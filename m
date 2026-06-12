Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E134F24A
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245284; cv=fail; b=lbCi7oDRmYmyMaT6DYLj9hDu41csHP+piw75whqCIad4VMYfeCG6/LBf7gdHsMGO9Yz+6QpovdK4LUIKmua8M1YTKXcQKXlyodpygsuoTmEY114pLesqY/INJ493WU1fZgGE0cUJ58lS7qp2XrqjX7S96J3nitQIw95THurPhrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245284; c=relaxed/simple;
	bh=XAv7ZjwS8zEcXD593l0TXQXO6qvirBwlUabSwu4ObTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QNA3n1Clg19NfuTyhANnrKbzxNAmzrUT64WOUIf34veS0/RIdHI7PECTiEaEsrnHyW0yNg13hD97SclwYNx48yFiPedvB1muwIE1TVd1WjGDBCgfp3zTKG4+xgcYCon6L5fYWMt7ec/LxvzjJoPUkpfu7mrHUPkKnfkHY6m+DHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qk/L/+tK; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qk/L/+tK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj4DTxdR4bahLDAFLXN5bqajbMSFQ5U9WfrtNo8wU+ACMDC3NznCUg/9u3XcVjtfpOs754k6MF0XVfD0ZYicE0fPW4GKv9jAHfo3Xkl+fMVa/L+9tYmTjZ38GRg6d760uk03NPlhMRdKxccSYl0z5mDDaT8aEsaWZhiiMpDP9fpearsEgB5c87eCbCGWwCk3Jr90vw+KkaNXsNcLCAr8WuQWCOckFV9p2XxSI2OrqFZfddzgkjktPA9dUyjjtbcYfLRl66h/D02Qd1xlvoEXfWSK4uc9cWg9zsYs7wIO/2ZCbZljmvKeWQITKRx1Sm2csud6Uws/ccYOZhdQ1BOgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7LiwpvY6+oelDxWCQDQTWXCCdzLr72IbqljkksOqko=;
 b=tqF9+7MnqR4iQzdeuqsSTQ/hohJ9marCPI9wmie3kc9bt+53xWCqM7AeurUzq2QkUnZSRcYt79+bb7OA0bS/35+5rZNjJ+BGhBZmJ6RrE28KRlcIGeoLNXnlfCbFs5F/jbW1KVVXg6ajcrLJqM5eDFSuVsFele8GCkf8jDvcMMazqNdxdGuK3zdFeHfF9HxhWjvC6LGKAeFaOaQ5u9TUDPwL1Jqat+vEiy7BXok3JjWGudqhzvq9324BEMGt3JZoDSFO0ev8IF+0VGfqhQUYWldlo8BedVjeu2tGZgFkLc9c3rlNum89UJ+dlRCnFtOF49a6/JKT9G5401YnBmYw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7LiwpvY6+oelDxWCQDQTWXCCdzLr72IbqljkksOqko=;
 b=Qk/L/+tKCy2J4jQaucD/1scMtWab+aKJ0yQ1b5BWGD1Shfe22847RHzeiGObtulNsw8H08vfU3IW3P03JGYymfJS1ueTVhJLEae740SoEt7lCTSfEsEmMpGzrB4hnxkYEufAu/ZcVLHdnxZs9M//0SjztJ5T4JiAAUpPtDgzNaxeuzy7/trW9rOHC4GuyenxmpJD8KbkAmXiJOtEF1CyheekS+eOM9GSIgyPSil9xcrUfQXzrhN8k6Xp0o916q2mjXCfpcoLoh0u7XMksS8uBEDBf6vaHM+2jCnrh9xDPVxvLjD61LTm87UmgsHCMkbzzrqoqvmicuqir5JmuZY2VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 06:21:19 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:21:13 +0000
