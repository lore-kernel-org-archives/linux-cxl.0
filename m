Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2076.outbound.protection.outlook.com [40.92.50.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869551990D3;
	Mon, 25 Nov 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533798; cv=fail; b=tBPTQ4QdoaLZkl0mqV2bqFxSUKEcleIPaKhNJMkXZ0XAzxG9/bRvrML6B90AIn3Jtll0r4fmjjUR3CsFAIKvLHqf4RZHSKLHKs4pVcUvH8dLgF/RZ+/+nkrM93jTLL4J86Z0L3lRKgIbPoUwan8tUkFJPRhevDf77FRAQWGKd0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533798; c=relaxed/simple;
	bh=n4gGlsuoC8VzwK6K0+6P16Qx9JYn/9gc+GSx78NHROY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poaDMmeWP48TnXmhDn4eZcPpGEBJStUwxOk4bnIlT60bHHwiYl73WCJHhgaQi/zDBSqGcGpLNqzmoKvWSPrjEdgv2q3gQEku8E6oWR9Jv3SmvCW8K5jxrcdGzqeNZV2ytOCu11CNIB/Y7rr1NY5EHFB2qSjAHSUZXjjUWIe5qJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lONYMgd3; arc=fail smtp.client-ip=40.92.50.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lONYMgd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifk45Q2rmyKiLwYr/0uaIWrU9W9j2QZQ+I/nbQTz4iF0glxW6j5EpwZP8JvZOA6rbOd9H4Yb+uIM3CFJEytDfANfDYH1njFu06pQ3QNMAlCRk74oDKVxBV4sOD7nYXa6q5AEresyfB0MH+84QKnFG6rURvFDQrP/z80DQnVituDBks8UcFFVmvvpX63qpD0U4RHnRkQvD/ygp6KEF/W4+xyd7nOqkyDCHC9ImYD2/gY3LbWERSUTTbDykiY+lnZ4HJEaprTq5r2U3Gi2se418h9VWzkNXpGOjRE5AnRME0YbHVj68qXM32mZuantHGsF4vbWr1ljBKcQI0W2q4j3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFOHkvF/CFhMmKmzqW4P3My6GI/7R2fokuGZWBJhGfM=;
 b=n6isvvVQWeGPhkXnVdogfYyQ1EjL54Ot3WWhxQJC5ehFtUPwTt4Z1YH1Zv3mToWwSY5MCx4PS8PoYG8wBP0QXs1JLrXMV9Nqe+K74zcqe731L0QKiufEdBbKXKnorn5V/P+U6+u3Bxl22xPkLvxJY6tA6/dsxGVs3PkNNjNTwPDVMy5+MIxv0jKbKwCftkzVkF8YXk15Q22/+OU/Mxywor0KqgVStnTPUKOAAjk3bTJuEhDgo4sHvQ3mgw/pu6XAD30I1XQeMdSyv/nDZLp3ySmXf8hLokuRvnvJOcDfuOep/uIvczgck65kQiD6W4JojSlu+3m89opsUfYP2E4AqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFOHkvF/CFhMmKmzqW4P3My6GI/7R2fokuGZWBJhGfM=;
 b=lONYMgd3ygM3z5Phzt0aG3HQFyHJTacMCymtAcg3EzDub/GdT1qxU/sNbaYJQJcGLGqtVV8qdP6R3ZoqNc/WThk+TSZKmxxFte4eBV/A40y6yu3wrP0vvAMU3z6Px0eSQT2+zg9faBYDs9nzh9AiAfMO4oUZtTQzExQm3Zt614bJ+f3XqbCBpaqxXfit0eMh9J9g5pSlnR8n0b+17V3HlQMYYFE1j5Xm1RhrCVkdotqo6UBgKpcHc9cac6gUrF1HoX4p+YUvluBcMJ+MU19akmxJ2E0qXDVfEiNCfbiFXqzalHHCVxE912ik6EP+iHBhPz4/sjizo+mBqraPgbNYHg==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by AS2PR10MB6952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.10; Mon, 25 Nov
 2024 11:23:13 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 11:23:13 +0000
Message-ID:
 <VI1PR10MB20168EDC5126CC53204B44E0CE2E2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Mon, 25 Nov 2024 19:23:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
To: Ira Weiny <ira.weiny@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
 <6740be7ca4bc3_2de57f2944b@iweiny-mobl.notmuch>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <6740be7ca4bc3_2de57f2944b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <e843faae-204d-4371-8c96-bae479187fdf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|AS2PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b662038-2a67-45b5-c261-08dd0d438cde
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|8060799006|5072599009|461199028|15080799006|36102599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWNoby9MMzNiSHQrc3QwdzlPMS8rVHJacmR1YmgrSFpPb0dsb0h6eGl5eFkw?=
 =?utf-8?B?S2ZWSWE0ZnNKSVRkejVtQ2pkYjE1SzRNZDExcDQzRlJqR3ZlK3FTT3JjdnVU?=
 =?utf-8?B?RDZLTU56UmpjL2xVK0N3Yy8wL3dPZFMwWWFNdXowRGlJcVI4Q3B6TmFzSW1t?=
 =?utf-8?B?MUpHdHNpZFZEeTZiWHdIbm45aFVQVnVGZ09HR1FGelh0TlFaWWFHeGhQV0NQ?=
 =?utf-8?B?SVdxSXgyY3hFTFhlSnZPTU9FMGtYMkNjS29rSmhVWEU4YTAwUUJFeXd0RnBY?=
 =?utf-8?B?Q2dHQTZDNmpmNnBMMW1rTjJLVWhUckdhMmwzUUFNWDhVbUtKOTVHajFOYTdj?=
 =?utf-8?B?Y0JrR0JFRjZzUUFqam1mY2JrdEVvRUdiOXIxdzlpU2lmN0RjT2lVNmVXU3VX?=
 =?utf-8?B?czl2UXZoemYwVWZUSDEzdk5WNlRIQ1pPUEhwYVRtdllPdTVGMzUwbGVKZTdj?=
 =?utf-8?B?S1h1NGhYckhmNHk3dWJaYStJeEMvRE54cGJhR3FwcnBqdjFCNWptMS9QQm92?=
 =?utf-8?B?MGJsRUdaQ1ZhNHVZcWJhSWtId2ZiaVVaYkJCemRZR0hIVExhWFlDRXYxV3I5?=
 =?utf-8?B?cWNxdThmaVRXRGRCWVlaNnp2bnk4ZURHenlUcnJTY2E5cUJsUEU0N2RVaXF3?=
 =?utf-8?B?UHpDOU8wYzhSVEdISXdIRTBLTHpHdTFDa0hwT1VSM2VBc0xJVWlkMitRM3p0?=
 =?utf-8?B?Zngzc0JiNnFBN1MzeC9wcEljeG95RXZoY3dSR1UzY3hDcHR1QzhMWE1pbWNi?=
 =?utf-8?B?R2tGVVpsUDJZQy93YzUyQVNiRDlDeTNSSFpFNTRPUXIraHJUb1BQcFNiMExq?=
 =?utf-8?B?VTVjRm9aMUlvaFN4RVBKN2twbGdvUHgvamN0azRpVVpJeDhqalp4VXVlUzNK?=
 =?utf-8?B?c2J2SFlUTWRPb1FkdkF6MGkwbHRUNmY0TUNSN3lMcFFGZk4ya2k5MjZOSG5M?=
 =?utf-8?B?ZExDL0hXZFVlczBFRmNobmhVbC9nWXpOZkNNUXA2RFRzcFo2dkRYN3J3ZStJ?=
 =?utf-8?B?YThKZHNDS0ljODYwT2NjVXhhT0RNK1VuS3ZWa1Y1LzZxbEhmTWNVSWZDRjM2?=
 =?utf-8?B?Y0R2amRaMldzcE5BdFhsQVo1WFNCam9Nbi9VOHoyaWtGY2hpWS95NzVTcHBT?=
 =?utf-8?B?VFREbStIeFl5Z2V5Y2JkMU55cUFpa3JaTlZCcVBNTmxBU0o4N2xSWjk5U3hs?=
 =?utf-8?B?MTIwL2JYNmY3NWhLTVBYVGhkc0VFSVcyeXR3U1c4amgrdTdyUzZkUnlXbFpJ?=
 =?utf-8?B?L3ZJajhSSzhTaFRjc0VEa1RzVW1HSHFuYjZPY25FdlJFVW1JR0k3WTZXbkw0?=
 =?utf-8?B?NVRSSGlLa2hiSXRqMWV3SkJCQ3MxR2YvT0VRSzBtbStKWE9XaEhoVXdjdDM2?=
 =?utf-8?B?Q3JRbVBzTVlZaCsvSU1zZUpwb3pjOEtaTVliQitBcmc1NjE2cEZkTmhrU2Rz?=
 =?utf-8?Q?in1VoC9B?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGREYnpnV3BnVkpGVUx2TG9OSzJUVXNhQ1lXV2lES2tRNkltSGFNUkROaS9m?=
 =?utf-8?B?SEdFM1VMdGxmTGRtTEJxbGZVSUhqZzlFQUFMcmdzZmdKWnVDOU80M2g3MWcr?=
 =?utf-8?B?ekcvSXlWNGN4dG10ZGpQM28va3pWQWh3MDg5OUNPYUNaWGNZVnlqaGpBU29I?=
 =?utf-8?B?cjlKWUEzcWhIRmlrK1o4TVFldVd2d3l3OHZKVDZOamNlMWlsZnlocFNmbUts?=
 =?utf-8?B?RzY5ZCs5MWx1UFBWR0UyeXRpaFZjNGo3RHcwZTFpME5QTDl2Y05NVTh0ek1x?=
 =?utf-8?B?RFNLS3o3U0pDKy9sT0RvaDBCOXRLU3h3a2NkVTVjYWJ4RTU2WVM1VDUwbnhn?=
 =?utf-8?B?dWVGeEdnZTg5ZXpyNHFCVkg4eUk0Mlk5MkJERUZKQ3oxSUFNWkt4YkFiOVBk?=
 =?utf-8?B?dU91cnMvcDMyUlVKOFpjYnZiNjVHdG4vQjVBK1RZaXdLMVA4WnNWTzA2WnFE?=
 =?utf-8?B?L3RZODlEc3l3dDNOUjN1YjhCY3VEUWR5MnpicWVYakp5ZkhDbE9qUWN2VGh3?=
 =?utf-8?B?Q0greDQrek5wOENyZTZxaFF2NnpHVEJGVS9lbFRvVEloem56Q09Hb2ZDaEhu?=
 =?utf-8?B?VnNwclV1c1ljd0dwa09RNlpyOW5pRmt0eTNvRE1SZDkrUHMvZ0FSVHZSU1dM?=
 =?utf-8?B?N1BDZWR1aExRYTFVb1RpcXpVYTlhVE9PeWZzV3BXbzhabTcyNnNqVDdHbnVE?=
 =?utf-8?B?bVhSNmtDVXZkVE9EajVmS1JxelFheU85eDdUY2NZWjQ4VjR2Ylo3VHp2QTZw?=
 =?utf-8?B?Z1RERkd0QXlETkdKNWJLNHJkWlFwdE9ET0lndklUbi9KRW1nUHJIem9LVHNa?=
 =?utf-8?B?YmJkRGhzcFM1UWluSkt0bjJwai9HcG8vWitkai9uNW1sbEJTNHJndTRDak4v?=
 =?utf-8?B?MHpoeExjMnB1YVMrK1V2dlh2ZklrYVd1d3h2cnNRYmxpWWUzUkFCd2x3WjBl?=
 =?utf-8?B?cHh4amV3MkduYTUvSVVRRkxPWjBucEVscWhXQWpQUEFhei9kQy84Y2kzbFEx?=
 =?utf-8?B?VDZHME9rdnB4VWZCNnJFSTgrb21kUHBjd3NLdmFUZ3NJTEpLNlM2RWNQdzJt?=
 =?utf-8?B?Y2RsMFRPSm9UZm5BVXF6MFFuSS9JYTFsNmNDM1Q5M05VQTBmU2FNbGtlcGxq?=
 =?utf-8?B?MStPcldxYmFFdUdlT1U5S2NDRUpEbWYzMnBNUVJVN2dYemwvT3A1d2lNbFJy?=
 =?utf-8?B?T1FPd1dkZVJmZEhuQWNSam52blFjOWplRFlPbW45ajRaU2hML202bmhnTUpx?=
 =?utf-8?B?cU5CNVo1bmhFSEpYR1RmWlROQ09HOEZlWkFSa0RkTFhWZGh4WlE3dkJlSWRI?=
 =?utf-8?B?YlNUdDBqaFJhVUs2MklYMGJaRnpKcnN5YkJ6YUw2OFhMVGZPOWNqK21EYmdC?=
 =?utf-8?B?YU9hbk0xK2lzSlBqUUxyTWo3b1ZXTHAzbnkybTMvT09jQ3VwSjlPTWNBWlVu?=
 =?utf-8?B?OFhETFMyWnV3bjJVVm9PTW5LbTRGa3FoMzYwSXNDUFlrbkZBQkkrcXM3SE12?=
 =?utf-8?B?MGwrUTlVM1FseDBtbWdZejV2R2lrYTNXNDdMWS9MSmtjQnhYbGJWdHlVZWZ5?=
 =?utf-8?B?QVJ4b1JhU0ZJdzE4anI5MG4rcWIySkk2cG9LOHRZL0c1QzBTUXBySmZ0L1Jx?=
 =?utf-8?Q?GkQZrdHa8h4N1DyBvfvtLNgcN+ccq20Rpkv4iqEE03EI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b662038-2a67-45b5-c261-08dd0d438cde
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 11:23:13.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6952



On 11/23/2024 1:25 AM, Ira Weiny wrote:
> Fabio M. De Francesco wrote:
>> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
>> Physical Address (HPA) windows that are associated with each CXL Host
>> Bridge. Each window represents a contiguous HPA that may be interleaved
>> with one or more targets (CXL v3.1 - 9.18.1.3).
>>
>> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
>> memory to which systems cannot send transactions. In some cases the size
>> of that hole is not compatible with the CXL hardware decoder constraint
>> that the size is always aligned to 256M * Interleave Ways.
>>
>> On those systems, BIOS publishes CFMWS which communicate the active System
>> Physical Address (SPA) ranges that map to a subset of the Host Physical
>> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
>> the endpoint is lost with no SPA to map to CXL HPA in that hole.
>>
>> In the early stages of CXL Regions construction and attach on platforms
>> with Low Memory Holes, cxl_add_to_region() fails and returns an error
>> because it can't find any CXL Window that matches a given CXL Endpoint
>> Decoder.
>>
>> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
>> ranges: both must start at physical address 0 and end below 4 GB, while
>> the Root Decoder ranges end at lower addresses than the matching Endpoint
>> Decoders which instead must always respect the above-mentioned CXL hardware
>> decoders HPA alignment constraint.
>>
>> Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
>> Decoders if driver detects Low Memory Holes.
>>
>> Construct CXL Regions with HPA range's end trimmed by matching SPA.
>>
>> Allow the attach target process to complete by relaxing Decoder constraints
>> which would lead to failures.
>>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> 
> Over all this looks good but I wonder if there is a slight optimization
> which could be done.  See below.
> 
>> ---
>>  drivers/cxl/Kconfig       |  5 ++++
>>  drivers/cxl/core/Makefile |  1 +
>>  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
>>  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
>>  5 files changed, 130 insertions(+), 9 deletions(-)
>>  create mode 100644 drivers/cxl/core/lmh.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 876469e23f7a..07b87f217e59 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -128,6 +128,11 @@ config CXL_REGION
>>  
>>  	  If unsure say 'y'
>>  
>> +config CXL_ARCH_LOW_MEMORY_HOLE
>> +	def_bool y
>> +	depends on CXL_REGION
>> +	depends on X86
>> +
>>  config CXL_REGION_INVALIDATION_TEST
>>  	bool "CXL: Region Cache Management Bypass (TEST)"
>>  	depends on CXL_REGION
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 9259bcc6773c..6e80215e8444 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -15,4 +15,5 @@ cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>> +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
>> new file mode 100644
>> index 000000000000..da76b2a534ec
>> --- /dev/null
>> +++ b/drivers/cxl/core/lmh.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/range.h>
>> +#include "cxl.h"
>> +
>> +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
>> +#define MISALIGNED_CFMWS_RANGE_BASE 0x0
>> +
>> +/*
>> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
>> + *
>> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
>> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
>> + * the given endpoint decoder HPA range size is always expected aligned and
>> + * also larger than that of the matching root decoder
>> + */
>> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
>> +		    struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct range *r1, *r2;
>> +	int niw;
>> +
>> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>> +	r2 = &cxled->cxld.hpa_range;
>> +	niw = cxled->cxld.interleave_ways;
>> +
>> +	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
>> +	    r1->start == r2->start && r1->end < r2->end &&
> 
> Should this be 'r1->end <= r2->end'?
> 

Hi Ira,

I think that cannot just simply use 'r1->end <= r2->end' to instead of 'r1->end < r2->end' here, because there is a 'r1->start == MISALIGNED_CFMWS_RANGE_BASE' checking which means the 'if' checking is only for LMH cases. 
But maybe can put both LMH cases checkings and non-LMH cases checkings into one function.

Thanks
Ming

[snip]


