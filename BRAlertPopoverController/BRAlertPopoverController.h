//
//  BRAlertPopoverController.h
//  BRAlertPopoverController
//
//  Created by Yang on 2/3/16.
//  Copyright © 2016 sgyang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** returnCode:
 enum {
	NSAlertFirstButtonReturn	= 1000,
	NSAlertSecondButtonReturn	= 1001,
	NSAlertThirdButtonReturn	= 1002
 };
 */
typedef void (^BRAlertCompletionHandler)(NSUInteger returnCode);

NS_ASSUME_NONNULL_BEGIN
@interface BRAlertPopoverController : NSViewController <NSPopoverDelegate>

- (instancetype)initWithAlert:(NSAlert*)alert completionHandler:(BRAlertCompletionHandler)handler;
+ (void)showWithAlert:(NSAlert*)alert relativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge completionHandler:(BRAlertCompletionHandler)handler;

@property (nonatomic, readonly) BOOL shown;

- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge;

@end

@interface NSAlert (popover)
- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge completionHandler:(BRAlertCompletionHandler)handler;
@end
NS_ASSUME_NONNULL_END
