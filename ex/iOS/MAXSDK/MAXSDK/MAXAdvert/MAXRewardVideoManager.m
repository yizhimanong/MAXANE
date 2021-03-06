//
//  MAXRewardVideoManager.m
//  MAXSDK
//
//  Created by 洋吴 on 2020/9/23.
//  Copyright © 2020 洋吴. All rights reserved.
//

#import "MAXRewardVideoManager.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import "MAXAdvertANEUtils.h"

@interface MAXRewardVideoManager ()<MARewardedAdDelegate>

@property (nonatomic, strong) MARewardedAd *rewardedAd;

@end

@implementation MAXRewardVideoManager

+ (MAXRewardVideoManager *)shareManager{
    
    static MAXRewardVideoManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[MAXRewardVideoManager alloc]init];
    });
    return shareManager;
}

- (void) loadAdWithUnitId:(NSString *)unitId{
    
    self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:unitId];
    self.rewardedAd.delegate = self;
    [self.rewardedAd loadAd];
}

- (void) setExtraParameterForKey:(NSString *)key value:(nullable NSString *)value{
    
    if (self.rewardedAd) {
        [self.rewardedAd setExtraParameterForKey:key value:value];
    }
}

- (BOOL) isReady{
    
    return [self.rewardedAd isReady];
}

- (void) showAd{
    
    [self.rewardedAd showAd];
}

- (void) showAdForPlacement:(NSString *)placement{
    
    [self.rewardedAd showAdForPlacement:placement];
}

- (void)didClickAd:(nonnull MAAd *)ad {
    
    if (ad.format == MAAdFormat.rewarded) {
     
        MAXAdvertSendANEMessage(RewardVideoClick, RewardVideoClickCode, @"", @"");
    }
}

- (void)didDisplayAd:(nonnull MAAd *)ad {
    
    if (ad.format == MAAdFormat.rewarded) {
     
        MAXAdvertSendANEMessage(RewardVideoDisplay,RewardVideoDisplayCode,@"",@"");
    }
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withErrorCode:(NSInteger)errorCode {
    
    if (ad.format == MAAdFormat.rewarded) {
        
        MAXAdvertSendANEMessage(RewardVideoFailToDisplay,RewardVideoFailToDisplayCode, @"errorCode", [NSString stringWithFormat:@"%ld",(long)errorCode]);
    }
}

- (void)didFailToLoadAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withErrorCode:(NSInteger)errorCode {
    
    MAXAdvertSendANEMessage(RewardVideoFailToLoad, RewardVideoFailToDisplayCode, @"errorCode", [NSString stringWithFormat:@"%ld",(long)errorCode]);
}

- (void)didHideAd:(nonnull MAAd *)ad {
    
    if (ad.format == MAAdFormat.rewarded) {
        
        MAXAdvertSendANEMessage(RewardVideoHide, RewardVideoHideCode, @"", @"");
    }
}

- (void)didLoadAd:(nonnull MAAd *)ad {
    
    if (ad.format == MAAdFormat.rewarded) {
        
        MAXAdvertSendANEMessage(RewardVideoDidLoad, RewardVideoDidLoadCode, @"", @"");
    }
}

- (void)didCompleteRewardedVideoForAd:(nonnull MAAd *)ad {
    
    MAXAdvertSendANEMessage(RewardVideoDidComplete, RewardVideoDidCompleteCode, @"", @"");
}

- (void)didRewardUserForAd:(nonnull MAAd *)ad withReward:(nonnull MAReward *)reward {
    
    MAXAdvertSendANEMessage(RewardVideoDidReward, RewardVideoDidRewardCode, @"", @"");
}

- (void)didStartRewardedVideoForAd:(nonnull MAAd *)ad {
    
    MAXAdvertSendANEMessage(RewardVideoDidStart, RewardVideoDidStartCode, @"", @"");
}

@end
