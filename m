Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4D15696E
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129507; cv=fail; b=TW/xSnZryPJI0Xlc3g6v6K/R8ODITTDrjjiKkHKjvI42ab0s9n8iH8zdtkQTG5WRSivUKlbPx/7LY88N2dHIhtHuQuCQy8fBEmEyzM2rEC4XZGlr6q5NqVVaOZx+/j02x8Fu0nBd90IM4hVIFowezhTT0+sjp8WMyRU5UE0D+iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129507; c=relaxed/simple;
	bh=X5GYUBYCbNBCKPd+S0JGj7eiUlMurXv8iKWMkrKD7ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBe0yP5SkxN08FyEnhTatl7HxrFtZ4SFikxrPiaHGr1Aqf3ywp+a3X3E71rKEX6M1+FXJltYB+WTLMX+51slgtS/GZfGm+yG8Csgp2C7eKS43LJR4O35cOX1cWapOSyf+8bVHw3L8uTeO7LH5iujSJuGZFztPKmR2R4Mbs4WiTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QiwjOkFt; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QiwjOkFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVfAJPYCEr4fZOPIh6ADHhXT87NBPx/1rXuy7n4bbi8mb3DriXOH7BAnPvgyF28Mv4Ym4OQk4Dyeuk3GqpyXonYWguESnwnZPvuVjeVTwdKjNWYUQMON9uDPXorNn3apHUydFCBaIUu7uDaJJr26bKe1GsbV1ozAPRH5yCN8raBqsJIVm2ooPR2inHL3BZV12KqS1ZL6zOSieDrvDqBua6/FizqFHptfN7UMSJdVhbB3WhXOrP2JF0Um8GJx1L9h6MLe3ERD7vtiC0CJR7HDxJTEsksewORRyB8Cc9f1QtKNmqsFmZZbYaxlI0DkabXpBTrr1yLCIg2yohOaMK1Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2V935ouR8ICc/Wq9YjPZ7+q84BabsFg2tH6Z8c01Ls=;
 b=N3X4es8kpCzhRnLTrDXCn0U4v8eW1ZPj2C08S0eR/ssvPoWsA1jOwoc0sxInVBq4FFA43mF9X1IH7++xDDU0z11dshoUpwciFFJCbWouUt8rHjuovJtUq+tpoPThGqE9gz5ZjMGx0QE0iZdLGqut+IXslvUwPTt1xkBBereYsN7/yiZtFQUhGcBUr/qg+c1rJQvmI91rnzjd6nMC8SBLSQsfJtRBmN7E+mG90wru3XpsmwLSL5mxni6UmgButLdy1tr2Y1U2O2r5dH+0eF60tPZroF9NVFDP4QHtRKx1XBFxEa2jwj27Hn4GVI1K7cJ7rgS/gNjZPmdvewW4hyQ1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2V935ouR8ICc/Wq9YjPZ7+q84BabsFg2tH6Z8c01Ls=;
 b=QiwjOkFtQizMs6tFdroX083ocIDpXHZw/SSueN+kcxU9/+MS1oFW2lFwZ4jhk8oGH2b5kl/vu4s+DIbLC4UnxjNOxaL5O1+Zuz7cTpnMqZCf5XvTg0wJmuNQfigwHY97X6vN9MBcPltk8BKrK/GHAAc8plT4FHIicOtcn5y03kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 15:58:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 15:58:23 +0000
