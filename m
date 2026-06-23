Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1534252C
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203096; cv=fail; b=IjRAR/Qic+3tv9Xs9QB8e6NbdyOuOuZAzTpWPOagtaLcF1oWXKIkl6MeUhXzC00/tEFP5734CyWx8CxGIAasjeFOo9CHKUje+Lnmbqnb2hY93bMw4Yjmmc2FKhNYVfaXUkD1pzs5MLga+g0+Um2WzJ8LLk1eZJwExqwGRK/THf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203096; c=relaxed/simple;
	bh=6TLCchhebn4b62AlTPKR1CgOq0YzsskfNxBOkVNOzH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DI2e+eBuhluN+5wp6hnaz7Cjv3P3aosACRe9eB4jb/xl4NTfxOO/hQXenqkcK01rtjmGEITctoQoo7HHG43wsXmRagq1iC8cHonUKf5jmxYc6sdXtzp4Y9SybB3kpE8crBn6yYsceTpZVOatLHHNBJ3XTZGGPJO3BLe2FFPsf/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bVLZ06A8; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVLZ06A8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPiWYBB6U4HnyKdGLY/a/nPuAkQCo0JUG90ymBFm9p5kLNB3xVj1zLZZgAKFB8Dz0mvC0ynWiHht2I+Ry4njKKsuuF1vpPG0YMx12ienFxMiL7W8V+c2f0AnpslOHTpHCwivOoyiwqxVuDBCj7XXiBCLX71v3w9wLczVhrDAy/KUYdwPxADPSvrFvkxtfnuhimtXSORASSUJRiCRRTMhgDel+smjZn94oVbeL5Y+8+hp6+r5XULAhvr7Ml2NQjlLzamJDO7OIHr0RC5SIv6VUf3q8yRRUfjdedEo5K7GdF9KoMsnTMLjDsabDHp4DepHtbm/bZk56RdOxnHFZFdpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqjxXYiIFPASc17YRqQ96rF/ScSe47Wa8tjEwD4qlqQ=;
 b=Rg0MCFwQe2QQHs2qf8p3hlKVReZzdMZYVVhQC/sqbiV81WWOQYGzNxpH7EOs/t1FR2nHoiK72avoaVW1B6u4Rnu4P7Z5FGuCQhk8fyi3ccbDDAwHUFEPssNljZibXt/3Sq4FBFTYvighGT4pfunzaivmJA4FStaoxy5QdLByBNwX27GZwT6mB0ETdiNdKuN4/wSBndULdKu0w+Hn8xMDQg4VZhdgeCx8NPm95//+CeEGCZuMb85fiCQmMM97Tx2jmTS1atLXw+nelyUr7hJV0qUzE8X91yaMyICnQ5YW7gze8j+Mlb8l7+TKmJS471/KW5kZ8Ny9fHlpg2pg0xwPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqjxXYiIFPASc17YRqQ96rF/ScSe47Wa8tjEwD4qlqQ=;
 b=bVLZ06A8JSuO2Ms+v2wvp4NlVgw2HEZ0+G3MdLmaO5gDhkxOijzTtOkQm315Ft4gaRQu1wzosH3k+kA3KAohm/N6UquqZgD8Kqi7gY2YvMKH/QWzkIYOdElzcU1JUjiHQoRum39mpJ9BL3QNPlFV5v/pecpr64BXTMYKkD2B1kyppIcOfO259FFLKBgq+tIx3urjg8+nO7UrEHLnwlR6D4CmkhxB6tn5c47N64c38pdE5c8TGAXAsZJpTh/QfZthslaPxYi98abbpx7hR4vz1Xob8bmKd4A0IuBPhdBGAL94nQhqOj3RoZkXGqcPlUc4bTXnZKH5MK4BH9a3n1QEog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 08:24:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 08:24:49 +0000
