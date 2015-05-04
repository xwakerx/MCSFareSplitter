//
//  FSBillUser.m
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTabUser.h"
#import "TSDefinitions.h"
#import "TSUserTabSplit.h"
#import "TSUtilities.h"

@implementation TSTabUser

+(NSNumber *) TSUserTypeGhost { return @0; }
+(NSNumber *) TSUserTypeFacebook { return @1; }
+(NSNumber *) TSUserTypeContacts { return @2; }
+(NSNumber *) TSUserTypeAction { return @3; }

- (id) init{
    self = [super init];
    if(self!=nil){
        self.email = @"";
        self.profilePic = nil;
        self.userType = TSTabUser.TSUserTypeGhost;
        self.firstName = @"";
        self.middleName = @"";
        self.lastName = @"";
        //TODO Deposit methods
        //@property (nonatomic) NSArray *depositMethods;
        //prefered deposit
    }
    return self;
}

- (id) initWithEmail: (NSString *) email withFirstName:(NSString*) firstName withMiddleName:(NSString*) middleName withLastName:(NSString*) lastName userType:(NSNumber*) userType{
    self = [self init];
    if(self != nil){
        self.email = email;
        self.userType = userType;
        if(firstName)
        {
            self.firstName = firstName;
        }
        if(middleName)
        {
            self.middleName = middleName;
        }
        if(lastName)
        {
            self.lastName = lastName;
        }
        //TODO Deposit methods
        //@property (nonatomic) NSArray *depositMethods;
        //prefered deposit
    }
    return self;
}

- (id) initGhostUserWithMail:(NSString *) email{
    self = [self init];
    if(self != nil){
        self.email=email;
        self.userType=TSTabUser.TSUserTypeGhost;
        //TODO Deposit methods
        //@property (nonatomic) NSArray *depositMethods;
        //prefered deposit
    }
    return self;
}

- (id) initActionUserWithMail:(NSString *) email{
    self = [self init];
    if(self != nil){
        self.email=email;
        self.userType=TSTabUser.TSUserTypeAction;
        //TODO Deposit methods
        //@property (nonatomic) NSArray *depositMethods;
        //prefered deposit
    }
    return self;
}

-(NSString *) description
{
    NSString *description;
    if(![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""])
    {
        description = [NSString stringWithFormat:@"%@ - %@",[self fullName], self.email];
    }
    else
    {
        description = self.email;
    }
    return description;
}

- (NSString *) fullName
{
    if(self.userType == [TSTabUser TSUserTypeGhost]){
        return self.email;
    }
    NSString *fullName = @"";
    if(![self.firstName isEqualToString:@""] && ![self.lastName isEqualToString:@""])
    {
        fullName = [NSString stringWithFormat:@"%@ %@ %@",self.firstName, self.middleName, self.lastName];
    }
    return fullName;
}

-(void)addSplitTab:(TSUserTabSplit *)splitTab
{
    NSMutableArray *mutableSplitTabs = [self.splitTabs mutableCopy];
    BOOL userHasSplitTab = NO;
    for (TSUserTabSplit *localSplitTab in self.splitTabs)
    {
        if(splitTab.tab == localSplitTab.tab)
        {
            userHasSplitTab = YES;
            break;
        }
    }
    
    if(!userHasSplitTab)
    {
        [mutableSplitTabs addObject:splitTab];
    }
}

-(NSNumber *)owe
{
    NSDecimalNumber *owe = [TSUtilities decimalNumberWithNumber:@0];
    
    for (TSUserTabSplit *splitTab in self.splitTabs)
    {
        if([splitTab.amount doubleValue] >= 0)
        {
            owe = [owe decimalNumberByAdding:[TSUtilities decimalNumberWithNumber:splitTab.amount]];
        }
    }
    
    return (NSNumber *)owe;
}

-(NSNumber *)owed
{
    NSDecimalNumber *owed = [TSUtilities decimalNumberWithNumber:@0];
    
    for (TSUserTabSplit *splitTab in self.splitTabs)
    {
        if([splitTab.amount doubleValue] <= 0)
        {
            owed = [owed decimalNumberByAdding:[[TSUtilities decimalNumberWithNumber:splitTab.amount] decimalNumberByMultiplyingBy:[TSUtilities decimalNumberWithNumber:@(-1)]]];
        }
    }
    
    return (NSNumber *)owed;
}
@end
