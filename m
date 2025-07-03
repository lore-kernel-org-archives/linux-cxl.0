Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBD2EA145
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552610; cv=none; b=e1qNFfRk4dmTeepQ0DNVEws1PIDF/dtwFNy3wpMWJ8zXqejPP3Nz/gWmCXqG+0HOZscqpWL9oWN3K0Bmcw9X+4X++amj8kv1EoNgmJvVACk9EJMJzJ43+F+8hnMYomyTeWUdt08O6yRA06ly/Ygo9NavGk5gbZWKH4qs/Mrya1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552610; c=relaxed/simple;
	bh=f7SVVYzcMpRRGELBRZrQBRgJkQ6R9JLeeLn3eZVcc60=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNeirB4bryuMfM80yaKN9QHq6WoltaT0YV3Y9YU1KtAkTRoxVpyMYlf34XyNq0RqWFYu/kbFgAXgLbOnKbpTqLhm4P9bEe/tgHnCN3CwOiv7uUhRLrl5aXQLi4LnAYoCXnadNXolrcZIzmiDE9iAWRrdq4rEUKE2MUF0+pvfptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXzVq5TXgz6M4rc;
	Thu,  3 Jul 2025 22:22:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EF1FB140371;
	Thu,  3 Jul 2025 22:23:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 16:23:24 +0200
Date: Thu, 3 Jul 2025 15:23:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <20250703152323.000069f6@huawei.com>
In-Reply-To: <b3216602850003d06016f4735246b5d4f9fdd643.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
	<b3216602850003d06016f4735246b5d4f9fdd643.1751513505.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  2 Jul 2025 21:03:21 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add infrastructure to translate System Physical Addresses (HPA) to
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
> reverse the spec defined steps. This case is not the reversal, it
> follows the device decode logic per the spec.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v2:
> Shift by (eig + eiw) not (eig + 8) in MOD 3 interleaves (Jonathan)
> Simplify bottom bit handling by saving and restoring (Jonathan)
> Calculate the pos and dpa_offset inline, not in a helper
> Use the new root decoder callback for spa_to_hpa()
> Use div64_u64 instead of / to fix 32-bit ARM (lkp)
> Use div64_u64_rem instead of % for arch safety
> Pass pointer to results structures (DaveJ)
> Add spec references and comments (DaveJ)
> Add validate_region_offset() helper
> 
> 
>  drivers/cxl/core/region.c | 100 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a2ba19151d4f..d965f07ba8a8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2956,6 +2956,106 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
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
> +	u64 shifted, rem;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +	int pos;
> +
> +	lockdep_assert_held(&cxl_rwsem.region);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	ways_to_eiw(p->interleave_ways, &eiw);

Maybe exercise paranoia and check return values from this

> +	granularity_to_eig(p->interleave_granularity, &eig);

and this.  That would mostly be to avoid reviewers having to
consider if errors are possible rather than because we think
we can get any.

> +
> +	/*
> +	 * If the root decoder has SPA to CXL HPA callback,
> +	 * use it. Otherwise CXL HPA is assumed to equal SPA.

Short wrap.  Go nearer 80 chars.

> +	 */
> +	if (cxlrd->spa_to_hpa) {
> +		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
> +		hpa_offset = hpa - p->res->start;
> +	} else {
> +		hpa_offset = offset;
> +	}
> +	/*
> +	 * Extracting the interleave position and the DPA offset
> +	 * is based on the steps defined in CXL Spec 3.2 Section
> +	 * 8.2.4.20.13 Implementation Note: Device Decode Logic

Also rather short wrap.
	 * Extracting the interleave position and the DPA offset is based on
         * the steps defined in CXL Spec 3.2 Section 8.2.4.20.13 
	 * Implementation Note: Device Decode Logic

probably better.

> +	 */

Comment next to comment is a bit ugly.  Maybe combine them or stick a blank
line in between.

> +	/*
> +	 * Interleave position:
> +	 * eiw < 8
> +	 *	Position is in the IW bits at HPA_OFFSET[IG+8+eiw-1:IG+8].

Odd combination of IG and eiw in these comments.
I'd either go with spec terms IG and IW or kernel eig and eiw

> +	 *	Per spec "remove IW bits starting with bit position IG+8"
> +	 * eiw >= 8
> +	 *	Position is not explicitly stored in HPA_OFFSET. It is
> +	 *	derived from the modulo-3 remainder of the upper bits.
> +	 */
> +	if (eiw < 8) {
> +		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> +	} else {
> +		shifted = hpa_offset >> (eig + eiw);
> +		div64_u64_rem(shifted, 3, &rem);
> +		pos = rem;

Same as:
	
		pos = shifted % 3;

How does this work for 6 or 12 way?

> +	}
> +	if (pos < 0 || pos >= p->nr_targets) {
> +		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> +			pos, p->nr_targets);
> +		return -ENXIO;
> +	}
> +	/*
> +	 * DPA offset:
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
> +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> +	if (eiw < 8) {
> +		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
Bottom bits already established, so I'd mask out all the top part.

		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));

As you have it here I think you leave lower bits in place and or them with
themselves.

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

It's getting a little deeply nested so maybe

		if (cxled->pos != pos)
			continue;

		result->cxlmd = cxled...
...

		return 0;
	}

> +		if (cxled->pos == pos) {
> +			result->cxlmd = cxled_to_memdev(cxled);
> +			result->dpa =
> +				cxl_dpa_resource_start(cxled) + dpa_offset;
> +
> +			return 0;
> +		}
> +	}
> +	dev_err(&cxlr->dev, "No device found for position %d\n", pos);
> +
> +	return -ENXIO;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static int cxl_pmem_region_alloc(struct cxl_region *cxlr)

