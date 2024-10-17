Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D61D517F
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176557; cv=fail; b=ifbgVAF3AKQs2NWDfyYpmNv9z5/AN/SNzbun5/iecggO412EeKH7tNmOjHES3XYVE1Cr+RrbdRm9LHWuMoliX3gVaYRRPO0weVbVpNBYl3RRWnOwr++Mx/Ngyea/WVdS9UuIYhsMD8vHoCRoQmw21gHCLvX8Lmts6kItA5B9bo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176557; c=relaxed/simple;
	bh=XRBSVcOtrw0DdXm0xEF3108LM/TmXVHwlBiQ5nK6LoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WEGtJcT2lU7SuegxqRqtvRDK6wDa0ejo++t4fC6K3erdmILbmGqIWN6yIDeNrF/4QQ9KNm876feKE5mLEKhdYT1Ne+S8AqqRKpldtTu2RoZPrVRW/if5bOqC3VSBfXFgrjwPo77k6/u5FCC0Cjj/vNy8yBnJehtiRCYT5kUcT0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/LQ0UTI; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/LQ0UTI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQd2jbLv25QWSc0bRb5oqrW0Gludfw3aT7Tg/UGc9DWqmhPiK7UpRyNqbyJQv7gb82HhxqO0tlFTSa2rl24nbzY/f4ZWN7ax8p+q/EhE9T9j6wzbTSx0aDkcWeDUzCKfhqL397ceTO+YOd/nmrodUjdY0FhYHFAVGvNFIaNFZ/sE8nEWmlfrN44O4COAPWTueYEUBqLACPOH9OTY7Wl978H59B4Cf7IMuS3ZdJGAjuAgvc79JMg4ov5rPhFGvTZiNZGKSmVsjJTjVGcLI1mCGYP2YFezJ3TJJLSnuoS3zXAVPw+NHOehu/vfJi3HSI+hhI6KPEsWeHhaihZMmBOOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VR+J6TRtsUpxobzVIXDTyZnKNNjR244IIGFVXj/+Ns=;
 b=nDnsdHAh7yHpcdgRJVxoHars597sXJq44YQWJdY4OUT/foEFPAmonO2xw7KSWWMG+uVrWmL+5DV05qOc5g0PhKiXe89IS8qjX/bVPpMZOquBd7NJRkoDhBxUvvadOQkauVb3oBVSKB8arSAfFoyoHVLlGEkyr5dU8CIWAvbBGlckWJiItYXdxev6pydifoNxi7M6HUK1uMR0YrFXmeTjNYJFz5ZKwBgl2BxLcFB6il1tiX4DFAuavZXWu33O7KjiXIvqavrIkHjWRHzeMaHS7qh7z5i6yDCAP1svm4jfQe2bvjbDu+7hqoCCzdHmSn8hC86N0XM2QpeNk5vfP3Z0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VR+J6TRtsUpxobzVIXDTyZnKNNjR244IIGFVXj/+Ns=;
 b=b/LQ0UTILiibBxGyh98WXc5eGMcCJqjGt6H5UXiFRsBCH/kd6SDnnFF6l8YM53Cb81o2XEHUMZtH3pzQMo+VIDd6Gq5zCH2j4ooC6ts+0NdS2/dWyFH5JnFQ8X7ywsHpKZBZidXNx0h/Mu4d8BI1W2Owr3OkCAMyrTMrUFNp18k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:49:05 +0000
