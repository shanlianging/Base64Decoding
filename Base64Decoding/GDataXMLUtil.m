//
//  GDataXMLUtil.m
//  XmlGData
//
//  Created by low on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GDataXMLUtil.h"
//#import "NSData+Base64.h"

@implementation GDataXMLUtil

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString *) xmlToString:(GDataXMLElement *)element
{
	return [self xmlToString:element addJava:YES];
}

+ (NSData *) xmlToData:(GDataXMLElement *)element
{
	return [self xmlToData:element addJava:YES];
}

+ (void) xmlToFile:(GDataXMLElement *)element fileName:(NSString *)fileName
{
	[[self xmlToData:element addJava:YES] writeToFile:fileName atomically:YES];
}

+ (NSString *) xmlToString:(GDataXMLElement *)element addJava:(BOOL)addJava
{
   	return [[[NSString alloc] initWithData:[GDataXMLUtil xmlToData:element addJava:addJava] encoding:NSUTF8StringEncoding] autorelease];
}

+ (NSData *) xmlToData:(GDataXMLElement *)element addJava:(BOOL)addJava
{
//    <java version="1.6.0_25" class="java.beans.XMLDecoder"> 
    
	GDataXMLDocument * document;
	if (addJava)
	{
		GDataXMLElement *java = [GDataXMLNode elementWithName:@"java"];
		[java addAttribute:[GDataXMLNode attributeWithName:@"version" stringValue:@"1.6.0_25"]];
		[java addAttribute:[GDataXMLNode attributeWithName:@"class" stringValue:@"java.beans.XMLDecoder"]];
    
		[java addChild:element];
    
		document = [[GDataXMLDocument alloc] initWithRootElement:java];
		
	}
	else
	{
		document = [[GDataXMLDocument alloc] initWithRootElement:element];
	}
	
	[document setCharacterEncoding:@"UTF-8"];
	
	NSData * xmlData = document.XMLData;
	
    [document release];
    
    return xmlData;
}

+ (void) addChild:(GDataXMLElement *)parent child:(GDataXMLElement *)child
{
    if (child != nil)[parent addChild:child];
}

+ (GDataXMLElement *) createObjectElementWithPropertyClassName:(NSString *)className
{
    GDataXMLElement *classElement = [GDataXMLElement elementWithName:@"object"];
    [classElement addAttribute:[GDataXMLNode attributeWithName:@"class" stringValue:className]];
    return classElement;
}

+ (GDataXMLElement *) createElementWithPropertyName:(NSString *)propertyName type:(NSString *)type value:(NSString *)value
{
    if (value==nil) return nil;
    
    GDataXMLElement *property = [GDataXMLNode elementWithName:@"void"];
    [property addAttribute:[GDataXMLNode attributeWithName:@"property" stringValue:propertyName]];
    [property addChild:[GDataXMLNode elementWithName:type stringValue:value]];
    return property;
}

+ (GDataXMLElement *) createStringElementWithPropertyName:(NSString *)propertyName value:(NSString *)value
{
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"string" value:value];
}

+ (GDataXMLElement *) createDataElementWithPropertyName:(NSString *)propertyName value:(NSData *)value
{
    if (value==nil) return nil;
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"string" value:[value base64Encoding]];
}

+ (GDataXMLElement *) createFloatElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value
{
    if (value==nil) return nil;
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"float" value:[NSString stringWithFormat:@"%.f", [value floatValue]]];
}

+ (GDataXMLElement *) createDoubleElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value
{
    if (value==nil) return nil;
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"double" value:[NSString stringWithFormat:@"%.2f", [value doubleValue]]];
}

+ (GDataXMLElement *) createIntegerElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value
{
    if (value==nil) return nil;
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"int" value:[NSString stringWithFormat:@"%d", [value intValue]]];
}

+ (GDataXMLElement *) createLongElementWithPropertyName:(NSString *)propertyName value:(NSNumber *)value
{
    if (value==nil) return nil;
    return [GDataXMLUtil createElementWithPropertyName:propertyName type:@"long" value:[NSString stringWithFormat:@"%lld", [value longLongValue]]];
}

+ (GDataXMLElement *) createDateElementWithPropertyName:(NSString *)propertyName value:(NSDate *)value
{
    if (value==nil) return nil;
    
    GDataXMLElement *eleObject = [GDataXMLNode elementWithName:@"object"];
    [eleObject addAttribute:[GDataXMLNode attributeWithName:@"class" stringValue:@"java.util.Date"]];
    [eleObject addChild:[GDataXMLNode elementWithName:@"long" stringValue:[NSString stringWithFormat:@"%lld", (long long int)([value timeIntervalSince1970]*1000ll)]]];

    
    GDataXMLElement *property = [GDataXMLNode elementWithName:@"void"];
    [property addAttribute:[GDataXMLNode attributeWithName:@"property" stringValue:propertyName]];
    [property addChild:eleObject];
    return property;
}

+ (GDataXMLElement *) createObjectElementWithPropertyName:(NSString *)propertyName value:(GDataXMLElement *)value
{
    if (value==nil) return nil;
    
    GDataXMLElement *property = [GDataXMLNode elementWithName:@"void"];
    [property addAttribute:[GDataXMLNode attributeWithName:@"property" stringValue:propertyName]];
    [property addChild:value];
    return property;
}

+ (GDataXMLElement *) createVectorElement:(NSString *)propertyName values:(NSArray *)values
{
    if (values==nil || values.count==0) return nil;
    
    GDataXMLElement *property = [GDataXMLNode elementWithName:@"void"];
    [property addAttribute:[GDataXMLNode attributeWithName:@"property" stringValue:propertyName]];
    
    GDataXMLElement *eleVector = [GDataXMLNode elementWithName:@"object"];
    [eleVector addAttribute:[GDataXMLNode attributeWithName:@"class" stringValue:@"java.util.Vector"]];

    for (GDataXMLElement *ele in values)
    {
        GDataXMLElement *eleAdd = [GDataXMLNode elementWithName:@"void"];
        [eleAdd addAttribute:[GDataXMLNode attributeWithName:@"method" stringValue:@"add"]];
        [eleAdd addChild:ele];
        
        [eleVector addChild:eleAdd];
    }
    
    [property addChild:eleVector];
    
    return property;
}


@end
