Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B13DD873
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550387; cv=fail; b=uIBnMSP/dQvJufgmVk67Srgf90atouScChX4d8rn5rXzmtDadJ5lyY3CSzMqSpExQzGsn6OHonAqjWNwYIY4PBRfHpomZ2f0TkH9yvBYoi00P7FQ/LNJjnChBszhrtIJpPMEFp7G8MrCDUx8sBhxj83w91eAmuxl+SjjEoEj/f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550387; c=relaxed/simple;
	bh=YkhR9X3vgmeRDujpoqU6gI8vCvITF3aoavFWeNq52DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bBdkgIKbFpWR2Xvx23FMH2K5GXbxCL0x3ccqHGo+c6D2pa00nS1+nJNBiFRCi3FIi7/MwZHeo1bel6vFnKLYOeAp/uueE3TFToahj9y7GHmZ/abXssRwRl2G/ojeRCUMPZMkNkzBVQudN0yzaUidVJS46dm0kZOKwSzDu8ZWeks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sv6qEWcS; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sv6qEWcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaplsrFJQwZ220EJURf7ZuREZjHMO+1YGvzj8OE8Peb22zTGR2GFpO9XtEktN+AYHqZPf+Q4VOm2bMtEZ5D77FIncNfg5BAwSM0Xij5iMJCbORhVBg8Hndy8vmQuSPdnead0Nby9xKZTWHjepNRBBLT8fTZlDpTUjnBNWJDhqZW2VwgUUXqnni9sZKkwfPcpGVTXJb2wX5q2fQmWu5+zJpc/uSLRLWGLLl+xJXr+f26J8L8COzWFwND0Pfs2rGsOBV4iA4vW64yJvCWpvYooPHQi0VLNHCuEl00oRfXjC+OuPs8OmCvJvhppTnGLigoEKIQkcjuibUpaH3sMbD1vEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tDkChyhP8npJsXePdl2tmuGIlYbjpJM1/QNb8TuDBA=;
 b=R7NVgTcTat/D6r1cERta6lCvV09kj5XQ7J5joLG95+39Y2/3vbJ3SYTDE0nNS54N1iLJyExqk2+kyhXY9tQJXZy2AbTUyxvIwEW+qWXZJpeYinX/eVyQYrOMo33zv0Rtt+lkNC+NAGtIzkzzm+pxphqXikLLskJMiIN+wX2bkIe8SchEpYCdVKx7RzYAqF+OFAFlBDGq6xIvMUmQ4jfymg+DUt03unt+CvmrQyR7WoiTpUdWqSqWzVt9VA3ECgIeZ7tp/4A2j+npF0JK6LP7utQRIhHqqAz0AIoLxM8ZXrd2EbNuW9w1+p8TUmjHdzM1boDofmTX6VrbNSTbX0zRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tDkChyhP8npJsXePdl2tmuGIlYbjpJM1/QNb8TuDBA=;
 b=sv6qEWcSEXmd/H0jus9M8dFxS9+9W6/Ig6BbiOpVw6j6A4r9a1syrpaGzT/ACD3KPOPGg5f1zYeu2uVgLURWCv8NZXInTyI99Kq3F3dd8+JT8PXhgO9i0Qbf29y55S9enbXzWhKGOXNiKb+Id3JMbPwxzh9H+sdDrovejWzZjT8mVm/+o2ME+xN+cDWgAiwjZPEEOFCBFj1FgD69LhSBcpqSh+Xa3WvSwZdyc1kRKrrutfFk/2cqSrYu1fymUuzflFPYisBP7ckBkRXWI3DCDIDmuo/vCqtywI+rBSJkZuHHogTpJZ1oRZLD9lBwCTdlX2OycRl2RpV6dJqNQBSyVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 05:46:19 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 05:46:17 +0000
