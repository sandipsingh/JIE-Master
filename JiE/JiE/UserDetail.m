//
//  UserDetail.m
//  JiE
//
//  Created by Rajesh on 26/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "UserDetail.h"

@implementation UserDetail
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_userId forKey:@"userId"];
    [encoder encodeObject:_dob forKey:@"dob"];
    [encoder encodeObject:_profilepic forKey:@"profilepic"];
    [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:_username forKey:@"username"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if ( self != nil )
    {
        _userId = [decoder decodeObjectForKey:@"userId"];
        _dob = [decoder decodeObjectForKey:@"dob"];
        _profilepic = [decoder decodeObjectForKey:@"profilepic"];
        _email = [decoder decodeObjectForKey:@"email"];
        _username = [decoder decodeObjectForKey:@"username"];
    }
    return self;
}
@end
