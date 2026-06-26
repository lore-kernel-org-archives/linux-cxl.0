Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F662EEE6A
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473847; cv=fail; b=iaEyQjXwbn1xhUIxJfKQQXmPimsrqQka8KiTu7dlwJsh62rjXzd+6G6n9YcFkkypV/glah8xHhvYoFEJNplMMz/b7VRkhAtIkH4pHu62F6CmIq9sUsLE5dxJ1ujOiklsX3nd0vYuQk9DRcvcdzf8NyMo6tv+3+xxP4WCPi1mig0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473847; c=relaxed/simple;
	bh=x1OPMWCc5r6hscNLU4oyc+u6sT+fOdVpp9MCQE7iprQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJyd9sQsmU2dVU8o2k2oldwhh+CwG1/RCvAB0P28lkrAMW7/iPYdb9Wq6tlgmHe1U5INOWcjpgX/N99YpsKZ1gtFeFGRFawBlFCAeZcHZODYMd7W6F8FoIJxGvUNC/l5ia+i7LGBtmc7GG3fVpb2/ECz+cEiG5I496l6rjE4q+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYAfL0zl; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYAfL0zl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saPdv+XoLuCxAP1aYOLqXuYKY2TZ6xgQpLuCfOR7OeYowYHgMwkNjqUcOGfwZ20+GE+lN4pEK7MGBZtjYC4UohMF+6KxTfB9FKzKtLvJTbXuvi18+9haR4OcJAUQpdLgMdx5jlgvhYHVDbBRcCF4pNxZMkxuWVjwGGocQK6YxPRiBqqo3EirtR8myjB/MwSbP3NAamfRhEvD1kyHLwKqxXBirbYVaDBdL/cs0mXfzkOFYl0heUq/4y+S2ldVHHWE7Oo4KtOmIYFi96Pkz6GwlziXbue0Gt2JOJFi7FolqYf5zT7psfBnewM86UrOmsM8u4G5NcjAU6hyiySjvYy6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBGMsrnn0kyUsnzoAPraZ/fbZ8LzgQhykEX0AB+Rk4c=;
 b=lQ2HZJTF9ycX2ixsI/azV7ujxoAijfdW2gCQuB96CHGdLBrjlD6eVVgIE60DunSTFQR4dfkjndYku8g1Wru7fzoWYiGJob82x4pippNvsaDm/WXSJ4buv2bftniXVQ7nzCRB7ZYNQCsLpkkbeeSwlrlECBfW67cEXQ29IygFkmfkLXlI4p9MjZEo9YgSDo7k/pCVvpkwnM3R9qzN1R0jkB9iGhsu7RKWBNjhnpJhYosd6ZYw6gXZ+Gv2qxo98YraAQJE11+tViM+/SJosSuyS7rddMecTB6OzuBkC6cspYjg3+nwGYiepzlm4pOekRZwxkbuOGwO4aqaYpN1TDNq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBGMsrnn0kyUsnzoAPraZ/fbZ8LzgQhykEX0AB+Rk4c=;
 b=aYAfL0zlELmADEnQLzls22UiSNxbMwYJUoprw8PP+kuivwFYVJDU2jNclhizFl8Uqp8wZFwoTsUg219mJSfnM0oRj1KTsUuXiws/3rkvzO2TBZ5lxpog0/yoqEC2ApdNxU8o3o9Uj28VeVbksyvPVVmZKBFi3CjQXgPb1vFBDRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 11:37:22 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:37:22 +0000
