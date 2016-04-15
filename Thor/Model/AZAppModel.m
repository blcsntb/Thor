//
//  AZAppModel.m
//  Thor
//
//  Created by Alvin on 13-10-22.
//  Copyright (c) 2013年 Alvin. All rights reserved.
//

#import "AZAppModel.h"

@implementation AZAppModel

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init]) {
        self.appName = [coder decodeObjectForKey:@"appName"];
        self.appDisplayName = [coder decodeObjectForKey:@"appDisplayName"];  
        self.appBundleURL = [coder decodeObjectForKey:@"appBundleURL"];
        self.appIconPath = [coder decodeObjectForKey:@"appIconPath"];
        self.isSysApp = [coder decodeBoolForKey:@"isSysApp"];
        self.index = [coder decodeIntegerForKey:@"index"];
    }  
    return self;  
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.appName forKey:@"appName"];
    [coder encodeObject:self.appDisplayName forKey:@"appDisplayName"];
    [coder encodeObject:self.appBundleURL forKey:@"appBundleURL"];
    [coder encodeObject:self.appIconPath forKey:@"appIconPath"];
    [coder encodeBool:self.isSysApp forKey:@"isSysApp"];
    [coder encodeInteger:self.index forKey:@"index"];
}

+ (AZAppModel *)appFromMetadataItem:(NSMetadataItem *)item
{
    NSString *path = [item valueForAttribute:(NSString *)kMDItemPath];
    NSString *name = [item valueForKey:(NSString *)kMDItemFSName];
    NSString *displayName = [item valueForAttribute:(NSString *)kMDItemDisplayName];
    
    NSBundle *appBundle = [NSBundle bundleWithPath:path];
    NSString *iconName = [[appBundle infoDictionary] objectForKey:@"CFBundleIconFile"];
    
    AZAppModel *app = [[AZAppModel alloc] init];
    app.appBundleURL = appBundle.bundleURL;
    app.appName = name;
    app.appDisplayName = displayName;
    app.appIconPath = iconName;
    app.isSysApp = [path containsString:@"/System/Library"];
    
    return app;
}

@end