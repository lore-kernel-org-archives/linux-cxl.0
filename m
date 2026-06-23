Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7485389DEC
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203999; cv=fail; b=jL4AJoh235lOB3rllvA4s8GSEBd7VIi9ZZMWAoAvOhR582sB8WMpzLbGM2urADouDHlWSjfYNVYXG6OFzPvg9FYR/KPDc9tqmvO17z/9IGbWBaB4xFlYcTbYODo/1Iaq0OJYs2b4PmDkCHlFyWzQrHdFZVqjyhliKgIRlVMP8Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203999; c=relaxed/simple;
	bh=A3EWWV9KohoEEdeYTA3I1AU9RToxxEnKKp+3/AC5Gu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5e8gD8vfbPC/sQdT5zElLCU87U9/b51UjV90RsUh864PCu/ldRHAx10CRa+1kvAdA7OaPIgZMs55VrGEFROwLCSOMB/PDW6WkH+XzOoQruwjyI+QRpFzZv0S+X6K8A4bWdtjMBNlCNA04QdPk92faIunhT+Oh9/pOqvQmGu0ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nrdSEgjQ; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nrdSEgjQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPSykDtoIyJKnUwTS9HwjVEweXcor1CJ4bq3IM0zhjK/qn8SN/yr8nNyk4dMXMQ2XO6eVaslotd3SeYIk/j7h+kHtHlkbJwzvjLP87rMBgj+kvESCF9wLOtXtDzFxPhQjad6DTNqSy6SrfNM2R7pUyUd9WPT9RjD5qNwEWMFSOsk5iMMna+SAq8j+FDLEejFKm3pyBv2fmitAHxw+0ibqeD7Z8so/cMu43Io5bIiMOPxSdhhXkYMBbWCg5f7yAHvNAIuLQW5n8WismEvm8kshlAREKoMZ6MFbm5QhuyMMuXN1BcKvfRA+viQM/Y5uwH4Qwb6GZmKItug4enzNjDiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBV87jQUE5OG/9K9Y4RzbyfFjEut6tODC46Oh/izN74=;
 b=fCAZB1jEWe2N2CNg/3gNbCkP03vBmn86IVaFV/0IvwuQAwkwoM6knRuSaSEELr4li2TBKlzm2q+4Qob/EKD8yy2Gw1tGHndnqi4Tv7xiL853U0SoW89IY7elJAea5Cy3P7kOtswbenXmEg9df6kVBeys1vB6Gf1qQYY5Ev4Nt7vBgZ1USOlsp+B5QQpzcxQ2uAp1TkCdSuoSx1JXV4HZWVEIYylwzrmoUFZkLDBwjM8tNKv3IiGzOMU7QZGslT/fVI0cYIBMMUmbPLMOAHVMd1BRnoQnvO+t5lKsYdu+KQ04JLFEPAjHWT+Q1Xks3xuao8mW/43fObJjpgldToCL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBV87jQUE5OG/9K9Y4RzbyfFjEut6tODC46Oh/izN74=;
 b=nrdSEgjQ394hOnlE2z7d7JmWKhenq2IFHfW/rw7lFIUtmG9NbVqNU90x8LNhtOJC6QntEMYeSG4DOIzINa8ZgGbtIcZqlPvMybcnCjPzmgn+JB8IUcS3OrSc9BcYDuQr13V2Ys4Z6trmfC4e4UuaUN/S1/L2Cz1OV6W9kwRwt+XCtqlt2LyOTPt+H4lX1G10U0zsPjdRtCYNQcOSsLuQlwzjCacz2ZWF/s0eU/zaJ4OZIyjcghS79CkYfteKiFAJcGM5RtxKodTdS72IRzuUJoTWIriQQqZ7cAhsP8yQv6F4d4HoOTOZEDVbfl5R+eyg7qDMbMVSPeFJb5xGSrt9EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:39:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 08:39:52 +0000
