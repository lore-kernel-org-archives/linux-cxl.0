Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A93BB102
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627045; cv=fail; b=SNQALFGQrKtGkkOwNOR0SiVVrRH3miGE/MA1Gc5g2Q8PJi6XIwAxFIMl9he1e1IWZfzFAXoqWvmnDeCrNtkJPOEClv0w9QXidqTKRH0AmRlM+AeALpKLXHzRShkjWXfAHz/auPzeGBKB9KKXbxnlQv3hgnJi847MMRclYGo5XU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627045; c=relaxed/simple;
	bh=ULMNYxk73xflvSCn8PxuBrbw8iEnjb2u/j/R4zex96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shUrmrd/vHKksCzm+xVTXYIhy3csOp8P+hl/Ni9Gyu8XUb9JgukG35x8COcZXI47fA1ZrD3YFNyanL9SvGh09TOatHmMu/HoFKmv6oBhe8s2hqyToY4aNxKsMUF1hORRogeDeWuV6beaeBir+AJu8a4Uq8OwCQmTSaUhhzs6Om4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJcMWzvY; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJcMWzvY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4mxtuVbICxNvg6ve7GphXdBfvzYPC5N3vD9A86r33hYSUGpZvD8sGyxY3FSBc0hJTt9h3QBG7iHxtXFCzgzOoLH5l2BwG+YfjUcAZSC8Lr5/lApUJYI8GvUYqxPYi0EGJtHf4S8Jvjs8FLy95UozVahWIJDt7Adqwrrrz8CjkPXHV6kwON6mbVSUg7a8A9BMRpPtErWdqlxChR4R8gEL47ql5nnTzEh/uvHNpniKfvP1MK9ZHMKfZb7SDYeHCQgh6ZTF0N/YpFnqMGLWHpC4celC4tsMJUy0vXoLYIBBuZPlRS69QjpcNhUt7nvZO0nJyKuiZ2+bushL1yR/ovkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBkViqpC/1ZPv6/wKCJxXj8B/DX9Cbuxgt0diKplkdw=;
 b=X3FGHv6YIYkbOJjQf7E0Qb+dbiEXAV2A9PuNDfKVKXVGf4Ty9VkGb/XOmU2f5pDse1vKHfiHhPJE0DWkVHD+xADhP2MLEzWXIBuBxbrTPiCWtfV8HHa5IU5ezk/rytLdxiwZgipLpD1ZKGt4NNcv6dq+drCKtIZ7REFDRwEzLYoUVibsVdsKySOxTUTrBZ5EvaP/vNFq/BL98IoO7sCe7UXweiy/TzT83o5yJwQiJB/n8THQjXxEIoMQyvBDYUq3Zmrq6p7hfiqkjmQpVys8xcmqMPQWmhBYLbFwBol7HrgvD80sv2KK3+ec//u2+KvgsYvUnrcF7vM22oAYJhhEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBkViqpC/1ZPv6/wKCJxXj8B/DX9Cbuxgt0diKplkdw=;
 b=aJcMWzvYSkKXDuTzfHr6oze22+XF9+9cB+2IycOb+vV3kZ4N+/Xmf2khLAbeAOjbyLM7kJ5J5hxK5+9NEyVYL/mZ683+aikLMuYPFGKyHTAcH+SKVUkfAg5ze5fGXcOccJRN8MU1j7JoA3btDl3er9x8bs3VMFvglwFJORNooTvUlOZVgmRKXoQO4g1Yn2kgxxEbk44lz0XCRe/n0hWt0Q9NiomKownj2XipYRf8tTenViRiGBUmFEp2oQCe1YIZxs1Fyy2bU3BLnbEs9VC+4rVtTyy+OALRPTgD6OCOsaNkTvRcrdAjpHlxncrYrFfE/b+i2ijKfFSXRBIReFSDug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:37:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:37:13 +0000
