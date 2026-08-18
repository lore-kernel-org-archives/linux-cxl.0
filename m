Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3248365A1D
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047288; cv=fail; b=OzH1rpq7zqPQAiTNuztCmFne71Qkv/ZjgHhZab9gDl0UIitFaT7yskMaILtRC8FUJyWx654YxnndtZ3tpQ5nYyRGatMdQBzdJuMUUVgBU0+11JMTsbKIPiCaj6iJSxT6RPiPGdt06yno1veL6GCgspXBWmD3bI6RDoSTb5sUaAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047288; c=relaxed/simple;
	bh=XhEE+tzqStckSeI+ZG0yFp9OhCMqApSiDsTSiMfMSkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JwCmGq3/5SVjVGI76arZ1HkA0rtT7vOJD1uhPVNR/jCKualam5ynciJiA7fwVDQPZZyVYRBseuULh6fWF2QK5rxz4j8J0kXA9QaPOULewLtPkQgrd6Akkduod0P9IVauQ3COJtmmhK5TWPFJ3iCw5FBqBlA6oq8qglbmjEAK+Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwzvdKpB; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwzvdKpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/laE/LJmhMzU8nKQ6iLP7SQ8rDpOGKnfPyODu0mr6WdoxwJD6ArTxoWxRE667W3YUy3R4zqE9Itl+78POlLVfIvFhiMlaPGfe3zs+P4mFOknQVzFQVAjXWITDoIuIkVlju/AjD62OqI+sIYDgEWsL4jgU2fKtxXgfCRlofDqcU5KI1hz8F2NdIpUxa6gzUdo1hXNDWRW47qDK3w5gBzTgxodVDzGlNXoKaJjogKPwLNBjLlaOl41FghiSLav6nZmaU9jXAq2Q7Kq1Gb1jcFf5BBNFsCHxGohNzP/b7gQFavY3mwVbdahFkyo4+bA5Ido0V9Irx7Hkn+Q52MuPz2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFGjMNIGr+V5u7Dbe05XUheSVZ03SZ7NZeu0yUKnIpY=;
 b=JdonZAMOzd05RoXFYOf5zGguJ7Q2DjKvvLWiiOgyENc2IZyHoojQdeB3iNnz1O68T5TphRyO4yDhcQ3FjAX2auzFaJsYE3c9ohY5anvE2C0BnC6708Ht0C+rMTdgQvNKHu/WNlnD/MV1LS3slSRHz7P1OajnG8csmTVbnGsnfRW3uc+TtBIlxmCB5VItMAkYUEhvQAMPqBKtPHHxI047v9s+ybCKV6jo7YQoLlWxSE/mjTgbZnbSTnbNy/QThNroUkSBHsw53MQ34O6XLnWMHy2nYjlB27jIoy4TGhYkL0zKERONGkM/URgBGT+dFHa+R2POi2B2S7CcudPV/RUWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFGjMNIGr+V5u7Dbe05XUheSVZ03SZ7NZeu0yUKnIpY=;
 b=OwzvdKpBu4gSdJT+KU9aiEiludFJ5uNYA0ciRaZLLUQ92lVbTuQ5oP9VAM0orD7+HIrMGvAkDuQuGvyWvaeT8h495l5TSiVsA/19KsGAud8A8A2RuD9d/kytoBZiwLKqFbIydwym00K77e1Jpq16ND4JsI6mIVsfzkRT3NJJ3Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 10:01:17 +0000
