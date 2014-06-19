//
//  TheMainViewController.h
//  TheCardsGame
//
//  Created by RemoteTiger on 6/19/14.
//  Copyright (c) 2014 Mermache. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheMainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


typedef struct {
    int suit;
    int kind;
} Card;


@end
