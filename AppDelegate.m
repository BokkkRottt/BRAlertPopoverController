//
//  AppDelegate.m
//  BRAlertPopoverController
//
//  Created by Yang on 2/3/16.
//  Copyright © 2016 sgyang. All rights reserved.
//

#import "AppDelegate.h"
#import "BRAlertPopoverController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *txtReturnInfo;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showAlertDefault:(id)sender {
    NSAlert* alert = [self newAlert];

    BRAlertPopoverController * controller = [[BRAlertPopoverController alloc] initWithAlert:alert completionHandler:^(NSUInteger returnCode) {
        NSString * strPressed = nil;
        switch (returnCode) {
            case NSAlertFirstButtonReturn:
                strPressed = @"OK";
                break;
            case NSAlertSecondButtonReturn:
                strPressed = @"Cancel";
                break;
            case NSAlertThirdButtonReturn:
                strPressed = @"LMAlertPopover";
                [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/lemonmojo/LMAlertPopover"]];
                break;
            default:
                break;
        }
        NSString * strChecked = alert.suppressionButton.state ? @"YES" : @"NO";
        self.txtReturnInfo.stringValue = [NSString stringWithFormat:@"Pressed: %@, Dont show again: %@", strPressed, strChecked];
    }];
    
    [controller showRelativeToRect:NSZeroRect view:sender preferredEdge:NSRectEdgeMinY];
}

- (IBAction)showAlertCategory:(id)sender {
    NSAlert* alert = [self newAlert];
    
    [alert showRelativeToRect:NSZeroRect view:sender preferredEdge:NSRectEdgeMinY completionHandler:^(NSUInteger returnCode) {
        NSString * strPressed = nil;
        switch (returnCode) {
            case NSAlertFirstButtonReturn:
                strPressed = @"OK";
                break;
            case NSAlertSecondButtonReturn:
                strPressed = @"Cancel";
                break;
            case NSAlertThirdButtonReturn:
                strPressed = @"LMAlertPopover";
                [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/lemonmojo/LMAlertPopover"]];
                break;
            default:
                break;
        }
        NSString * strChecked = alert.suppressionButton.state ? @"YES" : @"NO";
        self.txtReturnInfo.stringValue = [NSString stringWithFormat:@"Pressed: %@, Dont show again: %@", strPressed, strChecked];
    }];
}

- (NSAlert *)newAlert
{
    NSAlert* alert = [[NSAlert alloc] init];
    alert.messageText = @"BRAlertPopoverController";
    alert.informativeText = @"BRAlertPopoverController provides a simple API for showing an NSAlert as Popover.\n\nIt is based on LMAlertPopover.";
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert addButtonWithTitle:@"LMAlertPopover"];
    alert.alertStyle = NSCriticalAlertStyle;
    alert.showsSuppressionButton = YES;
    return alert;
}

@end
