Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3144A04
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744082578; cv=none; b=obXH5j+Df5TiIEFMR0GpX5C/M5M4z4LBtx98+ThxHhdZlCYjhwoNUc7f6Ppdkoo+ug9rwBdYXW3DMO0fckIQR8rDBpl4CQQ1Iui589zfxpZVt5KpX10SqBVgwOVKQ1QTONJ/1ijwIaZVaDJGH6pCZp66JJYBuGQ/xd/fsFHArOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744082578; c=relaxed/simple;
	bh=hx0b6Z7kGZKqvlphhHEF7U+blmiyyVOB9cQOd0ofZ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRdH2ZxAN/tuWCdQnSs7/c8uGsZii6rm/yUggS+Hs03XZ7a9nwGdTRGBnwNcpmIrKRB2VADDZ+xHLZiuJtNyvc33pblPeQgMZYjthIgXXfJ448DsfglBkrWCuSJqBmPUg2u4hM0/pZu7sdGoX3+BHSqxNwrohl5vUPekPT4iy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Q3IPN7rl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Q3IPN7rl"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c081915cf3so663615985a.1
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744082575; x=1744687375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpIkPb+oI8Nj81D/rHxz6wipY5qAq43JtioaQHbfmMM=;
        b=Q3IPN7rlwStxwZnyTI7aUvZrS0o+CzJ/BpM3mYzZBuT0R05Hk+S5xvRbviS1UZbRX2
         LyKwdW3OxwTYK/0poEU5jlR6Tqj1F4Y+n2cT+M3CCoWjOYv7xVzLQUTy98sqdplJxGAl
         y12BlJZAOzGR3qWrtAQ5wwbgNuT2QII6qRrH9kF5krqhzkCmKKQi3Kx7C34Hr7KPwzy9
         765GSIxCYVUey4WHE1MmXieXDGRjim0dgWEQuFyLhxxeIih06BAMBarLaonLQJwycSYA
         Akt5/l+wzWiOxjaLRulEviIuU+Bpm8eBXxKZdPzNEmQoRGKraaw3ybGedn/majEFDh7F
         QWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744082575; x=1744687375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpIkPb+oI8Nj81D/rHxz6wipY5qAq43JtioaQHbfmMM=;
        b=UUhYIE7iI4prh92XNyRk3Dravq4lrahCmrNkQatu7TCkzfET6wDAPf+JNwBvVsvdXj
         Dcvdw2rASXvYb353+7JlaDOobSurJyH+oy4INiH+5GjytsVD2a78BPi4lU2oVwmdVIu2
         4xDJTSz9PgIMzZyFy156M+gAiB/wKXY99vGdp94gtJA8n/RGUlWnUoYCm5AwzBJGYyk8
         V1lhajs3cB/6KVQH2AjOChdgAd1zE67k//9Lx2IIXURUXeYJ0ANudhGzFXgKvvnWbZYW
         nq+cF8xlVnzIUU0QU10qMwOOdZiOvp+AR2B7ohyyMOYHEttVfIRoS9zbqUWG8NiAN6UL
         /3cA==
X-Forwarded-Encrypted: i=1; AJvYcCX5n9dsZZ3WDIU6t7lcWO9Oe9TObRRSEJp1pHmrbf6akEAVsd0jxIiGgHOVP7k8IxPIFdP6GPWDvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0TGaCowkLKAjigSHzTh9WOwbjHMwouOEUfN/qR8DTwhuV2XS
	LgWP9KsThedeuMK3exZ5uMUKJwtmzQA5WrWndzAsAh2x4aH+HEwml+Os7gdjLbQ=
X-Gm-Gg: ASbGncuHBg2o3N6NwAhccPASKenHKE+MCfrQrlh+Str+UvP+ogy1kXtFr/+ti9156cG
	+5aFwAichnrGEqsl2MOJ5zNqbhhb2PCI42S/myVLbFLaxWtEG2HGHMSwgQwM4S3DDyUs2/2qY+8
	gCKIhMM8/QNYt1ZVXoUbkRGMXZQyTnGI4dcsycHazRVCECvzkU6xMpPGbFaKTOecZUi3qbW6Iqb
	wm7/YzvBFXAneL32XrI8ppPdsLqc0LzFaZY87GBkwCLAN4ioDvhfOCXY/l5zWo/NFqFEEEF6Aw4
	bQKFZT0zwI1MbRAZgE23E8TCclxC6gxnRQKaO+dRBWruddIugwnfguUI06GSY5S6BdIljVnfDDz
	K6BVONyPKgxdGkBh82K90cAW8cwkpLEqbDnzc6Q==
