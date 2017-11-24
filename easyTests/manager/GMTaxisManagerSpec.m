//
//  GMTaxisManagerSpec.m
//  easyTests
//
//  Created by Guilherme Martins on 24/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "Expecta.h"
#import <Specta/Specta.h>
#import "GMTaxisManager.h"
#import "GMTaxiModel.h"

SpecBegin(GMTaxisManager)

describe(@"GMTaxisManager", ^{
    
    __block GMTaxisManager *taxiManager;
    __block GMCoordinateModel *coordinateModel;
    
    beforeAll(^{
        taxiManager = [GMTaxisManager new];
        coordinateModel = [GMCoordinateModel new];
        coordinateModel.latitude = -23.5826059;
        coordinateModel.longitude = -46.6766973;
    });
    
    it(@"should call the right API taxi and return model", ^{
        [taxiManager listTaxisWithCoordinateModel:coordinateModel withCompletion:^(NSMutableArray *response, NSString *error) {
            
            GMTaxiModel *model = response[0];
            expect(response).notTo.beNil();
            expect([response[0] class]).to.equal([GMTaxiModel class]);
            expect(model.coordinate.latitude).notTo.beNil();
            expect(model.coordinate.longitude).notTo.beNil();
            expect(error).to.beNil();
        }];
    });
});

SpecEnd

