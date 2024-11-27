Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2087.outbound.protection.outlook.com [40.92.59.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54F208A5
	for <linux-cxl@vger.kernel.org>; Wed, 27 Nov 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674204; cv=fail; b=ctDSvGCg4GwDeMjFL44Ctk1pOVEAFS0VInBP04beg4EGAKUfm3+yzrNWX8b0f1WA4yeoh39VvxHPGnFMZOZGhrS/1xlUrwdCJL/AEaTaMI+mEdSlvP8dgMuB4mUHYujPHKOKaCl9iDUVdXnTwys9CqXxNbCUqcvXEG3BJRglDiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674204; c=relaxed/simple;
	bh=u6TJTc8PVNwCsdk4nrvyBz0MVHT2/VOARp5RDEMBxSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOLhmYxSNQzCgumN2hVWn1AtZjgAp8NAEQ8rRKEioP0CcUgJOGNWWOtvuv6FhOiAceyHW7JgOU9ZzI7RyqlSiAUmfhsZuvkhoULGXNTvDbHf69MOyxDUGusAm5x9IL0qveUbVCwzQQuSziiLxpTk1LQqQFpisg39rAUxYiSahBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dxdxzym2; arc=fail smtp.client-ip=40.92.59.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dxdxzym2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsrRJNozHua4gtW2+TbcYSsgM6aWjJxV7q75aUIDfC9DtcYPWAZHTY4UplLHtcJDiLIgGz3WxCo8oWOeBEmLsZSdLyqQaP7HlgCQdCByJM06/5YyeStwvt7Sg+qgTsxq20SEt+nq3pygFILdJrhn4aJpGjhxwXGcUt2M4EHvJc09F9aB+I1OL1ik8I0YSl4U/u3ueF8yTdtZSOgfbawdOjj43JW+beVaWAzNuCTQ0PMsY1g/NCYXj5CyC2j0PBCRDTnSJjSg1Vh5Ts8YlvxoSX322Ua21Po9Xgfb14+3CFfXTpRqm9rLt8w3W7iXoWtoCDyWER3yjJH1gTWVLc0L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TJMsEGCLly+mgsaa7LrQpsdOz0n/HSYTwWLvNzVhz8=;
 b=w7YXfxwKcuiry/wlbRX6DSOJvVGjzpxwIq01rcZ17Mb5SOE4T0qkY/TWay3DD2iSma4w81qlVHGPQvE1pz2Essx7KeV7grnnAorBjOC3rFPHoK6trqcg2wjQ6BgRxAliXGq85P3TxXhd92VT2g6i6wqXY4b7Ng9epFfm4ZhOPjA3ixEkI6H+DnM8oJvPoLIC03aexNfnxWqJA7JSxvQjNmfPaiMzsJRqqggzXlgMCB9F9EsoL7Qx/cz+e57+Cc7m4AV9mCr2F/4VpAeMWM7gtyfJGef5nv6S35ZFcHUlU/gXgT7iybMsCIj4u9oQbZRsxubUzqXTO+tuViXPw641sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TJMsEGCLly+mgsaa7LrQpsdOz0n/HSYTwWLvNzVhz8=;
 b=Dxdxzym207OACHSKyjVEYEuwyVzbgHB2J3MyTs+VEi752jcGHpD6RxsVdx+y4bQ0rq9i9ixFu0ZDUArIhuDDMFNEEf7mtei1q0RQduTa8W50KWZtnU1zJsl+OkLpqyfY1mDq/wF4Be7LnbTPG4h86D2JQfr67doLHSrOCvJw1E8Ky4NMNIJF/UVM6KAq6RICHz8+Lc/UZ94LKKtYXtUPGmYmrioBzuPXw34fF4Etud23JzfUWcBRlBwvPLtspNgccCQpBQxogSOC/OF1alZs8rTVvNOPQsDEAD0vxubryA4sf9E8UubDcXWJMcoxTf0hfxXb4gmq+g2/Rxjizj7GFw==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by PAXPR10MB5205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 02:23:19 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 02:23:19 +0000
Message-ID:
 <VI1PR10MB20165D95D04C56822A4C1AA8CE282@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Wed, 27 Nov 2024 10:23:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave.jiang@intel.com
References: <20241122072001.94758-1-ming4.li@outlook.com>
 <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
 <20241126150356.00001b2d@huawei.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <20241126150356.00001b2d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <f534eb44-809d-4659-9559-c6bdd9ef3cc4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|PAXPR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e8ccc4-1e0c-445e-9c2b-08dd0e8a74d4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|461199028|5072599009|19110799003|15080799006|36102599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1hTjJ5elZ0bE5pL3dkNW5zSC9VNlUzMmxxejFuYTZQMWpHZW1COVpzSmtL?=
 =?utf-8?B?R2tPOVR2ZmprQk92aTREU1A5MExOS3NCREdKb2VTcXNZdFRGQ1RnaVFMa2hq?=
 =?utf-8?B?YlRIaHlic2ZLbTcvY2U3VE5oWXh0NjlPamNXT0xxT0NRWHE3U3QwMDQ4MlpZ?=
 =?utf-8?B?VlhRMkJ6US9yaG94NWF3SDNWNWxIWHlLRWxocWlGT2RnSk04aEFqSHViU2I4?=
 =?utf-8?B?aXFRRy83VDBsTEFFQ0pkNGhwWEg0aGpCVFBvR2gwYVBCV2QyOFliR2dJb1Vs?=
 =?utf-8?B?MjBKOU1xUlRrOVVwSjRScnJyOW1iWmxOUWpsVk5CWC93S01PWGkxS3N1QzZD?=
 =?utf-8?B?Z29YK05DU20wMjUzVkZnL2dWN0p1ZWxCWWY1QjNaUEcxWXJkTnRWODZIMU1v?=
 =?utf-8?B?QzdhQkIydGZpdHArN1hsU1I5dWdoTGEzeFkyNC9EanBaTGpMenpUK2xmZ2Ro?=
 =?utf-8?B?QTdJT203MmFOd3lLaWJzOGRFNklKcFBsazVMcDdyaEd5djJvbXNzV1JrVHJY?=
 =?utf-8?B?T1R2T3lYbnJkc010bUpJMXMySWJXaURpMkd1Smx1VVFxU3ZYNld5SFlGTHZs?=
 =?utf-8?B?NVdRdm9RRWNKeUp0VG8zUVJCUDVlV0daRmh1VVphMFlSMGdEQzZFeUFCL3A5?=
 =?utf-8?B?d3dYN2M3Y1VZZldxU3NMOTQ2cDhSeVNYNktBWnUyd2Fvd2gwTFRhaVJ5ZWxk?=
 =?utf-8?B?L1JBRi9mK2lPOWNybWdFQ1RGVHpKajQrOVJCV29QSWFjenBIM3d2eUc5M1g2?=
 =?utf-8?B?Wi9NT3dZSG5XQnFESFFyc2llUHRjWmxwNlpVK1ZqV0dXQjJlbjZZdW9IRmt3?=
 =?utf-8?B?WWlodjZPS0VPSjlmT1RaTXkvTUNHdFZMRVBkZzIxakNpUzVlRGFDVEFKQXlT?=
 =?utf-8?B?b0FBVUtBeVJBMW92TUpQMUF2RkdkQk5UL0ZJaVVWUThpUm1NK05nMTNSb1BU?=
 =?utf-8?B?MCtLd0p6SFN2QjFWOFVweXZmdXVXK3NrQW43NDNjN3N2L1JBQm52anNOcWVv?=
 =?utf-8?B?U3FsRzdlVmU0cjBQTDR5ZWdTc2cyRlBvYWNkM1A2V24ydkhkMzY4UkxOaEFU?=
 =?utf-8?B?cG9QVFJhRzRVM0RsY09GNlBzNlNjMmFhYnA3Q2REeDRwaHVaWEVCeXYwWnll?=
 =?utf-8?B?a1V1Yk5udXd5UEVCSnFhU0krWkFNY1VabGNuYytnQnpCd09hMjZSUnRMQnha?=
 =?utf-8?B?YmppeE5EaWlMWU50TDlpbXRieGtUN2VtbVZQbEVuTlBRN294Mjc1bEkrc0VW?=
 =?utf-8?B?TjY2Wi81T2RzWnR2Nk5uYTBGRnFMclpFSkt0WlJZbDc1Q3RWNkhuRkcyYmhq?=
 =?utf-8?B?MGpjZWZuTjh1aURiazhqYm8vTkRXV2NFam8xRHhuVjdDSkhrL0czRklPb2hp?=
 =?utf-8?B?RkFKaXpqRnlGWmoyR2ltSkY0aTFwOWhsWmIrTFhobkR4d1I3N1JnK2RrQURY?=
 =?utf-8?Q?6FDOAKIl?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejNMTytXWnVZK3hibEQ5dlZBSy9rajJ1WkVIQVVXdjJtWnBBaHVzTVY0VGpk?=
 =?utf-8?B?UCt6NVhuaXNvb1RrUll3R1g3MEJMYmpWYkpudjBFdVlzUDB1SkdraTU4cDJ1?=
 =?utf-8?B?MnZ4Tk9ham9ZQmMwTG5NalV1K2FsUHdYM1RyWkc3dDliSWxoUGdCMENrbFUv?=
 =?utf-8?B?b3NVM1ArM1RPd2dZOEJ5WGZVRU9qYjZ2NGwwbTVWc0lrcjlEbC90bTY1bXdl?=
 =?utf-8?B?cis4SURnVDJJY0tNdDEvRGg1S0tOTFhOTnNUemJ5TzJnV2xVcTBYdDZJSDFE?=
 =?utf-8?B?QnE5eFY3cEFkT3huQi90ek9kNmcwcitYaVY2QWJaS0dsWUh4Vk1lQmFjbTlE?=
 =?utf-8?B?aDhmT2hkRVJOczkvNmFhTENyaUdKc3B6KzZxT2treHpKZFFSV015T1JBYVRs?=
 =?utf-8?B?ZnZpMXRhTlRxa0ZFYitHNzMwSDZMZWVTaXlYVmNZWmZGOVBnU0tyYXFGVEFt?=
 =?utf-8?B?bDRWT1hyZ3M2NCtvVUtyQ25GenNUTTF2eCtteVplcGwvTkRQWEtVWjByb25L?=
 =?utf-8?B?KzlpbFlYZ3gzLzJJcDIyWC9XeEh4cDg5MVlGZTNXMU1KZ1J5OHVEaFZBaHBk?=
 =?utf-8?B?WFdhTE1OUlMyL3FhTXpHMXhrYjlsck1GV096Rm5PVWRERzNqc2oxdkVUN2xz?=
 =?utf-8?B?QW1ER1RjOWdBaGtnSTQzOVIyd3lsN0tzaHc2M3JLOWxVbjdYVE80Y1VGNHlR?=
 =?utf-8?B?OGt1UnJYSmd0NW90RU5HYW4vcHJyMzQxbUdCam5BRi8vQ1NvNW11b1JpeXZt?=
 =?utf-8?B?aWFPWnZweUkyZlljRGg2dlBiM01kOC9VNTFYS3BkNHZBSkpCRFZxYSszU0pF?=
 =?utf-8?B?eVIzbHFDUUZaRUczVmwwY3NuZlNSaXY2WFFZdWVqTS9PMENjRysvcEpDOHRP?=
 =?utf-8?B?c3hYU05HU2RCQVJMT2VmeGlhMjNpcVZoL2cxMUNNbnlUZFZacndLM0FHd1JD?=
 =?utf-8?B?MlFWeGJXOGF0MjEwenZHZS9GZ3JwZ3JyejhFUFZ6bkJ5R2ZIVWFhckVMZmVP?=
 =?utf-8?B?TkQxd3J0cS9mcCtZVFdINDIzeUNvd3RpdytiZVlVM3FseEFVdGVOQnZvNldU?=
 =?utf-8?B?dXZEWDRqNjBFZHlvZGlHQ04xWWNWRWJVenA3K2s0K05RM0VUMW5tREJXV3hV?=
 =?utf-8?B?ODVXeTg2U0RYOE53VjNOcXp5K3RGM0I5SGlvMlg4RUZseEpoMzhpcENCQnhE?=
 =?utf-8?B?YWVndnh5Y0lrcG9XU01IT1I3d2ZnejNBZDQ5YlJETFZnRnlsdXF6OE5sQXVz?=
 =?utf-8?B?dXNIckRnYWJMM0MzNWFaM1N3YVc1bUtuTDNLOXdMZnhRNGdjQ1NPYlNoSVJS?=
 =?utf-8?B?OHZIeDdKaHlJc2RJdVN2ajM1ZjZaOTJyRittdjB5Skp3ejcrdEdlVCtQTXJa?=
 =?utf-8?B?VnFPaFhtSzNBYVA5dWxDeEl0QXJSQVlvSVRodmR1WXp6bW93c3JBa1N4R2lJ?=
 =?utf-8?B?eENXbTRLcTAvanRwL2hMUG8vQkxTd3cwWGs4MEZPamo3TmF0U1RRL1dPSVhn?=
 =?utf-8?B?NlVNRWlEZHc3YnlOWnRUTGNjSmZHakZ2dVZtZnJLbkFPUTlFUktLQ1hEMFhB?=
 =?utf-8?B?YkJpbVZhY0l6d3d4NllZcitEdk1iWWs5ZDBtNW9BQnhjRmI4WnhTV3ZLditQ?=
 =?utf-8?Q?lX5HY1OD/yudTI+drH/B1uvgUGuy0JuWvxb7yyuMAhJ0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e8ccc4-1e0c-445e-9c2b-08dd0e8a74d4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 02:23:19.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5205



On 11/26/2024 11:03 PM, Jonathan Cameron wrote:
> On Fri, 22 Nov 2024 15:20:01 +0800
> Li Ming <ming4.li@outlook.com> wrote:
> 
>> cxl-test environment always hits below call trace with KASAN
>> enabled
>>
>>  BUG: KASAN: slab-out-of-bounds in pcie_capability_read_word+0x1df/0x220
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x82/0xd0
>>   print_report+0xcb/0x5d0
>>   kasan_report+0xbd/0xf0
>>   pcie_capability_read_word+0x1df/0x220
>>   pcie_link_speed_mbps+0x6a/0x130
>>   cxl_pci_get_bandwidth+0x68/0x1c0 [cxl_core]
>>   cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x780 [cxl_core]
>>   cxl_region_shared_upstream_bandwidth_update+0x257/0x1640 [cxl_core]
>>   cxl_region_attach+0x1025/0x1e80 [cxl_core]
>>   cxl_add_to_region+0x121/0x14c0 [cxl_core]
>>   discover_region+0xa5/0x150 [cxl_port]
>>
>> cxl-test environment creates cxl memory devices based on platform devices
>> rather than PCI devices for testing. but cxl_endpoint_gather_bandwidth()
>> always assumes the device is a PCI device, it will cause the issue in
>> cxl_pci_get_bandwidth().
>>
>> The fixup is that faking a maximun bandwidth in cxl_pci_get_bandwidth()
> 
> maximum

Will fix it in v2.

> 
>> for a platform device so that the cxl-test environment can be used to
>> validate the functionality of region bandwidth.
>>
>> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
>> Signed-off-by: Li Ming <ming4.li@outlook.com>
>> ---
>>  drivers/cxl/core/cdat.c |  5 ++---
>>  drivers/cxl/core/core.h |  2 +-
>>  drivers/cxl/core/pci.c  | 24 +++++++++++++++++-------
>>  3 files changed, 20 insertions(+), 11 deletions(-)
>>
> 
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5b46bc46aaa9..bd0448c3c9a8 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <linux/platform_device.h>
> 
> Having a platform device include in a file called pci.c is a bit nasty..
> Can we instead check if the device is not a pci one?
> 

Yes, will do it in v2. Thanks for review.

BTW, I will use my another email address to send v2, outlook has some problems causing that the cover-letter and patches cannot be threaded.

Ming 



