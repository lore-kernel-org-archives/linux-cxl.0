Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9E7E1;
	Tue, 18 Mar 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331632; cv=none; b=OPiR0j1lmpiCpMvqjihv8zNxGrVzXW083+c/PdznGa1IQFCu48mRTGdTvfCZNjHtgH8GMoAFd+xoUcac1iWXShZzmkm1nSTQPM0ZJRHd/O3+/ErZT/P1+bJTwkVZX8a/12jvC5IeE+fX13ZO18y9jyI0b51w4W7FTBP1RQLyuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331632; c=relaxed/simple;
	bh=kulu2tclKATPYEFFRAIR+ou2lRNSwTwWlUcciUo8RB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc9Qy2e1nWjMaa7mqMJOm7iCzHPKtBDQia2Jx/Slx0aQp5wr7JOKZWetqk/ljcj6dNd3+JAfGII3v5loxeCWyO6zo85L1A8pWCh3ZZWvDL2WKRNdXdgaEKXTKEhvdPrEo2YTDlhKSwe4IEnLLxgDpGYnjaSGymSpbrzLMKCYG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cio2+0KX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cio2+0KX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742331631; x=1773867631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kulu2tclKATPYEFFRAIR+ou2lRNSwTwWlUcciUo8RB8=;
  b=Cio2+0KXkNUbwQZzyx+9/M7oieZwfpbygqjFjD1mLeCMnJXBag/KOk9j
   6Gwz+X1sQRj8hFdePcfq+ezZN4yDbZK7py+3VnyagpUrS8y3tUj4uWDDu
   Ve2TJeIoOh+R+MFtpUHJ/kE82BHLYGFa+1Uu+yVPGXKjSP0WCMiGcprv0
   nrB5z1SBi+pilixYPWQmxN+uuJxUPY6UJdbsK581ZjWNoBb3oZkWOnqAT
   JE4bjSgAiEo5jUfh2tUmk/pPlNngcPSLEDyzTBmPpbXjfQux2Vk4U2KV6
   qURr6+LWioZVhncEo4KZMIJFSgH9kwoOF8IPeFKRbkG03NVNNr8NEMpVR
   A==;
X-CSE-ConnectionGUID: M/v+suJlRH+m2FQhv8Snuw==
X-CSE-MsgGUID: erfPPDL/R1+dp8wALNcLRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54490244"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54490244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:00:30 -0700
X-CSE-ConnectionGUID: FP8iKRwjQVavZIVS3OHWZA==
X-CSE-MsgGUID: sOmGYciKR7yHB2aHweL5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="153221573"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.109.211]) ([10.125.109.211])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:00:29 -0700
Message-ID: <ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
Date: Tue, 18 Mar 2025 14:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cxl/region: set numa node for target memdevs when a region
 is committed
To: nifan.cxl@gmail.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 linux-kernel@vger.kernel.org, anisa.su887@gmail.com,
 Fan Ni <fan.ni@samsung.com>
References: <20250314164629.6937-1-nifan.cxl@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250314164629.6937-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 9:40 AM, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> There is a sysfs attribute named "numa_node" for cxl memory device.
> however, it is never set so -1 is returned whenever it is read.
> 
> With this change, the numa_node of each target memdev is set based on the
> start address of the hpa_range of the endpoint decoder it associated when a
> cxl region is created; and it is reset when the region decoders are
> reset.
> 
> Open qeustion: do we need to set the numa_node when the memdev is
> probed instead of waiting until a region is created?

Typically, the numa node for a PCI device should be dev_to_node(), where the device resides. So when the device is probed, it should be set with that. See documentation [1]. Region should have its own NUMA node based on phys_to_target_node() of the starting address.  

[1]: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/ABI/testing/sysfs-bus-cxl#L85

DJ

> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/region.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e8d11a988fd9..935ee0b1dd26 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -242,6 +242,13 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +static void cxl_mem_reset_numa_node(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +	cxlmd->dev.numa_node = NUMA_NO_NODE;
> +}
> +
>  static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -264,6 +271,7 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  		if (cxlds->rcd)
>  			goto endpoint_reset;
>  
> +		cxl_mem_reset_numa_node(cxled);
>  		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
>  			iter = to_cxl_port(iter->dev.parent);
>  
> @@ -304,6 +312,15 @@ static int commit_decoder(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> +static void cxl_mem_set_numa_node(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	u64 addr = cxled->cxld.hpa_range.start;
> +
> +	cxlmd->dev.numa_node = phys_to_target_node(addr);
> +	dev_dbg(&cxlmd->dev, "set numa node: %d\n", phys_to_target_node(addr));
> +}
> +
>  static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -340,6 +357,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  			cxled->cxld.reset(&cxled->cxld);
>  			goto err;
>  		}
> +		cxl_mem_set_numa_node(cxled);
>  	}
>  
>  	return 0;