X-Google-Smtp-Source: AGHT+IF6a1SP76wmH6Ygw0Tna4TAtQylWwl/soeK6IWS2NeTZsSEPQtntnv/Cy76q7M7CAEna+W4XQ==
X-Received: by 2002:a05:620a:4908:b0:7c7:827b:46bf with SMTP id af79cd13be357-7c7827b475amr1030560185a.39.1744082575296;
        Mon, 07 Apr 2025 20:22:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00f2b6sm67933266d6.42.2025.04.07.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 20:22:54 -0700 (PDT)
Date: Mon, 7 Apr 2025 23:22:53 -0400
From: Gregory Price <gourry@gourry.net>
To: Huaisheng Ye <huaisheng.ye@intel.com>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave.jiang@intel.com, pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Message-ID: <Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406112752.1261855-1-huaisheng.ye@intel.com>

On Sun, Apr 06, 2025 at 07:27:52PM +0800, Huaisheng Ye wrote:
> In some scenarios, the probe of endpoint ports would fail because of range
> register (RR) decodes outside platform defined CXL ranges.
> 
>   [kernel debug message]
>   cxl_hdm_decode_init:447: cxl_pci 0000:10:00.0: DVSEC Range0 denied by
>   platform
>   cxl_pci 0000:10:00.0: Range register decodes outside platform defined CXL
>   ranges.
>   cxl_bus_probe:2073: cxl_port endpoint3: probe: -6
>   call_driver_probe:590: cxl_port endpoint3: probe with driver cxl_port
>   rejects match -6
> 
> This defect could be found with Qemu CXL branch for a long while with a
> specified probability, even with the latest branch cxl-2025-03-20.
> 
> The root cause of this defect comes from that, bit CXL_DVSEC_MEM_ENABLE of
> DVSEC control has been set but in cxl_hdm_decode_init
> CXL_HDM_DECODER_ENABLE has NOT been set and also endpoint's dvsec_range is
> not covered by root decoder's hpa_range.
>

The explanation here is a bit confusing.  Please clarify if my
understanding of the issue is incorrect.

Observed problem:
   Some firmware/BIOS sets MEM_ENABLED, does not set HDM_DECODER_ENABLED,
   and does not program the Range registers.  This is possibly the
   result of defaulting MEM_ENABLED to 1 mistakenly, rather than a
   programming error / failure.

Suggested solution:
  Linux should detect this and reset the MEM_ENABLED bit and simply
  attempt to enable the hdm decoders accordingly.


Question: Is this only observed with QEMU? If so, can we just fix QEMU?


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 013b869b66cb..5452bb285140 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -448,6 +440,29 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		allowed++;
>  	}
>  
> +	if (info->mem_enabled && !allowed) {
> +		dev_warn(dev, "RR decodes outside ranges, have a try by disabling Mem_Enable bit.\n");
> +
> +		/*
> +		 * Instead of Return error when RR decodes outside platform ranges, reenable
> +		 * Mem_Enable bit of DVSEC control for a try.
> +		 */

Your comment says to "reenable mem_enable bit", but you clear it.
I think you mean to say "reset mem_enable bit, and try to enable hdm".

> +		rc = cxl_set_mem_enable(cxlds, 0);
> +		if (rc)
> +			return rc;
> +
> +		info->mem_enabled = 0;
> +		cxlhdm->decoder_count = cxlhdm->decoder_count_cap;
> +	}
> +

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..60b538f8b677 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -855,6 +855,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>   * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
>   * @regs: mapped registers, see devm_cxl_setup_hdm()
>   * @decoder_count: number of decoders for this port
> + * @decoder_count_cap: number of decoders from HDM Decoder Capability
>   * @target_count: for switch decoders, max downstream port targets
>   * @interleave_mask: interleave granularity capability, see check_interleave_cap()
>   * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
> @@ -863,6 +864,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
> +	unsigned int decoder_count_cap;

Why is this needed, as opposed to simply re-reading the count?

~Gregory
