//
//  LARSimplePDFViewController.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 20/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "LARSimplePDFViewController.h"
#import "LARBook.h"
#import "LARPdf.h"
#import "LARAnnotationsViewController.h"
#import "LARAnnotation.h"

@interface LARSimplePDFViewController ()

@end

@implementation LARSimplePDFViewController

-(id)initWithModel:(LARBook *) book andContext: (NSManagedObjectContext *) context{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = book;
        _context = context;
        
        NSMutableString *title = [[NSMutableString alloc] init];
        [title appendString:book.title];
        [title appendString:@" - PDF"];
        
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    [self syncWithModel];
    
    
    // Alta en notificaciones de library
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:@"AGTBOOK_DID_CHANGE_NOTIFICATION"
             object:nil];
     
}

#pragma mark - Notificaciones
-(void) notifyThatBookDidChange:(NSNotification *) notification{
    
    
    // sacamos el nuevo libro
    LARBook *newBook = [notification.userInfo objectForKey:@"BOOK"];
    self.model = newBook;
    [self syncWithModel];
    
}

#pragma mark - Util
-(void) syncWithModel{

    NSMutableString *nombrePdf = [[NSMutableString alloc] init];
    [nombrePdf appendString:@"Documents/HackerBook/Data/"];
    [nombrePdf appendString:self.model.title];
    [nombrePdf appendString:@".pdf"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString  *pdfFile = [NSHomeDirectory() stringByAppendingPathComponent:nombrePdf];
    
    if (![fileManager fileExistsAtPath:pdfFile]){
        
        LARPdf *pdf = [NSEntityDescription insertNewObjectForEntityForName:@"PDF"
                                                    inManagedObjectContext:self.context];
        
        UIImage* image = [UIImage imageNamed:@"emptyBookCover.png"];
        pdf.pdfData = UIImageJPEGRepresentation(image, 0.9);
        pdf.pdfUrl = self.model.pdf.pdfUrl;
        
        self.model.pdf = pdf;
        
        [self downloadPdf:pdf withNSManagedObjectContext: self.context];
        
    }else{
        // El fichero ya está cacheado en local, lo leemos
        
        NSString  *pdfFile = [NSHomeDirectory() stringByAppendingPathComponent:nombrePdf];
        
        NSData *data =[NSData dataWithContentsOfFile:pdfFile];
        
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        
        [self.pdfView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
        
        
    }
    

}

-(void) downloadPdf: (LARPdf *) pdf withNSManagedObjectContext: (NSManagedObjectContext *) context{
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0),
                   ^{
                       NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pdf.pdfUrl]];
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           // Lo hago en primer plano para asegurarme de
                           // todas las ntificaciones van en la ocla
                           // principal
                           [LARPdf setNewImageWithData:data intoPdf: pdf andNSManagedObjectContext: context];
                           
                           self.activityView.hidden = YES;
                           [self.activityView stopAnimating];
                           
                           [self.pdfView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
                           
                       });
                   });
    
}



-(NSURL*)documentsDirectory{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSURL *docs = [[fm URLsForDirectory:NSDocumentDirectory
                              inDomains:NSUserDomainMask] lastObject];
    return docs;
}

-(NSURL *) localURLForRemoteURL:(NSURL*) remoteURL{
    
    NSString *fileName = [remoteURL lastPathComponent];
    NSURL *local = [[self documentsDirectory] URLByAppendingPathComponent:fileName];
    
    return local;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)displayAnnotations:(id)sender{
    
    
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



@end
