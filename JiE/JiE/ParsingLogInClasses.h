//
//  ParsingLogInClasses.h
//  JiE
//
//  Created by neeraj on 24/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingLogInClasses : NSObject

@property(nonatomic,strong) NSString *logIn_Result;
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
