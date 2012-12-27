//
//  ViewController.h
//  ViewDemoSW
//
//  Created by shaowei on 12-12-25.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end