Date: Tue, 23 Jun 2026 16:39:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Message-ID: <ajpEy-oubtV4E0lY@MWDK4CY14F>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-5-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615145529.13848-5-dave@stgolabs.net>
X-ClientProxiedBy: KU0P306CA0096.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 28da8d47-cd69-4c2a-705b-08ded102fe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|3023799007|56012099006|4143699003|5023799004|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	W2Z6/VWywQRaZ90eTllyzPg2old3avR6XxB1pc3pE1jPZgjOkV1Jeew6SkoMqjLmsf3Is0uRHtzyOZDcAyO4ETUQvYKWJZi/LiSJPEcqCc8/CzLeVN2CSh04HPmbwEkQ9RDZ+5C8fdWi6VAmuNv1oiPw6Yir1mwEcAv4GTQ8JzpBFy/D3yfDuFv+w3zqxqaneX+BY0uzqClNg4qIMTLpaMQOTcFgPfvge9hRqjGvD4qLwJnNEi1QO2idtgrcVnvH9/DpzdrkJtD6Yus66pQu5HyXtyszC8c94/fg7ab0Sg/GsCG+QkrA6vxl0aEvmtR3TJtU0WZbT4kF48ahHFpQzT7MRKKDDMDxxBerzr+GFtTSlhRPGj/1r63O8+6T6kY0Fo0AYLxixl31trFSGgj8d/8DG+zBjLCmRgPG5cRs8DrxwZnvKOmegGnxgYtwDHXbQRYnqGKyh8hGPZr3oXqT7iihtYz/AcCWo515m7Zpsd/+U4St1m227Boq3pWE4D1ofbukcQzwxNsxHo4u1c44EehvFgSUTgVCVOVvOyz4lzPx0NcYJQNI4qf6NPB/3cRuNx7BXi3wjBErW5S1cAqNr/zvcjcrV6fgBsE7DiLIQnljntTfegNvaDkTA/7Qv9c0Dy+J8MiMFVPXEk7PGwqe47zAeYuMO8AgdkqvmOVeVDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(5023799004)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jb+nldpOYcCiEV81j9VAzrmQqQSOkKDKy9c4YqUFTsyNQTAVX2wYp23lyoOp?=
 =?us-ascii?Q?LDtEJgX0/ogi1YrUW7mDOr+syungExNKoi3tc9aHEp82mVEVpU9kUzCp36kL?=
 =?us-ascii?Q?VMTHmMcyDwh/QBhiE8VP56fQWMgES0TVlQ2clgAihCK+TpklJ3HMcIryogcc?=
 =?us-ascii?Q?cBZGBI5Jo2JNwvS9iDdy27N3xw45LYygZJybYWkYtdv/tPVCJHQgGET47/4p?=
 =?us-ascii?Q?Lt/KhQeV70+Z5yB3FzoZgYw4QZ5+F394utsEGAwdYciN1urVArY2sB2ux6MU?=
 =?us-ascii?Q?6mgxy+aMt8Z1SDUrQTGl1UKKUN1he1j6FmlCyZxiJdnlnB+TK4TEAEWfDLl+?=
 =?us-ascii?Q?yXDYrABqb5uLP9tmxyX0HsYSioEZsLYjAb1AtmJ/+KwVGOkGLqNpX/qkvVm0?=
 =?us-ascii?Q?SlR0yTJr34nFA6SoHPmCfTVXpeSZKJd4eScBh9/99jcFQznL+QOs9o1cFxhd?=
 =?us-ascii?Q?drsI6QpepriwKCC5ZkOXayCv82xWO1duJGKnCFqom7txy609aSNRGicYy3UL?=
 =?us-ascii?Q?r7EomdXeYI0DYyVO9xsT3IqLoYPO/Eo8W2/39K3JBSVyE8aXwFgJoLsW+3xE?=
 =?us-ascii?Q?j7ojHTvyheQcCx7NyndOpYCy5aTGfOeCr41nzdVjt7cIc7Pj8gonOKSZA875?=
 =?us-ascii?Q?v4r7U96fiO+Na0VqMBfygprrIgcZI5qhOQE6KPnwx96QlCnM7L1TZWc1QA81?=
 =?us-ascii?Q?G+nv0Aoj0WWz8v3MtlTlCdvYpJm2pixt4Knyvi2onthbVGpKNL/zuWqo0t0o?=
 =?us-ascii?Q?tKEOtS7o77ckXu7quOD3otpZnEm4+pd+4on6K9k/BPj+mqnUqQM4M8c6CLFR?=
 =?us-ascii?Q?e4VDmYPIpEAO9ylo4NJBrrAZbtQ+/+OIJ5NrNq71cC8UQwfyBpdinBxbKOor?=
 =?us-ascii?Q?fPo5kpPGJ+WverqjwtEdBscpUJP5NeJ8udUCT7uawAoVKHGUzSfswFJv5PUF?=
 =?us-ascii?Q?0+3ne4LDVY1Prv7eBPvClFobt+YkRha+mNkD3RJsmgKYemF+1kcMf2968Xk3?=
 =?us-ascii?Q?T/Czr79PEdpjqgvRL5vxAmNX2gqriZKrpUzzoYE+kDvOf08z6uk1MVVOeHwQ?=
 =?us-ascii?Q?z/1gniQLcD2kGXXVaieg6AGoVPisOmgAqyf0TKN2Q3ONZlgGTCAf3J5vORZD?=
 =?us-ascii?Q?pYHQl0en3aNaoalfO3r+BYu3EtlBsEf4WNpl7StaTl5ibTd87W8CTgHgLkYB?=
 =?us-ascii?Q?o9OQyoPjBSpQ03ahxnK2qopKIrQMi9QxPiHRNL3OxCeQec7HI7ZwDvrvhpPC?=
 =?us-ascii?Q?mdGFI1kAyuJCU32Aw+NAvG+ERp20mSP0C6JdFaVupwPaiYlLI8k5tWHOhSDi?=
 =?us-ascii?Q?eS4v8YDsVxDivMnrAn4H5jjLDd1DjSuUwgb7NvGeRhYeLCyVQEsd4ZZ8gtkx?=
 =?us-ascii?Q?5WVhHnyAIEVfEc0re9FwVws2vSTSFBVUaz9NuDstKIzLUD4UDvxCqd06BpF4?=
 =?us-ascii?Q?CTN6wqGgZwEU5jHoxQVOWcT1B9eZHxNt6J8hi3PPaUHqR0zuUEvKAy5XFWWR?=
 =?us-ascii?Q?oZOErWzUL5iP1l/2y6HZDNhTppRJgoX2xZcfhb01Jv7tqDOYZDIGHZXbmwO7?=
 =?us-ascii?Q?zHhCFJJsltJxoofKjkubRXd26T3q92Siu48//zYePgB3VJh2LInCzdZO4/T7?=
 =?us-ascii?Q?APm2yrFi1cthpf1KAxBTbS2kl99ajG9Pw6SquO5YtIpZyrMBIGUDmAJjI8ni?=
 =?us-ascii?Q?ENxaZ2DSTCuGrqKzIWesRuE8UKpTbmbqW5EbKp3KDiG4OnSZry9BvbzR48JC?=
 =?us-ascii?Q?xC9lStgdXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28da8d47-cd69-4c2a-705b-08ded102fe76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:39:52.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCyv1cLUllWLSHCVVSbD+prgSzx+6qmfn8gZ3STdoHvhKvCpmGtDyvxOaLxEPlDVzmzcWZsmI3ZCxk3+OcIgeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

