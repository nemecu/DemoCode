//
//  ViewController.m
//  allRow
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-10.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize lableStatus;
@synthesize textInputPath;
@synthesize lableResult;
@synthesize fileListArr;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fileListArr = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
//    [self getAllLine];
    
}

- (void)getAllLine:(NSString *)filePath{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
     
    NSString * stringContent = [[NSString alloc] initWithContentsOfFile:filePath
                                                               encoding:NSUTF8StringEncoding
                                                                  error:NULL];
    NSLog(@"stringContent:%@\n\n\n\n",stringContent);
    NSArray *arr = [stringContent componentsSeparatedByString:@"\n"];
    NSLog(@"count%d\n\n\n,arr:%@",[arr count],arr);
}

//点击按钮
- (IBAction)actionCalculate:(id)sender {
    
    //清空文件列表数组
    if (self.fileListArr) {
        [self.fileListArr release];
        self.fileListArr = nil;
        self.fileListArr = [[NSMutableArray alloc] init];
    }
    
    NSString *textPath = self.textInputPath.text;
    
    //开始分析
    self.lableStatus.text = @"正在分析目录结构";
    [self startAnalysis:textPath];
    self.lableStatus.text = @"正在计算行数";
    //开始计算行
    [self startCalculate];
    self.lableStatus.text = @"计算完成";
    
    
}

- (void)test{
    int rr = 77777;
    NSLog(@"%d\n",rr);
}

//分析
- (void)startAnalysis:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO ;
    
    //判断路径的存在与类型：文件 或 文件夹
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        //路径存在
        if (isDirectory) {
            //路径为目录
            NSArray *arrTmp = [fileManager contentsOfDirectoryAtPath:path error:NULL];
            if ([arrTmp count] > 0) {
                NSLog(@"arr:%@\n",arrTmp);
                for (NSString *subPath in arrTmp) {
                    
                    
                    [self isDecisionWithDirectoryName:path andSubName:subPath];
                    
                }
                
            }else{
                NSLog(@"%@ 这个目录下不存在文件\n",path);
            }
            
        }else{
            //路径为文件
            [self isDecisionWithFilePath:path];
        }

        
    }else{
        //路径不存在
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"输入路径不存在"
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//匹配扩展名1
- (void)isDecisionWithFilePath:(NSString *)filePath{
    NSString *extention = [filePath pathExtension];
//    NSLog(@"subPath:%@,extention:%@\n",filePath,extention);
    
    if ([extention isEqualToString:@"h"] || [extention isEqualToString:@"m"]) {
        //在 扩展名范围内
        NSLog(@"%@ is file\n",filePath);
        [self.fileListArr addObject:filePath];
    }else{
        NSLog(@"%@ 这个文件扩展名 没有计算在内\n",filePath);
    }
    
//    NSLog(@"arrCount:%d\n",[self.fileListArr count]);
    
}

//匹配扩展名2
- (void)isDecisionWithDirectoryName:(NSString *)path andSubName:(NSString *)subPath{
    //此处有待扩展
    
    NSString *extention = [subPath pathExtension];
//    NSLog(@"subPath:%@,extention:%@\n",subPath,extention);
    
    if ([extention isEqualToString:@"jpg"] || [extention isEqualToString:@"png"]) {
        //在 扩展名范围内
        NSLog(@"%@ is file\n",subPath);
        [self.fileListArr addObject:[path stringByAppendingPathComponent:subPath]];
    }else if ([extention isEqualToString:@""]){
        //次为 目录
        NSLog(@"%@ is directory\n",subPath);
        //此处可以扩展为 是否 解析下级目录
        [self startAnalysis:[path stringByAppendingPathComponent:subPath]];
    }else{
        NSLog(@"%@ 这个文件扩展名 没有计算在内\n",subPath);
    }
    
//    NSLog(@"arrCount:%d\n",[self.fileListArr count]);
    

}

//开始计算行
- (void)startCalculate{
    int rowOfAllFile = 0;
//    NSLog(@"self.fileListArr:%@\n",self.fileListArr);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *filePath in self.fileListArr) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        NSData *originData = [NSData dataWithContentsOfFile:filePath];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.01f);
        
        NSString *imagePath = @"/Users/shaaowei/Desktop/resultImage";
//        self.textInputPath.text
        imagePath = [filePath stringByReplacingOccurrencesOfString:self.textInputPath.text
                                                        withString:imagePath];
        
        //处理目录
        NSMutableArray *arrDir = [NSMutableArray arrayWithArray:[imagePath componentsSeparatedByString:@"/"]];
        [arrDir removeLastObject];
        NSString *dirPath = [arrDir componentsJoinedByString:@"/"];
        NSError *error = nil;
        [fileManager createDirectoryAtPath:dirPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if (error) {
            NSLog(@"SW -error: %@",[error description]);
        }
        
//        BOOL isSucceed = [imageData writeToFile:imagePath atomically:YES];
        BOOL isSucceed = [fileManager createFileAtPath:imagePath
                                              contents:imageData
                                            attributes:nil];
        CGFloat result = (originData.length-imageData.length)/(CGFloat)originData.length;
        NSLog(@"SW - 写入结果：%d,缩小比例:%f",isSucceed,result);
        
        [pool release];
    }
    NSLog(@"\n\n\n################\n所有文件总行数%d\n",rowOfAllFile);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textInputPath resignFirstResponder];
}




