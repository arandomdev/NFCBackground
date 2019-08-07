@interface NFTagInternal
@property (nonatomic,copy,readonly) NSData *tagID;
@end

@interface NFDriverWrapper : NSObject
- (bool)restartDiscovery;
- (void)closeSession;
- (unsigned long long)openSession;
- (bool)disconnectTag:(NFTagInternal *)tag tagRemovalDetect:(bool)arg2;
- (bool)connectTag:(id)arg1;
- (bool)queryTagNDEFCapability:(id)arg1 readable:(bool *)arg2 writable:(bool *)arg3 messageSize:(unsigned int *)arg4 maxMessageSize:(unsigned int *)arg5;
@end

@interface NFBackgroundTagReadingManager {
	NFDriverWrapper *_driverWrapper;
}
- (id)_readNDEFFromTag:(NFTagInternal *)tag;
- (void)handleDetectedTags:(id)tags;
- (void)resume;
@end

@interface NFCNDEFMessage : NSObject
@property (nonatomic,copy) NSArray *records;
-(id)initWithNFNdefMessage:(id)message;
@end

@interface NFCNDEFPayload : NSObject
@property (nonatomic,copy) NSData *type;                               //@synthesize type=_type - In the implementation block
@property (nonatomic,copy) NSData *identifier;                         //@synthesize identifier=_identifier - In the implementation block
@property (nonatomic,copy) NSData *payload;                            //@synthesize payload=_payload - In the implementation block
@end

@interface _NFHardwareManager
+ (id)sharedHardwareManager;
- (void)maybeStartNextSession;
@end