Message-ID: <4f1417ec-953f-d8e2-183e-38da67dd536b@amd.com>
Date: Fri, 17 Jan 2025 15:58:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and 'struct
 cxl_range_info'
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 85033fe4-2d19-4b0b-dc03-08dd370fc560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVZJV29OanU3T2pnQWhhaWlabUd2WS9aZy9maVI3V0RsanVFZitiRUJwdHNL?=
 =?utf-8?B?dXFCdFlwbldwTUhMMEE2dWpYS1VId1crMWxta2lQd3pzbytTWkk4Mk1qRC9T?=
 =?utf-8?B?ajNUREJ2ZHhqZEt3OEpISEhEZmRGZFhCczFMQks4Q1o2TmhWQU1KZ2JyOHlL?=
 =?utf-8?B?T2VNQWJMbVFGSXpjUnlhY2lxOTVBNzZnQ0pzbUltVFZCNHRPWGRnamlLT3Z5?=
 =?utf-8?B?RmxzV0g0MW5FT3dEWlU1NjJ1Q2JHcjhEajFWd0YxSnV4a0taSEllVFdwdW5q?=
 =?utf-8?B?WVRKajhwR2J3KzNwRXU5THVTY0JUNFJ6SnMyVE1RaCtrdWNqSGkxQ1VUeWFC?=
 =?utf-8?B?SlVHdTgrWURxZGw5NGZSekFYcVlxd2VBaVJTYm9nN2k1SFF5MGIvVVl1QWVH?=
 =?utf-8?B?MGxQRjV5aEhUMGttbDZGY09WK2RrbkRHOG9pdU02ZG5WTU5sckdvdEsrTFh4?=
 =?utf-8?B?UGJwQWZjemI1R1NBd2pDOU9PWDkzQk9HQzBjVE9USk9JdWtQbFFuYUoyOXc5?=
 =?utf-8?B?RlcyWVVRczBKOHhDSXMxSnY3dUlRSVBvSXU1cndtMWl0anJNNTdyRE5JdW83?=
 =?utf-8?B?eEg1eXdnTmcvSXhLRHNUSWVlZ0hPMDdsZE9aYzRPa1pralROZWNIdHFzMXZG?=
 =?utf-8?B?cC9BUFhKNlk1VUN3MWZRNWkrcitURHVWSHVsRXNZeTh4MnJJUmJxTzBTczFt?=
 =?utf-8?B?ZzduQkllamNiRGxhemVTL1NUOXN3Qk1jRG1nTllPYndJU0h2TnJBRzhCaGVM?=
 =?utf-8?B?NldCeHZFZVdxWGNvdFFxMCs5cmU4TVhsSVM0VHpPclBKVVpjdTVYS3hFN1VO?=
 =?utf-8?B?WURLVXg5MHcrd3lIMUR0d0t3TVhRYkVOZ0FvbWdQeElkSGtFM2tvUlZPTUpo?=
 =?utf-8?B?Tmp6R1JYaUVNcVZmL01wQTY0ZmdiUFh1TWRBRFIwZldpdkpJYkFPaXpTajBU?=
 =?utf-8?B?bHJKTktVQk9QYUllK2lUNEpkMEF4emtqSEdNbkJFV2JIMU9nN1d3cU9JYkYr?=
 =?utf-8?B?eDFjMTcwVW5PNkROQTl2RFMwbjBsV2Q1RVFPcmRlNlN0MTZqQ2xwUnh0QjlO?=
 =?utf-8?B?alVQMVJiZWZXa0FhVXNRS00rSHkzRHFIWmNkdE84RE9HRFJpeWdqOWFEUkFs?=
 =?utf-8?B?OExvdkxQNWhocDE2RFMvdmpvZEJia01mWnpHSVJ5SjMyM3dmOWdLcUVvYnoz?=
 =?utf-8?B?SHN5K0gxaDM0UEZyYmZyQ3NWMzBIcHVwbC83L2g5MmxnMi9wL21XcFRPWXor?=
 =?utf-8?B?bmlvc1dtbjZrYlhLSDBvN1d2T1M0clVlN2UwVStIN2dycVUvZmpSTjdIK1pC?=
 =?utf-8?B?L3JRTlhVc1ZmckNBVmplZDlGOXNxYk5TVEExUnVjTWJaVEZmbnNYM3BzVjlu?=
 =?utf-8?B?cnhZdzJjbk9OYnBZZ2t2K015cHZNMkJWR1J1ZUJjN0RVSXJMUm1xcmJoRUps?=
 =?utf-8?B?bW5iY0FZbWlBd2Jhc3ZZSkJPZDF5OXZmY2UrU096SUNNdWpwanVUVXJKVVp6?=
 =?utf-8?B?bGJGSnNHUWJpMXFwQTM5VHdPeFNRWVNnZlpxamFrQjhTYXYxU09QU0g0ek1y?=
 =?utf-8?B?b3NGWlNFR1VXRWlSNWQ3a1l4eFFTZTNaUENQTXc4dVJxMTBJZ3RMQ3c1d2ow?=
 =?utf-8?B?dERwRVYrRkMrNjVDUGRKSGtQMXp2TnNqM1lrRmJWZUdYZTRzcW5hV0hxTktX?=
 =?utf-8?B?TkgwNzRmK1hNRjVzdHc4Z1VGSzQxYjFSdDdPSysreDI0RTZobWI3bGhSOFdr?=
 =?utf-8?B?alRLaG1CbEZNek9oWmdwbjJqSkFmRm5pTXIrTVZnRXk4bEhNL0FhQTNOQUdt?=
 =?utf-8?B?Q0l3cGxTSDBoOEwxZTRIbUxFVUd5bTErdE5oV2IrbEV4RlJ0bUJoRzVhM2hL?=
 =?utf-8?Q?RWLYxf8qqcEQ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnQwTTZYZXhpSEIyKzVOc1FSbnduUERrRitmbHZBaDZZd2RKRHNBclMxb1Bj?=
 =?utf-8?B?YUZ0eWJTQzVjZEtlMGU0UFMrWWxuc3NRaGxjNXptdEk3Q1J2VWw4WG1OanRl?=
 =?utf-8?B?NVYrdjVUSkFtbnEzVTlWMjJOWDNOQ1ppandZbk45REdaZ21BTjJsSDVzMWhM?=
 =?utf-8?B?bjRhbGVVUEw1VlpEWEFFclJ6QjByemxtbllOU3RpL1FIeVhmSktzZk1YenBk?=
 =?utf-8?B?ZlZUWXlhOXFjMUlSSTB4MjJkNkpzc2hCQmZzMWt4ZGRiNGFEVjYyTnhzK3J1?=
 =?utf-8?B?dGRXUS92WXdBN1Z6K0pobHR6bkJzOWJ3Qkc0MzI0ejczV2VxZjJzdWIxdWp0?=
 =?utf-8?B?T2g4aFJ6NG9TME1Hbjd5Qk5pMWFNV1U3VXM0K0NOZ3hOblIyNHpUZ1d0UGFJ?=
 =?utf-8?B?L09MOHFMeEhxeHdqREZvSFBTWEs1RTZSVENiMXc0U1pDMGNCVlJ2Tm1zT2Jy?=
 =?utf-8?B?VHhMMlp0Uk1XNGRub0RuME1ydE1DMU9VUHRaZW9xR1diYTlkVk5uaERqUFJa?=
 =?utf-8?B?bHhXUFR1MlM0NjlhVFR0ZG5XTUsvS29xSHR6N0cxTXNySHRhZjh3cEp4TnZ5?=
 =?utf-8?B?WnNhdWtxbzFrUkZSTEtSbUVabUNUOERvVXhHSkVkbHJKQWZlNkJwZEp6Z1NM?=
 =?utf-8?B?dGxUNHV4YWkzSlVpQ3ZZaXBhZHlWTzk0OWwzdUJFdk81WDZIQ0Y3M2l6N3Y0?=
 =?utf-8?B?Q2tIMmlTalFLWVlucFhhK05lc20wQWhRaU1UbmpHcmxXVXJyTHdzdG1uOFVQ?=
 =?utf-8?B?UVo2dE56OUF5eHNqVlZDVG9salR6YXVWZDhlajJoa0JSZHdKdzkvdU5LRCtZ?=
 =?utf-8?B?c2Q2SXlrZmo5U3p2MWZ3NVE5SjZkQmFXa2ZTcTZVTzdpYVQzU2JYRk5QbjQ2?=
 =?utf-8?B?SGc1M3hGQW9IdWc3MUFvOXJwSWd2cUZ6VEFPWWdxV2RRWHdFWHBUUkt0QTBN?=
 =?utf-8?B?dHowNEVFNXhDeEtWTGdWdUFTVG9XR1FWQ0Z6TzgzSU81NGdJOStPTWVPYk8v?=
 =?utf-8?B?T1pqdnZhdWlqZm1xc1FDVkRvYzdhUHNTN09LTmxzOHMvMitUVGxNVWEwMnhQ?=
 =?utf-8?B?QW41S3VGQlJIeVQ2aklXbDV2TnorcHE5dlNEaUhhSGJmcWU0OUZ5UTU2RW1P?=
 =?utf-8?B?SXBKbE5DMnN1QTBNVkJqUHZ1WmJsZmhIY2lxdUUvUFdQdjNheHBJbDBaOGZw?=
 =?utf-8?B?b0d1ZWZJdmxYUUN6S00wZ2s0OHpZOEJqWnkzYzY0dUE1YlV1Y3ZPYXF2MC9a?=
 =?utf-8?B?UHBWalZWUjdxWkFYeFVoTWZGQWR6N0huZUttZ2YwQlJCWndLRDlxcDlsa1hn?=
 =?utf-8?B?VEdQRVJjUjV2N0l1d01kK0FtZE9IUjc2d3laMHo3WjBjbEVRZXdUcWRJUUJB?=
 =?utf-8?B?MzVBZXVrVE9rSjhHeVVIN3pjK00yOGNRcXhic3lXczVjbG1lUE1yeDF2QkM1?=
 =?utf-8?B?U05WajlEY3A4QktKc3FNSE1hRk9QdW5ucnBRYzM3TWFyRDJlWTVkc3dlNUMy?=
 =?utf-8?B?eFdydmZFWWpKYjU3WGdMU1dSRmMwMXNLeDZNaXJNd1pGRThOeis5S0ZhQlky?=
 =?utf-8?B?VnEydmRtZHhwNTVXTUp5NkVsSzN5cmptRDI1TDFlTFdxK3hlU1VQWFhVaGJQ?=
 =?utf-8?B?WWpxRGx1eWE4UkxnZlR6U0NRTStVM3EzbmIyYkFRaG4wMHdNUHhreE9hYm9y?=
 =?utf-8?B?d3VIeEhybTd5WUdjcUVhQWZOQ0YvQzNoTDdhbktVOElUbVhCWDBjTGxzRGl5?=
 =?utf-8?B?QXBJSWdTbitEYXUvRGhXcUMzWHpZeWE2a2xnbG9obCt0a29lNWFmeWVPT2Ez?=
 =?utf-8?B?bERlZG0xTGVmRVZQSVVaTlB5RHNJa21iaUZFbDJPcXRFam9qS1M3NEtFV2dL?=
 =?utf-8?B?d3h5dkhhYW53R1owOFBqRFNNdmhXTWQxcXRIcFZOcWo1NjJVUnd4aVpXaE1T?=
 =?utf-8?B?dXBnL1pzemhyKzdTNzlyWURFN0lBQzFMbittL2dZZU84SGhxaW1NS01lR3k2?=
 =?utf-8?B?NkE0dU1YYWUwYXloK3I3ck1sNnI2TTdWeDl1NUE2ZGo0WHkvR3hid3JoeTBy?=
 =?utf-8?B?T09QaEx4K0crK0kvMWozSXA0T3V2bjRrUkpLVzBwSmdBL1pxWnBQOVBTWDRP?=
 =?utf-8?Q?Gywl0DAfKVGls7I4QlUaA1JH5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85033fe4-2d19-4b0b-dc03-08dd370fc560
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:58:23.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkO8S0um9jlrK+trf3Ax0gPL2Vy9Ha2N4bCP5NAMo4dcCMcmPWe6T3tY4U9nVOELR6KF/d9XpWBazJW/oMkQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754


