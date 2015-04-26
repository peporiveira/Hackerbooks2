//
//  LARAnnotationsViewController.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "LARAnnotationsViewController.h"
#import "LARAnnotation.h"
#import "LARBook.h"
#import "LARPhoto.h"
#import "LARAnnotationViewController.h"

@interface LARAnnotationsViewController ()

@end

@implementation LARAnnotationsViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                              book:(LARBook *) book{
    
    if (self = [super initWithFetchedResultsController:aFetchedResultsController
                                                 style:aStyle]) {
        _model = book;
        
        NSMutableString *title = [[NSMutableString alloc] init];
        [title appendString:book.title];
        [title appendString:@" - Annotations"];
        
        self.title = title;
    }
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    //self.title = book.title;
    
    [self addNewNotebookButton];
    [self setupNotification];
    
    // Edit button
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar cual es la libreta
    LARAnnotation *nb = [self.fetchedResultsController
                       objectAtIndexPath:indexPath];
    
    // Crear una celda
    static NSString *cellID = @"notebookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:cellID];
    }
    
    // Configurarla (sincronizar libreta -> celda)
    UIImage *image = [UIImage imageWithData:nb.photo.photoData];
    cell.textLabel.text = nb.name;
    cell.imageView.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Devolverla
    return cell;
    
    
}





-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar la nota
    LARAnnotation *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    LARAnnotationViewController *nVC = [[LARAnnotationViewController alloc] initWithModel:note andContext:self.fetchedResultsController.managedObjectContext];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
    
}

#pragma mark - Notification

-(void) setupNotification{
    
    // Alta en notificaciones de library
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:@"AGTBOOK_DID_CHANGE_NOTIFICATION"
             object:nil];
    
}

-(void) notifyThatBookDidChange:(NSNotification *) notification{
    
    
    // sacamos el nuevo libro
    LARBook *newBook = [notification.userInfo objectForKey:@"BOOK"];
    self.model = newBook;
    [self syncWithModel];
    
}

-(void) syncWithModel{
    
    
    //Un fetchRequest
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:[LARAnnotation entityName]];
    fetchReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:LARAnnotationAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    fetchReq.fetchBatchSize = 20;
    fetchReq.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.model];
    
    //FetchRequestController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReq managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = fc;

    
    NSMutableString *title = [[NSMutableString alloc] init];
    [title appendString:self.model.title];
    [title appendString:@" - Annotations"];
    
    self.title = title;
    
    [self.tableView reloadData];
}

#pragma mark - Utils
-(void) addNewNotebookButton{
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self action:@selector(addNewAnnotation:)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}


#pragma mark -  Actions
-(void) addNewAnnotation:(id) sender{
    
    [LARAnnotation annotationWithName:@"New annotation" book:self.model context:self.fetchedResultsController.managedObjectContext];
    
    NSError *error;
    [self.fetchedResultsController.managedObjectContext save:&error];

}



@end
