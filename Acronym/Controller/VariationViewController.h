//
//  VariationViewController.h
//  Acronym
//
//  Created by Swagatika on 9/20/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VariationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableVariationList;
@property (nonatomic, strong) NSArray *variationArray;


@end
