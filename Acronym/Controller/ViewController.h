//
//  ViewController.h
//  Acronym
//
//  Created by Swagatika on 9/19/15.
//  Copyright (c) 2015 swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACHttpClientApi.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchAcronyms;
@property (weak, nonatomic) IBOutlet UITableView *tableAcronymList;

@end

