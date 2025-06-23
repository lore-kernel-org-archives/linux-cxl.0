Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA015747D;
	Mon, 23 Jun 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690228; cv=none; b=oKP8F4LhcPaSETGFaBgnES2QZ+pH/53Hc03BoG90arrDG0kxLvSFdHSJr2pgPAuLQweoFmtSvUBYyjNM7heU9GkjPD5rr0clfft1CCCevc9IjTihSAA0RY44pStt23fYVnw0t/k976e1Nkkc9gkrz697TOMFWkH2xtRpKQD9Ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690228; c=relaxed/simple;
	bh=ELZdQ3p4IyuL9UECA0T7zJ/0jD0+VGvARXmNsz4fH2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxFKUvwcnxq8yMk4El3PDBzNn0h/I22TB1KY4WWBPSZ6AamFNT748iYsWFMgNfBHWjn3jVCWufv+xU/A7gx7fo0yOyr0KAmhada24EFLN3udsxtBy1zxC8csj/mVrNPtK56HRB9GJbWK5e41K06+NxifSWEJ6/yANAwZaRVPMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYAtargz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYAtargz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690227; x=1782226227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ELZdQ3p4IyuL9UECA0T7zJ/0jD0+VGvARXmNsz4fH2Q=;
  b=fYAtargzYhimP0kixN9mbrP1eVZf0cuuCxR5X9IRUVOSZHkWOIWAqij9
   BPlDWVnyqsF3XiUcARUwaLuutRk4XseooJJqaQm9Z9G/aNddB+idc8yCN
   bNyN17j43E6hOZ78V3HLjkCCCB5QBGS45dyA5lw66Ky3Vug9sFoW0KWXC
   gMPt+BvU3SOb6OnhAdkSpjzuI/iTiVWAtqxAvnOtyWKOS4i6oXnQV4Io+
   av5T7QuDmbDmpJ5qLT9MES/BR7MAxBapObY3aFzIU0k48FbAKKG6vqmP+
   hz2M09gEhdG8tcp71dEpEYMRT+Wq3Ncok5v3Eo3xBwSbQy9AiNKIELwUZ
   Q==;
X-CSE-ConnectionGUID: GRzBgquSQSu56T1J42mjfg==
X-CSE-MsgGUID: DasDFtXlR2+KKt+8BzIJUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52771115"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52771115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:50:27 -0700
X-CSE-ConnectionGUID: swOTA/5lQ72mLN31rBN6jg==
X-CSE-MsgGUID: UBLkQ/tvSQaMPLtNvTVH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="152139810"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.178]) ([10.125.108.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:50:25 -0700
Message-ID: <cc5e782a-a6a8-4152-9e4c-52dbd1d8cc05@intel.com>
Date: Mon, 23 Jun 2025 07:50:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] cxl/decoder: Move decoder register programming to
 a helper
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-4-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250619050416.782871-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/25 10:04 PM, Dan Williams wrote:
> In preparation for converting to rw_semaphore_acquire semantics move the
> contents of an open-coded {down,up}_read(&cxl_dpa_rwsem) section to a
> helper function.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 77 +++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ab1007495f6b..81556d12e9b8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -764,14 +764,53 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> +static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	int id = cxld->id;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	/* common decoder settings */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	cxld_set_interleave(cxld, &ctrl);
> +	cxld_set_type(cxld, &ctrl);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> +		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> +		u64 targets;
> +
> +		cxlsd_set_targets(cxlsd, &targets);
> +		writel(upper_32_bits(targets), tl_hi);
> +		writel(lower_32_bits(targets), tl_lo);
> +	} else {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> +		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> +
> +		writel(upper_32_bits(cxled->skip), sk_hi);
> +		writel(lower_32_bits(cxled->skip), sk_lo);
> +	}
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	int id = cxld->id, rc;
> -	u64 base, size;
> -	u32 ctrl;
>  
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
> @@ -804,39 +843,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  
>  	down_read(&cxl_dpa_rwsem);
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -
> -	if (is_switch_decoder(&cxld->dev)) {
> -		struct cxl_switch_decoder *cxlsd =
> -			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
> -
> -		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> -
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> -	}
> -
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	setup_hw_decoder(cxld, hdm);
>  	up_read(&cxl_dpa_rwsem);
>  
>  	port->commit_end++;

