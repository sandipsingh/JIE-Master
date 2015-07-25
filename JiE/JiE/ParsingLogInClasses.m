//
//  ParsingLogInClasses.m
//  JiE
//
//  Created by neeraj on 24/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "ParsingLogInClasses.h"

@implementation ParsingLogInClasses
// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        self.logIn_Result        = [jsonDictionary objectForKey:@"result"];
    }
    
    return self;
}
@end
