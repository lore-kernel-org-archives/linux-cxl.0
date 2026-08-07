Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79048470EB9
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103479; cv=fail; b=MT9GeJ7ndFvgAe5Qo0y3pOqubOf0SS6mAFJaD0c+AIN1OKGXzTl4Ox95hZZz90Z7cHGsuhCxcF1/rL8RVZxaDceVGTEaLGFXvIU2knxKu0iyDdpSeQb2WI4XPqK7+TwX8tru2mGjnM3Ft8mN3zngLciRTbvjVMdazdpLTwilUX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103479; c=relaxed/simple;
	bh=fVC3q2LIbwCELC+SkJZ9fb+/PjFgMgQ82pYFzEcfS24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARAT7nQvMsfmamkEIIXcNtft04EyZu4+IfDwUUkytOtwvOU6WEaC+VHTyEt8+9vfxDQuv//mbSuCuoIt54wT9xMUADau4GVjp1r5J/AR9v8WOnKjhLTxO/q9nJKRFccnNaulN/kIQkqJmXpzj3Z7w0DQN2Ln32uwp3LLFYQpw/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpExMBrb; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpExMBrb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh3Q5aOgmm9jSxQh3AszcHmpQN/250Zg9PKJQSvpD29Tu8b4FOuu59QGOzAFs8rjMgQK4psCiYaKSXIliAQqulpEik4K7YA7iLrUgsGYpG862oDXIj9B50wNdKz80JhbYd5hfQi4hGGVhgjBpUrliisyJFCwtaz3O0OHKe7ZD//M+T3afjNhFlshrwLJVdq50YoeuC0ejQ/QxyZ9n2/uk6fGmvEeirPEm+u4UlXsW0Dvv3wcTRGhs7hEcoprCkbEw4i57YjYKD4OHCTfUXpbXRNtudP1+We4CL+QDsw7hp+9gG2S4cLlEbMju2xAFVLmLJ0gnFd5xHd/2t7lYXItdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAK6UCnm2pOqx3g2G1WCJ9OOAazdi3rxlZRs4UcjFcE=;
 b=Rv4dPR/rE6d0cyEexbfg0FL5JYscGiTnP94TE7AAmWnxw78JSk7Pa//V0+SPOzmdz9Th30f25uC09mrMVojCgi70ic1WK2/wrv2wXwaHMugwIX+N0MnGYBDW+WWyB+qVaJEcqKhr64d5sSMbV73eunWQIDZWhRtviZE4vld3ISysrUa5W3gD8iEoFUMkrzZ+Aytw6QVvj4iXbAQ1eNSVjrxVR/v+Rl/SesBSuxIxCkwjbN0gmUfjpIKMxfo6ALXPY9RDltZkPg1KC2WjTlyvkiwpKkZxAgArbf7woshfyAW75yF1jhftP0rDC0HMx8XIXHi17IBzJehl3bh3/9aF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAK6UCnm2pOqx3g2G1WCJ9OOAazdi3rxlZRs4UcjFcE=;
 b=OpExMBrbaB/z0ktT5h8v7PkFIBfoHhY3ZPAMHJg9GzBmsZ2w0lFZ/7hJKM09MEyNdwOmvq2CZlo7u6uupNXibiFU/6UM/4fAvTTRQhCZL5Y35LLFBoPmP5K23DQJVPIuUJ5MHaDzMzHjh53mSHSO3TZyk3ANOVAqb3PQqd0tWvPAxFLnc42goYyYyvGt8nK2ZY235bQ7VF++/4aOXk40w4sXVjh3QEdt+uUI4ucl8ak9U9D50LU7YphFp3zgCnDxjaPz6/vdOSdg+ekjJs4T1/XBRF9+yJLW1pecxVv4BfFXeafO3yGqFbYUJXYRsZXSOoVSgaUfGxRwHixx85R5sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 11:51:03 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 11:51:03 +0000
