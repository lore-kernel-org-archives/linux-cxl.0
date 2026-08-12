Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DD282F2A
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521546; cv=fail; b=ksbhuZEFM7ndTAEcN04BTD0v4eRtpsR7bCJTGmRPdRoLS0tNvzHf36NmuFZ1pflmBQfp4eY6Y3CGexNshz+NnlAgYwOa+tuKmmVGPiCsGBpJcEJqs/Ril49GaXy+7jGHXoVL3u2OadhU/I61afVR9NRiuyQw72Vk7inDBua1HJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521546; c=relaxed/simple;
	bh=MESC+HOExP1C88BheW5jrE6fXKlSbIbJDI1r5qDz46U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hgOaI9htxCxued5jQTq6mCypf2+H625FCir/F7y0mv1KdjcV+h6wFCtvBeps/YyakR59nu0R5Og60qltyh8RRbSF4oeuJnM1ML0V2zn8b0x10EYFfPi4qnL4Rh1lUcXwp2dtDhL8bdxKE9J3shVaZcHTEuH1t7q+D7Ze6EmT7lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hSZ7hl9R; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hSZ7hl9R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJaZypcha8ri4hhPOJz51HcZdq5EogmGiWXXRx7JL0BJ4MNPlib+tBky3XbdxXIPJgYnXLmBfb9Dylxmk4+4TKPIGhTU1NNKkYpCgLcS+9awXiN0kDyKXYjemms8BcHM35EgPdU42DnR6fXwMbi4NFOUOVujAnC5ORsmnrUU64QaAce3CJT1Ts4CY7kIIIKR+voqGF+/skkNigjsB3IWHX6rK/49P3KJ/HXQGQyk4qTn5RxGe4owlngLkJgUSdBS27LH1i2/4ciaKfmv0k1bqmSnQdpkJvrhTBSqf2pKymVXbcGJmdogEbjQDHiAu1crLsn5zqWlsNJ9Cr88dd/yVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZbyrJAv3nWKozJNRcD433UPanaas9IJr11KhE+eP/M=;
 b=yOsUDADjoRm6ULtv7O4ILt5ux93tbIQccwMPGfFjA2pCEe0BHbAbFv0Y6wp+pM5NG8a4TyGxRyoj0VIBKm5/tir7FEt8X9Hr9wVhoXvo98gBQD1HgnnZFKT3+B4UWR5CJ4X6J04IodDfA0cYykCPQilA70icH3MIq3VZUnyK07CYANJhQuvrLull4KODkmCLsUKFTXPgL0vCDCRay7jMNZuvax1N0gfxXdl2JnPt+7KxEihIvnvvYeaaeAj6vJLRGbbPrknwSTh0e8suWijLxzQc6mnQUxG30TyhuD2vdoAEoIKQTwymzINzRc1mdy/gxGLycYm2Abw8rDyYqaF+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZbyrJAv3nWKozJNRcD433UPanaas9IJr11KhE+eP/M=;
 b=hSZ7hl9RAfWTYWLpmMhk1JuBblwxRpY81XSxDvrLFZSugjaLtj+/jTS6+sEUY5Z+z5WDczHo91MUUFghR/lhaovI6zLVe1eaU8R/eNaJRQrV6RMv96V6wre94leLmYoU18NE99YJ1V1jmN4ZE1Qgq3cEeVurVzZu7kD1Dxk+6eVhCgwvI/SM/rkTNV1tk1/RCjYN6pzDCvjC68yKFM0vKQLxj4okm/vhL0aZaOZ677/H25THK42pGpTpjaOi2P7zNphiKsBU8oni8sWhv2C7mqiZLwMvNLhe0NSJy3W0bMdvILiC+76VHoTN4/8sGmXFHKyA/Ppfcfr5Y8LqWwJJow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 07:58:59 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 07:58:53 +0000
Date: Wed, 12 Aug 2026 15:58:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on
 setup failure
