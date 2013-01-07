//
//  MailShare.m
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MailShare.h"

@implementation MailShare

-(void)send:(NSDictionary *)content delegate:(id)delegate{
    NSString *to = [content objectForKey:@"to"];
    NSString *from = [content objectForKey:@"from"];
    NSString *subject = [content objectForKey:@"subject"];
    NSString *body = [content objectForKey:@"body"];
    NSString *path = [content objectForKey:@"path"];
    delegateTmp=delegate;
    
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setMailComposeDelegate:self];
    if (to != nil) {
        [mailComposeViewController setToRecipients:[NSArray arrayWithObject:to]];
    }
    if (from != nil) {
        //
    }
    if (subject != nil) {
        [mailComposeViewController setSubject:subject];
    }
    if (body != nil) {
        [mailComposeViewController setMessageBody:body isHTML:NO];
    }
    if (path != nil) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        [mailComposeViewController addAttachmentData:data mimeType:@"image/png" fileName:[path stringByDeletingLastPathComponent]];
    }
    [((UIViewController *)delegateTmp) presentModalViewController:mailComposeViewController animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result){
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent:{
            NSLog(@"Mail sent...");
            break;
        }
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
        default:
            break;
    }
    [((UIViewController *)delegateTmp) dismissModalViewControllerAnimated:YES];
}
@end
