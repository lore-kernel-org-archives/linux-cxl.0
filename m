Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3C1C1F22
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947895; cv=fail; b=iAy2n8ahJ9adoPrn8RIUS2SfDDaka8lL9SWQAibDfp+2mKFl4vNmHC7aMS9DSaU6uGSToYW++Y4TmRReWJDAYmwIix8knY8hBsyF7ug/FMixYAm5KcBWVr8uh7Vnt3WvLpGJb9Fo3LJRKOfNFAWDOOxi7kBz5E2Fg91d6X/ibJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947895; c=relaxed/simple;
	bh=zkOlvyF3qPdRWY0XC75ZifRk8WeaFx7b95DNtUECV/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C8qTaY0THKehy3teg6K9UplyXuDDHZ2l41V1IZ0aWhOeZSA9/JdAcOxD8g9+Uh9QN0xAnGyXRGCE+eeFP3Wv8CaKGStbSzo36a6Y/JU+VYyyBkk4ETxfDB/mQgAu2woCs4Z+tySXA93qyOo90ULGO06lZp5rT1t69flYtiUW4/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjwKYyoz; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjwKYyoz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqHkiOt7/FCi4RnfKeZuhSgW1MjzrhBmf+khUkWwjoK2JO7iRlncJkztRlg2NRYNK0gNzt87LEqRjjzjaiTagkmHQvEl4iUoIt1xHQVuwIc8msd/4QZpTSNxOY1WviUnW87Ir9yYnWSOve9TLagB7K6Hl4skeIyFHvDeekjVavByDs++Uzki15sFFwGMAKAnWvaPPgjyh+qSQ8lWQbjfRVKRZ13T93pvFi/sE7mp9IXvOVCwk1inbOs8PFeE9Ij4LBykJccHQ67uECRJl+aIGGmvHYWsmI/E83v2NiZUkeiNlisIcrHZrHD1sMZbA4mxLp5QRcj2CRXf6CRZZFQolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62pHCL2VlxfSFT8fdiSgcQlLUhgHKZ3hPjdPCdsyal0=;
 b=XsTUo6N8Q0LePZbrZQzMwSKgFzIPkn1Q0W6Rl7CyR9A43FlhQQyWjCg9pAtmEKregdymZECQU0X8xgdN6mG3C3sqNjUCmrQZp4I5qkwBNRcD7fZAHzMO8xMlH4iVjBTzaqMDiPJ07HGaDqtSQzl9klTjZkBLXBJxsUD8OAf+PIShd39NnX6r8QU3S1jB8ctq0y+o+DEAT7Sw3NgYdkzHHXATGI1NRzjNPHYtBysGL7hXiB1EtKjRVVFM+7vbbJobTVPFM1eD2LtoaNzjFMCCDl2iHIPzuvwN/Se173S6+S6M32za1bwAdr4O8ylwDm2TOcrzGbKwyuaIco7DRniclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62pHCL2VlxfSFT8fdiSgcQlLUhgHKZ3hPjdPCdsyal0=;
 b=fjwKYyozLJ5IGxNc+E3mPZMt2ljpWuHjH7M/SBFvYNA55XS0RQ7k68VbTENH6A9Rc7Q1pP2deILCZNeTFJkA850vYkC/QsgmvmykMWbRKuojLoWgARlchh6+CINxHg9StLINJUTZKt2h7ZpKKdMgDDmNqcN9R+JAq+0Xf2VenO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 20:11:30 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%3]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 20:11:30 +0000
