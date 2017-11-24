//
//  GMTaxiModel.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMTaxiModel.h"

static NSString * const kLatitudeJSON = @"lat";
static NSString * const kLongitudeJSON = @"lng";
static NSString * const kDriverJSON = @"driver-name";
static NSString * const kCarTypeJSON = @"driver-car";

@implementation GMTaxiModel

- (instancetype)initWithJSON:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.coordinate = [GMCoordinateModel new];
        [self setValuesForKeysWithJSON:dictionary];
    }
    return self;
}

- (void)setValuesForKeysWithJSON:(NSDictionary*)dictionary {
    self.coordinate.latitude = [dictionary[kLatitudeJSON] floatValue];
    self.coordinate.longitude = [dictionary[kLongitudeJSON] floatValue];
    self.driver = dictionary[kDriverJSON];
    self.carType = dictionary[kCarTypeJSON];
}

@end
