//
//  GMLocationManager.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMLocationManager.h"

@interface GMLocationManager ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMCoordinateModel *coordinateModel;
@end

NSString * const kFormatDate = @"yyyy-MM-dd HH:mm:ss";

@implementation GMLocationManager
- (id)init {
    if (self = [super init]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return self;
}

- (void)initUserLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)stopUserLocation {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    [self insertDataIntoDataBaseWithLocations:location];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationManageDidFailWithError:)]) {
        [self.delegate locationManageDidFailWithError:error];
    }
}

#pragma mark - APP Background
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if (![self isLocationServiceAvailable]){
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"default.domain", nil) code:1 userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"location.service.off.title", nil) forKey:NSLocalizedDescriptionKey]];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationManageDidFailWithError:)]) {
            [self.delegate locationManageDidFailWithError:error];
        }
    }
}

#pragma mark - Helpers
- (BOOL)isLocationServiceAvailable {
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

- (void)requestAuthorizationLocation {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - UserData
- (void)insertDataIntoDataBaseWithLocations:(CLLocation *)location {
    self.coordinateModel = [GMCoordinateModel new];
    self.coordinateModel.latitude = location.coordinate.latitude;
    self.coordinateModel.longitude = location.coordinate.longitude;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:kFormatDate];
    self.coordinateModel.timestamp = [formatter stringFromDate:location.timestamp];
    
    [self loadDataIntoDataBase];
}

- (void)loadDataIntoDataBase {
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationManageDidStopLocations:)]) {
        [self.delegate locationManageDidStopLocations:self.coordinateModel];
    }
}

@end
