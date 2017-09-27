//
//  ViewController.m
//  CoreMLcameraobjectdetection
//
//  Created by Hitesh Patel on 9/27/17.
//  Copyright © 2017 Hitesh Patel. All rights reserved.
//

#import "ViewController.h"
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>
#import "Resnet50.h"

@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    AVCaptureSession *Session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *Device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *Input = [[AVCaptureDeviceInput alloc] initWithDevice:Device error:nil];
    [Session addInput:Input];
    
    [Session startRunning];
    
    AVCaptureVideoPreviewLayer *Layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:Session];
    [self.view.layer addSublayer:Layer];
    Layer.frame = self.view.frame;
    AVCaptureVideoDataOutput *Outpput = [[AVCaptureVideoDataOutput alloc] init];
    [Outpput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [Session addOutput:Outpput];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
   //NSLog(@"%@",request);
    CVPixelBufferRef pixcelref = CMSampleBufferGetImageBuffer(sampleBuffer);
    NSLog(@"%@",sampleBuffer);
    Resnet50 *Resnet = [[Resnet50 alloc] init];
   
    VNCoreMLModel *VNMomodel = [VNCoreMLModel modelForMLModel:[Resnet model] error:nil];
    VNCoreMLRequest *Request = [[VNCoreMLRequest alloc] initWithModel:VNMomodel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        
       NSLog(@"called");
        printf("%s",[[NSString stringWithFormat:@"%@",request.results.firstObject] UTF8String]);
    }];
    
    
    
    

    NSDictionary * dict;
   
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:pixcelref options:dict];
    [handler performRequests:@[Request] error:nil];
  
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
