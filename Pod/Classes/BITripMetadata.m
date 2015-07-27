#import "BITripMetadata.h"
#import "NSString+Date.h"


@implementation BITripMetadata {
    NSString *_name;
    NSString *_key;
    NSURL *_url;
    NSDate *_startDate;
}

- (instancetype)initWithName:(NSString *)name startDate:(NSDate *)startDate {
    self = [super init];
    if (self) {
        _name = name;
        _key = [[NSUUID UUID] UUIDString];
        _startDate = startDate;
    }
    return self;
}


- (instancetype)initWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name startDate:(NSDate *)startDate {
    self = [super init];
    if (self) {
        _url = url;
        _key = key;
        _name = name;
        _startDate = startDate;
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToMetadata:other];
}

- (BOOL)isEqualToMetadata:(BITripMetadata *)metadata {
    if (self == metadata)
        return YES;
    if (metadata == nil)
        return NO;
    if (_name != metadata->_name && ![_name isEqualToString:metadata->_name])
        return NO;
    if (_key != metadata->_key && ![_key isEqualToString:metadata->_key])
        return NO;
    if ([self getStartDate] != [metadata getStartDate] && !((NSInteger)[[self getStartDate] timeIntervalSince1970] == (NSInteger)[[metadata getStartDate] timeIntervalSince1970]))
        return NO;
    if (_url != metadata->_url && ![_url isEqual:metadata->_url])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [_name hash];
    hash = hash * 31u + [_key hash];
    hash = hash * 31u + [_url hash];
    return hash;
}

- (NSString *)getKey {
    return _key;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"name"] = _name;
    dict[@"key"] = _key;
    if(_url){
        dict[@"url"] = [_url absoluteString];
    }
    if(_startDate){
        dict[@"startDate"] = [NSString stringDateFromDate:_startDate];
    }
    return dict;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *key = dictionary[@"key"];
    NSDate *startDate = dictionary[@"startDate"] == nil ? nil : [dictionary[@"startDate"] toDateFromStringDate];
    NSURL* url = nil;
    NSString *urlFromDict = dictionary[@"url"];
    if(urlFromDict){
        url = [[NSURL alloc] initWithString:urlFromDict];
    }
    return [[BITripMetadata alloc] initWithUrl:url key:key name:name startDate:startDate];

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"_name"];
        _key = [coder decodeObjectForKey:@"_key"];
        _url = [coder decodeObjectForKey:@"_url"];
        _startDate = [coder decodeObjectForKey:@"_startDate"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"_name"];
    [coder encodeObject:_key forKey:@"_key"];
    [coder encodeObject:_url forKey:@"_url"];
    [coder encodeObject:_startDate forKey:@"_startDate"];
}


- (NSString *)getName {
    return _name;
}

- (NSDate *)getStartDate {
    return _startDate;
}

@end