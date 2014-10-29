//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088111757259877"
//收款支付宝账号
#define SellerID  @"15021195612@163.com "

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"dp35kdtn1o2a0nvhwz9hoijgarubb13o"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMmo996WETG5EbeWIBGP2/2IdoTCz/2RLNgf7Ub5Owt9ug6lVsguauuqEGsBbfrHPPxsKDYsfaprzENY3IeYis3/j4FiSxlc+wKwQ9b3+TrtoOLZgtSyF5MljeQFVIxtl7R7M60zLv7pZSHJl+Lmy1UXJBm2+xblqoio+0NHVUbNAgMBAAECgYEAjF5S+trWaRf7XyDefZr3dEjyxoKcKFJPNrkyfn6pPNxtEBjCiWDWB+g+uV0rYq4go0vdyae6aU/TxOUrzC7AHloj8RfgHM0qFEI+XC/2CVM5ezszvy5iCvwAW0K2ov/90S2HBmwagrfTUskE8svUYZ25lhnae0CTlP2g9JoVewECQQD5QZU8KWIC2ZnPltIN8Yy/1FQt6nkyTBQaJs3gk6p5ucjU/R3tdCpKbXxzJVLUm7wsXpY+BhGUAslA7dr+k88hAkEAzx24oispqF2VNY6IixDGidEwqyEmJCtiJLc3WSsdsUid+WEQWWCN4GDl0Mljz9YdRuCQQmVOnVfCXNn6tpQeLQJBAIKRIjWDj/3iMroVTS9UquAJv5bVzmrUg2s3jHzpnVFqSpOXi8fJJCYcuCYxFPSeJ7IuUhFnaGnaE8ZZUnAsyUECQQC3i/BXDwdQ5PZZSyJok4pPEmseDTd+8E9+mDvdst8SgHc3TLSvcGjrQxQHbqIcyvSRHmvZ22vK9r4RiT+tVCBVAkATEnGpe2zQvD77ZFend0rvlAGRXFBbem8XYiM1Dv/FmuIt7LfwWqWFkPciJMFK7cGNobnmeM9c+s2V0aZrqHrY"

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
