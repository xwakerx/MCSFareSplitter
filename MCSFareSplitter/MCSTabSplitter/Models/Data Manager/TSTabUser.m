//
//  FSBillUser.m
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTabUser.h"
#import "TSDefinitions.h"

@implementation TSTabUser

+(NSNumber *) TSUserTypeGhost { return @0; }
+(NSNumber *) TSUserTypeFacebook { return @1; }

- (id) init{
    self = [super init];
    if(self!=nil){
        self.email=@"";
        self.profilePic=@"";
        self.userType=TSTabUser.TSUserTypeGhost;
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

- (id) initGhostUserWithMail:(NSString *) email{
    self = [super init];
    if(self!=nil){
        self.email=email;
        self.profilePic=@"";
        self.userType=TSTabUser.TSUserTypeGhost;
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

-(NSString *) description{
    NSString *description;
    if(![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""]){
        description = [NSString stringWithFormat:@"%@ %@ %@",self.firstName, self.middleName, self.lastName];
    }else{
        description = self.email;
    }
    return description;
}

- (NSString *) getFullName{
    NSString *fullName = @"";
    if(![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""]){
        fullName = [NSString stringWithFormat:@"%@ %@ %@",self.firstName, self.middleName, self.lastName];
    }
    return fullName;
}

@end
