//
//  ContentView.swift
//  AppodealTest
//
//  Created by bowtie on 09.11.22.
//

import SwiftUI
import Appodeal

struct ContentView: View {
    // MARK: - PROPERTIES
    @ObservedObject var ad = AdvertisingProvider.shared
    
    @State var isInterstitialTapped: Bool = false
    @State var isRewardedTapped: Bool = false
    @State var isNativeTapped: Bool = false
    
    private func setTimerForInterstitial() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: { _ in
            isInterstitialTapped = false
        })
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 15) {
                    Spacer()
                    HStack(spacing: 15) {
                        AdButtonView(title: "Banners") {
                            if ad.isBannerReady {
                                ad.isBannerShown = true
                            }
                        }
                        .opacity(ad.isBannerReady ? 1 : 0.8)
                        .disabled(!ad.isBannerReady)
                        
                        AdButtonView(title: "Interstitials") {
                            if ad.isInterstitialReady {
                                ad.presentInterstitial()
                                isInterstitialTapped = true
                                ad.isBannerShown = false
                                setTimerForInterstitial()
                            }
                        }
                        .opacity((ad.isInterstitialReady && !isInterstitialTapped) ? 1 : 0.8)
                        .disabled(!ad.isInterstitialReady || isInterstitialTapped)
                    } // HSTACK
                    
                    HStack(spacing: 15) {
                        AdButtonView(title: "Rewarded Video") {
                            if ad.isRewardedReady {
                                ad.presentRewarded()
                                isRewardedTapped = true
                                ad.isBannerShown = false
                            }
                        }
                        .opacity(ad.isRewardedReady ? 1 : 0.9)
                        .disabled(!ad.isRewardedReady)
                        
                        NavigationLink {
                            NewsFeed()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.black)
                                    .frame(height: 80)
                                
                                Text("Native")
                                    .foregroundColor(.white)
                            }
                            .opacity(ad.isAdInitialised ? 1 : 0.8)
                            .disabled(!ad.isAdInitialised)
                        }
                        .onTapGesture {
                            ad.isBannerShown = false
                        }
                    } // HSTACK
                    
                    Spacer()
                } // VSTACK
                .padding(.horizontal)
                
                if ad.isBannerReady && ad.isBannerShown {
                    AdvertisingProvider.Banner()
                        .frame(
                            minWidth: 320,
                            idealWidth: .infinity,
                            minHeight: ad.bannerHeight,
                            maxHeight: ad.bannerHeight
                        )
                }
            } // ZSTACK
        } // NAV
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