Received: from SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::d21d:ab2:c96c:57f2]) by SJ1PR12MB6217.namprd12.prod.outlook.com
 ([fe80::d21d:ab2:c96c:57f2%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 14:49:04 +0000
Message-ID: <45f3d3e7-4145-4bc9-96bb-98d7c10c35e0@amd.com>
Date: Thu, 17 Oct 2024 09:49:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cxl: Update Soft Reserved resources upon region creation
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20241004181754.8960-1-nathan.fontenot@amd.com>
 <20241016164324.000037b9@Huawei.com>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <20241016164324.000037b9@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:806:d0::30) To SJ1PR12MB6217.namprd12.prod.outlook.com
 (2603:10b6:a03:458::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6217:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: e98608ce-b5de-4c94-8e0a-08dceebad87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHF1dWZ5RkQzNEQ3R05NRWxuOWR4VEVpZHR1c28za3pYM3ZSd2lKaEU1Y1c3?=
 =?utf-8?B?Qkd0VHVxS1FRRTR6N3hCd2NSWENoU2NaRHFyZTRLQmpWNWNBVmpUUUVrZ0t4?=
 =?utf-8?B?dThNYzBNcHptemZ6WEZxQWFjSk9La1NSc25HZzRMb2J3YXpnUTlvWTVldHZO?=
 =?utf-8?B?SlJoMGxqSmdNcWRnWDUrTlcwM0orMUtJaHVxWit2SXM5U2t5bWxtS24wcnNn?=
 =?utf-8?B?bGVhNFFQT0lvVmRyQUpyQm1HQ3FkcFkzd29RNWQ3T2VnQ1pNQnYwbXlaeWh3?=
 =?utf-8?B?M1NvUHpFTGI5aXdUckVyQUpGZHFhTk5rbEhseFRqdFJHSk1HYUlzeWJsMTNR?=
 =?utf-8?B?WlV6K1lGVzdCRFBWOGdMeHVWMFlzSkVvMkFXSU9iRjQ2ekJROEtQMWJ0alBG?=
 =?utf-8?B?dmdoRU9idkdMeHN6cFNOZVcvcEREOW9VSDc3NEdoQWp5NFhJeGJmSXEwd2Y2?=
 =?utf-8?B?YTU4bGU3VlgxZk1Sa2NrSW1yMDY0UElaWUx6SDc5Zm5tU2dhenlVWEg5STd3?=
 =?utf-8?B?bEVvYXpkSXBuWFJmVGwrcm04Z3M1aTBPMmt0WmVjdVRPMmNjakJDc3JlSUNP?=
 =?utf-8?B?cFdTUmdJQzBTSVNsUFNmZHl2ODNiQk1Cdmo4K0ZWVWltWkV1RE5hTUNxL1I1?=
 =?utf-8?B?TGJFOE4zSi8wcmFwc2pGYjgzclJVL3dWYUtvTU52Z2NPbWhvTlIvQ1p4alZq?=
 =?utf-8?B?OHdnM0xnbmZXY2tGYjVWRTNIemhlc3VHajB5RlZIUkJkKzJSOEFTcUJFMTZx?=
 =?utf-8?B?R21lM2p2L1lnaDU0M2tCSy9RRGdyYjRXbDdqdGRTL3ZtSmJ4bld1SkhoQkFy?=
 =?utf-8?B?WUd4RU1keG10aGY1Sml6V092VVJ6TEtSMHpveEN3ZFNZU1FsRWx6QmJRZHBZ?=
 =?utf-8?B?TThkSmY5RlhTK2RzZWZKY3hPQmtIZGxkQ2NQZVhob1l0dUNjZHdRbjdtU3ow?=
 =?utf-8?B?NU1RRU9NUkJtd2ZuZ1MrZ3ZVT1RkanRzQnhDYk1QQmJQbzJvbHU4Rlc4SjBG?=
 =?utf-8?B?VmJpUmhuRnp0RVRSWVE3dkl4RzhSYWhqdjN0QVNZWnFVbHVxcjVkK2QrcTd3?=
 =?utf-8?B?aDhGSDI5MkVWc2tsektQTDBOeVFGNTVlVEZzOStLZ2NTaXlzdEhLYkYrK2hy?=
 =?utf-8?B?TGdnU3hYRUxvOG9RRDdOa2w5UEMrL3NaRmRuT2lENEh0T3hhaDZOZWliUUVh?=
 =?utf-8?B?OUV4d1pDQ2JDdDVaVXV2QkhVaGx6blRUWVJKUS8zN2huTW5NRTFGTm1IMnhs?=
 =?utf-8?B?Y0loRFJ2MzBLcmVUdTl1eEhPdGZUUXNRVjF1MFBtcWxWdDBoMi9VZk40OFpI?=
 =?utf-8?B?ZzFaOFRLV2lZbDdqVTJxdjhzNkxmajBKVTkwV3NIK1dpRHJ4K2prZWkzMmVv?=
 =?utf-8?B?b1h1NlNBMXZCc09rTExIbTV0ZTJQUEEzcUQrdkRRZW8rZmF3ODBvNzJTd0J5?=
 =?utf-8?B?MjdqTXZwcktxb2RpL1BCdnpSYXZ5cVAvQUcraHAvaGNLQUFyeHdlSG1kNWpw?=
 =?utf-8?B?aHZkZThMUlFaNVEzbU9DRFpnOXdpdlpWY0VVWm02dEZQbk8wN1FIdGdmd2dz?=
 =?utf-8?B?Nm5ZYXdWRE5pY2ZnMzh5MTJoWkkrYmcwWnRlWmJhUzVlWHJKKzY5ZEZRTVhs?=
 =?utf-8?B?Q2h6Z1V1bVozYjdEL1Njc2lmWXFBcGxHMysyZzhyY0lVTkZ4NXg2VStNcDQ5?=
 =?utf-8?B?bWtZZWxrY0UyV3ZKWWhKK3dva1I2RXcrSExBVVhUV2t3NkE1QzcvWTc0anc1?=
 =?utf-8?Q?JMDSqA6LuOu5b/Iups1gddZ0yOTSES2S108iUAp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzV5MFJDbXNiY2RNaFFlc2ErUThjWkF4V2VZdGVKQ3N2RnNzWm9BQUN1dnVI?=
 =?utf-8?B?OWc1bVRBTnIyRGhBbGVrd3lId0VkYVFSV1hXUnFMMnFCMTVoQlBBbWZFUXV1?=
 =?utf-8?B?d3pGMUVTNTJxMmpSaGJnR3RmN1NTNWZ1Nmd5UUdTZTh6VWkrTnNjQVE5Q2pl?=
 =?utf-8?B?SWg4dnJTSkNWeTI1TGROeG5jbzFQZ3o3d1F6eWVhN0tYVTJDdE1hTDRQbmpR?=
 =?utf-8?B?S0xaNi84OGwrVDZrTlY2SkY2R2xmTUlhOGhtM2dVWVJGNmpFQkRzMWRFWjh3?=
 =?utf-8?B?VE5rN1BCUUY3d1hQVDNGZDZtVkVCbW80dG5wd3MwV1Urd3VKNk1hZjY0eVd3?=
 =?utf-8?B?cGJzMmlhcFZqUTBZa0kvOGlqYlM3aCt6WXY0R21PMm9xVEZKNStkSkxYekNs?=
 =?utf-8?B?cjJmY2JZbG9teGEvYlVtVVpQNHV3K3JOVWtOK0RLZE05MGNTOS9WMjF2WGZt?=
 =?utf-8?B?ZWY5MFd0T1AvSjZmZENuV1NJOElUM29tWkpuR0tnWVJINEo1aVo0WkgwWjNr?=
 =?utf-8?B?eFRVTmFpSGpyNzk3UWlBdUtWSno3STE5R0o4VVdRTDYxRE90Rjl4RVZzSTJM?=
 =?utf-8?B?dkVLNzBPcFhiNW04WjMySTgrb0J4bzh2TFFkZUxhdFVyN1JQa3h5OENyWWZl?=
 =?utf-8?B?RGQxT2h0YktjZFI0cHYwSEVER25JNFlRd2xLanUrSGV3WWZ3dDZZdDRMOC9E?=
 =?utf-8?B?ekY4Q1NaZE95ZVYzNEhQcTdhaHBRakt1bHQ0MXgvRXIvU3k0YlhxcjNZU1Jk?=
 =?utf-8?B?L2M5cHZZRVl6U1F3L0pSRERSNy9OUHkvZzRZYzJmYlo5QjJzbUVmUFFENWpL?=
 =?utf-8?B?dkl6YlVuUVhiU1FtQVU5MVZYTlFNS0RPWWwyWnljcGxIeG9KK1E4R24zUnZO?=
 =?utf-8?B?dTZmUHRZSk1HckkrblNnTDdqMzltaTNjdkRpQ1lMS0J1K2dsQmZUdlRCL0N5?=
 =?utf-8?B?YzZXMm95eXJRS3NNTjlQK0VpVFh5TlF5T3Y4emVqMDAvNExwVGJMM2tTNThS?=
 =?utf-8?B?UUNma0NUeU9QbThQNXpBeTRIa3RaNjVVRGdVVVRvTnZtSnQ2dHU3Q3p0cEdO?=
 =?utf-8?B?TzBraFJFdG15b1NEYU4wQktMWllMZk43WXQrbWlDSjJhT3RWWi9sMGtPVmYw?=
 =?utf-8?B?d0hJRXI4RnpHREliR0FpY05uK29TaldyZXhmcjgxNFNCejV0a2xwK3ArMmJp?=
 =?utf-8?B?NFFyOTdQWVhBU3NEa1M4S0R2d2EvOFVSOTlhVzhjV2RnSzJKWWNpdmcvQUVa?=
 =?utf-8?B?VTFKeHVOK3JDSDYvZ3lRT2JCdDNBVTNtbDUrWjY5Z0NzUmNSTjFKck00Ri9Q?=
 =?utf-8?B?cmZNaGFqdCtPM2JVNjQxT05JMVhzM2FTNUNBMzRLaU9KSGFGbEdZVDZSTm5O?=
 =?utf-8?B?S3FiT1pSN0FzNEZRb2NIM0hHeGJPdEl1K3hUaFdOVHoxQ1hkeG94MTFRK3Rl?=
 =?utf-8?B?eTVGUWhqTGJrSFRrMGlDQW9uN1plWFVjUHNTYXUrc0hqZm8ydkp1cmsySnlM?=
 =?utf-8?B?L2ZPc2lacEczL0h1R21hY0tYbW1IeVo2bElJRGNDN243MzVLenIrYnFEV0tZ?=
 =?utf-8?B?QU1BemRKMFpMQTFBVzFYQi8ybDc2U2ZKT3FGTWlDVXpDK1Z5bVM5UFNxcjJD?=
 =?utf-8?B?NGlXRFJjNUQ5VHJ1aHBHdGlQU1hiTkF3SC9iMVlhNHVOdkRPV2FKcHVhZkJ2?=
 =?utf-8?B?UjBVZ01LSmgrckFFdUtzNVpEdVV0WTBHTnBUOW1DaVpGK2VxcE1LSVlpaXNI?=
 =?utf-8?B?bUIzYVlNQ0k4Nm83SC95SDFNTHBna25iMmJDVDFaQ3NzM3U5TWIrekJoNnhF?=
 =?utf-8?B?UUlQSVdoeXVXWDBRenkvZmc1RXhTLy95cTV1VXMrUENGOXdhVERvaHlCa09z?=
 =?utf-8?B?WXQyTExGZ1pOanBPVXFjWEVNRGJhajFGdDB1S011NU83aEJMb3diWU4zbjIr?=
 =?utf-8?B?ZFJ1NmJhNm82aHhnZlZiSGx2QmZ6L0xrSWU1MmprS1BsZlg0R0JwUmpwTGp4?=
 =?utf-8?B?MDZLTno0R2FNZGM4TGEwZUt6UXZBOVAva25nQThsUGIxd3Y5K2VlUXp4VDkw?=
 =?utf-8?B?SFJ2NjR1eVpxWjlZbTNud2Y4andrS3MyUjlZb1hSc2VHaHhLKy9iZlYzZ1U1?=
 =?utf-8?Q?p/knvUPqT5JqocF2jE8FVZ4lN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98608ce-b5de-4c94-8e0a-08dceebad87b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:49:04.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EqlE5iS/ABPrA5TfBzdfRgCcwFR1MPqpojDpfPMKqgCVURcpmHCAIhIUmBN0zZcGaPhlIunoj/6oRoVOMxdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

Hi Jonathan,

On 10/16/2024 10:43 AM, Jonathan Cameron wrote:
> On Fri, 4 Oct 2024 13:17:54 -0500
> Nathan Fontenot <nathan.fontenot@amd.com> wrote:
> 
>> Update handling of SOFT RESERVE iomem resources that intersect with
>> CXL region resources to remove the intersections from the SOFT RESERVE
>> resources. The current approach of leaving the SOFT RESERVE
>> resource as is can cause failures during hotplug replace of CXL
>> devices because the resource is not available for reuse after
>> teardown.
> Good to give an example here + any debug error messages etc.

Good point. I'll include a better explanation of the failure with examples
in the next version.

> 
>>
>> The approach sought is to trim out any pieces of SOFT RESERVE
>> resources that intersect with CXL regions. To do this, first set
>> aside any SOFT RESERVE resources that intersect with a CFMWS
>> into a separate resource tree during e820__reserve_resources_late()
>> that would have been otherwise added to the iomem resource tree.
>>
>> As CXL regions are created the cxl resource created for the new
>> region is used to trim intersections from the SOFT RESERVE
>> resources that were previously set aside.
>>
>> The next steps are to add any SOFT RESERVE resources remaining to the
>> iomem resource tree after CXL device probe completes and to notify
>> the dax driver so it may consume the added SOFT RESERVE resources.
>>
>> This patch includes the use of a delayed work queue to wait
>> for CXL device probe completion and then have a worker thread add
>> any remaining SOFT RESERVE resources to the iomem resource tree.
>>
>> Not in this patch is notification of the dax driver so it may consume
>> the SOFT RESERVE resources.
>>
>> The goal of presenting this RFC is to drive discussion of the
>> current approach for trimming SOFT RESERVE resources, the use of
>> a delayed work queue to add remaining SOFT RESERVE resources to
>> the iomem resource tree, and methods for notifying the dax driver
>> of any newly added SOFT RESERVE resources.
>>
>> NOTE: As this is a RFC the temporary pr_err("CXL DEBUG...")  messages
>> have been left in to aid in testing and validation.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Trivial, but why Alison's SoB?  She didn't send the patch which would
> be normal reason for last SoB in a list like this (handling of the patch).
> 
> Maybe a Co-developed-by is missing?

Alison helped develop the code so a Co-developed-by should be here.

> 
> Whilst I appreciate this is an RFC, the arch specific bleed
> into CXL code needs to go.  + we need some info here on whether this
> is an x86 specific issue.  I'm fairly sure it's not and that should
> be called out as future work.

As far as I know this is an x86 issue for handling the SOFT RESERVE
resources, if other arches are seeing this than we need to update the approach.

> 
> Also, much of this is actually generic, with only a few bits
> being e820 related.  Can we pull the soft reserve list etc out
> of them into generic code.

Yes, we could do that. The handling of the soft reserve list doesn't
need to live in the e820 code.

> 
> To me the general approach seems reasonable but I'd suggest +CC linux-mm
> as the issue maybe more about the impacts on DAX than this working for CXL.

ok, I'll add linux-mm. One of the pieces I wanted to get feedback on was the
dax component and how we could invoke the dax driver to consume any soft
reserves that remain after the cxl driver removes intersecting cxl region
resources.

> 
> Comments inline are mostly general suggestions of simplifications
> and refactoring to aid readability.
> 
>> ---
>>  arch/x86/include/asm/e820/api.h |   3 +
>>  arch/x86/kernel/e820.c          | 156 +++++++++++++++++++++++++++++++-
>>  drivers/cxl/core/region.c       |  14 ++-
>>  drivers/cxl/port.c              |  34 +++++++
>>  4 files changed, 203 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
>> index 2e74a7f0e935..542a52871beb 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -44,6 +44,9 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
>>  
>>  extern int  e820__get_entry_type(u64 start, u64 end);
>>  
>> +extern void e820__trim_soft_reserves(const struct resource *cxl_res);
>> +extern void e820__insert_soft_reserves(void);
>> +
>>  /*
>>   * Returns true iff the specified range [start,end) is completely contained inside
>>   * the ISA region.
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 4893d30ce438..855c26460bb9 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
> 
> 
> 
>> +static void e820__trim_soft_reserve(struct resource *res,
>> +				    const struct resource *cxl_res)
>> +{
>> +	resource_size_t new_start, new_end;
>> +	int rc;
>> +
>> +	pr_err("CXL DEBUG Trimming Soft Reserves for %pr\n", cxl_res);
>> +
>> +	if (res->start == cxl_res->start && res->end == cxl_res->end) {
>> +		pr_err("CXL DEBUG Releasing resource %pr\n", res);
>> +		release_resource(res);
>> +		kfree(res);
>> +	} else if (res->start == cxl_res->start || res->end == cxl_res->end) {
>> +		if (res->start == cxl_res->start) {
> Not a huge amount of sharing in here.
> 	} else if (res->start = cxl_res->start) {	
> 		/* Left over bit at top end */
> 		rc = adjust_resource(res, cxl_res->end + 1, res->end - cxl_res->end);
> 		if (rc)...
> 
> 	} else if (res->end == cxl_res->end) {
> 		/* Left over bit at bottom end */
> 		rc = adjust_resource(res, res->start, cxl_res->start - res->start);
> 		if (rc) ...
> 	} else {
> 		/* Left over bits on either side. */
> 	}

Yep, I'll update that.

>> +			new_start = cxl_res->end + 1;
>> +			new_end = res->end;
>> +		} else {
>> +			new_start = res->start;
>> +			new_end = cxl_res->start - 1;
>> +		}
>> +
>> +		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
>> +		       res, new_start, new_end);
>> +		rc = adjust_resource(res, new_start, new_end - new_start + 1);
>> +		if (rc)
>> +			pr_debug("Cannot adjust soft reserved resource %pr\n",
>> +				 res);
>> +	} else {
>> +		new_start = res->start;
>> +		new_end = res->end;
> Confusing use of parameters here as they don't match use in early legs.
> Maybe just putting the values inline would be clearer.

will do.

>> +
>> +		/*Adjust existing to beginning resource */
>> +		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n", res,
>> +		       new_start, cxl_res->start);
>> +		adjust_resource(res, new_start, cxl_res->start - new_start + 1);
> 
> Off by 1?  It's different form above leftover bottom part (should be the same).

