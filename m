Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8027BF84
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669546; cv=none; b=eWw1Xt+PKjCVRVMdauTvBr78xRfv6PbdJyRjBDo0eTYQy9zfH9hZliHu/55298GXvAGykK5xANUyvizA8RgJd9ki0+19spV9Wcc1+aNSpHEP2MeYPZwNiIVTdNG+jSFcw78qpBcBzcUPCCDK0tnfUsWEwNeaxCkfW0vcglBOT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669546; c=relaxed/simple;
	bh=PTzI6MgieYN0FHTkKSjTRDfUEurYd80VxELjXugCDk0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRD1x1szycda9OyVDYvDxpKYtt+ieKJ8CiugOMQJoXH8qbvNHiZmHavhfLQvsLyg+6lCwrjhuJkIiBLM7vtWjKJWEZ6qGuX9pv3YsBRe0gcXjpyp9Yi0yKTbg4rByRjIizcsJbBJbgrC9ccsMwD4Yb8E/t/XZnEE85zvtaQqmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz87d2y7bz6L50f;
	Sat,  9 Aug 2025 00:07:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A1B3C1402F3;
	Sat,  9 Aug 2025 00:12:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 18:12:20 +0200
Date: Fri, 8 Aug 2025 17:12:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/region: Refactor address translation funcs for
 testing
Message-ID: <20250808171218.00003c57@huawei.com>
In-Reply-To: <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
	<d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
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

On Mon,  4 Aug 2025 01:52:39 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for adding a test module that exercises the address
> translation calculations, extract the core calculations into stand-
> alone functions that operate on base parameters without dependencies
> on struct cxl_region.
> 
> This refactoring enables unit testing of the address translation logic
> with controlled inputs, while maintaining identical functionality in
> the existing code paths.
> 
> The moved code has only one change. In the new cxl_calculate_position()
> eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
> since the new function cannot depend upon struct cxl_region_params.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

A few comments.  In general looks fine to me.

>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> -	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> +	u64 dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -2965,19 +3043,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	/* Remove the dpa base */
>  	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
>  
> -	mask_upper = GENMASK_ULL(51, eig + 8);
> -
> -	if (eiw < 8) {
> -		hpa_offset = (dpa_offset & mask_upper) << eiw;
> -		hpa_offset |= pos << (eig + 8);
> -	} else {
> -		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> -		bits_upper = bits_upper * 3;
> -		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> -	}
> -
> -	/* The lower bits remain unchanged */
> -	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +	/* this chunk was moved, maybe move comment too */

No idea what that refers to!

> +	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3011,8 +3078,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_endpoint_decoder *cxled;
>  	u64 hpa, hpa_offset, dpa_offset;
> -	u64 bits_upper, bits_lower;
> -	u64 shifted, rem, temp;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3034,50 +3099,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	} else {
>  		hpa_offset = offset;
>  	}
> -	/*
> -	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
> -	 * eiw < 8
> -	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
> -	 *	Per spec "remove IW bits starting with bit position IG+8"
> -	 * eiw >= 8
> -	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
> -	 *	derived from the modulo operation of the upper bits using
> -	 *	the total number of interleave ways.
> -	 */
> -	if (eiw < 8) {
> -		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> -	} else {
> -		shifted = hpa_offset >> (eig + 8);
> -		div64_u64_rem(shifted, p->interleave_ways, &rem);
> -		pos = rem;
> -	}
> -	if (pos < 0 || pos >= p->nr_targets) {
> -		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> -			pos, p->nr_targets);

Bit of a shame to loose this debug print if we hit this condition.

> +
> +	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +	if (pos < 0 || pos >= p->nr_targets)
>  		return -ENXIO;
> -	}
>  
> -	/*
> -	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> -	 * Lower bits [IG+7:0] pass through unchanged
> -	 * (eiw < 8)
> -	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> -	 *	Clear the position bits to isolate upper section, then
> -	 *	reverse the left shift by eiw that occurred during DPA->HPA
> -	 * (eiw >= 8)
> -	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> -	 *	Extract upper bits from the correct bit range and divide by 3
> -	 *	to recover the original DPA upper bits
> -	 */
> -	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> -	if (eiw < 8) {
> -		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
> -		dpa_offset = temp >> eiw;
> -	} else {
> -		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
> -		dpa_offset = bits_upper << (eig + 8);
> -	}
> -	dpa_offset |= bits_lower;
> +	dpa_offset = cxl_calculate_dpa_offset(hpa_offset, eiw, eig);
> +	if (dpa_offset == ULLONG_MAX)

How do we get ULLONG_MAX?  Not obvious that cxl_calculate_dpa_offset()
can generate that.

> +		return -ENXIO;


