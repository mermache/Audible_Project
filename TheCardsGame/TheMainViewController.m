//
//  TheMainViewController.m
//  TheCardsGame
//
//  Created by RemoteTiger on 6/19/14.
//  Copyright (c) 2014 Mermache. All rights reserved.
//

#import "TheMainViewController.h"
#import "NSMutableArray+Shuffle.h"

#define CARD_SUIT 4
#define CARD_SETS 13

@interface TheMainViewController (){
    
    
    //Cards in a Deck
    NSMutableArray *deckCardsArray;
    
    NSMutableArray *shuffledCardsArray;
    
    // A collection view to display deck
    UICollectionView *theDeckCollectionView;
    
}


@end

@implementation TheMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
    self.view.backgroundColor=[UIColor orangeColor];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    theDeckCollectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [theDeckCollectionView setDataSource:self];
    [theDeckCollectionView setDelegate:self];
    
    [theDeckCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubview:theDeckCollectionView];
    
    [super viewDidLoad];
    
    
    deckCardsArray = [[NSMutableArray alloc] init];
    
    //Dealing cards
    [self setupCards];
    
    //Button to shuffle cards
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(shuffleCards)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Deal" style:UIBarButtonItemStyleBordered target:self action:@selector(deal)];
    
}

-(void)deal{
    
    if([deckCardsArray count] == 52) {
        UIAlertView *allCards = [[UIAlertView alloc] initWithTitle:@"All CArds Dealt" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [allCards show];
        return;
    }
    
    NSValue *theObject = [shuffledCardsArray lastObject];
    [shuffledCardsArray removeLastObject];
    
    [deckCardsArray insertObject:theObject atIndex:0];
    [theDeckCollectionView reloadData];
    
}


-(void) shuffleCards{
    //suffling cards mehods call
    [deckCardsArray shuffle];
    
    shuffledCardsArray = [[NSMutableArray alloc] initWithArray:deckCardsArray];
    
    [deckCardsArray removeAllObjects];
    
    
    //reloading the view controller with cards
    [theDeckCollectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void) setupCards {
    //setring up cards
    for(int i=0; i< CARD_SUIT; i++) {
        for (int j=0; j<CARD_SETS; j++) {
            Card theCard;
            theCard.suit = i;
            theCard.kind = j;
            [deckCardsArray addObject:[NSValue valueWithBytes:&theCard objCType:@encode(Card)]];
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [deckCardsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    NSValue *thevalue = [deckCardsArray objectAtIndex:indexPath.row];
    Card theCard;
    [thevalue getValue:&theCard];
    NSString *theImageName = [NSString stringWithFormat:@"%d_%d.png",theCard.suit,theCard.kind];
    
    
    imageView.frame = cell.contentView.bounds;
    imageView.image = [UIImage imageNamed:theImageName];
    [cell.contentView addSubview:imageView];
    
    cell.contentView.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 73);
}


@end
