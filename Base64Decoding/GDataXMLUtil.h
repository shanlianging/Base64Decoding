//
//  GDataXMLUtil.h
//  XmlGData
//
//  Created by low on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface GDataXMLUtil : NSObject

+ (NSString *) xmlToString:(GDataXMLElement *)element;

+ (NSData *) xmlToData:(GDataXMLElement *)element;

+ (NSString *) xmlToString:(GDataXMLElement *)element addJava:(BOOL)addJava;

+ (NSData *) xmlToData:(GDataXMLElement *)element addJava:(BOOL)addJava;

+ (void) xmlToFile:(GDataXMLElement *)element fileName:(NSString *)fileName;

+ (void) addChild:(GDataXMLElement *)parent child:(GDataXMLElement *)child;

+ (GDataXMLElement *) createObjectElementWithPropertyClassName:(NSString *)className;

+ (GDataXMLElement *) createElementWithPropertyName:(NSString *)propertyName type:(NSString *)type value:(NSString *)value;

+ (GDataXMLElement *) createStringElementWithPropertyName:(NSString *)propertyName value:(NSString *)value;

+ (GDataXMLElement *) createDataElementWithPropertyName:(NSString *)propertyName value:(NSData *)value;

+ (GDataXMLElement *) createFloatElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value;

+ (GDataXMLElement *) createDoubleElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value;

+ (GDataXMLElement *) createIntegerElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value;

+ (GDataXMLElement *) createLongElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value;

+ (GDataXMLElement *) createDateElementWithPropertyName:(NSString *)propertyName value:(NSDate *)value;

+ (GDataXMLElement *) createObjectElementWithPropertyName:(NSString *)propertyName value:(GDataXMLElement *)value;

+ (GDataXMLElement *) createVectorElement:(NSString *)propertyName values:(NSArray *)values;


@end
