Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D22EDD50
	for <linux-cxl@vger.kernel.org>; Wed, 29 Oct 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739452; cv=none; b=VG570ivyplWsPAsBbh6lrRnompn5qLN1Ug3wRLfoexc83Ym5sGR0JklixEhNh0lVCRy9DNm7fiSL1NNqJa4XkVm8i17c3bUY6yFo8TjZ1Um5/bpYr9ShhUj9iDXCD+4F+LpDrU1iWDSeBtr4rBSiLPvi5Jh9NqMb3GD2P/Nr6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739452; c=relaxed/simple;
	bh=608Js/tAnNcu+cBMnjay3GscK0409jTFx5hrE5Eh6ws=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uACz8TUrx1Qqm6LYZB1aLqB3zmxLdfpuSS7kLuXzDt2RugLZDlwc1xV/fYor7ejfSj5qO/gxhKRd3ZuCqXmbB6nI/mh/WgH2/NJ+cOwgkicHyXAvywgVYGvPxhd3U2sist7fxD7E9kfbykcmDKIWdDZ015t8nl5pkWTqSlWPtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxQpZ3hJ8z6L4sZ;
	Wed, 29 Oct 2025 20:02:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 98358140136;
	Wed, 29 Oct 2025 20:04:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 12:03:59 +0000
Date: Wed, 29 Oct 2025 12:03:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, "Qing
 Huang" <qing.huang@intel.com>
Subject: Re: [PATCH v2] cxl/region: Translate DPA->HPA in unaligned MOD3
 regions
Message-ID: <20251029120357.000029f1@huawei.com>
In-Reply-To: <20251014062850.727428-1-alison.schofield@intel.com>
References: <20251014062850.727428-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 13 Oct 2025 23:28:48 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL driver implementation of DPA->HPA address translation depends
> on a region's starting address always being aligned to Host Bridge
> Interleave Ways * 256MB. The driver follows the decode methods
> defined in the CXL Spec[1] and expanded upon in the CXL Driver Writers
> Guide[2], which describe bit manipulations based on power-of-2
> alignment to translate a DPA to an HPA.
> 
> With the introduction of MOD3 interleave way support, platforms may
> create regions at starting addresses that are not power-of-2 aligned.
> This allows platforms to avoid gaps in the memory map, but addresses
> within those regions cannot be translated using the existing bit
> manipulation method.
> 
> Introduce an unaligned translation method for DPA->HPA that
> reconstructs an HPA by restoring the address first at the port level
> and then at the host bridge level.
> 
> [1] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
> [2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation
> 
> Suggested-by: Qing Huang <qing.huang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

A few minor inline you might want to tweak a little. 

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> 
> Changes in v2:
> - Add 6 and 12 Host Bridge interleaves to decode_pos() (Jonathan)
> - Limit the unalignment check to MOD3 regions
> - Move the cache_size increment to a single place 
> - Updated some in code comments
> - Rebase on v6.18-rc1 
> 
> Changes in v1 (was RFC):
> - Replace "/" with do_div() to quiet i386 build warning (lkp)
> - Replace 'cxld->interleave_ways' with 'hbiw' for clarity
> - Use div64_u64_rem() for alignment alignment
> - Fix up a printk format specifier (lkp)
> - Update code comments and commit log
> - Rebase on v6.17-rc7
> 
> 
>  drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 140 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e14c1d305b22..3dc6f0ae9f19 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2934,13 +2934,124 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
>  	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
>  }
>  
> +static int decode_pos(int reg_ways, int hb_ways, int pos, int *pos_port,
> +		      int *pos_hb)
> +{
> +	int devices_per_hb;
> +
> +	/*
> +	 * Decode for 3-6-12 way interleaves as defined in the CXL
> +	 * Spec 3.2 9.13.1.1 Legal Interleaving Configurations.
> +	 */
> +	switch (hb_ways) {
> +	case 3: /* Supports 3-way, 6-way, or 12-way regions */

Does no harm I guess, but the comment seems a little unnecessary given
the line that immediately follows!

> +		if (reg_ways != 3 && reg_ways != 6 && reg_ways != 12)
> +			return -EINVAL;
> +
> +		devices_per_hb = reg_ways / 3;
You could drop this out of the switch as

	devices_per_hb = reg_ways / hb_ways;

Then the switch is simply checking for a valid config.

> +		break;
> +
> +	case 6: /* Supports 6-way or 12-way regions */
> +		if (reg_ways != 6 && reg_ways != 12)
> +			return -EINVAL;
> +
> +		devices_per_hb = reg_ways / 6;
> +		break;
> +
> +	case 12: /* Supports 12-way regions */
> +		if (reg_ways != 12)
> +			return -EINVAL;
> +
> +		devices_per_hb = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* Calculate port and host bridge positions */
> +	*pos_port = pos % devices_per_hb;
> +	*pos_hb = pos / devices_per_hb;
> +
> +	return 0;
> +}

...

> +/*
> + * unaligned_dpa_to_hpa() translates a DPA to HPA when the region resource
> + * start address is not aligned at Host Bridge Interleave Ways * 256MB.
> + *
> + * Unaligned start addresses only occur with MOD3 interleaves. All power-
> + * of-two interleaves are guaranteed aligned.
> + */
> +static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
> +				struct cxl_region_params *p, int pos, u64 dpa)
> +{
> +	int ways_port = p->interleave_ways / cxld->interleave_ways;
> +	int gran_port = p->interleave_granularity;
> +	int gran_hb = cxld->interleave_granularity;
> +	int ways_hb = cxld->interleave_ways;
> +	int pos_port, pos_hb, gran_shift;
> +	u64 shifted, hpa, hpa_port = 0;

Trivial but I really don't like mixing assignment and non assignments
in these.  Also can reduce scope of hpa and shifted which is probably a good
idea for readability.

> +
> +	/* Decode an endpoint 'pos' into port and host-bridge components */
> +	if (decode_pos(p->interleave_ways, ways_hb, pos, &pos_port, &pos_hb)) {
> +		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
> +			p->interleave_ways);
> +		return ULLONG_MAX;
> +	}

Trivial but I'd put a blank line here if you end up respinning.

> +	/* Restore the port parent address if needed */
> +	if (gran_hb != gran_port)
> +		hpa_port = restore_parent(dpa, pos_port, gran_port, ways_port);
> +	else
> +		hpa_port = dpa;
> +
> +	/*
> +	 * Complete the HPA reconstruction by restoring the address as if
> +	 * each HB position is a candidate. Test against expected pos_hb
> +	 * to confirm match.
> +	 */
> +	gran_shift = ilog2(gran_hb);
> +	for (int index = 0; index < ways_hb; index++) {
Why not just i for the index?

		u64 hpa = restore_parent(hpa_port, index, gran_hb, ways_hb);

> +		hpa = restore_parent(hpa_port, index, gran_hb, ways_hb);
> +		hpa += p->res->start;
> +
> +		shifted = hpa >> gran_shift;
> +		if (do_div(shifted, ways_hb) == pos_hb)
> +			return hpa;
> +	}
> +
> +	dev_dbg(&cxld->dev, "fail dpa:%#llx region:%pr pos:%d\n", dpa, p->res,
> +		pos);
> +	dev_dbg(&cxld->dev, "     port-w/g/p:%d/%d/%d hb-w/g/p:%d/%d/%d\n",
> +		ways_port, gran_port, pos_port, ways_hb, gran_hb, pos_hb);
> +
> +	return ULLONG_MAX;
> +}
> +


