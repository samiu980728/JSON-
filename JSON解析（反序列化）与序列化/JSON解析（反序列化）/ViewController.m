//
//  ViewController.m
//  JSON解析（反序列化）
//
//  Created by 萨缪 on 2018/8/11.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ViewController.h"

//**********确保透明传输的安全性

@interface ViewController ()

@end

@implementation ViewController

//触碰任意地方触发事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self jsonToOC];
    //[self ocToJSON];
}


//OC类型转化成JSON类型
- (void)ocToJSON
{
    //并不是所有的OC对象都支持转化为JSON
    //注意 **** 不可以进行字符串的转化
    NSDictionary * dict = @{@"name":@"xiaomming",@"age":@25};
    
    //用一个方法判断是否可以将该OC对象转化为JSON
    if ( ![NSJSONSerialization isValidJSONObject:dict] ){
        NSLog(@"该对象不支持转换");
    }
    
    //参数1：要序列化的OC对象  2：附加选项 kNilOptions 表示为0
    //3.错误信息 nil
    //返回JSON的二进制数据
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    
    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

//JSON类型转化成OC类型
- (void)jsonToOC
{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/forecast?location=beijing&key=70c5ee7d3a214fefaee2fc9ca8eeb52f"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //处理服务器返回的数据
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //或者使用JSON进行解析(反序列化处理) JSONData -> OC中对象(字典或数组)
        //Serialization 序列化工具
        //参数1：要解析的JSON按键数据 2：解析数据时候的附加选项 默认传0:kNilOptions
        //3：错误信息
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSLog(@"%@--%@",[dict class],dict);
        NSLog(@"HeWeather6[0] %@",[dict objectForKey:@"HeWeather6"][0]);
        NSLog(@"%@",[[dict objectForKey:@"HeWeather6"][0] objectForKey:@"basic"]);
        //NSLog(@"%@",[[[dict objectForKey:@"HeWeather6"][0] objectForKey:@"basic"][0] objectForKey:@"admin_area"]);
        
        NSLog(@"%@", dict[@"HeWeather6"][0][@"daily_forecast"][0][@"cond_txt_d"]);
        //NSLog(@"dict[HeWeather6][0][status][0] = %@",dict[@"HeWeather6"][0][@"status"]);
        NSLog(@"dict[HeWeather6][0][update][1] = %@",dict[@"HeWeather6"][0][@"update"][@"utc"]);
        NSString * str = dict[@"HeWeather6"][0][@"update"][@"utc"];
        NSLog(@"str = %@",str);
        
        
//        NSLog(@"%@", obj);
//
//        NSLog(@"%@", [[obj objectForKey:@"HeWeather6"][0] objectForKey:@"basic"]);
//
//        NSLog(@"%@", obj[@"HeWeather6"][0][@"daily_forecast"][0][@"cond_txt_d"]);
//    }
//
        //想让一个字典的数据为空 ,key不为空 那么数据不能传nil 要传 [NSNULL null]
        
        //复杂json数据的处理方式
        //法 1 写文件
        [dict writeToFile:@"/Users/samiu/Desktop/nice.plist" atomically:YES];
        
        //法 2 直接在线格式化
        //在 在线解析json格式 的网站格式化
        
        
        //输出分类
        //id obj = [[dict objectForKey:@"HeWeather6"] objectForKey:@"basic"];
        //NSLog(@"obj = %@",obj);
        
        //获取所有的key
//        NSArray * keyArray = [dict allKeys];
//        NSLog(@"keyArray = %@",keyArray);
//        NSArray * valueArray = [dict allValues];
//        NSLog(@"valueArray = %@",valueArray);
//        NSLog(@"count = %li",[valueArray count]);
        
        NSMutableArray * dataSourceProvinceArray = [[NSMutableArray alloc] init];
//        NSArray * arr = [dict valueForKey:@"HeWeather6"];
//        NSLog(@" arr = %@",arr);
//        for (NSDictionary * dic in arr[0]) {
//            NSArray * strArray = [[NSArray alloc] init];
//            [strArray setValuesForKeysWithDictionary:dic];
//            NSLog(@"%@, ",strArray);
//        }
        //过滤词典
//        NSArray * arrNcieArray = [dict objectForKey:@"HeWeather6"];
//        NSLog(@")
        
        
        
        
    }] resume];
}

//保存假数据的方法
- (void)other
{
//    1. 加载数据
    NSString * stu = [[NSBundle mainBundle] pathForResource:@"https://free-api.heweather.com/s6/weather/forecast?location=beijing&key=70c5ee7d3a214fefaee2fc9ca8eeb52f" ofType:nil];
    NSArray * array = [NSArray arrayWithContentsOfFile:stu];
    
    // 2 把数据以JSON方式保存
    //写plist文件的方法
    //[array writeToFile:@"/Users/samiu/Desktop/123.plist" atomically:YES];
    
    //JSON：需要先把OC对象转换成JSON的二进制数据 然后再写文件
    
    //附加条件options：NSJSONWritingPrettyPrinted 用来排版 美化结构
   NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    // 3 写文件
    [jsonData writeToFile:@"/Users/samiu/Desktop/123.json" atomically:YES];
    
}

- (void)other2
{
   
    // 1 加载数据
    NSString * stu = [[NSBundle mainBundle] pathForResource:@"123.json" ofType:nil];
    
    NSData * jsonData = [NSData dataWithContentsOfFile:stu];
    // 2 jsonData -> OC对象
    NSArray * array = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    
    //这种方法不能加载json数据 因为json数据本质上并不是一个数组 而是一个json字符串
   // NSString * stu = [[NSBundle mainBundle] pathForResource:@"123.json" ofType:nil];
    NSArray * array1 = [NSArray arrayWithContentsOfFile:stu];
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
