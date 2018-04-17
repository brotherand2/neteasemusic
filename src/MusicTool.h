//
//  MusicTool.h
//  FrameworkTest
//
//  Created by zyh on 2018/4/9.
//  Copyright © 2018年 zyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "header.h"
@interface MusicTool : NSObject
+ (instancetype)sharedTool;
-(void)getVipPlayUrl:(NSArray*)songs;
@property(nonatomic,strong) NSTimer *refreshTimer;
@property(nonatomic,strong) NSMutableArray *downloadSongs;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) BOOL downloadVip;
-(NMSettingIconAndSwitchCell*)createSettingPlayUrlCell:(NMSettingViewController*)vc;
@end
