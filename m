Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF24A7C97
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581850; cv=fail; b=TjgPR6rbx84dRd69gklo+T1tyLZMagJ2AzPqqILTdwV41cgWUfcqmSv8DsOPV1MQ7j5ju1muRh5r/VI3dtVhLaqDY/UIBPrbKI4r+T9bIjETuMjKYDFyqjPzn5tEi7xoB0UTK2D5JbiUPjiDmixoUgVfEnu6uGqcvre9+oilcVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581850; c=relaxed/simple;
	bh=hOAxaT923sRTej1hR3+KiJQEpYlpBLGmI2aMdJDZXxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D6g3Gn5hpd6Tz5PoOdplgH4KkZ8J8j5b7Hc/sNrLDBJVfuGG6sRFTZwWbGoXhAG/BoXs0Iz4TOlB0Q8ATzh9hvE/2iFIKWlm+9+ebMtUoklOaJuzpzdlUjfjhyJ/ffCQriCMyOLB1W9HE+mMYT9Q+vpih/fLs/dyvMh7zjgYnQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBqzfn21; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBqzfn21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8CP9z+qQ4IWPluhKhjveU0c+IDGCvFLiqTEz2QyulhspDsvoLlZNe/i8gqlo8Yz7J7SetYOA+R3513tCAgU1RV7n9tRb7RCRyY2mCMX4cu4dWwPp38knjcPZH5pVllbsuubfkfOetfrLpJmqRjv25zLgx6k061jhBqXckh4/hf9XKrTBbpYN1+lYiaGB4NGZqXamv3xt+mY0OjX3A14zKOyO6NrhgnfpWNJt0rsvaeOnCz9ie79QE+ggzyQ/qUrktMS+ehIOsCxGHonwEs2mJZ1FzU1HHBGoMKb4C3TIx0NmlSNg+a+FKcF/S7VQtmv6DLQQH0VRRBeM/VFfBN02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kfCGDKi5lsjvOW9Flg9RqggDG/Srg2wGhE7IkegMfA=;
 b=jXdnpB153wxG6/6fidgyBDs6NPxTyufy4oEtQ4YgnUbbBNa74oKdbaomUm2VI2rsS/NdCJ3EYD9bnsEB3HIeeKyxQxuL+GReJPI39aiot967Yxus0OXxGEl6YVH8eVpxSVLjnq2S+05OxPcLNYTT/Rono2bwHlTf0QOyd+R2PEQ534XVoEamT9hgkJXzN8TL1S7h5zS0AO2gfpS9NZFcnGRvHwNeApQDbqlokbRT3L+O4EnMTcxD0SLQJbPBYPsAZrydJPhGMeckBu8CIYUFAP05s7G0cvgbrade5ZZyXtCKg/7V38KJHNi1nDpOHJI8WMQniFZ1elILbRsihmZN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kfCGDKi5lsjvOW9Flg9RqggDG/Srg2wGhE7IkegMfA=;
 b=EBqzfn215GA5W35kEOKgSo7Ooyc6xK5DOQ3CYWpMrA/m/2CGC44jnEZooCEvLO8iuJ9ZbwNJO8sDnq21wX7igwBpIiYSXl7jACFz9fxfPt2Ny/wKrQ92WCzoWY5veChDzTUSq/rjvg1qs2AaQ5yN9CReXeHpTEkqMCAfL7D0Bhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.10; Wed, 16 Sep 2026 18:03:49 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 18:03:48 +0000
