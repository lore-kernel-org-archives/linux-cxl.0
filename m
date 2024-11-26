Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2063.outbound.protection.outlook.com [40.92.49.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F32BA3F;
	Tue, 26 Nov 2024 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587236; cv=fail; b=Ast01jawvlGIXMrU0d1k8KZ/YQ6kNbwrpZ3ZL1FDDc53dXdPbT6HHK/H5M/FpYvK4As+BIYM7gPY/2HIjx4FeIdup/BD0TJNAYQl6bk3lRLoK4TwIX+DbsRSiIcLYgZ88kTGtad1ODrWgi15226vmZv68NDY/1lLlNsKgYEAP1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587236; c=relaxed/simple;
	bh=NTO9AUfL8tKup6wRb5HkTjocnvgn3HQFs/fNrqHODmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aM1TaZtuCb5dWo5wKqVMmQCKiCowppaeLCOLu6GEKRxB7HCegjp4c06MEchpR8lAQauy3D26nibFmJrvVXBAlu9HcSvWIzlCpIU2oTxQjV/hHaj6/HdiHEzwK4AjsK4/cc0A3QfsDB28LMnMvn5xCwi3+HHjIN0g37MORydFn+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=shvOR+0G; arc=fail smtp.client-ip=40.92.49.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="shvOR+0G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dotF5BxeKWKPgBGsGABYQJOFgoO7aieJ6kCRLAn9obNzxZo+8KEfCUz5vgTZfb3pDFEDKJrubruN6MWNmjKh5Ty/dIflM8IWRqIjVonDxLseR5yOyLlouszpHX3/HgwdYm1llNq/Et17hRelHfRnlzrD4OmCCyG8XBVE5OG2Hj7Z22wYchN7YB7T3TnKxWYU3mcrDzX3HAw046X8exxARdGRbXPQJEnDxL3SpYD4EDALBQSio3SrHbzINHHRAYGgAVb2RzlGengUIl3qSxqKVczvoTrxFqvuMXnbPBQzWRWHOIIVnYydNCFWe1JowujO2NVZdv7jrIjs2dyFuuVWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xuc57HnfJBL+YwYiA3ZG+t69/qCS8KK4uT+ZeBtTd5I=;
 b=vtOcdTzGL0u7i/hjhEa4StajE5UdQsnmudqgCkbWe1eUhS1XUAjXfQT5epzkPXH2E9UkTLTPBnj5REu/g7cn/VDsy2NGnbgkgzbHAT1P92FJglQ896ZJJm2WVxCh8aPuTEXRnGtOvP9gRVzOuNjaYzQSWsQemMu6IQLXg4akcydJrXwsWu8odW5qeqc02wcJuwF9+qWaO2ZKBeDOhvRByMobYLPMUOhbXayywxleHr2b6jT9lh84yFnsq6u9TPFcUaV360V9Zd3KabzJg2404n7Emymd+/FU+cCmA8rZxpqdT7uaKB75lBJNL5UjLG0SsWPCC0pl+H3GnIVLG5i6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xuc57HnfJBL+YwYiA3ZG+t69/qCS8KK4uT+ZeBtTd5I=;
 b=shvOR+0GtYpzh5U0skVd2LkRs/GMwPxs+e8MpczGIHKb3Hq5AjYjbN+cDrHi2ejv3YHlPJ4GRcu5vcad7yj7XlAdmXqIbXsaqmw22rRN/8otXNEMygSZsp4ENSYzwWwjTdyB94U+Vgj3/HZjFGpM2rwUd+fiY+6YNJ9eHQoAWv9kAa3cOFewvcbrN7wyXSh2JUEdTe1uo1Hd9G5UIyMypR8oBvoOsuav7cS4Io7xtWJ1R7zCq04j+rumT7/IFCud/dd8JeUVMN3/xBIJRHWjPexyh4d6rhNVe7IHTFUJss8Ss9TFULATpkvbxslZaGoDzA1PqLzlzen+aS7YOkxU0Q==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by GV1PR10MB6325.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Tue, 26 Nov
 2024 02:13:38 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 02:13:38 +0000
Message-ID:
 <VI1PR10MB2016CDFC3A816ADC4F8840EECE2F2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Tue, 26 Nov 2024 10:13:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Li Ming <ming4.li@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
 <VI1PR10MB2016115B9C59CA9A74312092CE2E2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
 <2791149.btlEUcBR6m@fdefranc-mobl3>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <2791149.btlEUcBR6m@fdefranc-mobl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:404::31)
 To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <23ae8010-6148-4d56-bcfc-224c926757eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|GV1PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e48c8c-1560-41d8-38d2-08dd0dbfefca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|5072599009|8060799006|15080799006|36102599003|440099028|3412199025|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlHWmxlUmd1OVFFdWxPdlpXaHZWZzZrOVZRcCtuQjdLV1djaDYydW4ycDJz?=
 =?utf-8?B?NnJvOXEvUnBEaGREQThYTFBEa3BEVmMvQUZwUDhCdjNkRkpoWXBtZ0Q3OFFQ?=
 =?utf-8?B?KzFTZXdmZWFHS25JWWNraFFxSnBhL1gxMVVCbk1uREhrd3FjRXp2S3lqZDlV?=
 =?utf-8?B?Z1phY2VxNDRKbjB3OUJJRm5yZ21jRUlsZUhKb2lwcUlkME42T3hocjFSRFpw?=
 =?utf-8?B?UStvYklCV3FURUNlODNwa0kxRFZlcmpQNnB4ZnRZczREdFhBMGd3YWhZbmgx?=
 =?utf-8?B?WFdjdjRqUVV4eGd6Q1NIOUlVaHNFRjVYZ2RWamlDRkdSOU5qcFdiTjVrdVk2?=
 =?utf-8?B?RFZkUEczN0h2U2QrNVh2L1Q0c25sVXlSWnVkSkNVeHdLZ1lrUHBEcVhWRXFs?=
 =?utf-8?B?eTdyeURjV0Uvb244Uy8zTEUvTVM4ZHg4Z0hIZnozdnpSY213MmczejM1L0lh?=
 =?utf-8?B?N1lEMVdmWlNsdERrT3ErcWJaaWlFT0NKMytSWEdSbUgrZnRXemhYY211TkNm?=
 =?utf-8?B?S2lTVGZKbzNBMTY5eCtMWEc5aFI0TG9PVlZaY2N6MFhqU0hYVkFmeFlkZ3Vv?=
 =?utf-8?B?ZFRxV3ljSjlQRGU5Ujd2aXYrUHFaNVI1TStzNzlWYjlWd01mLzlhRCtoTmVz?=
 =?utf-8?B?Wm4rdFc1N3ZaZzQ2czZpYmE1Q1U5SkhqZmtSWUxuQzdkY0xMR3EvRG1hUjQ3?=
 =?utf-8?B?RWhEakc1UTh5QlAwUU91RktBU3VqZ0VZUC95dSt4SjNkN3d2SVNHUmNSMTBw?=
 =?utf-8?B?dS9NSTJkelJqcTdjdGJFM2hWTDJLMStMRVdVeUFaMTBuWk0vUmU0UzRHUXN3?=
 =?utf-8?B?aXUvWitORFkxVEhwN2YwcVU5Zms3ZFQ2T3pHOXBNSzR1SjlXUjczU0xDVVUw?=
 =?utf-8?B?MkphV014bHA2bC9COHBkem5wS2hSd2l0K3l6VWY2Ky80YklONEN6Vkx1cFFp?=
 =?utf-8?B?czB0UjVRMVRWTXROQVlQZHI0TnRraTRoQXF3czEvMXNzZ3ZXQ2dIbW5JN0h3?=
 =?utf-8?B?emRLWWNZRUpBYnZBcFY1dCtsSGF6dDNYYzVCaU54K3NNUXZKUzBBVVY2UlZm?=
 =?utf-8?B?Y2VXemRINkJ5WGtHS1pTWFBNMHgvVXF3SFd0NVhJODB1djl5cHhCYTE3S0RI?=
 =?utf-8?B?MjJWb2lxaFRpTlcycHVRWWVFclpOcExQU3FPNVZ5VVVtS2tWVjBOUGltY3hr?=
 =?utf-8?B?dGcvd1NjbUtEVkp5UXJoSUhUcDhjM2dnTm9TMm1OVk1Iem9XdW1kbTlzVW9T?=
 =?utf-8?B?Wmt3R3RhMzQ4dm80Y2VCRWpIaWJGS0pWQjliQzBBTXNyeDJ3NEVaMWhQNDhj?=
 =?utf-8?B?blhIK3BIcEhDOE1hclpzTnJQS1g1SmJrQVdzb0ovRXFEUTJ0YkZLUUx3K2ZN?=
 =?utf-8?B?aVhDUE9QUWRwRWJFUHhrRUltbTYwVlZSeHBDL0pGVUhMMEhvZUxqQkRMaEkr?=
 =?utf-8?Q?Gp8Q7CCF?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCtxMkhPWWhYR3FjQWVzbklsZjJNK3lXQkovUnNXcVBJeVpaMFJlajgreWJS?=
 =?utf-8?B?RnFYTDRZbmkwcFVNbHNDallpRzR5Z0ZMYTc0bm9XV0tJeTAyOWhJNzF4cEQv?=
 =?utf-8?B?WjROekZMQTQxOVg2ZmxPSksyaUxvRXBsbDVTdytSUjhFUEZXZHJFdWRhd2Yv?=
 =?utf-8?B?Z3FxcDBVWTZaVFpLYkozOGNwWXdNdjVyajliVEVPdE1STFlzQkg5ekZ4c0F4?=
 =?utf-8?B?N2kvR1hPck5Da3BRY1RDQ3Rza3EzUHJNZmpRSDZvekFzanBKMTZkSGhnbVZr?=
 =?utf-8?B?by9YK0xqdDRDMFJDTkM5eFpNQk1rSzU2UU01bldUNnMrT0JYaWhFcEhUbnNu?=
 =?utf-8?B?Um1MSHBUT0ViT1BvNEROQUZ5WDk3OTV0QjhYQnZCWENNQUJUUGV0TkJ0V3hY?=
 =?utf-8?B?UmQ5SmJNeDJ3M1JNZXNtT2ZEeURqZlJUN2ZxOGFja0lIcGhsOHlzZUxSeDV5?=
 =?utf-8?B?MHZQNG05TTE4ZEczQWtqOFhSdnRVamdvOXFIT3lQWTh5Q0NkOWd2TXo5eSsr?=
 =?utf-8?B?TE9zUWtGYXF3MW5ZcUZRS0UrYUgzamwvTGJGQUt4NCtqblJwbVgxcjdCNU85?=
 =?utf-8?B?MlY5WFUvdDhDME5OV3NoQUs0SWpEb3pmLytyOFIra3FHZWpuZS9UOTFHazUv?=
 =?utf-8?B?TG5EL3J3M0JQWlZOdXJGeEdWWlZINkxQTE45V2syYUdUVEl2K1hDSzNMNk83?=
 =?utf-8?B?dUNBNCtNY1dUbS83S1YrRndTb3FxRmk3d21yZFhoWHJyN2xPcTdsT21vaXF0?=
 =?utf-8?B?cGR6VVBYVVpBK0IrdXp3RFpraUk1aVZXa0REN0l0ZHZEdUFZU25CbUhXcTFq?=
 =?utf-8?B?T0ZHWnZ5bGw0Yzd4QW8yUEd5WTVJd3VON0Izb2lHT3l1Y3RISjgvMFpacCtx?=
 =?utf-8?B?V292bVhJRklyV1NFeGovNmVwSFRrMzB4eTZZM2xZNDZFSE85aFc3RG10RStS?=
 =?utf-8?B?ZFJhRUo5bDE2dUJmcC9NaGVCVmtKN3hNQWxlbEJOR2JaRnFJLzBMNGhSTUNF?=
 =?utf-8?B?d1B4SjFuQ1NXdWNnNlV0aTVobDBOaXhTSG5OemRoWXcxaGcwUWVSQ3diTG1H?=
 =?utf-8?B?SVJwTU1IcDdSZ3lvT3RsUmZsRnlZanVDUVJKc3pWWmRkd05KZXlGVERram5o?=
 =?utf-8?B?b3lYYmY4ekp4OVpMdkxlV0JDUUtSL0x3bk1RU1FJVVdBU2hTeFY0d2UxbDdn?=
 =?utf-8?B?MldiMVZDVXFMd0EzUTdVQ29keWhLa21uejJqKzZVQk1PcEttZVVjb1ZMcnAz?=
 =?utf-8?B?ZWZZMVRSa2MzSGpXdlh1UkhZVGs0QklBQjZUMlpzUnJTNUxRZFBLdFJlRi9J?=
 =?utf-8?B?RG81c05DblhjNUdmUVFqV0hDWkpnRDhuRGxaL3JaYlN5WTNNNTdDQW9RUW9X?=
 =?utf-8?B?VEVxbDh3bld1UDNhbFE1Ym1LNGRXTTRKekViaVBGS0lDejEzYlVRbWpVZzQv?=
 =?utf-8?B?UERkMlBONXMvbmc4Lzl4eEJaMnBoQzJIMURYRW0yYWRZRGl2UXhCY205clZL?=
 =?utf-8?B?Tms4LysreFR6M0ZRVndRUUEzckFhVjdnRkR3QTM0SzhhTjJhb2U1UHBWNDVY?=
 =?utf-8?B?QW5XZ1lNQ0ZQYzBzTFFYN2M4TnFBdVdpK2M4N0t3LzJsTkNpNXd0RXhUOWV3?=
 =?utf-8?Q?N0YIYnetOQmBZ6jMa2DqeiWbebdTUmq521cNiJrZdjTI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e48c8c-1560-41d8-38d2-08dd0dbfefca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 02:13:38.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6325