Date: Fri, 26 Jun 2026 13:37:17 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/6] cxl/region: Validate interleave selector bits
Message-ID: <aj5kbdsqLPge-rkT@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::6) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: ff927fd7-4bd3-46e6-db05-08ded3774947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zA9tx/UNe1atpgpko/l0zt0JsobjVFNn6niNrXCjbQPbkcAvOClkFhsIKXUmBwvEJCONyYL8GA5+wAqNwwhrRpYBZhG2lY/oTr8PRmzVavTErasdvnkKcyrGNixBQyVzAjjn5ihWcq1JK3gwPxSXX32A+RaqOb4YRKt0p1ngImga5R9it6MxCKzx3woT0EW/9QdO4VsTj6crIR/+TBGQIQTidhWlmFkl35j3SJq/wsdX/qGvfoQtqe5GhWVQGjFSnA7pm0fpTU6wAAzGsBNmLLnKJ74Twl/nabjNOtG8Jh7+5ledqgVTs6HhADT9ZQO5pM+84HLiBAudM7YvT1wg3YN6bqRS4lmOyfWngpCNEwaTqQb868D1lNk51MIWk+dJuAhHDOxMWuOVe38kxi1yOdke6GobL/KjYmhB1mx9m81wggRoiEEWYOBCgZoaviP4+fLRc3CTWM/h4mFEW7rKSqa7VLTz8ThdWOFGizo0jw54zc166OYw/h7pmMxqBjER3wbRSPcjraRe03KwLoLnaXtj45CbrsdBn0SIUr2Y7EPhrvy6rQ1gwTTqSjn7ZnAzL9ju6FhZphtgEPym4WWQaAn7pQcOewbmhIuwHS8zmsvhoy+585rcin9fbA18pwjjpEZ0c5nJPZp9VV1a3Y3i1eOQJCA0hlSKNNIorAezgzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV/GR+fb+nnkEk6TyZAwxMqHDJrWaY/hUg3xxVxfS+T1tlO80LLcoY9bl3Ku?=
 =?us-ascii?Q?yYSehFhAvSIfUFU8kCNpn4ch/2OLh462+jFnrxO2rsfFsMOs7cSNydMMlDdS?=
 =?us-ascii?Q?dimYVCJgsW5md7Ujijer+BOTP+VzA2UVUzeFnCyXWArrDWJlhnvMBFn9AP0K?=
 =?us-ascii?Q?JC2jSBC4CLSsxkRQpjAkMlhU60AWh7eW/EsB9a8LpoGEr5NNa1MZJrkRogKP?=
 =?us-ascii?Q?f5+L34oTWptUUy6gdNv4rx3DSDyFZFng2hCoFNIGTU+hcf4h/6ivem4CGmBX?=
 =?us-ascii?Q?u+sY3OMGHNdvAPNmxoVaWigxwUyWiUU4dbuNrEv+mPNu/2HxBs/3KTAmgaQJ?=
 =?us-ascii?Q?bdI9XsGHBYITWpj6dbAt1OsoHm7MekuipQXvMinUW5Dq06Qp9acvYxuHR7E4?=
 =?us-ascii?Q?Y2JWaLlDo39gl+3x/QXlfwa0OEp/vpCdyz5lIfYVyQvvnfOlAXX/npYCqtSp?=
 =?us-ascii?Q?mWxxSCGgJfl+Wr/8feFbPozVZhUpHGtj9gDD4tH6X9LJv1elv69M1jCEmQPQ?=
 =?us-ascii?Q?PLPk0k3AMC7NmFGrHjk0I6B0w3+8h0Xh2QW45aRDezBNvd+A1XtWaM9rk7Ah?=
 =?us-ascii?Q?/DHb3dmKUVQFHMkHlb1sS+GzUFDcw/zxjQK81Ox1VST4uinlKgR8jTNXZM8/?=
 =?us-ascii?Q?8VahNA3hLMxNU2Ov7rA+8uvRmV+cklY5/blCUWZ8kvSCBVUVCeq9cSHVUrFJ?=
 =?us-ascii?Q?MnS1LjjsfQhmY4XsmZwqMSvdn98OZ1+rdyP0YzHUxpYHQ+nsHoMcIR7bn1Ky?=
 =?us-ascii?Q?8lj2ycGmhY5NQzjSmCGklLP6L66nc63MfKUHKHWlQNhGP/ZjPCciu3U5KBvh?=
 =?us-ascii?Q?dHa74xLh0f1qASF1/x0rwERm8aBVkSK8rahC3Df+BWy9GWSl6Yih/55TvQY0?=
 =?us-ascii?Q?ky8AkL8TGgQpkintvYYt8uol0CPHNnQQtNAFDUTqyUQy2L/pSwK9ROEWItUx?=
 =?us-ascii?Q?FxXlTLM0zV8OtabAsZJrNrSznCue0FzuNrUZqnKhQIsz1Rwvz9oQIkPdSx9h?=
 =?us-ascii?Q?m6bW4R2yJC6vgrQsoG3LT/8KdXw/zr4ha5kQ8HR1sKSlrbf49X7sSWeypFAF?=
 =?us-ascii?Q?ESc/aeFx3LXq+ZL+j19JdCvLop6v5YzHaUOWDiiduDsQVflHccM44mdvy335?=
 =?us-ascii?Q?OaHZ2IEgbNZqkOQH7OApgP9ZSIQJm4JBKB+C/X5LgzS+xU5lIEJfBYPSqlnV?=
 =?us-ascii?Q?TPm0LXjB/oHDiwRnVSQA3ishQwDQbhjnPn8+4SwgtwmfFmYUCrIV+ec+UfIk?=
 =?us-ascii?Q?HMRmskXebnaBot16/wD2R/acFGddu0OO/tVJ/3ZE79/CRrH2CRpkJyzvARkG?=
 =?us-ascii?Q?RdtwD7DX0ZJZXcFOUBZ2HJFNUiXYeb3QsL2huxVaEvKGS8g1yTeKjItDr6ke?=
 =?us-ascii?Q?NGQ9uWcx4SqG1GQOxS1EbPLcEGTGigjGfW/bFATVrJdf2eMXl/X3mu1OoA/g?=
 =?us-ascii?Q?4CZ3Gfc+KnvXl4GV4ByEfJPX2nh9yG+rY+JE+ZSLj4ll3YvvyfhTbSogNiOb?=
 =?us-ascii?Q?Dr0DVyfn8V++RWWQ4oqU5BxhnnkT+zR/M7u0maLBqqE9Ziept/m+tRi8wgSK?=
 =?us-ascii?Q?FB/SBhLeqqMORgPGAgImBDzc+aHV5cYmCYB1NCOCn8HzStqfomP6gfLGRrqU?=
 =?us-ascii?Q?487fIRlX7/3ydRKYkmODpgu6VH2cMey0bea6EDkVP49X88sUyVOvPn6n2hbr?=
 =?us-ascii?Q?X3xrKutlLbflOjYAarO7I5PAvZMPiayqLLW5tvQr9WR/zfeo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff927fd7-4bd3-46e6-db05-08ded3774947
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:37:22.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP9C7qA+By10xQ6yZ/oaK3n5hTIQGNT24JE7vOpbmOOaOEeT4tTDHEA1Lf1WeBOBpKDdk2piPNcYsYDTTJgSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

