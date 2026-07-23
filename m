Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8B4823D4
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839454; cv=none; b=kmTqfZ6U/g6yUs/jFx/53gQ/V2w59hnArZw9Ny5A56elYf2neCzh/+nUpmB6pOBoCGu9rKn0lce8iMxdUx1xvFGDhRrcrlNf9heSAldCkTLoIm7wWTaM36HudhEwFp99FI8sv1R9rFVKVddBX1FBkK3VvVjAYWcBVYdsvfhn+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839454; c=relaxed/simple;
	bh=pyuhVDnXHfFGPS094FrssOvaQJISDMMSwqqmLM/RWKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwB/3rmtzVbIIOrZQ/QPtAFfjVcQ6+T0cFu4caxvYZoQyFwA2W1s0gu9vagHbEhhBse4PGMGHBWpn7cxcTy0E27a3CHl8agko/qkXVAfDkMQOblD9i0JLRDc9tRXhOx4x9g4jQbRHcs2/yjNyRSSIcOIhSFHQHncnzeTmoeOMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LR3RpK4R; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LR3RpK4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784839448; x=1816375448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pyuhVDnXHfFGPS094FrssOvaQJISDMMSwqqmLM/RWKg=;
  b=LR3RpK4RNx/vOXw3gxaGAEa4uES50c6ijaeHfs+fEz2JzAE/+8FOipwX
   W2XgHbpnVLErS6p7wK7NrRD8hesmpBNInZcZHI2TpYBw2tc4I71u0AG83
   b22LCGU0Uc/qrxvhYJxfuuJCR9+R/sNYsUDaCSXql6NZ49TQla9Y8+IVi
   VO4sxtYmtqUlTDOvMqtKzBzRcDBoyWeW8o3jXYPpTuYxbzjlROYenguB/
   fObdGNSRpy6St4i/9OFPZcXCaWOahbxrMVahc8xuZ+QTAVGCo02EU+VTh
   DNj1onq2wOBWUcR93vZquFa+aOD37qBcMzZWu5qEsTKg2+3KpFU42AOxF
   A==;
X-CSE-ConnectionGUID: CDWmziSnRf+jv5oElxBaiw==
X-CSE-MsgGUID: gqdZ8ynOT0q8daoDUb/jZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85522244"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="85522244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 13:44:04 -0700
X-CSE-ConnectionGUID: iMeJo7x4QACZ1jN9sSCGYQ==
X-CSE-MsgGUID: INYjis+3RiSLQiSW60pE/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="283022385"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.160]) ([10.125.110.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 13:44:03 -0700
Message-ID: <bcbc5578-8f95-4c27-b07d-9b5fa1ad4baa@intel.com>
Date: Thu, 23 Jul 2026 13:44:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Map mock device nodes to an online node
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: djbw@kernel.org, jic23@kernel.org, alison.schofield@intel.com,
 linux-cxl@vger.kernel.org
References: <20260723180630.1302871-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260723180630.1302871-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/26 11:06 AM, Davidlohr Bueso wrote:
> cxl_mem_init() assigns alternating NUMA nodes to the mock memdevs
> to model multi-node topologies. On a single-node host node 1 has
> no pgdat, and the first node-aware allocation in an odd device's
> probe faults on a NULL zonelist:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc00000006e3
>   KASAN: probably user-memory-access in range [0x0000000000003718-0x000000000000371f]
>   Workqueue: async async_run_entry_fn
>   RIP: __alloc_frozen_pages_noprof+0x288
>    new_slab
>    ___slab_alloc
>    __kmalloc_node_track_caller_noprof
>    devm_kmalloc
>    cxl_mock_mem_probe
> 
> Map the requested node to an online one, as dax_hmem already does
> for its target node.
> 
> Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")
> Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
> Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Found while regression testing unrelated work.
> 
>  tools/testing/cxl/test/cxl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030..5156516a82d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1748,7 +1748,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_mem;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>  		if (rc)
> @@ -1763,7 +1763,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_single;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
>  		if (rc)
> @@ -1779,7 +1779,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_rcd;
>  		pdev->dev.parent = &rch->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
>  		if (rc)

