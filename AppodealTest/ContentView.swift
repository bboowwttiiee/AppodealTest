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
    
    private func setTimerForInterstitial() {
        isInterstitialTapped = true
        
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
                                ad.presentBanner()
                            }
                            ad.bannerCounter += 1
                        }
                        .opacity((ad.isBannerReady && ad.bannerCounter < 5) ? 1 : 0.8)
                        .disabled(!ad.isBannerReady || ad.bannerCounter >= 5)
                        
                        AdButtonView(title: "Interstitials") {
                            if ad.isInterstitialReady {
                                setTimerForInterstitial()
                                ad.presentInterstitial()
                            }
                            
                            ad.hideTopBanner()
                        }
                        .opacity((ad.isInterstitialReady && !isInterstitialTapped) ? 1 : 0.8)
                        .disabled(!ad.isInterstitialReady || isInterstitialTapped)
                    } // HSTACK
                    
                    HStack(spacing: 15) {
                        AdButtonView(title: "Rewarded Video") {
                            if ad.isRewardedReady {
                                ad.presentRewarded()
                            }
                            ad.rewardedCounter += 1
                            
                            ad.hideTopBanner()
                        }
                        .opacity((ad.isRewardedReady && ad.rewardedCounter < 3) ? 1 : 0.8)
                        .disabled(!ad.isRewardedReady || ad.rewardedCounter >= 3)
                        
                        NavigationLink {
                            NewsFeed()
                                .onAppear {
                                    ad.hideTopBanner()
                                }
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
                            ad.hideTopBanner()
                        }
                    } // HSTACK
                    
                    Spacer()
                } // VSTACK
                .padding(.horizontal)
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
