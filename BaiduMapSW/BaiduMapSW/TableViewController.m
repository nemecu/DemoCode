//
//  TableViewController.m
//  BaiduMapSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Sip2BDMapViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"origin";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"sip2Map";
        }
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case 1:
        {
            Sip2BDMapViewController *vc = [[Sip2BDMapViewController alloc] initWithNibName:@"Sip2BDMapViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
            
        default:
            break;
    }
}

@end
