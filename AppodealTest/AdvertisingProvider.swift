//
//  AdvertisingProvider.swift
//  AppodealTest
//
//  Created by bowtie on 09.11.22.
//

import SwiftUI
import Combine
import Appodeal

final class AdvertisingProvider: NSObject, ObservableObject {
    // MARK: Types and definitions
    private typealias SynchroniseConsentCompletion = () -> ()
    
    /// Constants
    private struct AppodealConstants {
        static let key: String = "ac4b2540bd0186cf1950793234646a6820c9032d70531411"
        static let adTypes: AppodealAdType = [.banner, .interstitial, .rewardedVideo, .nativeAd]
        static let logLevel: APDLogLevel = .debug
        static let testMode: Bool = true
        static let defaultPlacement: String = "default"
        static let bannerPlacement: String = "bannerRestriction"
        static let rewardedPlacement: String = "rewardedRestriction"
        static let interstitialPlacement: String = "interstitialRestriction"
    }
    
    /// Native view SwiftUI interface
    struct Native: UIViewRepresentable {
        let ad: APDNativeAd
        
        func makeUIView(context: UIViewRepresentableContext<Native>) -> NativeView {
            guard
                let viewController = UIApplication.shared.rootViewController,
                let uiView = uiView(for: viewController)
            else {
                return NativeView()
            }
            return uiView
        }
        
        func updateUIView(_ uiView: NativeView, context: UIViewRepresentableContext<Native>) {}
        
        private func uiView(for viewController: UIViewController) -> NativeView? {
            return try? ad.getViewForPlacement(
                AdvertisingProvider.AppodealConstants.defaultPlacement,
                withRootViewController: viewController
            ) as? NativeView
        }
    }
    
    // MARK: Stored properties
    /// Singleton object of provider
    static let shared: AdvertisingProvider = AdvertisingProvider()
    
    private var synchroniseConsentCompletion: SynchroniseConsentCompletion?
    
    // MARK: Published properties
    @Published var isAdInitialised     = false
    @Published var isBannerReady       = false
    @Published var isInterstitialReady = false
    @Published var isRewardedReady     = false
    
    @Published var bannerCounter       = 0
    @Published var rewardedCounter     = 0
    
    // MARK: Public methods
    func initialize() {
        /// Custom settings
        // Appodeal.setFramework(.native, version: "1.0.0")
        // Appodeal.setTriggerPrecacheCallbacks(true)
        // Appodeal.setLocationTracking(true)
        Appodeal.setLogLevel(AppodealConstants.logLevel)
        
        /// Test Mode
        Appodeal.setTestingEnabled(AppodealConstants.testMode)
        
        /// User Data
        // Appodeal.setUserId("userID")
        
        // Disable autocache for banner
        // we will cache it manually
        Appodeal.setAutocache(false, types: .nativeAd)
        
        // Set delegates
        Appodeal.setBannerDelegate(self)
        Appodeal.setInterstitialDelegate(self)
        Appodeal.setRewardedVideoDelegate(self)
        Appodeal.setInitializationDelegate(self)
        
        Appodeal.setBannerAnimationEnabled(true)

        // Initialise Appodeal SDK
        Appodeal.initialize(withApiKey: AppodealConstants.key, types: AppodealConstants.adTypes)
    }
    
    func presentBanner() {
        defer { isBannerReady = false }
        // Check availability of banner
        guard
            Appodeal.canShow(.banner, forPlacement: AppodealConstants.bannerPlacement),
            let viewController = UIApplication.shared.rootViewController
        else { return }
        
        Appodeal.showAd(
            .bannerTop,
            forPlacement: AppodealConstants.bannerPlacement,
            rootViewController: viewController
        )
    }
    
    func hideTopBanner() {
        Appodeal.hideBanner()
    }
    
    func presentInterstitial() {
        defer { isInterstitialReady = false }
        // Check availability of interstial
        guard
            Appodeal.canShow(.interstitial, forPlacement: AppodealConstants.interstitialPlacement),
            let viewController = UIApplication.shared.rootViewController
        else { return }
        
        Appodeal.showAd(
            .interstitial,
            forPlacement: AppodealConstants.interstitialPlacement,
            rootViewController: viewController
        )
    }
    
    func presentRewarded() {
        defer { isRewardedReady = false }
        // Check availability of rewarded video
        guard
            Appodeal.canShow(.rewardedVideo, forPlacement: AppodealConstants.rewardedPlacement),
            let viewController = UIApplication.shared.rootViewController
        else { return }
        
        Appodeal.showAd(
            .rewardedVideo,
            forPlacement: AppodealConstants.rewardedPlacement,
            rootViewController: viewController
        )
    }
}

// MARK: Protocols implementations
extension AdvertisingProvider: AppodealInitializationDelegate {
    func appodealSDKDidInitialize() {
        //here you can do any additional actions
        self.isAdInitialised = true
    }
}

extension AdvertisingProvider: AppodealBannerDelegate {
    func bannerDidLoadAdIsPrecache(_ precache: Bool) {
        isBannerReady = true
    }
    
    func bannerDidFailToLoadAd() {
        isBannerReady = false
    }
    
    func bannerDidExpired() {
        isBannerReady = false
    }
}

extension AdvertisingProvider: AppodealInterstitialDelegate {
    func interstitialDidLoadAdIsPrecache(_ precache: Bool) {
        isInterstitialReady = true
    }
    
    func interstitialDidFailToLoadAd() {
        isInterstitialReady = false
    }
    
    func interstitialDidExpired() {
        isInterstitialReady = false
    }
}


extension AdvertisingProvider: AppodealRewardedVideoDelegate {
    func rewardedVideoDidLoadAdIsPrecache(_ precache: Bool) {
        isRewardedReady = true
    }
    
    func rewardedVideoDidFailToLoadAd() {
        isRewardedReady = false
    }
    
    func rewardedVideoDidExpired() {
        isRewardedReady = false
    }
}
