Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793606187;
	b=RIBfBLw3TEl6drAcsge5DPpZHIx8p2MqjrMhzDdjz4MnDWtA/yoZ+7oj8DhDp06UsyZv
	 2CA0ub+JLz1T4VUohrhUWeDr3hL8Z6p/X66RtVUvTcbFcXnhFzJSWtx6rrM7uheDsNcEw
	 9sPu0hE1Q8amYYrCFttSalgD607t268eaEXOR7gAXJp8lLU89OIacGSm93R3JiSLGjwHX
	 LQbJPKGBkQ3vOx7kHD3vT6TKBWfSHPTeE0rDH2rgIjttKx5jLUMXteo7M0tuhSujWK6ng
	 ehaVGTO0hJKtOX4JAQn4wlilQUku+lwXXwtq+ZxDKqzXPoKpTbIhd4fqYWjhS3FpjBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606187;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uFMpAdzfYy3Q6dsd0Zo27g3w+8Yd0tULNqvUE3aFD+M=;
	b=Y7xvlUP8FlUstv+rlg78hB0IhLr8GW66sQ1/AnBgO7w4suOpU3/wqu4tCdj3B7SxSJSj
	 5hB1eQdr50zZl2Er/NdN+K3/Ul5X/2VF5JJdg5znyr/MItVzoIxK0DVaC8L/JatqVPaHR
	 0XYolO3QCB8yJsZqG7BcAkhOWxZuFFSXkS+UVzA/FxDNXjsXG0ZtsHjTBpQ69+wm8UaJK
	 CCYTKE+D9fPhQYSnEYqgwi52S498hD9GCdj6vj3yUZBhdGUncCH79ikF/fqC2+i7HtzxW
	 zXWO3xyAqJWSg7PfpguBqL+jwLSZtTzuHYJXJnMRgVcYinawh9S4jK0WQUiCb1na3Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h3AA6baK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.2
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B4606A326;
	Mon,  2 Nov 2026 07:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h3AA6baK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1bBu78yizMTr9zb0RPc7InwFaWApbux4Lbcwv4Fo+j52Ho4LjXj4FJpcezhch+vjoKdXCI6zhd6uZt7VeOH34yn13mGdRyPsc2EXZ0UvvWEDFvTxHWdMAKj6zbANdktrIXnUzOrTaaQc3AoF25QAnTJaFVBfcTbG8dzA7267g84JHairp+1ybrFp4/iGvvDx3sqnRDQOWOxtE7+34U2BKzfx7wgvTpday2YysIOxZEteIcGBoKBKOBBSoJbybuoB4SoJmaJZDy91gV7vyutLVGndTyJnfGsG1mHWRi5MaO2qajHF2kpROgdfwqJ+ascYGWsf1zjx4NxiU/FnCNGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFMpAdzfYy3Q6dsd0Zo27g3w+8Yd0tULNqvUE3aFD+M=;
 b=VOHJM1cM+fE+PeFtoRYXuSfmNpuIcFpNP12nqVUZwaqDc+LAQwaKpiW1wSRdrdMX59NP2P0cvw2YxJ1VTxP0Cn6z/7G76J1Z8iH+svfZkrDbL73AuOLjAKnHP4EfuQxQP3FzlJuLe4P5zdnd7iqC+H2LRrD0+nNW82HYJtMc3W2KIyh9jgZirolEpIFgFhWHvaEtFCm+XuoJVh2QaXJb/Et1g6Yqq5k2mlTrVUkr0yvt05fDuMPhyHFMKsq3CJ3x7n+aHd3jEDKUL75dqFgSmXDLfjh7MqZh6fEdQhzfymH7lUXhnBvTnGbdalKVmQCnQJwLUAhCGnhz+MCx80/83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFMpAdzfYy3Q6dsd0Zo27g3w+8Yd0tULNqvUE3aFD+M=;
 b=h3AA6baKMyKsMtooRNeNK1I1hazAmW/066xduXigi/eP49SZgYyuwKxTPDMI2gnkchTfIuT2T5N4LEC8N485oDIOpFggDWGtLOFCKbIuzmuOkD9Vc634tW7ZyChGRdWV63xD8aChWzC2T0DgONTMYuDUx8DV5VvaoFcz8KasJgItutaZRTo1aFTtHf+6c1weRu+yHTssohwJyRqNla8kQU6v1jToiXbFaMoYUNX8+d3GkcV3IgFULxtzO+aDgXP+PbfSyP0dFOCYtdwrAy4XgfnMaJUa/BPPa38P3pSnwFTQ8mYsc79MLcGyxH7MWolfqFmGS8WcxdNmbqqZ1XXriw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:56:22 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:56:22 +0000
