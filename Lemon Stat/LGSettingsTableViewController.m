//
//  LGSettingsTableViewController.m
//  Lemon Stat
//
//  Created by Arkadiy Grigoryanc on 27.11.16.
//  Copyright © 2016 Decidion. All rights reserved.
//

#import "LGSettingsTableViewController.h"

#import "LGChangePassViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "NSString+Request.h"

@interface LGSettingsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *eMail;
@property (strong, nonatomic) NSString *password;

@end

@implementation LGSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //fake data
    _login = @"login";
    _eMail = @"eMail";
    _password = @"password";
    
    
    [self requestGetAccount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"LoginCell" forIndexPath:indexPath];
                    cell.textLabel.text = @"Логин";
                    cell.detailTextLabel.text = _login;
                }
                    break;
                case 1: {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"EmailCell" forIndexPath:indexPath];
                    cell.textLabel.text = @"e-Mail";
                    cell.detailTextLabel.text = _eMail;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PasswordCell" forIndexPath:indexPath];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Request Methods

- (void)requestGetAccount {
    
    extern NSString *gToken;
    extern NSURL *baseURL;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:baseURL];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:gToken forHTTPHeaderField:@"Auth-Token"];
    
    NSString *string = @"catalog/accounts/myaccount";
    
    [manager GET:[string encodeURLString]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
             
             _login = @"login";
             _eMail = @"eMail";
             _password = @"password";
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ChangePassword"]) {
        
        LGChangePassViewController *changePassViewController = segue.destinationViewController;
        
        changePassViewController.navigationItem.title = @"Смена пароля";
        changePassViewController.currentPassword = _password;
        
    }
    
}

@end