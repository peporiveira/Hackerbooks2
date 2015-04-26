//
//  LARPhotoViewController.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 25/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "LARPhotoViewController.h"
#import "LARPhoto.h"
#import "LARAnnotation.h"
#import "LARBook.h"

@interface LARPhotoViewController ()

@end

@implementation LARPhotoViewController

#pragma mark - Init

-(id) initWithModel:(LARPhoto *) model andAnnotation: (LARAnnotation *) annotation andContext: (NSManagedObjectContext *) context{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        _context = context;
        _annotation = annotation;
    }
    
    return self;
}

#pragma mark - View Life cycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Me aseguro que la vista no ocupa toda la pantalla, sino lo que queda disponible dentro del navigation
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // sincronizo modelo -> vista
    self.photoView.image = self.model.image;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.model.image = self.photoView.image;
}


#pragma mark - Actions
- (IBAction)takePicture:(id)sender {
    
    //Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Uso la camara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        
        //Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    //Esto es como muestra la nueva vista. La animacion
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Lo muestro de forma modal
    [self presentViewController:picker animated:YES completion:^{
        
        //Esto se va a ejecutar cuadno termine la animación que muestra al picker.
        
    }];
    
}

- (IBAction)deletePhoto:(id)sender {
    
    
    // La eliminamos del modelo
    self.model.image = nil;
    
    //Actualizamos la vista
    CGRect oldRect = self.photoView.bounds;
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.photoView.alpha = 0;
        self.photoView.bounds = CGRectZero;
        self.photoView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    } completion:^(BOOL finished) {
        // sincronizo modelo -> vista
        
        self.photoView.transform = CGAffineTransformIdentity;
        self.photoView.alpha = 1;
        self.photoView.bounds = oldRect;
        self.photoView.image = nil;
        
    }];
    
    [self.context deleteObject:self.model];
    
    NSError *error;
    [self.context save:&error];
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //OJO! pico de memoria asegurado, especialmente en dispositivos antiguos
    //sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //La guardo en el modelo
    self.model.image = img;
    [self.model saveImage:img inAnnotation:self.annotation andContext:self.context];
    
    
    
    //Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES completion:^{
        //Se ejecutará cuando se haya ocultado del todo
        
    }];
}

@end
