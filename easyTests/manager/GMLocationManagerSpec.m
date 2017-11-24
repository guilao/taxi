//
//  GMLocationManagerSpec.m
//  easyTests
//
//  Created by Guilherme Martins on 24/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "Expecta.h"
#import <Specta/Specta.h>
#import "GMLocationManager.h"
#import "GMCoordinateModel.h"

@interface GMLocationManager (Private)
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMCoordinateModel *coordinateModel;
@end

SpecBegin(GMLocationManager)

describe(@"GMLocationManager", ^{
    
    __block GMLocationManager *manager;
    __block GMCoordinateModel *coordinateModel;
    
    beforeAll(^{
        manager = [GMLocationManager new];
        [manager requestAuthorizationLocation];
        
        coordinateModel = [GMCoordinateModel new];
        coordinateModel.latitude = -23.5826059;
        coordinateModel.longitude = -46.6766973;
    });
    
    it(@"should call the location manager with user", ^{
        [manager initUserLocation];
        expect(manager.locationManager).notTo.beNil();
        expect([manager.locationManager class]).to.equal([CLLocationManager class]);
        
    });
    
    it(@"should stop the call the location manager with user", ^{
        [manager stopUserLocation];
        expect(manager.locationManager).to.beNil();
        expect([manager.locationManager class]).notTo.equal([CLLocationManager class]);
        
    });
});

SpecEnd
