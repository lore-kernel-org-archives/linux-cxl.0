Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890204C14E9
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671995; cv=fail; b=O+NRmISkLstIe2xcFyajg4NIEOFy0XqD3L+W6Z0WMkJUelM8UDcctbycwXbEZngM4d6ueA8Z+591uHAy3Yn2GD8p6JpUDWThGkTHV+AaOzw1Tif5lXpqqYR0/wRvtw0YPBXHVIbU5hbvQRumcG+D5/vX1Br1C2FSxgQlXrdAa7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671995; c=relaxed/simple;
	bh=o1Z3KRahH3jqjHDTz7coM7ZiQU5l9atx95sT1wrLu0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSZTdk1kcwPN21/paeyVInVg0elP/BMh2t4OF7/pzqS+8Ni9/DYpmuDQ0jB7MLIF/zDp26/GWVlAGOAwOVyEi5xw1K0IztKy4SqpZGbthCbb1ic0ScQY4v9TJ1BxfnVhcifIGfhpR5dm7XIXfwo7EDNcSJWDTYj2ADNqfd4Eus4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fl0eHdrT; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fl0eHdrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVsISzzmqnqfcYwOaV943WomirZEkcZm0tlrnFwI0KV9vArjhx8Xktha26VQSdCYJ0UGvzVx0mFNqWCdUou2scq+KrMNCWGHoTPlQXzrz4PMsc4+gfwbdRJx3zgNRPoRwPw9cO5E+/C0Y/iSD6lHMB7RLIEtZiSDml6Nw84J2BcXW6qg0O4cwg3a8GIRdDgfh9tpgS8D4BWPt16PZg309Xrj17tXM7ROvRahiQP8Qo/bPwJR6MjQX8z9jrr+0HsQRIEVYfazHrrex/mds7f8iWAetd/6vns9VgvnRe/MZ95n/rwdM1ghFGcxAfy9TGORlxrZWGLnRDYsTJFnrHxi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLeWBFCufjLKDF5aF7eNzVD5oZQMd+TphZH0njsKZhc=;
 b=vEVpr1l9TgGSv0/hL/jEN0S//fqBhl1BlJmoC0y3k6B5E6QGL6a+SuCG91MGIIJcNrWmeWlWTtDJlK0YJkM0Vo3fI1oh3In1tcBxsorpOMry/0Z9zXrPTZdarcO8eSiKlf+fPK/jdQXZ1auKr4PyTqgOw69C51Tf4/pBpeVGABMHkOPzvIpofIuOSHDn3JOt5Wih5AVzKGi6ZwLwwBmbeFgm6ZDt6ysHmfomFSOoZRzfGPCGE0mKsW+sJiHQ0gYN2EUUYMiz7WmXzQGtm5vI1xsx1YAMpUA1aBKytsOu4JnVwcwKZ+uKwS59x+42Fidgk3yl+KYeVth3mtBwkaWkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLeWBFCufjLKDF5aF7eNzVD5oZQMd+TphZH0njsKZhc=;
 b=Fl0eHdrThVLYyNUOrRSrI9hEM9F0wxtCsC11i1BtkNEAdiPdYjHRJroqpJ8UsDm7yBwUoWjvYpqnUEG/eJkf7bQhOxidVZISDru/0KCehhmN6kdggmhPDI+OzujpbDNB2NR+Y4MwRtIUEo92+xSqfAgQSQEtBV2HxUV1ve6AhlzQrnKyPog9cG4udh0HjkXemY+v5x/JLa82m3pOHttOXiWWrLThr25yjjUyRD/z7mMhmdTNyl7029nkWyOncrdlHZxbhJOKNJvB3suJD67WmoDEROK5ph5xz15lsy7048yGRmcQyuO75jq2qDd/i8NQIIyFSjhlFSTtS2+QB+oRFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:53:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 08:53:04 +0000
