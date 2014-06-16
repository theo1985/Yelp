//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpViewCell.h"
#import "YelpObject.h"

NSString * const kYelpConsumerKey = @"IOZuQChiwHkPZDxxHcYUcQ";
NSString * const kYelpConsumerSecret = @"dfXUHzu-uHqJfhTzn79BkBhOLrY";
NSString * const kYelpToken = @"NQn3BcSgDsVR7wMbVDCau0biZeoz-2SG";
NSString * const kYelpTokenSecret = @"hgTThwroTqeTk50PzclX2QGqbgo";

@interface MainViewController ()
{
    UISearchBar *searchBar;
    UIRefreshControl *refreshControl;
}

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *yelpResults;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

- (void)loadTableData;
- (void)onSettingsClick;

@end

@implementation MainViewController
@synthesize searchBar;
@synthesize refreshControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsClick)];
        barButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = barButtonItem;
        
        searchBar = [UISearchBar new];
        [searchBar sizeToFit];
        
        refreshControl = [[UIRefreshControl alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationItem.titleView = searchBar;
    
    self.tblView.dataSource = self;
    self.searchBar.delegate = self;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"YelpViewCell" bundle:nil] forCellReuseIdentifier:@"YelpViewCell"];
    
    [self.tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(loadTableData) forControlEvents:UIControlEventValueChanged];
    
    [self loadTableData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self loadTableData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.yelpResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpObject *yObject = [[YelpObject alloc] initWithDictionary:self.yelpResults[indexPath.row]];
    YelpViewCell *yCell = [tableView dequeueReusableCellWithIdentifier:@"YelpViewCell"];
    
    yCell.yelpObj = yObject;
    
    return yCell;
}

- (void)onSettingsClick
{
    // Animate to the SettingsViewController
    //[self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)loadTableData
{
    [self.client searchWithTerm:self.searchBar.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", self.searchBar.text);
        
        self.yelpResults = response[@"businesses"];
        
        [self.tblView reloadData];
        [refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

@end