Date: Fri, 7 Aug 2026 19:50:56 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 4/8] cxl: Add HDM-DB region creation
Message-ID: <anXFldW1WpSIsRUC@MWDK4CY14F>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-5-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-5-dave@stgolabs.net>
X-ClientProxiedBy: KL1PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: f24f36ee-b027-4cf4-d468-08def47a283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|3023799007|6133799003|11063799006|5023799004|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E56rO3nF6dUdwK8/MI1MCsuGWn2Ypbfrn4JmHvRTdX3/KMgy1yuIzHcdv8vq9/oLWOU0SU3JysqSdXPMiGtrP9BcVc1WbzAHnFMJYMNQGwQxm/Pq6SgapOYUkH4qfdk8hGWNaP6gE5PyGTXRH6BiLmWAK1fN37+GwvQ4Y+ORa6wJ9jHqcxteBn1ovAvYQfC6Nhr7wgEE50+9qDKtknMry/Q3LciqP8/26jpBERG3cF8D0jNJxAk1cC9XtN+GG0l5zXJjnH0ION9xbhLVMcnivzAE4wrrGicdOWC61ZF+qfbYWgmLcJXz2ZCfB/M/WY90dPWEWAmePDD1XwOz1CfnPU0zXEnAjfo4bioIVqZ1oqm46zn7f8zvhabqSA435eTPImytXo/rCIoJoCNi7/WKAdltlyHqSns50W9ELYK+fpC20lcdGVTnsCxq8MNDcDPw+bIuvQFu5Q9OeZ1t/XPzAdpEPbdS4tlX/fGnUU2TrZQhQ5alesQxdfLYTtLvEaYROgpGIFMhISLGjgDearPvknejxMRA0Ud0sRqHWtFmmmlX6CezXA1hVIoXPxJ8rn89FM7ffLcniqXLJBI+ebUytANpsrtPiqehXN6ZAWhm7ddHBA6q7r953DrzQSw8pnBL86CrIbQ+HKrUOjCDbWE7WLQDs5LXjOkH9axjLQhhrZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gd7Ytq0j8Q8FSfaE5Ip3bS2ZALUVGiqCM8/X/cnN4ypKr38s6AlToR6cCFiY?=
 =?us-ascii?Q?qHDla61bRoay1/tKmKtl1TwT4PctFnJUQcLZnfwuPMQGO5e8r9JXxZx0b3oZ?=
 =?us-ascii?Q?4j1VEH7bgviChmcqfubPAKCeQiwMjRIpk7c70F3qPhlXInBounla6ZzgRbv+?=
 =?us-ascii?Q?U9iAixiTs3nUpqxhXZ38WtQGQdyxLBM48ciKbjNpGStEx/yv58bxm8YMDiJu?=
 =?us-ascii?Q?rlFebXZRxmlK8Vv0rXutBazCXTg3K7d+uqAm0iGYpBsnnNFPWYpvSGh2VVHQ?=
 =?us-ascii?Q?Uy2cxQggBzt9EAdEoo3UEgsjc4JhJIehfvyRW7v8esiLGhIehBIPKe2h1Mbs?=
 =?us-ascii?Q?PELVTxRiCnnkPWXyyHQgWlXnLcGN9mO4bLhBQErBKh76h91FH3Qm6dpURGRI?=
 =?us-ascii?Q?maY3sFnsapc1Ymc5PpeuAzr8r7qqouXgJTXjCquANbbeZm4n+kj5c62cjVPb?=
 =?us-ascii?Q?y5nRjlee5PcUSQsdIpgCC5kgYS/M3lTG/HPT6OAwMoik/1uoBnc/1TgXnBvM?=
 =?us-ascii?Q?lJrn6AnvGPXrwRX9Za+d0+j4wtavSwEyFGp+CLbmEWM+hvRks5nezri958jG?=
 =?us-ascii?Q?mFdNZUroTr8mtMBBTIHtJwwlJhjL8aMBwAfyVU1CpdkRMbaLPzkvTkzDxZF9?=
 =?us-ascii?Q?vA4PQuGYogc9yqo9cLV7S3SUmzEAJWHWjyDQBRZzposB7wcCQqVrzKQSZzlM?=
 =?us-ascii?Q?C7RATIxRZzvDPp5LTBg4AtZ1LWtOsPUd8qC/pd+CpFHhnKfRnP/IBIImVFZw?=
 =?us-ascii?Q?kqTD+6iyCRmNoJmEIhBXGKpiM8OM/bDY3p2FLwQJWnHZzWhPgd2rdRkd42ab?=
 =?us-ascii?Q?uyND86vpOLQd5pSk4iOlnMKBDIOEclRaIwbEOPjIK6MIzhzFBLJQ16sLgloS?=
 =?us-ascii?Q?WzMcBLsKF2x5LR2NsSujbc1k285HFCPkX5hi3WedgfK+1+/NuL43Kk+9r12N?=
 =?us-ascii?Q?xCW2TpjZyiNmIrYuXCGu3qfEbg8aRXr0DHcPNC7NmzNJbfyOdPoRoAjOCwGd?=
 =?us-ascii?Q?GknTfhAB7RogkZrWfuLxr1lNk2LH32LKQjtHX4WNIDpQ2o2GIszTDV8o4Hoa?=
 =?us-ascii?Q?kwQEf01oqNmT2BwbXYrfDOm+m0wX5CtCDj9Sg+cmUY2gUEtQj4RMlwEUHKOQ?=
 =?us-ascii?Q?D4S9h4VF0pzsvypYCxUmbPHV8rDM4AuBowK873xVCxbhahnmPn7j3IkND/CF?=
 =?us-ascii?Q?VW32NdwTgoFo1K90FraJqsZa6dAFeJM+pmToLurC0aWJWb5uvZCb+5/QN6Eg?=
 =?us-ascii?Q?b9XKRmV1oTYU2HjTZdbMPtac+CI2vRAEE1DF2I0tG13wFN3fyjZgJs1BV+WY?=
 =?us-ascii?Q?rRvr/zuxcCjpCTHVnHJts6TiOilQG6w6vtHikAHD+ZX0aFkGEsdehdwcxMzp?=
 =?us-ascii?Q?K20ch1E+PjAabekFHe0aHMV8NY8mKJkSxggJz1Dg2HubYraBAcPXSolmys03?=
 =?us-ascii?Q?mc3RQOqfk9kuWE0SC9AZW2GmArodTBlXE9OFJRDPqRUxLTVlCFf0gNNFzM8z?=
 =?us-ascii?Q?tx6b0tKpbtKy/o+XVRYL15IhMZSKiDTa6u4RINYPYFm9cMYn/xzTzNa36Mi1?=
 =?us-ascii?Q?fHmggJ1KBNn5pe0kCjNArfKXHSCcSaq3LLVWkDysgSYX6+ldNLYtOicUbkJ/?=
 =?us-ascii?Q?hWdP+UZYiw1KjY/Qx3d0Su8aJOHU7cDSMrsO9eVv52BjpAJjsFUeyQpbnyLP?=
 =?us-ascii?Q?5NSg2zqb9kdxsBoSbLe485zqjfwr3i4CCbzaAPaE6jBE8+fxCrOyhF1EoA0V?=
 =?us-ascii?Q?rV6SbGk92w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f36ee-b027-4cf4-d468-08def47a283e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:51:03.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot2nMrUp5pUTPJivvU7iOAAhqd5MuAaRDmydevqmwkXgWj2UAk8LfmU1GhbYzUry837lMND/16sia+/R37xXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478

