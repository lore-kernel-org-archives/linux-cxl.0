Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA91EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Jun 2023 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjF2RLI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Jun 2023 13:11:08 -0400
Received: from mail-tyzapc01olkn2064.outbound.protection.outlook.com ([40.92.107.64]:2262
        "EHLO APC01-TYZ-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229794AbjF2RLH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 29 Jun 2023 13:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPPLC0dw+VKMrJg0MO84acyHcID8EQNRLX4EGBxvaDzynHTYLbkcOu5zL2Kq5gHlfq+sn+rtzuYkTcEXT1sAkn6cnmvdk8cNfbWcNygWsESaPZLCJgeYmvMfrGCVkXioqn0JhNqQyaeAQYFSRQHOcy9gG8+0jJBhevZ0PsbX8P5hBb+ZUrK00DSDGbl2V8TFZF0SCq2MCcqWtv0fXvXBCWzToyQNQ5fhVTjGHZh/6xIBEDwNhUMn22JEyVIhl+tXdSqZuj1UVeHrB3BGRQcSIIVwIu/VonfS2rAdGck8Z35Jn3ImagjRJFLWmA+i6UdGrqG6s8u2oCKTG6iqf842tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3utBbDMuYIXIAAiKmnH/Zu4Gvdkh4l+IjuVYRaXoZo=;
 b=hvQ+I1kYyYH3Vhn1fACW/asR43Dv1G07gTn+4JFL6fu2HwGi7ltyJJx8mXTtCnv91NTHGYEmBi5X9H13pLJjfdXMlzA5DOssCboCFYi6pOeRTtGxVxCn4iPU3DeDLfIwP7cd3lMrDykoVVJFg87jwubXXcH+VGo/zHodB3grA4hZX5jvKYeGrqiwz+0GKmV89oSyPKyXHVDloSjIztlSqoYCRbCIQtUsUlOhg2QZiuRQraCj5GBcVXb4dNlneVzWKCTajszqoazXgV+lsDLCaHAeHX9lXwpzIxQZU03xTxUeQ9ie1qlXyvu+3qIW+L0hfB6lbk9OLL++AY2YdF0eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3utBbDMuYIXIAAiKmnH/Zu4Gvdkh4l+IjuVYRaXoZo=;
 b=mO4qijeC1ny24MggVgma/FWKPH7cRayRYr55dBdZgvNQA4Cyre3pCc7l+Gjqx74IAVhQecNXLZhvV9sBVViCFg/QIAy37Qo6BVyNk36mWHT0vDMLkFlZLqD/tDCTW0FMXOIaEa6qyRovEBvtF1tRcgO3owaUJI3hSJVgpPQjv5fXtAFuiQY9RHg8cqojxz1fhf+iYQgIPY0+qZYZq++gSUwcwAaW8t9rDeB3XKqr+0+ueJ1/R9jBa3QO3XkzRQd23MWmxJZXcpnNmeNrGTlmrWZOwLlBzP9z6sTyRXfNppJ7XjnJbgFripZyAtbwDgqJplX0RUzq4yCVjbzXB5gtCg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4162.apcprd06.prod.outlook.com (2603:1096:820:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.25; Thu, 29 Jun
 2023 17:11:02 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 17:11:02 +0000
Date:   Thu, 29 Jun 2023 10:10:48 -0700
From:   Fan Ni <nifan@outlook.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        nmtadam.samsung@gmail.com, nifan@outlook.com, fan.ni@samsung.com,
        jonathan.cameron@huawei.com
Subject: [Question] How to set up DVSEC CXL Range Registers for DCD devices
Message-ID: <SG2PR06MB339718DD083E76EEA06008F2B225A@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TMN:  [w9Pd2GfMWf3nvNB9jvYN6PUiNU87bkrv]
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJ27GNBCt0deif+/@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 696a5dff-55b6-4e80-a8a7-08db78c3d0fb
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmriMkceEMr8g4HVAclj/Oy91KhCAqydfuhamgd+p9e0lxtLro8ZY1IzNK55JRvRhP9BQBemSr5O9iQ0WATZKbN0PFy8P5LMHA8rDpllk5n1wUGy/RV7JAJ+Q3V97lBNM7qNHtU4jWUlT0r7EK+UyE7HGFP7UMMtdYcK5/oRU024GdxCUQdqVLGg8m97FV5ZiXBKez/qn0H2YhRtMu6l2jWoPLHwR3Xdai3BLWPPAThrqqjF+EARfkPvUrS5dfFhUDN0SBq7ijBhWUK+y2TMPH9JHxYZn7DPYlXeU5aWCWcsEzJuslS2YEkdcfRiHnxYlEiMYZ+603DGzR4H4CIA9ZnYuyBd8wWSmQEx8CuXgB+SAA8Q4hL3ZNYU1aeiGZSBiyf/bu/aE2YwFJLSFS99EF1unPUtEVvLvWI5mRTQnAdvG0ZmC52EQtyREgdGYkG3Y7iHR2O3ZzCpEKOCvFaL6yzv1Oj9VhYmMaLWKAHP62nd952PSwJ4LBwGtbjd5tQrjIxLByKwJjPawrA+jsPl9j+qgh+lCtf08O2JfPaYOKisPMXtsCWLc1KxnENd+AcOC7Eas0Io5phnnDU3SPo/BU1zU6MN6hhJ0sOdTsbqMVTDasiBomlFHLC5MtDmif/OzAQ68wi8o0Xz3wqfka5oCkkU4iE0SALn+WcqEpCYsdQQbbhCs58ApRrZplJYecvxI0j5hYREhLm3LZX0NXVyaQXiHpJFMNbD3uutSiP7bFDVHsm3Va40XF5t7ovy9JQ15Ho=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kF85t6stnfFU9EuVqyIoqEYLW46V8fswJtX+A/ubXgSnvs1z6RdIVuL67czY2deRRbZvkWLrT4r1KwdQt60C07rgzq1JmeigD8XUNReiY1hmDtGbWqpANwnTGY8M7sY/QQB4h1FXvBuULaM+ItSdXedPeW/hm3YdmVZ9Jm/UPyFOWe5TWHlcklxtlwzCXZKiyb1pSLbOIAxB2iZkP7bXmm4oDFyQXjCAg/J2k+cne4bSyppQ2hl9xFuTi9BbLKMD79XJrzR2rBh9EnZSuLHapwZ/ryXD2gaXUcwerTP9FAC8/PulcKqejV3J8UGFh+bAWPXMA24+ZeBfhB4jMg81rLoYQMwg/xe3zMGbhv0MmLVaiNmSYSEYpUj1kUCAx/hdzztxJjycj98AQbeAl87irzXpKHC3GT0tEIVOmOdX0OFPzbZ2wCNEJT++9Xv6M2/kQXYjoNU+Lrpf555eKTDP2z/KuKqoFwsOpXCZHZXZ+w4PLFtVZxnoLXDv5t+8GUxIvXlVTCYwQxXYhuzNxzvonWry4CsnDTvUkT/iRdDRxcQFS3RvxREioIv/wTpAkJv8SQrogPfyOWP5TZL5UV9Kgro9NAseI+u0Q81O6KtoXwiaY9DtsZzrJXNMgLnImn4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmwxNlZ2MkYxTE9SSm90eXVyNUVnckdhVnl2M3FPRnl4VW5MK1Bxd0ZBZ1NF?=
 =?utf-8?B?cXRBZnJUcUwvbXFqc3RrcXhrTEIzLzROV0p5UERWTWNVS0dCOUUyZ1l6T0FC?=
 =?utf-8?B?VkM1aDRFN29PaDZQR2JrMDFZbjFFdm9SU0pQeXhPNVRSOEZlU3FkQ21aK2hy?=
 =?utf-8?B?ZE84VllENExJODlsdEJJMjd0NjlIK2k3dDlaUFkveHlsdndiNml1MEM0L1Rt?=
 =?utf-8?B?Wm1hOXBWbUtlTmx3M0htc3RCYWFsTVhROVJReDZ2WUxCRUdyVHFaaDhZcHNB?=
 =?utf-8?B?eGFvekhYbkFXRFFRT0MwdERlQ0VlNHh4QzVxVVdleDRyZGwyaUJjZm9xbzdN?=
 =?utf-8?B?WkVjSFFDWlpIMHZXclNSazVzNzZwbnM2MDd4dlZyaDZCbnh6c003bjQrUFQ5?=
 =?utf-8?B?aGMyLzdaQTB4T0U0Vy9BQllIaUlLMUN6b3pFaDI0bFRKN3JKaG1nUkZ2Rmh1?=
 =?utf-8?B?YjFKKzNaQk9ETEFySDFabExFbEk0c0tFaktTWFA5Ui9EcC9BaUt2eWcvd0RV?=
 =?utf-8?B?QkxucUU2NlJCdjVhcHR2anZ6Tk5PQnZEN0VtZTg2ZklJVThHQzVTNXZTdkZv?=
 =?utf-8?B?b2ZwbWh4ZTNKSlNrUHA1cXhlemYvRXNXSTdtRUkvV3JOaG9jdUk1NlNXT1pH?=
 =?utf-8?B?b3JHL0VhM2hIVGtraEg5MUVKdXRrd0pUK0lqd21tWnJhRVNOQTRuTVl6YlNs?=
 =?utf-8?B?ZWhpUVgrNG16M1JpVXJEemR3SFVJcXFEbUZHMy9tNUpNU2ZPWjROWmpmOTlZ?=
 =?utf-8?B?STk5SzBQcmVhZlAwQVNMd0ZaaTRkUllYc2szSXpWUTNOMEhvT1NPeGw1TVpB?=
 =?utf-8?B?ZlJFbytKZkgrWTFrZXJ5aUt3TEdFMmRiZ0xHL1J0S0Y3M3d2cVNoK1M3eFZz?=
 =?utf-8?B?cXM0dSsrVHFuc0h5UndmMW9NcU9YUFhVQm8rTmlUbUdXbkQwQU94cDVIMmZR?=
 =?utf-8?B?dElUbXFYeFk4ZnV2dCtKbVVTWjIwbmZyTkNOK2YrT2Y3TzgvMFVveXNrTWRW?=
 =?utf-8?B?RjBVOHo4aVZ2Ny9Mcy9vRUhXR09STGczU0pRYzh5eDYrNkUvK3E3L2hlUmRZ?=
 =?utf-8?B?WTdJY3hYalZLUmUrakd1bytoMzdHTmVrS1VCRTd6T0V1RlNpVWdSWmh3YmF2?=
 =?utf-8?B?QUJIQmZ5ZEpOKzl3dFY5YWlVVnRmcGtsNzdQVWJHY2ducWdrSHhkVEJEOWZX?=
 =?utf-8?B?VUFPRS8zbWZ5RUFWakg3Q2xvRW5BdnowczhsY0xkcEh6WWZFVWV3bGlnaXBu?=
 =?utf-8?B?ZVJhYXZ3ZG9mdDA3U1RCTEtNOGhoTHhpUktUS0ZBSGNXWlEwRUplbkE3enJq?=
 =?utf-8?B?TGJYcjJGUFBIaUU3ZDRwRG9uMVRobjErTjdHKzl6MFptUUpsN0I3SUhtMU1k?=
 =?utf-8?B?SzMwYm1BUSs5OFJURG5xd2NvZGJZa0FETStZdVBBaE83YVhRNlJPTUUvRlZy?=
 =?utf-8?B?eUxteDBqUC83OFNyTDlNUW1uMGxJY3VXTDBZZDB0QkVrazhqZ1I5WUVTT2lY?=
 =?utf-8?B?T0ttaG1QYWxWeWJ3bVZGNkdzT1NOMVF3eXNGeXU3TFFhVFJ0VDFRVE9EdW5X?=
 =?utf-8?B?b1pFREwzNG5YVkdReTRwOE51akI2R0JzUE9sL0Q5bG9mOUo3WS8xU1N3Rmpl?=
 =?utf-8?B?Q2RWVE5CUCt1aUdsdkx1U1pnbW5qcHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696a5dff-55b6-4e80-a8a7-08db78c3d0fb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:11:02.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4162
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

When preparing the DCD patches for QEMU emulation and testing, I hit an issue
when trying to load the cxl modules. The issue happens when the kernel tries
to do cxl pci probe where it checks whether the media is ready
through cxl_await_media_ready. The function will check dvsec mem range.

In current QEMU code, the dvsec range registers for type3 memdev is set
only for static ram and pmem in function build_dvsecs, which will cause
the kernel fails the check of media ready of DCD devices without static
capacity.

About the issue, I have following questions that want to ask and
clarify,

1. do we allow DCD device have no static (RAM/PMEM) capacity at all and
only dynamic capacity?

2. Do we need to set dvsec range registers for dynamic capacity? And how
if needed?

In current Qemu code, we assume at least one of ram or pmem static capacity
exists. The code logic of build_dvsec looks like below,
if (vmem){
	set rang1 base and size with vmem info;
	if (pmem)
		set range2 base and size with pmem info;
} else {
	set range1 base and size with pmem info;
}

To fix the issue above and make kernel works for DCD (with no static ram/pmem),
I updated the logic as below and it seems to pass the modprobe.

if (vmem) {
	set rang1 base and size with vmem info;
	if (pmem)
		set range2 base and size with pmem info;
	else if (dc){
		set range2 base and size with dc info;
	}
} else if (pmem){
	set rang1 base and size with pmem info;
	if (dc)
		set range2 base and size with dc info;
} else 
	set rang1 base and size with dc info;

Is the above logic reasonable? If not, what is the right way?


Thanks,
Fan


-- 
Fan Ni <nifan@outlook.com>
