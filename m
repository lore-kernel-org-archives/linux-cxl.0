Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669ED2698A2
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663155; cv=none; b=AfBpN4J62aeuYXvx1v4I5dxduFenOPWV72ZeCPfPMcG7Wy6e89szyI4EZqSAhLa1AgqmxzITEkmvz4GOJYN4JMuKF2DiXzW+FUMLjbSMAFBlGjDwP1qQ1zD8Nx8cociDjenycTj6fMOLkaYIVSkL1r2D6UTk1GElBkE62VvbQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663155; c=relaxed/simple;
	bh=Pm8XBq3ktgLEzdPM1d6CIBxcwTVP/K9EjKuNLYo0f0Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOl50M4kohXVNll1f5OFInKyl8Q2UObFCkjC2fd8pQ/3lUMLcbhqiFt4fpxHorfcbuKQ/XKC9cW+ZyCHpMGERbUBTaAFv1GBkALjzmanJdyCT0lEwzxKddqpyY70Rvocbgxh+RaNdJc9XYoGiJBltuVoRiNr+e67AG/XQM+4YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtC91cK5z6L531;
	Wed, 16 Jul 2025 18:51:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D561914010C;
	Wed, 16 Jul 2025 18:52:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 12:52:27 +0200
Date: Wed, 16 Jul 2025 11:52:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <20250716115226.000067fc@huawei.com>
In-Reply-To: <28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
	<28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 12 Jul 2025 19:37:55 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add infrastructure to translate System Physical Addresses (SPA) to
> Device Physical Addresses (DPA) within CXL regions. This capability
> will be used by follow-on patches that add poison inject and clear
> operations at the region level.
> 
> The SPA-to-DPA translation process follows these steps:
> 1. Apply root decoder transformations (SPA to HPA) if configured.
> 2. Extract the position in region interleave from the HPA offset.
> 3. Extract the DPA offset from the HPA offset.
> 4. Use position to find endpoint decoder.
> 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> 6. Return the result - a memdev and a DPA.
> 
> It is Step 1 above that makes this a driver level operation and not
> work we can push to user space. Rather than exporting the XOR maps for
> root decoders configured with XOR interleave, the driver performs this
> complex calculation for the user.
> 
> Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> Implementation Note: Device Decode Logic.
> 
> These calculations mirror much of the logic introduced earlier in DPA
> to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> reverse the spec defined 'Deivce Decode Logic'.

Device

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

A few minor things inline. 
> ---
> 
> Changes in v3:
> Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
> Collapse a header comment into pos and offset blocks (Jonathan)
> Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
> Mask off bottom bits in < 8 offset case (Jonathan)
> Wrap code comments closer to column 80 (Jonathan)
> Use a continue to un-nest a for loop. (Jonathan)
> 
>  drivers/cxl/core/region.c | 93 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a2ba19151d4f..404f69864d61 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2956,6 +2956,99 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	return hpa;
>  }
>  
> +struct dpa_result {
> +	struct cxl_memdev *cxlmd;
> +	u64 dpa;
> +};
> +
> +static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
> +						      u64 offset,
> +						      struct dpa_result *result)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_endpoint_decoder *cxled;
> +	u64 hpa, hpa_offset, dpa_offset;
> +	u64 bits_upper, bits_lower;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +	int pos;
> +
> +	lockdep_assert_held(&cxl_rwsem.region);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	if (granularity_to_eig(p->interleave_granularity, &eig) ||
> +	    ways_to_eiw(p->interleave_ways, &eiw))
> +		return -ENXIO;

Why eat return values to replace with ENXIO? I'd prefer

	rc = granularity_to_eig(p->interleave_granularity, &eig);
	if (rc)
		return rc;

	rc = ways_to_eiw(p->interleave_ways, &eiw);
	if (rc)
		return rc;


> +
> +	/*
> +	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
> +	 * CXL HPA is assumed to equal SPA.
> +	 */
> +	if (cxlrd->spa_to_hpa) {
> +		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
> +		hpa_offset = hpa - p->res->start;
> +	} else {
> +		hpa_offset = offset;
> +	}
> +	/*
> +	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
> +	 * eiw < 8
> +	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
> +	 *	Per spec "remove IW bits starting with bit position IG+8"
> +	 * eiw >= 8
> +	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
> +	 *	derived from the modulo operation of the upper bits using
> +	 *	the total number of interleave ways.
> +	 */
> +	if (eiw < 8)
> +		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> +	else
> +		pos = (hpa_offset >> (eig + 8)) % p->interleave_ways;
> +
> +	if (pos < 0 || pos >= p->nr_targets) {
> +		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> +			pos, p->nr_targets);
> +		return -ENXIO;
> +	}
Maybe a blank line here.
> +	/*
> +	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> +	 * Lower bits [IG+7:0] pass through unchanged
> +	 * (eiw < 8)
> +	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> +	 *	Clear the position bits to isolate upper section, then
> +	 *	reverse the left shift by eiw that occurred during DPA->HPA
> +	 * (eiw >= 8)
> +	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> +	 *	Extract upper bits from the correct bit range and divide by 3
> +	 *	to recover the original DPA upper bits
> +	 */
> +

and not one here to keep this grouped slightly more closely with the
code it is talking about.

> +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> +	if (eiw < 8) {
> +		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));

Really trivial but I'd use eig + eiw + 8 - 1 to align with the parameter
order in the comment.  With matching that comment in mind why not,

		dpa_offset = (hpa_offset & (GENMASK_ULL(51, eig + eiw + 8) >> eiw;
(Go long on this line for readability)  Or use 63 if you prefer for the upper
a should remain safe.

Not using hpa_offset for the intermediate value avoid ambiguity about what
the value is at that stage (it's not the hpa_offset


> +		dpa_offset = hpa_offset >> eiw;
> +	} else {
> +		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
> +		dpa_offset = bits_upper << (eig + 8);
> +	}
> +	dpa_offset |= bits_lower;
> +
> +	/* Look-up and return the result: a memdev and a DPA */
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		if (cxled->pos != pos)
> +			continue;
> +		result->cxlmd = cxled_to_memdev(cxled);
> +		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +
> +		return 0;
> +	}
> +	dev_err(&cxlr->dev, "No device found for position %d\n", pos);
> +
> +	return -ENXIO;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static int cxl_pmem_region_alloc(struct cxl_region *cxlr)