Received: from SJ1PR12MB6074.namprd12.prod.outlook.com
 ([fe80::3dee:b690:a008:1bf5]) by SJ1PR12MB6074.namprd12.prod.outlook.com
 ([fe80::3dee:b690:a008:1bf5%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 10:01:17 +0000
Date: Tue, 18 Aug 2026 12:01:11 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 3/9] cxl/region: Derive port granularity from selector
 bits
Message-ID: <aoQtZwK7_cvtl4fR@rric.localdomain>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <efef416440a89a44dfddb13ef390285a98c69cd4.1785444498.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efef416440a89a44dfddb13ef390285a98c69cd4.1785444498.git.alison.schofield@intel.com>
X-ClientProxiedBy: CPCP307CA0006.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::8)
 To DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6074:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e86d9e3-f43e-4fb1-75b7-08defd0fa497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	J/wh9sg0a1E9lpy/ubop0QAkb8oqgIj8HTH/0UL+4eB1btgw6eT8C7LVyKE/NtzeZD0mUslAv/N/8IYdW9PsVD9O8Bx7clRgthlmqdz5ullYvupOKTQDpWkLVEkP5fwfZEkX3P+Vxy0LTqZCuLA1WGS3wOepmkftFLJoXhfnighoq0yYgonFRvDvAWy/fEwzAbN+zHvivVKcChJBYSlWFCLkk7vvf6YnF52TapZ+9M2Y8+gs/xk9YTFtL1FFJbH06JGWvLDpWvviFCco2n1EW52VIJ/ewkXCmM2GH3Y9Ew1gndEZp5R5FCCM4G+VREmhA3fq1K1mDJ5CDnDZmnA6Ub9dq3+yw39antOZCCxey8VevK909wbr/cTLYTEcUcaJHqkep3I54ajPe3t32XfcDDsRcntXhxuxfs273JLCYuzjCOYnw0vyiuVcO1vUMrKqRHxMo9cfM8axwOO1emT41y59F9JaDZcEX38qHslsVfy0FAjG52c/zkslT7br3D+ySVH85u1rUPH8iBw7furv9cLaJ2Mjx7FLNZBIti4TuQk87zerplPJLBWphCYFPivay1Ai+r4Mp28ha7/lYVIg8WS32dP14SGpHWvUqL9xCYzbyZ8uZ92762c9Q3eATg9xeqApoCXMe1xOV9/aB2LQ6KT7JZLHvJdhkM81GPsuFTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6074.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybRaxRqm68JNBC6NbZi37K8OYb+nV25y3CHkoYjU+xuhN+NXOEL/2tetJsTK?=
 =?us-ascii?Q?rf+XijSnz4pBhosjdmoKyY4Ea3PMwcFOX7AExFXbpNsGw7tm/PY+1Wwd5mBx?=
 =?us-ascii?Q?p8ioy8ms/wkh4xoFFYi2d3DzEWAa4mrEDDZhhVf8sfHxq4oPL7reRjimjSLJ?=
 =?us-ascii?Q?2KgQ78Ahnnr1oMMDM8b5sO6DpZwkRCNTPXo4RKLkuClMbmNkVdfGgrtR7m24?=
 =?us-ascii?Q?ehJdxGcrrELbM6y8w4Sud+Wkq4YEIIFhRyw6fCWsgZvbE7N7Kv8IpYrVIVSC?=
 =?us-ascii?Q?fLfA+I+C5C5d78GSoYKAoA3b0QQTbSSY6qx8aEoHTXaTw+X6yCU7rAkEh1ul?=
 =?us-ascii?Q?2bcdhXHIc+8XJdN0l12fm2JcqsVQ+/3iHT2mMwOW4WmgC45yCWKG88+p+1lg?=
 =?us-ascii?Q?Nmz8u/57JT6PsF4TuXLtPvzTcGKSvc1B/P2/zQeTYfCslDtwaecW1PLOe+nM?=
 =?us-ascii?Q?YDnvz5LcUcfzP6y9NVgy1dWQnJgTj2ZiGOLK0YWnUrayceHZpkResgCe2blu?=
 =?us-ascii?Q?S/pKL2/q5EeRUdbhAEpS62ynkWJ30/+teJWuOFInzyh9Bi/cvsC9u+ko9QEz?=
 =?us-ascii?Q?QzfxB2xoukmhgGMGX3JuSAxcbZ+crL/hjtr+pxdThT8i8vtkb4ynXEC9X9zM?=
 =?us-ascii?Q?iq1bnqyO6Z1KZf12ixjOnsY/XKGOfjLkIBcJWsE00G5OOdT/xjd+KEgocmMq?=
 =?us-ascii?Q?CfA4DUrUvmx88nmFORiqavoKS75b8hku/Ujj7g2c56MBhfuHBB4iu+712hU0?=
 =?us-ascii?Q?k9MEiiTf2C7GjAjYHqAYkC0PnBLNOPX6qUkiEsY8uHwX58VpwDV38+A0+5Hs?=
 =?us-ascii?Q?ScqjZjHBBN/UAYWFwq6DyB624CwkhTyWo8cULdsi1tQ1vd9h/Wc9WEzZP2do?=
 =?us-ascii?Q?HdNLJ9yjT8b5GQYlrFuAwosL+bExJ00rejCsdYWHsdonCLuCY2Twe9M4XS4R?=
 =?us-ascii?Q?SqmSaVy7ATbOx92S4iP3dZHMu2wch3MyErfWVPeJ+aYNyRKJF3c5fINksTKo?=
 =?us-ascii?Q?CCVXvz405iK5y5y4xwJXNdGKH0/E33RPF9QhyxGZA55vDdTxrNNa4N2xj/3l?=
 =?us-ascii?Q?iGk+szN4qJbhmGZdRp9BAZkJz/g+T4EztLRyZP5lK83KIIgZ/Ev6ihneEjPq?=
 =?us-ascii?Q?zyHde/TMyqjEqDGlUdEofok32sREcbsiHI2KBXvB/k7ypG2RQkiItO2Go9XA?=
 =?us-ascii?Q?AgUrkwXUW0uV1Qz1uMkbLY0qe7aK79ygP3mOp8oPUvvCFCSj9oe5vjr5o3jS?=
 =?us-ascii?Q?Xsp4K7uyFizRp4qOZOGcmsTT7WwJT9xCLNsKSOR/aPdRo0xp6IXxSzMrCMzM?=
 =?us-ascii?Q?0R4L0Ow723+7SeM4QVwJi7DqkRxSAZwsN4QQGZBTxn3soswCvZRscg0CtsPj?=
 =?us-ascii?Q?bZxJboNZl/T4NBYgt4P7QeuJEu8pYxChU1xd4CaqX8SPrzlwToLKyZ5fy6dJ?=
 =?us-ascii?Q?5rC4XonPFA/ppL94W7rMEeI5+7lr1m5/tLI7v+I0HsFHMI9NIYLWD8MUf/yt?=
 =?us-ascii?Q?bgBbOXExOiozDaa7CYLZeGlQFjT/hbnmUY+0kMWwHpNDwxdcemS5YEenVEB1?=
 =?us-ascii?Q?FvY/HOMUEvH3801DOutQNfhXif3bLpUTvY3L/HZnJ0NAUFCIJ9xS+Zwlv1L3?=
 =?us-ascii?Q?rU9jk46Q+WLgsZUefIXDSlpOT9hnh1h6gYJaBA9BXluwM29xqniWnldHEql8?=
 =?us-ascii?Q?rkW1jSW+w4MRDZi7aMhIeRXEDQfmDk7r/VxhRal+/WHngJ+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e86d9e3-f43e-4fb1-75b7-08defd0fa497
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 10:01:16.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0lswa0aWVOlm1ZXRs5fRPjhDr9B7zp9AKMEsSCljxc17A/DvAp8VupSVGR4XOUymzKWot+w75Ft3G+pf5gBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On 30.07.26 15:20:23, Alison Schofield wrote:
> A user-created region currently derives each port decoder granularity
> from the parent granularity and ways. That recurrence assumes the
> selector bits follow the existing same-granularity ordering and cannot
> derive the decoder settings for a mixed-granularity region.
> 
> Add cxl_region_is_mixed_gran() as the common predicate for regions
> whose granularity is finer than an interleaving root decoder.
> 
> Update derive_port_granularity() to choose each port decoder's
> granularity from the selector bits not already used by its ancestors.
> For auto regions, compare the firmware-programmed granularity with the
> derived value and reject a mismatch.

