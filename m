Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16634404B
	for <linux-cxl@vger.kernel.org>; Wed, 19 Aug 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151232; cv=none; b=Y0ek3kThqOrLnYeqfcGDqBLpHbHbX9cbqINyc03ugYKSR1/GW1Dr6oUTSsZR4hUwiOtwuB2wFWs0Bm6iPHIeQTdt+U8Qr0xfD4KItuJoLIewewxmnW0Zz+jR5MFdOHKnpR8lbpYU5+jjUzz6x7MR42EWWy5xn0VMBOG3nf58c7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151232; c=relaxed/simple;
	bh=2Clwq0xEVl/D3F5PUetuKq2yD9SbLjCrf62+DTeKkvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r182dHrloUhPIEOud7KDJWETmOxnElKNfFDMr9s8n3LHY+M0OelhJ78pWp32zkreHrRvqkdhUwfTLtQx84Erfk5TxBW4G0T1AQdZB3QyfaV5as/BSdxmcF/jwaz5EW/tCC7YYtD+Y4Ryvm5Pl/ORuT7GYIZ9t9SpyIEIOvIfQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWGIZtGV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWGIZtGV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so1669980a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 19 Aug 2026 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151230; x=1787756030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bxSCVWHULZ047P0gCjavIGFCaLe7BBqipIjyXjDKflw=;
        b=ZWGIZtGVzgAgdSQlfcdCepMa5pnETsj1ceGQ4JHoQqrbyY8LHEp/C/DACAf/5oB+M6
         6mgRozbiK2ZbXjAcgA24Fb/2/aytoMgOvb7CIAY1ZhthIYBTgmDE5cqio26sxa8NJuSf
         lmLeQTnQv9dsHHYs71/Y9CLTkk0OPths8JdoKdu/D3z8VsQZdczpNsCSP0j+BbXQ1Klc
         Qe+kHFlZSsayLtQbtEyqGW+wvmKbFLlpZK4RGBt+cXpWs65uliFzs2RYk+at9oGu5hNZ
         smOtFnw4vt4Lzh8bSCgpMhVqH/BihtN0EmssSuAUo3LMxoc+dZi/Z7oWRhZlYr797G7N
         Bpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151230; x=1787756030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxSCVWHULZ047P0gCjavIGFCaLe7BBqipIjyXjDKflw=;
        b=SpkbhCBCeyQiSvulSLtGElhLV52eoiPwfKHnL5eqo8mRKT2fWDdErV16aET2n4u5QY
         5rBnlmsMIwgDDxnEbgU+6l9MCSB7eW0VQJfhR/b5cNcDW7obF5a/WcuB1thZmzdewU5H
         9sB06vBlsVq3rIu6F28wUEWG5gEWKTFpG0GpyS4G15X7RWMu8C9WSYhmG5YR8LrM3RGG
         RR9hu4DBKqHWKftsV/Vmv0Q4yG+Izno0pYg6sl5QWIDxYnp61QfoBwBDYkKjDMueeHng
         VZI5K1nixqLhM84dEpzV0PBPKDfcPuiolCb411Pi3gAfKRimjW6B+LTkgN7y23MkLcmN
         LUhg==
X-Forwarded-Encrypted: i=1; AHgh+RpFdCW6NhZOyKEFMukppTB8+JsinVi/xUBuswyKumCrc+hvzFhK6kY9AyTXTf28FPzB70tN52kpDvc=@vger.kernel.org
X-Gm-Message-State: AFuF++mMnIAiLEcgjwxccagTMJelxh6l8vjpNzkxPte7qBpT2o3Xh/8N
	heQey4hZLpR+A+ps22HN9N/6OXJXWentBhCLWzGJ8wAW8+beQs3NbMqD
