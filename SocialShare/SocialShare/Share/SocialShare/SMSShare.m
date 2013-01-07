//
//  SMSShare.m
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SMSShare.h"

@implementation SMSShare

-(void)send:(NSDictionary *)content delegate:(id)delegate{
    NSString *to = [content objectForKey:@"to"];
    NSString *body = [content objectForKey:@"body"];
    delegateTmp=delegate;
    
    MFMessageComposeViewController *messageComposeViewController=[[MFMessageComposeViewController alloc] init];
    [messageComposeViewController setMessageComposeDelegate:self];
    if (to != nil) {
        [messageComposeViewController setRecipients:[NSArray arrayWithObject:to]];
    }
    if (body != nil) {
        [messageComposeViewController setBody:body];
    }
    [((UIViewController *)delegateTmp) presentModalViewController:messageComposeViewController animated:YES];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result){
        case MessageComposeResultCancelled:
            NSLog(@"SMS send canceled...");
            break;
        case MessageComposeResultSent:
            NSLog(@"SMS sended...");
            break;
        case MessageComposeResultFailed:
            NSLog(@"SMS send Failed...");
            break;
        default:
            break;
    }
    [((UIViewController *)delegateTmp) dismissModalViewControllerAnimated:YES];
}
@end
