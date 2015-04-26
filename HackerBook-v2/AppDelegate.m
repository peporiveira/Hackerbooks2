//
//  AppDelegate.m
//  HackerBook-v2
//
//  Created by Luis Aparicio on 13/04/2015.
//  Copyright (c) 2015 Luis Aparicio. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "LARBook.h"
#import "LARLibraryViewController.h"
#import "UIViewController+Navigation.h"
#import "LARBooksViewController.h"
#import "LARTag.h"

@interface AppDelegate ()
@property (nonatomic, strong) AGTCoreDataStack *stack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    //Creamos una instancia del stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    //Descargamos los datos y Creamos el modelo
    
    //Valor por defecto para saber si es la primera vez
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if (![def objectForKey:@"firstTime"]) {
        
        //Descargo JSON
        [self didRecieveData];
        
        
        //Guardamos un valor por defecto
        [def setObject:@"1" forKey:@"firstTime"];
        
        //Por si acaso...
        [def synchronize];
    }else{
        
        //Compruebo si existe el fichero. si no existe lo descargo
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString  *jsonFile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/HackerBook/Data/JSON.txt"];
        
        if (![fileManager fileExistsAtPath:jsonFile]){
            
            [self didRecieveData];
            
        }
    }
    
    //Un fetchRequest
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:[LARTag entityName]];
    fetchReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:LARTagAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    fetchReq.fetchBatchSize = 20;
    
    //FetchRequestController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchReq managedObjectContext:self.stack.context sectionNameKeyPath:nil cacheName:nil];
    
    //Detectamos el tipo de pantalla
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        //Tipo tableta
        [self configureForPadWithFetchedResultsController: (NSFetchedResultsController *) fc];
    }else{
        
        //Tipo teléfono
        [self configureForPhoneWithFetchedResultsController: (NSFetchedResultsController *) fc];
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    
    //Debemos de guardar los datos
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void) didRecieveData{
    
    NSURL *urlJson = [NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"];
    
    NSData *data = [NSData dataWithContentsOfURL:urlJson];
    
    [self saveDataIntoSandbox: (NSData *) data];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    [self cargarDatosEnModelo: (NSDictionary *) json];
}

-(void) saveDataIntoSandbox: (NSData *) data{
    
    NSString  *folderHackerBook = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/HackerBook/Data/"];
    NSError *err;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:folderHackerBook withIntermediateDirectories:YES attributes:nil error:&err];
    
    NSMutableString *namFile = [[NSMutableString alloc] init];
    [namFile appendString:@"Documents/HackerBook/Data/"];
    [namFile appendString:@"JSON.txt"];
    
    NSString *jsonFile = [NSHomeDirectory() stringByAppendingPathComponent:namFile];
    
    
    
    [data writeToFile:jsonFile atomically:YES];
    
}


-(void) cargarDatosEnModelo: (NSDictionary *) json{
    
    
    NSDictionary *dictobj = json;
    for (id key in dictobj)
    {
        NSDictionary *value = key;
        
        [LARBook initWithTitulo:[value objectForKey:@"title"]
                                     isFavorite:NO
                                         author:[value objectForKey:@"authors"]
                                           tags:[value objectForKey:@"tags"]
                                            pdf:[value objectForKey:@"pdf_url"]
                                       urlPhoto:[value objectForKey:@"image_url"]
                                        context:self.stack.context];
        
        // Guardar
        [self.stack saveWithErrorBlock:^(NSError *error) {
            NSLog(@"¡Error al guardar! %@", error);
        }];
    }

}

-(void) configureForPadWithFetchedResultsController: (NSFetchedResultsController *) fc{
    
    //Creamos los controladores
    LARLibraryViewController *libraryVC = [[LARLibraryViewController alloc] initWithFetchedResultsController:fc style:UITableViewStylePlain];
    LARBooksViewController *booksVC = [[LARBooksViewController alloc] initWithFetchResultController:fc];
    
    
    //Creo el Combinador
    UISplitViewController *split = [[UISplitViewController alloc] init];
    
    [split setViewControllers:@[[libraryVC wrappedInNavigation],[booksVC wrappedInNavigation]]];
    
    //Asignamos delegados
    split.delegate = booksVC;
    libraryVC.delegate = booksVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = split;
    
}

-(void) configureForPhoneWithFetchedResultsController: (NSFetchedResultsController *) fc{
    
    
    
    //Creo el controlador
    LARLibraryViewController *libraryVC = [[LARLibraryViewController alloc] initWithFetchedResultsController:fc style:UITableViewStylePlain];
    
    //Creo el combinador
    UINavigationController *navLib = [UINavigationController new];
    
    [navLib pushViewController:libraryVC animated:NO];
    
    //Asigno delegado
    libraryVC.delegate = libraryVC;
    
    //La pinto
    self.window.rootViewController = navLib;
    
    
}

@end
