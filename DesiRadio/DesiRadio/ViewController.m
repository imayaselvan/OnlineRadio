//
//  ViewController.m
//  DesiRadio
//
//  Created by imayaselvan r. on 30/06/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "PCSEQVisualizer.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property(nonatomic)AVPlayer *player;
@property(nonatomic)AVPlayerItem *playerItem;
@property(nonatomic)PCSEQVisualizer * visual;

@end

@implementation ViewController
- (IBAction)PlayBtnclicked:(id)sender {

    
    if ([self isPlaying]) {

        [self.visual stop];
        [self.player pause];
        [_PlayBtn setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
    }else{
        [self.player play];
        [self.visual start];
        [_PlayBtn setImage:[UIImage imageNamed:@"pausebutton"] forState:UIControlStateNormal];

        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _PlayBtn.enabled=NO;
    [_PlayBtn setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];

    [self loadData];
    [self setUpvisual];
    
    
}
-(void)loadData{
    NSString *path         =[[NSBundle mainBundle] pathForResource:@"Radio" ofType:@"plist"];
    self.stationDatas      =[NSDictionary dictionaryWithContentsOfFile:path];
    stationnames =[self.stationDatas allKeys];
    
}
-(void)setUpPlayerwithUrl:(NSURL *)url {
    
    if (self.playerItem) {
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        
    }else{
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    

    [self.player play];
    
    if ([self isPlaying]) {
        [self.visual start];
    }
}
-(void)setUpvisual {
    
    self.visual = [[PCSEQVisualizer alloc]initWithNumberOfBars:20];
    CGRect frame = self.visual.frame;
    frame.origin.x = (self.view.frame.size.width - self.visual.frame.size.width)/2;
    frame.origin.y = (VisualContainerView.frame.size.height - self.visual.frame.size.height)/2;
    self.visual.center =VisualContainerView.center;
    self.visual.frame = frame;
    [VisualContainerView addSubview:self.visual];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            [self.visual stop];
            
            
        } else if (self.player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            if ([self  isPlaying]) {
                [self.visual start];
                _PlayBtn.enabled=YES;
                

            }

            
        } else if (self.player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            [self.visual stop];
            
            
        }
    }
}
-(BOOL)isPlaying
{
    if (self.player.currentItem && self.player.rate != 0)
    {
        [_PlayBtn setImage:[UIImage imageNamed:@"pausebutton"] forState:UIControlStateNormal];

        return YES;
    }
    return NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stationDatas count];
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
    if ([self isPlaying]) {
        [self.player pause];
        [self.visual stop];

    }
    [self setUpPlayerwithUrl:[NSURL URLWithString:[self.stationDatas objectForKey:[stationnames objectAtIndex:indexPath.row]]]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [self.player removeObserver:self forKeyPath:@"status" context:nil];

}
@end
