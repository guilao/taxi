//
//  GMTaxisManager.m
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMTaxisManager.h"
#import "GMTaxiModel.h"

static NSString *const kLatitudeKey = @"lat";
static NSString *const kLongitudeKey = @"lng";
static NSString *const kTaxisKey = @"taxis";
static NSString *const kAPITaxis = @"gettaxis?";

@implementation GMTaxisManager

- (void)listTaxisWithCoordinateModel:(GMCoordinateModel *)model  withCompletion:(void (^)(NSMutableArray *, NSString *))block {
    NSDictionary *dictionary = @{kLatitudeKey:[NSString stringWithFormat:@"%f", model.latitude],
                                 kLongitudeKey:[NSString stringWithFormat:@"%f", model.longitude]};
    
    [[GMDatabaseNetwork sharedClient] requestWithAPI:kAPITaxis parameters:dictionary withCompletion:^(id response, NSError *error) {
        if (error) {
            block (nil, NSLocalizedString(@"taxi.response.error", nil));
        }
        
        NSMutableArray *arrayResponse = response[kTaxisKey];
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; arrayResponse.count > i; i++) {
            GMTaxiModel *model = [[GMTaxiModel alloc] initWithJSON:arrayResponse[i]];
            [array addObject:model];
        }
        block(array, nil);
    }];
}

@end
