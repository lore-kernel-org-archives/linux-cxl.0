Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB579156652
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152773; cv=fail; b=EOYBcDi15PYJ58mSWZh1UYwB1gLSJ702zEcSFoWbEIcad9n1Bx526IMP7v8NrzahPKGlIdWXwBSd9abGrxyvuZRPlA2yEdtKV8bUiZsegExCrFGH+FYrb3lpObUuthpPtWLvhjBnbNNOb4TbrHrcx8BCxXZlSHzFRWtGIQ6aEcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152773; c=relaxed/simple;
	bh=8y/Chv0GO3NN4NukvLKO+Hnj+bVAqj60u9VTCgMQn3o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7FxJ4c3E7oepHkOSZdR+X3Fa5gff5fFO/pQi69Rp9zKdOHvwOjOBaSDBT5q9cBNYmUrc1UuaDaZ9/ZIQekA3tXWBUX8WsdIs4Wi33CgyY/mwtzFJqhg0PvPwLI0n/piD3Iza1XdXg2QEs4Z56eHO4zlVTZl38LSXZTAhhJ07Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r5bL2/ku; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r5bL2/ku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqUnRbtbudV9hVnvgQm4iIijUHpL2lxuzMCvbgS9poFSjpVOOMbyzuKN/4R3ohHcXhdIu6DUXq+rokpdLu+iIxJiUoJqMzqeQYzU4h0iYK4z1VRzSx7sIuebQdXjfrfgFziFM6lgYnlV1L4e2sKDDtngZNt1BWWAb6WX41GkRUpV4CszxlvMWWSi/FDBJEBAhStA3M7xliFIzHV151jxwdZOX0l6lfxa8KbZwtpF5RxQ5TpftCmwnNHDr8oBKKeZTECfOHO5N3AHz92CVy631OPYMBz2NwBHK24vGh/URF/9bsyAb1DU6uBMmNVtmDvCaMQW6FEab9SFXmGHC1Lm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTH9cFRsD+55Do+ua/cLz4FLZhC2EF/SmrRjNUGhqoE=;
 b=n6EfQ5GVajQYihIn2/iPYpcNIhi2t2M2jlpvzls2jtfqZG+lKEWoq3uuwpTL16qBMMoGoxrpe0OAe2whEXMrUdpq2cfgNfAOskdpoxtYSqUoLm4tabgG32fbzG/25rTpmCGmIfEu8deFv3r7tQTznDvRfso0lcLOwauADhSRJhNaf949x4pyyE68djWUTavDWoIkeh7PsLS8PZQTyHwjAkdMnhSV7XKOrm+FnH+BzOAlomixnkzHJWi/79fG94E8ui9Ef0QBAFfUcvmNfBP4FhER8Djh2eCI/oZYjKM0cvnJK5wjptqfDnFY+DGr3la/6TfsQaSIiM0CjuhGjYk8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTH9cFRsD+55Do+ua/cLz4FLZhC2EF/SmrRjNUGhqoE=;
 b=r5bL2/kue3OPk+ZQzdfLtRHWzoWPuKENEMwD+sXS04GwX9JxDU9Z54dt9HM/S+tswUw88NyIRAHHHjg+JvsDKynKecjIEwhc4EYj60kYcVLHzhtKSAdDdet4v21UMpkqZ4XlrufIn/LQ8KOnIBKY/hBkYTujHLdrXyt7PPOBRek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 10:52:49 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 10:52:48 +0000
Message-ID: <c6e88068-1eaa-d3c9-570f-7988b8cb846e@amd.com>
Date: Fri, 31 May 2024 11:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/13] RFC: add Type2 device support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
 <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
 <0a5e5366-92ef-d608-43ab-e0756e0458c8@amd.com>
 <664c296bacb6f_a0282947a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <257e2959-5919-a847-d3e7-53f53bc0e131@amd.com>
