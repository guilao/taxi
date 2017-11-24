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

#import <GoogleMaps/GoogleMaps.h>

@interface GMViewController ()
@property (nonatomic, strong) GMLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@end

static NSString * const kTaxiIconKey = @"taxi_icon";

@implementation GMViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupLocation];
    [self.locationManager initUserLocation];
}

#pragma mark - Location
- (void)setupLocation {
    self.locationManager = [GMLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAuthorizationLocation];
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
        [self showMarkerTaxisOnMapWithArray:response];
    }];

    [self setupMapViewWithMyLocation:locations];
}

- (void)stopLocationManager {
    [self.locationManager stopUserLocation];
    self.locationManager = nil;
}

#pragma mark - Maps
- (void)setupMapViewWithMyLocation:(GMCoordinateModel *)locations {
    // Create a GMSCameraPosition that tells the map to display the
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locations.latitude
                                                            longitude:locations.longitude
                                                                 zoom:16];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
}

- (void)showMarkerTaxisOnMapWithArray:(NSMutableArray *)array {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (GMTaxiModel *model in array) {
            GMSMarker *marker = [GMSMarker new];
            marker.icon = [UIImage imageNamed:kTaxiIconKey];
            marker.position = CLLocationCoordinate2DMake(model.coordinate.latitude, model.coordinate.longitude);
            marker.title = model.driver;
            marker.snippet = model.carType;
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = self.mapView;
        }
    });
}
@end