Date: Mon, 24 Aug 2026 13:46:10 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Message-ID: <aovZXTZ26siN8PSQ@MWDK4CY14F>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cb9a38-f5b6-4d53-ac9e-08df01a303ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	umoZ6wkbDnSHb1O/NmNVOgwz4CmiKyrs5MdPGPdpZr0JB6CJJF4OeSCTwJvzfidDVPilTvV3WiRC08FhZrfkAUIu8tJZNdC1jCZXVTsVkr0sGwW+GFBq7VvhUb4BDJIaS/u60ft9FBdS1cbAexYkKWnW0cqXzauf+3H3dAeomuM1Wsp6+dxebfd7yWU9GDRAfPU2C303VCtAef1MFYLAKAUaPuQFVbGR1lJLgfHQSq+yKICRl9iqbKQtVc/cTXTaYng+73S8vz6MK2maUQFXfWvTAoJXrsO+hR2A5Cc7PtNcHIY8T+a8u9t8YtnOBalefl4bzVDgrdjZ+qDm/9IrQV8902HQow1b32aykKPQnfKLsHuXeU0E7qayP0bFG2674odfSO7pJY4az8OXL8qlGhC3NBWve+GAxUmNp2YVTb71VCfuGwnd7ACmAc7KwEAUjc0i7QggHZFgw/KSe+YZ7GBd/tVRSh79H+tkpXpVCS/N9WFs81bsmvcmXnYD1ghDFj3OKaqWAGst4eys/Fol16fFONcXcfA+agvmtRpMRsvz6qiDPFsGJUqZGRA2RthcTxhcfNEQKroP7ExgoRPoBONtJzW1Vt6tBS2gL6xztk7bv/netNbc5rnAxo6xQjTvrywTK6PpY+21NBjDwjDfs3GBp0BQZS5NrJ9jjT+u/3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fE7e31z3WnwUk55EZuBxD4kwh8y60y3Ej9brCMr/bZnqiiy8EJyAf1H8QzND?=
 =?us-ascii?Q?qgrdms1dYPLbdBkAcxOi6O6io0a9K7pCGA/FvAvlAbtWZZr8LspSaYt0JFEo?=
 =?us-ascii?Q?+HYP1a7aL0KwHIwLe2cGZqD+jbIEcMlNrGMa0DpIvRII5qmtmtxlAeFQwzdR?=
 =?us-ascii?Q?7cH06MT+vf/HK1nToOE2U+uF0GAPJS7hzcjeFftaj4wrKxjIYiMtLZF87EWH?=
 =?us-ascii?Q?bU5zE3dbZ6GFQ6SrnQkPBd+PnSd783zZbDRT3QrRl+0d1aRhqRLHvQJWLvx3?=
 =?us-ascii?Q?M4Irx1XsdQk9z8r78K1LcaA04TrsL7PuLp9BDjHDJ69rdr+iFuE44lgy20nc?=
 =?us-ascii?Q?fqBqo/5Ky0j58YQMVaN5q5rk5V1DkK1yEmJB5QpaCDuf+uLplLDIB4mnoVZw?=
 =?us-ascii?Q?sTI+9SOXrwoRzPnE03Y7XwA5gXGTrkSOlnwkgkYfdUcqaspEvB/RF6+u+nvh?=
 =?us-ascii?Q?PEmMVydSITsldhjZwjZasoXl5GwASvXrZOeIR52Fn6Y/GmXrdCyKjT+Mem+O?=
 =?us-ascii?Q?1H8WihT8RrOAmpefwoJBIGj2t5rPvU5CEqsqRCQnm02HKQeGfLcUyX9qiyxi?=
 =?us-ascii?Q?m6CYYCEs87Xe2Rq6eCGzLTQ3HuPKlnZ9gqdK62c2u73z+gO6HTDAMb4gvXje?=
 =?us-ascii?Q?nDsEdMzA32hUgotxSB5T7T2TBV+8ZXEdzgR6VwbuM09VrLstjEQ087PNtquh?=
 =?us-ascii?Q?RyVh1GP/XM3+K+OimcmRIbpVO05jPKqm7NDblDrSm7k7o5JwaqBiH2WDO5fp?=
 =?us-ascii?Q?ASd91re50uQ0mt4KKDrIdWhhIX28QrkOxNeHHM6H/nvz+1QLy9IYFklGWw3K?=
 =?us-ascii?Q?wkl1HZdPmdwji+CEAJuw7cREfLbNO0r/PPPnCUisi8EekZ04+RvxTwWMGEe+?=
 =?us-ascii?Q?8hDWgD8NKy1CnaXqiUXSqQWm7SmUA+gLqnOecCPer6lNlDz3q4n+0/0iMnUW?=
 =?us-ascii?Q?SisqAPi9HjRmIhewVEYwpiQPW7+zKtqqOQks0gHEPidm3jZHlwfQEYQkpCNu?=
 =?us-ascii?Q?CYljVEi0shFOt90tgapQO5t6ST1PCMHeKRtnh2JPTRYGPaJ0yV3nThDGk2A3?=
 =?us-ascii?Q?4hFrduITwSZEKEWYmxWIMfqhU5x1Cb+/WZJdGSpTZgFuUwGXQpxXQbc009I0?=
 =?us-ascii?Q?AIS+TJyyPsNAw2HDuh3wJLHbjBTCRJSTfJk+DDFm8dxJK8M6IMlD25e4W8F2?=
 =?us-ascii?Q?1/bluwzypgDaBbqFBqXqv/wvaaARCkJmpwWVfpM7wRwpb/YtJVMDIXuNj/nt?=
 =?us-ascii?Q?vGJuY7ayG/NEG5NloSiH/NN3YCzEcF4Nn19ba18a/h61r4VlzipO+O6LLDFu?=
 =?us-ascii?Q?atL2O/esYtG8dzDQjF+aSy/Ayo8JZ4Y2EmJev84xFwK6DbbU3LEF6UGH/DWb?=
 =?us-ascii?Q?l22lYuIYY0iwo35MTkZI/AbEWT3YBzIKhNInQhDL/ivd54dOfcigtYbb+nBV?=
 =?us-ascii?Q?KkP2LZq/0GonuAU/SH2+MflxzWH8XcTs410QClqYdwcasmBwnbTHM34a7BYl?=
 =?us-ascii?Q?fs69gR0DBdXguk8655VWq8op2wrtK16OHwwh0eXG8T8HI6WW977WtiygPMmV?=
 =?us-ascii?Q?FT3eMGmRrZdyu800dPTklfXQqSBnGb2161ArgIjMItHQk5tjEF7oCM7B0Air?=
 =?us-ascii?Q?2YwI2dkPl6NcTlb7qnn0Wv1BhnZNd8Fn9htnCpDh8AXxlQmdraTLV2d41RbM?=
 =?us-ascii?Q?339ym/cGe1kRqthE78AROLnysurh97hRuHIBCIPzSBLLujLJzcoGlx/n0nPH?=
 =?us-ascii?Q?7xtXTPY0xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cb9a38-f5b6-4d53-ac9e-08df01a303ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 05:46:17.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bahwHTTh41ptdlQ53toCDZfAIojdDq78IGKl0lMtw9TEEIQQakgS/E2QhWi5naTIlqZnOU/HnWdgUAR6//KoHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

