//
//  GMLocationManager.h
//  easy
//
//  Created by Guilherme Martins on 23/11/17.
//  Copyright © 2017 Guilherme Martins. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "GMCoordinateModel.h"

@protocol GMLocationManagerDelegate <NSObject>
@required
- (void)locationManageDidFailWithError:(NSError*)error;
- (void)locationManageDidStopLocations:(GMCoordinateModel *)locations;
@end

@interface GMLocationManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic, weak) id <GMLocationManagerDelegate> delegate;

/*
 * Inicia a localização do usuário caso esteja autorização
 * response - retorna GMCoordinateModel
 */
- (void)initUserLocation;

/*
 * Faz a Geolocation ser pausada / desligada
 */
- (void)stopUserLocation;

/*
 * Solicita ao usuário a permissão de acessar sua Geolocation
 */
- (void)requestAuthorizationLocation;

@end