Message-ID: <6432d25a-e4be-4628-88c9-24441b623d40@amd.com>
Date: Wed, 11 Dec 2024 14:11:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <Z1l4LSIIzmoInQXp@smile.fi.intel.com>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <Z1l4LSIIzmoInQXp@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:6e::34) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: a00dd64a-84e0-4d5d-4a4b-08dd1a20006f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mkg1TTdhUmk2MWZPTVRmdWptRFZ1MGcweHZvTlIvbXhSYVhIbENDRDNDZ3po?=
 =?utf-8?B?RndTWGFzTXUzcFRveitEZlNZVzZjV3hSNW5Wb1hybENSWjUrVytkUDA3RGR0?=
 =?utf-8?B?d3pQVzQrMHRVOVkwVmpaZFFzQlZyWm9ON3B0VnJoaE84dzdvRWplbk9sdFpj?=
 =?utf-8?B?NVJVZE5zdm1LeGxHWmNPeFBtdGcwWVA4aVNUU1d2S3ZIYnlVNEc2ckxwb0Yy?=
 =?utf-8?B?eGNmUkJPd0p1OTNZb1JHNkVTQkFLZWc0UWN1Y3c3Uk9Gd0dvZFQrb0ljR1Jo?=
 =?utf-8?B?WkNleTFsajJZc2RBRWxwYkVQNXF2TDBaUGJJVmdxUVpYamNOYjVqUnh1cFE0?=
 =?utf-8?B?aWNnRmFvb3RKcW1jMWU2NWJMMURHV0xBSFdNdk8xZjVtZnRNSndybTJpY3dP?=
 =?utf-8?B?cEpGd2l6NkRiVE81VjlQNVpnMFVNOHluVTdCVjNJaDk2eGRFMjZyNWZIclRP?=
 =?utf-8?B?VWlPamk1aGFVbGJuZGZCVjBhaWRJbGp1T3VnQkE3M2V4dUtaZ3l3NG1ERWVQ?=
 =?utf-8?B?WmhMR0N5TUROUUpNT0ZBZDA4cUg0QWZaTWRmeE5seWIzK3ErNnRDY3daa25V?=
 =?utf-8?B?RlNYbFVPaFEySnlsbzRyYkFpeHREZm5yMnNwZlNPa2VMNVZtZ1JpdElObEMx?=
 =?utf-8?B?SkNERk0xS00vSStOUTBnN0U0Q0ZVaXAyVVlGaHJVU2MxQ2liVVRrUXZ2WWNw?=
 =?utf-8?B?SWd5T0ZtakZ0LzNGSkdLNFcyRXFDZzJPZC9XbS9pMGhoK1oxQ250MEt5WDQy?=
 =?utf-8?B?NUM3UjZTeFJUUmNuNUY5SDBkR0o1b1loZ1JmMVFlbERZNjNGcnlSMTI1YVNu?=
 =?utf-8?B?d09iYVpQN2o1NVJGMXRKVGpyaWxENzVWWEtEUXNRRWNSZ2VLYlFTRUpBVkVu?=
 =?utf-8?B?eS81ako3TThzS3oydnFIOU9KbWJReFh0VHU4KzJnRkFIS3FyWkl2Zk5LaUpi?=
 =?utf-8?B?cWdqVVdOak8rVGsxZmc3UTVXMnJKeGtYUDJYZWsrYnRPTlhzZ2w2UFZCTkg5?=
 =?utf-8?B?K3ZWTmx1VHNhZVJ3ZzFMUGowZyswcUs0VFRiSDc3UEl6dUdRcjFZZmR4c3hn?=
 =?utf-8?B?dklMUStnVzRZMFU4ZWxCa3lMZGVUd1FwOHVZMmM4OVJrOWVpMjlsTU5ROWtK?=
 =?utf-8?B?RWY4Z3grRVdORnhEYm1DSjMyVGZET21VL0R1ZEJCTzI2cGFsYTZjYlNaeWRV?=
 =?utf-8?B?akZ3bXUxWkdRMnBJbnpJMlFsV1dJNzhhSjgzamNpU2drakhSeHljVGllR1Ra?=
 =?utf-8?B?LzRWbEpOMDBQd3FVMVdOR2h1UVB1NFpxUStCaVhhQW1WcUVqT1VXMVZCU0lX?=
 =?utf-8?B?WUFTSEczbU5KZjVEZ0hRQ3VWcGZXNmpzS2p1SnFyMTJSY01lektoTkNVakt4?=
 =?utf-8?B?a21YNTJFWEhQam5tekpOME9ZZ2JySXdyYVd5anpDbm5IUGtMOExMdWFJYWxh?=
 =?utf-8?B?c2xpeHYzRzBEdUI2dThEYmpoakdmT0J2WmlXOTE0TEtESmJOUENBM3dBbnUr?=
 =?utf-8?B?UUh4a1h1ZFhKUGFhc29PSko0MHhYSmJuS2NNbERtMnNra1k0WXVqSjBoSUFB?=
 =?utf-8?B?TmtFZEo4VDdaQXd0aFZIcHZkOEhOVUFFMTlONFUrS3JVa2RxQm1rS3JrRmoy?=
 =?utf-8?B?SEFscTBEYm15VEF2MWJOVHlhZjZhZjM4dkVNajUrblg5bXkrcmU3QjU1OGF5?=
 =?utf-8?B?TENySjc3V1BRSjdjaHF3eE9wWTZ1Y1lic0lzMDNKaVNVRVpIZEt2RmpBMU9M?=
 =?utf-8?B?WGNHSUxnOVFITUtpNVdtWVd4U1NBYXIvbFRGU3dNblM4enBIcWErVzRVMCsx?=
 =?utf-8?B?amRyWlUrdlYvL2dad2crQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5BZjFYdEZVUnJjL29LVVdiNUJZMnd4eXl5K2lpYlYzR0hiTkEweVI0L1JX?=
 =?utf-8?B?OGUrVkRQOFh4NVNTOTRRZEozbFFsbVlzVWJHQ0FhbUl4dmxSbkpXOUtma1dr?=
 =?utf-8?B?Si9rSWx4WlJNUWtWM3h1QVpIRnNTMWJtUnN1bmI2Nk01T0R6VVQxNG9DVlVB?=
 =?utf-8?B?M0NvakNnMEF6cXBEaVBPUjg1cTc0RnNLanBIeld2bXNBUGN0MGZmY1hLY3Nl?=
 =?utf-8?B?eDdQQ3o3a1NsR0pzQVN2U2FSb0dJMjVadmVyTXQ4MXIxUzN6c3lPSU5YMjZK?=
 =?utf-8?B?UWprVDJIYmFVKzluOCtkQTdvcHRsRmtaYlhwL09jaU8xekhiUWJnbXNuVlZr?=
 =?utf-8?B?UXJEQ0tKa204WnY1UkRKWURNbXAwZFBRYjlrUmwxVnowcWQ5STdhZ0RqVkVS?=
 =?utf-8?B?L00yRk00N05iQnlvOWZXcDJuTE9uMExvZTdGRDdzN0prOER6cmoxYXRZb0w1?=
 =?utf-8?B?b29lQm1DYWxtVjR2SW1uTkRZd3JqN3htUENLcHdtNzJhZVJBY3NjV0tSUGM0?=
 =?utf-8?B?RlA0dTlPWjdLbzZheW1VMUw5Zi9TTHFBUVU2SkNNUVVEeXZYNmh0ZTRJRFFh?=
 =?utf-8?B?Q1VsZXE5ckdqbjVDL21sd2tmTGtlaGJZN3VNYkRjTHVXN21Va3lIbUdBcVJ4?=
 =?utf-8?B?VUZRWFBhdldqS2h1WENOZVg4b29ZZUNhV3RjK1JZZDFOUGkzV2ZoZzFJNUtw?=
 =?utf-8?B?VVBzK2tESklNNjhwdm5wdUZVN3NxbGZlR2JMRzVMU2p1UjljMmpZZlZjSTdy?=
 =?utf-8?B?LytyMXJLRWd6NDJIMzFMS01ZYnh1UlJWVGlyRG9NaTJ1S2NmSm83TmdvVHli?=
 =?utf-8?B?bEtWKzhhc2xiQmhNbWpuV0d5Z1Q5MDIrZDMzOTRZbVk3ZDVNeGVuNml2djRY?=
 =?utf-8?B?YlhJbkJvbDJUUkdqNURhaGZpdVpnNFB3bExnM1o2KzN4MlZyaHFIMWdwbFZ2?=
 =?utf-8?B?UVR6MGt6TUU0YlFkK3ZMTnFnTFgvMHlnRjh3MEZTSGJIRzB3ZE80Wk52Zm1q?=
 =?utf-8?B?Z0djam1zUFRiMWFjKzZCTUN3c0t6VkFrYVk5eW1aeXd3Y2w5VHpwMld3N3E2?=
 =?utf-8?B?RDlTeVV3TWlTV0h3LzZnSXlhZzJ1UkNGSGpJeFpXUnREMER6c0tpblpuVE5S?=
 =?utf-8?B?cDJjQVkxS25oaFpMNDIwWi9IZE1ZeVJYOFB0a0dGZHpGQVk4WGFKUVh5WmUz?=
 =?utf-8?B?VmljRTdYY25NSDBLcm9lL3NoN0c5U21BSDltNDdDb2JkTGx5T0ptSjZLM2Rq?=
 =?utf-8?B?ZGxGQU1yVkpXZ2ZHY05JZ2J1Y1ZpLzdCdUFKR1JYOEhHOE93c2Y0NGFLTzZa?=
 =?utf-8?B?cWJLS3ByNVRGakVjS096S2J4TEprSzR6UXpsZkJORVF1M29mdlkrcUs0cjhv?=
 =?utf-8?B?ZXRXdGUxWHNsSzFzZUJidFc5Ly96cjM4VlpmWE41Q0N5K1BCazFxU0VnUlpt?=
 =?utf-8?B?d3NRVFd0bHJURWZEdU9Ob3VsVGdSZkFwN3A4L0p2L2tBak4xTmxhVGVjYm12?=
 =?utf-8?B?bDk4OWJLNXlvNHBWZWovb2FZOHlaMGpXU0U2YVpxWnVaUVAxSytVa0NKMFg4?=
 =?utf-8?B?ejkyQ3FUelNEbjJIZHlWQTRlN21tRzVVcFlXYXZoSjI5SmF1REVXQVFNc1Rh?=
 =?utf-8?B?b1c5YTkxVlBjdXdDK0tod1JKQzh3aUpFbEpKMW9YRDhHbzNjN0ovZ1JBUVJs?=
 =?utf-8?B?VTJFVUxKS040dkl6SUhNb0VURmRnRkFNV2tLMHF5MXZXUm43WE40YWNOZmU1?=
 =?utf-8?B?aGdoZHVmTFNhSmowQ2kvRENBVkM1KzkwMENiM294cWlwMW5yODFicXRkMjI1?=
 =?utf-8?B?b21rbW16d1FGczZwbHNybW5CUEpFRnFyRm1YbERIWm95MkZGbCtEZ1hMZXQ0?=
 =?utf-8?B?MlF0Tzc3dldCNHVscXVFejRZa1hGdzN0cE02bE5qbjR2QWxsbC9nS3Bka2Uy?=
 =?utf-8?B?Q0F6WmVSTzhGNGRLRFJWYkFwWk9iRTZ1RnlVckduZWsvSmF2WHN3U1IwbDRu?=
 =?utf-8?B?cTZJcnA2VVVVRmRRNHJhU3FQTVQzUVJKb3ZiT3V3S2Z2eEFjWHZRSnZIN2cy?=
 =?utf-8?B?Z3B1emd5cUVRckpqa0U5UlRaTkt1THNncWdtUTlOdURtOWpHdFBzTzhqVjNG?=
 =?utf-8?Q?2W+fLDgCMbixUGWiKUnEPeINL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00dd64a-84e0-4d5d-4a4b-08dd1a20006f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:11:30.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYtsXel3NrgNQLd3rni1by2UZnuDoR+Qvrz41dYWo5+/anWOZbXhXfvmdoHy0ERddKJHsfWGCfBmexZaTzuhpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

