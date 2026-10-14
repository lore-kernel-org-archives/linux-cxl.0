Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F984BA1C2
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968573; cv=fail; b=e0Oorlk+pKTDFRGXFQdS+m/Z2KFChaCJ8V7yAq42MNNuIb/dUdzNF4x/gsD4Vl2dVF3h0GXHcDq30LfODiGDV0dP3MlyVgvknkFOFZVNJupkXnHw3tCKAdXttaRwjhPG64wKSuE07vMehrGqTcRCYXAKfmB7LQaxMbAJblXkJHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968573; c=relaxed/simple;
	bh=gIB3Do0XPuug4FZAYBEI2xuxq2PzkW1CEmMT5TkIUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DLeBvX7c2RSboZL+yLVR3xKbBz7WFH4KzrylTEVwxW+8RhCG8IK59Cs5up0PcdMJ/g4nV7DKTx62DPxnP/BzMnxQ7VMpWLH3J3gxZsyJW+uxKNUxk6EF4zyUW0//Lbm1ZPQzqwBa2264pvd/1S/TuXtQOfOHFotMSOh6bFQdatg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L093P1mt; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L093P1mt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moFtGMAaLheHn3c5n+GhC2Ovzj4ptzOhU6IdPqh+u9uFXYiMYyJuBs3OysBkQdUPNhkO4bM+kCdoKJVZhrQNwAgNaCoD/vNuBk5SdEMEILOxAnNhmJ3czBkrQj6H/v0CTdmZW1fp65thjk40EKvC2mqj+mKSHVUr2NHuAe6jl1LZZRzP+3yIP2ho6TG0MADEH5QL9TW7C21zs17iYq6YFZ1oFveZFeodDhtTNCLx4wGq/hFkYwnPKOCZN9FzXajnBOUv1aQb7BSaL71PjIiCtP5oUSEnuzc0C1C4vsM8dtz5o88HPeDolQFFkiqP3tOoCo6gGB8rlSUYQCZ7e5145g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRsqqu1GLv8nuXAd3zvunYQxZldm1N9X9YUlQfi8GpU=;
 b=Nxkd514NuoVANZf9/u5TKYXsgigrG9FWzyBWUe8ikWJY17RnXH8waANRGrwDq9AAzW2H2i+D5X3PlhWzcavGGO8yP0iiB13XMWJDpQ4yAADurgshxF+EMH2/GQlxpz5Iza/qHjD0cF1PHALRDTFUH31BOJspV0RjeSJIZzPOKgh0oUrft1yPIW2GFe725vr58030dIxrCzGAThwa18NkkViAkXkoZew9SE1OEMe5bZ3bFSlyU0T/fTQNE077AdaELgUybb3Q4btu+t5jpjbrDH5R42dVBqkH3P5pU0yU66CXjSkxZ61+07qD6ZKkMHs6zMdp0WqDD5x9zOoZS+wa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRsqqu1GLv8nuXAd3zvunYQxZldm1N9X9YUlQfi8GpU=;
 b=L093P1mtsFeXsakIkTU41Y7lhcSMjid+y0h6JfZrN4CWZfgZgqdYY3Z6192ubzMDLODfQtWL1x7NcObk4Ufykc83HaLM779Q0a+pvpanGwu/pl7ybOjMtxefSXEmRfqyv7MkdvQtbQOwwfzLHtkhbrglWClapaF2mIrMm/2r68Pmzj+xacml4AdDe67wjsABVF6WvWqFex4jBy8uAa2XiYHCXR92GYvrfcqjjLkLGiISS6QqqMcHH7ce8HmH9f9XsVT00bSxUZCTyfykBCJ57lfWydEf8hM1YbHKKIHMhqnogIsc+QLVYePGls6EGowAdgQEA7BI8EWDBRRbkHXNnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 14 Oct
 2026 09:02:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 09:02:42 +0000
