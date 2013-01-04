//
//  CommonData.h
//  BaiduMapSW
//
//  Created by shaowei on 13-1-4.
//  Copyright (c) 2013年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#ifndef BaiduMapSW_CommonData_h
#define BaiduMapSW_CommonData_h


#ifdef Debug

#	define DLog(fmt, ...) NSLog((@"%@ [Line %d] " fmt), NSStringFromSelector(_cmd), __LINE__, ##__VA_ARGS__);
#else

#	define DLog(...)

#endif


#endif
