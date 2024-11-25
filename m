Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2060.outbound.protection.outlook.com [40.92.59.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C56179BF;
	Mon, 25 Nov 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524187; cv=fail; b=TPxEB1VuW4Hil8Uwp6fOMBc7Xg2RbVyGzOncOK6UoCROC7wCQhadH208Kkm64v1XFZxtcX7Nye1+yKFDUodRj17jPMflKAwoLHFbrLGVfXgdZufxr8WpWAlGjaZPkB/Xw0IRr0UPHI0WfL5+Hit/HJPfclgH9uTRtfO4qfgZbA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524187; c=relaxed/simple;
	bh=kztp/uXyIUn/pzMDo20p87i42bjThNEpi1pR5ngB28s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDJCR7VmZAz0cx0AGQrYYi05PFdI9ConpBkVYGsRpK6ArDP+daLd5vCcyN6Km+TNRSR7YStHO8+K48I4niTAwmp2vb0Ml8x6k3n8sXIzi3H6B7C+nsr8xbzqAYSFBHFvxy+lm39O19KNe34f5HfiA3/TAE+zaU6NGAaw8bsfQu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pgCHtsuz; arc=fail smtp.client-ip=40.92.59.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pgCHtsuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+gmoIe46C5sUDq1Dwvob1x3j5oRCSV1Ve5ckRhppiC6uUVtnosViGkKyjxx6zuIztRunJXZKLxpmcbPwQuoXgHIFI6hbONsgc8HAQnKgnVrqn4VmzmcvsUaYT+DRsroqa1MpW6g9CA2uuxmqCKB2+1SIsfvELkY+DFF1YAYomIvOjmFjq5QDnhyY4SY5vOkWX2qmx1y3jZTGpW1C2hKjmKrn5eZ7WAmtS3leWjJZJUBfsQm3wSH3JulLahjNN+Ib/8XA2VkRBxbJu80AhmhW+CSZ33108Y4/wI8NmBznA5cI+iWiw/II8/bHFZ/xDfo18zWe50D/OFJfz++QqATiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3ENaH7tpbZHHSNPZwVGf6u5CF+YLfZIgjFjLDd/5pI=;
 b=P4HqmQuvWmN5yh+PWiOqkELHB42AWOgk/D/6aToCghR2olVwSARiDzWBU+BBt7FNDJiFa3kkIRAId8cOroDXPIY2NIComYLz4F0Oxzw9Vj9M9C1cu4Xp59AGKIt6bUSUBe8FW0dBUudpneLBfGoCILMwwq1f6gVwAZHWiYXuYjBdsDz1aYZUdYyqzB75wjbbZZukpp1gZuNbEMaGDQXzQfDv4vZ8meoG2ckQUVxLN5RW80uEXoEszkA9zX2BSrhMnuupMgHV3MlF7EexulL3gaBOTsckB49V10yuFWBaS9Ryh1CQjXeK+/Y3iMcwWWEUdU48JrDABKJKqwlY8nbZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3ENaH7tpbZHHSNPZwVGf6u5CF+YLfZIgjFjLDd/5pI=;
 b=pgCHtsuz/ZuithtiH+9LxKzO8y0nqmNu7nO+XKdoZQY9tPnlYItpfHE+QDnkXTov03YJUx7w8QqpbvTs2p/LDYwCRYmwYPYyLQIMeL8mTkRzMlPm8ZpBlC3886OBLqYzahcBrxd5Drq+HtXfuIbNO/DdWUZolCeOYUkuWIIjiTYI8k11c/Z/ACaJtCu/FRaasuWoGKXNDqTTNZXhe2fBBnkzcAcoDuN5qYy6I4Ua85DUBTT/7hMYIJIYNAg6rsYyPrOnWGmmLK/ceSAOOPZmAcxOLyL966XG4Qbyqrj21hI+jm6hDY3nGl4ODaLpMBdSll31gbdoobNy6GJP/x1E5A==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by GV1PR10MB8708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Mon, 25 Nov
 2024 08:43:02 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 08:43:02 +0000
Message-ID:
 <VI1PR10MB2016115B9C59CA9A74312092CE2E2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Mon, 25 Nov 2024 16:42:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <06abc31d-4945-4cc6-8074-086596159f48@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|GV1PR10MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a0b28-048c-484c-319e-08dd0d2d2c63
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|461199028|36102599003|6090799003|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1luOGVFR0h2aDRLTDMzekFXQ0dxcFlmME5JMlFVSm5YY0FVYlY2YWRqVGtV?=
 =?utf-8?B?L05rNyt5bVdGZjFlbEVZNUk0VGt3UVNsdzR3bXBXM1liTEVWWjlJemJadk5E?=
 =?utf-8?B?c1RnOW8zZ1orZnk4VGEyWTFYTFJxbFlSc1p5dVpjd2x0bjRucmRkQkdXSncv?=
 =?utf-8?B?eXVMSW5ib0JGV2lVdGZzR2trbTR4KzFWdVVQN2swOTVvRnMxWG50QmpxSC9u?=
 =?utf-8?B?SC9FWFk0eVBqL2VoYzkzcU1BQXNBTEdHbktNQ3lNK3o3aWVWUGRrbjZEbWlQ?=
 =?utf-8?B?R3R6Z2o1VU5UZ01IanRTQURRVVpGNStLNlVGMXVrSzRHS1BHRGROSU52K1lR?=
 =?utf-8?B?K1VtNW8vU0ExQ1B1SkxtUllFQVhDYTBwM3hMNmhUUGVxSVhCMitCbzl1YXJ5?=
 =?utf-8?B?U0xuL0tqZVFMUUVmZzdJK1FsY2JncDhjcTlRK3pjVEQrRDlGVXUyak85M0ZS?=
 =?utf-8?B?dDEzRnpHTmlSUmVyWDJDZEl2cVVZMVI4Q1NtTkFWMkxrc0VuV2J2WC9xNXhm?=
 =?utf-8?B?TmtPOVRCMHI5ZFlvWEFIc0t4WERjZ0FaQ2diRmQ2cDhDREFNZTIzbWR2d0Vy?=
 =?utf-8?B?TkJKWTFLWW5tampOQ1h3QmNiRis0S2dOK1ZxazIxZmx6aExkN2JZZkRJbGFm?=
 =?utf-8?B?Y2FSMmM4dWV1NGN3K29wQlFmdDRabUlTM1YrYnNvWFFSL3dTcXFDcm9ZcXAy?=
 =?utf-8?B?OTB2NE1TeUtjL0FNTmtMd2JJRVloTFhUbmZXbStIaTlSZFZtRTVtclY2TllG?=
 =?utf-8?B?MzhBQ3ZydDArS015ck5wSC9yQlk0d1hITnF0SmhqUWVTTHEvYjdTSzFDbGg5?=
 =?utf-8?B?eFc5Q1ZQRnJIVUpjd0NNdGQyeEQ3RWRRUWZ0NVVxckVqT080RUdTa2pzbDk0?=
 =?utf-8?B?TFV5WWZ6Ky9ZVU54MVVPK3pLeTFJTC83UGVMUFc5bFg5Q2ZmNW00clJadFhK?=
 =?utf-8?B?WG9XTTVManJmTXgrVE9kamZLYVB3aTdFMTFnLzZVSVpIdU00K092Zld3YTZS?=
 =?utf-8?B?Snp5cTJXYVRNY2xtVUtQaW9kSjJoczJYOHNLc05oNVl1eDltdk9PRitzM3A1?=
 =?utf-8?B?N3c1ZEduRnhyMUNoRVZraE9VZzd1c2FQSitVVzdEcVhNejFFKzdGWTRwS1ox?=
 =?utf-8?B?ckRaeG0rY3ZJZkpuaVRvRHNDdUlidWtJWUxGME5nSDV1dmRzZzRwM2x3ZGdO?=
 =?utf-8?B?TFkvcVRxQVJqTXRxWUtJYlEwN3kxYUNEaE9ZOGdqMW1yUWh2L1MrNHdxQXdi?=
 =?utf-8?B?dDNxS0hRMEh2MXZORGJFa2t0YVZTTDhySUUzSW5JQ2EwYVVxZXBIOUdCVzRy?=
 =?utf-8?B?Q0RqbWIxaHkxQndGcUlkMERtSHJKOHQyVDNzZFdhMGZUekxMOWZPNlo2MXNz?=
 =?utf-8?B?aTJNZ0d1WFFKc3hNbS9DckZ4bk5YMVpUTEh5QldnL3UvaHpIOFBWMDJBbTdX?=
 =?utf-8?Q?B34TAgvQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXJGdXh2Rk1PbDZ6MmVrYWlJRDlFdnBOSmNOVTg4MHBYZDlnK1g4amdCQ3pE?=
 =?utf-8?B?MkJObENNQW1VUWRCODMxTDBPMHVPRGhqWGt1SkJGQ2hxaXFzWUN4ZFJ4UUJP?=
 =?utf-8?B?ZGFKbjhpbDBtcEM3RlNDbDJSblNUQzFmYmJjNnBZb3BmWnYveDhZdGlweDI2?=
 =?utf-8?B?d0ZtSkFuZWU0MTFDWStteCtvbTN0Uzc0VWlmR3RGZzhKKzF6Wkk4NGJwQ3A5?=
 =?utf-8?B?OVJnYWJCOWlESHdOdDNDUVA3RGJkSVBoZnJ6TFhuZStWU2lYSHVzbEVrdFpQ?=
 =?utf-8?B?VGNsb082U0RzZ0lROHhFY2gxME9CWXpDOXVrKzZwSEp0TGJldTRYdUdnUmky?=
 =?utf-8?B?a2RzdXVSeDNxZVlaelZxeWhWWGQzK0dhZWFxb0xCeS9FeGp4emVpRzZJbzZj?=
 =?utf-8?B?L0t5dDNRZ3NzbmFPUk1LRTBlcXNsR0Z2VHE4VkNwS2RRUEJlYlRIckc2T2I0?=
 =?utf-8?B?ME9UNVhaWVhDWnpnZmhCY3pmcjdHUDBDVW9yd284czJETVAxcWhrNlQyUytT?=
 =?utf-8?B?OWZGcjJzMmtsSUhVclkrZXk5Vnd1cldZeUQ0MEF0dktHcHJLKzZCRHVud0c4?=
 =?utf-8?B?b2l5WkxodTZ3VEtkM2N0VzdpMDhCc1RsdWpHVi9oaGNiNW81Y1ZuVzRhZWhL?=
 =?utf-8?B?My9sYzB5S096VEtNMXJpMER5SjVmL1JFb0hrWTg1ajhneDJPMWk1T1I1LzFn?=
 =?utf-8?B?aUJxYlFmYlNUY091YkU1Nm8yMWl4TTFpempkME9uSnlBKzZRanVhTm5HeVZq?=
 =?utf-8?B?RWlISG1jSlRDZUMxL25pOHpIWXdVazdFUjNtZXVuRE1ncHYybkZ1OGQ4VGQv?=
 =?utf-8?B?d1ZtanV2TVdiOS9nVzU1Si9FZkxWR1BpbFBSTmVvNnFDdXB1QkFCNDF0UVNG?=
 =?utf-8?B?QnJxU1BzZTlEVGV3L005YmdTSWlkcFNYSERKSDlQc3E2M2l3Sk1xZENnekto?=
 =?utf-8?B?ekU0L3BHaXZvTVI2cXJIL1AxdGtMVExENHI0TDBNTmxkWjFkN0M4WEQxOGtO?=
 =?utf-8?B?M3JpUmVidTlUa3hDbmhKR0tMSHlNdFFza1VNT2lNMzFkbXRxMUQxUnUwNUVH?=
 =?utf-8?B?NFNmOEM0b2ZlSkk3TU5zWGhmT1RQMlNqekdGQTV6Q3FhbVNXaWJ3V0pkbFpm?=
 =?utf-8?B?ekxRdTJ2UFczMUp3RXVYMjRCOFpJQ3RyUi9KMWp6Y0J6ZERUQWkvOStKU2dt?=
 =?utf-8?B?eTJUWCtKa3RwNWI5MDR6MUF5a0xZVnE5T3Z0clBtaEk5aWJTK0Q0aVFSbzBJ?=
 =?utf-8?B?RUlyTzB3a1RaMHRWZ0NNU2tFbUtYNi9KTm1TV2lQcHZiY0hMcUNlT0xtZzNy?=
 =?utf-8?B?ckR4NnZHSmQrcFd6RXRJN1czS2ZEcFZpNHdBcVNmOE1WaUtyYXhsamxCWDNC?=
 =?utf-8?B?MXllQ2FBalJVM0wrU0VkS0cvWDdjSkR6ejFkZ2lQS01SR0hqWGQrN1ZrNzhT?=
 =?utf-8?B?b1BKeGFMZGtuazVNVlJFL01hOVh0MUFLektKSnExQ05ISkFSbmV6OU4yZUxu?=
 =?utf-8?B?cVdFVXlWa0tQUGNpMEk1SUpzZlozR1BFblUyTFBLN1E5R1Nsa2FqRHd4WlNY?=
 =?utf-8?B?NW1zY2hNZGFDQW5hRTU1cExFSjJPblNzOHI4WGFPbjhOTDdqOXRrMFFoUE1r?=
 =?utf-8?Q?UPJ4f9KTGJPQJngUS8xWiBYhjdRsgIRCgQqfjIx0vBKs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a0b28-048c-484c-319e-08dd0d2d2c63
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:43:02.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8708



On 11/22/2024 11:51 PM, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> ranges: both must start at physical address 0 and end below 4 GB, while
> the Root Decoder ranges end at lower addresses than the matching Endpoint
> Decoders which instead must always respect the above-mentioned CXL hardware
> decoders HPA alignment constraint.

Hi Fabio,

Here mentions that the end address must be below 4GB, but I don't find any checking about that in the implementation, is it not needed?

[snip]


> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ac2c486c16e9..3cb5a69e9731 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (arch_match_region(p, cxld))
> +			return 1;
> +	}

