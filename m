Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425348A8C7;
	Tue,  1 Sep 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284844; cv=none; b=lVEl4n5QSIoYFh8rV/E6vnr7Hy9KQfLUm98QbnyJ96lXG6ntYbTKug6rWvOs4hWH7TGphfpDFPYmenrrLsfjXb9Kj2pJmm5oh3gTUtd+D2hm+8aKzA7rpPhuOAipFM5zAhrGBsxSd9N3IFCaI8ArYAqfYr0BBxd5R37cctfm3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284844; c=relaxed/simple;
	bh=2656E0RmlVbRzn5xZ0Ho+djh6YbWPtwm0sPiiaIFvJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUXjg1MVhV/vY5b7wF36BB7Xmwe5UGD4rmNGYE5lhUDrTnZY2Ef2PG90nK6jz0bxLNwOeaeI7icLUbWCynXrJZTAcx9rGdSU6aNJCJhlGfQWCg2a154A+ZHFo94PCSbE/ILefv0z0ZM4tISXKoBtALkBm4i0xnKq3SRhXMZdlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8nBvWJL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8nBvWJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788284843; x=1819820843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2656E0RmlVbRzn5xZ0Ho+djh6YbWPtwm0sPiiaIFvJg=;
  b=K8nBvWJLz0Inje/p4Xd+tf3ei7BM2c/HeThzm402+Qz6gSKxGPOQWVjy
   CBLQoTGmK8+gK06/aMt7mlTUHU9K8ilnorZiiwPpPHNMI6G1gdC+RGRQl
   V16YVL33N+0TjpnabPGbG3MfMIrzNgMZKxBCoye3/l8Bq0B8GTlssKGBJ
   bmxrcV/5lbu56cLUkFnHvjY1l6FwlFsk/SzxVIH2HqHczBrVZ4l3hZB1p
   WRp6pbtZ9mq5IvZrd7ll3qFxrcre2WuFnXde0fpGACyhByvRYihbYw1tC
   5PecY1jSElM7c2YIPB9k1Klyc6Bpu5eO9fMHl1NJxTNHtcAcqpaZn7QaZ
   w==;
X-CSE-ConnectionGUID: 6Womi0XRSL6sxiD/w6qZ3Q==
X-CSE-MsgGUID: lMmbZlhoRh6HwW/jOd2DCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100235327"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="100235327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:47:22 -0700
X-CSE-ConnectionGUID: SI3Bqgj9ScmiLxx/9r8pfA==
X-CSE-MsgGUID: fpmQqBVuT3WUNdP2HNf9MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="274437175"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.72]) ([10.125.110.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:47:20 -0700
Message-ID: <a0d7da35-d119-4627-9e2a-9594611a8a24@intel.com>
Date: Tue, 1 Sep 2026 10:47:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported
 symbols
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260721084009.38100-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260721084009.38100-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 1:40 AM, Richard Cheng wrote:
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

Applied to cxl/next
2c73cda8908f

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

