//
//  LARAnnotationViewController.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "LARAnnotationViewController.h"
#import "LARAnnotation.h"
#import "LARPhotoViewController.h"
#import "LARPhoto.h"
#import "LARAnnotationsViewController.h"

@interface LARAnnotationViewController ()

@end

@implementation LARAnnotationViewController

#pragma mark - Init
-(id) initWithModel:(LARAnnotation *) model andContext: (NSManagedObjectContext *) context{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        _context = context;
    }
    
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Asignamos delegados
    self.titleAnnotation.delegate = self;
    
    // Fechas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    
    // Nombre
    self.title = self.model.name;
    
    self.titleAnnotation.text = self.model.name;
    
    // Texto
    self.textView.text = self.model.text;
    
    //Photo
    self.photoView.image = self.model.photo.image;
    
}


-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Baja en notificaciones
    //[self tearDownKeyboardNotifications];
    
    // Sincronizo vistas -> Modelo
    
    self.model.name = self.titleAnnotation.text;
    self.model.text = self.textView.text;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // Buen momento para validar el texto
    
    [textField resignFirstResponder];
    
    
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    // Buen momento para guardar el texto
    self.model.name = textField.text;
    
    NSError *error;
    
    [self.context save:&error];
}



#pragma mark - Actions
- (IBAction)displayPhoto:(id)sender {
  
    //Creamos el controlador
    LARPhotoViewController *pVc = [[LARPhotoViewController alloc]initWithModel:self.model.photo andAnnotation:self.model andContext:self.context];
    
    //Push
    [self.navigationController pushViewController:pVc animated:YES];
   
}

- (IBAction)displayShare:(id)sender{
    
}

- (IBAction)displayRemove:(id)sender{
    
    [self.context deleteObject:self.model];
    
    
    //Me muevo al controlador por encima
    //Buscar una forma mejor de hacer esto
    
}



@end