On 11.06.26 10:47:25, Alison Schofield wrote:
> Multi-level interleaves are valid when each decoder level claims a
> distinct portion of the region HPA selector. The existing setup is
> too restrictive as it requires that each level's granularity must
> equal the parent granularity multiplied by the parent ways. That
> forces the root to sit at the innermost selector bit and rejects
> legal layouts where the root claims an outer bit.
> 
> Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
> selector bits from the root toward the current port, reject overlap,
> and reject any accumulated selector that does not fit within the
> region selector.

I think this is the main goal of the patch, to introduce a
selector-bit mask and use that to keep track of ways and
granularities. We should remove as much as possible from the original
code without introducing functional changes here. Subject and
description should emphasize that more.

> 
> Preserve the existing same-granularity behavior using values derived
> from the selector walk.
> 
> Block mixed-granularity attachments until position arithmetic is
> updated by a later patch.
> 
> Originally-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 192 +++++++++++++++++++-------------------
>  1 file changed, 96 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..c859c8661281 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1423,12 +1423,34 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +/**
> + * get_selector() - Return the HPA selector mask for one level
> + * @ways: interleave ways
> + * @gran: interleave granularity in bytes
> + *
> + * Return: ``(ways - 1) * gran`` for power-of-2 interleaves, or the
> + * selector for the power-of-2 component of a 6-way or 12-way interleave.
> + *
> + * A 3-way interleave consumes no HPA selector bits.
> + */
> +static inline u64 get_selector(int ways, int gran)
> +{
> +	if (!is_power_of_2(ways))
> +		ways /= 3;
> +
> +	if (!is_power_of_2(ways) || !is_power_of_2(gran))
> +		return 0;
> +
> +	return (u64)(ways - 1) * gran;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	int distance, parent_distance;
> +	int ig, iw, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1436,9 +1458,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
> +	u64 selector, cxlr_sel;
> +	struct cxl_port *iter;
> +	u16 eig;
> +	u8 eiw;

That list of local vars is very long and we should factor out some of
the code to helpers.

>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1452,28 +1475,66 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);

That could be moved to the declaration section.

