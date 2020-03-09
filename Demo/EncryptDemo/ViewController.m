//
//  ViewController.m
//  EncryptDemo
//
//  Created by Chen Yiliang on 2020/3/5.
//  Copyright © 2020 cyl. All rights reserved.
//

#import "ViewController.h"
#import "CYKeychain.h"
#import "NSString+CYEncrypt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"User Home: %@", NSHomeDirectory());
    
    NSString *originStr = @"apple";
    NSLog(@"%@ MD5: %@", originStr, originStr.md5);
    NSLog(@"%@ SHA256: %@", originStr, originStr.sha256);
    
    NSString *key = @"123";
    NSString *iv = @"abc";
    NSString *enpryptedStr = [originStr DESEncryptWithKey:key];
    NSLog(@"%@ DES enprypted string: %@", originStr, enpryptedStr);
    
    originStr = [enpryptedStr DESDecryptWithKey:key];
    NSLog(@"%@ origin string: %@", enpryptedStr, originStr);
    
    enpryptedStr = [originStr DESEncryptWithKey:key iv:iv];
    NSLog(@"%@ DES iv: %@, enprypted string: %@", originStr, iv, enpryptedStr);
    
    originStr = [enpryptedStr DESDecryptWithKey:key iv:iv];
    NSLog(@"%@ iv: %@, origin string: %@", enpryptedStr, iv, originStr);
    
    enpryptedStr = [originStr AESEncryptWithKey:key];
    NSLog(@"%@ AES enprypted string: %@", originStr, enpryptedStr);
    
    originStr = [enpryptedStr AESDecryptWithKey:key];
    NSLog(@"%@ origin string: %@", enpryptedStr, originStr);
    
    enpryptedStr = [originStr AESEncryptWithKey:key iv:iv];
    NSLog(@"%@ AES iv: %@, enprypted string: %@", originStr, iv, enpryptedStr);
    
    originStr = [enpryptedStr AESDecryptWithKey:key iv:iv];
    NSLog(@"%@ iv: %@, origin string: %@", enpryptedStr, iv, originStr);
    
    [self testRSA];
    
    [self testKeychain];
}

- (void)testRSA {
    NSString *publicKey = @"-----BEGIN PUBLIC KEY-----\
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCxuWhp6EgQfrrSBtxlBwbU35lh\
    jC67X0Y1KrhqolIfYo3/yWV1eryYVUhk5xeHsbKg9RHD9TpIZRUWIW5a8MrMBcgr\
    1A/dgIHi2EM28drH4JRTmkTLVHReggFbb046k0ISpLW3XVW0jHB3/z3S1c/NT9V6\
    3SQK6WJ65/YP5xISNQIDAQAB\
    -----END PUBLIC KEY-----";
    NSString *privateKey = @"-----BEGIN PRIVATE KEY-----\
    MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALG5aGnoSBB+utIG\
    3GUHBtTfmWGMLrtfRjUquGqiUh9ijf/JZXV6vJhVSGTnF4exsqD1EcP1OkhlFRYh\
    blrwyswFyCvUD92AgeLYQzbx2sfglFOaRMtUdF6CAVtvTjqTQhKktbddVbSMcHf/\
    PdLVz81P1XrdJArpYnrn9g/nEhI1AgMBAAECgYBEbsMAvLs69sFS6+djU1BTGYIC\
    6Kp55ZawFDIMhVIf2aAZ1N+nW8pQ0c3dZIpP6qGAjrz3em6lv55d9iN7Cura/g57\
    Rk4S3SRo5u4hWUd16NeIVP+HfreKIgZ6jwKQTfXt2KzDuIAHudvwT2UJBePgIIDQ\
    oKMEq4khtFiRGS1UgQJBAN/KpSOiRiGup8h/Iqespwfxyrqn5/4iyw1tpJCWzHdd\
    P7nJGpYmOL+ELWs/pReYclAOqH9ZIzOT2K8ZLt6yBOECQQDLTXZowK8wFgMudAE5\
    TStC/zl3TAKMu/Gu5wlXSMoa+nwSy/FSIQZyypGeHR2X8QhbZ1Qz+uBCJm7gEGOW\
    MWPVAkEAp5ajsFm3V0XqE/VRSGu88fAaN0nCK8h2cunm0Ph8ye6k6EY3iLW6zYD4\
    WlZhFZhuEpHHkQZ5nAhdvlKHjPGXQQJAYOtF1rx9B/SGgb/F0ZZrWF4p/ChdUtBK\
    cHIt7tGBoAjn22IkYl3iIBlYAEOrFwNOU5zX9IvWG1MNKn5Fq5VSHQJBAJG5xSY0\
    IKzXWDsGnPIa9XlSTv1zl7RCGNDo7O1zh+5J/kjDpU9M2fIXEtzvGYHiOffz9FBh\
    5ka69JJNFWoWAiw=\
    -----END PRIVATE KEY-----";
    
    NSString *originStr = @"apple";
    NSString *encryptedStr = [originStr RSAEncryptWithKey:publicKey];
    NSLog(@"%@ RSA encrypted string: %@", originStr, encryptedStr);
    
    originStr = [encryptedStr RSADecryptWithKey:privateKey];
    NSLog(@"RSA encrypted origin string: %@", originStr);
}

- (void)testKeychain {
    NSString *account = @"apple";
    NSString *password = @"123456";
    NSError *error = nil;
    BOOL result = [CYKeychain storePassword:password withAccount:account error:&error];
    NSLog(@"keychain add result: %@, error: %@", result ? @"success" : @"fail", error);
    
    error = nil;
    password = [CYKeychain getPasswordWithAccount:account error:&error];
    NSLog(@"keychain get result: %@, error: %@", password, error);
    
    password = @"abcdef";
    error = nil;
    result = [CYKeychain storePassword:password withAccount:account error:&error];
    NSLog(@"keychain update result: %@, error: %@", result ? @"success" : @"fail", error);
    
    error = nil;
    password = [CYKeychain getPasswordWithAccount:account error:&error];
    NSLog(@"keychain get updated result: %@, error: %@", password, error);
    
    error = nil;
    result = [CYKeychain deletePasswordWithAccount:account error:&error];
    NSLog(@"keychain delete result: %@, error: %@", result ? @"success" : @"fail", error);
    
    error = nil;
    password = [CYKeychain getPasswordWithAccount:account error:&error];
    NSLog(@"keychain get result: %@, error: %@", password, error);
}

@end