On 1/17/25 06:10, Dan Williams wrote:
> The pending efforts to add CXL Accelerator (type-2) device [1], and
> Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata. Trip hazards include:
>
> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>    devices with CXL.mem likely do not in the common case.
>
> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>    commands like Partition Info, Accelerators devices do not.
>
> - CXL Memory Devices that support DCD support more than 2 partitions.
>    Some of the driver algorithms are awkward to expand to > 2 partition
>    cases.
>
> - DPA performance data is a general capability that can be shared with
>    accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>    suitable.
>
> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>    memory property, it should be phased in favor of a partition id and
>    the memory property comes from the partition info.
>
> Towards cleaning up those issues and allowing a smoother landing for the
> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> way for Memory Devices and Accelerators to initialize the DPA information
> in 'struct cxl_dev_state'.
>
> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> get the new data structure initialized, and cleanup some qos_class init.
> Follow on patches will go further to use the new data structure to
> cleanup algorithms that are better suited to loop over all possible
> partitions.
>
> cxl_dpa_setup() follows the locking expectations of mutating the device
> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> likely only have one hardcoded 'ram' partition to convey to the
> cxl_core.


<snip>

> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +


This explains to me what you meant about locking when setting the 
resources for Type2.


However, I think this is no necessary because there is no user space, or 
that is my idea, involved when creating CXL regions for a Type2. It is 
all up to the accel driver to do so, therefore no locking needed because 
none is going to traverse the child resource list while 
initialising/updating it.

It does not harm to have it for current Type2 case, and always a good 
idea to have it for potential future cases.


