// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import <ProtocolBuffers/ProtocolBuffers.h>

// @@protoc_insertion_point(imports)

@class AccountDelta;
@class AccountDeltaBuilder;
@class Transaction;
@class TransactionBuilder;



@interface ComBeanKeeperRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define Transaction_guid @"guid"
#define Transaction_date @"date"
#define Transaction_value @"value"
#define Transaction_kind @"kind"
#define Transaction_deleted @"deleted"
@interface Transaction : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasDeleted_:1;
  BOOL hasValue_:1;
  BOOL hasDate_:1;
  BOOL hasGuid_:1;
  BOOL hasKind_:1;
  BOOL deleted_:1;
  Float64 value;
  SInt64 date;
  NSString* guid;
  NSString* kind;
}
- (BOOL) hasGuid;
- (BOOL) hasDate;
- (BOOL) hasValue;
- (BOOL) hasKind;
- (BOOL) hasDeleted;
@property (readonly, strong) NSString* guid;
@property (readonly) SInt64 date;
@property (readonly) Float64 value;
@property (readonly, strong) NSString* kind;
- (BOOL) deleted;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (TransactionBuilder*) builder;
+ (TransactionBuilder*) builder;
+ (TransactionBuilder*) builderWithPrototype:(Transaction*) prototype;
- (TransactionBuilder*) toBuilder;

+ (Transaction*) parseFromData:(NSData*) data;
+ (Transaction*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Transaction*) parseFromInputStream:(NSInputStream*) input;
+ (Transaction*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Transaction*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Transaction*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface TransactionBuilder : PBGeneratedMessageBuilder {
@private
  Transaction* resultTransaction;
}

- (Transaction*) defaultInstance;

- (TransactionBuilder*) clear;
- (TransactionBuilder*) clone;

- (Transaction*) build;
- (Transaction*) buildPartial;

- (TransactionBuilder*) mergeFrom:(Transaction*) other;
- (TransactionBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (TransactionBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGuid;
- (NSString*) guid;
- (TransactionBuilder*) setGuid:(NSString*) value;
- (TransactionBuilder*) clearGuid;

- (BOOL) hasDate;
- (SInt64) date;
- (TransactionBuilder*) setDate:(SInt64) value;
- (TransactionBuilder*) clearDate;

- (BOOL) hasValue;
- (Float64) value;
- (TransactionBuilder*) setValue:(Float64) value;
- (TransactionBuilder*) clearValue;

- (BOOL) hasKind;
- (NSString*) kind;
- (TransactionBuilder*) setKind:(NSString*) value;
- (TransactionBuilder*) clearKind;

- (BOOL) hasDeleted;
- (BOOL) deleted;
- (TransactionBuilder*) setDeleted:(BOOL) value;
- (TransactionBuilder*) clearDeleted;
@end

#define AccountDelta_addedOrModified @"addedOrModified"
#define AccountDelta_serverTimestamp @"serverTimestamp"
@interface AccountDelta : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasServerTimestamp_:1;
  SInt64 serverTimestamp;
  NSMutableArray * addedOrModifiedArray;
}
- (BOOL) hasServerTimestamp;
@property (readonly, strong) NSArray * addedOrModified;
@property (readonly) SInt64 serverTimestamp;
- (Transaction*)addedOrModifiedAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (AccountDeltaBuilder*) builder;
+ (AccountDeltaBuilder*) builder;
+ (AccountDeltaBuilder*) builderWithPrototype:(AccountDelta*) prototype;
- (AccountDeltaBuilder*) toBuilder;

+ (AccountDelta*) parseFromData:(NSData*) data;
+ (AccountDelta*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (AccountDelta*) parseFromInputStream:(NSInputStream*) input;
+ (AccountDelta*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (AccountDelta*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (AccountDelta*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface AccountDeltaBuilder : PBGeneratedMessageBuilder {
@private
  AccountDelta* resultAccountDelta;
}

- (AccountDelta*) defaultInstance;

- (AccountDeltaBuilder*) clear;
- (AccountDeltaBuilder*) clone;

- (AccountDelta*) build;
- (AccountDelta*) buildPartial;

- (AccountDeltaBuilder*) mergeFrom:(AccountDelta*) other;
- (AccountDeltaBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (AccountDeltaBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSMutableArray *)addedOrModified;
- (Transaction*)addedOrModifiedAtIndex:(NSUInteger)index;
- (AccountDeltaBuilder *)addAddedOrModified:(Transaction*)value;
- (AccountDeltaBuilder *)setAddedOrModifiedArray:(NSArray *)array;
- (AccountDeltaBuilder *)clearAddedOrModified;

- (BOOL) hasServerTimestamp;
- (SInt64) serverTimestamp;
- (AccountDeltaBuilder*) setServerTimestamp:(SInt64) value;
- (AccountDeltaBuilder*) clearServerTimestamp;
@end


// @@protoc_insertion_point(global_scope)