On Mon, Jun 15, 2026 at 07:55:28AM +0800, Davidlohr Bueso wrote:
> A region inherits its coherency from the chosen root decoder: HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
> 
> Surface the topology through read-only sysfs:
> 
>   - decoderX.Y/cap_bi (root): CFMWS BI restriction.
>   - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder().
> 
> The HDM Decoder Control BI bit is set at commit time only when the
> target_type is DEVMEM and the BI capability is advertised
> (cxlds->bi for endpoints, root F_BI for switches).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++--
>  drivers/cxl/acpi.c                      | 11 +++++-
>  drivers/cxl/core/hdm.c                  | 16 +++++++++
>  drivers/cxl/core/port.c                 | 32 ++++++++++++++---
>  drivers/cxl/core/region.c               | 46 +++++++++++++++++++++----
>  drivers/cxl/cxl.h                       |  5 +++
>  6 files changed, 113 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..3db6ac1a700a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -297,7 +297,7 @@ Description:
>  		Each entry in the list is a dport id.
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
>  Date:		June, 2021
>  KernelVersion:	v5.14
>  Contact:	linux-cxl@vger.kernel.org
> @@ -306,8 +306,9 @@ Description:
>  		represents a fixed memory window identified by platform
>  		firmware. A fixed window may only support a subset of memory
>  		types. The 'cap_*' attributes indicate whether persistent
> -		memory, volatile memory, accelerator memory, and / or expander
> -		memory may be mapped behind this decoder's memory window.
> +		memory, volatile memory, accelerator memory, expander memory,
> +		and / or back-invalidate (HDM-DB) memory may be mapped behind
> +		this decoder's memory window.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/target_type
> @@ -426,6 +427,17 @@ Description:
>  		current cached value.
>  
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/bi
> +Date:		June, 2026
> +KernelVersion:	v7.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows '1' if this endpoint decoder is currently configured
> +		for HDM-DB (device-managed coherency with back-invalidate).
> +		The HDM-DB state is inherited from the region the decoder is
> +		attached to, which is in turn set from the chosen root
> +		decoder's CFMWS BI restriction (see cap_bi).
> +
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..6a9ba82719e9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  		flags |= CXL_DECODER_F_PMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>  		flags |= CXL_DECODER_F_LOCK;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
> +		flags |= CXL_DECODER_F_BI;
>  
>  	return flags;
>  }
> @@ -198,6 +200,12 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>  			cfmws->header.length, expected_len);
>  
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -437,7 +445,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->target_type = (cxld->flags & CXL_DECODER_F_TYPE2) ?
> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4a41cde9fdba..a6844b4577be 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,25 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
> +
> +	if (bi) {
> +		if (is_endpoint_decoder(&cxld->dev)) {
> +			struct cxl_endpoint_decoder *cxled =
> +				to_cxl_endpoint_decoder(&cxld->dev);
> +			struct cxl_dev_state *cxlds =
> +				cxled_to_memdev(cxled)->cxlds;
> +
> +			bi = cxlds->bi;
> +		} else if (cxld->region) {
> +			bi = cxl_root_decoder_is_bi(cxld->region->cxlrd);
> +		}
> +	}
> +
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
>  }
>  
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..71801dfd614b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
>  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> +CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
>  
>  static ssize_t target_type_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
> @@ -233,6 +234,19 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(mode);
>  
> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
> +}
> +static DEVICE_ATTR_RO(bi);
> +
>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -329,6 +343,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_cap_bi.attr,
>  	&dev_attr_target_list.attr,
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> @@ -339,16 +354,24 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h, hdm_db;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
> +
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h, hdm_db;
> +
> +	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
> @@ -402,6 +425,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_bi.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
>  	SET_CXL_REGION_ATTR(region)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cc41c08c0c0c..79cfb31f09c7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1132,11 +1132,13 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	/*
>  	 * Endpoints should already match the region type, but backstop that
>  	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> +	 * based on what is mapped when they are assigned to a region. HDM-DB
> +	 * endpoint decoders inherit their type from cxlr->type below.
>  	 */
>  	dev_WARN_ONCE(&cxlr->dev,
>  		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> +			      cxld->target_type != cxlr->type &&
> +			      !cxl_root_decoder_is_bi(cxlr->cxlrd),
>  		      "%s:%s mismatch decoder type %d -> %d\n",
>  		      dev_name(&cxled_to_memdev(cxled)->dev),
>  		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
> @@ -2034,6 +2036,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2083,10 +2086,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
>  	}
>  
> @@ -2772,6 +2796,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
>  
> @@ -2779,7 +2804,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
> +	/*
> +	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
> +	 * produces an HDM-DB region; otherwise HDM-H.
> +	 */
> +	target_type = cxl_root_decoder_is_bi(cxlrd) ?
> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
> +
> +	cxlr = __create_region(cxlrd, mode, id, target_type);

Hi Davidlohr,

I have a question about this part, I do not understand FW so please correct me
if I'm raising some stupid questions.

It derives the region type from the root decoder's BI flag, but on auto-discovery
path, it still and it needs to take target_type from the endpoint decoder's HW-read
type, 2 different sources that can disagree.
An auto-discovered DEVMEM region could hit the "DEVMEM && root bit && !cxlds->bi" check
and reject in cxl_region_attach() before cxl_bi_setup() has executed.

But path 3's init_hdm_decoder() -ENXIO on a committed BI bit means such a decoder will
never reach construct_region(), so this scenario might never happen.
If so, maybe a changelog or comment noting that HDM-DB auto-discovery is out of scope would
help?

Best regards,
Richard Cheng.

>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 917a6aee5936..29231d0db470 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -287,6 +287,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {
> @@ -807,6 +808,10 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>  {
>  	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
>  }
> +static inline bool cxl_root_decoder_is_bi(struct cxl_root_decoder *cxlrd)
> +{
> +	return cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
> +}
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  
>  /**
> -- 
> 2.39.5
> 
