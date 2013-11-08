//
//  AppDelegate.h
//  BrowserView
//
//  Created by Азат Зулькарняев on 31.10.13.
//  Copyright (c) 2013 Азат Зулькарняев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    __block Boolean inLoop;
    dispatch_queue_t browseQueue;
}
    

@property (weak) IBOutlet WebView *view;
- (IBAction)openURl:(id)sender;
@property (unsafe_unretained) IBOutlet NSPanel *panel;
- (IBAction)goToURL:(id)sender;
@property (strong) NSMutableArray* tasks;
@property (assign) IBOutlet NSWindow *window;
- (IBAction)cancel:(id)sender;

@property (weak) IBOutlet NSButton *checkBox;

@end