Date: Wed, 16 Sep 2026 20:03:43 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 5/7] cxl/region: Support mixed-granularity auto regions
Message-ID: <aqrZ_3deL8WWWiNF@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <4ff59676f6db40e86749ebc810ead8ddfd3d3366.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff59676f6db40e86749ebc810ead8ddfd3d3366.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::9) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 696d2649-7ed2-453d-f3f7-08df141cdb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4AHfe8fZe8BbmjmNyDaKFJKY5XI3BngLaUCRApP59nWPORmU2LIRsdI1k8ut5XoMS/UBbAXeg4rtZ0nRUs0hzo8RrsZNmb+e6l0EXkJMratQJV7k1nSHrL6XozV0XH6FCAFIGRUqG58coauj1wvR0vPGR6jBIn3WrEhL12rO3fP9l5nknCb1lytuH6hoz76O30mWMQLX4FL3zXwtN/9pT4UgPOT8sm48796dJVuWHa8SwNtfNF/gC7YK2e4jRccWL6Qsl1BYaXo11BzgtzRqlx/d0VvVvBAX6Zljpq6QJ7sp7yxI+3t3ivB8HU+Se6xwk+cYdHolL1ORbypvuolZhQeO0fmRlLg6P2h96p2M2CEqPLPvzdILSCFBSwW/C5AbA2p09v+jKMlTcsCF3WQtE7vaucVUcJUlGqQLdTSSc+UoobCtFZhFZTdUClJnS61n9C/BZQH72SawRJMiKsDvyCwQELeMhuOmzCcR4sU3Mx6w/Rie8VolTxNdHi6hBuBTRWm5UMmXDNHG7uhpw25MPIL9i5B49e/kbfUlVg2w7VcftK7Ar/zGCjutTKAgaIZnBURPk5MeuHinksH0sfLng3IroN7n3K768pBLGTbfDnnatlHu+3B3dhkv0noX/nv0+SNUc+dAtLR+55UBPChIASL6YA6lIncb8XLJPyUtndg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oiVoSsnjUINweWH47unNHiKSiR4maBHmVlP0mWCRQv3yPVhbxubmxm7XkOik?=
 =?us-ascii?Q?s7EYhkJCpCwh5pJc5E0jfwjrUePkfKiH1KuOoyo0EMsf65T1ePH0AvJBn5CK?=
 =?us-ascii?Q?Mc3aZbvBNLug8ziX0oDrCUBQSevRG6Dpa6sgZlLWOc+wNyZOKbU2pDzQ9f6h?=
 =?us-ascii?Q?k9US7DEsGeMD8lWGmyjBm6kKglnXypMjEniOLDXkLSH9x35mh99diEkXmlid?=
 =?us-ascii?Q?fbQ8viPt+Q3oWbrPBHzF4z3Kujq/hJnQuE6u8SaBzGYvtXFsNq66gsQ6wty8?=
 =?us-ascii?Q?YdFT6xH3vQKhV3W+ccIRX0+8CpJF7CMYVGR2R4rpQ6cOheEdgaCSVY62Zlex?=
 =?us-ascii?Q?Y0NcK05AL+JK6gxbNafJ5PBP4W/S3a8TPEqcrPaU7vobAlaYbVfC4SJ5f+dC?=
 =?us-ascii?Q?KHE7z1i5c2gAg498NbZCBGrgcpbO3HyNSFzYH8TtoVMLa3X5TKyjxMk7qTST?=
 =?us-ascii?Q?57s3mFMbRL23I+LaixicjfoIlhGy8AZjAlAt4QotYio7N0zcT7hclLqD1NfY?=
 =?us-ascii?Q?O3JD2GesYH9wowC7h5RghEa2rXfVA5bGCgbiwl1O9vzADak/zeIupjCibmow?=
 =?us-ascii?Q?XFaCkd52moqBcDXsV6TM82OJJDZLsXkiB3qyiU/M/44u9QVO1yTFjf7u7aFJ?=
 =?us-ascii?Q?cNHLb7dkIOrKKRynfbJJbk4zMKgU6SZJ37Tp6OVwjfHJ1sW2HTK2TDit7vqT?=
 =?us-ascii?Q?yLnLeYHNqSwk34Uzhx9f5/x6eDNKwN7Pty5ppqhYZ/pR+8pH+U328Hd1W8n0?=
 =?us-ascii?Q?iH0ksA5s9igcNM4TDHeWGG3nRTfshQL3dvWFFj7oR3fUwVWmjS0adUlpY0j4?=
 =?us-ascii?Q?mjITz9Eim69byR6d5rrNpFZq4WwukoOoO6FRoqPfZYbQtXA/W11vMpyVo5D+?=
 =?us-ascii?Q?M0sMth3RXAH1U31EqpZR5vhxoriaJpu0MqB+ibxlKaYrSw6nN/iOy7eRDTIM?=
 =?us-ascii?Q?6WTm/08EmBKJ3V1fT9WqgwWFuWQuNwO3S8x8kIB2CH/hfVxB1vARkrUNPPZo?=
 =?us-ascii?Q?n4JQ80oZQhZdWslGuoe0pNQXComK7TflVWcE7Hiut5bdwJ/I590xLkZZMtOe?=
 =?us-ascii?Q?zWeKC/e3sk2ONmyI3pdIv8B72Ce7KWj0OF2xxsQICHxc7mYX5yoq0qgHSao/?=
 =?us-ascii?Q?m6YOwVzfloc9vo5yeR/WeagGTsJJk9qQWvwPuq7uj9Hw4qw4LnK3h1TUTFy/?=
 =?us-ascii?Q?/WGUxetGlMv+d2Nis+XVR2QD2nI2+vxScvf9Gt9ybSW4sxrUKq1HUuC/XI38?=
 =?us-ascii?Q?cjJ5aNlx2+VtHiygOQ/FuGqV9lJ2ojVpEG/t63c4/GBNZnSYBcGHLf0lxdPQ?=
 =?us-ascii?Q?Z1o79zDE5MFuEHSvh8JTir8ogPqe1iaGAl3AIugnXksP6v6+/xznNe0MddrJ?=
 =?us-ascii?Q?s+a0mNYEwb+AlaJwS9M8IRdes2gvDRXmOcT+EuzjxINt/pEJM6XAK3rn1CRy?=
 =?us-ascii?Q?iNJLZXaNfh2ApI4Pso8Yo2eWJYy1F/2gTsPGpWCGu5Ipqk2v96fwWpsXKe7n?=
 =?us-ascii?Q?AqbsFE+f5B7O7oci9pbggtrK/99gP9bGoCD1eXC2mOyVi+zqOcjG64+woiTo?=
 =?us-ascii?Q?Iv4BLyBbrudpJ/7RF5zuBn2nkckARzMltw3yb7nwF9d67kVV1Sky4boVmAPS?=
 =?us-ascii?Q?KriH7hZKi+0IFoERAfe1EfvdKLO31pRBFSMKHhHas5I8xyafFOwYuxcQdqLz?=
 =?us-ascii?Q?utYxvxWQN49xdELMSeDjqoqTVKKSEzU+TE7Eng4C8lO+JLPh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696d2649-7ed2-453d-f3f7-08df141cdb66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:03:48.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKbJ9U3rvnU9BA5Xfvt9opuzGROwQ7HUpbW6xgyvj4ElimkO04qbB0Er2/oc4pyHnJEU3UQVAVjqomGmjn+X+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

