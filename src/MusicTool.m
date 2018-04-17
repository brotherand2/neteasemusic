//
//  MusicTool.m
//  FrameworkTest
//
//  Created by zyh on 2018/4/9.
//  Copyright © 2018年 zyh. All rights reserved.
//

#import "MusicTool.h"
#import <objc/runtime.h>
#include <mach-o/dyld.h>
#include <mach/mach.h>
 

@implementation MusicTool
+ (instancetype)sharedTool
{
    
    static MusicTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[MusicTool alloc] init];
        tool.downloadVip=[[NSUserDefaults standardUserDefaults] boolForKey:@"downloadVip"];
    });
    return tool;
}
-(void)setDownloadVip:(BOOL)downloadVip
{
    _downloadVip=downloadVip;
    [[NSUserDefaults standardUserDefaults] setBool:downloadVip forKey:@"downloadVip"];
    //[self.userDefaults setInteger:maxCommendNum forKey:@"maxCommendNum"];
}

-(void)getVipPlayUrl:(NSArray*)songs
{
    _downloadSongs=[NSMutableArray array];
    _index=0;
    for(NSInteger i=0;i<songs.count;i++)
    {
        NMSong *song=songs[i];
        if((song.isFeeSong||song.isFeeSongPaid)&&song.playUrlInfo==nil)
        {
            [_downloadSongs addObject:song];
            NSLog(@"发现收费歌曲:%@",song.name);
        }
    }
    if(_downloadSongs.count)
        [self addRefreshTimer];
    else
        NSLog(@"没有发现收费歌曲");
    [self nextPlayUrl];
}

-(NMSettingIconAndSwitchCell*)createSettingPlayUrlCell:(NMSettingViewController*)vc
{
    
    NMSettingIconAndSwitchCell *cell=[vc dequeueReusableCellWithIdentifier:@"PlayUrl"];
    if(cell==nil)
    {
        cell=[[NSClassFromString(@"NMSettingIconAndSwitchCell") alloc] initWithStyle:0 reuseIdentifier:@"PlayUrl"];
        [cell setTitle:@"下载vip音乐" icon:[UIImage imageNamed:@"cm2_set_logo.png"]];
        [cell setDelegate:self];
        [cell setOn:self.downloadVip animated:YES];
    }
    return cell;
}
- (void)settingSwitchableCell:(NMSettingIconAndSwitchCell *)arg1 switchValueChanged:(_Bool)arg2
{
    [self setDownloadVip:arg2];
     NSLog(@"%s",__func__);
}

-(void)addRefreshTimer
{
    [self invalidateRefreshTimer];
    
    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPlayUrl) userInfo:nil repeats:YES];
}

-(void)invalidateRefreshTimer
{
    [_refreshTimer invalidate];
    _refreshTimer  = nil;
}
-(void)nextPlayUrl
{
    if(_index>=_downloadSongs.count)
    {
        [self invalidateRefreshTimer];
        for(NSInteger i=0;i<_downloadSongs.count;i++)
        {
            NMSong *song=_downloadSongs[i];
            NSLog(@"收费歌曲播放地址是:%@",song.playUrlInfo.url);
        }
         return;
    }
     NSLog(@"%s 下一首",__func__);
    NMSongUrlInfoFixer *fixer=[NSClassFromString(@"NMSongUrlInfoFixer") _sharedInstance];
    [fixer _fixSongPlayUrlInfo:_downloadSongs[_index] bitrate:192000 completeBlock:nil retryCount:2];
    _index++;
}
@end
