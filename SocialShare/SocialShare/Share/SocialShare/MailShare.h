//
//  MailShare.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IShare.h"
#import <MessageUI/MessageUI.h>

@interface MailShare : NSObject <MFMailComposeViewControllerDelegate, IShare>{
    @private
    id delegateTmp;
}

@end
