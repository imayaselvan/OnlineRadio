//
//  ViewController.h
//  DesiRadio
//
//  Created by imayaselvan r. on 30/06/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UITableView *tab;
    NSArray *stationnames,*StationURL;
    __weak IBOutlet UIView *VisualContainerView;

}
@property (strong, nonatomic) IBOutlet UIButton *PlayBtn;
@property(nonatomic,retain)NSDictionary *stationDatas;

@end
