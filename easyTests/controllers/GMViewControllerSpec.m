//
//  GMViewControllerSpec.m
//  easyTests
//
//  Created by Guilherme Martins on 24/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "Expecta.h"
#import <Specta/Specta.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GMViewController.h"

@interface GMViewController (Private)
@property (nonatomic, strong) GMLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@end

SpecBegin(GMViewController)

describe(@"GMViewController", ^{
    __block GMViewController *controller;
    
    it(@"should initialize GMViewController as controler's view", ^{
        GMLocationManager* manager = [GMLocationManager new];
        controller = [[GMViewController alloc] init];
        expect(controller).notTo.beNil();
        expect(controller.locationManager).to.equal(manager);
        expect(controller.mapView.myLocationEnabled).to.beTruthy();
    });
});
SpecEnd
