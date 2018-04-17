# neteasemusic
网易云逆向,下载vip音乐,tweak
代码是在https://github.com/sunweiliang/NeteaseMusicCrack 基础上修改的,使用tweak

增加设置UI,打开开关后,每次打开歌单,会对VIP的音乐获取播放地址,过几分钟后点击下载就能下载所有VIP音乐,不用播一次下载一次
调用堆栈:
下载音乐

[NMPlayViewController downloadButtonClicked:]
[NMPlayUIController downloadSong:
[NMNewDownloadManager singleDownloadSong:collection:completeBlock:
[NMCopyRightChecker checkCopyright:action:needAlert:]
[NMCopyRightChecker checkAndAlertCopyrightIssue:action:needAlert:


播放音乐


[NMPlayListDetailViewController tableView:didSelectRowAtIndexPath:]
[NMPlayListDetailViewController processTableViewCellSelectedInDefaultOrder:indexPath:]
[NMPlayerManager playSongs:atIndex:collection:]
[NMPlayerManager playSongs:atIndex:collection:showUI:]
[NMPlayerManager playSongs:atIndex:collection:showUI:isCarPlay:]
[NMSongFilter getFilteredCopyrightAvailableSongsForPlay:collection:callbackBlock:]
[NMSongFilter getFilteredCopyrightAvailableSongs:collection:callbackBlock:action:]
sub_10079C310
[NMPlayerManager _loadSongs:atIndex:collection:play:showUI:saveHistory:loadFromHistory:isCarPlay
[NMSonglistPlayerController setupWithSongs:index:complete:]
[NMSongFixer fixSongs:playerController:complete:]

[NMPlayer createStreamer:]
[NMPlayer providerForSong:]
[NMPlayer fixSongInfoForSong:completeBlock:]
[NMSongUrlInfoFixer fixSongUrlInfo:type:completeBlock:]
[NMSongUrlInfoFixer _fixSongUrlInfo:type:completeBlock:]
[NMSongUrlInfoFixer _fixSongPlayUrlInfo:bitrate:completeBlock:retryCount:]
[NMSongUrlInfoRequest initPlayUrlWithSongId 


下载全部歌曲

[NMContentOperBar downloadButtonClicked]
[ NMPlayListDetailViewController downloadButtonClicked

获取播放地址

[NMSongUrlInfoFixer _fixSongPlayUrlInfo: bitrate:192000 completeBlock:nil retryCount:3]

![image](https://github.com/brotherand2/neteasemusic/blob/master/a.jpg)