Date: Mon, 2 Nov 2026 15:56:17 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/edac: Read cached DRAM event records under
 the xarray lock
Message-ID: <aug-xbNiSauAAjjx@MWDK4CY14F>
References: <20261101013418.87326-1-ai@linux.com>
 <20261101013418.87326-2-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101013418.87326-2-ai@linux.com>
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 919c0198-9005-4e7e-a33c-08df38b6c96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kV+AbFjayG9O5FWaEBtwD5onQkzIZB6zsKyO9oKjz0VPB75DZGH8KME93v3GbqwSgW7ruDa8qhm0oxZa9IvNr4U4cUvz/s7oQ5yQTh/X+t/nJpMHpDD6381jUvXjvycOU0KsN5wbgllKAZ8NJ1pQvVXRK+FMZktctz3scg+D40kAnbga0/JqBL2KKDVMNFmhhPQlHa9896yTZvin/LvLG9dobr8i8q6hNiiqGVi7v+aTTlt/k7s0CqLwBes/HN3JzqKhpuU+SfU+dhK6vhBQ28T6bfMi04CCVjUMikwhE/2fIT9bCB+iU/ae1OiW+eBxbu6JyEFHXzi046VIVdzpMKlsH5IOh/ebtuj/cORwR2VPsmG9hvmBep4K8uUySPQzr/ds9PxeVgLaNufuKL7heYVK+MPYGs7BpuqveWAbqEJp3vQdsKYcH1sUGMHkya8QrG/H8mCwZhHT/ec4JSUlc3UlFq2MZUJbVryNW9sCfpqx0dC4IqBRnCyVv9tDRgrx4gR39AKvAk/hSfuJdplCxOBxHgmrVnw9N+AeAU5CqyxVv9QkNe0fPynn1T8c8/pN3+7PZ2rcPRKdJRmc0S8rJ8B0HmbHZ+YnZBHDo+VYLjZQCARrI5V09zpTnOqIfHKMRHKjVrtrbTdNIr2jwiXaqKJI9YmCZrlkL7yI90MD+oQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCXw0k5FnAMQ3eECjWCmgjr9M7f80DnsDCkJBQIQ7f+FaA1SuZONAeyuSW4o?=
 =?us-ascii?Q?fCxA32Qnng/6FhF2me3tdgyV2mwK0LwgqAfjsUUDo/cUeEYSmsv5DW/c1iuK?=
 =?us-ascii?Q?TQViAQp7755/9ZyvqqVmYs+3bqRTxlcEp873KiF3hm3QVfqDaYWszvMK3zUe?=
 =?us-ascii?Q?xstb9eOu8OL4Bx6DjOCosfNU1sO6CmNeAfK51XLyGpfsLKpF7947+9A1hmZV?=
 =?us-ascii?Q?XQkHj6SoZZiuy8bgCEuquFPnNXKitIREQVNVqcVscpo/NYpVCKUHbMEM1W84?=
 =?us-ascii?Q?QfkWqc4AePqxSbK3gGkHVy+IJ+f9pqElSPV6Z55ZKPPwPIeeaP8o32OLGUtg?=
 =?us-ascii?Q?7EYf9BYmcOER2udVpGahisw5dHnmky+Wdx+bZm6MY3GGtA5Ki7oOCsdmlsza?=
 =?us-ascii?Q?FqAsrBnjHiMgu+3Vkv+6tcuTJjOaG3hkaGhBL78WDYcWTX3gjY08f7qh2UaN?=
 =?us-ascii?Q?Ayam4L34TrVfTWwkE/vFFQUv0YOvO3HY6XBktTfu8WNitpFSav+24D2RKnAu?=
 =?us-ascii?Q?Eg5Ox+Ow0Vn18/5y5dMNckz6GEX0DWqe8WTIUBG5P3qqPjJSkodHxy1qWBXm?=
 =?us-ascii?Q?8mPLmRIA4HtiqjLztmllaJQi+Vf/5WJtCu8kkKQcGe629nDKlrUFrZi/HZ7p?=
 =?us-ascii?Q?fCY61vyNdAgqEImiQ2v3Zt95lNMiqk5Ds8JTIpaxJEgq0xVkI5W0ESIMXV7N?=
 =?us-ascii?Q?lycZO3tmaXg9kc1X/4ctt5ZsPpTmQ9sSJvvtGJVjBm5WrgZJ00ADdi2OLLnE?=
 =?us-ascii?Q?A3feBWlz4yOh4d4nc0GUYKr/kpP5c9bDn9xnZ44V3FZUAAt75jKz0hEGjq2w?=
 =?us-ascii?Q?c2IxjToee///5sCJix/SgJBeX97Ai/O2gVf5jukmWC3sbiofav277ZEQRLqb?=
 =?us-ascii?Q?781PnXxl8ctmic04484CYeR2d71C6he3JHzMkl7V6WuDA5FeptwS+jGVScIq?=
 =?us-ascii?Q?Crr81esza4kZyKQqoHus5P8ir3JorSobufu02jZv/P2D16Pu3FSihbfSB9pq?=
 =?us-ascii?Q?mkXdCii4noRxP7muszS+bQEOXPj2bcqaXrKwf3yeq29U4YC83lLGLkPWw8aT?=
 =?us-ascii?Q?kX9vf3EtQ9/xuYWGo5OKsn///4VFCWImGl/4pQwsuv7z2Ed+haNvkPBm7a8M?=
 =?us-ascii?Q?0LJFcCpt5qDIBSw7pJMbtyDdbxVcdarAmiYYmU24lLbGRv3EYIMB+I677iRG?=
 =?us-ascii?Q?s6yaf6FNNOyNjU+zyL3GHoH1a06tZ7mrjCugBfiopkHZlyFdeCkUAYH9WnKO?=
 =?us-ascii?Q?ItmQGDH9slYSEhslD398HU85MtboKGiqXCtVZwWI5468tHt+bfzzQbbjLvDg?=
 =?us-ascii?Q?GFFDKSDAeZIGDZfmQookkq0WZC6Pfnm3tSIpyMkbcd7XcdPoF4MbpUE5a0ce?=
 =?us-ascii?Q?QhmXQhaW7Ba++IVEYpBusL/FJFS1T3lCaOHRAvXNt6QRGLmo75CG2dvR/Tv0?=
 =?us-ascii?Q?6iuZZcOiVkPK6iP7NmH0SeOACxIsbDWiRg5VH2/3fCcudiQnRlR/PFmCrY3J?=
 =?us-ascii?Q?7M4C2sDwkmjTkNo1MBdjl7ZpN3AU9ruVrYXikCQtFYZ1wCnNBzrJECEVV21/?=
 =?us-ascii?Q?rYAEeu8ZgktRUG01VnRVdQDuWq0GSOU2Ikh/SVib20Sev2FNY0ztNBGlud4K?=
 =?us-ascii?Q?/SSCAa75NXw6aM9JMUqSpniTWKL2AaUGEh+j/hS188lLN7LL4XrTg9x4J5lA?=
 =?us-ascii?Q?RhnjhQjsRwpWIsYhRZzNistknkl1R1DOkZrDmb85BmMxsvZsfjOmBhl7b2Uc?=
 =?us-ascii?Q?EWoOwjgGEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919c0198-9005-4e7e-a33c-08df38b6c96e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:56:22.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxgYlqiSIG1rnqXkjPEKQjT5/QRvJckWdyl0DrR8rsR0yJc1VrfsQrSx1lKmOwaX3pOR0wWPgFRtkf5x8VUjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

