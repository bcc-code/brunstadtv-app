// Autogenerated from Pigeon (v3.2.7), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CastConnectionState) {
  CastConnectionState_ = 0,
  CastConnectionStateNoDevicesAvailable = 1,
  CastConnectionStateNotConnected = 2,
  CastConnectionStateConnecting = 3,
  CastConnectionStateConnected = 4,
};

@class MediaItem;
@class MediaMetadata;
@class ChromecastState;

@interface MediaItem : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithUrl:(NSString *)url
    mimeType:(nullable NSString *)mimeType
    metadata:(nullable MediaMetadata *)metadata
    isLive:(nullable NSNumber *)isLive
    playbackStartPositionMs:(nullable NSNumber *)playbackStartPositionMs;
@property(nonatomic, copy) NSString * url;
@property(nonatomic, copy, nullable) NSString * mimeType;
@property(nonatomic, strong, nullable) MediaMetadata * metadata;
@property(nonatomic, strong, nullable) NSNumber * isLive;
@property(nonatomic, strong, nullable) NSNumber * playbackStartPositionMs;
@end

@interface MediaMetadata : NSObject
+ (instancetype)makeWithArtworkUri:(nullable NSString *)artworkUri
    title:(nullable NSString *)title
    artist:(nullable NSString *)artist
    episodeId:(nullable NSString *)episodeId;
@property(nonatomic, copy, nullable) NSString * artworkUri;
@property(nonatomic, copy, nullable) NSString * title;
@property(nonatomic, copy, nullable) NSString * artist;
@property(nonatomic, copy, nullable) NSString * episodeId;
@end

@interface ChromecastState : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithConnectionState:(CastConnectionState)connectionState;
@property(nonatomic, assign) CastConnectionState connectionState;
@end

/// The codec used by PlaybackPlatformPigeon.
NSObject<FlutterMessageCodec> *PlaybackPlatformPigeonGetCodec(void);

@protocol PlaybackPlatformPigeon
- (void)newPlayer:(nullable NSString *)url completion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)queueMediaItem:(NSString *)playerId mediaItem:(MediaItem *)mediaItem completion:(void(^)(FlutterError *_Nullable))completion;
- (void)replaceCurrentMediaItem:(NSString *)playerId mediaItem:(MediaItem *)mediaItem playbackPositionFromPrimary:(nullable NSNumber *)playbackPositionFromPrimary completion:(void(^)(FlutterError *_Nullable))completion;
- (void)setPrimary:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)play:(NSString *)playerId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)pause:(NSString *)playerId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)stop:(NSString *)playerId reset:(NSNumber *)reset error:(FlutterError *_Nullable *_Nonnull)error;
- (void)getChromecastState:(void(^)(ChromecastState *_Nullable, FlutterError *_Nullable))completion;
@end

extern void PlaybackPlatformPigeonSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<PlaybackPlatformPigeon> *_Nullable api);

NS_ASSUME_NONNULL_END
