//
//  ViewController.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "ViewController.h"
#import "GMTaxisManager.h"
#import "GMTaxiModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMCoordinateModel *coordinateModel = [GMCoordinateModel new];
    coordinateModel.latitude = -23.542887;
    coordinateModel.longitude = -46.73158;
    GMTaxisManager *manager = [GMTaxisManager new];
    [manager listTaxisWithCoordinateModel:coordinateModel withCompletion:^(id response, NSString *error) {
        NSLog(@"FOI");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