In-Reply-To: <257e2959-5919-a847-d3e7-53f53bc0e131@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a402d6-99c2-4928-3fa7-08dc815fcfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODdnUlREQnBUbzFxS1F0a3lRQnhXWkhMemMyb2RuOS9HMUZjd1I0a1FzVEc1?=
 =?utf-8?B?RjJVcDdKQXpnL2ZDdFVRNnBZYUR3ZmJRUjlKL3JKSEppZERET2xNREx1S09I?=
 =?utf-8?B?ZytZc0xMRDZiY1BUZzQ3ZnZ2cHV5RHplOXZVUEFVQWZKWU04NFRodVJkS3Zo?=
 =?utf-8?B?SlNuUmRLSG9kVVp5YW1zMXd0VlNZdFVybkl0TFBIaXkvVjZOYitqMWtzK3RI?=
 =?utf-8?B?eXZYMFN2bEVXRU9SWjRqbG00QkpGNEkrSzNBVkdicU1oSitoYkZPTjRRS2tN?=
 =?utf-8?B?KzMxSlU1UXY2Yjg5YlJncExnT0t6WElZZjh5cVkySStvVy83ZCtZZEYwOEV3?=
 =?utf-8?B?eHozSy9SdjVoRlA3VklHcGprM2s0dXJuSFRhaXUweitMR3Axc2hvUytMYVpU?=
 =?utf-8?B?c0owMjBXWnJ6aWVyb25lK241NDU3NzlORWFqV0dvdmZESlZNTjY5OXNMbjFN?=
 =?utf-8?B?L1lkS09XMHNSMUljbDdYVVArYmlFVFNyQzV4Wm1GT2twcFdSRW1pRlpkWmRG?=
 =?utf-8?B?S3F3UzQyUmVCZS9PcDg1cGdoQ3RpUDVycXBzamdaYU9OeG8xV2JyWXFTb2lD?=
 =?utf-8?B?ZUgySTc4Vk41TmtJbE54dnhaa1VTWDdWR2RwOEhKS2R2VVh1eXVKcmlrdzZT?=
 =?utf-8?B?aWpOa2lxbDJ6Tk9paTg3bnZ0bFAxS05hTDEvOG4rclpwbVhidTdsaDd2UVpk?=
 =?utf-8?B?TTJ2bVQvN3V6U2psQlBycVc5YklGSnlyVko5MURob0tCZUJwRVBXQ2hnYTlo?=
 =?utf-8?B?NFV3VFpFWUpWRWJldHY4eFFXdzF0YkozSUNGZFVTQ3BVaVpZcUxQcGRSNmh4?=
 =?utf-8?B?bTROeVFNQmdHdk1zSVlENTd4UHRMQlI4UCtxRWhRUlczdjc1eGRBc1Fucm95?=
 =?utf-8?B?ZDRiREVyNzE2S3hYZFJ6YktMOUtOSGdIWW9nOWpxeHJVelVLSUF5NTh5Vmtx?=
 =?utf-8?B?djc2QjVDV1MwU2MyckpXU2VmNGJEMTZxSVFPaHFQNWdxN3REeTgxV3RhU2ho?=
 =?utf-8?B?TUpZQlJnb09oYmVGQVNNN0k4UHhVbllNbTlvOTVLa1Y3Sk1FcUF1Q1hERnhE?=
 =?utf-8?B?bE5tVmh2dVBzMzRZd1pqaVBaWGJKd1IxZXFjWC95bmFkUjdsYUpCL1N3dExJ?=
 =?utf-8?B?R1RPL3MzOXk2YUorT3JIV202aVQ0eFNKM2hxV205VTZIZng1VXVZN0ZoM013?=
 =?utf-8?B?dHE3SFQ4eGtGQkNSdnhrN1JlOXpZdHdjZDE2aTg3MkFoSG5rd2poZGQzckJ4?=
 =?utf-8?B?ejhTSjZSVjlkWFhXeXJqMElEMmpEb0ZvWTVYQVYvVXV1d1ZXV1NPRy8xeFZN?=
 =?utf-8?B?SDFWeDJBU3J4SkVJN2g5T3BnbE14WVZuZ1RvekkzVit0emFFWEt4TDg1Qlho?=
 =?utf-8?B?d2JaVUNQOVJwOTZMOFFNNkZZOGFzS0ovbGJ0QUlzSjltRXVoOUVOSXpTRUpY?=
 =?utf-8?B?ZHJLWmtsNUVRMkxydGU1TTdMOE1wdWsvd0ZJTkg1YWlsd3o3dHB0SnAzbUhK?=
 =?utf-8?B?UDhQYzFFNnJMYTlvK1I5T013c1R1bzJqS3BvMUkwM3VFdUpBUjZmUFFHUitr?=
 =?utf-8?B?ajJNTkUyU3pFZUhIcUVweEpjNHV6WVYvekJ4N1pYWUtnaGREcWJWZGlUOWxx?=
 =?utf-8?B?QzBIaHNRcEd3aVg2SlRzWm5UTHNoMXBIMHp5UjB6czZaVjlIdzN0QmNJcGhk?=
 =?utf-8?B?enptVk1aMFJ2RUovaUdydlVaUUZPdG95UjlRZHZEUGVZV1VhcUVGU0ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1llWWVldUU5WGowZWJja0NYSSs0N05WSm1WeW1ZcEJhUGRDVEhySml3aVA5?=
 =?utf-8?B?OTUxK0ZtU3lTN0VXNXc1ZzZ1bW9VVzJHekJpOVV6QTI5RU9jbkVVR1hieitG?=
 =?utf-8?B?WWRRNlNCOXVTWno5WFJ0TlhFRllxRHZwakJ6ZWlxVHpXb2dBVWJHcnFDRWdu?=
 =?utf-8?B?RHpLZUcvVG1PcjB6aHQ5MHp3M0s1M2lGU1ZpYURtdkNya1pqTFhXa3VMR3RX?=
 =?utf-8?B?SVd4RzhPZWtWRkJEMjB3NS9wSkZpNTFONjBaeDd4ajAveDZEVEh5dkJFUU1m?=
 =?utf-8?B?VVJQdkJlbjM3YXNWblVxaE0zQTFUWTdKSWxwL3lnNmF0NE96Mk1lWTNhUHNS?=
 =?utf-8?B?ZGl3K3MzVk9qVGpJV1pYbGNBazdLb1FtZU9PY0ZFT1hzMldlTVl5N0xHNGJl?=
 =?utf-8?B?NWFWcUhxVk9tbkdoUXdWckRtWmNnL2NuejNqRzdPcTY1Vkl5TlFyMitnYjZl?=
 =?utf-8?B?ZEtlZTM2QTZleFk5d1AzcllvVTBNeTdmRjZORUtNWGNtaTBxdnBNVWREa1BU?=
 =?utf-8?B?cGNnazJodjdPaXJHTU9KeGdQK0EvYVlGOVN2SVZKUEp4OE5vMkxWRXQ5YWlV?=
 =?utf-8?B?NS9HcWpYc3M5TFUzWlFzVEIwNVVXRWswRnQ0UFlodzNwblhNT0kzc0Jzai9R?=
 =?utf-8?B?d0xFa0I3WTltdnE1ajNVNDIzUXFlU0hJNnhkdDdJVmZiWmZRWUlaTCsrSzVJ?=
 =?utf-8?B?dTc3UG5FZ2cxZWdYenhnbDlhc0prcG9IeUx2TnE0Rjg0OUgyeDkrM25rbm9J?=
 =?utf-8?B?eVBtQWUzQkUrT0g5UkRxcXJYdmFOZWlXQU9yUjlHalFkeHFRNUhKamNBMHJq?=
 =?utf-8?B?RlJvR2tSd3ZOcGd6dGpMSlRnakMvM2JMU1kvZWJSRWNqaXVaSEswcnNSc09N?=
 =?utf-8?B?N1F1MmwxRlJwOTBEbVpGQWtRWUF3cGVxRjhsVGkxQXVvT09ucHhmNjMzRFdx?=
 =?utf-8?B?eHNHbWJxeVFZd1JEVXZHNWF2YUdCNFFuNDFTQ1FtZVdmYjRYdktBNmVNWGcx?=
 =?utf-8?B?SkNxdHJTUmxHTVl0OWlpamdpYi9LeEMvZlZuWUNaMEFwYVFsZ0NPY0NSVTAv?=
 =?utf-8?B?cEhHYUU1eWQ1azJhMkhadlNRdE1QQ0NoUlQzam1BSmFmRFFDcVgzQWVNTFcz?=
 =?utf-8?B?WUs0UU5nTU5GOGpGbXNabzNvOTZLdFpybS9rbjJQN2VydWdJL21oTTlnZnFJ?=
 =?utf-8?B?MEx0dXlvOUhUN1hDZzhabitDNTFuYi9KRGF5ZEtSSlQzMUlybVlhZUZQU0NY?=
 =?utf-8?B?Ui91ajREZWdpcnpDejVlSGV4MGZtQ251a2tQd1ExdnA1cWhBTVJZclViRzND?=
 =?utf-8?B?L1o2U3BlcHdPKzh6V0svbzFVZjdxZHhCKzA4SEdlZ00vZTZST000ZEo0Tlc4?=
 =?utf-8?B?R2E5SjJrQUJScGpQT0lQWmo5dFBpeVJnYmxUVGVYZGtQSlVGN0xnYlducFZ4?=
 =?utf-8?B?bEJBN0F5SXlkQUhyKzRMcnFiNWkra25uN2J1Wkd6SmxySE93T09EQzhySndQ?=
 =?utf-8?B?bXVnSnNkdGpndVNPZUo4Z1NXRjNSNW1MRWZad2VFQXZoOUlNTlNnYjJSYnZJ?=
 =?utf-8?B?K1JYaGpicTlidmk1aEpnNnN1OXBLRlRqY2h3aUFpY3hNYUlIWTB6Tzk0THVz?=
 =?utf-8?B?UzNIejR3d1pxYldBTElmQ2lGVWYreEFQaVBEenNjaUF4RWtQOEVUQVFPMWhB?=
 =?utf-8?B?MWhNUzNGMmVWMzU1T1dJa2JHMnAvUng3NldDOTVGa3JzYXZ0QklPNWx3T3dD?=
 =?utf-8?B?RGJKTVNOcjVwajBzc3ZWelYxT3BiVHlQeXQ1bXdTRkpkTG5acllOd2w5QnlL?=
 =?utf-8?B?QXpVZFpSYTdZUXRBamZnMGlCeFZKQmxLY2UxQkgvbHZBaVoxT2l2WEkyU0w0?=
 =?utf-8?B?Qnkrd1h4WDlFY05yOTJ1M2pxTmRxekU1S25jYzR2bEZDSUV6TUVZZDJXM0tU?=
 =?utf-8?B?MmFZM084Vmhid0lSMGFCNEZWVTVDdGNQSTlGaWdFV3FTbE9FQmdpWVI2Q2VP?=
 =?utf-8?B?TnRERW4zZ29rckNMMDRZS1o1WTFuWTRHcC9HdS9TOHZPN3ByZVpXYk1IUit6?=
 =?utf-8?B?b3dDN0lFcitsNWh0dEk2ZmFtNlh2OXhrSFc2NjdDZWJaNXIwVGtSWHBqVmVq?=
 =?utf-8?Q?Tu7yV5yCk8vPpo+JkqoJ2gMlR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a402d6-99c2-4928-3fa7-08dc815fcfab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:52:48.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuvIZvZUNSKwVxCUWsZWlp5dMYq/+3p7g4B4N6O+OOA6pa6l7KPoKFdWpaHcIQbmJi5reqPCX/7K6pWMsfoTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

