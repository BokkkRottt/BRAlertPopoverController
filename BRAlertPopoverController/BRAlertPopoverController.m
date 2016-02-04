//
//  BRAlertPopoverController.m
//  BRAlertPopoverController
//
//  Created by Yang on 2/3/16.
//  Copyright © 2016 sgyang. All rights reserved.
//

#import "BRAlertPopoverController.h"

@interface BRAlertPopoverController ()

@property (retain) NSAlert * alert;
@property (copy) BRAlertCompletionHandler completionHandler;
@property (assign) NSPopover * popover;

@end

@implementation BRAlertPopoverController

- (instancetype)initWithAlert:(NSAlert*)alert completionHandler:(BRAlertCompletionHandler)handler
{
    self = [self init];
    
    if (self) {
        
        for (NSButton *button in alert.buttons) {
            button.target = self;
            button.action = @selector(dismissAlert:);
        }
        
        [alert layout];
        self.alert = alert;
        self.view = [alert.window contentView];
        self.completionHandler = [handler copy];
    }
    
    return self;
}

- (BOOL)shown
{
    return self.popover.shown;
}

+ (void)showWithAlert:(NSAlert*)alert relativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge completionHandler:(BRAlertCompletionHandler)handler
{
    BRAlertPopoverController * newController = [[BRAlertPopoverController alloc] initWithAlert:alert completionHandler:handler];
    
    [newController showRelativeToRect:rect view:view preferredEdge:preferredEdge];
}

- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge
{
    if (self.shown) {
        return;
    }
    
    NSPopover* popover = _popover;
    
    if (popover) {
        _popover = nil;
    }
    
    popover = [[NSPopover alloc] init];
    popover.delegate = self;
    popover.contentViewController = self;
    
    [popover showRelativeToRect:rect ofView:view preferredEdge:preferredEdge];
    
    _popover = popover;
    
    NSWindow * window = popover.contentViewController.view.window;
    [NSApp runModalForWindow:window];

}

- (void)dismissAlert:(NSButton*)clickedButton
{
    NSUInteger indexOfClickedButton = [self.alert.buttons indexOfObject:clickedButton];

    NSInteger returnCode = 0;
    
    switch (indexOfClickedButton) {
        case NSAlertFirstButtonReturn:
        case NSAlertSecondButtonReturn:
        case NSAlertThirdButtonReturn:
            returnCode = indexOfClickedButton;
            break;
        default:
            returnCode = NSAlertThirdButtonReturn + indexOfClickedButton - 2;
            break;
    }
    
    BRAlertCompletionHandler completionHandler = self.completionHandler;
    
    if (completionHandler) {
        completionHandler(returnCode);
    }
    
    NSPopover * popover = self.popover;
    
    if (popover) {
        [popover close];
    }
    
    [NSApp stopModal];
}

- (void)popoverDidClose:(NSNotification*)notification
{
    NSPopover* popover = self.popover;
    
    if (popover) {
        popover.delegate = nil;
        popover = nil;
    }
}

@end

@implementation NSAlert (popover)

- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge completionHandler:(BRAlertCompletionHandler)handler
{
    [BRAlertPopoverController showWithAlert:self relativeToRect:rect view:view preferredEdge:preferredEdge completionHandler:handler];
}

@end