Date: Wed, 14 Oct 2026 17:02:35 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/7] cxl/region: Factor out cxl_port_peer_distance()
Message-ID: <as9E1ldLkjpdfTDr@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef91c74-2d1c-4f29-be1d-08df29d1e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	NimhZTi7Z8e/jOnPGmyFv5aDPszTp0Zdwl87lWyG9MDipIpqlRu6OIsqj5O8++Bu2Mr3wQkviqOH8RCRg3jXellldYRFFhYVyD3aeq0GayxRhEdFxJc6qe9OUISUO1Rat/uZmeVPhzK691KrfFASDWTRlKUvjNeqeKNhjktq0ftQEk+hdZs/nqYzKzI7BIPxj3l8TOKL47s5g+AO+oQ6cRKh4Ses9wImKNboCVP7I03YcmuWrUqbn64uqUcS0pNZT6exbgIJZtludCEq64gP6sU3wl81EZmqQXbFi/hfD1Zky7pXjKKISreZN+h1dOufoINmlQHlJril60lStOvSm6vRHKJz3HfzwhhqUWXiSqp46/9NlBD9JDjxG5iXbySurQKShjEqYEgndiHFpn9joYMw11F53Nx6IWWdCb1ByVCRaTi8FricQ5wA8IuOE8D0IzfsuNS334T/2yndPCZfLo2uXGMmyeVDEpUL0PB8l1ToM83xO/wHbroUlUipilONvg+uBgAxZXKNrAK6oJnl+toWXoMu9YfIuy5ChVU+TM+PVBVQqtHh7Iu8gK5SQxXxYALzpBRzWY9/CsfnFOU3T3G6bvyLNfkUOTuwcW+8h8x6RQi1fN46FedlywywPeeSVAMwwF9u0PBcx4m2yQ2ImaHii/js9H/EnI1/9A8FcZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCP8m6Kkrf+cq4B8vlFxJrtBsdD819mrl1qW6pJuPOJKC6S/Swg5rwv8rmp8?=
 =?us-ascii?Q?cDRRuXY9D+MShBPX7XbYLU5r7lf3eJ2eEa2ITqc1EceKN/ePpzmnzoLbc58t?=
 =?us-ascii?Q?0p0UfTd4LCptqyqm24ULWZncVTZAU2QZPj6yY/W9ZIHGs8szn5968vDRZkUx?=
 =?us-ascii?Q?+ztglvvUdXW6u/fACaar6/Z5sjG+adnUdcHU1ejHOp8UOjnbMWGS+qZTyXnY?=
 =?us-ascii?Q?1f3PRWHb2MWAj0Kd7NfC+UhTpZm7Iu9PBVfpqTRP3QFmOJQ355rNSnw6ghcD?=
 =?us-ascii?Q?B9qvS4FAy0jmmKkqSv7F77e7pgjFCo1UTM2OHdjPUvvSUx1ki7uARZj2Ampu?=
 =?us-ascii?Q?8lxIzK0w6uPraHNywenf8IFSUdiMyOQtnNBnvyk7vMGWZRhawrgpgx//ZbOF?=
 =?us-ascii?Q?PHTuLjByxk9KY8DLsOW08P9FyKDFOpli0J4yVrpWLxcA8CiHESRksVrgofnA?=
 =?us-ascii?Q?/LTpwkZbVUGuU4kKikUph0HN0Xc9QWaZBZjRXfyVuMnrlNcWiu+EeiTdpHnK?=
 =?us-ascii?Q?PkUQrrMOndgHq+kw6mAks4259MQdHpsAc61GpnmNGdeSemkgr6rUliMHWXOi?=
 =?us-ascii?Q?LD62cipalW+8i12FGXOiRjsYouSVKB/eiuGTRxWz8GpBnf+38fR2ZOEO8EeI?=
 =?us-ascii?Q?zpTdfEIhGw8ELIkFht/+m52mAxKs7WA08WDQbLT9rfFQT+ovPKhaH/9eBlye?=
 =?us-ascii?Q?0oZnGOiTFqozbj3IxSeVeLE9ptzINMwukW5oAbiOszpuo/HjodFSvq1VfdED?=
 =?us-ascii?Q?JUZh76duRHBLPxIds8TJIwIMRt4CgqyfpWvZqxHcFtyh9ZUoYJGFT1e7Xxpp?=
 =?us-ascii?Q?nfOEPCxS17x/9yhBP+MNuXXBILWxaRMZtmaONprdbqrhJz79rHpdFLVTLIB/?=
 =?us-ascii?Q?2ZLY6c50iTGyNIl9XjPmUD9zTtFzY3DlseaOpQ4dBVviPf5QRmNxtN4aQkA0?=
 =?us-ascii?Q?UNdqafHp74myKDnfFLKaqq5epfGisvgEUlhqmIw2BkTUORFP6Yqya52xTBYY?=
 =?us-ascii?Q?4bohu14C98XPIF/HhwIOOwwZQMtng2oogPkFPx3AHIY4Ppyl4m2V+QuMds0f?=
 =?us-ascii?Q?HlZXjsS9b/6o8t+k0iY/1NuqJIqIl7kz6TD9B9Jmvg6XR4yNPxGE7F0VGuOV?=
 =?us-ascii?Q?MXdmFhx05lSo1YeZlMUlvJYSIhe/xZr5i7ZtpVA89lASmduuXYONqJ6Sedf2?=
 =?us-ascii?Q?GQ99dp86PgebmvB8eo5hNyGt7Y/gmEthGvECGPmuwXrVSEWIzIUgmws9pIHv?=
 =?us-ascii?Q?OJ4UU42pvNk+wDS6o3EzinTwl/eGEetbsuIPec1R/jh0loL/C7mQFlyt0xzI?=
 =?us-ascii?Q?6tsIDysQK6bWrutNk4igsrlE8sDMFxjEj8qrmOsc0U45dnWnKEguyYynmcxO?=
 =?us-ascii?Q?pPK+48BpQd+8AzvfngOPS7Y5PCDj5e5VBuBDnCFAJrZXjyhGM5uFeu6M26Eu?=
 =?us-ascii?Q?pv+jyHhkjKZhTBtnOFNtj2Wrtj37aRRxfbDlBRBW5StK2ChqbjRMXGSckgXV?=
 =?us-ascii?Q?1/vXvwtp0dNkrQplwxVcdYIuCSXdiLuxIc2AI1l4HOilRMlgzlmELC2cD6PR?=
 =?us-ascii?Q?Em1Gs/WKvbEpD+69+WstWsTCygDzfi8WTJix9Bd40If6ZSRH2tqvRY6e/HSK?=
 =?us-ascii?Q?QsFh5uiFeIS1XZO1GzMxwIdTeR1t6bnGYY8BP4m7mTaq74w5m7ee+g2P14Vf?=
 =?us-ascii?Q?zSsQqAlP5Hr5BkeeQourNv94Sm56FOJLaaVf6oxohlnwIYEGvdRUVDvG7tMQ?=
 =?us-ascii?Q?eZSZm8ShGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef91c74-2d1c-4f29-be1d-08df29d1e765
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:02:42.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY1z0UYPRyySbOWnhdJ1YH2DHfhgvTExB7CBfocUxomvwvLn/KsyKpu1iHCVzpIwVw4YeFnTFc0qQ+XEZybs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

