//
//  FeedPost.m
//  APITest
//
//  Created by Admin on 07.11.16.
//  Copyright © 2016 Galiev Danil. All rights reserved.
//





#import "NewsFeedPost.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsFeedPost

- (id)initWithServerResponse:(NSArray*) responseObject
{
    
    self = [super init];
    if (self) {
        
   
        
        NSDictionary* itemData = [[NSDictionary alloc]initWithDictionary:[responseObject objectAtIndex:0]];
        
        NSDictionary* ownerData = [[NSDictionary alloc] initWithDictionary:[responseObject objectAtIndex:1]];
        
        NSArray* attachments = [[NSArray alloc] initWithArray:[itemData objectForKey:@"attachments"]];
        
        self.photosArray = [NSMutableArray array];

        
       // NSLog(@"attachments array = %@", attachments);
        
        
        self.likeCount = [[itemData objectForKey:@"likes"] objectForKey:@"count"];
        self.shareCount = [[itemData objectForKey:@"reposts"] objectForKey:@"count"];
    
        self.ownerPost = [ownerData objectForKey:@"name"];
        
        self.textPost = [itemData objectForKey:@"text"];
        
        NSString* stringURL = [ownerData objectForKey:@"photo_100"];
        
        if (stringURL) {
            self.ownerImageURL = [NSURL URLWithString:stringURL];
        }
        
        
        
        
        for (NSDictionary* obj in attachments) {
            
            NSString* tempString;
            
//            if ([obj objectForKey:@"link"] != nil) {
//                
//                NSDictionary* tempDict = [obj objectForKey:@"link"];
//                tempString = [[tempDict objectForKey:@"photo"] objectForKey:@"photo_604"];
//                
//            } else
            tempString = [[obj objectForKey:@"photo"] objectForKey:@"photo_604"];
            
            
            
            if (tempString != nil) {
                
                [self.photosArray addObject:tempString];
                
                //NSLog(@"photos array count = %ld", (unsigned long)[self.photosArray count]);
                
                //NSLog(@"photos array = %@", self.photosArray);
                
                self.postImageURL = [NSURL URLWithString:[self.photosArray firstObject]];
                
   
            }
            
            
            NSLog(@"URL = %@", self.postImageURL);

            
            NSURLRequest* postImageRequest = [NSURLRequest requestWithURL:self.postImageURL];
            
            NSLog(@"URL request = %@", postImageRequest);
            
            self.postPhoto = [[UIImageView alloc] init];
            
            UIImageView* tempImageView = self.postPhoto;
            
            NSLog(@"self postPhoto before block = %@", self.postPhoto);
            NSLog(@"tempImageView = %@", tempImageView);
        
            


            
            [tempImageView
             setImageWithURLRequest:postImageRequest
             placeholderImage:nil
             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                 

                 self.postPhoto.image = image;
                 
                 NSLog(@"image in block = %@", image);
                 
                 NSLog(@"postPhoto in block = %@", self.postPhoto);
                 
                 

                 
                 
                 /*
                 UIImage *bgImage = [UIImage imageNamed:@"Default@2x.png"];
                 UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:bgImage];
                 */


                 
             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                 NSLog(@"Getting postOwner image failed");
             }];
            
            self.postPhoto = tempImageView;
            
            if (self.postPhoto == nil) {
                
                NSLog(@"RAVNO NIIIIIL");
                
            
            } else NSLog(@"VIEW EXIST");
            

            

            
            //NSLog(@" type = %@", [obj objectForKey:@"type"]);
        }
        
  

      
        
    }
    
    return self;
    
}

@end