Date: Fri, 5 Jun 2026 10:37:04 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl: Add HDM-DB region creation
Message-ID: <aiI1ZVwF-b-KA4Sf@MWDK4CY14F>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-5-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605003329.2584012-5-dave@stgolabs.net>
X-ClientProxiedBy: KL1PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caecb3a-b1ec-42a8-2102-08dec2ab5955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|56012099006|4143699003|3023799007|5023799004|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O+y0dhIOleZSZcHkN11lY9edN4eXn5GtRiNpG14f4z56y7DSj0OQ6vHFOvATXphkJ8fDC3kpenPGf926DEGQjMFPNukw9Xij3WkwKMmIZYVWnWavsi+x9XwaWoRQ5BoWFeU5ae8be4+vrGsF9iib55fv87+xHZaJNdAgKF7inBLg5RV5FYGv6ITAS9HPPLcylpBvGCRQulIpV/eAIPyynMJ0yHfuYpkxdLI/8fTuLAL37M7eNc1RD58IeRAYWXuKQjXQXlu/AyA0dAINkFPX6e3tR9DFY6L2iEWSGYheEC0hl17LE74gIKrbGEbFL97DSzkqXqogj5kh0ccNZNShUCzRtCi/9lb0y4mt2vmk3uyDpzPTH2CGY+Ih2EUYWbBXUEStWq2Lbvq/wZXakYDaQIPHCr+Tq8zWB1P7QYjf7jFQSl7bprZlqwqXatQC6KNyPgadkszSLHkrBtZOysvkzs7GOmndF71ZvfVvF/gAD7jQd4nKvo6mBIzZdX+ABOB2uE3rtYONZGZ7Sq3o4gxoTBRTmBBvt70kV2e+5HTcekzFBFlAas6p2l0rWF0on3S9qx+GRyWgtVorSuYq0qStaLEy3v//dLI51/NXsHkRyFmU9usK5kN3q3H+9dMf5VE8AEytmPBignA/3w3C8SQz9UZRfHR51Fv7r6zJVpYnxW6I73aVADhtoP7+SSQ3TmRL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099006)(4143699003)(3023799007)(5023799004)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFLU8DaBMmdV/fc92uuu/aVihDRY6lx5FPRwz05NUeTRY+HrObXkbWpa7FlC?=
 =?us-ascii?Q?bj+x4VMN06vAZ7+JymRBOF0k6fRQ4MAIlxrl87sbaglphRhZkjJuSi2IsYIe?=
 =?us-ascii?Q?UEjZRhpretRfJgig8w5UHpJ0koPYiRhW2OH/4nn6EZmTByA+kYfh3/HkhXTA?=
 =?us-ascii?Q?izzhaOp3aJTbx0boDFm5L7qg0lceo2iGCNsue4WbWbMaqkD6dleJx00GwNI5?=
 =?us-ascii?Q?+2MVfQ/DSpwZQiGL5aSEGE6KFQoT7dxfKoRwWX+2fo2VIEPEeMxvbFz+CxaB?=
 =?us-ascii?Q?HZ00bOPqn+bKHpjs0oaOtIjIk2WtLaTXKs4aBDjmUcGuG1HlNtFpvrj5wAAu?=
 =?us-ascii?Q?oyiXsxiqv3glN2xSenMVGkAwAwK+PjQ2NUpOT0kWJRNYFeUqThikZN3/+GWH?=
 =?us-ascii?Q?+8LZdy7QlfQGUdbKo2lsJLzllfT2BEgomK4i1dt0BIYhJ30xtSs0f/2emgRd?=
 =?us-ascii?Q?5693/TI86uilclnu2VZMq6xxQPobUo0vCpD2a/e99C4T7ia7FGLoG49rjUQo?=
 =?us-ascii?Q?7NQdChLxaGwZsZz2MffeGFmmtkF1U36QcvwPopmekQ6aem3iBF0+qkNpy+iP?=
 =?us-ascii?Q?uQZ0w8/x4qAd2UmaLbYi10pRbqb1M5HrkfCNH+fnZrPvmPcdVqSKBp2Cp7JJ?=
 =?us-ascii?Q?YkZMP18n+1xAsxeBlFcPKYEb9czA6xQcU1rPtxif5fvpTT3w2w5kM5sM4ZlT?=
 =?us-ascii?Q?bpDMe6NNz5MrrGoWel3TuTm1Ozvm6BoRP5zov8PISB/eEZ1nrLMmaqPU6J2c?=
 =?us-ascii?Q?gd9gjVA+7JQx0XGcc8auTwvYXqg2cOxkto93jvNGablDKkdjbCuROYK37tWy?=
 =?us-ascii?Q?e94rIhPOhW+jFreAE+e8sq24qBlq67MOzGVAbEpTcLIJj/7kBOB1umVUZAqN?=
 =?us-ascii?Q?+GQKp4+vvtH9/dXY+3IuNP9RE24Xd2x+3NlJCLGPH7P4FIF0nKhIUvzN7kNz?=
 =?us-ascii?Q?J537W52PpV41Exo8Ay+Z1syGQpLRznKJqZEg8I0bYxnXXnd2VER8s+w8LNLQ?=
 =?us-ascii?Q?ZASnY/nZAsQuvPxw5gbCtNU/eXIH/yr4zowXA8uDljxt8MwsMmr+5hNvAHOT?=
 =?us-ascii?Q?ud5Qr/tY19w1wPtv8Wq5JrjpSWGbUFJ+VeFnhu+Dz31rQ7hSsirFAmQOfwi1?=
 =?us-ascii?Q?NqXtytxhPnAShk3+NLlH+VmWJ/0ZZRschXC0qeNX5aTuFCyGJ8TiEVjNDwt8?=
 =?us-ascii?Q?aFVx1o7MV6/HiHv5YoRn5YOpwppH1INBG3tgSc+F/LKkdGMYufOGCJgANGe1?=
 =?us-ascii?Q?mvczAIA/6fFiLdnA3qaO0UiUZg76VycUXUNTw2Ah5xHfRoGkpJfNhyYJ2Jry?=
 =?us-ascii?Q?3PBiFB2JO08nQL9qgYsKOhLAkZ62Ogl0CWH5Mj2HCyoKJkeGYsGcGvSyv6yO?=
 =?us-ascii?Q?9rKoJgpErj+x+UFgbU5B5FmWMQkiNxCIEKYYOtU3hqLkT587M1oc7GOH3/7y?=
 =?us-ascii?Q?5q2RlVuBpyUSsla4KMR89aBLojOjxYxp8x5R9hTXheqyOmOKDqlTeBT2YICH?=
 =?us-ascii?Q?b1DShRAwSnI6duSIZattdP6FEBmerW2D52Cp29++0VurKVMvCDMebq0iNfBI?=
 =?us-ascii?Q?yVgeXgvoxZZrbt9efp92zpdtW+Oea1cKrxi2XYxsOtK1uuw0E8ydkVeRIAXK?=
 =?us-ascii?Q?034WLxbOXZu1EAIoNQliwF9BJIKeeMjeWXN+Snik/xvAngbJD2f/cP6TyMfa?=
 =?us-ascii?Q?aihe+LLx/VS1E/LHqagGYP5U3a6zCua14j2f4cgZ/bfNwV65H3R493iNamgr?=
 =?us-ascii?Q?+ZNJXPmqaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caecb3a-b1ec-42a8-2102-08dec2ab5955
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:37:12.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPqwCWj4CjR76g0s4esOebzlinWoocWUU+W7CAwvIWQrQtKnM6AmA5vu/Rd+GjCLqRhe3dl7ksneLnOOrYZWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

