#import "BITripMetadata.h"


@implementation BITripMetadata {
    NSString *_name;
    NSString *_key;
    NSURL *_url;
}

- (instancetype)initWithKey:(NSString *)key name:(NSString *)name {
    self = [super init];
    if (self) {
        _key = key;
        _name = name;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _key = [[NSUUID UUID] UUIDString];
    }

    return self;
}

+ (instancetype)metadataWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}


- (instancetype)initWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name {
    self = [super init];
    if (self) {
        _url = url;
        _key = key;
        _name = name;
    }

    return self;
}

+ (instancetype)metadataWithUrl:(NSURL *)url key:(NSString *)key name:(NSString *)name {
    return [[self alloc] initWithUrl:url key:key name:name];
}

+ (instancetype)metadataWithKey:(NSString *)key name:(NSString *)name {
    return [[self alloc] initWithKey:key name:name];
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
    return dict;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *key = dictionary[@"key"];
    NSURL* url = nil;
    NSString *urlFromDict = dictionary[@"url"];
    if(urlFromDict){
        url = [[NSURL alloc] initWithString:urlFromDict];
    }
    return [[BITripMetadata alloc] initWithUrl:url key:key name:name];

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"_name"];
        _key = [coder decodeObjectForKey:@"_key"];
        _url = [coder decodeObjectForKey:@"_url"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"_name"];
    [coder encodeObject:_key forKey:@"_key"];
    [coder encodeObject:_url forKey:@"_url"];
}


- (NSString *)getName {
    return _name;
}
@end