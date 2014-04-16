//
//  ECViewController.m
//  tictactoeSampleApp
//
//  Created by Brij Mohan on 03/03/14.
//  Copyright (c) 2014 Engageclick. All rights reserved.
//

#import "ECViewController.h"
#define kPlayer1 1
#define kPlayer2 2

#define BTN_1_TAG 1
#define BTN_2_TAG 2
#define BTN_3_TAG 3
#define BTN_4_TAG 4
#define BTN_5_TAG 5
#define BTN_6_TAG 6
#define BTN_7_TAG 7
#define BTN_8_TAG 8
#define BTN_9_TAG 9
#define BTN_10_TAG 10
#define BTN_11_TAG 11
#define BTN_12_TAG 12
#define BTN_13_TAG 13
#define BTN_14_TAG 14
#define BTN_15_TAG 15
#define BTN_16_TAG 16

@interface ECViewController ()
{
    int nofRowsnColumns;
    
    UIImageView *imgView;

    UIButton *player1;
    UIButton *player2;
    NSMutableArray *array1;
    NSMutableArray *array2;
    int count1,count2;
    int selPlayerTag;
    
    UITapGestureRecognizer *singleTapGesture;
    
}
@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    array1 = [[NSMutableArray alloc] init];
    array2 = [[NSMutableArray alloc] init];

    nofRowsnColumns = 16;
    
    player1 = [UIButton buttonWithType:UIButtonTypeCustom];
    player1.frame = CGRectMake(40, 20, 120, 40);
    [player1 setTitle:@"Player 1" forState:UIControlStateNormal];
    [player1 setTag:kPlayer1];
    player1.backgroundColor = [UIColor blackColor];
    [player1 addTarget:self action:@selector(player1Selected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:player1];
    
    player2 = [UIButton buttonWithType:UIButtonTypeCustom];
    player2.frame = CGRectMake(165, 20, 120, 40);
    [player2 setTitle:@"Player 2" forState:UIControlStateNormal];
    [player2 setTag:kPlayer2];
    player2.backgroundColor = [UIColor blackColor];
    [player2 addTarget:self action:@selector(player2Selected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:player2];

    
    float x=40;
    float y=80;
    float width = 60;
    float height = 60;
    
//    singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    singleTapGesture.numberOfTapsRequired = 1;
//    singleTapGesture.delegate = self;

    for(int i=0; i<nofRowsnColumns; i++)
    {
        imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(x, y, width, height);
        imgView.userInteractionEnabled = YES;
        imgView.tag = i+1;
        imgView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:imgView];
        
        x = x + width + 2;
        
        if((i+1)%4==0) //
        {
            x = 40;
            y = y + height + 2;
        }
//        NSLog(@"frajme:: %@", NSStringFromCGRect(imgView.frame));
        
//        [imgView addGestureRecognizer:singleTapGesture];
    }
    
    playerSelected = NO;
    
}

- (void)player1Selected
{
    selPlayerTag = kPlayer1;
    player1.userInteractionEnabled = NO;
    player2.userInteractionEnabled = YES;
    
    playerSelected = YES;
    player1.backgroundColor = [UIColor darkGrayColor];
    player2.backgroundColor = [UIColor blackColor];
    
    NSLog(@"selPlayerTag:: %d", selPlayerTag);
    
//    [METoast resetToastAttribute];
//    [METoast toastWithMessage:@"Player 1 selected"];
}

- (void)player2Selected
{
    selPlayerTag = kPlayer2;
    player1.userInteractionEnabled = YES;
    player2.userInteractionEnabled = NO;
    
    playerSelected = YES;
    player2.backgroundColor = [UIColor darkGrayColor];
    player1.backgroundColor = [UIColor blackColor];

    NSLog(@"selPlayerTag:: %d", selPlayerTag);
    
//    [METoast resetToastAttribute];
//    [METoast toastWithMessage:@"Player 2 selected"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:imgew];
    
    if(![touch.view isKindOfClass:[UIImageView class]])
    {
        return;
    }
    
    if(playerSelected == YES)
    {
        playerSelected = NO;
        
        tagValue = touch.view.tag;
        
        NSLog(@"TouchedView tagValue = %d", tagValue);

        if([touch.view isKindOfClass:[UIImageView class]])
        {
            //PLAYER 1 SELECTION
            if(selPlayerTag == kPlayer1)
            {
                
                if(touch.view.backgroundColor == [UIColor orangeColor])
                {
                    touch.view.backgroundColor = [UIColor redColor];
                    
                    NSString *tagg = @"";
                    tagg = [NSString stringWithFormat:@"%d", tagValue];
                    
                    [array1 addObject:tagg];

                    [self checkForCondition];

                }
                else
                {
                    touch.view.userInteractionEnabled = YES;
                    playerSelected = YES;
                }
            }
            
            
            //PLAYER 2 SELECTION
            if(selPlayerTag == kPlayer2)
            {
                if(touch.view.backgroundColor == [UIColor orangeColor])
                {
                    touch.view.backgroundColor = [UIColor blueColor];
                    
                    NSString *tagg = @"";
                    tagg = [NSString stringWithFormat:@"%d", tagValue];
                    
                    [array2 addObject:tagg];
                    
                    [self checkForCondition];

                }
                else
                {
                    touch.view.userInteractionEnabled = YES;
                    playerSelected = YES;
                }
            }
        }
    }
}


- (void)disableUserInteraction
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
        {
            if(view.backgroundColor == [UIColor redColor] || view.backgroundColor == [UIColor blueColor])
            {
                view.userInteractionEnabled = NO;
            }
//            else
//            {
//                view.userInteractionEnabled = YES;
//            }
        }
    }
}


- (void)enableUserInteraction
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
        {
            if(view.backgroundColor == [UIColor orangeColor])
            {
                view.userInteractionEnabled = YES;
            }
//            else
//            {
//                view.userInteractionEnabled = NO;
//            }
        }
    }
}


- (void)checkForCondition
{
    NSLog(@"ARRAY 111111:: %@", array1);
    NSLog(@"ARRAY 222222:: %@", array2);
    
    if([array1 containsObject:@"1"] && [array1 containsObject:@"6"] && [array1 containsObject:@"11"])
    {
        NSLog(@"WIN");
        [array1 removeAllObjects];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Player 1 got one point" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    
    if([array2 containsObject:@"1"] && [array2 containsObject:@"6"] && [array2 containsObject:@"11"])
    {
        NSLog(@"WIN");
        [array2 removeAllObjects];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Player 2 got one point" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    
    if(array1.count == 8)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Rerun App" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    
    if(array2.count == 8)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Rerun App" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }


}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
////    CGPoint point= [touch locationInView:self.view];
////    NSLog(@"Point :: %f, %f", point.x,point.y);
////    return NO; // handle the touch
//    
//    return NO;
//}
//
//- (void)handleTap:(UITapGestureRecognizer *)gesture {
//    UIView *tappedView = [gesture.view hitTest:[gesture locationInView:gesture.view] withEvent:nil];
//    NSLog(@"Touch event on view: %@", [tappedView class]);
//    NSLog(@"tagtagtagtag:: %d", tappedView.tag);
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
