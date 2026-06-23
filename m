Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50094340A52
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204467; cv=fail; b=E3/rV1XNnXt44csEXYaLfD4Ew7lvhQ9UcfObxQhpKHVwljzUU7MHLm9CO912MWV5jiux0Nn580ceovPbN7/0+JIQjfiO1zgqrIUlChKqmQdvRQtATKUoVTk9di12WgZHGYMHg6tQd1oXYl7CGKe3LLtlc8O3xKSX2+PY2bJaGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204467; c=relaxed/simple;
	bh=wK2cn4ApCYhV71hxkPeou6sMwaav6tE/dSAOwdqvTC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h0OAzQwruGszljWYM89DLMaScxDYojy+QYiDhCuOqAU43fti0dpNrrtAfyd6a1ObGxsFe218/6Fg84TASx4AD/1hxX7EBgOuIKUrz7l77LaSe3mkD8c2uDosgG7ESkPKOQHtaB+2+qykD3adeoAkTTXi8UrrwrkIZOzLSVsRUe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXDgynPG; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXDgynPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1GjIFVNHV1wkx9SF0JDaHoE9R6XPKiynHTHYAed2CxEGIs38GCA/UCZjM7UbM0iLFmyQfNts/mrHYBTU5rCsh9/8pH43ST4j5vcw5Y9a7PsorWDN1syZkN3IVMlhTkg6MtdeHKnLmDuOw93LjjwpM+hJD+ehSNCQ1PkHlxXt8RCXZWH3k569pcvruP2+JFawQZ2oRaQDOC31b3on2hO9JDricmiRV2uBbKVqYGnyxQW1nIRpwOLBr+FjnGkYX4TNpQ7rurdLJm7C69yqsn2jzWbf2hcjevaTpctlJyfeDBxBmK/0JWIrAv3yWRnd0GyWIUC7JydS90wVe2Dc7fHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDLDokAJIn5BeeL8M4UbSNaI8oXIUN082BHZmUIlcGg=;
 b=qJrhUCJh3s6CPfiLJchIPHipQ9AnrBHGtaNCZhkPxvmWCpVKBtDtdD5xYJkLGnz0BMyPR0nriJwUdvuBGTc6S43S+Y7wEm2MxXN9nfQsTOTQIDwz8xJFgr60ZP8H7XohCPW7SXtQUrOq5e3Ilix7gnb62LxIi4TkhdKf5g+pY+Rbjlr3zixX4Q4f7hdmf1tx+B+h/2pcknvLfyCNnXxRSoKCZRoJi9i4hcQ35RYAEvW55yX8w5CPQoVxrDUmm4+gqWqjDADF9vGo/3Wa4kpG+Lyesx8vcBpUG1Lho5QjM2M7pU/Sife3/DXQFMAkffjGPB+PQB6JteMGCFBjNQ8P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDLDokAJIn5BeeL8M4UbSNaI8oXIUN082BHZmUIlcGg=;
 b=aXDgynPGwCdNiCbUy+79v0gbzDgU4sc2RBNcIWFyof7Pya38cWR3BE9BD0GWnK7bmNAYGZmmqSZyMwRipyReZTCvPgUdXGvxNQLeCexz27U0KddeTa4bJVfp6muKC4i9OFt6IKL41ghU7sWsQkhemWD+pDYXZkj8Ut0nqZ/89Xdnl7rfl+YKTvVBEZdSgYwwBEgeQYSD0VTvixFPKMMR7GEGPl0ax3LfCNXiAFbHUDh0yYZWPjMLEVEIGSP1sweGO1xytqjDM4I8takH0Gv/MoxRjnT1qfO+eTQ7zMQwbfixttyk00HL3ayq2HJl+2As1Zd2t63tv1SYMCXOhklf9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:47:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 08:47:39 +0000
