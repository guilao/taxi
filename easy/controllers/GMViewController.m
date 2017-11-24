//
//  GMViewController.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMViewController.h"
#import "GMTaxisManager.h"
#import "GMTaxiModel.h"

@interface GMViewController ()
@property (nonatomic, strong) GMLocationManager *locationManager;
@property (nonatomic, readwrite) BOOL isLocationStarted;

@property (weak, nonatomic) IBOutlet UIButton *searchTaxiButton;
@end

@implementation GMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLocation];
}

#pragma mark - Location
- (void)setupLocation {
    self.locationManager = [GMLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAuthorizationLocation];
}

#pragma mark - IBAction
- (IBAction)tapSearchTaxiButton:(id)sender {
    if(!self.isLocationStarted) {
        self.isLocationStarted = YES;
        
        if (!self.locationManager) {
            [self setupLocation];
        }
        [self.locationManager initUserLocation];        
        self.searchTaxiButton.userInteractionEnabled = NO;
    }
}

#pragma mark - Error AlertView
- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"default.error.title", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok.button", nil) style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Location Methods Delegate
- (void)locationManageDidFailWithError:(NSError *)error {
    [self stopLocationManager];
    [self showAlertWithMessage:NSLocalizedString(@"location.service.notDetermined.location", nil)];
}

- (void)locationManageDidStopLocations:(GMCoordinateModel *)locations {
    [self stopLocationManager];

    GMTaxisManager *manager = [GMTaxisManager new];
    [manager listTaxisWithCoordinateModel:locations withCompletion:^(NSMutableArray *response, NSString *errorMessage) {
        if (errorMessage) {
            [self showAlertWithMessage:errorMessage];
            return;
        }
    }];
}

- (void)stopLocationManager {
    [self.locationManager stopUserLocation];
    self.locationManager = nil;
    self.isLocationStarted = NO;
    self.searchTaxiButton.userInteractionEnabled = YES;
}
@end