On Tue, Jul 28, 2026 at 07:41:32AM +0800, Davidlohr Bueso wrote:
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
> in cxl_rr_assign_decoder() and restored to the endpoint default on
> detach and on a failed attach.
> 
> The HDM Decoder Control BI bit is set at commit time only when the
> target_type is DEVMEM and the BI capability is advertised
> (cxlds->bi for endpoints, root F_BI for switches).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++--
>  drivers/cxl/acpi.c                      | 15 +++++++
>  drivers/cxl/core/hdm.c                  | 23 ++++++++++
>  drivers/cxl/core/port.c                 | 39 +++++++++++++++--
>  drivers/cxl/core/region.c               | 57 +++++++++++++++++++------
>  drivers/cxl/cxl.h                       |  5 +++
>  6 files changed, 136 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..370c6fd7d245 100644
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
> +Date:		July, 2026
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
> index 3b818adbd38b..eceb8dd97df2 100644
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
> @@ -437,7 +445,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> +	/* host-only wins if firmware sets both coherency restrictions */
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (cxld->flags & CXL_DECODER_F_TYPE2) {
> +		if (cxld->flags & CXL_DECODER_F_TYPE3)
> +			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
> +		else
> +			cxld->target_type = CXL_DECODER_DEVMEM;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9da8aa211609..f437fe15c6df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,25 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
> +

This doesn't make sense to me, HDM-D and HDM-DB are both DEVMEM but only HDM-DB
has BI. We should look for their root decoder's BI flag ?


> +	if (bi) {
> +		if (is_endpoint_decoder(&cxld->dev)) {
> +			struct cxl_endpoint_decoder *cxled =
> +				to_cxl_endpoint_decoder(&cxld->dev);
> +			struct cxl_dev_state *cxlds =
> +				cxled_to_memdev(cxled)->cxlds;
> +
> +			bi = cxlds->bi;

cxlds->bi only says that BI has been enabled for this EP and its path.
One EP can have multiple HDM decoders for different regions and not every
DEVMEM region uses BI.
For example, the EP could have one HDM-DB region under a BI root and another HDM-D region
under a non-BI root.

Maybe cxl_root_decoder_is_bi(cxld->region->cxlrd) ?

Best regards,
Richard Cheng.

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
> @@ -970,6 +986,13 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	return 0;
>  }
>  
> +/*
> + * HDMs that advertise support for both coherency modes
> + * (CXL_HDM_DECODER_COHERENCY_BOTH) default to host-only; the region
> + * attach path switches target_type to device-coherent if the region's
> + * root decoder has the CFMWS BI bit set. Only HDMs that strictly
> + * support device-coherent mode default to HDM-DB.
> + */
>  enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7817109026b1..2dbd8c24f968 100644
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
> @@ -233,6 +234,26 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(mode);
>  
> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	struct cxl_region *cxlr;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	/*
> +	 * An endpoint decoder is HDM-DB when the device advertises BI
> +	 * (cxlds->bi) and it is attached to a device-coherent (DEVMEM)
> +	 * region whose root decoder advertises the CFMWS BI restriction.
> +	 */
> +	cxlr = cxled->cxld.region;
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxlr &&
> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM &&
> +			  cxl_root_decoder_is_bi(cxlr->cxlrd));
> +}
> +static DEVICE_ATTR_RO(bi);
> +
>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -329,6 +350,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_cap_bi.attr,
>  	&dev_attr_target_list.attr,
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> @@ -339,16 +361,24 @@ static struct attribute *cxl_decoder_root_attrs[] = {
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
> @@ -402,6 +432,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_bi.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
>  	SET_CXL_REGION_ATTR(region)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..840acc330ede 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1130,16 +1130,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	}
>  
>  	/*
> -	 * Endpoints should already match the region type, but backstop that
> -	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> +	 * Endpoint decoders inherit their type from cxlr->type; broken
> +	 * pairings were already rejected by the coherency checks in
> +	 * cxl_region_attach(). Switch-decoders change mapping-type based
> +	 * on what is mapped when they are assigned to a region.
>  	 */
> -	dev_WARN_ONCE(&cxlr->dev,
> -		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> -		      "%s:%s mismatch decoder type %d -> %d\n",
> -		      dev_name(&cxled_to_memdev(cxled)->dev),
> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>  	cxld->target_type = cxlr->type;
>  	cxl_rr->decoder = cxld;
>  	return 0;
> @@ -1827,6 +1822,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
> +	/* undo cxl_rr_assign_decoder() type inheritance */
> +	cxled->cxld.target_type = cxled_default_type(cxled);
>  	return rc;
>  }
>  
> @@ -2059,6 +2056,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2108,10 +2106,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> @@ -2327,6 +2346,8 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  		.start = 0,
>  		.end = -1,
>  	};
> +	/* undo cxl_rr_assign_decoder() type inheritance */
> +	cxled->cxld.target_type = cxled_default_type(cxled);
>  
>  	get_device(&cxlr->dev);
>  	return cxlr;
> @@ -2823,6 +2844,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
>  
> @@ -2834,7 +2856,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
>  		return rc;
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
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c323c38d0da2..ec2203561446 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -300,6 +300,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {
> @@ -826,6 +827,10 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
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