responses below...

On 12/11/2024 5:31 AM, Andy Shevchenko wrote:
> On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
>> Update handling of SOFT RESERVE iomem resources that intersect with
>> CXL region resources to remove the intersections from the SOFT RESERVE
>> resources. The current approach of leaving the SOFT RESERVE
>> resource as is can cause failures during hotplug replace of CXL
>> devices because the resource is not available for reuse after
>> teardown of the CXL device.
>>
>> The approach is to trim out any pieces of SOFT RESERVE resources
>> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
>> resources that intersect with a CFMWS into a separate resource tree
>> during e820__reserve_resources_late() that would have been otherwise
>> added to the iomem resource tree.
>>
>> As CXL regions are created the cxl resource created for the new
>> region is used to trim intersections from the SOFT RESERVE
>> resources that were previously set aside.
>>
>> Once CXL device probe has completed ant remaining SOFT RESERVE resources
>> remaining are added to the iomem resource tree. As each resource
>> is added to the oiomem resource tree a new notifier chain is invoked
>> to notify the dax driver of newly added SOFT RESERVE resources so that
>> the dax driver can consume them.
> 
> ...
> 
>>  void __init e820__reserve_resources_late(void)
>>  {
>> -	int i;
>>  	struct resource *res;
>> +	int i;
> 
> Unrelated change.
> 
> ...
> 
>> -	for (i = 0; i < e820_table->nr_entries; i++) {
> 
>> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
> 
> 
>> -		res++;
> 
> Unrelated change.

I can remove these unrelated changes.

> 
> 
>>  	}
> 
> ...
> 
>> +static struct notifier_block hmem_nb = {
>> +	.notifier_call = dax_hmem_cb
> 
> It's better to leave trailing comma as it reduces churn in the future is
> anything to add here.
> 
>> +};
> 
> ...
> 
>> +++ b/drivers/dax/hmem/hmem.h
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef _HMEM_H
>> +#define _HMEM_H
> 
> This needs a few forward declarations
> 
> struct device;
> struct platform_device;
> struct resource;

The next version of the patch removes this newly created .h file but good point
for any new headers created.
 
> 
>> +typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
>> +			    const struct resource *res);
>> +int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>> +
>> +extern struct platform_device *hmem_pdev;
>> +
>> +#endif
> 
> ...
> 
>>  #include <linux/compiler.h>
>>  #include <linux/minmax.h>
>>  #include <linux/types.h>
>> +#include <linux/notifier.h>
> 
> I would put it before types.h to have more ordered piece.

