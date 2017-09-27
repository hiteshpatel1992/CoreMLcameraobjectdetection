//
//  AppDelegate.h
//  CoreMLcameraobjectdetection
//
//  Created by Hitesh Patel on 9/27/17.
//  Copyright © 2017 Hitesh Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