On Sun, Nov 01, 2026 at 10:34:19AM +0800, Jongwon Lee wrote:
> The event path caches DRAM event records in an xarray and frees a record
> when xa_store() replaces it, when it expires and when the cache
> overflows. It runs with device_lock() and cxl_rwsem held for read.
> 
> The repair path looks records up with cxl_find_rec_dram() while holding
> only cxl_rwsem for read, so the two paths can run at the same time.
> cxl_find_rec_dram() reads the record after xa_load() returns, and
> cxl_mem_perform_sparing() reads validity_flags from the returned record
> again later. Both reads can hit a record the event path has just freed.
> 
> Move the lookup into __cxl_find_rec_dram(), called with the xarray lock
> held, and make cxl_find_rec_dram() return whether a record matched and
> copy out the validity flags the sparing path needs. No caller keeps a
> pointer to the record after the lock is dropped. The event path frees a
> record only after xa_store() or xa_erase() has removed it from the
> xarray, and both take the same lock.
>

Hi Jongwon,

Did the bug actually happened ? if so , can you provide the error log ?

Seems like the root cause is that the cxl's rwsem was only protecting CXL
topology and DPA, while leaving memory problem's entry ( those xarray entry )
without protection.

Using xarray lock is fair for me, keeping the access short and the entry
already use xarray as bookkeeping, though I'm wonder if there're better
alternative for locking mechanism. we might want to discuss abit about that.

Another thing is about changing cxl_find_rec_dram()'s signature.
Since the pointer can't be gauranteed valid after the function lifetime ends,
return a boolean instead of pointer is fine.
However, copy of the flag doesn't seem like an elegant choice,
if caller needs other fields in the future or bookkeeping adds more info
in the future, the signature here will need to be altered again.

What if we copy the whole struct cxl_event_dram ? PPR can continue
passing NULL since it only needs matching result.

Something like the following

