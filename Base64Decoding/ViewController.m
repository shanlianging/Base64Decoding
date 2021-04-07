//
//  ViewController.m
//  Base64Decoding
//
//  Created by 武传亮 on 2019/3/17.
//  Copyright © 2019年 shanlianging. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "GDataXMLUtil.h"

@interface ViewController ()

@property (weak) IBOutlet NSTextField *pathTF;
@property (weak) IBOutlet NSTextField *keyTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    

}



- (IBAction)parseAction:(NSButton *)sender {
    
    
    NSString *filePath = self.pathTF.stringValue;
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSString *content;
    if ([rootElement.name isEqualToString:self.keyTF.stringValue]) {
        content = rootElement.stringValue;
    } else {
        for (GDataXMLElement *child in rootElement.children) {
            if ([child.name isEqualToString:self.keyTF.stringValue]) {
                content = child.stringValue;
            }
        }
    }
    
    if (content.length != 0) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableArray *pathArray = [self.pathTF.stringValue componentsSeparatedByString:@"/"].mutableCopy;
        [pathArray removeLastObject];
        
        NSString *path = [pathArray componentsJoinedByString:@"/"].mutableCopy;
        
        
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.xml", self.keyTF.stringValue]];
        
        BOOL isSuccess = NO;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
         
            isSuccess = [data writeToFile:path atomically:YES];
            
        } else {
            
            isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        }
        
        if (isSuccess) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
        
        //[self createFileWithPath:path andData:data];
        
    }
    
    

    
}

- (void)createFileWithPath:(NSString *)path andData:(NSData *)data{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        if([data isEqualToData:[NSData dataWithContentsOfFile:path]]){
            return;
        }
    }
    
    [[NSFileManager defaultManager]  createFileAtPath:path contents:data attributes:nil];
}

- (void)createDirectory:(NSString *) path error:(NSError **) error{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    }
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
