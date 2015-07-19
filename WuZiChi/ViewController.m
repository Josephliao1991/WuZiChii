//
//  ViewController.m
//  WuZiChi
//
//  Created by 廖宗綸 on 2015/7/18.
//  Copyright (c) 2015年 Joseph Liao. All rights reserved.
//

#import "ViewController.h"
#import "FivePoint.h"

@interface ViewController ()<FivePointDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2,
                             self.view.frame.size.width, self.view.frame.size.height);
    
    FivePoint *gameController = [[FivePoint alloc] initWithFrame:rect
                                                         withRow:19
                                                      withColumn:19
                                                    withDelegate:self];
    [gameController show];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark FivaPoint Delegate
#pragma mark -
-(void)fivePoint:(FivePoint *)fivePoint didTouchDot:(DotView *)dotView martixArray:(NSArray *)matrixArray{
 
    NSLog(@"Now Touch Row :%ld , Column :%ld",(long)dotView.indexPath.row,(long)dotView.indexPath.section);
    NSLog(@"Now is %@",matrixArray[dotView.indexPath.row][dotView.indexPath.section]);
    
    for (NSArray *columnArray in matrixArray) {
        
        NSLog(@"| %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ | %@ |",
              columnArray[0],columnArray[1],columnArray[2],columnArray[3],
              columnArray[4],columnArray[5],columnArray[6],columnArray[7],
              columnArray[8],columnArray[9],columnArray[10],columnArray[11],
              columnArray[12],columnArray[13],columnArray[14],columnArray[15],
              columnArray[16],columnArray[17],columnArray[18]);
        
    }

}

- (void)fivePoint:(FivePoint *)fivePoint didCheckGameResult:(gameResult)gameResult{
    
    
    NSString *theMessage = @"";
    
    switch (gameResult) {
        case gameResult_BlackWin:
            theMessage = @"黑子 獲勝";
            break;
            
        case gameResult_BlackBrokenRule:
            theMessage = @"黑子 違規";
            break;
            
        case gameResult_WhiteWin:
            theMessage = @"白子 獲勝";
            break;
            
        case gameResult_WhiteBrokenRule:
            theMessage = @"白子 違規";
            break;
            
        default:
            break;
    }
 
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"遊戲結束"
                                        message:theMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *doneAction =
    [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //more to do
        [fivePoint resetGame];
        
    }];
    
    [alertController addAction:doneAction];
    [self presentViewController:alertController animated:YES completion:nil];
    

}



@end