I thought I got the math right, maybe I didn't. I'll re-run tests to and check it.

> 
> 
>> +
>> +		/* Add new resource for end piece */
>> +		e820__add_soft_reserve(cxl_res->end + 1, new_end - cxl_res->end,
>> +				       res->flags);
>> +	}
>> +}
>> +
>> +void e820__trim_soft_reserves(const struct resource *cxl_res)
>> +{
>> +	struct resource *res, *next;
>> +
>> +	pr_err("CXL DEBUG Trimming Soft Reserves\n");
>> +	for (res = e820_sr_res.child; res; res = next) {
> 	for (res = e820_sr_res.child; res; res = res->sibling)
> is the same I think and avoids need for next.

Yes, it should be. I'll update it.

>> +		next = res->sibling;
>> +
>> +		if (resource_contains(res, cxl_res)) {
>> +			e820__trim_soft_reserve(res, cxl_res);
>> +			break;
> return;
> 
>> +		}
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(e820__trim_soft_reserves);
>> +
>> +static int __init e820_parse_cfmws(union acpi_subtable_headers *hdr, void *arg,
>> +				   const unsigned long unused)
>> +{
>> +	struct acpi_cedt_cfmws *cfmws;
>> +	struct resource *res = arg;
>> +	struct resource cfmws_res;
>> +
>> +	/* Validation check, remove when finished debugging */
>> +	if (!res->parent && res->end)
>> +		pr_err("CXL DEBUG Should insert %pr\n", res);
>> +
>> +	if (res->parent || !res->end)
>> +		return 0;
>> +
>> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
>> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
>> +				   cfmws->base_hpa + cfmws->window_size);
>> +	pr_err("CXL DEBUG Found CFMWS: %pr\n", &cfmws_res);
>> +
>> +	if (resource_overlaps(&cfmws_res, res)) {
>> +		pr_err("CXL DEBUG Found SOFT RESERVE intersection %llx - %llx : %llx - %llx\n",
>> +		       res->start, res->end, cfmws_res.start, cfmws_res.end);
>> +		e820__add_soft_reserve(res->start, resource_size(res),
>> +				       res->flags);
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  void __init e820__reserve_resources_late(void)
>>  {
>> -	int i;
>> +	int i, rc;
>>  	struct resource *res;
>>  
>> +	/*
>> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
>> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
>> +	 * that do intersect a potential CXL resource are set aside so they
>> +	 * can be trimmed to accommodate CXL resource intersections and added to
>> +	 * the iomem resource tree after the CXL drivers have completed their
>> +	 * device probe.
>> +	 */
>> +	pr_err("CXL DEBUG Checking e820 iomem resources\n");
>> +
>>  	res = e820_res;
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>> -		if (!res->parent && res->end)
>> -			insert_resource_expand_to_fit(&iomem_resource, res);
>> +		pr_err("CXL DEBUG Checking e820 iomem resource %llx - %llx\n",
>> +		       res->start, res->end);
>> +		if (res->desc == IORES_DESC_SOFT_RESERVED) {
>> +			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS,
>> +						   e820_parse_cfmws, res);
> Can we make this somewhat generic by having a parse to find a match
> then call 
> e820__add_soft_reserve(res->start, resource_size(res), res->flags);
> if the match occurs. That way the check can be in arch independent code.
> 
> cxl_res_overlaps_cfmws() perhaps.
> 

I like this better than what I have. I was never real crazy about having the
e820 code parsing the cfmws.

> 
>> +			if (rc) {
>> +				res++;
> 
> Move the res++ into the for loop ... i++, res++)

will do.

> 
>> +				continue;
>> +			}
>> +		}
>> +		pr_err("CXL DEBUG Inserting %llx - %llx\n", res->start, res->end);
>> +		insert_resource_expand_to_fit(&iomem_resource, res);
>>  		res++;
>>  	}
>>  
> 
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index d7d5d982ce69..9f94730c488f 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -7,6 +7,10 @@
>>  #include "cxlmem.h"
>>  #include "cxlpci.h"
>>  
>> +#if CONFIG_X86
>> +#include <asm/e820/api.h>
>> +#endif
>> +
>>  /**
>>   * DOC: cxl port
>>   *
>> @@ -89,6 +93,35 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	return -ENXIO;
>>  }
>>  
>> +DECLARE_RWSEM(cxl_sr_rwsem);
>> +
>> +static void cxl_sr_update(struct work_struct *w)
>> +{
>> +	down_write(&cxl_sr_rwsem);
>> +	pr_err("CXL DEBUG Updating soft reserves\n");
>> +	e820__insert_soft_reserves();
> 
> That's arch specific code bleeding over to the cxl code.
> So needs at minimum to be hidden behind an arch call.

Agreed, keeping #ifdef <ARCH> out of the driver would be good. I'll look
at adding an arch call.

> 
>> +	up_write(&cxl_sr_rwsem);
>> +}
>> +
>> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
>> +
>> +static void schedule_soft_reserve_update(void)
>> +{
>> +	static bool update_scheduled;
>> +	int timeout = 5 * HZ;
>> +
>> +	down_write(&cxl_sr_rwsem);
> For the locks use guard()

Yes can switch to guard().

> 
> However, what are they for?

The concern is that we could have races on scheduling the soft reserve updates
and I wanted to try to keep only one work item on the queue. They may not be
needed, I was erring on the side of safety

> 
>> +	if (update_scheduled) {
>> +		pr_err("CXL DEBUG modifying delayed work timeout\n");
>> +		mod_delayed_work(system_wq, &cxl_sr_work, timeout);
> 
> See docs for mod_delayed_work_on()
> 
> "If @dwork is idle, equivalent to queue_delayed_work_on(); "
> which is where schedule_delayed_work() ends up.
> So other than maybe for the debug prints you don't need this dance
> just always call mod_delayed_work()
> 

Thanks, I'll look into it.

...and thanks for all the review comments.

-Nathan

> 
> 
>> +	} else {
>> +		pr_err("CXL DEBUG Adding delayed work\n");
>> +		schedule_delayed_work(&cxl_sr_work, timeout);
>> +		update_scheduled = true;
>> +	}
>> +	up_write(&cxl_sr_rwsem);
>> +}
>> +
>>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  {
>>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>> @@ -140,6 +173,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	 */
>>  	device_for_each_child(&port->dev, root, discover_region);
>>  
>> +	schedule_soft_reserve_update();
>>  	return 0;
>>  }
>>  
> 
