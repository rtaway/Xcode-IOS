//
//  ViewController.m
//  takephoto
//
//  Created by Nimo Wang on 14/05/2016.
//  Copyright © 2016 Nimo. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)makerecord:(id)sender {
    //1
            // 初始化图片选择控制器
       // UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//    controller.delegate =self;
//    controller.sourceType =UIImagePickerControllerSourceTypeCamera;
//    controller.allowsEditing = YES;
//    controller.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
//    controller.videoMaximumDuration = 45.0f;
//    controller.videoQuality = UIImagePickerControllerQualityTypeMedium;
//    
//    
//    
//    [self presentViewController:controller animated:YES completion:NULL];
    //[controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
    
    
    // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
//    NSString *requiredMediaType = ( NSString *)kUTTypeImage;
//    NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
//    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
//    [controller setMediaTypes:arrMediaTypes];
//    
//    // 设置录制视频的质量
//    [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
//    //设置最长摄像时间
//    [controller setVideoMaximumDuration:10.f];
//    
//    
//    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
//    [controller setDelegate:self];// 设置代理
//    [self presentViewController:controller animated:YES completion:NULL];
   //2
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable!!!");
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakeVideo = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            //支持摄像
            canTakeVideo = YES;
            break;
        }
    }
    //检查是否支持摄像
    if (!canTakeVideo) {
        NSLog(@"sorry, capturing video is not supported.!!!");
        return;
    }
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为动态图像
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    //设置摄像图像品质
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //设置最长摄像时间
    imagePickerController.videoMaximumDuration = 30;
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模式视图控制器的形式显示
     [self presentViewController:imagePickerController animated:YES completion:NULL];
    
    
    

}

- (IBAction)takePhoto:(UIButton *)sender {
    //1
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.view.backgroundColor = [UIColor orangeColor];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
//
    //2
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    //检查是否支持拍照
    if (!canTakePicture) {
        NSLog(@"sorry, taking picture is not supported.");
        return;
    }
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil] autorelease];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:NULL];
    [imagePickerController release];
}
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    NSLog(@"get the media info: %@", info);
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取用户编辑之后的图像
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //将该图像保存到媒体库中
        UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //创建ALAssetsLibrary对象并将视频保存到媒体库
        ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (!error) {
                NSLog(@"captured video saved with no error.");
            }else
            {
                NSLog(@"error occured while saving the video:%@", error);
            }
        }];
        [assetsLibrary release];
    }
    
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (error != nil)
    {
        NSLog(@"Image Can not be saved");
    }
    else
    {
        NSLog(@"Successfully saved Image");
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
