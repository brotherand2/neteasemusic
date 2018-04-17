#import "header.h"
#import "MusicTool.h"
%hook NMSong


-(bool)canDownloadMusic
{
    return 1;
}
- (void)setPlayUrlInfo:(id)arg1
{

    if(arg1==nil)
        return;
    %orig(arg1);
    NSLog(@"%@,%s,%@",[self name],__func__,arg1);
}

- (void)setDownloadUrlInfo:(id)arg1
{
if(arg1==nil)
return;
if([arg1 url]==nil)
arg1=[self playUrlInfo];
%orig(arg1);
NSLog(@"%@,%s,%@,self=%@",[self name],__func__,arg1,self);
}

%end


%hook NMPlayListDetailViewController
- (void)viewDidAppear:(_Bool)arg1
{
    %orig(arg1);
    if([MusicTool sharedTool].downloadVip)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //NSLog(@"song=:%@",[self songArray]);
        [[MusicTool sharedTool] getVipPlayUrl:[self songArray]];
        });
    }


}
%end
%hook NMAdBackgroundView
- (_Bool)showAd:(_Bool)arg1
{
NSLog(@"去掉了首页广告的显示%s",__func__);
return 0;
}
- (_Bool)showAdView:(_Bool)arg1
{
NSLog(@"%s",__func__);
return 0;
}

%end
%hook  NMAppDelegate
- (void)uploadIDFA
{
NSLog(@"%s",__func__);
}
- (void)checkPushNotification
{
NSLog(@"%s",__func__);
}
- (void)showAdvertisementIfNeeded
{
NSLog(@"%s",__func__);
}
- (_Bool)checkUpdate:(id)arg1
{
NSLog(@"%s",__func__);
    return 0;
}
- (void)buyVipDidShow:(id)arg1
{
NSLog(@"%s",__func__);
}
- (void)checkVersion:(_Bool)arg1
{
NSLog(@"%s",__func__);
}
- (void)adBackgroundView:(id)arg1 tappedWithUrl:(id)arg2
{
NSLog(@"%s",__func__);
}


- (void)adBackgroundViewSkipAd:(id)arg1
{
NSLog(@"%s",__func__);
}
%end
%hook NMSettingViewController
- (long long)numberOfRowsInSection:(long long)arg1
{
    if(arg1==3)
        return 3;
    else
       return %orig(arg1);
}
- (id)cellForRowAtIndexPath:(NSIndexPath*)arg1
{
    if(arg1.section==3&&arg1.row==2)
    {
        return [[MusicTool sharedTool] createSettingPlayUrlCell:self];
    }
    return %orig(arg1);
}
%end


%hook NSBundle
-(NSString *)bundleIdentifier
{
    NSString *str=%orig;

    NSArray *syms = [NSThread  callStackSymbols];

    if ([syms count] > 1)
    {
        if( [[syms objectAtIndex:1] containsString:@"neteasemusic"]||[[syms objectAtIndex:1] containsString:@"robot"])
        {
            return @"com.netease.cloudmusic";
        }

    }
    return str;
}
-(NSDictionary*)infoDictionary
{
    NSDictionary*info=%orig;
    NSArray *syms = [NSThread  callStackSymbols];

    if ([syms count] > 1)
    {
        if( [[syms objectAtIndex:1] containsString:@"neteasemusic"]||[[syms objectAtIndex:1] containsString:@"robot"])
        {
            NSMutableDictionary *data=[info mutableCopy];
            [data setObject:@"com.netease.cloudmusic" forKeyedSubscript:@"CFBundleIdentifier"];
            return data;
        }

    }
    return info;
}
%end

