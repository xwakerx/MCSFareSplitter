//
//  TSContactsManager.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSContactsManager.h"
#import "TSTabUser.h"
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@implementation TSContactsManager

+ (id)sharedManager
{
    static TSContactsManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(NSArray *)phoneContacts
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted)
    {
        NSLog(@"Denied");
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        NSLog(@"Authorized");
        return [self getAllContacts];
    }
    else //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
    {
        NSLog(@"Not determined");
    }
    
    return nil;
}

-(NSArray *)getAllContacts
{
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
    CFArrayRef allPeople = (ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName));
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    NSMutableArray *contacts = [NSMutableArray array];
     
    for (int i = 0; i < nPeople; i++) {
        @autoreleasepool {
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);

            if(person == NULL)
            {
                break;
            }
            //get First Name and Last Name
            NSString *firstNames = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString *middleNames = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
            NSString *lastNames =  CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
            
            // get contacts picture, if pic doesn't exists, show standart one
            NSData  *imgData = CFBridgingRelease(ABPersonCopyImageData(person));
            UIImage *image = [UIImage imageWithData:imgData];
            
            //get Phone Numbers
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for(CFIndex i=0; i<ABMultiValueGetCount(multiPhones); i++) {
                @autoreleasepool {
                    CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                    NSString *phoneNumber = CFBridgingRelease(phoneNumberRef);
                    [phoneNumbers addObject:phoneNumber];
                }
            }
            CFRelease(multiPhones);

            //get Contact email
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                @autoreleasepool {
                    CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                    NSString *contactEmail = CFBridgingRelease(contactEmailRef);
                    [contactEmails addObject:contactEmail];
                }
            }
            CFRelease(multiEmails);
            NSString *email = @"";
            if(contactEmails.count > 0 && [contactEmails[0] rangeOfString:@"@facebook.com"].location == NSNotFound)
            {
                email = contactEmails[0];
                
                TSTabUser *contact = [[TSTabUser alloc] initWithEmail:email
                                                        withFirstName:firstNames
                                                       withMiddleName:middleNames
                                                         withLastName:lastNames
                                                             userType:[TSTabUser TSUserTypeFacebook]];
                
                contact.profilePic = image;
                
                [contacts addObject:contact];
            }
        }
    } //autoreleasepool
    CFRelease(allPeople);
    CFRelease(addressBook);
    CFRelease(source);
    
    return contacts;
}


@end