On 03.09.26 16:23:47, Alison Schofield wrote:
> The CXL Specification permits a region's interleave granularity to differ
> between levels of the decoder hierarchy. For an auto region, the CXL driver
> reconstructs that hierarchy from the decoder configuration programmed by
> platform firmware.
> 
> The CXL driver currently requires the interleaving root to have the same
> granularity as the region, with each successive interleaving level becoming
> coarser toward the endpoints. A mixed-granularity region lifts that
> requirement: its interleave granularity is finer than the granularity of
> its interleaving root decoder. The driver cannot assemble such a region
> today.
> 
> Support mixed-granularity auto regions in the CXL driver, restricted to
> coarse-to-fine layouts. Derive each interleaving decoder's granularity from
> its parent:
> 
>         child_ig = parent_ig / child_iw
> 
> A same-granularity region keeps the existing derivation, which coarsens
> toward the endpoints:
> 
>         child_ig = parent_ig * parent_iw

This is the implementation specific limitation. Either buttom-up or
top-down.

> 
> The topology determines each decoder's interleave ways, so the parent
> granularity and child ways determine the child granularity. Use that
> relationship to validate the decoder geometry while assembling an auto
> region. Only the interleaving levels are compared; a passthrough level,
> child_iw == 1, keeps its granularity exemption.

Tracking selector bits is order independent.

> 
> Refuse a derived granularity finer than the region granularity. Dividing at

Yes, that is a general requirement as otherwise the combined
interleaving configs would never match the region.

> every level lands the deepest interleaving level exactly on the region
> granularity, so a finer value means the topology below one port is deeper
> than the region interleave has positions for, which happens only when
> another branch is too shallow to cover its share. That is what rejects an
> unbalanced tree below the interleaving root.

In general, unbalanced trees could work if all endpoints of the same
region end at the same level. Else, Endpoints would have different
granularities depending on their levels.

> 
> Require the root and region to interleave over the same span, the address
> range in which the interleave pattern completes one full pass:
> 
>         root_iw * root_ig == region_iw * region_ig
> 
> The same span relationship covers the CXL Specification's Mod3
> configurations. For example, a 6-way region at IGB across three host
> bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave at
> IGB below it, as described in CXL 4.0 Section 9.13.1.1.

Looks correct for Mod3 configs. Then, all the hpa bits above are used
to determine the host bridge interleave position. And else, the same
bits would be used again for subsequent interleaving levels causing an
invalid position (in the CXL spec, CFMWS Structure, Interleave Target
List).