X-Gm-Gg: AR+sD10G0u8IflBEZnsd1KYRnL3cCS3eVl3rtW3nB14Ugg8+hWVcgm1ltXTjfBEtlPs
	XDiyy964kcs2BHeQuL9b0FT0YnwyqnTNT1kfou5ZcZTpe1Tz2P2slQvq2E2AGM/N6arX7ousWCA
	0LrsbNckxBKqXS42yfYwSY6wqJ0s48xyDxUL5f8UBr7xDXaLK1B72gmJsqxErT4drr5ViVRLJbW
	ZLJTsBfYbLSXsK2DKMcomU2155Jd+T2ZvTUl4pJkwfQhtUI6xum5V/7LTWSZm4TqpUd1P9iBN3U
	4pH4HJrTz9206M0SOsWiz1msSQMRzK6aZKaDlgug57LlPJ1fHQoOFZTrP07ICcj+7fXXs0Mu50c
	3ZKMnzX9FKGwstJxmggyJtF3o/lijf8CWZIcU2aA/oBAyYOGDacSnHqMcd9+1oo5QteTpSNqpEk
	ghYzMDSSFZb3z27PPlchd0lOk7dtUGUDq6+jaxn73bnMpZO3hRA1ypEz3GEGHscYY=
X-Received: by 2002:a17:90b:1f82:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-3958108a4c6mr9971843a91.12.1787151229865;
        Wed, 19 Aug 2026 07:53:49 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f85cdddsm966811a91.3.2026.08.19.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:53:49 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:23:47 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org,
	ming.li@zohomail.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, newtonl@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported
 symbols
Message-ID: <aoXDe6OM1oWwVyK8@acer-nitro-anv15-41>
References: <20260721084009.38100-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721084009.38100-1-icheng@nvidia.com>

On Tue, Jul 21, 2026 at 04:40:09PM +0800, Richard Cheng wrote:
> Building cxl_test with LLVM=1 (ld.lld) fails in modpost:
> 
> """
>   cxl_core: .export_symbol section references '__wrap_...', but it
>   does not seem to be an export symbol
> """
> 
> cxl_test --wraps 6 symbols that cxl_core both defines and exports.
> GNU ld only wraps undefined references, but ld.lld also redirects
> references to defined symbols, so cxl_core's own EXPORT_SYMBOL entries
> get rewritten to __wrap_* and modpost rejects them.
> 
> cxl_core never calls these symbols, so wrap them only in the caller
> modules via LDFLAGS_<module>.o instead of the global ldflags-y.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  tools/testing/cxl/Kbuild | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e49ce644b4b1 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -4,16 +4,20 @@ ldflags-y += --wrap=is_acpi_device_node
>  ldflags-y += --wrap=acpi_evaluate_integer
>  ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
> -ldflags-y += --wrap=cxl_await_media_ready
> -ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_endpoint_parse_cdat
> -ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
> -ldflags-y += --wrap=devm_cxl_add_dport_by_dev
> -ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
>  ldflags-y += --wrap=walk_hmem_resources
>  ldflags-y += --wrap=region_intersects
>  ldflags-y += --wrap=region_intersects_soft_reserve
> +wrap_cxl_core := --wrap=cxl_await_media_ready
> +wrap_cxl_core += --wrap=devm_cxl_add_rch_dport
> +wrap_cxl_core += --wrap=devm_cxl_add_dport_by_dev
> +wrap_cxl_core += --wrap=devm_cxl_switch_port_decoders_setup
> +wrap_cxl_core += --wrap=devm_cxl_endpoint_decoders_setup
> +wrap_cxl_core += --wrap=cxl_endpoint_parse_cdat
> +LDFLAGS_cxl_acpi.o += $(wrap_cxl_core)
> +LDFLAGS_cxl_pmem.o += $(wrap_cxl_core)
> +LDFLAGS_cxl_port.o += $(wrap_cxl_core)
> +LDFLAGS_cxl_mem.o  += $(wrap_cxl_core)
>  
>  DRIVERS := ../../../drivers
>  DAX_HMEM_SRC := $(DRIVERS)/dax/hmem
> -- 
> 2.43.0
>

Hi Richard,

I was hitting the same tools/testing/cxl build failure on current cxl/next.
modpost was failing on wrapped CXL symbols, for example:

.export_symbol section references '__wrap_devm_cxl_add_rch_dport',
but it does not seem to be an export symbol

.export_symbol section references '__wrap_devm_cxl_add_dport_by_dev',
but it does not seem to be an export symbol

.export_symbol section references '__wrap_cxl_await_media_ready',
but it does not seem to be an export symbol

I found this patch while investigating the failure and applied it to my tree. 
With the patch applied, the wrapped-symbol build issue is resolved and tools/testing/cxl 
builds successfully for me.

Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
