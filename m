Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8732F3C16
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891781; cv=none; b=ltiTKdQpo8fgEIDwyrmP0Ui0s8vdp5pm6ewXkMiW/Kvvfdy0819awOntaFE9BoSBp/QVUNMc4sE3aRBN2J6QbjYEQgMxNiLXC2YaA5RHCQ9cCQ8LwlbLk9sikdLZHNIWaNGgqzshMUSJVoyCdNaTBVhxq2MIHffSQtArGTxssyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891781; c=relaxed/simple;
	bh=z59bYCacyzfacojIgnqax1NfXGoth8VYmbzeCZ3pyxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9YwX90MisIjzwRkdWVV5ulJHbRx38e8BxJeCR08gI7V4Mbjq9ki7NFI/2ZwpGRHeZ/e4gemVF3Bhk93NZ1+StU8bDhIFsqRRNMpeJhCsfCa2I1HQ9qzmLLYy9ePVzj5T81ovtljFA3eCrQ2u0qDjaU6eX1/UNVEORq+ACwENkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5ZOqTo3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5ZOqTo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750891780; x=1782427780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z59bYCacyzfacojIgnqax1NfXGoth8VYmbzeCZ3pyxU=;
  b=B5ZOqTo3ISYI/VS9CZ7eTATsOsdnsiCkPbW3tVYCC+aIDfMNtvWaSDEw
   ra/PkWHJFrtyuKKLTJseN+uGIoJfk8rjc0bsFDdZ1OKKe5uN+sN+dTEcr
   b4vwC5QV+t9hn6kz+CmKZMfE9OeJFiuq6O7abCbM5UxDk0KHJ1qTcBIB2
   ArwgXGy+blUyX6dHaofnj74irCfwkWHCu3Nw/htCiIPpb15GJ9a0Ho9oG
   bYKziDnixnX1qiuul4Mn/l2d96I44g6v6iYdkQLTHoRSDPl+CTpekFZ5a
   1L0vzKBFK713/3S3ikalvZkJf8KczHRQ0DREHLpzB8XposQSqfcS2LnM0
   Q==;
X-CSE-ConnectionGUID: ND4Bm3FHTQir8PZhd5c4lA==
X-CSE-MsgGUID: jt48GwGJTUCf26DXbkTuGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64532311"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64532311"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:49:39 -0700
X-CSE-ConnectionGUID: Ng1zNJo+S36Y30fg2m8V8w==
X-CSE-MsgGUID: aDevBVdpSeKN5sfEDFx0Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152113910"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.5]) ([10.125.109.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:49:39 -0700
Message-ID: <ef98b7b1-0fec-423e-843f-e82281eb48ef@intel.com>
Date: Wed, 25 Jun 2025 15:49:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/region: Introduce HPA to DPA address translation
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1750725512.git.alison.schofield@intel.com>
 <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/25 5:53 PM, alison.schofield@intel.com wrote:
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

Are there any public documentations (or spec section) on explaining the translation you can point to for each of the function segments?

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
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

While this is totally valid in C, I'm not big fan on returning a struct. The compiler copies the result from the function's stack to the variable of the caller function. Can we just pass in the addr of the caller's struct to write back and avoid that copy? We are not writing Rust code in CXL yet. :) 

> +						  u16 eig)
> +{
> +	struct hpa_decode_result result;
> +	u64 bits_upper;
> +
> +	if (eiw < 8) {
> +		result.pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> +		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
> +		result.dpa_offset = hpa_offset >> eiw;
> +	} else {
> +		bits_upper = hpa_offset >> (eig + 8);
> +		result.pos = bits_upper % 3;
> +		bits_upper /= 3;
> +		result.dpa_offset = bits_upper << (eig + 8);
> +	}
> +
> +	result.dpa_offset |= hpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	return result;
> +}
> +
> +static struct cxl_dpa_result __maybe_unused

Same comment as above

DJ

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
> +
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +	hpa_offset = hpa - p->res->start;
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

