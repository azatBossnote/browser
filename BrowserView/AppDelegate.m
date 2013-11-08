//
//  AppDelegate.m
//  BrowserView
//
//  Created by Азат Зулькарняев on 31.10.13.
//  Copyright (c) 2013 Азат Зулькарняев. All rights reserved.
//

#import "AppDelegate.h"
#import "Task.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _tasks=[[NSMutableArray alloc] init];
    inLoop=NO;
}


- (IBAction)openURl:(id)sender {
    [NSApp beginSheet:_panel
       modalForWindow:(NSWindow *)_window
        modalDelegate:self
       didEndSelector:nil
          contextInfo:nil];
}
- (IBAction)goToURL:(id)sender {
    [self fixData];
    inLoop=NO;
    [self startShow];
    [NSApp endSheet:_panel];
    [_panel orderOut:sender];
}
- (IBAction)cancel:(id)sender {
    [NSApp endSheet:_panel];
    inLoop=NO;
    [_panel orderOut:sender];
}
-(void) fixData{
    for (int i=0; i<[_tasks count]; i++) {
        Task * task=_tasks[i];
        if(![[[task url] substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"http://"] ){
            [_tasks[i] performSelector:@selector(setUrl:) withObject:[NSString stringWithFormat:@"http://%@", task.url]];
        }
        if(!task.time){
            [_tasks[i] performSelector:@selector(setTime:) withObject:@0];
        }
    }
}
-(void) update: (int) index{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: [NSURL URLWithString:[_tasks[index] url]]];
    [[_view mainFrame] loadRequest:urlRequest];
}
-(void) startShow{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if([_checkBox state]){
            inLoop=YES;
            while (inLoop) {
                for(int i=0;i<[_tasks count];i++){
                    dispatch_async(dispatch_get_main_queue(), ^{[self update:i];});
                    sleep([[_tasks[i] time] intValue]);
                }
                
            }
        } else {
            for(int i=0;i<[_tasks count];i++){
                dispatch_async(dispatch_get_main_queue(), ^{[self update:i];});
                sleep([[_tasks[i] time] intValue]);
            }
        }
    });
}
@end
