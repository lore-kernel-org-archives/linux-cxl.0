Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063F28468E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775244; cv=none; b=ph2xA/V56UuVbCfoAYiGT7ZakYj9FRiDilR1CuQ8PLF5Lfmda1aKnOFGIaoE5yGhtJZ6IfHHL8jdx2Eeyn5lH10IhgyM7HEjwEc6uVaICdvide0RIw7p/nCeWWj3zZ4yowoGMdCl4cd9wtEQ94E+dZ8w5rH5Zx/DeVwDvtbcGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775244; c=relaxed/simple;
	bh=p5TbWyW7Tc62KGwH1u3fTq7uBRQWv1knvd7SdJsh2mM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFKVbwyVnUCvwcg5n3XG5fzyVpAnZW3q4VvCUJQi35IZ7dCZ3waBP8pVMXJkY2OJPaWehTu7zc6yzHPft69EtClTiAqxIPTebIup/eN1q6kjLJLukXB0+yiR7gFslLnchoplkObze0/wd3TdkTP2HVLmf3AzsABos9Y82bJ4wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRRzh2DC0z6D9C0;
	Tue, 24 Jun 2025 22:24:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 671F11402C3;
	Tue, 24 Jun 2025 22:27:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 16:27:17 +0200
Date: Tue, 24 Jun 2025 15:27:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Introduce HPA to DPA address
 translation
Message-ID: <20250624152716.00004c0c@huawei.com>
In-Reply-To: <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
	<4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 17:53:35 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add infrastructure to translate Host Physical Addresses (HPA) to Device
> Physical Addresses (DPA) within CXL regions. This capability is being
> introduced for use by follow-on patches that will add poison inject
> and clear operations at the region level.
> 
> The HPA-to-DPA translation process involves several steps:
> 1. Apply root decoder transformations (HPA to SPA) if configured
> 2. Calculate the relative offset within the region's address space
> 3. Decode the interleave position using the region's interleave ways
>    and granularity settings
> 4. Identify the target memdev based on the decoded position
> 5. Compute the final DPA by adding the decoded offset to the memdev's
>    DPA base address
> 
> It is Step 1 above that makes this a driver level operation and not
> work we can push to user space. Rather than exporting the XOR maps for
> root decoders configured with XOR interleave, the driver performs this
> complex calculation for the user.
> 
> While not immediately apparent in this diff, broader examination of
> the region.c code shows that this work is basically the reverse of
> previous work where a DPA is translated to an HPA. This is notable
> because it demonstrates that these calculations reuse existing logic
> rather than introducing new algorithms.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

This maths still gives me a headache, but I don't follow at least some of it.
Also I'm missing the application of the XOR Map referred to above.

> ---
>  drivers/cxl/core/region.c | 85 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..d2d904c4b427 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2972,6 +2972,91 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	return hpa;
>  }
>  
> +struct hpa_decode_result {
> +	u64 dpa_offset;
> +	int pos;
> +};
> +
> +struct cxl_dpa_result {
> +	u64 dpa;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +static struct hpa_decode_result decode_hpa_to_dpa(u64 hpa_offset, u8 eiw,
Having a function called hpa_to_dpa that takes an hpa_offset seems inconsistent.

decode_hpa_offset_to_dpa() maybe?

> +						  u16 eig)
> +{
> +	struct hpa_decode_result result;
> +	u64 bits_upper;
> +
> +	if (eiw < 8) {
Could add a spec reference. Other than that, this block looks fine to me.
> +		result.pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> +		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
> +		result.dpa_offset = hpa_offset >> eiw;
> +	} else {

This block isn't lining up for me with what is documented in step 2 of the
implementation note on decoding.

> +		bits_upper = hpa_offset >> (eig + 8);
ignoring pos calc as that is confusingly in a very different place
in the spec, we should have
DPA_OFFSET[51:IG + 8] = HPA_OFFSET[51:IG + IW] / 3 

So I'm missing a shift by IW somewhere.
Perhaps some more comments would help relate this to the maths.

> +		result.pos = bits_upper % 3;
> +		bits_upper /= 3;
> +		result.dpa_offset = bits_upper << (eig + 8);



> +	}
> +
> +	result.dpa_offset |= hpa_offset & GENMASK_ULL(eig + 7, 0);

I wonder if it is simpler to keep a copy of these bottom bits from
before all the manipulation above.  They make it through untouched
but we could avoid the reader having to figure that out.


> +
> +	return result;
> +}
> +
> +static struct cxl_dpa_result __maybe_unused
> +cxl_hpa_to_dpa(struct cxl_region *cxlr, u64 hpa)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct hpa_decode_result decode;
> +	u64 hpa_offset;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +
> +	lockdep_assert_held(&cxl_region_rwsem);
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_err_once(&cxlr->dev,
> +			     "HPA 0x%llx not in region [0x%llx-0x%llx]\n", hpa,
> +			     p->res->start, p->res->end);
> +
> +		return result;
> +	}
> +
> +	/* Apply root decoder translation */
> +	if (cxlrd->hpa_to_spa)
> +		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);

Is this in the right direction?  I was rather expecting opposite of what
is going on in cxl_dpa_to_hpa()

Perhaps separate spa and hpa in here to improve readability with
spa == hpa for the case where we don't have a transaltion.

> +
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +	hpa_offset = hpa - p->res->start;

Given people will line this code up with cxl_dpa_to_hpa() maybe a
comment to rule out subtracting cache_size?

> +
> +	decode = decode_hpa_to_dpa(hpa_offset, eiw, eig);
> +	if (decode.pos >= p->nr_targets) {
> +		dev_err(&cxlr->dev, "Invalid position %d for %d targets\n",
> +			decode.pos, p->nr_targets);
> +
> +		return result;
> +	}
> +
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		if (cxled->pos == decode.pos) {
> +			result.cxlmd = cxled_to_memdev(cxled);
> +			result.dpa = decode.dpa_offset + cxl_dpa_resource_start(cxled);
> +
> +			return result;
> +		}
> +	}
> +	dev_err(&cxlr->dev, "No device found for position %d\n", decode.pos);
> +
> +	return result;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static int cxl_pmem_region_alloc(struct cxl_region *cxlr)