> +	iw = cxl_rr->nr_targets;
> +
> +	if (iw > 8 || iw > cxlsd->nr_targets) {

And this can be moved up / merged with the power of 2 check before.

> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
> +
> +	/* Track selector bits already claimed by ancestor decoders */
> +	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
> +				cxlrd->cxlsd.cxld.interleave_granularity);
> +
> +	/* Track distances used in passthrough granularity and peer checks */
> +	parent_distance = cxlrd->cxlsd.cxld.interleave_ways;
> +	if (!is_power_of_2(parent_distance))
> +		parent_distance /= 3;
> +	distance = cxlrd->cxlsd.cxld.interleave_ways;

Better use only one var here. One can derived from the other once
needed.

Actually, we do not really need it at all, see below.

> +
> +	for (iter = parent_port; !is_cxl_root(iter);

That could become a helper function get_parent_selectors() or so.

> +	     iter = to_cxl_port(iter->dev.parent)) {
> +		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
> +		u64 cxld_sel;
> +
> +		if (cxld_iter->interleave_ways == 1)
> +			continue;
> +
> +		cxld_sel = get_selector(cxld_iter->interleave_ways,
> +					cxld_iter->interleave_granularity);
> +
> +		if (cxld_sel & selector) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s: overlapping selectors: %#llx:%#llx\n",
> +				dev_name(iter->uport_dev),
> +				dev_name(&iter->dev), cxld_sel, selector);
> +			return -ENXIO;
> +		}
> +
> +		selector |= cxld_sel;
> +
> +		parent_distance *= cxl_rr_iter->nr_targets;

The parent_distance could be derived from the parent selector and
moved out of the loop to simplify factoring out this into a helper.

> +		distance *= cxl_rr_iter->nr_targets;
> +	}
> +
> +	distance *= iw;

The decoder's selectors are the next lower bits below the parent
selectors, so iw and ig could be directly calculated from that. I
think that very much simplifies the code.

There are those 3 selectors we just need to keep track of: switch
selector, region selector and parent selector. With that everything
else can be determined, e.g. iw and ig.

If we create helper functions to get all 3 selectors, this function
will be much smaller. That also moves away error checks to that
helpers.

> +
> +	/* Accumulated bits must fit within the region selector */
> +	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
> +	if ((cxlr_sel & selector) != selector) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxlr_sel, selector);
> +		return -ENXIO;
> +	}
> +
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> -
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> -
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);
> @@ -1484,84 +1545,18 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		goto add_target;
>  	}
>  
> -	if (is_cxl_root(parent_port)) {
> -		/*
> -		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG != region IG.
> -		 */
> -		parent_ig = p->interleave_granularity;
> -		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> -		/*
> -		 * For purposes of address bit routing, use power-of-2 math for
> -		 * switch ports.
> -		 */
> -		if (!is_power_of_2(parent_iw))
> -			parent_iw /= 3;
> -	} else {
> -		struct cxl_region_ref *parent_rr;
> -		struct cxl_decoder *parent_cxld;
> +	ig = p->interleave_granularity * parent_distance;
>  
> -		parent_rr = cxl_rr_load(parent_port, cxlr);
> -		parent_cxld = parent_rr->decoder;
> -		parent_ig = parent_cxld->interleave_granularity;
> -		parent_iw = parent_cxld->interleave_ways;
> -	}
> -
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> -	}
> -
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_iw);
> -		return rc;
> -	}
> -
> -	iw = cxl_rr->nr_targets;
>  	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> +	if (!rc)
> +		rc = granularity_to_eig(ig, &eig);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +			"%s:%s: derived ig %d not a valid granularity (iw %d)\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), ig, iw);
>  		return rc;
>  	}

That is just a value check which could be reworked to check the
selector instead. Could be a helper function.

We should consider adding the selector to struct of cxld and only
check it once it is finally converted to ig and iw after setup is
done.

>  
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> -	}
> -
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> @@ -2067,6 +2062,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/* Keep this patch bisectable until position arithmetic is updated */
> +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> +	    p->interleave_granularity)
> +		return -ENXIO;
> +

Hmm, that looks odd, even if it's only temporary. Could you explain
why that is needed here.

Thanks,

-Robert

>  	if (p->nr_targets >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
>  			p->nr_targets);
> -- 
> 2.37.3
> 