Date: Fri, 12 Jun 2026 14:21:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <aiuhReNj4Q_-HMzF@MWDK4CY14F>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 198c2480-6065-455b-29d1-08dec84acd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|4143699003|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nARP8Tk+ywp7c0qa0XE0UOEUko3+ij/LotorSU3XGGIRNGUlOlBw4/vGYBcc+h08L9b7kwPkNJ9yYFh/oXAb/DpdbEbYVsMErx79fSBFO9kKZxGQCDxfro2Yvq5TtD+lrQsD5gsFs+AJfF2WNLn1VOnwA7e1NdHv19bWsnTAmpVFdymbvLLWjHsTDXA4sUChUFH2YZJjqlRc8WEHBwUiDSkiezW0eh1dlIOJ+H9FLdgnq7+gdX5qynuyFTbPyN2CH0LSqu0GVgmTO5CkWqF5wpytDMIT9798HIQdBvp3NFlk3tPv3xFoqjrRjGXb7oYWUL7NVl4B9WUdpDwqebxyFe4DXXoCucFX3JbnNRpKWcTnDLFf67RWPOL+j5J2ntIdTIFGzfZu/U1/2Qj4ACGsutpRJbfIitRBG8BR6UEXhWHE9UlxB5jnAgbZalB30hSk/HwRut6JBhQ3Mn47FHWoTSROOqM5QqnnWoiAnpsbxQzRHoQ64/TUB4xyVMGhJFfUgR4b2h5ZWxvYt3CPy0tRZHW3aaxbV9jv4Uqv4Or9AxLM8x+BIrUoFYEnsEoiWqafGfhI8j0lir000cFsHh6pyHxadSnNky0x2hd0NhJ5480bNYC+SWOIhrCNwcFVXhceOplwZmDgGjux3g9sQbPBqaAi3pSoXqNbBW9HLC0/411heP6Gydz7Bgyr+rMTbcaw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(4143699003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QzN+18SEmFDnuEw/qncboF18hRQU0dsjonuxkIdwwBhYe0NsQfEmMneW7WG6?=
 =?us-ascii?Q?wLJTDnnnt/OT9fcBRdcTyv1b7esQiIgN/TPQz6Abv9USVLFiu4usZSq4BuDi?=
 =?us-ascii?Q?XJw/RM2dfwu9pro91MIFXnsjyYkewK1N6/Zx34aCuOKa1ingWEi4u8Z4ry/S?=
 =?us-ascii?Q?mZeI5FpRPsTfOcArO1d+UmfazbN+7P2Og4XvAHu9WsNcN6eqZFyxH4wAwEFj?=
 =?us-ascii?Q?zpEJUitfG5qjnBeFeYlvpf6bjU6VuX/hPPHALmiMoiEkZdQrvcx316e7bsrF?=
 =?us-ascii?Q?StrPSfXgTJ+QaqNDr/AUjRYCNVZRpWHb7Ye+jSzne6mzS9YnxIelycsed4/y?=
 =?us-ascii?Q?n49+LmcHzloKknqGvkPsTt00DKwJu/1q5uTM3HfLDZZRl8nnUGXcFcS+L0Ug?=
 =?us-ascii?Q?WNaoaarXhGiKs9Q6SRbPJPPEJEkt+2dzj4zPHWuwkNt9UQQHEEKHCbK0V6wj?=
 =?us-ascii?Q?WliJh4ov4vB6nVaps2opab/NKdIS6PraRilwGLZMrHXKHDAErMX0G4OAhArL?=
 =?us-ascii?Q?S/7KP4hlearbCBZx5wGUk8e0+Nlw82109jQIIkptK6EG5jffNAU5Ys96RGF5?=
 =?us-ascii?Q?cph+izwmUNND6oxDxjjPUNjB+gK85cUz5CDazdvFn4guSM31qjiOm7CGQenK?=
 =?us-ascii?Q?HTu//CTDbs3m+gjXIZ+LiZGWA3N29yr8eqvQjulKEwrYCWsqL0ST7iz4NzHM?=
 =?us-ascii?Q?+YASQmqg3cPirQJzNfC7AmXlP4KK8sFCqutcrt0YtnwwuKJ/0VHrsUT9rAc/?=
 =?us-ascii?Q?1aDycOWsoQeDKmsgsRCgsiyxk5iq432srZ+sx2r9gkv4UgKMqZ6HKR9Doxxr?=
 =?us-ascii?Q?KT2yCc4y2Uz0CNzGSqzARwgYt5Q7CDLg9VrIPvw/XzL+SmiJsW4gE/YH7dCW?=
 =?us-ascii?Q?Vz1J6fop2s2IGotMSWQm3RXw2zMR1/q1kFyUKD9DdKCsNjMoiACfwtnL2fJx?=
 =?us-ascii?Q?cvVWKNbWnBY6WpRUCC2UKJ5hbLDU70VwbjR/2wZctI1Id8CKY4YK34C+PFRK?=
 =?us-ascii?Q?3y400c7Zqz8oRKlQqVVW/ofw7Xfl0rsx3ZCkdXUcQASTdc4z3mhTXg26lEvh?=
 =?us-ascii?Q?tE+PdxxQLcVonp7TsyKAxubXwi8EsYpjbjtAtYmkKnIIQGlhgeBTTbpRW7rh?=
 =?us-ascii?Q?AJYsJD5yuzpRPF+UQvd63YZ68R6AactczJ9trFLst1Tqel0Zu81UOfeAUB6R?=
 =?us-ascii?Q?CHVPrif4mVbheHe8KQFqxGX5dKU4kV2qg9Bz/QsG1ZsoapmlT+neKgVjzIlB?=
 =?us-ascii?Q?SMJeCPO4X5QGqiYCu9sTB746kjU/TL8bcAEhS5Op6H/he7fRWRECVAxNBkWv?=
 =?us-ascii?Q?tfX9c+/MqZjxC8WGB+1lz4D4q0GqZpVpqt1CEOO/sLiNLnLDamsmKS++Ly3s?=
 =?us-ascii?Q?VsZpH5+cHs6sQ32YNXN5/EfaS7ZW0gj/DptdgBnuzV8tz7HPxY9lO0e04VW6?=
 =?us-ascii?Q?CP6cSzfuSHnDZpvQghSkAmf44twKf5X53rDE7JzRRCC67niLuQKey2ID6HAS?=
 =?us-ascii?Q?1/k160q61nQy8LB0a7Z18429Z1p9X/zRktwqupAXKQiYMNMHiCW8es6ginU5?=
 =?us-ascii?Q?fwRTx3QXHmNDNCDgu6KCFt3NmebrVJKS1mrZyJGhEoe/KQZqxxmmWwbXIhsI?=
 =?us-ascii?Q?Gc2iTmVHiLY3CecG92eog06IWhP64V9MoHzJjO1erBlGsihnwdZdShWCokqa?=
 =?us-ascii?Q?meIyDz57Qd7qZgc5AM/56vrjELz3g90pvbMiR84OtSve+ci5KwBBQpRcPtlC?=
 =?us-ascii?Q?5EFz7LvFJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198c2480-6065-455b-29d1-08dec84acd4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:21:13.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hKKBXfoaDRFKfidDON2jWKkF/dtbWJuHZvYDV1g3XmSMeo1PMGAYAXGlKxCL9378VxO0Ds6mdx9p+36QMRGmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

On Thu, Jun 11, 2026 at 10:47:27AM +0800, Alison Schofield wrote:
> Mixed-granularity regions place the root decoder at outer HPA bits.
> A root target then owns root_gran / region_gran inner positions
> before the root advances to the next target. That ratio becomes the
> root target stride in region positions.
> 
> Account for that stride in endpoint placement, position calculation,
> and peer-distance checks.
> 
> Remove the temporary mixed-granularity attach reject now that position
> arithmetic matches the selector layout.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d5d19ed62171..9fff538a9ce1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1444,12 +1444,34 @@ static inline u64 get_selector(int ways, int gran)
>  	return (u64)(ways - 1) * gran;
>  }
>  
> +/**
> + * root_pos_stride() - Return root target stride in region positions
> + * @cxlr: region
> + *
> + * Return: root_gran / region_gran when the root granularity is larger
> + * than the region granularity, or 1 otherwise.
> + */
> +static inline int root_pos_stride(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> +	int region_gran = cxlr->params.interleave_granularity;
> +
> +	if (cxlrd->cxlsd.cxld.interleave_ways <= 1)
> +		return 1;
> +
> +	if (region_gran == 0 || root_gran <= region_gran)
> +		return 1;
> +
> +	return root_gran / region_gran;
> +}
> +