will do.

> 
> ...
> 
>> +extern void trim_soft_reserve_resources(const struct resource *res);
>> +extern void merge_soft_reserve_resources(void);
>> +extern int insert_soft_reserve_resource(struct resource *res);
>> +extern int register_soft_reserve_notifier(struct notifier_block *nb);
>> +extern int unregister_soft_reserve_notifier(struct notifier_block *nb);
> 
> Why extern?

You're correct, extern isn't needed. I used it to follow what is done for other
declarations in the file only.

> 
> ...
> 
>> +++ b/kernel/resource.c
>> @@ -30,7 +30,7 @@
>>  #include <linux/string.h>
>>  #include <linux/vmalloc.h>
>>  #include <asm/io.h>
>> -
>> +#include <linux/acpi.h>
> 
> We don't usually interleave linux and asm headers, moreover the list seems to
> be sorted (ordered, please preserve the ordering).
> 

Good point, I'll correct this.

> ...
> 
>> +struct resource srmem_resource = {
>> +	.name	= "Soft Reserved mem",
>> +	.start	= 0,
>> +	.end	= -1,
>> +	.flags	= IORESOURCE_MEM,
> 
> This can use DEFINE_RES_MEM_NAMED() as well.

Yes. I went with this format since it is what is used for the other two
struct resource definitions currently in the file.

> 
>> +};
> 
> ...
> 
>> +	if (sr_res->start == res->start && sr_res->end == res->end) {
> 
> Wondering if we have a helper to exact match the resource by range...

I don't remember seeing one but will investigate.

> 
>> +		release_resource(sr_res);
>> +		free_resource(sr_res);
>> +	} else if (sr_res->start == res->start) {
>> +		WARN_ON(adjust_resource(sr_res, res->end + 1,
>> +					sr_res->end - res->end));
>> +	} else if (sr_res->end == res->end) {
>> +		WARN_ON(adjust_resource(sr_res, sr_res->start,
>> +					res->start - sr_res->start));
>> +	} else {
>> +		/*
>> +		 * Adjust existing resource to cover the resource
>> +		 * range prior to the range to be trimmed.
>> +		 */
>> +		adjust_resource(sr_res, sr_res->start,
>> +				res->start - sr_res->start);
>> +
>> +		/*
>> +		 * Add new resource to cover the resource range for
>> +		 * the range after the range to be trimmed.
>> +		 */
>> +		new_res = alloc_resource(GFP_KERNEL);
>> +		if (!new_res)
>> +			return;
>> +
>> +		*new_res = DEFINE_RES_NAMED(res->end + 1, sr_res->end - res->end,
>> +					    "Soft Reserved", sr_res->flags);
>> +		new_res->desc = IORES_DESC_SOFT_RESERVED;
>> +		insert_resource(&srmem_resource, new_res);
>> +	}
> 
> ...
> 
>> +void trim_soft_reserve_resources(const struct resource *res)
>> +{
>> +	struct resource *sr_res;
>> +
>> +	write_lock(&srmem_resource_lock);
>> +	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {
> 
> Can this utilise for_each_resource*()?
> Ditto for the rest of open coded for each type of loops.

This one could use for_each_resource(). There is one loop that cannot since it
moves struct resources from one list to another.

> 
>> +		if (resource_contains(sr_res, res)) {
>> +			trim_soft_reserve(sr_res, res);
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&srmem_resource_lock);
>> +}
> 
> ...
> 
>> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
>> +				   cfmws->base_hpa + cfmws->window_size);
> 
> Can be one line.
> But is this correct? The parameters are start,size, and here it seems like start,end.

Good catch. I'll fix this.

> 
> ...
> 
>> +static bool resource_overlaps_cfmws(struct resource *res)
>> +{
>> +	struct srmem_arg arg = {
>> +		.res = res,
> 
>> +		.overlaps = 0
> Keep trailing comma.

will do.

> 
>> +	};
>> +
>> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
> 
>> +	if (arg.overlaps)
>> +		return true;
>> +
>> +	return false;
> 
> 	return arg.overlaps;
> 
>> +}
> 
> ...
> 
>> +int insert_soft_reserve_resource(struct resource *res)
>> +{
>> +	if (resource_overlaps_cfmws(res)) {
>> +		pr_info("Reserving Soft Reserve %pr\n", res);
> 
> Btw, do we have pr_fmt() defined in this file?

Yes, there is a pr_fmt for kernel/resource.c

Thanks for the review.

-Nathan

> 
>> +		return insert_resource(&srmem_resource, res);
>> +	}
>> +
>> +	return insert_resource(&iomem_resource, res);
>> +}
> 