ping

...

and some new comments below.


On 5/22/24 17:38, Alejandro Lucero Palau wrote:
>
> On 5/21/24 05:56, Dan Williams wrote:
>> Alejandro Lucero Palau wrote:
>>> On 5/17/24 01:08, Dan Williams wrote:
>> [..]
>>>> My expectation for CXL accelerator provided memory is that it is 
>>>> marked "EFI
>>>> Reserved" in the memory map (or CDAT), not "EFI Conventional + 
>>>> Special Purpose
>>>> Attribute". Recall that the EFI_MEMORY_SP attribute is just a 
>>>> *hint* that OS may
>>>> *not* want to consider a memory range as part of the general 
>>>> purpose memory
>>>> pool. CXL Accelerator Memory is far from that definition. If a 
>>>> driver needs to
>>>> be loaded to effectively use a memory range that is not a range 
>>>> that can be
>>>> transparently converted to "EFI Conventional Memory".
>>> Well, that "EFI Reserved" is what we want. However, AFAIK, it is
>>> EFI_MEMORY_SP the only one being discussed with our BIOS/UEFI contacts.
>> Well, tell your BIOS contacts that they need to honor what the device
>> puts in the CDAT for the memory-type, not just make it up on their own.
>>
>>  From the Linux side we can scream loudly with
>> WARN_TAINT_FIRMWARE_WORKAROUND every time we see a BIOS that has failed
>> to match EFI memory-type with whatever the device puts in the CDAT,
>> because that's clearly a broken BIOS.
>
>
> Yes, we need to sync with these guys :-)
>
> EFI_MEMORY_SP was our/my only focus and that is probably the problem 
> and the confusion.
>
> BTW, How can the kernel warn about this? I guess this requires the 
> driver raising it. doesn't it?
>
>
>>> Because how to assign those flags seems to be based on BIOS
>>> implementation, we count on some BIOS versions doing the wrong thing 
>>> for
>>> our purposes, so I have been working on a workaround implying udev
>>> events and executing a modified daxctl for switching a dax device mode
>>> or even removing/destroying it.
>> Yikes, no, lets not do that. Another thing we can do from the kernel
>> side, in case the CDAT is missing, is to never attach device-dax to
>> address ranges within CXL windows with the "Device Coherent Window
>> Restriction".
>
>
> I do not want to put my reputation on this workaround, but I see it as 
> a first and quick fallback and not requiring kernel changes to 
> CXL/DAX. My idea is to add some interface between drivers and DAX for 
> doing this if necessary, once the driver tries to get the resource and 
> it fails. Maybe with some kernel boot param like 
> dax_allow_change=drivername or something similar. What else could we 
> do for the case of the BIOS/kernel doing the wrong thing?
>
>
>> [..]
>>>> It would help me if you can summarize what you did and did not 
>>>> adopt from that
>>>> proposal, i.e. where it helped and where it missed the mark for 
>>>> your use case.
>>> I basically took your patchset referenced in the RFC, specifically the
>>> 19th one, and tried to work with it from a pcie/CXL device driver. I 
>>> did
>>> debug all the problems precluding the CXL invoked function to succeed
>>> and applying those changes from previous patches required and not
>>> committed yet. Patches 7, 8, 9 and 11 are based on your patchset, with
>>> just some minor change since I did not see a reason for changing them
>>> after studying them. The other patches are those fixes for having a
>>> Type2 finally able to create a dax region and map it.
>> Ok, let's not add dax region's for this case, but the rest sounds
>> straightforward, I'll take a look.
>>
>> [..]
>>>>> The reason for adding such a Type2 driver instead of changes to a 
>>>>> current kernel
>>>>> driver or a new driver is threefold:
>>>>>
>>>>> 1) the expected kernel driver to use the functionality added is a 
>>>>> netdev one.
>>>>>      Current internal CXL support is a codesign effort, therefore 
>>>>> software and
>>>>>      hardware evolving in lockstep. Adding changes to a netdev 
>>>>> driver requires the
>>>>>      full functionality and doing things following the netdev 
>>>>> standard which is
>>>>>      not the best option for this development stage.
>>>> Not sure what "netdev standard" means, and not sure it matters for 
>>>> a discussion
>>>> that is constrained to how the CXL core should evolve to accommodate
>>>> accelerator-local memory.
>>> You know I could not add to a netdev driver just those changes for CXL
>>> initialization, then mapping a CXL region and doing nothing else. 
>>> Such a
>>> mapping needs to be linked to something inside the driver what is just
>>> under development and testing.
>> Ok, you're just talking about pre-plumbing the CXL bits before getting
>> started on the netdev side. Makes sense to me.
>>
>>>>> 2) Waiting for completing the development will delay the required 
>>>>> Type2 support,
>>>>>      and most of the required changes are unrelated to specific 
>>>>> CXL usage by any
>>>>>      vendor driver.
>>>> Again, [2] already path cleared the idea that early plumbing of the 
>>>> CXL core for
>>>> type-2 is in scope. Just need to make sure this effort is focused 
>>>> on general CXL
>>>> specification use cases.
>>>>
>>>>> 3) Type2 support will need some testing infrastructure, unit tests 
>>>>> for ensuring
>>>>>      Type2 devices are working, and module tests for ensuring CXL 
>>>>> core changes do
>>>>>      not affect Type2 support.
>>>>>
>>>>> I hope these reasons are convincing enough.
>>>> I am happy to have general specification discussions about core 
>>>> functionality
>>>> that all CXL accelerators need and plumbing those ABIs to be 
>>>> exercised via
>>>> something like cxl_test.
>>>>
>>>> I expect that cxl_test only covers coarse grained inter-module ABIs 
>>>> and that the
>>>> fine details will need to wait until the accelerator specifics are 
>>>> closer to
>>>> being disclosed and the real driver patches can start flowing. In 
>>>> other words, I
>>>> am not keen to see QEMU used as a way to proxy features into the 
>>>> kernel without
>>>> disclosing what the real world consumer actually needs.
>>> Sure. FWIW, this will end up changing a internal driver mapping HW
>>> buffers which are now based on PCI BAR offsets by same mapping based on
>>> CXL region mapping.
>>>
>>> This involves, PFs and VFs, and because CXL is only advertised by PF0,
>>> this all brings more complexity to those changes than could be 
>>> expected.
>>>
>>> I think taking the CXL core to the support needed, hopefully based on
>>> this RFC, should be started as soon as possible instead of waiting for
>>> our driver/device to be ready.
>> I agree, but continued transparency on what the CXL use case looks like
>> in the final implementation helps make sure the right upstream CXL
>> mechanism is being built.
>>
>> For example, just from that insight above I am wondering if we need some
>> centralized interface for VFs to lookup / allocate CXL resources from
>> their PF0.
>
>
> Not in our case, but it could be needed (or convenient) for more 
> complex devices regarding CXL ranges or decoders.
>
>
>> [..]
>>>>> Type2 implies, I think, only the related driver to manage the CXL 
>>>>> specifics.
>>>>> This means no user space intervention and therefore no sysfs 
>>>>> files. This makes
>>>>> easy to avoid the current problem of most of the sysfs related 
>>>>> code expecting
>>>>> Type3 devices. If I´m wrong in this regard, such a code will need 
>>>>> further
>>>>> changes.
>>>> Not sure what you mean here, I am hoping that sysfs ABI for 
>>>> enumerating objects
>>>> like memdevs, decoders, and regions "just works" and is hidden from 
>>>> the
>>>> accelerator vendor driver.
>>> If a Type2 is fully private, should be any sysfs files about it?
>>>
>>> AFAIK, those files are mainly for user space able to create memories
>>> joining them, or for changing the dax mode. What do you think a Type2
>>> needs through sysfs apart from info? While writing this I realize I 
>>> have
>>> not thought about power management ...
>> They are primarily for userspace to enumerate resources, and they
>> provide kernel object names for CXL error events. For example userspace
>> could generically map a CXL switch error to impacted endpoints without
>> needing to know or care whether it was a type-2 or type-3 endpoint.
>
>
> That makes a lot of sense. Then I'm afraid I should work on this. I'll 
> try to find out if it could be just modifying current patchset with 
> minor changes.
>
> Thanks
>
>