Hi Alison,

This helper computes stride from gran ratio, but nothing from downstream
checks that the stride equals the number of endpoints actually fanned out
under one root target.
The patch assumes each root target each own stride consecutive region position,
when that does not hold, the additive recurrence below and peer-distance seed
both mis-account, and we walk off into a foreign endpoint.

>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int distance, parent_distance;
> +	int sel_distance, pos_distance, stride;
>  	int ig, iw, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> @@ -1490,10 +1512,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				cxlrd->cxlsd.cxld.interleave_granularity);
>  
>  	/* Track distances used in passthrough granularity and peer checks */
> -	parent_distance = cxlrd->cxlsd.cxld.interleave_ways;
> -	if (!is_power_of_2(parent_distance))
> -		parent_distance /= 3;
> -	distance = cxlrd->cxlsd.cxld.interleave_ways;
> +	stride = root_pos_stride(cxlr);
> +	sel_distance = cxlrd->cxlsd.cxld.interleave_ways;
> +	if (!is_power_of_2(sel_distance))
> +		sel_distance /= 3;
> +	pos_distance = stride > 1 ? 1 : cxlrd->cxlsd.cxld.interleave_ways;
>  
>  	for (iter = parent_port; !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent)) {
> @@ -1517,11 +1540,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  		selector |= cxld_sel;
>  
> -		parent_distance *= cxl_rr_iter->nr_targets;
> -		distance *= cxl_rr_iter->nr_targets;
> +		sel_distance *= cxl_rr_iter->nr_targets;
> +		pos_distance *= cxl_rr_iter->nr_targets;
>  	}
>  
> -	distance *= iw;
> +	pos_distance *= iw;
>  
>  	/* Accumulated bits must fit within the region selector */
>  	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
> @@ -1540,7 +1563,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
>  				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> +						     pos_distance);
>  				if (rc)
>  					return rc;
>  				goto out_target_set;
> @@ -1556,7 +1579,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		ig = cxld->interleave_granularity;
>  	} else if (iw == 1) {
> -		ig = p->interleave_granularity * parent_distance;
> +		ig = p->interleave_granularity * sel_distance;
>  	} else if (selector) {
>  		ig = 1ULL << __ffs64(selector);
>  	} else {
> @@ -1813,14 +1836,17 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int stride = root_pos_stride(cxlr);
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
>  	int rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> -		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> +	/* Mixed-granularity roots advance every stride positions */
> +	if (dport != cxlrd->cxlsd.target[pos / stride % iw]) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s invalid target position for %s (stride %d, check root/region gran ratio)\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			dev_name(&cxlrd->cxlsd.cxld.dev));
> +			dev_name(&cxlrd->cxlsd.cxld.dev), stride);
>  		return -ENXIO;
>  	}
>  
> @@ -1951,6 +1977,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
>   * @cxled: endpoint decoder member of given region
>   * @hpa_range: translated HPA range of the endpoint
> + * @stride: root target stride in region positions
>   *
>   * The endpoint position is calculated by traversing the topology from
>   * the endpoint to the root decoder and iteratively applying this
> @@ -1960,11 +1987,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   *
>   * ...where @position is inferred from switch and root decoder target lists.
>   *
> + * For mixed-granularity regions the root contributes outer position
> + * bits, so the root step is:
> + *
> + *    position = position + stride * parent_pos
> + *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
>  static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> -				   struct range *hpa_range)
> +				   struct range *hpa_range, int stride)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -2010,6 +2042,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  		if (rc)
>  			return rc;
>  
> +		if (stride > 1 && is_cxl_root(parent_port_of(iter))) {
> +			pos = pos + stride * parent_pos;
> +			break;
> +		}
> +
>  		pos = pos * parent_ways + parent_pos;
>  	}
> 

