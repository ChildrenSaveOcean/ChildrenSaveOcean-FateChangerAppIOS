//
//  FateChangerModel.h
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/29/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FateChangerModel : NSObject
#pragma methods
-(void) startOfModel;
-(void) stopModel;
-(void) saveUserDefaultValues;
-(void) postTeacherRequestForResource: (NSString *) teacherEmail;
-(NSString *) requestBestPersonContinent: (NSString *) continent forCountry: (NSString *) country;
-(void)selectedRole: (NSString *) role;
-(NSString *) whatIsRole;
@end