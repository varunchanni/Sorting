//
//  ViewController.m
//  Sorting
//
//  Created by Varun on 30/11/2015.
//  Copyright © 2015 Channi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    __weak IBOutlet UIView *viewResult;
    __weak IBOutlet UILabel *lblNumbers;
    __weak IBOutlet UILabel *lblNumbersSorted;
    
    NSMutableArray *arrNumbers;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (UIButton *button in self.view.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button.layer setBorderColor:button.tintColor.CGColor];
            [button.layer setBorderWidth:0.5f];
            [button.layer setCornerRadius:4.0f];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSortTouched:(id)sender {
    [self makeRandomArrayForTag:[sender tag]];
}

#pragma mark - Making Array

- (void)makeRandomArrayForTag:(NSInteger)tag {
    
    [arrNumbers removeAllObjects];
    
    if (!arrNumbers)
        arrNumbers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        int newNumberValue = arc4random() % 100;
        NSNumber *newNumber = [NSNumber numberWithInt:newNumberValue];
        
        if (![arrNumbers containsObject:newNumber])
            [arrNumbers addObject:newNumber];
        else
            i -= 1;
    }
    
    [lblNumbers setText:[arrNumbers componentsJoinedByString:@", "]];
    
    switch (tag) {
        case 1:     [self insertionSort];       break;
        case 2:     [self selectionSort];       break;
        default:    [self selectionSort];       break;
    }
}

- (void)insertionSort {
    
    for (int i = 0; i < [arrNumbers count]; i ++) {
        
        int theElement = [[arrNumbers objectAtIndex:i] intValue];
        int j = i;
        
        while (j > 0 && [[arrNumbers objectAtIndex:(j - 1)] intValue] > theElement) {
            NSNumber *nextNumber = [arrNumbers objectAtIndex:(j - 1)];
            [arrNumbers setObject:nextNumber atIndexedSubscript:j];
            j --;
        }
        [arrNumbers setObject:[NSNumber numberWithInt:theElement] atIndexedSubscript:j];
    }
    [lblNumbersSorted setText:[arrNumbers componentsJoinedByString:@", "]];
}

- (void)selectionSort {
    
    for (int i = 0; i < [arrNumbers count]; i ++) {

        int min = i;
        
        for (int j = i + 1; j < [arrNumbers count]; j ++) {
            
            NSNumber *theElement = [arrNumbers objectAtIndex:min];
            NSNumber *newElement = [arrNumbers objectAtIndex:j];
            
            if ([theElement intValue] > [newElement intValue])
                min = j;
        }
        
        NSNumber *tempNumber = [arrNumbers objectAtIndex:i];
        NSNumber *smallNumber = [arrNumbers objectAtIndex:min];
        [arrNumbers setObject:smallNumber atIndexedSubscript:i];
        [arrNumbers setObject:tempNumber atIndexedSubscript:min];
    }
    [lblNumbersSorted setText:[arrNumbers componentsJoinedByString:@", "]];
}

@end