But for factor-of-2 only configs that requirement is not valid. Bits
above HBIG and ENIW could be used at lower levels. Let's see the
checks added...

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 128 ++++++++++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 116f84bb0745..5b7104a55fdd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1435,6 +1435,15 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +/* Mixed granularity has a region IG finer than the interleaving root IG */
> +static bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +
> +	return cxld->interleave_ways > 1 &&
> +	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1448,7 +1457,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>  	u16 eig, peig;
>  	u8 eiw, peiw;
>  
> @@ -1464,26 +1472,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	child_iw = cxl_rr->nr_targets;
> +
>  	if (cxl_rr->nr_targets_set) {
>  		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
>  
>  		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> +		 * @distance is the spacing between region positions sharing this
> +		 * dport. Mixed-granularity regions place them contiguously.
>  		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +		if (!cxl_region_is_mixed_gran(cxlr)) {
> +			struct cxl_region_ref *cxl_rr_iter;
> +			struct cxl_port *iter = port;
> +
> +			do {
> +				cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +				distance *= cxl_rr_iter->nr_targets;
> +				iter = to_cxl_port(iter->dev.parent);
> +			} while (!is_cxl_root(iter));
> +			distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +		}

Worth moving that to a helper.

distance == 1 in the other case? Add to comment...

>  
>  		for (i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> @@ -1497,15 +1505,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	if (is_cxl_root(parent_port)) {
> -		/*
> -		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG != region IG.
> -		 */
> -		parent_ig = p->interleave_granularity;
>  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> +		/*
> +		 * A non-interleaving root does not contribute to the region
> +		 * interleave.
> +		 */
> +		if (parent_iw > 1)
> +			parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
> +		else
> +			parent_ig = p->interleave_granularity;

Finaly this calculates iw and ig. Can that code (including the next
part below) moved out to a function. Possibly the various code paths
could be simplified for the different cases and checks be centralized
for all of them.

>  		/*
>  		 * For purposes of address bit routing, use power-of-2 math for
>  		 * switch ports.
> @@ -1538,7 +1546,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	child_iw = cxl_rr->nr_targets;
>  	rc = ways_to_eiw(child_iw, &eiw);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> @@ -1546,23 +1553,25 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> +	/* Only mixed-gran regions refine granularity toward the endpoints */
> +	if (cxl_region_is_mixed_gran(cxlr)) {
> +		child_ig = parent_ig / child_iw;
> +
> +		if (child_ig < p->interleave_granularity) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s: granularity %d is finer than region granularity %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				child_ig, p->interleave_granularity);
> +			return -ENXIO;
> +		}
> +	} else {
> +		child_ig = parent_ig * parent_iw;
>  	}
>  
> -	rc = eig_to_granularity(eig, &child_ig);
> +	rc = granularity_to_eig(child_ig, &eig);
>  	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), child_ig);
>  		return rc;
>  	}
>  
> @@ -2061,6 +2070,43 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_validate_interleave(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int root_iw = cxld->interleave_ways;
> +	int root_ig = cxld->interleave_granularity;
> +
> +	if (root_iw == 1)
> +		return 0;
> +
> +	if (p->interleave_granularity > root_ig) {
> +		dev_dbg(&cxlr->dev,
> +			"granularity %d exceeds root decoder granularity %d\n",
> +			p->interleave_granularity, root_ig);

This is a valid case for the non-Mod3 case.

> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Same-granularity regions below a power-of-two root may span multiple root
> +	 * interleaves. Mod3 roots are width-matched instead.

What about the other power-of-two root configs? Comment suggests the
check is just for Mod3, but those other configs "fall through" too.

> +	 */
> +	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
> +		return 0;
> +
> +	/* Span is one complete pass through the interleave pattern. */
> +	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
> +		dev_dbg(&cxlr->dev,
> +			"region span %d (%d ways at %d) must equal root span %d (%d ways at %d)\n",
> +			p->interleave_ways * p->interleave_granularity,
> +			p->interleave_ways, p->interleave_granularity,
> +			root_iw * root_ig, root_iw, root_ig);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -2103,6 +2149,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	rc = cxl_region_validate_interleave(cxlr);

maybe name this check_root_interleave and pair it with
check_interleave_cap? Function is "check" only. Will be easier to get
the function's purpose. Maybe, move it up.

I rather like to have a check close to the code it is actually needed
for. That makes it more reasonable.

-Robert

> +	if (rc)
> +		return rc;
> +
>  	if (p->nr_targets >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
>  			p->nr_targets);
> -- 
> 2.37.3
> 
