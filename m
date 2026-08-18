Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B173385D6E
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044408; cv=fail; b=KZt00D5zrvC1BM4zHTFDUR5nKpy1Z4RLa9wXHj49OoBqU2eHYilQ2gmBjDtsPpK3ft+WIxw1fL3aMhKpM8HqogrbjGYErRnPMMlrZa3XcQQ4dKJDx/+/ydY6aQYNBge7sF4ZuBSOnHrJvATiVTV9mkGqJUJPMyCjJPkRhH1BOwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044408; c=relaxed/simple;
	bh=v9pukeAzjmWL7inEllB776QwMmuxzT1q5MzvKbJBc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFO+0TqVABZLJjD1QXLCnww2iKIsU3GXTuXdVHJkglmLcblOGuzmj1dr1+G6ks+RKeYMEBTe4JwwobyXipd/WB0dMAajs/S7m+f5vp95Q3NcxediZWxyuagyoDhAcQQNU+9M36r9nuHLbMxidNYyavH9DuTIHOtX6xkzEIdx4d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1waCwbjI; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1waCwbjI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXDYD9EGDhqSb+pT1dABIPY2jA7uIp14MRGF0N9FLIhfq6p/xEFeuyNaTZ7VM4gkXBI2Hvf6PRpWJG43+dANHkSmDI/6SeWlajih1GzA9wxlRTA9yToqCQU9du1mAnrMNq0tVuJ/MTNFjqSlQ1FSP9j++c1WE1pnsmMfGUY9zZPKLSmH/rPr3g8FP/WluhwQ0yUVR+adg+OfUoIfGfm5T5zqczddEWiRPH/iSEdYjADHRudCT4KYkAp/fycVtxGkRODuT8WL6E79As7R0ulnykRzg+Mx52ksaqdBvvRFlxA6TU34jAIPianaSaKt6gjiXWUIwMF/H8LQF2MI4y4tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG3uFrlh/DSKFkKgJnsRyLPFh9XDbK99spVIZo8V4jY=;
 b=t2QNkju3u9GNzrZPQt9OdjnvYHnT33bRsk5/6ZwVEXmNqhwqvnHJ/zVO5xluZO6VP0krIO3Fw0uHWvz7BJ0MMUI4grg7bzzsSJm93jt2qdHUMoGSe6NNXvqt1+1SYm524Wrq5Ur7J3PVSehEJqimfbVKnp5JwYseUr2pQ+v2981b/S3KzObFqw1fuVUUdUQpgmeAYwpKo5v/wiChAgSegXOrdB3o59DvCAvpzVUWdVWQxEWB0gl4x1YvtRuMfIwOPsKib2ZUOhxQkNeioctclF8nuWFIVNyo2VRwI2XSi5G1ss0F3YmuxuR/8DkbTaEOGOil1SN46rIrB0kUUkFsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG3uFrlh/DSKFkKgJnsRyLPFh9XDbK99spVIZo8V4jY=;
 b=1waCwbjIRiQH+H+rk3ZQJ5vv7L0PaI254kNVVPfGmmTkWenOUT3j7ZS1m6iHe04qduw54JNiclfoFX7htyZ4PIvRwKNPTPXt/OzSYm56abhNikd8xfhdyvDGyW3llkd9D6nuOwltzZp5HuhfRBnpopOF4yF38fUztvQ6ROPohZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Tue, 18 Aug 2026 09:13:22 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:13:22 +0000
