//
//  GMDatabaseNetwork.h
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDatabaseNetwork : NSObject

+ (instancetype)sharedClient;

/*
 * Parametro realizada a chamada da API
 * response - array de retorno da API
 * error - retorna o erro da API
 */
- (void)requestWithAPI:(NSString *)api parameters:(id)parameters withCompletion:(void (^)(id response, NSError *error))block;

@end
