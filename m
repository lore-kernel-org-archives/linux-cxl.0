Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196914EC53;
	Mon, 12 Aug 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463430; cv=fail; b=dNz0gzHrq15+4PKLPfSgZ1dT2PP5kJxbVhD0ZczphxzilnLTFQVa2oweMVK5IgqxOr2cd65v9HIzwHW/D+Olyzu8MCktZ5/hIu4yKzbzh40jajV/ESJUUx/RDorNq2EpiVc50OP8BguPbP92Rk0A8LK8L4jAgQZFgk0l9NZx5OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463430; c=relaxed/simple;
	bh=3dwTB7wM+VX7mV3IclSzXOwzCAiiEnVd8m5sd1U+3rY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQm23k8/EOfEttUc4CPpdCFdiM8aVl0JWRNbjpzpHn5rNG7qkGFVqyUpLZH1Mt5YNur80g1CQWzMK7R+GVpiU8fmo9C/IuzlOglATU0wIMCNTxvq1/FlhuMJACVGUcDl1+xEOMWZKEa4UjeSO+UAHwnH6OKkgoJbasdKReUl248=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oMvyt/2i; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oMvyt/2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYki1mDkTlmwNWZ0IItjK80b0xrkWivqNLgAtzYo7wq+QfUKlRIe3Tye8M4qBITdwvnASKWgjX+gT8g1L2jYBG5ib4FC+L+IkipqrtpzF/WO734B/WYFoDJPVHbte1hsNUdmcaZeLvNmktpct+Wy/GjAFA97ft/Db4UyrxeJISpc2ddT9Iy7mrl3xN24SJwuIsmF35nVM+plwnFEXqMC5gPzjMEPtLpMtuX/Oi/dSZH88/A4DWGLXZbKtydj5xKR+BOAAonycga+Ld0K+OLgU3XAg1B+3cXrWzWwmxWID20d9+/N05lBrRfenKk0x4i49MiyCsvUT8KGmyjxEUXB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLPmGXIy53zBtUH8lfpJ1fBtRvWrHqdv3ew9XDXD+E4=;
 b=yExDvCKGVUFjsM3iVhxmq1PZ3gKHZz1s4IpuRN2XkJJCa0S4QKGAiSc+TjiSIRGAN64IGRIA/1NO/IjoRhE/zi3Os3C2AUhpY8QxWqwVbP06RGsXRI2kGw47j4pWWG4UCJphAy6dZuizyg8pL2BpkbVkf1Z0T99N4x0rhuivfiUEZcdxg6s1LuSHPnDrmj+OgVGkIdTs6fdwkJNtrilwBnrIRS/nqYlPosx7j5IiyrD4g3/s2DqPeMDHUlK3THb3OwDcJABOi8llF5Gpcv2F0tdLpzvM7KCAn/aBF9zUdFWWluFrCDEYVBbNQRZ3ZASZbEz6b7ZQ1QQSH47sq7BVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLPmGXIy53zBtUH8lfpJ1fBtRvWrHqdv3ew9XDXD+E4=;
 b=oMvyt/2i08TMJDGapbIEucA2aefvIAtx1DC4q5cGbiTupIweb6fpJ/hX2AhAQXpgpX2ntFr53mJZ2LXfIO9lpHky4pMHr4nJgWFbelL5LDdUkkPySRzVYweL5kAGMjlG5lYgjOxA1kWpv7fVR8FII22TayH23Pn08lqOP7eAmzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 11:50:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:50:26 +0000