Date: Tue, 23 Jun 2026 16:24:43 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <ajpBq7pFdSEzyol1@MWDK4CY14F>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-3-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615145529.13848-3-dave@stgolabs.net>
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ca2be0-d530-4e5f-d63d-08ded100e434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xbVuwWDvEeU4Sij+sQsnLTkXdPsjMOJck9tyB9WP1fPsYjV80rhPIA5iC+6qgpXlr5rNrQ9pTyEwJZh/9T5McGewWNBcemEhPhSaDNpCSyyHm5u61czwBD1aGt36t0uXPgGqtTN/m9p8MV9KoPjTqXKWqp6hlq+xScqGN1P9vmO7nLjQ7P5XPHguil/2UIrbA14G4FP1ASacHZNinRsqzhnZXCBZ6oVNCCWVH9AoHzELc5M8Y8eSNHsHJvbcdaq6s7fQAbt17Dr7MDjaMkLU7jUXjSHm1lPpPs+weXoS7Gg8AmDcplOXDgT/QyuJZ5RJVnnVKTXjNI3hfbrvib1ZKm44Y4Saa+L5P4YjlgRBcpBgz5z6v6qBeYYcLms85DA5oLB2C3GwqoQceD6VKXEe3hdf8ahoCIvxlnMfyfLBBiWLmOztXa0zR0iMlqqWCpaB+fvIz0vqJu3uuvEDWROFUP158w/TNLbHh8KGdP0DdcA+Kz/c4hG+wWIDBTNTEl6fv0pwKpIRoX8tVEjVvxAay9TPnGyHtGYoLMSrsCePlMMFfQ5NrAPCi1lpFplDHQDoCGLeSPqOvE2NRQsT1HDvxyaBYiwgnLfG56HwUWqcZqi9/j/gZQfmW3/gTeey/M+b5Jy0u+xrI2AvgUNg39jPTWolH4KcvXbm6NuQLY8+qgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qb1KJdgP613aZcmRLXMzagWy73ILsDA59/6JlyonZtx5TRRAP8Q56zGALxhb?=
 =?us-ascii?Q?GFEOvQ+RLNzPzfm6mKZ+lUH5oC+lM29EVMyDBdIcK0aqHsCay5hZvj5gn2dt?=
 =?us-ascii?Q?0huD6u55H/jESGQ2SdDH2eU1sgrdE+PPLZUTmtPCy3zVJ+HL0CQkT50x+Cl0?=
 =?us-ascii?Q?gyqYffZ2sJDA7YmmFDd9c15a5HVUjvON8ADe99N27EAyLxPN3pI0cHwBYdKO?=
 =?us-ascii?Q?Iy2AwQ6XXAs97Oz0SBmJJRg9GHld3KnZ6Q/mXwTezkDEUaUqE0JwmLfoMdsJ?=
 =?us-ascii?Q?PqcB2Ek63s6xy/y2TIn5AIyf/MdYST42XbrKEdGkByYD3w+ZTis841/liLci?=
 =?us-ascii?Q?Wv5Jxvfv0cSVthiUpCfWcOEj0wgkYmuLpMrkFtHPZmEC3UiT+Az+jvZg2keM?=
 =?us-ascii?Q?XwFrnFjtltz9uM6tiqcSFJrKxW5CbT/5D1oxI6jsfPzBZ0QxQre3xmp3Us2o?=
 =?us-ascii?Q?ZM8gZ3QUam38TcgKvT7Z/x3Jt4/iMt5kgyjj6bi+MKQgIA+XyMMBsf6tnkPV?=
 =?us-ascii?Q?30Bt/pq+JXhTUAcD5c+qbdwGdp2UVnfqQFCX8Ozi2ov/43sbH3HMU9OejpoI?=
 =?us-ascii?Q?nZ3/5FoL1acH71hUNMnKFda5KKMi46fjr4oF+rlo0H25iPvj9wW7ZdldmExT?=
 =?us-ascii?Q?1pOVmCGBj+rCu0lXXenGZIJ30lWY9GzXsvn5I/aj/7nKaeWkaweYel9H8Vda?=
 =?us-ascii?Q?ZfaKh2NhCY8ky096SqogiTXqyxbmMskWepTuvugQTVERWeKevCAw/ctwz+E/?=
 =?us-ascii?Q?YwRwkYxZtBpiQ/y/zyXPJ5yiXGWv5QLKwFf0ep5wz42S49g/aLhFzyFKoGuF?=
 =?us-ascii?Q?w5bGBDor/DoKzRFAqg2LjULwDUDPbZhkpOxXSLE8ZJCn8avHwLEE7I1F1wGh?=
 =?us-ascii?Q?LuGuQ7iEpsGNzkVPCOfQ4Xf9aBvUskC1A0flJEUu3+wWzE1lErjKMhqJK+oL?=
 =?us-ascii?Q?qPxlYCnlZDR7fj+wLrwOeiL7jISqIQnT8cyDH04QcChpT6hPR1ec6i23rmz8?=
 =?us-ascii?Q?GdgH/nC4zhhv1u9xgTXsQEraWvmJi1VPm3wlTNs43yKuh8mB/v7YjLTdQQlM?=
 =?us-ascii?Q?lb2GI/KW/OSzAqkroi6S7BKlC65gDuzOroJ8iQez842AdwqEUHpUYAgkAxjD?=
 =?us-ascii?Q?tZaGJl1Cfg5ySJzrIY4J6plCfOKHJmDhkfl9tkSr0tBzW5918yYxEEBycpZj?=
 =?us-ascii?Q?qlFYW7ZjDLjGHz0lRrYdJNZgW0z6L7yITjTs1a60VNkglhfppyYvdTkovUcR?=
 =?us-ascii?Q?/S+lhnGQxzgzuxsjDcRbBdojAXjfoOq1jS5h5bsqbf+y4Q0BhU1NLiH4TXfu?=
 =?us-ascii?Q?E+LXny8mLcresL3Ul1BNWxWj5x+sZ0D5mis92xJKgvN2kw4+ztBwVAefmv9K?=
 =?us-ascii?Q?gRQEE8HaUPCmvQgR3Bya96GZsh196JpIqizvR8GKisGLdA6EbcyizG1nXlxA?=
 =?us-ascii?Q?ECNEiQOyS/EeXbi1+ifPvEKUAcyXhe78if6HWFEsnRcJbFsACz2iY5BXzLp5?=
 =?us-ascii?Q?OKY40nIToyJZDBWSm7AWpnK5JuvCG/tJbvhDV/5MYRVs8Jm3sZdV5e7WGonb?=
 =?us-ascii?Q?lEKRSv4VSAKIyqVRQc4m2n4GchJ+Z5v3MKXrooR334eT38ervA342UEmN9z0?=
 =?us-ascii?Q?1C4dVq+LjPZE+xtdk86dYYXis5eTIjdW1PdlxlRDJ+5zm0W3/KPkUAORGOY7?=
 =?us-ascii?Q?54hkazHNGmVHY+sO+M/yj5K8Fr+1TJA+sxxPCtPt/k/GGZ89yanNCvJNcl7n?=
 =?us-ascii?Q?wZGcTmKPzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ca2be0-d530-4e5f-d63d-08ded100e434
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:24:49.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzhPgn/5XNpTC5I5i2oAOIHRDskupF/6HHZc9dXmQ8xDPzyMIjb/mj9fsUX2nEboByu42a3tTfGHPFbWtY+TgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B