The only requirement I see here is that firmware programmed selector
bits must be within the endpoint's bit mask (which matches the
region's total ways and gran configuration). The selector and
granularity of a single decoder within the chain may vary, as long as
it is within the total selector and does not overlap with other
decoders. It is not possible to calculate a single correct granularity
value for auto-mode. And in user-mode there are muliple setups and
values possible too, unless there are strict assignment rules given
that only allow a single subset.

> 
> Originally-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 90 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 79 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b0061f03892a..871dedd37cc8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1552,32 +1552,94 @@ static bool region_selectors_fit(struct cxl_port *port,
>  	return true;
>  }
>  
> +/**
> + * cxl_region_is_mixed_gran() - Test for a mixed-granularity region
> + * @cxlr: region
> + *
> + * A region is mixed-granularity when an interleaving root decoder uses a
> + * larger granularity than the region.
> + *
> + * Return: true for a mixed-granularity region.
> + */
> +static inline bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +
> +	return cxld->interleave_ways > 1 &&
> +	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
> +}
> +
>  /**
>   * derive_port_granularity() - Calculate the granularity for a port decoder
> + * @port: port being configured
>   * @cxlr: region under construction
> + * @accum: selectors used by the ancestor decoders
>   * @fanout: product of the ancestor switch ways
> - * @ig: filled with the port decoder granularity
> + * @iw: port decoder interleave ways
> + * @ig: filled with the derived granularity
>   *
> - * Preserve the existing parent-granularity times parent-ways recurrence in
> - * terms of the region granularity and the fan-out above this port.
> + * Select the decoder granularity from the region selector bits not already
> + * used by its ancestors. Same-granularity regions allocate the lowest
> + * available selector bits first. Mixed-granularity regions allocate the
> + * highest available selector bits first so decoder granularities decrease
> + * from the root toward the endpoints.
>   *
> - * Return: 0 on success.
> + * A passthrough decoder uses no selector bits and retains the granularity
> + * implied by the ancestor fan-out.
> + *
> + * Return: 0 on success, -ENXIO when no valid selector remains.
>   */
> -static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
> -				   int *ig)
> +static int derive_port_granularity(struct cxl_port *port,
> +				   struct cxl_region *cxlr, u64 accum,
> +				   int fanout, int iw, int *ig)

