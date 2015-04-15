//
//  ProfileViewController.m
//  Vault_ClientFacingApp
//
//  Created by Harrison Ferrone on 4/9/15.
//  Copyright (c) 2015 Harrison Ferrone. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileHeader;

@property (weak, nonatomic) IBOutlet UIButton *profileSkillTreeToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *profileImageButton;

@property UIColor *customGrey;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *missionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentExpLabel;

@property UIImagePickerController *imagePickerController;
@property UIImage *profileImage;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customGrey = [UIColor colorWithRed:(34/255.0) green:(34/255.0) blue:(34/255.0) alpha:1.0];
    self.view.backgroundColor = self.customGrey;
    
    [self setDeveloperInfo];
    [self setDeveloperPhoto];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)setDeveloperInfo
{
    self.nameLabel.text = [NSString stringWithFormat:@"HARRISON"];
    self.classLabel.text = @"iOS";
    self.levelLabel.text = @"1";
    self.missionLabel.text = @"CODER";
    self.currentExpLabel.text = @"720";
}

-(void)setDeveloperPhoto
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [defaults dataForKey:@"profilePic"];
    UIImage *profilePic = [UIImage imageWithData:imageData];
    
    if (!profilePic)
    {
        [self.profileImageButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [self.profileImageButton setBackgroundImage:profilePic forState:UIControlStateNormal];
    }
}

- (IBAction)takeProfilePicture:(UIButton *)sender
{
    UIAlertView *photoFormat = [[UIAlertView alloc] initWithTitle:@"Your Picture" message:@"Choose from your Photo Library or take a picture on your Camera" delegate:self cancelButtonTitle:@"Dimiss" otherButtonTitles:@"Photo Library", @"Camera", nil];
    [photoFormat show];
}

#pragma mark - UIAlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Photo Library
    if (buttonIndex == 1)
    {
        [self photoFromLibrary];
    }
    //Camera
    else if(buttonIndex == 2)
    {
        //[self photoFromCamera];
    }
}

#pragma mark - UIImagePickerController Delegate Methods
-(void)photoFromLibrary
{
    self.imagePickerController = [UIImagePickerController new];
    self.imagePickerController.delegate = self;
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

//-(void)photoFromCamera
//{
//    self.imagePickerController = [UIImagePickerController new];
//    self.imagePickerController.delegate = self;
//    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
//    [self presentViewController:self.imagePickerController animated:YES completion:nil];
//}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.profileImage = info[UIImagePickerControllerOriginalImage];
    [self.profileImageButton setBackgroundImage:self.profileImage forState:UIControlStateNormal];
    
    NSData *savedProfilePicture = UIImageJPEGRepresentation(self.profileImage, 10);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:savedProfilePicture forKey:@"profilePic"];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
