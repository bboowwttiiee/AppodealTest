platform :ios, '10.0'

source 'https://github.com/appodeal/CocoaPods.git'
source 'https://cdn.cocoapods.org/'

install! 'cocoapods', 
  :deterministic_uuids => false,
  :warn_for_multiple_pod_sources => false

use_frameworks!

def appodeal
  pod 'APDAdColonyAdapter', '3.0.1.1'
  pod 'BDMAdColonyAdapter', '~> 1.9.5'
  pod 'APDAdjustAdapter', '3.0.1.1'
  pod 'APDAppLovinAdapter', '3.0.1.1'
  pod 'APDAppsFlyerAdapter', '3.0.1.1'
  pod 'APDBidMachineAdapter', '3.0.1.1' # Required
  pod 'BDMCriteoAdapter', '~> 1.9.5'
  pod 'Ads-Global', :configuration => 'Release'
  pod 'OneKit-Pangle', '1.1.21-pangle', :configuration => 'Release'
  pod 'RangersAPM-Pangle', '2.3.2-pangle', :configuration => 'Release'
  pod 'BDMAmazonAdapter', '~> 1.9.5'
  pod 'BDMSmaatoAdapter', '~> 1.9.5'
  pod 'BDMNotsyAdapter', '~> 1.9.5'
  pod 'BDMTapjoyAdapter', '~> 1.9.5'
  pod 'APDFirebaseAdapter', '3.0.1.1'
  pod 'APDGoogleAdMobAdapter', '3.0.1.1'
  pod 'APDIABAdapter', '3.0.1.1' # Required
  pod 'BDMIABAdapter', '~> 1.9.5'
#  pod 'APDIronSourceAdapter', '3.0.1.1'
  pod 'APDIronSourceAdapter', '3.0.1.1', :configuration => 'Release'
  pod 'IronSourceSDK', :configuration => 'Release'
  pod 'APDFacebookAdapter', '3.0.1.1'
  pod 'APDMetaAudienceNetworkAdapter', '3.0.1.1'
  pod 'BDMMetaAudienceAdapter', '~> 1.9.5'
  pod 'APDMyTargetAdapter', '3.0.1.1'
  pod 'BDMMyTargetAdapter', '~> 1.9.5'
  pod 'APDStackAnalyticsAdapter', '3.0.1.1' # Required
  pod 'APDUnityAdapter', '3.0.1.1'
  pod 'APDVungleAdapter', '3.0.1.1'
  pod 'BDMVungleAdapter', '~> 1.9.5'
  pod 'APDYandexAdapter', '3.0.1.1'
end

target 'AppodealTest' do
  project 'AppodealTest.xcodeproj'
  appodeal
end
