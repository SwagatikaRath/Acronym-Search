//
//  VariationViewController.m
//  Acronym
//
//  Created by Swagatika on 9/20/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import "VariationViewController.h"
#import "AcronymData.h"

@interface VariationViewController ()
@property (nonatomic, strong) NSString *headerTitleString;
@end

@implementation VariationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting the tableview delegate to self
    _tableVariationList.delegate = self;
    _tableVariationList.dataSource = self;
    
    _tableVariationList.estimatedRowHeight = 80;
    _tableVariationList.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - TableView Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.variationArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"VariationCell";
    
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil];
        cellId=[nib objectAtIndex:0];
    }
    
    cell.textLabel.text = self.variationArray[indexPath.row][@"lf"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"This acronym has %@ occurences and used first in the year %@",self.variationArray[indexPath.row][@"freq"],self.variationArray[indexPath.row][@"since"]];
    return cell;
}

#pragma mark - TableView Delegates Methods

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
   _headerTitleString = @"Below are the Variations.";
    return _headerTitleString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
