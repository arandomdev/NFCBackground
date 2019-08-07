#import "headers.h"
#import "NSData+Conversion.h"

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

%hook NFDriverWrapper
- (bool)disconnectTag:(NFTagInternal *)tag tagRemovalDetect:(bool)arg2 {
	return %orig(tag, arg2);
}
%end

%hook NFBackgroundTagReadingManager
- (id)initWithQueue:(id)arg1 driverWrapper:(id)arg2 lpcdHWSupport:(unsigned char)arg3 {
	%log;
	return %orig(arg1, arg2, 1);
}

- (void)handleDetectedTags:(id)tagCollection {
	NSArray *tags = [tagCollection allObjects];
	HBLogDebug(@"=== Detected tags: %lu ===", tags.count);
	NFDriverWrapper *driver = MSHookIvar<NFDriverWrapper *>(self, "_driverWrapper");

	for(NFTagInternal *tag in tags) {
		HBLogDebug(@"tag: %@", tag);
		
		[self _readNDEFFromTag:tag];
		//[driver disconnectTag:tag tagRemovalDetect:0];
	}

	[NSThread sleepForTimeInterval:1.0];
	[driver restartDiscovery];
	HBLogDebug(@"exit");
}
%end

%ctor {
	HBLogDebug(@"Hooked into nfcd daemon");
	dlopen("/Library/MobileSubstrate/DynamicLibraries/NFCWriterDaemon.dylib", RTLD_LAZY);
	%init;
}