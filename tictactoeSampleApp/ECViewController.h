//
//  ECViewController.h
//  tictactoeSampleApp
//
//  Created by Brij Mohan on 03/03/14.
//  Copyright (c) 2014 Engageclick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECViewController : UIViewController <UIGestureRecognizerDelegate>
{
    BOOL playerSelected;
    
    int tagValue;
}
@end
