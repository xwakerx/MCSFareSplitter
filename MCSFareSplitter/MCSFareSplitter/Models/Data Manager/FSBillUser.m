//
//  FSBillUser.m
//  MCSFareSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FSBillUser.h"
#import "FSDefinitions.h"

@implementation FSBillUser

+(NSNumber *) FSUserTypeGhost { return @0; }
+(NSNumber *) FSUserTypeFacebook { return @1; }

- (id) init{
    self = [super init];
    if(self!=nil){
        self.email=@"";
        self.profilePic=@"";
        self.userType=FSBillUser.FSUserTypeGhost;
        self.firstName=@"";
        self.middleName=@"";
        self.lastName=@"";
        //TODO Deposit methods
        //@property (nonatomic) NSArray *depositMethods;
        //prefered deposit
        self.owe=[NSNumber numberWithInt:0];
        self.owed=[NSNumber numberWithInt:0];
    }
    return self;
}

@end