Message-ID: <01ca9abf-45b0-90c1-d503-5e53eb4904c4@amd.com>
Date: Mon, 12 Aug 2024 12:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] cxl: Avoid to create dax regions for type2
 accelerators
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-4-ying.huang@intel.com>
 <20240804173813.00001018@Huawei.com>
 <87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1400ab-2300-4f46-884e-08dcbac4f492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHhvTXpOandRRlJXMVMrWGs2Qzl1Uk5lTEwzZlpaSS9JeHNUMWdtaGJ1aHhH?=
 =?utf-8?B?YXk3YXV1MGtaeTVXYW9kZEM1UkFHYmhnbk9XM1IzWTVhSjcreGdEejQ2VjJr?=
 =?utf-8?B?UEJseWxtWUZ2UjR1amlZc29FU1VZMGUrS1I0UElzTG5odzJ5YmJRWVZUNkIr?=
 =?utf-8?B?QVRaUzhLajdYalRRTEJFQXp4UEpPcXR3M3ZPVnlkVlcwUW5xK1hjTTJVcmRE?=
 =?utf-8?B?TG1QM2dDZkpDS29pMjlVNUZkTUxYUitTbHFSMzhzYllRMi9xRCtqdHVZOTZv?=
 =?utf-8?B?ZU5rYnl2OGlvZWtIYWFxSmpqZCtRcW55YUo5UGJ1MVphbnlWRUNBUU85SlY2?=
 =?utf-8?B?bW96UElxT2lsZnhyWDd6VnhSWEFFbjVqenN4eWllSEdCbVJkcGc2M1FXN0RR?=
 =?utf-8?B?aEZYUEJNSnVMc282c3pRdkxoNmdpeXJHUGdKTGRoQUZDcHZHa2M4ZjJMRWpC?=
 =?utf-8?B?aXV6RkEzbWNYeUZheDVud3NwYzNncW9CaVlBTEF4ZXhIZDNiSi9VbHhQcUsx?=
 =?utf-8?B?a0xVNFpiRUkvZUxGZFI4ZHBZRzNvcktRcWVEdStYRWNWS2x5clFlUW8xalZH?=
 =?utf-8?B?bm81NXF2bHFzcVNrN0c4amczbklzSHQ4NUF6MG9BSW5QeENsSTljY1pncU1O?=
 =?utf-8?B?T1NlM2QrQk1zeWF5dTBlTUVNeUdnQ3ZWMWZnY0NOSzZ5NjIrWjhsYnJqY21q?=
 =?utf-8?B?UVdsOEZJdXpFMmxJS1pvNmxOb0ZobCtaZC9tMVExUGRPenNGYjJQay9RSk1C?=
 =?utf-8?B?T2hzS2x0RHA2TUpXUGVlOXkwanhoVUp0WnNLbGZBMDZlcXpjaEFhMjdBT1Vo?=
 =?utf-8?B?b0ZrS1RxVnpDb1ZNRUJ6UXBmNTlSWllIWVlHT3JGd3pTcGxpbkh1V2NyK2FK?=
 =?utf-8?B?OXA4ejRwdGRGblBQQzVZb3poYVhrVElWLzBEWWRkZno2aDl5UHRBaG5jNFMw?=
 =?utf-8?B?NmZpL0tnc29ZRVkyRXlhdERCc1VtSHhYVVlqRDE2VU9FNW1JQXJRck55Q2hU?=
 =?utf-8?B?bnhTT05lR1VpL3ZyWmliY0ducHdlamdvUXQ0ZXN4ZytobFgwYldXUGUySVdF?=
 =?utf-8?B?ekMvdlYxeXpPRkxxak9Jb1pud2JrK2RJaisxQ2Z3b3l4YU1JcTZXZlpEazcy?=
 =?utf-8?B?VTZ4SzJPN1NwVnI4dmhhN2l0YWVHM055c01SUW5oQnNzb3FwaUIzeFVncFJ2?=
 =?utf-8?B?c3FzN0d5YXlJVytOaUd4NDNXV251bDRBd0pZR3dESGE3SWxXUnBYTHRGTWtl?=
 =?utf-8?B?MWZmdFFCRXBQVFlOSmtpZ1dHUEtocm5ZU29ITnJEUXNMRm5MVTJkMWIwS0tO?=
 =?utf-8?B?dTFoanhIZ01EMi9Td29kVFppNjdDeEdLcFNiakhxR0htbjRmeGw2TGFyOGMv?=
 =?utf-8?B?b0xiZ1lkZVNadjQ5Zjc2aUlYMXVtZWkxUlQvbHVxRyttUnpBcm9hQVlzalJC?=
 =?utf-8?B?V0JRRlZGNEszUm9NNmZNWUFWZnBySWlIY2JSVWVRMmcwR2JDcEpSZDNUSFZr?=
 =?utf-8?B?azh4bnhGRklYSmxwdCtHYzhqUVVjLysxVGVlVkR6TVEwb0pCMDNJNmpJVVNW?=
 =?utf-8?B?RjJDM1B3UTdZSUEzYnlLcmtFcWxqQzNPcmpOQldJemtGWEJmQloxOWZlTERs?=
 =?utf-8?B?Y0x4eGJ1VjMvMXpUdTIyK1F4U2x1WHNNbWpqaWdZQkxxTkZiand3c1BMUVhS?=
 =?utf-8?B?RHl0eVpHWko1cVJDT0xHWkhHVGh5dFBvK0x5eUVvYnpPZXZvWFZZcFdQM2hD?=
 =?utf-8?Q?YyjjWSwbuMtFsqEUr61XcVlJFxU+d6k9dIo1U7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlFVVU5pQlV1SlduckI0bGxXTUxPU3VxZGNBOTFKMTl0bDY0SE0rSE5Ba0Rh?=
 =?utf-8?B?U2dQNlRTZ3c2MHVrSlJOeCtRR2dKRjl5UHVRSHhrNXY1N2VUWkwwQmlYVjZm?=
 =?utf-8?B?SGludVBYakxKa1c2M1lUUnFSNEUzbS84TW1aSG9IN0dJMTRUekxQODV3S0li?=
 =?utf-8?B?dFg1YWtMSEphaGFLVGVqcjZhOFYzWXBJbi9ObHg2M2wvUWdEd01KWEg1QWtw?=
 =?utf-8?B?NTAwbzhVK2hBTUVpbS9CN3ZLTlMycjR4ZjZYbG5kbXBHUUJUbTgyU2lNV1Z3?=
 =?utf-8?B?UlJHWFl5Y09yV1ZESXlpWkJadWo4YmV4dzlNcDVxUTJGN0lEZWFLSVhJMDdD?=
 =?utf-8?B?eTZYblZ0WGZObks1dDJVN1RzNHNscEo3RjZtYVhDK21xZWUzZXRHY3pidDI4?=
 =?utf-8?B?VzIwRHIrNFczcTJHMXJqNy93WFArQUQ3a1RFZC9hWHhicnN3cmlYQjJCV3JB?=
 =?utf-8?B?Q1pJajBNZzhHdTJSajRaNWFVMVp2UGVRMDZHQUdiMGp1TFdDOU5KN2xqQjR3?=
 =?utf-8?B?czhySXRwbVhxTGJDNjRKKzdhdVNFajRPaVlhN1dwRWQxYnU1M2lpZ2NpM2tJ?=
 =?utf-8?B?cE1pdzNLUlVGckJXRXkreSt2NGFHNjFHYjE4YkF2WDhHOXhxSHdUSkYzWjlw?=
 =?utf-8?B?Wm5Db2MrQUlOWm9MNXl0WlYvSXRRdE9sMDg3Q016RFhvSk16ZU50bllKODdN?=
 =?utf-8?B?M2xmWWgxcHEvSGxKNlA5WERPV2NxRUxTN3IvQklOVHJ4aDVuRmVkbWVxTnZD?=
 =?utf-8?B?V1RoeGpuMzltQjhqS25sVlBvTm5TaVJtdmsraW5OL2dJMVY5STFPRjcwS2Nj?=
 =?utf-8?B?b3RhenZ4U2QrcnBrakhUV1BTeDNOTjR1QWlaZFNlcWJMOUhtSzY0WUFqMDJJ?=
 =?utf-8?B?UEowdFBPRjV5SDBZanBLTjVXbmFYOWx4T1pBRnFMRjNMR1BTUWNJa2IxRmZI?=
 =?utf-8?B?NWRKb1p5TWdjMnV4TmVOOHFIU2F1YkxLdXpNaEN0ZGoxNVZWanpDaER1bUdL?=
 =?utf-8?B?ZTZuTnlwdEMzeHIxd25kck42NUpaYldqankxWlNDaFB6c09keEdVS3FwUWtH?=
 =?utf-8?B?YStIRDM4WWEreHJIaTgwVjZoaVhnL0ovQVJkSCt4VG4zZWNTUVcvam9uSGYy?=
 =?utf-8?B?L2U4YkR4QWwzRzV5TUxDUVo2VlFpblc4cGgvWjd2eGphQ3Z3YzFMcmN0WUM2?=
 =?utf-8?B?UGtGa0ZoVG1PK1ZlRWVjN1o5eVA0ckdMUVo4M0Ntc0svZTB4NCtIZHdnV2Ft?=
 =?utf-8?B?M3VyM0srcUJ6QU8zamNTajE0RndYVzNRN0gyYmRKNGFQc2VhdU5mRDlMY25t?=
 =?utf-8?B?NTU3Q0VOWTArMWszRHRnOVl1NmxiNFFXZ3U2NFVBTlkwSmVnZTJjL0U5OURu?=
 =?utf-8?B?ejB2TDc3THpqQkJZQmNpUHlOWWxKRnc5RERVa29vSDlTMVU4UnpEclhkYnlz?=
 =?utf-8?B?dktEM3VTWndualpwdmRDRGFWcHJ2MnRxSG1qbGRrQktNZGhGVnRmQzJlTFcv?=
 =?utf-8?B?VzBZdHVpdyt5TUIrZWdNbVZIdXJKd1BHMGdWaXJJQi9VS0pId2JFaTYxY0tj?=
 =?utf-8?B?QmtyanBWVm5mM1BJUVBuRFVxaXVpRDdnL3FheE5VL0NvdzFmMy9VNWxDLzln?=
 =?utf-8?B?eStFbjdKM293dmFTYlVsTURxR0s0RkVXK3RFNWwrQzc2akkzOHlRUk9EMENy?=
 =?utf-8?B?QXJab0R1TXhScTFkdStadXN4UmJjWDVBL0UyT05aVTRubjZxSE1IQm8wTnhD?=
 =?utf-8?B?NEFnNmphdW9hbXl5WDJUVWpRa1dodnJqVzhLK1IyeFNONGdMR0svQk83ay8y?=
 =?utf-8?B?Mi9QRXJsSGxHN2N5enFMR0ZJUmltTzcxY214TVNpUnYxdDZPMncwL3RHV2R6?=
 =?utf-8?B?cGhYZm5DQ0J0eUFZY3dxbFBHKzZmMFE5ZFk2bjNSazZxb0NnL2hXczdGNGpm?=
 =?utf-8?B?Nkt2MHZFWWF4a055NXIyNk1jNVRUR0JMT01QT2JUVFR4bXBnRjQxWUVMNmFD?=
 =?utf-8?B?K0J1Z0RJV0xvQmNwRGtlNWMxcjdBNHk2NXFIMHo5K3V5SjZ5clk2Yk1vS3Ro?=
 =?utf-8?B?L1JORFI5eVhBT0VOZWJQdVVDdERIa0JhTjkyNlhjeVEybXNRNHpDdVJlL1pv?=
 =?utf-8?Q?mB1jCC8L7lgJEuiiw1gzGgWt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1400ab-2300-4f46-884e-08dcbac4f492
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:50:26.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQnhByN+y4R4KiKndKx5TB8+aPXy74q/ziQhBJd6kDEm0GBc4nqeqoA8wFygy42gy6OsdAORwTD0JlpEIN36Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