On Mon, Jun 15, 2026 at 07:55:26AM +0800, Davidlohr Bueso wrote:
> Implement cxl_bi_setup(), which walks the CXL port topology to enable
> BI flows on the device and every component in the path between the
> device and the root port. The walk is two-pass: first to verify each
> component advertises BI capability, then to write BI Enable on each
> dport's BI Decoder Control register and on the device. On failure
> during the enable pass, partially-enabled dports are rolled back.
> 
> The teardown counterpart, cxl_bi_dealloc(), runs automatically on
> cxl_mem unbind.
> 
> cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
> in each decoder is programmed separately at commit time. After a
> successful setup the device is BI-capable but not yet using BI for
> decode coherence.
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 366 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  28 ++++
>  drivers/cxl/mem.c      |   4 +
>  include/cxl/cxl.h      |   2 +
>  4 files changed, 400 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e4338fd7e01b..cdb741d09b9e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,11 +2,13 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -926,3 +928,367 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
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
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
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
> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(device)(&port->dev);
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (enable) {
> +			/*
> +			 * There is no point of failure from here on,
> +			 * BI will be enabled on the endpoint device.
> +			 */
> +			dport->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +
> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(dport->nr_bi == 0))
> +				return -EINVAL;
> +			if (--dport->nr_bi > 0)
> +				return 0;
> +
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return 0;
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (enable) {
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		rc = __cxl_bi_commit_decoder(dport->dport_dev, bi);
> +		if (rc)
> +			return rc;
> +
> +		if (port->regs.bi_rt)
> +			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, true);
> +}
> +
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, false);
> +}
> +
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
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
> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
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
> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
> + * committed here (cxl_workqueue tears them down asynchronously), but
> + * memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +	struct cxl_dport *dport_iter, *dport;
> +	struct cxl_port *port_iter;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
> +	if (!port || !cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +
> +	port_iter = port;
> +	dport_iter = dport;
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

Hi Davidlohr,

I think the failing dport enablement will get disabled here, too.
Because you put the "== failed" check after the disable. For a DSP that
re-runs __cxl_bi_commit_decoder() on HW that just failed to commit during
enable, I think a second commit timeout up to 5s will occur on every failed
bring-up.

Rollback should only unwind the dports that fully enabled, stop before the failed one.

Correct me if I'm wrong.

Best regards,
Richard Cheng.

> +
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport_iter, *dport, *failed;
> +	struct cxl_port *port_iter;
> +	struct pci_dev *pdev;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port_iter = port;
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
> +			    PCI_EXP_TYPE_UPSTREAM &&
> +		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +				       port_iter->regs.bi_rt)) {
> +			dev_dbg(cxlds->dev, "BI not supported by USP\n");
> +			return 0;
> +		}
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter)) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		if (dport_iter == failed)
> +			break;
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 760f51b43891..89c0c6ce24a3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -167,6 +167,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
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
> @@ -630,6 +655,7 @@ struct cxl_rcrb_info {
>   * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -642,6 +668,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int nr_bi;
>  };
>  
>  /**
> @@ -906,6 +933,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ab88eaa31d1d..c40f482b7c14 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -160,6 +160,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>  
> +	rc = cxl_bi_setup(cxlds);
> +	if (rc)
> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 8ce9b4e9ca73..4938e93edb63 100644
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
