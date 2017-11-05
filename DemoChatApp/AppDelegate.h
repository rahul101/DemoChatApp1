//
//  AppDelegate.h
//  DemoChatApp
//
//  Created by Mangal Compu Solution on 05/11/17.
//  Copyright © 2017 KloudData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

