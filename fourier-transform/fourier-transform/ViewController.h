//
//  ViewController.h
//  fourier-transform
//
//  Created by Zoe IAMZOE.io on 11/29/17.
//  Copyright © 2017 Zoe IAMZOE.io. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController {
    NSTextField* textField;
    NSTextField *timeLabel;
    NSTextField *numberLabel;
    NSTextField *baseLabel;
    NSTextField *fourTextField;
}

@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSTextField *numberLabel;
@property (weak) IBOutlet NSTextField *baseLabel;

@property (weak) IBOutlet NSTextField *fourTextField;
@property (strong, nonatomic) IBOutlet NSTextField* textField;

@end

