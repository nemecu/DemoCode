//
//  ViewController.m
//  ViewDemoSW
//
//  Created by shaowei on 12-12-25.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "ViewController.h"
#import "ImageExpandViewController.h"
#import "ProgressGradientViewController.h"
#import "AnnotationViewController.h"


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_myTableView release];
    [super dealloc];
}




- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 12;
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
            cell.textLabel.text = @"progress+gradient";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"ImageView + Expand";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"AnnotationView";
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
            ProgressGradientViewController *vc = [[ProgressGradientViewController alloc] initWithNibName:@"ProgressGradientViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case 1:
        {
            ImageExpandViewController *vc = [[ImageExpandViewController alloc] initWithNibName:@"ImageExpandViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 2:
        {
            AnnotationViewController *vc = [[AnnotationViewController alloc] initWithNibName:@"AnnotationViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
            
        default:
            break;
    }
}


@end