Date: Tue, 29 Sep 2026 16:52:59 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <art5JoFbkTv7PT39@MWDK4CY14F>
References: <cover.1790103847.git.dave@stgolabs.net>
 <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: d381519b-7e18-4c81-3013-08df1e071319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|5023799004|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q2bMjb9MisKDnQjEk4FPup3xN+JgW9zkqISeYrDhTk2USJHS8VnKq71aYtDUIl89osD8yu85Sjg6EtJBnoZeEVURk3spgQ6vf5feoFIm2lJjOwtn7cNSUwR2igRRdhS3et3OpR72ncwwQG0NO91A6WbZkyRafMIxnjWfXigMk54O0N6kzOJB5sVwR7IdttJvoJDFxf+nf0YsPpTbud82cfp26UdcHqnO5DKzl8jOrjHyt/slRhAg30x5V3nIN1OBdFUX39jYhzJ5+ZRfq6jZxHYDrFH5NFH2h0fu+P9dCB63PEmUV4LqLC5oBhEPocei6/Y4j+UNeHwidtHpm6cXFS4UYY5Lbgs9DI43eEZKabsRADC49v5b+Xm9/tYZiJ41xI5NVf65y8XM1o1C9a2GS6pXfnFfKWYJQerGXFNnrC7oVeDefnbHPaVBzbyxZeWO6V1ReqZEH/GVo4wkU2eaS7wsLQgv3A0hE7Tmn8fROGhWghopBVRun+3R3Qd2QVrH3KoKgziIdSwuhREPybm3xUM0+CMAxxFgSlnYwABQkeSNYZLZH0TK14PMGDXuCfURAbDfheTiPJ6G5wieydEtwRb9hmGF9PMnDF0Ss+e1muT+AoIQ4lvUX8YqgkqcGf+f2quRHGfUEmzFFDNGZ8EMWM+l85tnpCw7BWJOJTyIS5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cX8t71rOmIwWI/iXNqbLm8i1KjJn6bfBoiOr9EHCbqk8X5ZJdqvMYC30tFnk?=
 =?us-ascii?Q?gGtXN7+dUVXQdhWmobLaPrvyRUWqKvrJhmsEus+DvP18JSih2IraVpZVvWP7?=
 =?us-ascii?Q?EucRBd34yzMRS8BW6IDrUmie8qtGIwTWu8zO8M0CrbxaqQUbmRluzByJjMEi?=
 =?us-ascii?Q?bhnIP9gGuL8iwxnZKSuHt6N9Hrp6Zj7t+YsUjUJDnVAR6MeSm8KeCdEFyNcn?=
 =?us-ascii?Q?tGGdLphm1qC9w2XUCD9IN01/HlPTN/ps2j9LNKLjJXRsFpz6zdRU54nnrPIX?=
 =?us-ascii?Q?01s4sP1SVlB6+epCVotnWocE2UVb65rUhbvvg2H1ZQIL+vG+w9ODTRIwJr7j?=
 =?us-ascii?Q?IwlM3Qx73AZtGZJEZEWnrp4K2InjcoE8yJ/Prej1NFJ4p5UbTT7cPMvKicLN?=
 =?us-ascii?Q?q2deLVSBYRgiVb2iCWRTd4H62Hq562ZB0+8i8ieGjuSgLuMcUhyCT1ikdVNv?=
 =?us-ascii?Q?e/AacUxy1oLyPheG115z/bosTJOn1yNyhr0/i/Dr0aGEHwBZcUUQE9ITynDq?=
 =?us-ascii?Q?UU3bW4tQ9al3+5Ts9hfyLfwwMKsi66QT7bhErw+hfJzvbF5xp272U7DJ0XTH?=
 =?us-ascii?Q?nN/cdlnakPhVSFqqRdnSZNca6s+3/5HFOCW+mb1AA9pH+3ebBHE0itLpmeDy?=
 =?us-ascii?Q?LhE8GH4F74u+LjXLsSaEJlOzmQOs2LJck5IyBEszFyMkKgM/Ei+xL18uRdn4?=
 =?us-ascii?Q?QjG/o74pk0fhAfxVDgJHtlPdYiVeKXZ/j3lVEFjINx7XDRRJ+7R5rhLLpgVA?=
 =?us-ascii?Q?mdx/XpEHT5ABOXG7ZwgPrL4NDMWICN+HB5jntQTRK32kJh7xJeIXnRII/Cyw?=
 =?us-ascii?Q?qUuFEGeFRJa8EWDC8xUMBdbajw1eLGd7ezfRmKihovJo5VCZNqVbALcvAhnY?=
 =?us-ascii?Q?Kook99bHdwG1O6bujDYXbwafevJAUXc4mQakc2pCowkFBoEXguUjB0PPPXkO?=
 =?us-ascii?Q?GBVVFMx5orhNXRxA+2U9MaVqtHl9IgtZmNQb7kzTx2avPA9H4vk9+B11BQg6?=
 =?us-ascii?Q?0GsN9fdvGTq7rhiat1kkvLaLlnARxmQ3kNkB1nJmq67SDSueo6vaH5Y4AkoJ?=
 =?us-ascii?Q?RgistqaceHPHHDrM6jFDViDZoFbXVAZw+E76NVUNYB1VMkZIPqCTDzme4iMM?=
 =?us-ascii?Q?q+dUhv8sJ+QCAcpkzcdkEMORxqCkUc4XEa9igGEK8abI9gdzLzQiPRnmaV39?=
 =?us-ascii?Q?uv2N7c1HuJmlNyux5MwEK2huFg7FzgyTqKNjDpDhppymmg/yTODv7hBSo/Ba?=
 =?us-ascii?Q?jAiwwQwm9xyr1Hp4OdFso8ynn9lDMkk+dLMn+gFjhhmhn/MdOMJoMrPHZMl/?=
 =?us-ascii?Q?xsWGjyFSh+V6sPXW2s8Gt7JFBtMGqn06u5c5P9twUZvh8U8kJrOCPI3kgWZO?=
 =?us-ascii?Q?K0cQJYgb0gJxmUHGbDIJXK3of7qQZ3yQBH8TImsydUiX4MTmZjadFSumLSSb?=
 =?us-ascii?Q?7ZaEXYCqgSQ/zLbjj/s0fNDKD2ppja4BE+QSNGF4MbxAoKwH+pEjLO9IKDGR?=
 =?us-ascii?Q?qTCoqIoRVZfINyM3OjyP3LiuHrsfhVEUapHxSI3+3uCJimNMXgo56wXjtkzX?=
 =?us-ascii?Q?W47zYXdaYrI1TpL2528i1IvttEpcrBvnH07tQp0RlOw+A10J+0nLLF1SRoJV?=
 =?us-ascii?Q?DFQlC49wmX4o0yYG5ypLHkVwPNcpmb34nKozzXdiiE6V5zhgObnpiyN9KWk7?=
 =?us-ascii?Q?AnimfhB/xHB80WPyT1EXTiXAZZEgGKtgVsZ4JT0PK/AIWvgYYoTKdDMt6qEH?=
 =?us-ascii?Q?VivD9VyCPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d381519b-7e18-4c81-3013-08df1e071319
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:53:04.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQyU1XNOg08XEz+gLfJa/rwDj1S+mDI87e/9ZyH3ykLArDkp+/0nkTjsm4IuTPZmDNwMnmRzzgO35wFeF8oVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Tue, Sep 22, 2026 at 04:38:39PM +0800, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Setup runs from devm_cxl_endpoint_decoders_setup(), between the
> port's HDM state and its decoders. Registered there, its devres
> teardown brings BI down after the decoders quiesce and before the
> HDM state is freed, and BI is settled before the decoders, and later
> the regions, are looked at. The BI-ID and path enablement belong to
> the endpoint port's lifetime.
> 
> Setup is safe in endpoint port probe context. The port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
> 
> Dealloc is safe in endpoint devres context. Both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
> 
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
> 
> Likewise, the device state outlives the walk - cxlmd->cxlds is
> nulled only after cxl_memdev_unregister() has torn the endpoint
> down, and delete_endpoint() clears cxlmd->endpoint only after the
> endpoint devres has run.
> 
> Each dport is programmed by its position - the one immediately above
> the device takes BI Enable, every dport above it takes BI Forward
> (Table 8-157, Table 9-13), at any switch depth (Table 7-97). Any
> level can be shared, so nr_bi refcounts endpoints at every dport.
> Registers are written on the first endpoint and cleared on the last,
> but only downstream ports commit (Table 8-156), once per endpoint
> (Table 8-152), and a failed commit undoes its write and commits the
> undo. A USP advertising a BI Route Table that failed to map is
> refused rather than treated as absent. nr_bi counts only the
> endpoints this driver enabled, so a level can be cleared while
> firmware still has an unbound device on it.
> 
> A reset may wipe the device's BI Enable, whose reset default is 0
> (Table 8-157). .reset_done reads the hardware rather than assume
> which reset ran, and invalidates cxlds->bi, failing closed with
> recovery by rebind as for decoder loss; dealloc unwinds the dport
> refcounts regardless. It also clears cxlds->bi unconditionally - the
> endpoint disable fails when the hardware already shows BI Enable
> clear, from a reset .reset_done never saw, and the flag must not
> outlive the BI Decoder mapping it describes, which the endpoint port
> releases moments later.
> 
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing the dports that share state (nr_bi and
> the control register at any shared level, the switch USP's BI RT).
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/core.h |   7 +
>  drivers/cxl/core/hdm.c  |  10 +
>  drivers/cxl/core/pci.c  | 427 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |  31 +++
>  drivers/cxl/pci.c       |   8 +-
>  include/cxl/cxl.h       |   2 +
>  7 files changed, 484 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 384bad8cb70f..ef41632d7b7d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -210,6 +210,13 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
>  
> +static inline bool cxl_bi_decoder_enabled(struct cxl_port *port)
> +{
> +	return FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
> +			 readl(port->regs.bi_decoder +
> +			       CXL_BI_DECODER_CTRL_OFFSET));
> +}
> +
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0e9d652b568e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1274,6 +1274,16 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Between the port's HDM state and its decoders: devres,
> +	 * unwinding in reverse, brings BI down only after the decoders
> +	 * quiesce, while its slow walk still precedes the HDM state
> +	 * free.
> +	 */
> +	rc = cxl_bi_setup(port);
> +	if (rc)
> +		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
> +
>  	return devm_cxl_enumerate_decoders(cxlhdm, &info);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_endpoint_decoders_setup, "CXL");
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b8676a3d6ec9..f3ca9861a7ba 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,12 +2,14 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <cxl/pci.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -965,3 +967,428 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
>  		break;
>  	}
>  }
> +
> +/*
> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
> + */
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (20 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     unsigned int scale,
> +					     unsigned int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
> +		dev_dbg(dev, "Invalid BI commit timeout: scale=%u base=%u\n",
> +			scale, base);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
> +				u32 committed_bit, u32 err_bit,
> +				unsigned int scale, unsigned int base)
> +{
> +	unsigned long tmo_us, poll_us;
> +	ktime_t start;
> +	u32 status;
> +	int rc;
> +
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> +		       __cxl_bi_get_timeout_us(dev, scale, base));
> +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> +	start = ktime_get();
> +
> +	rc = readx_poll_timeout(readl, status_reg, status,
> +				status & (committed_bit | err_bit),
> +				poll_us, tmo_us);
> +	if (rc) {
> +		dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
> +		return rc; /* -ETIMEDOUT */
> +	}
> +
> +	if (status & err_bit) {
> +		dev_err(dev, "BI-ID commit rejected by hardware\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
> +		ktime_to_us(ktime_sub(ktime_get(), start)));
> +	return 0;
> +}
> +
> +/* BI RT only exists on switch upstream ports. */
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +static int cxl_bi_commit_dport(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	lockdep_assert_held(&port->bi_lock);
> +
> +	/* root ports never require the explicit commit */
> +	if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
> +	    PCI_EXP_TYPE_DOWNSTREAM)
> +		return 0;
> +
> +	rc = __cxl_bi_commit_decoder(dport->dport_dev, dport->regs.bi_decoder);
> +	if (rc)
> +		return rc;
> +
> +	if (port->regs.bi_rt)
> +		rc = __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +
> +	return rc;
> +}
> +
> +/*
> + * Enable BI-ID changes in the given level of the topology.
> + * @direct says the device is connected directly to this dport, which
> + * takes BI Enable; every dport above it takes BI Forward.
> + */
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
> +{
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value, set, clr;
> +	void __iomem *bi;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
> +
> +	bi = dport->regs.bi_decoder;
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	set = direct ? CXL_BI_DECODER_CTRL_BI_ENABLE :
> +		       CXL_BI_DECODER_CTRL_BI_FW;
> +	clr = direct ? CXL_BI_DECODER_CTRL_BI_FW :
> +		       CXL_BI_DECODER_CTRL_BI_ENABLE;
> +
> +	value = (ctrl | set) & ~clr;
> +	if (value != ctrl)
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	/* owed per new device below, not per register change */
> +	rc = cxl_bi_commit_dport(dport);
> +	if (rc) {
> +		if (value != ctrl) {
> +			/* the undo is a BI-ID change owing its own commit */
> +			writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +			cxl_bi_commit_dport(dport);
> +		}
> +		return rc;
> +	}
> +	dport->nr_bi++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Dealloc BI-ID changes in the given level of the topology. Called
> + * once per endpoint that enabled this level: on teardown, or to
> + * unwind a path that failed partway up.
> + */
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port;
> +	void __iomem *bi;
> +	u32 ctrl;
> +
> +	guard(mutex)(&port->bi_lock);
> +
> +	bi = dport->regs.bi_decoder;
> +	if (!bi)
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(dport->nr_bi == 0))
> +		return -EINVAL;
> +
> +	/* others below still need this level */
> +	if (--dport->nr_bi > 0)
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +			CXL_BI_DECODER_CTRL_BI_ENABLE),
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	return cxl_bi_commit_dport(dport);
> +}
> +
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already enabled in hardware\n");
> +			return -EBUSY;
> +		}
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
> +		}
> +	}
> +
> +	FIELD_MODIFY(CXL_BI_DECODER_CTRL_BI_ENABLE, &ctrl, enable);
> +	writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n", str_enabled_disabled(enable));
> +
> +	return 0;
> +}
> +
> +static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, true);
> +}
> +
> +static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, false);
> +}
> +
> +/*
> + * devm teardown on endpoint port destruction. Registered before the
> + * decoders, so devres runs it after them: regions are detached and
> + * decoders unregistered by the time BI comes down.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_port *endpoint = data;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	cxl_bi_ctrl_endpoint_disable(cxlds);
> +	cxlds->bi = false;
> +


Is it safe to disable BI unconditionally ?

For a FW-configured HDM-DB region with locked decoders, resetting decoders can
leave the HW mapping active. If that memory is boot System RAM, it can remain
in use after driver unbind, while the cleanup here disable BI.

I think one of the scenario is when decoders are boot-programmed and locked.
FW could configure such a range with BI enabled and expose it

Should we preserve BI when those locked mapping remain active ?

Best regards,
Richard Cheng.


> +	/*
> +	 * Walk the same parent_dport chain that enabled the path. A bus
> +	 * lookup cannot stand in for it: an ancestor-driven teardown
> +	 * delists the parent port before this devres action runs.
> +	 */
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port_iter->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +}
> +
> +/*
> + * Enable BI on every dport in the path, then on the device itself.
> + * On failure, unwind only the dports that enabled.
> + */
> +static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
> +			      struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return 0;
> +
> +err_rollback:
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter) && dport_iter != failed) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}
> +
> +/*
> + * An SBR wipes the device's BI Enable; an FLR leaves it alone.
> + * The check is against the hardware, not decoder state: BI is
> + * enabled at probe, so it can be wiped with no decoder ever
> + * committed. A wipe invalidates the software state; BI is never
> + * re-enabled here.
> + */
> +void cxl_bi_reset_detected(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	if (cxl_bi_decoder_enabled(endpoint))
> +		return;
> +
> +	dev_warn(cxlds->dev, "BI disabled by reset\n");
> +	cxlds->bi = false;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	/* BI is VH-only */
> +	if (cxlds->rcd)
> +		return 0;
> +
> +	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
> +			       endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	port_iter = dport->port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder)) {
> +			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> +			return 0;
> +		}
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM) {
> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +					       NULL)) {
> +				dev_dbg(cxlds->dev,
> +					"BI not supported by USP\n");
> +				return 0;
> +			}
> +			if (port_iter->reg_map.component_map.bi_rt.valid &&
> +			    !port_iter->regs.bi_rt) {
> +				dev_dbg(cxlds->dev,
> +					"BI RT advertised but unmapped\n");
> +				return 0;
> +			}
> +		}
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
> +					endpoint);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 131ed62e8db3..b81fd680d18a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -742,6 +742,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
>  	xa_init(&port->regions);
> +	mutex_init(&port->bi_lock);
>  	port->component_reg_phys = CXL_RESOURCE_NONE;
>  
>  	device_initialize(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 65be3b91259a..ad7c991f0f9b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -180,6 +180,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_TRACE_SIZE SZ_512
>  #define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
>  
> +/* CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure */
> +#define CXL_BI_RT_CAPS_OFFSET 0x0
> +#define   CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ BIT(0)
> +#define CXL_BI_RT_CTRL_OFFSET 0x4
> +#define   CXL_BI_RT_CTRL_BI_COMMIT BIT(0)
> +#define CXL_BI_RT_STATUS_OFFSET 0x8
> +#define   CXL_BI_RT_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
> +/* CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure */
> +#define CXL_BI_DECODER_CAPS_OFFSET 0x0
> +#define   CXL_BI_DECODER_CAPS_HDMD_CAP BIT(0)
> +#define   CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ BIT(1)
> +#define CXL_BI_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_BI_DECODER_CTRL_BI_FW BIT(0)
> +#define   CXL_BI_DECODER_CTRL_BI_ENABLE BIT(1)
> +#define   CXL_BI_DECODER_CTRL_BI_COMMIT BIT(2)
> +#define CXL_BI_DECODER_STATUS_OFFSET 0x8
> +#define   CXL_BI_DECODER_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -565,6 +590,7 @@ struct cxl_dax_region {
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
>   * @regs: mapped component registers
> + * @bi_lock: serializes BI Decoder/RT state of this port's dports
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -587,6 +613,7 @@ struct cxl_port {
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
>  	struct cxl_component_regs regs;
> +	struct mutex bi_lock; /* dport BI state shared below this port */
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -650,6 +677,7 @@ struct cxl_rcrb_info {
>   * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -662,6 +690,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int nr_bi;
>  };
>  
>  /**
> @@ -920,6 +949,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_port *endpoint);
> +void cxl_bi_reset_detected(struct cxl_port *endpoint);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..cdab4804dba7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -987,8 +987,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	if (!cxlmd->dev.driver)
>  		return;
>  
> -	if (cxlmd->endpoint &&
> -	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +	if (!cxlmd->endpoint)
> +		return;
> +
> +	cxl_bi_reset_detected(cxlmd->endpoint);
> +
> +	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
>  		device_for_each_child(&cxlmd->endpoint->dev, NULL,
>  				      cxl_endpoint_decoder_clear_reset_flags);
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 278b84b08c83..718eb4353887 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -168,6 +168,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -187,6 +188,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -- 
> 2.39.5
> 