Date: Tue, 18 Aug 2026 11:13:18 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/9] cxl/region: Validate interleave selector bits
Message-ID: <aoQiLpojRvgfZA7I@rric.localdomain>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <67cfafacefffabb7db34f9d261ba47c0edc7dc67.1785444498.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cfafacefffabb7db34f9d261ba47c0edc7dc67.1785444498.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::12) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d265cc-ab7f-4e93-a098-08defd08f37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Obc0sNE7mpvzlV19wFaY9uux9FbGKSVC/7qXK1/uOjNwyveGeukSIm9aKWIf+1hLZSOYaEJ0z8ZBdAFBzP1Wb0QatgHSI2yEZh/Xcoy+eniamZXIeOAiVkf8WkmU2pRxRkDWidCXE3/BYYmUYJzxhjGhSyQ+ywW6Ai6e23TWQODqj4J7Btzd+aieYbEI2mwdSwExB6r2TloppqHK9VFNYedhk9cWFvuVssfFIzY7OeceqZcpm1LdoKMf13wLK4fULicXVX9umMsr72DmK6e2okY0zTGSlK+jW9IIpVBYe0SxL6ym/yVAo3lm+kkkygflkeEQ+rIgNNSuJ9TT3nWjLusQFCCFIZsW8JsOxDgDiaCqZCGik/vK1txbMAoGvRJDZxqdo1yyhfZ9S5z2sv95XWOiMxHLjm2PQnMXx41l5fbGgIbDaHHA63ZIjwo4r2qFgQhIMOmWIWRiNgCKUd/HmjRc9uqR1ekL/wrtE8GUKjo448vz60e1pSP3vYIevWxT4LxoUceQSeyt5TIUPn0C6rob5HJuDsH0qynCWF2RBbcbmrmt3BMOvhY5AjNNnsSSxInWZXQ1NazkT3Y+K8tL4XSCm+dNbzXUm3KBrewirgxMM8khEvi3rx6jykqnNWdRnptK+/986dqesBIncF+Hjk6UcoWrrJVnr2cUsCwRMNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uqLNu+3umyu+8duZiFsBMo6VVDM64H7ln/bGhSpBAx1EkhEr8iY0zu4B6/pE?=
 =?us-ascii?Q?8Yn14WYzOFSfGtecHBNOxev2npnZSpPQ+3wUN1jq1aOy07ARayegUcL+AQCO?=
 =?us-ascii?Q?n8z5+RpKIk73hSJKbEA9csoZWHgFf+mpgMU8cwCDh2+7zJtdhRTyR6LCt/nm?=
 =?us-ascii?Q?TNW9r7g40gMa9O7l2MUansDCG8zNOctZ8iFKR5xZP1/WbIWH3JlPnHEcA2Hs?=
 =?us-ascii?Q?HlyKmIdEz5Bey4ptgZ47Pjm4jhPNq1GmmJsV/a96HxiGzGb4/J/eQFJwnB7Z?=
 =?us-ascii?Q?4VgH+OV/pum+ZYQJUIhzvn4084KAozeV+VSIruj3LL1S1opXxN0VVINHuQYr?=
 =?us-ascii?Q?VzPMCOdyORgOvuS0xXbk2UOGOsPzM4lLKXmw1yzXcL5uZtFH646TgCs3wyYv?=
 =?us-ascii?Q?XrwA/XgaWIpqOpIhjEwbRbIHvFL+kN4KW2ZOFwkNfHZbeV+cbZhdjKPzBrPt?=
 =?us-ascii?Q?8lY0LFzp/BBjiJ/gwlUIxN1AHc6wuQBEFDUndlT9De4g46spFQgZpes6qWPy?=
 =?us-ascii?Q?LP+E1t41CUKBoHq0j+t+41uF4QN6RfxsVbB7nSZCbNMAFY4ve1wK0RHf9erJ?=
 =?us-ascii?Q?nKp41t7WO76fDRculismJGH/8Vap3hYCTldeE0teKngEZhgGKof8jeLiWSEc?=
 =?us-ascii?Q?LTJ/8FBJZIeiyN4zkcSGOV+ZWddhrwR9jwVWaVc/tH1OWj1yfYcwaM4Pcv3d?=
 =?us-ascii?Q?G8ZimvlXHaR43sbG1dg6h3w8ZYzubD/V+2W21YIgwrfDLFX9Ox9IgkbxOPqe?=
 =?us-ascii?Q?jDXmIskfibNmrIfV6EztDkCO3iseyKMwWnS1P3ngxYT9YgsiQ0BOvlZhLfc7?=
 =?us-ascii?Q?xu82Td6xZu8Mlln6SkW2lHWExSgePpVs7k1XgAwcRqe4hXnNzqBeT26KDszT?=
 =?us-ascii?Q?nkgti8mTw0m1Iyonv9NNWSgOHYWveB8nFq+D2ldDWSJAJ/OI4KljGhCs9IKz?=
 =?us-ascii?Q?fd6WJcoifXm7SVyMsqKMIC9D8ImDj5QTv7NkYlVg2UODrIcyEL5dmbhV1kuF?=
 =?us-ascii?Q?puT0p3vdpydvwg7PSlKG+US0IvF5MX10eaxGXgAflp+l8ZJ3ADxRFaCx3ISt?=
 =?us-ascii?Q?HNe45AFdX1LFG/xN9Xdu9V/Sa+KHqdbtt+GrwyBRmgdJtTaYqAgrhuyIjfCJ?=
 =?us-ascii?Q?hs9SPLKd11z992+OhGk4shn/ELIhMC8tY4Cu6igS3Xs8jJd3kNN7SHaWaJiW?=
 =?us-ascii?Q?6ePZxWHLAl1xRKtqeviXOmy307W+WDJS+m7rNAWzDHwtV2/5P9VZaCecfbH/?=
 =?us-ascii?Q?N1640g0MuPQyhkb5403DA+l1wHohcSOWS0m2YFHm0cdO70lb+Z00CAKOSPgC?=
 =?us-ascii?Q?7lwQU4HYPgkQI4AiWido60VpsK88Me0TW4iyaOxzq9J9yejryg6mfLpTjJAC?=
 =?us-ascii?Q?j0rkdLABX9pH428SGx+Fehb9d62M6Gpiz4PH/E9c0De3z9CrinlZFN7n/7CQ?=
 =?us-ascii?Q?USq42Y2GwGmOZmtV2QcrXQUM2sb9v4xqFCZe5xY1Im5s7mlnwboprU6Pt6+b?=
 =?us-ascii?Q?slDT8QXBVY8cE5hRu66ptPtbLPwawIZjJXk0DdM6847iuiNTG1VwkhKYZ5Mh?=
 =?us-ascii?Q?C146DgIFVmS/mDgCHRyiOWvTFIW8+x/HYg7FZm5BwppR3bESBn/w05UyubIH?=
 =?us-ascii?Q?UHy9PkVKNMng2OWpAs6LvedrUvgAFedySk6BKtHbDR77yn9koNoRgJgllYsl?=
 =?us-ascii?Q?nb9dkUS+R434xY/vkZyEi0vJJ8BBx8LG62hEhqOGtyd+VHIZp+xcVy+0QAeg?=
 =?us-ascii?Q?f7tSjIksgA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d265cc-ab7f-4e93-a098-08defd08f37e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:13:22.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DTxWyUC7SHq/M5Kl9BU5rjvmNpMcEo6XEi0hremGsLakGpVpgMfgMQX2J9zTIPO0dxoZioLBORcizo1VSMaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On 30.07.26 15:20:22, Alison Schofield wrote:
