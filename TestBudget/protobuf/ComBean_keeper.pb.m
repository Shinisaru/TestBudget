// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ComBean_keeper.pb.h"
// @@protoc_insertion_point(imports)

@implementation ComBeanKeeperRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [ComBeanKeeperRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface Transaction ()
@property (strong) NSString* guid;
@property SInt64 date;
@property Float64 value;
@property (strong) NSString* kind;
@property BOOL deleted;
@end

@implementation Transaction

- (BOOL) hasGuid {
  return !!hasGuid_;
}
- (void) setHasGuid:(BOOL) _value_ {
  hasGuid_ = !!_value_;
}
@synthesize guid;
- (BOOL) hasDate {
  return !!hasDate_;
}
- (void) setHasDate:(BOOL) _value_ {
  hasDate_ = !!_value_;
}
@synthesize date;
- (BOOL) hasValue {
  return !!hasValue_;
}
- (void) setHasValue:(BOOL) _value_ {
  hasValue_ = !!_value_;
}
@synthesize value;
- (BOOL) hasKind {
  return !!hasKind_;
}
- (void) setHasKind:(BOOL) _value_ {
  hasKind_ = !!_value_;
}
@synthesize kind;
- (BOOL) hasDeleted {
  return !!hasDeleted_;
}
- (void) setHasDeleted:(BOOL) _value_ {
  hasDeleted_ = !!_value_;
}
- (BOOL) deleted {
  return !!deleted_;
}
- (void) setDeleted:(BOOL) _value_ {
  deleted_ = !!_value_;
}
- (instancetype) init {
  if ((self = [super init])) {
    self.guid = @"";
    self.date = 0L;
    self.value = 0;
    self.kind = @"";
    self.deleted = NO;
  }
  return self;
}
static Transaction* defaultTransactionInstance = nil;
+ (void) initialize {
  if (self == [Transaction class]) {
    defaultTransactionInstance = [[Transaction alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultTransactionInstance;
}
- (instancetype) defaultInstance {
  return defaultTransactionInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasGuid) {
    [output writeString:1 value:self.guid];
  }
  if (self.hasDate) {
    [output writeInt64:2 value:self.date];
  }
  if (self.hasValue) {
    [output writeDouble:3 value:self.value];
  }
  if (self.hasKind) {
    [output writeString:4 value:self.kind];
  }
  if (self.hasDeleted) {
    [output writeBool:5 value:self.deleted];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasGuid) {
    size_ += computeStringSize(1, self.guid);
  }
  if (self.hasDate) {
    size_ += computeInt64Size(2, self.date);
  }
  if (self.hasValue) {
    size_ += computeDoubleSize(3, self.value);
  }
  if (self.hasKind) {
    size_ += computeStringSize(4, self.kind);
  }
  if (self.hasDeleted) {
    size_ += computeBoolSize(5, self.deleted);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (Transaction*) parseFromData:(NSData*) data {
  return (Transaction*)[[[Transaction builder] mergeFromData:data] build];
}
+ (Transaction*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Transaction*)[[[Transaction builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (Transaction*) parseFromInputStream:(NSInputStream*) input {
  return (Transaction*)[[[Transaction builder] mergeFromInputStream:input] build];
}
+ (Transaction*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Transaction*)[[[Transaction builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (Transaction*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (Transaction*)[[[Transaction builder] mergeFromCodedInputStream:input] build];
}
+ (Transaction*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Transaction*)[[[Transaction builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (TransactionBuilder*) builder {
  return [[TransactionBuilder alloc] init];
}
+ (TransactionBuilder*) builderWithPrototype:(Transaction*) prototype {
  return [[Transaction builder] mergeFrom:prototype];
}
- (TransactionBuilder*) builder {
  return [Transaction builder];
}
- (TransactionBuilder*) toBuilder {
  return [Transaction builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasGuid) {
    [output appendFormat:@"%@%@: %@\n", indent, @"guid", self.guid];
  }
  if (self.hasDate) {
    [output appendFormat:@"%@%@: %@\n", indent, @"date", [NSNumber numberWithLongLong:self.date]];
  }
  if (self.hasValue) {
    [output appendFormat:@"%@%@: %@\n", indent, @"value", [NSNumber numberWithDouble:self.value]];
  }
  if (self.hasKind) {
    [output appendFormat:@"%@%@: %@\n", indent, @"kind", self.kind];
  }
  if (self.hasDeleted) {
    [output appendFormat:@"%@%@: %@\n", indent, @"deleted", [NSNumber numberWithBool:self.deleted]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (void) storeInDictionary:(NSMutableDictionary *)dictionary {
  if (self.hasGuid) {
    [dictionary setObject: self.guid forKey: @"guid"];
  }
  if (self.hasDate) {
    [dictionary setObject: [NSNumber numberWithLongLong:self.date] forKey: @"date"];
  }
  if (self.hasValue) {
    [dictionary setObject: [NSNumber numberWithDouble:self.value] forKey: @"value"];
  }
  if (self.hasKind) {
    [dictionary setObject: self.kind forKey: @"kind"];
  }
  if (self.hasDeleted) {
    [dictionary setObject: [NSNumber numberWithBool:self.deleted] forKey: @"deleted"];
  }
  [self.unknownFields storeInDictionary:dictionary];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[Transaction class]]) {
    return NO;
  }
  Transaction *otherMessage = other;
  return
      self.hasGuid == otherMessage.hasGuid &&
      (!self.hasGuid || [self.guid isEqual:otherMessage.guid]) &&
      self.hasDate == otherMessage.hasDate &&
      (!self.hasDate || self.date == otherMessage.date) &&
      self.hasValue == otherMessage.hasValue &&
      (!self.hasValue || self.value == otherMessage.value) &&
      self.hasKind == otherMessage.hasKind &&
      (!self.hasKind || [self.kind isEqual:otherMessage.kind]) &&
      self.hasDeleted == otherMessage.hasDeleted &&
      (!self.hasDeleted || self.deleted == otherMessage.deleted) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasGuid) {
    hashCode = hashCode * 31 + [self.guid hash];
  }
  if (self.hasDate) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.date] hash];
  }
  if (self.hasValue) {
    hashCode = hashCode * 31 + [[NSNumber numberWithDouble:self.value] hash];
  }
  if (self.hasKind) {
    hashCode = hashCode * 31 + [self.kind hash];
  }
  if (self.hasDeleted) {
    hashCode = hashCode * 31 + [[NSNumber numberWithBool:self.deleted] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface TransactionBuilder()
@property (strong) Transaction* resultTransaction;
@end

@implementation TransactionBuilder
@synthesize resultTransaction;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultTransaction = [[Transaction alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultTransaction;
}
- (TransactionBuilder*) clear {
  self.resultTransaction = [[Transaction alloc] init];
  return self;
}
- (TransactionBuilder*) clone {
  return [Transaction builderWithPrototype:resultTransaction];
}
- (Transaction*) defaultInstance {
  return [Transaction defaultInstance];
}
- (Transaction*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (Transaction*) buildPartial {
  Transaction* returnMe = resultTransaction;
  self.resultTransaction = nil;
  return returnMe;
}
- (TransactionBuilder*) mergeFrom:(Transaction*) other {
  if (other == [Transaction defaultInstance]) {
    return self;
  }
  if (other.hasGuid) {
    [self setGuid:other.guid];
  }
  if (other.hasDate) {
    [self setDate:other.date];
  }
  if (other.hasValue) {
    [self setValue:other.value];
  }
  if (other.hasKind) {
    [self setKind:other.kind];
  }
  if (other.hasDeleted) {
    [self setDeleted:other.deleted];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (TransactionBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (TransactionBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSetBuilder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        [self setGuid:[input readString]];
        break;
      }
      case 16: {
        [self setDate:[input readInt64]];
        break;
      }
      case 25: {
        [self setValue:[input readDouble]];
        break;
      }
      case 34: {
        [self setKind:[input readString]];
        break;
      }
      case 40: {
        [self setDeleted:[input readBool]];
        break;
      }
    }
  }
}
- (BOOL) hasGuid {
  return resultTransaction.hasGuid;
}
- (NSString*) guid {
  return resultTransaction.guid;
}
- (TransactionBuilder*) setGuid:(NSString*) value {
  resultTransaction.hasGuid = YES;
  resultTransaction.guid = value;
  return self;
}
- (TransactionBuilder*) clearGuid {
  resultTransaction.hasGuid = NO;
  resultTransaction.guid = @"";
  return self;
}
- (BOOL) hasDate {
  return resultTransaction.hasDate;
}
- (SInt64) date {
  return resultTransaction.date;
}
- (TransactionBuilder*) setDate:(SInt64) value {
  resultTransaction.hasDate = YES;
  resultTransaction.date = value;
  return self;
}
- (TransactionBuilder*) clearDate {
  resultTransaction.hasDate = NO;
  resultTransaction.date = 0L;
  return self;
}
- (BOOL) hasValue {
  return resultTransaction.hasValue;
}
- (Float64) value {
  return resultTransaction.value;
}
- (TransactionBuilder*) setValue:(Float64) value {
  resultTransaction.hasValue = YES;
  resultTransaction.value = value;
  return self;
}
- (TransactionBuilder*) clearValue {
  resultTransaction.hasValue = NO;
  resultTransaction.value = 0;
  return self;
}
- (BOOL) hasKind {
  return resultTransaction.hasKind;
}
- (NSString*) kind {
  return resultTransaction.kind;
}
- (TransactionBuilder*) setKind:(NSString*) value {
  resultTransaction.hasKind = YES;
  resultTransaction.kind = value;
  return self;
}
- (TransactionBuilder*) clearKind {
  resultTransaction.hasKind = NO;
  resultTransaction.kind = @"";
  return self;
}
- (BOOL) hasDeleted {
  return resultTransaction.hasDeleted;
}
- (BOOL) deleted {
  return resultTransaction.deleted;
}
- (TransactionBuilder*) setDeleted:(BOOL) value {
  resultTransaction.hasDeleted = YES;
  resultTransaction.deleted = value;
  return self;
}
- (TransactionBuilder*) clearDeleted {
  resultTransaction.hasDeleted = NO;
  resultTransaction.deleted = NO;
  return self;
}
@end

@interface AccountDelta ()
@property (strong) NSMutableArray * addedOrModifiedArray;
@property SInt64 serverTimestamp;
@end

@implementation AccountDelta

@synthesize addedOrModifiedArray;
@dynamic addedOrModified;
- (BOOL) hasServerTimestamp {
  return !!hasServerTimestamp_;
}
- (void) setHasServerTimestamp:(BOOL) _value_ {
  hasServerTimestamp_ = !!_value_;
}
@synthesize serverTimestamp;
- (instancetype) init {
  if ((self = [super init])) {
    self.serverTimestamp = 0L;
  }
  return self;
}
static AccountDelta* defaultAccountDeltaInstance = nil;
+ (void) initialize {
  if (self == [AccountDelta class]) {
    defaultAccountDeltaInstance = [[AccountDelta alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultAccountDeltaInstance;
}
- (instancetype) defaultInstance {
  return defaultAccountDeltaInstance;
}
- (NSArray *)addedOrModified {
  return addedOrModifiedArray;
}
- (Transaction*)addedOrModifiedAtIndex:(NSUInteger)index {
  return [addedOrModifiedArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  [self.addedOrModifiedArray enumerateObjectsUsingBlock:^(Transaction *element, NSUInteger idx, BOOL *stop) {
    [output writeMessage:1 value:element];
  }];
  if (self.hasServerTimestamp) {
    [output writeInt64:2 value:self.serverTimestamp];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  [self.addedOrModifiedArray enumerateObjectsUsingBlock:^(Transaction *element, NSUInteger idx, BOOL *stop) {
    size_ += computeMessageSize(1, element);
  }];
  if (self.hasServerTimestamp) {
    size_ += computeInt64Size(2, self.serverTimestamp);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (AccountDelta*) parseFromData:(NSData*) data {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromData:data] build];
}
+ (AccountDelta*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (AccountDelta*) parseFromInputStream:(NSInputStream*) input {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromInputStream:input] build];
}
+ (AccountDelta*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (AccountDelta*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromCodedInputStream:input] build];
}
+ (AccountDelta*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AccountDelta*)[[[AccountDelta builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (AccountDeltaBuilder*) builder {
  return [[AccountDeltaBuilder alloc] init];
}
+ (AccountDeltaBuilder*) builderWithPrototype:(AccountDelta*) prototype {
  return [[AccountDelta builder] mergeFrom:prototype];
}
- (AccountDeltaBuilder*) builder {
  return [AccountDelta builder];
}
- (AccountDeltaBuilder*) toBuilder {
  return [AccountDelta builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  [self.addedOrModifiedArray enumerateObjectsUsingBlock:^(Transaction *element, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@ {\n", indent, @"addedOrModified"];
    [element writeDescriptionTo:output
                     withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }];
  if (self.hasServerTimestamp) {
    [output appendFormat:@"%@%@: %@\n", indent, @"serverTimestamp", [NSNumber numberWithLongLong:self.serverTimestamp]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (void) storeInDictionary:(NSMutableDictionary *)dictionary {
  for (Transaction* element in self.addedOrModifiedArray) {
    NSMutableDictionary *elementDictionary = [NSMutableDictionary dictionary];
    [element storeInDictionary:elementDictionary];
    [dictionary setObject:[NSDictionary dictionaryWithDictionary:elementDictionary] forKey:@"addedOrModified"];
  }
  if (self.hasServerTimestamp) {
    [dictionary setObject: [NSNumber numberWithLongLong:self.serverTimestamp] forKey: @"serverTimestamp"];
  }
  [self.unknownFields storeInDictionary:dictionary];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[AccountDelta class]]) {
    return NO;
  }
  AccountDelta *otherMessage = other;
  return
      [self.addedOrModifiedArray isEqualToArray:otherMessage.addedOrModifiedArray] &&
      self.hasServerTimestamp == otherMessage.hasServerTimestamp &&
      (!self.hasServerTimestamp || self.serverTimestamp == otherMessage.serverTimestamp) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  [self.addedOrModifiedArray enumerateObjectsUsingBlock:^(Transaction *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  if (self.hasServerTimestamp) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.serverTimestamp] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface AccountDeltaBuilder()
@property (strong) AccountDelta* resultAccountDelta;
@end

@implementation AccountDeltaBuilder
@synthesize resultAccountDelta;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultAccountDelta = [[AccountDelta alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultAccountDelta;
}
- (AccountDeltaBuilder*) clear {
  self.resultAccountDelta = [[AccountDelta alloc] init];
  return self;
}
- (AccountDeltaBuilder*) clone {
  return [AccountDelta builderWithPrototype:resultAccountDelta];
}
- (AccountDelta*) defaultInstance {
  return [AccountDelta defaultInstance];
}
- (AccountDelta*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (AccountDelta*) buildPartial {
  AccountDelta* returnMe = resultAccountDelta;
  self.resultAccountDelta = nil;
  return returnMe;
}
- (AccountDeltaBuilder*) mergeFrom:(AccountDelta*) other {
  if (other == [AccountDelta defaultInstance]) {
    return self;
  }
  if (other.addedOrModifiedArray.count > 0) {
    if (resultAccountDelta.addedOrModifiedArray == nil) {
      resultAccountDelta.addedOrModifiedArray = [[NSMutableArray alloc] initWithArray:other.addedOrModifiedArray];
    } else {
      [resultAccountDelta.addedOrModifiedArray addObjectsFromArray:other.addedOrModifiedArray];
    }
  }
  if (other.hasServerTimestamp) {
    [self setServerTimestamp:other.serverTimestamp];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (AccountDeltaBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (AccountDeltaBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSetBuilder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        TransactionBuilder* subBuilder = [Transaction builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addAddedOrModified:[subBuilder buildPartial]];
        break;
      }
      case 16: {
        [self setServerTimestamp:[input readInt64]];
        break;
      }
    }
  }
}
- (NSMutableArray *)addedOrModified {
  return resultAccountDelta.addedOrModifiedArray;
}
- (Transaction*)addedOrModifiedAtIndex:(NSUInteger)index {
  return [resultAccountDelta addedOrModifiedAtIndex:index];
}
- (AccountDeltaBuilder *)addAddedOrModified:(Transaction*)value {
  if (resultAccountDelta.addedOrModifiedArray == nil) {
    resultAccountDelta.addedOrModifiedArray = [[NSMutableArray alloc]init];
  }
  [resultAccountDelta.addedOrModifiedArray addObject:value];
  return self;
}
- (AccountDeltaBuilder *)setAddedOrModifiedArray:(NSArray *)array {
  resultAccountDelta.addedOrModifiedArray = [[NSMutableArray alloc]initWithArray:array];
  return self;
}
- (AccountDeltaBuilder *)clearAddedOrModified {
  resultAccountDelta.addedOrModifiedArray = nil;
  return self;
}
- (BOOL) hasServerTimestamp {
  return resultAccountDelta.hasServerTimestamp;
}
- (SInt64) serverTimestamp {
  return resultAccountDelta.serverTimestamp;
}
- (AccountDeltaBuilder*) setServerTimestamp:(SInt64) value {
  resultAccountDelta.hasServerTimestamp = YES;
  resultAccountDelta.serverTimestamp = value;
  return self;
}
- (AccountDeltaBuilder*) clearServerTimestamp {
  resultAccountDelta.hasServerTimestamp = NO;
  resultAccountDelta.serverTimestamp = 0L;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)