Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2A136662
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140785; cv=none; b=p7KF8htr1tgzbzbqzYo5WvXIh3u19moAGBjJDV1YjjK4ojHFVEhOs8LngwG+0N0ZGTOHG1tV0ps3PsgHALiQpcXWK+cNvNTfDZtQC++ycrHW3/njNnCfU69Firwu2jPzqTLoHJ7eLFB2kWLjUrewzhYWguqBELGLtMsy+B8ol30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140785; c=relaxed/simple;
	bh=KJTZmLwaZO9xpsdvzLeVxler7rLsie4jyEXqYk03/nE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eig8MI+kbbEbpfAgCKOPDLlhDpqm96j9dGltNLy05qEGAjLqNNjEEtebsDLJE2Iw8s5/Tyfk2nX2bzi5cUdBS+apc6sLUs9J8MD+DAQdy7nb3E5vd+iOLwN1neohVmdA8YixNK9ehImnt4s9YDsbXv6MnmamFPXVMi5by3O8t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQkmVLfn; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQkmVLfn"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bda4bd14e2so4663874b6e.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706140783; x=1706745583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70z9zW8c+zY1lhKSF5SMlkbQQJVCvyivNJrKkuHwb3M=;
        b=mQkmVLfn6SNMFWfI0RSgWDCwYkFtKCOSAuBfqKhzjWtByC6Ro/YaBJVTJPKtcw8njs
         7QUy1ig+a0V0mYwF1S04dA3g8Zv2NKKhDLAGT6/wvUcA2Vtj9l+ZkZB+cfqYIYk9M5mI
         7K6cPbxz1UG+pxgCE3txeEesPTBRubX5X/iRqjF1kjqceRhIRnWg5tpgRqFEu4hoKCD3
         ytBrtsr5aZVNSL73TKO5T0Ust8dM21Y2jCZh1rj6ounQRi13g1hX4hfuJ8dBtm7qt/LT
         GM4CmqMzaQbrBXR86Lrp9NsP6y7hRof6h8x4VIauW3S+eYkL4uEBzysj6uQYy7jdDUo1
         CvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140783; x=1706745583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70z9zW8c+zY1lhKSF5SMlkbQQJVCvyivNJrKkuHwb3M=;
        b=ZjIe45trGAYw9ufJLFwroLKJZjppv37KGTPz9CT1NM9oY/mxskHpeQ2xoF9kBE53Tx
         h6ODXRIYdKpf8cgisJ458jZbuEqYCDytLmmMy0PSYcoPgEhAnu6yIW4UMnoVm/Hbbt9r
         oDWurq8O08Jw0WUQ/n0owOTj/ixoiAZHhUFQ76zt+wgLGOtALLW7v0elfowYU56RRMOA
         9p/Hl7hVz10ljsxM1GXkcErMa92Q6jrmQFmBQahQbkSV26SfBu/8X548fRgl0oVmcUsQ
         tYaWOJu0fRfcY+9BJ9fzx5VqgmpQXtuk+NQUhgyOWfz4LYrkjm5eSuBOOgAupUdWT8k4
         ZPig==
X-Gm-Message-State: AOJu0YzHbtf6qsmenHG2mgm4MKlUu2jQ+hJOhk+/wu4/jio4KsSYcemA
	sgeyIWJyuwIOJBwcAEFUWuJaG07g4a2OxSZCp28/Weou1WFxu0SC
X-Google-Smtp-Source: AGHT+IFEzS1g+FvxtLtqxjHGtmlDWqaClEQ3FnfuXQazw35kawdhDmwwT4ef3lPAyHu3Z+d+7Rw62w==
X-Received: by 2002:a05:6808:f8f:b0:3bd:998d:60c1 with SMTP id o15-20020a0568080f8f00b003bd998d60c1mr52032oiw.17.1706140783066;
        Wed, 24 Jan 2024 15:59:43 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id t6-20020a625f06000000b006dd87826805sm2599008pfb.75.2024.01.24.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:59:41 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:59:08 -0800
To: Quanquan Cao <caoqq@fujitsu.com>
Cc: dave.jiang@intel.com, vishal.l.verma@intel.com,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH] =?utf-8?B?Y3hsL3JlZ2lvbu+8mkZp?= =?utf-8?Q?x?= overflow
 issue in alloc_hpa()
Message-ID: <ZbGkTHdfq0YP82YB@debian>
References: <20240124091527.8469-1-caoqq@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124091527.8469-1-caoqq@fujitsu.com>

On Wed, Jan 24, 2024 at 05:15:26PM +0800, Quanquan Cao wrote:
> Creating a region with 16 memory devices caused a problem. The div_u64_rem
> function, used for dividing an unsigned 64-bit number by a 32-bit one,
> faced an issue when SZ_256M * p->interleave_ways. The result surpassed
> the maximum limit of the 32-bit divisor (4G), leading to an overflow
> and a remainder of 0.
> note: At this point, p->interleave_ways is 16, meaning 16 * 256M = 4G
> 
> To fix this issue, I replaced the div_u64_rem function with div64_u64_rem
> and adjusted the type of the remainder.
> 
> Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..ce0e2d82bb2b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -525,7 +525,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct resource *res;
> -	u32 remainder = 0;
> +	u64 remainder = 0;
>  
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
> @@ -545,7 +545,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
>  		return -ENXIO;
>  
> -	div_u64_rem(size, SZ_256M * p->interleave_ways, &remainder);
> +	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
>  	if (remainder)
>  		return -EINVAL;
>  

Make sense to me.

Fan
> -- 
> 2.43.0
> 