I have a question here, on AUTO path, the check are bitwise and order-independent,
so they accept it, then pos comes out d*2+u+4*hb where HPA decodes reads d+2*u+4*hb,
so 6 of 12 endpoints get the wrong pos and the region is rejected or mis-mapped.

If my inference is true, it contradicts the cover-letter's "every arrangement" claim.

--Richard
 
> @@ -2024,12 +2061,14 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> +	int stride = root_pos_stride(cxlr);
>  	int i, rc = 0;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
> +						     stride);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -2056,6 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
> +	int stride;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
>  				  p->interleave_granularity);
> @@ -2088,11 +2128,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	/* Keep this patch bisectable until position arithmetic is updated */
> -	if (cxlrd->cxlsd.cxld.interleave_granularity >
> -	    p->interleave_granularity)
> -		return -ENXIO;
> -
>  	if (p->nr_targets >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
>  			p->nr_targets);
> @@ -2214,11 +2249,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	 * A fail message here means that this interleave config
>  	 * will fail when presented as CXL_REGION_F_AUTO.
>  	 */
> +	stride = root_pos_stride(cxlr);
>  	for (int i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> +		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
> +						   stride);
>  		dev_dbg(&cxled->cxld.dev,
>  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
>  			(test_pos == cxled->pos) ? "success" : "fail",
> -- 
> 2.37.3
> 
> 