I've been looking at this, mainly alarmed by the error handling problem 
mentioned.

Firstly, my original comment in the cover letter is misleading. The 
patchset does not avoid kobjects to be created just some sysfs files 
related to kobjects attributes.

I think it is the right thing to do, although some of those attributes 
could in fact be shown, so I will fix that. However, I think some fields 
now in cxl_memdev_state should be inside clx_memdev, like 
ram_perf/pmem_perf, but moreover, I think we need a more flexible way of 
linking Type2 to those structs where the optional Type2 functionalities 
can be set or not. Not something to be faced in this patchset but by for 
some refactoring in the near future if my concern turns out to be a real 
one.


Secondly, there is another concern, maybe a more important one, and it 
is related to the error handling. I have to admit I did not think about 
this at all before Dan's comment, and I think it is something worth to 
discuss.

There are, at least, two error situations I'm concern with, although 
they (can) end up with the same action: a pcie/CXL slot reset. Assuming 
there could be cases where the system can recover from this situation, 
and noting that CXL.mem or CXL.cache could stall cpus and likely 
crashing the system, the concern is how the CXL device configuration 
like HDM should be done after the slot reset. While a FLR keeps that 
config, a slot reset does not. The current Type3 support inside the CXL 
pci driver does nothing when the device is detached (no release 
callback), what is happening when the system performs the slot reset, 
and cxl_error_resume is not trying anything. If I'm not wrong, it is in 
the resume callback where the device is probed again.

So here is my question: should not an endpoint slot reset be supported?


>> [..]
>>>> If you think we will still be talking about this driver enabling in 
>>>> September
>>>> I would invite you to submit this as a topic for the CXL uConf.
>>> That would be great!
>>>
>>> If this RFC work is integrated by then with the CXL core, that would be
>>> fantastic, but the CXL.cache support will still be pending.
>> Sounds good.
>>
