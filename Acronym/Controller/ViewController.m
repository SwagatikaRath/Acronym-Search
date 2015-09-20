//
//  ViewController.m
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import "ViewController.h"
#import "AcronymData.h"
#import "MBProgressHUD.h"
#import "AcronymConstant.h"
#import "VariationViewController.h"


@interface ViewController ()

@property (nonatomic, strong) AcronymData *acronymData;
@property (nonatomic, strong) NSArray *meaningArray;
@property (nonatomic, strong) NSString *headerTitleString;
@property  BOOL noResultFound;

@end

@implementation ViewController


- (void)viewDidLoad {
     [super viewDidLoad];
   
    //Setting the tableview delegate to self
    _tableAcronymList.delegate = self;
    _tableAcronymList.dataSource = self;
    
    _tableAcronymList.estimatedRowHeight = 80;
    _tableAcronymList.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UISearchBar delegate methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if ([_searchAcronyms.text  isEqual: @""]) {
        self.meaningArray = nil;
        [_tableAcronymList reloadData];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    [self searchAcronym:searchBar.text];
    [_searchAcronyms resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    self.meaningArray = nil;
    [_tableAcronymList reloadData];
    [_searchAcronyms resignFirstResponder];
}


#pragma mark - TableView Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meaningArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"AcronymTableViewCell";
    
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil];
        cellId=[nib objectAtIndex:0];
    }
    
    cell.textLabel.text = self.meaningArray[indexPath.row][@"lf"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"This acronym has %@ occurences and used first in the year %@",self.meaningArray[indexPath.row][@"freq"],self.meaningArray[indexPath.row][@"since"]];
    return cell;
}

#pragma mark - TableView Delegates Methods
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (![_searchAcronyms.text isEqual:@""] && !_noResultFound) {
        _headerTitleString = [NSString stringWithFormat:@"Result for acronym %@",_searchAcronyms.text];
    }
    else{
        _headerTitleString = [NSString stringWithFormat:@"Acronym Result"];
    }
    return _headerTitleString;
}

#pragma mark - searchAcronym:resultAcronym Method
/**
 
 @method
 
 searchAcronym:resultAcronym
 
 @param resultAcronym:Acronym text entered by the user
 
 @discussion This method will call the fetchAcronym:parameters method of ACHttpClient to initiate acronym search.
 
 */

- (void)searchAcronym:(NSString *)resultAcronym {
    
    NSDictionary *parameters = @{@"sf": resultAcronym};
    
    // show loading indicator request is initiated
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ACHttpClientApi sharedACHttpClientApi] fetchAcronym:resultAcronym parameters:parameters
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               
                               //response is a single item array so fetching the first element
                               if([responseObject isKindOfClass:[NSArray class]] && [responseObject count] > 0 ){
                                   
                                   _acronymData = [[AcronymData alloc] initWithDictionary:responseObject[0]];
                                   self.meaningArray = [_acronymData.results mutableCopy];
                                   [_tableAcronymList reloadData];
                                   _noResultFound = FALSE;
                                   
                               }
                               
                               else {
                                   
                                   [self showAlertForWarning:@"No Results!" message:[NSString stringWithFormat:@"No results found for %@",resultAcronym]];
                                   
                               }
                               
                        }failure:^(NSURLSessionDataTask *task, NSError *error) {
                           
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [self showAlertForWarning:@"Error" message:error.localizedDescription];
                        }];
}


#pragma mark - Error Alert

// ***** To show the alert with passed message

-(void)showAlertForWarning:(NSString *)strTitle message:(NSString *)strMsg {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
   
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _noResultFound = TRUE;
        self.meaningArray = nil;
        [_tableAcronymList reloadData];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"VariationControllerIdentifier"]) {
        NSIndexPath *indexPath = [self.tableAcronymList indexPathForSelectedRow];
        VariationViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.variationArray = self.meaningArray [indexPath.row][@"vars"];
    }
    
}
@end
