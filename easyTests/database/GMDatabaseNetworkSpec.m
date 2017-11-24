//
//  GMDatabaseNetworkSpec.m
//  easyTests
//
//  Created by Guilherme Martins on 24/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "Expecta.h"
#import <Specta/Specta.h>
#import <OCMock.h>
#import "GMDatabaseNetwork.h"

SpecBegin(GMDatabaseNetwork)

describe(@"Test method shared.", ^{
    __block GMDatabaseNetwork *client;
    
    beforeAll(^{
        client = [GMDatabaseNetwork sharedClient];
    });
    
    it(@"Should instantiate an GMDatabaseNetwork object.", ^{
        expect(client).beInstanceOf([GMDatabaseNetwork class]);
    });
    
});

describe(@"IPFGenerics methods.", ^{
    __block id mockDatabase;
    __block NSString *api;
    __block NSDictionary *parameters;
    __block NSError *emptyError;
    
    beforeAll(^{
        api = @"gettaxis?";
        parameters = @{ @"lat": @"-23.5826059",
                        @"lng": @"-46.6766973"
                        };
        emptyError = nil;
    }); 
    
    beforeEach(^{
        mockDatabase = OCMPartialMock([GMDatabaseNetwork sharedClient]);
        OCMStub(ClassMethod([mockDatabase sharedClient])).andReturn(mockDatabase);
    });
    
    it(@"Should return response of NSURL. success", ^{
        NSMutableArray *array = [NSMutableArray array];
        OCMStub([mockDatabase requestWithAPI:[OCMArg any]
                                  parameters:[OCMArg any]
                              withCompletion:([OCMArg invokeBlockWithArgs:array, [NSNull null], nil])]);

        [[GMDatabaseNetwork sharedClient] requestWithAPI:api parameters:parameters withCompletion:^(id response, NSError *error) {
            expect([response class]).to.equal([NSDictionary class]);
            expect(error).to.beNil();
            expect(response).notTo.beNil();
        }];
    });
    
    it(@"Should return response of NSURL. error denied", ^{
        NSMutableArray *array = [NSMutableArray array];
        OCMStub([mockDatabase requestWithAPI:[OCMArg any]
                                  parameters:[OCMArg any]
                              withCompletion:([OCMArg invokeBlockWithArgs:array, [NSNull null], nil])]);
        
        [[GMDatabaseNetwork sharedClient] requestWithAPI:@"" parameters:parameters withCompletion:^(id response, NSError *error) {
            expect(error).notTo.beNil();
            expect(error.code).equal(403);
            expect(response).to.beNil();
        }];
    });
    
    afterEach(^{
        [mockDatabase stopMocking];
        mockDatabase = nil;
    });
    
});

SpecEnd
