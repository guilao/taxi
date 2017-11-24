//
//  GMTaxiModel.h
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMCoordinateModel.h"

@interface GMTaxiModel : NSObject

@property (nonatomic, strong) GMCoordinateModel *coordinate;
@property (nonatomic, strong) NSString *driver;
@property (nonatomic, strong) NSString *carType;

/*
 * Inicia o model com os dados vindos da API jSON
 */
- (instancetype)initWithJSON:(NSDictionary *)dictionary;

@end