Message-ID: <anwnc6DDssBblI9y@MWDK4CY14F>
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812061043.57319-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ef0e1a-edb6-4219-9942-08def8478d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DkzgabTEsLPsnu8tWMUGrs6jpd2Q9PFvmd0Qv7rXoWOOPAkpKosCVWntuvN1gXn+qqptzehqWxlj4qMUFlZUkzDjSo/RCLLNaHnPcq5OGJeax72Kcieq0OOLTHEYRE1BvaDJbXxsKIAAOgLwj1s/xnjO1n6ZbTKWrY1j0gWHLVmcv7QuHNFo9zoGnyaUZdileUN50ZlNaWM44SM8X/fkQSzAz245npFu4P9hYXq09Rer8QOUuGb/NuKiS/kV/qzqcnhrkL4tCgjak7bVdR0WTdmRRQrKj1AqgaDf1T7gDCsBiWqkX0UjguNk7R98NywWHnTFIsbGcuSgROUfK4glDi5NWAb2OXEBGyLb4FpAnFc4ta/JvUU7qdgPYbXpzqBUpJWkZC7j+qBE5RC+r/g0UKTZVi11EM0yxrhI4smHkIXkuEnF/2q3WO9epLVD/jBEnT970Nft0lHs9h93qoXXv5RQIDVB78rGvxCDGrrq0X4lB5mB670OCmWiSa64qP/tEpjcAZg8vnwxX0MuWc1mjjzU2gXaKT70i/TLEngC4E32bryWNBDvndTpQsVHeSFysOJ5rD4o2ZGRihj8EliIxX/13EgWEJ3mgfURGSQR1Zv/lqMtUdSKYHOoPlqQOiwyyt6KrzTJeig7NFe5x8Gd1jkat8oeqqKt2KKVXwP0Ce8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnNfFfDctVMIvWaXnLSIH8bjgejZz4Xrxm37FePuUSXwtsRSjshxsxABe720?=
 =?us-ascii?Q?4nVNEhsMm2yILOKkxT0CJ5kRCsPxhviH14efDmf40wftau1mDR6CzsQuYUjQ?=
 =?us-ascii?Q?j45cMoSU/KO19ByBWCotfhOFwkeCE2Lcj/+RF/yrQ3yxpiuxaezf73XEnFAV?=
 =?us-ascii?Q?lI4CS7tUoN4IcdWgxilIKiWcQiHd66FZWoMhpyPvp+yzZiHYJHiY6Wwb/ogC?=
 =?us-ascii?Q?+gWUF7zUE+aSL7qhXtCVCn+I/ufvFV2ylAGt6YkvqdteX0cn5nL9LdeXMdhX?=
 =?us-ascii?Q?SqNNcfURyD3FXvJ9WMIlwwLWmzIVSvEmimrnO3qPfHNr7yNIAiioFCzaEBsa?=
 =?us-ascii?Q?cbUfyGzCIEfAUpksu3B/66vmx2odZ/yucBzX2x+ozFPAlglK5mt+FyySnNFq?=
 =?us-ascii?Q?FurVBefl942mV4dTMxivIY9f06/8SRk0v7r4i1I7HiczgNgNJt4hOMmk0mLC?=
 =?us-ascii?Q?7MoHnsmv2w1PxOjcywE85Um4DYvL3cWpUWkE+sWKw2ZFesrE0NbZZTY5fGR4?=
 =?us-ascii?Q?E+sGGg1wYEcN8u0/SjAAjeZxZc5R+F3ZuPmMP8dipzhPzdgco7jbcaWYhDBc?=
 =?us-ascii?Q?rbgIQwgVi+BWRy60G2mAVUnTdODt5ssgUNj6xd71P3KYkQ/tq+rEEX1+VjB+?=
 =?us-ascii?Q?+dQREY2i+371QSZRU8T3EMuUPfah93ME+Dzq7ciCYFBBaVOMOlgzEF4DTzrX?=
 =?us-ascii?Q?kz0m4jsuGmdvrxjW6KQHO8QpVtfCLffVAsK6xmytSANR5IUc6zUh4vFiGR2X?=
 =?us-ascii?Q?ghDT33dDjhWFkMm5xkAkdwbyhta1rOz0Rfh9W9tg2vnjC0obDCJDhA/+S8HZ?=
 =?us-ascii?Q?NYFX1swQJmlx1mfMiNu4YTvxHuj/0xod4nzSrXuG023ea6VEjQEkXblu1sV4?=
 =?us-ascii?Q?ZnMpmB0VvYJX1EJZXqrdhSwS41aSK4B0egZnGfKHPFhn7thJfvZPkLdMndPh?=
 =?us-ascii?Q?RxuuUCxD96bWgI/xT7DA8Fri6gua+4E1BwN85WTf+UJ3HMHw4lcvWnxgkhHt?=
 =?us-ascii?Q?nxwWCRLpbsUGTDGFScnUt8Vh6t09fFr3fRPCpHsnwvzk+C69FclskcjiZW9q?=
 =?us-ascii?Q?eLLhjjH+j1IUxrAVYlvGSZ6I2RabMhviw4r62iEb40GInCYtSu3ssne34gDW?=
 =?us-ascii?Q?qie0jkHA/2t535PepXUMDYmrMXyXLgq3rm5yaji6QTu7wDuaC6CrpXvlTlsq?=
 =?us-ascii?Q?OHmYS0g2wKvFDq1pRkPMFRj33aXf7MO7NhpgBHYTjjtcxEJXLU9+80DPAv9f?=
 =?us-ascii?Q?ZKuvSebs6Y2lc6z7qqnp6IHKdBW7X8Saaj4byv8zh4pPA6FVcn69EMXrajJo?=
 =?us-ascii?Q?IwHnZsB1jNdltziTFG8yGxfHRt0RacML93PyF+iprPKQWVnw+5GMsSPdHMJD?=
 =?us-ascii?Q?KbtV9ZvMKAYaodd+8TYOmd2rNwAS9V8mGkxjKL2O/bAurnTatrPRhZsiiR7R?=
 =?us-ascii?Q?wFrRO7cpyjfzjM7wow1v13qWQ0keuLOMyXGqmKVzY7F4LKuBhQxEnrjY0yzm?=
 =?us-ascii?Q?Px9JeMvsjSM750UFU9i+LQlEG42a+6FkZo9wiaTdyejS2nNO+jb067IyeAsP?=
 =?us-ascii?Q?rF06Gp4JzKCNE/R/9ljFlRYgzJpXgvlfz3AXMlB3R4ykQRIEQpLygyUUPANH?=
 =?us-ascii?Q?lY12LyV6ly0Dy+TXSjorw1OIvyLB5rmztpr3ywSCYbQyhWfgPrUiN22tmbTR?=
 =?us-ascii?Q?bReTAM1nP3vODfIECJcfLDL7w7bqn/7GXPxZY0SkPzS3p7iXJYbg/+yTpKBk?=
 =?us-ascii?Q?5H3wa3udKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ef0e1a-edb6-4219-9942-08def8478d58
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 07:58:53.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIPr42pBjFYuwSQ2lzG1TeFJtbWELJTUMazNbEUNCG/PUv4BdxVAeHO/EvF8wDS610tTDF2wi50XWXKthHG/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113

