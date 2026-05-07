import StoreKit
import Foundation
import Observation

@Observable
final class PurchaseManager {
    static let shared = PurchaseManager()

    var isProUser: Bool = false
    var monthlyProduct: Product?
    var yearlyProduct: Product?
    var isLoading = true

    private var transactionListener: Task<Void, Never>?

    private init() {
        transactionListener = listenForTransactions()
        Task { await loadProducts() }
    }

    func loadProducts() async {
        do {
            let storeProducts = try await Product.products(for: [
                "com.zzoutuo.SoundSplit.monthly",
                "com.zzoutuo.SoundSplit.yearly"
            ])
            for product in storeProducts {
                switch product.id {
                case "com.zzoutuo.SoundSplit.monthly":
                    monthlyProduct = product
                case "com.zzoutuo.SoundSplit.yearly":
                    yearlyProduct = product
                default:
                    break
                }
            }
            await updateSubscriptionStatus()
            isLoading = false
        } catch {
            isLoading = false
        }
    }

    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await updateSubscriptionStatus()
                await transaction.finish()
                return true
            case .userCancelled, .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            return false
        }
    }

    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await updateSubscriptionStatus()
        } catch {}
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                if let self {
                    do {
                        let transaction = try self.checkVerified(result)
                        await self.updateSubscriptionStatus()
                        await transaction.finish()
                    } catch {}
                }
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    private func updateSubscriptionStatus() async {
        var isPro = false
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                if transaction.productID == "com.zzoutuo.SoundSplit.monthly" ||
                    transaction.productID == "com.zzoutuo.SoundSplit.yearly" {
                    isPro = true
                }
            }
        }
        await MainActor.run {
            isProUser = isPro
        }
    }

    enum StoreError: Error {
        case failedVerification
    }
}