On Thu, Jun 04, 2026 at 05:33:28PM +0800, Davidlohr Bueso wrote:
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
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++--
>  drivers/cxl/acpi.c                      | 11 +++++-
>  drivers/cxl/core/hdm.c                  | 14 +++++++
>  drivers/cxl/core/port.c                 | 29 ++++++++++++--
>  drivers/cxl/core/region.c               | 51 +++++++++++++++++--------
>  drivers/cxl/cxl.h                       |  1 +
>  6 files changed, 100 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..f631a94f098d 100644
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
> +KernelVersion:	v7.2
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
> index 4a41cde9fdba..70c797c77b70 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,23 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +
> +		bi = bi && cxlds->bi;
> +	} else if (cxld->region) {
> +		struct cxl_root_decoder *cxlrd = cxld->region->cxlrd;
> +
> +		bi = bi && (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI);
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
> index c5aacd7054f1..2b463a8b06a7 100644
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
> @@ -233,6 +234,18 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
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
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
> +}
> +static DEVICE_ATTR_RO(bi);
> +
>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -329,6 +342,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_cap_bi.attr,
>  	&dev_attr_target_list.attr,
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> @@ -339,16 +353,22 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
> +			       CXL_DECODER_F_PMEM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
> +			       CXL_DECODER_F_RAM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
> @@ -402,6 +422,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_bi.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
>  	SET_CXL_REGION_ATTR(region)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..3f9ddacfae4e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1129,17 +1129,6 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * Endpoints should already match the region type, but backstop that
> -	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> -	 */
> -	dev_WARN_ONCE(&cxlr->dev,
> -		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> -		      "%s:%s mismatch decoder type %d -> %d\n",
> -		      dev_name(&cxled_to_memdev(cxled)->dev),
> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>  	cxld->target_type = cxlr->type;
>  	cxl_rr->decoder = cxld;
>  	return 0;
> @@ -2034,6 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2083,10 +2073,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> +	    cxlds->type == CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}

Hi Davidlohr,

This might not be a hole today, but CXL_DEVTYPE_DEVMEM type-2 device
will bypass this part and commit HDM-D in a BI-restricted window, Type-2
will never have cxlds->bi set.

Maybe something like "DEVMEM" regions on F_BI windows, require cxlds->bi
for all device types.

> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_dbg(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_dbg(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
>  	}
>  
> @@ -2772,6 +2783,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
>  
> @@ -2779,7 +2791,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
> +	/*
> +	 * The CFMWS dictates endpoint coherency: a BI-restricted window
> +	 * produces an HDM-DB region; otherwise HDM-H.
> +	 */
> +	target_type = (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI) ?
> +			CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
> +
> +	cxlr = __create_region(cxlrd, mode, id, target_type);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 917a6aee5936..73d4d2d4616d 100644
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
> -- 
> 2.39.5
> 
> 
