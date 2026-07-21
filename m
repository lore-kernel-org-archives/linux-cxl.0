Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950F46DFE0;
	Tue, 21 Jul 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650959; cv=none; b=CnHnYfwfoHQoEE3qGuhgengjhg2s1R4UguvjjUd3x94d3uJ5ojaaiSZyRwlcZsm7eh/Yy22JgpZMygH5C7IuHNtH09ZEEwMMaiI6UY6muvxkL3+vkmlzL7fC24OrUjykMGjF9QuMyCVZlvS7uh3jau32OP+2Ws9/0Rv1EWq9DfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650959; c=relaxed/simple;
	bh=KzeKp1MU0p4Xa6fIpLIgRhrSfHvac4WsuQXkLChX8GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4nNzg0d72niXviYQ5L1o6srCaETvNFkqlTwrtML4LdHyPXtDrxrRIJ9uEMQIdPesJaqAMgeBfnpRgeLOiEN8k3ZqQaZcMsbXsjnVCTPSOMnf2y/f5Dtk9NkPvzb3VzcIuaG3h69xfexqZ1cERyOjz2ugC2g1C8a3X77p6yVpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hk/bpJMP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hk/bpJMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784650958; x=1816186958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KzeKp1MU0p4Xa6fIpLIgRhrSfHvac4WsuQXkLChX8GA=;
  b=hk/bpJMP4KOp5IMzzWgAtb45GaM50mSXvhtikLlMZgzRH/CBj+2ZZpUz
   9X+qEP8W02IBhY210+RaKf+kbS23y+aYs9LCfdZyqY4jjcboRJPdOp3y9
   ql/l3rZFHyqPvyoRh0/A4JSKEuQjENb5CvBJBMTo5DyuTaPfCpn5o8Rd1
   H04mgI7rm+Q2yssG7orarbPExyTUOTd29zkPdTkJu1cH/ipjV8E+bllTX
   Eked+0YjwMwGPV9mhKb3E+nMyZ6YRj2XmuiXm08mipvziDe0A4/6wjKxT
   zSsI/ntlXpyCK6db4sdaJfCFVYEnSwUT2x2HcQlt2eZ38/PEpUlh2Ybec
   w==;
X-CSE-ConnectionGUID: aAMuh2KgQXaS1w++vEr0Ew==
X-CSE-MsgGUID: AxaLYoaER9u47ln3DgTgJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96623192"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96623192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:22:37 -0700
X-CSE-ConnectionGUID: GN3ipz+nTQq0H8XFzpU7BA==
X-CSE-MsgGUID: kTsEn1Z4TliWKJ3OZ8d18Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261370133"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:22:36 -0700
Message-ID: <6e45902f-3438-4e8d-87d1-2cbef947a91e@intel.com>
Date: Tue, 21 Jul 2026 09:22:35 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


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

