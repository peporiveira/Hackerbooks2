//
//  LARBooksViewController.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 15/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "LARBooksViewController.h"
#import "LARBook.h"
#import "LARLibraryViewController.h"
#import "LARPhoto.h"
#import "LARTag.h"
#import "LARSimplePDFViewController.h"
#import "LARAnnotationsViewController.h"
#import "LARAnnotation.h"

@interface LARBooksViewController ()

@end

@implementation LARBooksViewController


-(id) initWithFetchResultController:(NSFetchedResultsController *) fetchedResultsController{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _fetchedResultsController = fetchedResultsController;
    }
    
    return self;
}

-(id) initWithModel:(LARBook *) model andFetchResultController:(NSFetchedResultsController *) fetchedResultsController{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
         _model = model;
        _fetchedResultsController = fetchedResultsController;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photo.image = [UIImage imageWithData:self.model.photo.photoData];
    self.authors.text = self.model.authorsWithNameAndSeparate;
    self.tags.text = self.model.tagsWithNameAndSeparate;
    
    //Muestro los campos
    
    //[self showDataInView];
    
    
    
    //Detectamos el tipo de pantalla
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        [self.authors setFont:[UIFont fontWithName:@"Arial" size:10]];
        [self.tags setFont:[UIFont fontWithName:@"Arial" size:10]];
        
    }
    
    //[self hiddenPortada];

    
    if (self.model.isFavoriteValue) {
        UIImage *butYe = [[UIImage imageNamed:@"starYe.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.favorite setImage:butYe forState:UIControlStateNormal];
    }else{
        //Añado la imagen al boton
        UIImage *butBla = [[UIImage imageNamed:@"starBla.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.favorite setImage:butBla forState:UIControlStateNormal];
    }
    
    //Si estoy dentro de un SpliVC me pongo el botón
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
-(void) libraryTableViewController:(LARLibraryViewController *)library didSelectedBook:(LARBook *)book{
    
    //Actualizo el modelo
    self.model = book;
    
    //Muestro los campos
    //[self showDataInView];
    
    //sync modelo y vista
    
    if (self.model.isFavoriteValue) {
        UIImage *butYe = [[UIImage imageNamed:@"starYe.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.favorite setImage:butYe forState:UIControlStateNormal];
    }else{
        //Añado la imagen al boton
        UIImage *butBla = [[UIImage imageNamed:@"starBla.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.favorite setImage:butBla forState:UIControlStateNormal];
    }
    
    //[self hiddenPortada];
    
    self.photo.image = [self.model.photo image];
    self.authors.text = self.model.authorsWithNameAndSeparate;
    self.tags.text = self.model.tagsWithNameAndSeparate;
    
    //Actualizo el titulo del libro en el NavigationC
    self.title = self.model.title;
}


-(IBAction)displayPdf:(id)sender{
    
    // Crear un PDFVC
    LARSimplePDFViewController *pdfVC = [[LARSimplePDFViewController alloc]
                                         initWithModel:self.model andContext:self.fetchedResultsController.managedObjectContext];
    // Hacer un push
    [self.navigationController pushViewController:pdfVC
                                         animated:YES];
    
}

-(IBAction)displayAnnotation:(id)sender{
    
    //Un fetchRequest
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:[LARAnnotation entityName]];
    fetchReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:LARAnnotationAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    fetchReq.fetchBatchSize = 20;
    fetchReq.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.model];
    
    //FetchRequestController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReq managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Crear un PDFVC
    LARAnnotationsViewController *annVC = [[LARAnnotationsViewController alloc]
                                           initWithFetchedResultsController:fc style:UITableViewStylePlain book:self.model];
    // Hacer un push
    [self.navigationController pushViewController:annVC
                                         animated:YES];
    
}

-(IBAction)markFavorite:(id)sender{
    
#warning Solucionnnnnnnnnnnn provicional. Ver porque falla si no pongo el delegado a nil cuando se actualizan los datos.
    self.fetchedResultsController.delegate  = nil;
    
    UIButton *button = (UIButton *)sender;
    LARBook *book = self.model;
    
    if (!book.isFavoriteValue) {
        UIImage *butYe = [[UIImage imageNamed:@"starYe.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImage:butYe forState:UIControlStateNormal];
        self.model.isFavoriteValue = YES;
        
        //Añado al tag una referencia al book
        [LARTag addTagFavoriteWithBook:book andManagedObjectContext:self.fetchedResultsController.managedObjectContext];
        
        
    }else{
        //Añado la imagen al boton
        UIImage *butBla = [[UIImage imageNamed:@"starBla.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImage:butBla forState:UIControlStateNormal];
        book.isFavoriteValue = NO;
        
        [LARTag removeBook:book InFavoriteWithManagedObjectContext:self.fetchedResultsController.managedObjectContext];
    }
    
    
    NSError *error;
    [self.fetchedResultsController.managedObjectContext save:&error];
    
    NSError *errorPerform;
    [self.fetchedResultsController performFetch:&errorPerform];
    [self.fetchedResultsController setValue:[self.fetchedResultsController fetchedObjects] forKey:@"sections"];
    
    [self setupNotifications];

    
}


#pragma mark - Notifications
-(void) setupNotifications{
    
    NSNotification *n = [NSNotification
                         notificationWithName:@"CHANGE_BOOKS_IN_TAGS"
                         object:self
                         userInfo:@{@"bookFavorite" : self}];
    
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
}
@end