> Each decoder level in an interleave uses a field of host physical
> address (HPA) bits, called a selector, to choose which of its
> downstream targets a given address routes to. In a multi-level
> interleave the selectors of the root, the switches, and the endpoints
> must occupy distinct address bits so that every level makes an
> independent routing decision.
> 
> The existing setup does not check the selectors directly. It instead
> requires each level's granularity to equal the parent granularity
> multiplied by the parent ways, which only holds for a subset of the
> legal selector layouts. Layouts that place non-overlapping selectors
> in a different order, as mixed-granularity regions do, are rejected
> even though they are valid.
> 
> Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
> the selector of each level from the root toward the current port,
> reject any selector that overlaps a bit already claimed by another
> level, and reject an accumulated selector that does not fit within
> the region selector. The root decoder's selector is walked alongside
> the switch levels rather than tracked separately.
> 
> This patch adds selector validation but does not yet enable the
> mixed-granularity layouts. A temporary gate rejects region granularity
> finer than the root granularity until the position arithmetic is
> updated.
> 
> Originally-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 103 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1082db7b2cca..b0061f03892a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1448,33 +1448,110 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  }
>  
>  /**
> - * get_parent_fanout() - Calculate the switch fan-out above a port
> + * get_selector() - Build the HPA selector mask for an interleave
> + * @ways: interleave ways
> + * @gran: interleave granularity in bytes
> + *
> + * Power-of-2 interleaves select targets with contiguous HPA bits beginning
> + * at @gran. For 6-way and 12-way interleaves, only the power-of-2 factor
> + * contributes selector bits. A 3-way interleave contributes no selector
> + * bits.
> + *
> + * Return: the HPA selector mask, or 0 when no selector bits are used.
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
> +/**
> + * get_parent_selectors() - Collect selectors and fan-out above a port
>   * @parent_port: first ancestor port
>   * @cxlr: region under construction
> + * @cxlrd: region root decoder
> + * @accum: filled with the selectors claimed by the ancestors
>   * @fanout: filled with the product of the ancestor switch ways
>   *
> - * Walk from @parent_port to the root and multiply the interleave ways of
> - * each switch decoder. Root decoder ways are not included.
> + * Start with the root decoder selector and walk the ancestor switch
> + * decoders. Reject selectors that overlap. Passthrough decoders contribute
> + * neither selector bits nor fan-out.
>   *
> - * Return: 0 on success.
> + * Root decoder ways are not included in @fanout.
> + *
> + * Return: 0 on success, -ENXIO on selector overlap.
>   */