On Wed, Aug 12, 2026 at 02:10:43PM +0800, Guixin Liu wrote:
> devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
> and only afterwards, under the nvdimm bridge's device lock, arranges for
> its removal - and only if the bridge has a driver bound. If it does not,
> the function sets -ENXIO and leaves through err_bridge, which drops the
> reference this function took on the bridge and returns. The device that
> was just added has no owner at that point: no device_del(), no
> put_device(), and no devm action to do either later. The sibling failure,
> a devm_add_action_or_reset() that cannot allocate, is already covered,
> because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
> that path.
> 
> An unbound bridge is a normal state, not an error state. The bridge is
> unbound whenever cxl_pmem is unloaded or its device is detached through
> sysfs, and a region can be probed in that window.
> 
> The added device then stays in sysfs, along with the reference it holds on
> the region, until the module is unloaded. cxlr->cxlr_pmem still points at
> it, and worse, the name is still taken: a later probe of the same region
> allocates a second cxl_pmem_region and fails in device_add() on the
> duplicate "pmem_region%d", so once this has happened the region can no
> longer be brought up at all.
> 
> Call cxlr_pmem_unregister() on that branch. It is invoked from inside the
> scoped_guard() that holds the bridge's device lock, which is what its
> device_lock_assert() requires, and it performs the same teardown the devm
> action would have performed, including clearing cxlr->cxlr_pmem, so
> err_bridge is left with only the bridge reference to drop.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/region_pmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> index 23d97e3d78b6..7ab1373a95e0 100644
> --- a/drivers/cxl/core/region_pmem.c
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  		dev_name(dev));
>  
>  	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> +		if (cxl_nvb->dev.driver) {
>  			rc = devm_add_action_or_reset(&cxl_nvb->dev,
>  						      cxlr_pmem_unregister,
>  						      cxlr_pmem);
> -		else
> +		} else {
>  			rc = -ENXIO;
> +			cxlr_pmem_unregister(cxlr_pmem);
> +		}
>  	}
>  
>  	if (rc)
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng
