//
//  GMTaxisManager.h
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import "GMDatabaseNetwork.h"
#import "GMCoordinateModel.h"

@interface GMTaxisManager : NSObject

/*
 * Parametro realizada a chamada da API e coleta os taxis próximos a localização enviada
 * response - retorna um array com o model de taxis
 * error - retorna o erro da API
 */
- (void)listTaxisWithCoordinateModel:(GMCoordinateModel *)model withCompletion:(void (^)(NSMutableArray *response, NSString *error))block;

@end