On Thu, Aug 20, 2026 at 04:31:20PM +0800, Alison Schofield wrote:
Hi Alison,

> Endpoint position calculation currently relies on the requirement that
> an interleaving root have the same granularity as the region. Auto
> region creation builds the position by multiplying by each parent
> decoder's ways, while user region creation selects the root target
> with 'pos % ways'. Those calculations are sufficient under the current
> granularity restriction.
> 
> In order to support mixed-granularity regions, that granularity
> restriction will need to be removed so decoder granularity can change
> between levels of the interleave hierarchy. The position calculation
> needs to account for those changes to produce the correct endpoint
> ordering.
> 
> Change the position calculation so each decoder's contribution is
> weighted by its granularity relative to the region granularity:
> 
>     position += target_pos *
>                 (decoder_granularity / region_granularity)
>

This looks correct to me.
Please see the below comment, having a question there.
 
> Use the same relationship to select the root target during user region
> creation.
> 
> For currently supported regions, the new weighted calculation reduces
> to the existing position calculation and produces identical endpoint
> positions.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 60 ++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3b640c9ba5a0..4f367feaf6c8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1805,9 +1805,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
> -	int rc;
> +	int root_pos = pos, rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> +	/* Root target selection advances at root-granularity intervals */
> +	if (iw > 1)
> +		root_pos = pos * cxlr->params.interleave_granularity /
> +			   cxld->interleave_granularity;
> +
> +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
>  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			dev_name(&cxlrd->cxlsd.cxld.dev));
> @@ -1908,13 +1913,13 @@ static int match_switch_decoder_by_range(struct device *dev,
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_gran(struct cxl_port *port, struct range *range,
> +			     int *pos, int *gran)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> -	int rc = -ENXIO;
> +	int ways, rc = -ENXIO;
>  
>  	parent = parent_port_of(port);
>  	if (!parent)
> @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  		return rc;
>  	}
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	*ways = cxlsd->cxld.interleave_ways;
> +	ways = cxlsd->cxld.interleave_ways;
> +	*gran = cxlsd->cxld.interleave_granularity;
>  
> -	for (int i = 0; i < *ways; i++) {
> +	for (int i = 0; i < ways; i++) {
>  		if (cxlsd->target[i] == port->parent_dport) {
>  			*pos = i;
>  			rc = 0;
> @@ -1955,13 +1961,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * @cxled: endpoint decoder member of given region
>   * @hpa_range: translated HPA range of the endpoint
>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * The endpoint position is calculated by traversing the topology from the
> + * endpoint to the root decoder and accumulating the contribution of each
> + * decoder level:
>   *
> - *    position = position * parent_ways + parent_pos;
> + *    position += parent_pos * (parent_granularity / region_granularity);
>   *
> - * ...where @position is inferred from switch and root decoder target lists.
> + * ...where @parent_pos is inferred from switch and root decoder target
> + * lists, and the multiplier is the number of region positions that the
> + * level's granularity spans. A level that selects a single target
> + * contributes nothing.
>   *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
> @@ -1971,7 +1980,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int gran = cxled->cxld.interleave_granularity;
> +	int parent_gran = 0, parent_pos = 0, pos = 0;
>  	int rc;
>  

The "gran" here is using EP decoder's granularity, I think maybe th region
granularity is correct ?

They're normally equal, but in the scenario of normalized-addressing auto regions
they're not.
In that case the EP decoder stays in passthrough mode, for example 1W1/IG256,
while ccxl_prm_setup_root() discover a translated region at IW2/IG4K

For root target 1, this code calculates
1 * (4096/256) = 16

The correct region position is 1, a 2-way region only has pos 0 and 1.

I saw in v3 the regrion granularity was passed into this function explicitly,
maybe I know the reason to make this change if I am missing anything there.

Best regards,
Richard Cheng.

>  	/*
> @@ -1984,20 +1994,18 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  	 *        |    |           |    |
>  	 *       mem0 mem1        mem2 mem3
>  	 *
> -	 * In the example the calculator will iterate twice. The first iteration
> -	 * uses the mem position in the host-bridge and the ways of the host-
> -	 * bridge to generate the first, or local, position. The second
> -	 * iteration uses the host-bridge position in the root_port and the ways
> -	 * of the root_port to refine the position.
> +	 * The region and the root decoder interleave at granularity g, so
> +	 * each host-bridge decoder interleaves at 2g and spans two region
> +	 * positions while the root decoder spans one.
>  	 *
>  	 * A trace of the calculation per endpoint looks like this:
> -	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
> -	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
> +	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
>  	 *       pos: 0                   pos: 1
>  	 *
> -	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
> -	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
> -	 *       pos: 2                   pos = 3
> +	 * mem1: pos += 1 * 2       mem3: pos += 1 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
> +	 *       pos: 2                   pos: 3
>  	 *
>  	 * Note that while this example is simple, the method applies to more
>  	 * complex topologies, including those with switches.
> @@ -2008,12 +2016,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> -				       &parent_ways);
> +		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
> +				       &parent_gran);
>  		if (rc)
>  			return rc;
>  
> -		pos = pos * parent_ways + parent_pos;
> +		pos += parent_pos * (parent_gran / gran);
>  	}
>  
>  	dev_dbg(&cxlmd->dev,
> -- 
> 2.37.3
> 
> 
