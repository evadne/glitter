//
//  IRGLWebViewController.m
//  glitter
//
//  Created by Evadne Wu on 12/23/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRGLWebViewController.h"
#import "IRGLDefines.h"

@interface IRGLWebViewController () <UIWebViewDelegate>

+ (NSURLRequest *) defaultRequest;	//	For-test stuff

- (void) handleRefresh:(id)sender;
- (void) handleApplicationDidReceiveRemoteURL:(NSNotification *)aNotification;

@end


@implementation IRGLWebViewController

- (void) dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[super dealloc];

}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self)
		return nil;
	
	self.title = @"Hello World";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(handleRefresh:)] autorelease];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidReceiveRemoteURL:) name:kIRGLDidReceiveRemoteURLNotification object:nil];
	
	return self;

}

- (void) loadView {

	self.view = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
	NSParameterAssert(self.view);

}

- (void) viewDidLoad {

	[super viewDidLoad];
	
	self.webView.delegate = self;
	[self.webView loadRequest:[[self class] defaultRequest]];

}

- (void) handleRefresh:(id)sender {

	[self.webView reload];

}

- (UIWebView *) webView {

	return (UIWebView *)self.view;

}

- (void) webViewDidFinishLoad:(UIWebView *)aWV {

	NSString *actualScript = @"window.irgl.punt = function (wrap) { document.location = 'irgl://handleCallback/' + encodeURIComponent(wrap) }";
	[aWV stringByEvaluatingJavaScriptFromString:actualScript];

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return YES;
	
}

- (void) handleApplicationDidReceiveRemoteURL:(NSNotification *)aNotification {

	NSLog(@"%s %@", __PRETTY_FUNCTION__, aNotification);
	
	//	aNotification

}

+ (NSURLRequest *) defaultRequest {
	
	NSString *pagePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"IRGLTest"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:pagePath]];
	request.HTTPShouldHandleCookies = NO;	//	No matter what.
	
	return request;

}

@end
