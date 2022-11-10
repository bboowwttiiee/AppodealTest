//
//  NativeView.swift
//  AppodealTest
//
//  Created by bowtie on 09.11.22.
//

import Appodeal
import SwiftUI

/// UIView is required for Appodeal native ad
/// to correctly track impressions and user
/// interactions
final class NativeView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var callToAction: UILabel!

    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var adChoices: UIView!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        self.icon.layer.cornerRadius = 8.0
        self.icon.layer.masksToBounds = true

        self.callToAction.layer.cornerRadius = 8.0
        self.callToAction.layer.masksToBounds = true
    }
}


extension NativeView : APDNativeAdView {
    func titleLabel() -> UILabel {
        return title
    }
    
    func callToActionLabel() -> UILabel {
        return callToAction
    }
    
    func descriptionLabel() -> UILabel {
        return descr
    }
    
    func iconView() -> UIImageView {
        return icon
    }
    
    func mediaContainerView() -> UIView {
        return mediaContainer
    }
    
    func adChoicesView() -> UIView {
        return adChoices
    }
    
    static func nib() -> UINib {
        return UINib.init(nibName: "Native", bundle: Bundle.main)
    }
}


extension APDNativeAd {
    var view: AnyView {
        AnyView(
            AdvertisingProvider.Native(ad: self)
                .shadow(color: .red, radius: 8)
                .frame(height: 400)
        )
    }
}