```
xa_lock(&array_rec->rec_dram);
rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
found = rec;
if (rec && out)
	*out = *rec;
xa_unlock(&array_rec->rec_dram);

The sparing caller uses its own record:

struct cxl_event_dram rec;

rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx, &rec);
if (!rec_found)
	return -EINVAL;

validity_flags = get_unaligned_le16(rec.media_hdr.validity_flags);
```

What do you think ?

Best regards,
Richard Cheng.




> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 69 +++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..f0c12871bd 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -938,18 +938,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/* Caller holds the xarray lock. The record may be freed once it is dropped. */
>  static struct cxl_event_dram *
> -cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> -		  struct cxl_mem_repair_attrbs *attrbs)
> +__cxl_find_rec_dram(struct xarray *rec_xarray,
> +		    struct cxl_mem_repair_attrbs *attrbs)
>  {
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_dram *rec;
>  	u16 validity_flags;
>  
> -	if (!array_rec)
> -		return NULL;
> +	lockdep_assert_held(&rec_xarray->xa_lock);
>  
> -	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
> +	rec = xa_load(rec_xarray, attrbs->dpa);
>  	if (!rec)
>  		return NULL;
>  
> @@ -1029,6 +1028,32 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/*
> + * cxl_store_rec_dram() replaces and frees records while the repair path only
> + * holds cxl_rwsem for read, so look the record up and read it under the
> + * xarray lock, and hand back a copy of what the caller needs.
> + */
> +static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +			      struct cxl_mem_repair_attrbs *attrbs,
> +			      u16 *validity_flags)
> +{
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_dram *rec;
> +	bool found;
> +
> +	if (!array_rec)
> +		return false;
> +
> +	xa_lock(&array_rec->rec_dram);
> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
> +	found = rec;
> +	if (rec && validity_flags)
> +		*validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> +	xa_unlock(&array_rec->rec_dram);
> +
> +	return found;
> +}
> +
>  #define CXL_MAX_STORAGE_DAYS 10
>  #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
>  
> @@ -1298,9 +1323,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	return 0;
>  }
>  
> -static struct cxl_event_dram *
> -cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> -		     struct cxl_mem_sparing_context *ctx)
> +static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> +				 struct cxl_mem_sparing_context *ctx,
> +				 u16 *validity_flags)
>  {
>  	struct cxl_mem_repair_attrbs attrbs = { 0 };
>  
> @@ -1332,10 +1357,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>  		attrbs.repair_type = CXL_RANK_SPARING;
>  		break;
>  	default:
> -		return NULL;
> +		return false;
>  	}
>  
> -	return cxl_find_rec_dram(cxlmd, &attrbs);
> +	return cxl_find_rec_dram(cxlmd, &attrbs, validity_flags);
>  }
>  
>  static int
> @@ -1344,7 +1369,7 @@ cxl_mem_perform_sparing(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>  	struct cxl_memdev_sparing_in_payload sparing_pi;
> -	struct cxl_event_dram *rec = NULL;
> +	bool rec_found = false;
>  	u16 validity_flags = 0;
>  	int ret;
>  
> @@ -1362,11 +1387,12 @@ cxl_mem_perform_sparing(struct device *dev,
>  			return -EBUSY;
>  	} else {
>  		if (cxl_is_memdev_memory_online(cxlmd)) {
> -			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
> -			if (!rec)
> +			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
> +							 &validity_flags);
> +			if (!rec_found)
>  				return -EINVAL;
>  
> -			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
> +			if (!validity_flags)
>  				return -EINVAL;
>  		}
>  	}
> @@ -1376,13 +1402,10 @@ cxl_mem_perform_sparing(struct device *dev,
>  	if (cxl_sparing_ctx->persist_mode)
>  		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
>  
> -	if (rec)
> -		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> -
>  	switch (cxl_sparing_ctx->repair_type) {
>  	case EDAC_REPAIR_CACHELINE_SPARING:
>  		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
> -		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
> +		if (!rec_found || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
>  			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
>  			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
>  		}
> @@ -1399,9 +1422,9 @@ cxl_mem_perform_sparing(struct device *dev,
>  		fallthrough;
>  	default:
>  		sparing_pi.channel = cxl_sparing_ctx->channel;
> -		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> -		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
> -			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
> +		if ((rec_found && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> +		    (!rec_found && (!cxl_sparing_ctx->nibble_mask ||
> +				    (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
>  			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
>  			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
>  					   sparing_pi.nibble_mask);
> @@ -1814,7 +1837,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
>  			attrbs.repair_type = CXL_PPR;
>  			attrbs.dpa = cxl_ppr_ctx->dpa;
>  			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
> -			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
> +			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
>  			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
>  				return -EINVAL;
>  		}
> -- 
> 2.55.0
> 