See my comment on comments in the previous patch. It should not be
documented.

> -static int get_parent_fanout(struct cxl_port *parent_port,
> -			     struct cxl_region *cxlr, int *fanout)
> +static int get_parent_selectors(struct cxl_port *parent_port,
> +				struct cxl_region *cxlr,
> +				struct cxl_root_decoder *cxlrd, u64 *accum,
> +				int *fanout)
>  {
> +	u64 selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
> +				    cxlrd->cxlsd.cxld.interleave_granularity);
>  	int distance = 1;
>  	struct cxl_port *iter;
>  
>  	for (iter = parent_port; !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent)) {
>  		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
> +		u64 cxld_sel;
>  
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
>  		distance *= cxl_rr_iter->nr_targets;
>  	}
>  
> +	*accum = selector;
>  	*fanout = distance;
>  	return 0;
>  }
>  
> +/**
> + * region_selectors_fit() - Check ancestor selectors against the region
> + * @port: port being configured
> + * @cxlr: region under construction
> + * @accum: selectors used by the ancestor decoders
> + *
> + * Return: true when every accumulated selector bit is present in the region
> + * selector.
> + */
> +static bool region_selectors_fit(struct cxl_port *port,
> +				 struct cxl_region *cxlr, u64 accum)

Better have this inline in the code, this functions does not help
much.

> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	u64 cxlr_sel = get_selector(p->interleave_ways,
> +				    p->interleave_granularity);
> +
> +	if ((cxlr_sel & accum) != accum) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxlr_sel, accum);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * derive_port_granularity() - Calculate the granularity for a port decoder
>   * @cxlr: region under construction
> @@ -1517,6 +1594,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	int ig, iw = cxl_rr->nr_targets;
>  	int fanout, rc;
>  	int pos = cxled->pos;
> +	u64 accum;

rename: "total_sel", "parent_sel", ...?

>  	u16 eig;
>  	u8 eiw;
>  
> @@ -1538,10 +1616,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return -ENXIO;
>  	}
>  
> -	rc = get_parent_fanout(parent_port, cxlr, &fanout);
> +	rc = get_parent_selectors(parent_port, cxlr, cxlrd, &accum, &fanout);

An easy and straight for loop could be a good alternative.

fanout can be dropped from the function interface. Weight of the
selector can be used instead.

>  	if (rc)
>  		return rc;
>  
> +	if (!region_selectors_fit(port, cxlr, accum))
> +		return -ENXIO;
> +

Without a helper it is actually better readable:

	cxlr_sel = ...;
	total_sel = ...;

	if ((cxlr_sel & total_sel) != total_sel) {
		...

So, only use helpers if really needed. And, assign values directly.

>  	if (cxl_rr->nr_targets_set) {
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> @@ -2087,6 +2168,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * Mixed-granularity position calculation is added by the next patch.
> +	 * Reject it until then so this intermediate state remains bisectable.
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> +	    p->interleave_granularity)
> +		return -ENXIO;
> +

That change did not remove anything that would make existing code
break, right? It just adds selector calculation. I don't see a need
for this additional check.

-Robert

>  	if (p->nr_targets >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
>  			p->nr_targets);
> -- 
> 2.37.3
> 
