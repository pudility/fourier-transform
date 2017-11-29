//
//  ViewController.m
//  fourier-transform
//
//  Created by Zoe IAMZOE.io on 11/29/17.
//  Copyright © 2017 Zoe IAMZOE.io. All rights reserved.
//

#import "ViewController.h"

@interface NSString (ConvertStringToArray)
-(NSArray*)convertStringToArray;
@end

@implementation NSString (ConvertStringToArray)
- (NSArray*)convertStringToArray {
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    NSUInteger i = 0;
    while (i < self.length) {
        NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString* charString = [self substringWithRange:range];
        [tmpArray addObject:charString];
        i += range.length;
    }
    
    return tmpArray;
}
@end

@interface Reduce:NSObject
- (void) inputArray:(NSArray* )array;
@end

@implementation Reduce
- (NSString*) inputArray:(NSArray* )array base:(int)baseX{
    //baseX = 5; //(baseX > 62) ? 62 : baseX;
    
    __block int carry = 0;
    
    NSString* new_value = @"";
    
    NSString* rangeString = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSArray* range = [rangeString convertStringToArray];
    NSArray* from_range = [range subarrayWithRange:NSMakeRange(0, 10)];
    NSArray* to_range = [range subarrayWithRange:NSMakeRange(0, baseX)];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull element, NSUInteger i, BOOL * _Nonnull stop) {
        carry += [from_range indexOfObject:element] * pow(10.0, (double) i);
    }];
    
    while (carry > 0) {
        new_value = [NSString stringWithFormat:@"%@%@", (NSString*)to_range[carry % baseX], new_value];
        carry = (carry - (carry % baseX)) / baseX;
    }
    
    //NSLog(@"new val %@", new_value);
    return new_value;
}
@end

@implementation ViewController
- (IBAction)goPressed:(NSButton *)sender {
    NSString* value = _textField.stringValue;
    NSString* four = _fourTextField.stringValue;
    NSLog(@"started %@", value);
    NSString* check_val = @"0";
    NSString* currentBaseResult;
    
    int check_base = 0;
    
    NSArray* splitValue = [[[value convertStringToArray] reverseObjectEnumerator] allObjects]; //reversed array
    
    Reduce* reduce = [[Reduce alloc] init];
    
    int x = 3;
    NSDate *methodStart = [NSDate date];
    while (x < [value intValue] && x < 63){
        currentBaseResult = [reduce inputArray:splitValue base:x];
        
        if (([[check_val componentsSeparatedByString:four] count] -1) < ([[currentBaseResult componentsSeparatedByString:four] count] -1)) {
            check_val = currentBaseResult;
            check_base = x;
            //NSLog(@"now set to %@", check_val);
        }
        x++;
    }
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
    _timeLabel.doubleValue = executionTime;
    
    NSLog(@"Finished");
    NSLog(@"Base: %d", check_base);
    _baseLabel.integerValue = check_base;
    NSLog(@"Valu: %@", check_val);
    _numberLabel.stringValue = check_val;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
