//
//  ViewController.h
//  takephoto
//
//  Created by Nimo Wang on 14/05/2016.
//  Copyright © 2016 Nimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)makerecord:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
@end