I think that it is better to check LMH cases before checking (p->res->start == r->start && p->res->end == r->end).
Per the changelog and the implementation of arch_match_region(), below case should fails but current checking will succeed:
the value of 'p->res->start' is MISALIGNED_CFMWS_RANGE_BASE and the the value of 'p->res->end' is equals to the value of 'r->end'.


>  
>  	return 0;
>  }
> @@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
>  		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    (cxld->hpa_range.end != p->res->end &&
> +		     !arch_match_region(p, cxld)) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> @@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (arch_match_spa(cxlrd, cxled))
> +			return 1;

Same as above, what will happen if the root decoder's address range still contains endpoint decoder's address range in LMH cases? should fails or succeed?

> +	}
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1943,7 +1954,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3199,7 +3210,13 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +
> +	if (arch_match_spa(cxlrd, cxled))
> +		return true;
> +
> +	return false;

Same as above.

>  }
>  
>  static int match_region_by_range(struct device *dev, void *data)
> @@ -3217,8 +3234,12 @@ static int match_region_by_range(struct device *dev, void *data)
>  	p = &cxlr->params;
>  
>  	down_read(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		rc = 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			rc = 1;
> +		if (arch_match_region(p, &cxled->cxld))
> +			rc = 1;
> +	}

Same as above.

Thanks
Ming