//
//
//- (int)rows:(NSString *)filepath{
//    
//    char c;
//    
//    int  h = 0;
//    
//    FILE *fp;
//    
//    
//    
//    fp = fopen([filepath UTF8String], "r");
//    
//    
//    
//    if (fp == NULL)
//        
//        return -1;
//    
//    
//    
//    while ((c = fgetc(fp)) != EOF) {  
//        
//        if (c == '\n')
//            
//            h++;
//        
//        else {
//            
//            c = fgetc(fp);//这里处理最后一行可能没有换行标记 
//            
//            if (c == EOF){
//                
//                h++;
//                
//                break;
//                
//            } else if (c == '\n')
//                
//                h++;
//            
//        }
//        
//    }
//    
//    return h;
//    
//}
//
//
//- (BOOL)checkClassFile:(NSString *)filePath {
//    
//    
//    
//    NSString *extensionName = [filePath pathExtension];
//    
//    NSLog(@"后缀名%@", extensionName);
//    
//    if ([extensionName isEqualToString:@"h"] ||
//        
//        [extensionName isEqualToString:@"m"])
//        
//        return YES;
//    
//    return NO;
//    
//}
//
//
//- (NSArray *)GetAllDirInPath:(NSString *)inpath{
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSMutableArray *dirArray = [[NSMutableArray alloc] init]; 
//    
//    BOOL isDir = NO;
//    
//    [fileManager fileExistsAtPath:inpath isDirectory:(&isDir)];
//    
//    if (isDir == NO){
//        
//        if ([self checkClassFile:inpath])
//            
//            [dirArray addObject:inpath];
//        
//        
//        
//        return [dirArray autorelease];
//        
//    }
//    
//    
//    
//    isDir = NO;
//    
//    
//    
//    NSError *error = nil;
//    
//    NSArray *fileList = nil;
//    
//    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
//    
//    fileList = [fileManager contentsOfDirectoryAtPath:inpath error:&error];
//    
//    
//    
//    //在上面那段程序中获得的fileList中列出文件夹名
//    
//    for (NSString *file in fileList) {
//        
//        NSString *path = [inpath stringByAppendingPathComponent:file];
//        
//        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
//        
//        if (!isDir) {
//            
//            if ([self checkClassFile:path])
//                
//                [dirArray addObject:path];
//            
//        } else {
//            
//            [dirArray addObjectsFromArray:[self GetAllDirInPath:path]];
//            
//        }
//        
//        isDir = NO;
//        
//    }
//    
//    return [dirArray autorelease];
//    
//}
//
//
//- (IBAction)getNums:(id)sender {
//    
//    //获取路径
//    
//    NSString *path = [self.finderPath stringValue];
//    
//    NSLog(@"文件路径%@", path);
//    
//    //检查文件是否存在
//    
//    NSFileManager *filemanager = [NSFileManager defaultManager];
//    
//    if ([filemanager fileExistsAtPath:path]) {
//        
//        //获取路径
//        
//        int num = 0;
//        
//        NSArray *arr = [self GetAllDirInPath:path];
//        
//        
//        
//        for (NSString *inpath in arr) {
//            
//            num += [self rows:inpath];
//            
//        }
//        
//        NSLog(@"%d", num);
//        
//        [self.outPutField setStringValue:[NSString stringWithFormat:@"总行数: %d", num]];
//        
//    } else {
//        
//        [self.outPutField setStringValue:@"请输入正确的路径"];
//        
//    }
//    
//    
//    
//}







- (void)viewDidUnload
{
    [self setTextInputPath:nil];
    [self setLableResult:nil];
    [self setLableStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [fileListArr release];
    [textInputPath release];
    [lableResult release];
    [lableStatus release];
    [super dealloc];
}

@end
