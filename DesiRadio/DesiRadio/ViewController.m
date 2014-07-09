//
//  ViewController.m
//  DesiRadio
//
//  Created by imayaselvan r. on 30/06/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize URL;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    stationnames =[[NSArray alloc]initWithObjects:@"Thendral World Radio",@"Express Tamil Radio",@"HINDI FM",@"Vulaa Live Radio from USA",@"International Tamil Radio",@"Oli FM",@"First Tamil Radio from UK",@"Love Tamil Radio",@"TI FM Radio",@"Ungal tamil radio",@"Tamil flash fm",@"vegam tamil radio",@"Tamil Radio 24/7",@"vanavil fm",@"ROCK VAnavil",@"tamil aruvy", nil];
    StationURL =[[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];

    
    PlayerView=[[UIWebView alloc]init];
    [self.view addSubview:PlayerView];
    PlayerView.hidden=TRUE;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [stationnames count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        
    }
    
    cell.textLabel.text=[stationnames objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  
    self.URL  = [NSURL URLWithString:@"http://extamil.com/extamil.m3u"];
    [self Loadurl:self.URL];
}

-(void)Loadurl:(NSURL*)url{
    PlayerView.hidden=FALSE;
    PlayerView.backgroundColor=[UIColor redColor];
    request = [[NSURLRequest alloc] initWithURL:url];
    [PlayerView loadRequest:request];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
