//
//  ViewController.m
//  Lab3
//
//  Created by Avni Barman on 2/6/17.
//  Copyright © 2017 Avni Barman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taxOptions;
@property (weak, nonatomic) IBOutlet UILabel *taxAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UISwitch *taxIncludedSwitch;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWithTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *stepperLabel;

@property float billAmount;
@property float taxPercent;
@property float taxAmount;
@property float tipPercent;
@property float subtotal;
@property float tipValue;
@property float totalWithTip;
@property float totalWithSplit;
@property int splitNum;
@property bool includeTax;

@end

@implementation ViewController
- (IBAction)changed:(UITextField *)sender {
    
    _billAmount = self.billAmountTextField.text.floatValue;
    
    [self updateAllValues];
}


- (IBAction)taxOptionPressed:(UISegmentedControl *)sender {
    
    _taxPercent = (7.5f+(0.5f*(float)_taxOptions.selectedSegmentIndex))/100;

    
    [self updateAllValues];
    
}
- (IBAction)taxIncludedPressed:(UISwitch *)sender {
    
    if(_taxIncludedSwitch.on){
        _includeTax = true;
        
    }
    else{
        _includeTax = false;
        
    }
    
    [self updateAllValues];
}

- (IBAction)slider:(UISlider *)sender {
    
    
    UISlider *sliderBar = (UISlider *)sender;
    
    _tipPercent = sliderBar.value;
    _tipPercent = (double)_tipPercent;
    _tipPercent = floorf(_tipPercent * 100 + 0.5) / 100;
    
    [self updateAllValues];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setDefaultValues];
    [self.billAmountTextField becomeFirstResponder];
    
}

- (IBAction)stepperPressed:(UIStepper *)sender {
    UIStepper *stepperVal = (UIStepper *) sender;
    
    _splitNum = stepperVal.value;
    _splitNum = (int)_splitNum;
    
    [self updateAllValues];
}

- (void)setDefaultValues {
    _billAmount = 0.0;
    _taxAmount = 0.0;
    _taxPercent = 0.075f;
    _tipPercent = 0.0;
    _subtotal = 0.0;
    _tipValue = 0.0;
    _totalWithTip = 0.0;
    _totalWithSplit = 0.0;
    _splitNum = 1;
    _includeTax = true;
    
}
- (IBAction)clearFormButtonPressed:(UIButton *)sender {
    
   
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Clear all values"message:@"Are you sure you want to clear all values?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle: @"Clear All" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self setDefaultValues];
        
        [self.taxOptions setSelectedSegmentIndex:0];
        
        [self.taxIncludedSwitch setOn:true];
        
        [self.slider setValue:0.0];
        
        self.billAmountTextField.text = @"";
        self.taxAmountLabel.text = @"Tax $0.00";
        self.tipPercentLabel.text = @"0%";
        self.stepperLabel.text = @"1";
        self.tipLabel.text = @"Tip:      $0.00";
        self.totalWithTipLabel.text = @"Total with Tip:      $0.00";
        self.totalPerPersonLabel.text = @"Total per Person:      $0.00";
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    
    [alertViewController addAction:destructiveAction];
    
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];

    

    
}

- (void)updateAllValues {
    
    int tipPercentDisplay = _tipPercent*100;
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%d", tipPercentDisplay];
    
    self.tipPercentLabel.text = [self.tipPercentLabel.text stringByAppendingString: @"%"];
    
    
    _taxAmount = _billAmount*_taxPercent;
    
    if(_includeTax == true){
        _tipValue = (_billAmount+_taxAmount)*_tipPercent;
        
    }
    else{
        _tipValue = _billAmount*_tipPercent;
    }
    
    _totalWithTip = _billAmount+_tipValue+_taxAmount;
    _totalWithSplit = _totalWithTip/_splitNum;
    
    NSString *tipString = [NSString stringWithFormat:@"%.2f", (double)_tipValue];
    self.tipLabel.text = @"Tip:      $";
    self.tipLabel.text = [self.tipLabel.text stringByAppendingString: tipString];
    
    NSString *stepperString = [NSString stringWithFormat:@"%d", _splitNum];
    self.stepperLabel.text = stepperString;
    
    
    NSString *taxString = [NSString stringWithFormat:@"%.2f", (double)_taxAmount];
    
    self.taxAmountLabel.text = @"Tax $";
    self.taxAmountLabel.text = [self.taxAmountLabel.text stringByAppendingString: taxString];
    
    
    NSString *totalWithTipString = [NSString stringWithFormat:@"%.2f", (double)_totalWithTip];
    
    self.totalWithTipLabel.text = @"Total with Tip:      $";
    self.totalWithTipLabel.text = [self.totalWithTipLabel.text stringByAppendingString: totalWithTipString];
    
    NSString *totalWithSplit = [NSString stringWithFormat:@"%.2f", (double)_totalWithSplit];
    
    self.totalPerPersonLabel.text = @"Total per Person:      $";
    self.totalPerPersonLabel.text = [self.totalPerPersonLabel.text stringByAppendingString: totalWithSplit];
    
    
}
- (IBAction)backgroundButtonDidTapped:(UIButton *)sender {
    
    [self.billAmountTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