On 11/26/2024 1:22 AM, Fabio M. De Francesco wrote:
> On Monday, November 25, 2024 9:42:56 AM GMT+1 Li Ming wrote:
>>
>> On 11/22/2024 11:51 PM, Fabio M. De Francesco wrote:
>>> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
>>> Physical Address (HPA) windows that are associated with each CXL Host
>>> Bridge. Each window represents a contiguous HPA that may be interleaved
>>> with one or more targets (CXL v3.1 - 9.18.1.3).
>>>
>>> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
>>> memory to which systems cannot send transactions. In some cases the size
>>> of that hole is not compatible with the CXL hardware decoder constraint
>>> that the size is always aligned to 256M * Interleave Ways.
>>>
>>> On those systems, BIOS publishes CFMWS which communicate the active System
>>> Physical Address (SPA) ranges that map to a subset of the Host Physical
>>> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
>>> the endpoint is lost with no SPA to map to CXL HPA in that hole.
>>>
>>> In the early stages of CXL Regions construction and attach on platforms
>>> with Low Memory Holes, cxl_add_to_region() fails and returns an error
>>> because it can't find any CXL Window that matches a given CXL Endpoint
>>> Decoder.
>>>
>>> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
>>> ranges: both must start at physical address 0 and end below 4 GB, while
>>> the Root Decoder ranges end at lower addresses than the matching Endpoint
>>> Decoders which instead must always respect the above-mentioned CXL hardware
>>> decoders HPA alignment constraint.
>>
>> Hi Fabio,
>>
>> Here mentions that the end address must be below 4GB, but I don't find any checking about that in the implementation, is it not needed?
>>
> Hi Ming,
> 
> Good question, thanks!
> 
> While a first version of arch_match_spa() had a check of 'r2->end < SZ_4G',
> I dropped it for the final one. It ended up out of sync with the commit message.
> 
> I think that we don't want that check. I'll rework the commit message for v2.
> 
> If the hardware decoders HPA ranges extended beyond the end of Low 
> Memory, the LMH would still need to be detected and the decoders capacity 
> would still need to be trimmed to match their corresponding CFMWS range end. 
>>
>> [snip]
>>
>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index ac2c486c16e9..3cb5a69e9731 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, void *data)
>>>  	cxld = to_cxl_decoder(dev);
>>>  	r = &cxld->hpa_range;
>>>  
>>> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
>>> -		return 1;
>>> +	if (p->res) {
>>> +		if (p->res->start == r->start && p->res->end == r->end)
>>> +			return 1;
>>> +		if (arch_match_region(p, cxld))
>>> +			return 1;
>>> +	}
>>
>> I think that it is better to check LMH cases before checking (p->res->start == r->start && p->res->end == r->end).
>> Per the changelog and the implementation of arch_match_region(), below case should fails but current checking will succeed:
>> the value of 'p->res->start' is MISALIGNED_CFMWS_RANGE_BASE and the the value of 'p->res->end' is equals to the value of 'r->end'.
>>
> I think that the expected "normal" case should always come first. In the expected
> scenarios the driver deals either with SPA range == HPA range 
> (e.g, in match_auto_decoder()) or with SPA range that fully contains the HPA range
> (match_decoder_by_range()). 
> 
> If either one of those two cases holds, arch_match_*() helper doesn't need to be
> called and the match must succeed. 
> 
> Besides, other architectures are free to define holes with many constraints that 
> the driver doesn't want to check first if the expected case is already met.
>>
>>>  
>>>  	return 0;
>>>  }
>>> @@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>>>  		if (cxld->interleave_ways != iw ||
>>>  		    cxld->interleave_granularity != ig ||
>>>  		    cxld->hpa_range.start != p->res->start ||
>>> -		    cxld->hpa_range.end != p->res->end ||
>>> +		    (cxld->hpa_range.end != p->res->end &&
>>> +		     !arch_match_region(p, cxld)) ||
>>>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>>>  			dev_err(&cxlr->dev,
>>>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>>> @@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>>>  {
>>>  	struct cxl_endpoint_decoder *cxled = data;
>>>  	struct cxl_switch_decoder *cxlsd;
>>> +	struct cxl_root_decoder *cxlrd;
>>>  	struct range *r1, *r2;
>>>  
>>>  	if (!is_switch_decoder(dev))
>>> @@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>>>  	r1 = &cxlsd->cxld.hpa_range;
>>>  	r2 = &cxled->cxld.hpa_range;
>>>  
>>> -	if (is_root_decoder(dev))
>>> -		return range_contains(r1, r2);
>>> +	if (is_root_decoder(dev)) {
>>> +		if (range_contains(r1, r2))
>>> +			return 1;
>>> +		cxlrd = to_cxl_root_decoder(dev);
>>> +		if (arch_match_spa(cxlrd, cxled))
>>> +			return 1;
>>
>> Same as above, what will happen if the root decoder's address range still contains endpoint decoder's address range in LMH cases? should fails or succeed?
>>
> If r1 contains r2, there is no LMH and the driver is dealing with the regular, 
> expected, case. It must succeed.
> 
> Think of the arch_match_*() helpers like something that avoid unwanted
> failures if arch permits exceptions. Before returning errors when the "normal"
> tests fail, check if the arch allows any exceptions and make the driver
> ignore that "strange" SPA/HPA misalignment.
>>
>> [snip]
>>
> Thanks,
> 
> Fabio
> 
> 

Understand it, thanks for your explanation.

Ming

> 
> 
> 