This function interface gets really out of control now. You need 5
args to calc the granularity and return 2 values? Something is wrong
here.

I guess we need to change the approach here. Maybe split target setup
for auto- and user-mode. We must simplify the code, I think that is
possible.

Will take a look.

-Robert

>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
>  	struct cxl_region_params *p = &cxlr->params;
> +	u64 selector;
>  	int sel_distance;
>  
> -	sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
> -	sel_distance *= fanout;
> -	*ig = p->interleave_granularity * sel_distance;
> +	selector = get_selector(p->interleave_ways,
> +				p->interleave_granularity) & ~accum;
> +
> +	if (iw == 1) {
> +		sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
> +		sel_distance *= fanout;
> +		*ig = p->interleave_granularity * sel_distance;
> +	} else if (selector && cxl_region_is_mixed_gran(cxlr)) {
> +		*ig = (1ULL << fls64(selector)) / iw;
> +	} else if (selector) {
> +		*ig = 1ULL << __ffs64(selector);
> +	} else {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: no selector bits available for iw %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -ENXIO;
> +	}
> +
> +	if (iw > 1 && (~selector & get_selector(iw, *ig))) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			get_selector(iw, *ig), selector, iw, *ig);
> +		return -ENXIO;
> +	}
>  
>  	return 0;
>  }
>  
> +/**
> + * cxl_port_setup_targets() - Validate and program a port decoder
> + * @port: port being configured
> + * @cxlr: region under construction
> + * @cxled: endpoint decoder being attached
> + *
> + * Validate the decoder's selector placement and derive its interleave
> + * geometry. User-created regions program the derived values; auto regions
> + * validate the firmware-programmed values.
> + *
> + * Return: 0 on success, negative errno on invalid interleave geometry.
> + */
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1635,7 +1697,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		goto add_target;
>  	}
>  
> -	rc = derive_port_granularity(cxlr, fanout, &ig);
> +	rc = derive_port_granularity(port, cxlr, accum, fanout, iw, &ig);
>  	if (rc)
>  		return rc;
>  
> @@ -1650,8 +1712,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (iw > 1 && cxld->interleave_granularity != ig) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s: firmware ig %d != derived ig %d (iw %d)\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				cxld->interleave_granularity, ig, iw);
> +			return -ENXIO;
> +		}
>  		if (cxld->interleave_ways != iw ||
> -		    (iw > 1 && cxld->interleave_granularity != ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
> -- 
> 2.37.3
> 
