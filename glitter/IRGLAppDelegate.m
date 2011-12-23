//
//  IRGLAppDelegate.m
//  glitter
//
//  Created by Evadne Wu on 12/23/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRGLAppDelegate.h"
#import "IRGLDefines.h"

@implementation IRGLAppDelegate
@synthesize window;

- (void) dealloc {
	
	[window release];
	[super dealloc];

}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	[self.window makeKeyAndVisible];
	return YES;
	
}

- (UIWindow *) window {

	if (window)
		return window;
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.backgroundColor = [UIColor whiteColor];
	window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:
		[[(UIViewController *)[NSClassFromString(@"IRGLWebViewController") alloc] init] autorelease]
	] autorelease];
	
	return window;

}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

	NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
	
	if (url)
		[userInfo setObject:url forKey:kIRGLRemoteURL];
	
	if (sourceApplication)
		[userInfo setObject:sourceApplication forKey:kIRGLSourceApplication];
	
	if (annotation)
		[userInfo setObject:annotation forKey:kIRGLAnnotation];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kIRGLDidReceiveRemoteURLNotification object:application userInfo:userInfo];
	
	return YES;	//	Maybe we can carry a nonretained pointer to a “Handled” BOOL in the future

}

@end