On Mon, Oct 12, 2026 at 09:25:59PM +0800, Alison Schofield wrote:
> cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> each step of adding an endpoint to a port's decoder. One of those steps
> calculates the distance between region positions that share a downstream
> port.
> 
> Move that calculation to a new helper, cxl_port_peer_distance().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

This patch inspired me that there might be some space for optimization when
facing different topology, while keeping this one as a generic arithmetic.

I'll try to draft a RFC patch series these days.

Best regards,
Richard Cheng.

> ---
>  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9b0e2f195d1f..ea281ce4ec49 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +/*
> + * The "distance" between peer downstream ports represents which
> + * endpoint positions in the region interleave a given port can
> + * host.
> + *
> + * For example, at the root of a hierarchy the distance is
> + * always 1 as every index targets a different host-bridge. At
> + * each subsequent switch level those ports map every Nth region
> + * position where N is the width of the switch == distance.
> + */
> +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_region_ref *cxl_rr_iter;
> +	struct cxl_port *iter = port;
> +	int distance = 1;
> +
> +	do {
> +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		distance *= cxl_rr_iter->nr_targets;
> +		iter = to_cxl_port(iter->dev.parent);
> +	} while (!is_cxl_root(iter));
> +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +
> +	return distance;
> +}
> +
>  static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  					 struct cxl_region *cxlr,
>  					 struct cxl_endpoint_decoder *cxled)
> @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +		int distance = cxl_port_peer_distance(port, cxlr);
>  
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
> -- 
> 2.37.3
> 