I do not understand why you took this change from my patchset.

Maybe the other two patches have a pass, but this should not be removed 
from my patchset, not at least after discussing it publicly.

The reason you mentioned for doing it was for making things easier for 
the other changes in my larger patchset, but again, you should have 
discussed this first publicly, and second, I do not remember other large 
patchsets, far larger than mine, being partially picked up  by someone 
else but the patchset submitter, and sending those picked changes in 
another patchset.


On 8/6/24 06:52, Huang, Ying wrote:
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>
>> On Mon, 29 Jul 2024 16:46:11 +0800
>> Huang Ying <ying.huang@intel.com> wrote:
>>
>>> The memory range of a type2 accelerator should be managed by the type2
>>> accelerator specific driver instead of the common dax region drivers,
>>> as discussed in [1].
>>>
>>> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>>>
>>> So, in this patch, we skip dax regions creation for type2 accelerator
>>> device memory regions.
>>>
>>> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 9a483c8a32fd..b37e12bb4a35 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
>>>   					p->res->start, p->res->end, cxlr,
>>>   					is_system_ram) > 0)
>>>   			return 0;
>>> +		/*
>>> +		 * HDM-D[B] (device-memory) regions have accelerator
>>> +		 * specific usage, skip device-dax registration.
>>> +		 */
>>> +		if (cxlr->type == CXL_DECODER_DEVMEM)
>>> +			return 0;
>> As in previous need to be careful as that may not mean it's
>> an accelerator.
> Yes.  We need some other way to identify type2 devices.
>
>> However, we do need to deal with BI setup for HDM-DB type 3 devices
>> etc and to check the HDM Decoder capability registers to make sure
>> Supported Coherence model is appropriate. (e.g. 11 for host only or
>> device coherency - HDM-H/HDM-DB)
> Yes.  We need to check BI configuration too.
>
>>> +
>>> +		/* HDM-H routes to device-dax */
>>>   		return devm_cxl_add_dax_region(cxlr);
>>>   	default:
>>>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> --
> Best Regards,
> Huang, Ying