Date: Tue, 23 Jun 2026 16:47:34 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Message-ID: <ajpHWPTGviu63cx9@MWDK4CY14F>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-5-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615145529.13848-5-dave@stgolabs.net>
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db22bc3-c068-4718-6887-08ded104149a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|3023799007|56012099006|4143699003|5023799004|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	AUd9PItE+HskZ06fbLDhJtT/U9IQf4NansMN7WCS0a5Pmh+qNxH1H0lJ97oqXy9ki8IJCSzmHcNr40VyNc1yLlGoW50F/dnsr+LdldUaM36nap9KKhAEF//5sNYsEmxlBIXmpfvi9shyXH2LeFk3n/pIvcGw+Q6Kq+5LxcG3ycO6pE9DzNeWuZVAoBBLcnWcrJKjr6DRfz5w8iyHwfxLUqePQ8H/trmhLK2qN48Gs4ZPRybMombieMDrQbaw/Gp988m5eQaGjv0OSRST6f91IFBugfWyeh5tPg4B7z7gLwcwg2JGKgLgyDn1sxaeElc1qV4AWfrBWpg4vE1UQntuPRgwHFGaR0+n7i9e3aLxy2Qew2lQbZNlvT1Yyo8gcYlwNA1B3nFxnP9bLd2c8Ypgu+o9rHsd0QTlM72FpV6uX5p5bP7d0auI8ShbyvSHOsB9BpZ8BFrYBF6aclCQNec9zGLKbY+DHZDUkAQRMvHsfRwpeGzncUOyOu/FJPlgidIpWtQ/g+aSCIeW55AXBU8XKGn2qMUkzQhaXEQWZCuCFYBb5FmL9FxHl2AHyibPcPOuwn+Oabe/JNXMclRE7KROIavb6u6/mMmMn/9hVliiFeTVbI5KdAECqIgUs812SpcGQEZ2Nr6NR2msTZAXL3Z2QndjKAr4oKjYaP1ebHGVBk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(5023799004)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Kt3y9rCVIoujaoVVF/8wO6EmFKPakXqzSihUSCrTk2G3KXuxJkoDJCDaZDY?=
 =?us-ascii?Q?yJyOMdzbRU0nwauKFFowdVEisq57SrFeugDoZrazxiqTW2/0k+0ve763A/3o?=
 =?us-ascii?Q?lnCcpEbUi/S5hbUJbJGRqre4DrEcsAe7hnfQmOR/m8A62IwJiToGDDoCciok?=
 =?us-ascii?Q?Qu/P2v4tVxPCw5clEF35HRwovij0tQplXg0yUNM5okKbvQKVHTI4w5XKFguj?=
 =?us-ascii?Q?fovdomAJ98b14tSOihGyoYdOQp8YQETgeH2gAEEGVprvQ+rzdO4aZyhxfSQM?=
 =?us-ascii?Q?4v5iDj50bv6J7klhkHKYnX03n/76zmH9xqRQY/Qetp/L1U/NuSrzaTEHtEzs?=
 =?us-ascii?Q?nRdWx5+G1btduoLEWskokm7ziGj7EngNkE7vlah1a2E8HO7z0PKwuqjeVCJg?=
 =?us-ascii?Q?Xc8jJhuMrWb0ANw7adjUddyYWYdDIxbagTnTitF9XKvms85J4AEeWx5+zStp?=
 =?us-ascii?Q?Ofo9pEMiwFH+OKiZru+aQe/LEguTtyiKqeyttpLF3hkDcHRvzoYWYYJl2SkY?=
 =?us-ascii?Q?BWSZMB8brl/Rk4e0y+eByp8inYr2Jylq0q1pvC13Vuw1YqkR2Z3bkfLA8wzy?=
 =?us-ascii?Q?f2DZu1EfOSPDVWM3S8gjJX1JLVXf6VSRGWihNcIozpnUIB1ZVjbEJZ92cdCm?=
 =?us-ascii?Q?krjjI33hpLqSsDITTgiuWkbDfwOVvVFyBBtE3ijKBqGB42CRP/LEyvjq6y24?=
 =?us-ascii?Q?KGIO1m8t9snuWrfwa6ILyONRIFCR6RYBf04W/Jl8yyY0aIzanVR+cGEbTulj?=
 =?us-ascii?Q?WHKiUfcrrhJxry3S7Xz5JhlN3gbAzfUZ5L8PBmTdPVgjBjhbh9nvIj2IGarK?=
 =?us-ascii?Q?08SsUGIyU3WPxilVxEc+fCtdrh5WSqiK0ATh4uEHGyRpRkoqps4d9iZ3njw/?=
 =?us-ascii?Q?0UBGc4HfABZZrcv5eoufpNGCl3KL8j7FaaY0TTBxTqKsGKhZwT0dK784f7im?=
 =?us-ascii?Q?dj/JGwWCUVJiR/8l58zMf1sSQxqWE+WWu+A0gldgjt5ewVkhis1at/JEJmCj?=
 =?us-ascii?Q?OixqYVHXpz58WcRaTHGZ29MSwyu1v4lzExi3yiTNkKjKl8XCi6UKj5x8tNkm?=
 =?us-ascii?Q?Cnw7GfM5xuqCmkBP9yvsNY07nM/V6Z8DKrW5kJcZTvkmKhP9rfkwosxVmJGd?=
 =?us-ascii?Q?rdJOPOcpULOxWKVi2of3zae6Wtey1LEmtZOiKHaWXEUjRG8cN6v6HXhV/uPu?=
 =?us-ascii?Q?rpCnzExOPBcfnUSx3knzwrlPqGCEKrBxOjS0IdJUECS2oKYWXNIlj1uAEzSe?=
 =?us-ascii?Q?f5HbruqxzlW9tOG8fX7jtZTIyJku8u3Hz1A0ZLwmv6vtfnSevZS0+/OXJZyc?=
 =?us-ascii?Q?TRWrPpTKbrm8uJnlf5r6XPqJ9faFVBKtHWjfu5raeIP/HtTvMDdektuZ3kI8?=
 =?us-ascii?Q?6Cjnn/2iZSVHQTbqFW0nWtwH363eU8mWm0n+ga3FlTgSktZxPCQUI5LmNTfU?=
 =?us-ascii?Q?kwHuQ/knu2wpgHxkNzch/kwzH9DNA8SSL6E9MMAbc76BRAXZH7OUAHTtYAtg?=
 =?us-ascii?Q?OygLm3UxeXIkg6tbfHMvUYDsOawPgrUD0R+vM6kfbdqgmO78/UoB73mJGnPr?=
 =?us-ascii?Q?f1SkryoArz1RTylp0cAv9oyLrZpHBgL7uLfQhZL957fArprHu+sbiAVdS2HK?=
 =?us-ascii?Q?OY/Ug2PL94Ue2JW+Kx/hDTi2yD7CVtGgvA/JsPQxzR5EtpRgxYupOu6wnhAC?=
 =?us-ascii?Q?N/h4I8/ZrXhTX2zz2V5WEJmq9r7ljWQvWPmUbIIvU74MV3j+Nte6Wyc5iPVc?=
 =?us-ascii?Q?w1J87+PmOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db22bc3-c068-4718-6887-08ded104149a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:47:39.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MXtldo4klp7+27VxsIuK0904jjj/l26DA5Sa+Jl57ApblgJExrS9XPQyZvckGpyMLtb8K3dDa2DVfm4Znv9xg==
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

Plus for this part, it rejects host-only + BI, but device-coherent + host-only isn't caught.
For that combo __cxl_parse_cfmws() now picks DEVMEM, whereas before this series it always defaulted
to HOSTONLYMEM, so it silently changes from host-only to device-coherent.

Is it meant to be legal ? why DEVMEM wins the precedence in __cxl_parse_cfmws() ?
Those 2 coherency models are mutually exclusive, I thought both should be rejected, symmetric with the BI check.

Best regards,
Richard Cheng.


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
