Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7D493620
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284910; cv=none; b=dFCqfa7/Uj0R5S6gj+xpKL6FHr/aiPc4/TfPiGy6y+rU7oeA+3iwVvfI7ID/Rw0oLJ/UZcbsljTKOky3dywBpDfIa2qm2nOt4sCV32fqdWDPb+/OVIIVJ4p81VJjVtu7qfZgguRKZiq1oo6cMBUBlQeTThHyrFTsaEE56jXzoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284910; c=relaxed/simple;
	bh=vC8GHJre4FTsFyGz4ywEn1uxNmSn657W3ReFGb3s9ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCDL073cYWAcx/jUBzyfXiojCe/EaKbtXj7ZetYPAO1qytlY5sZI5MN9rR+QnqPK0pu0XoUVf5eQ1wwEQyJr+UySPpl/fnqkvXC9hs09KA6IbsYtWU6o+c2PwHsGf+XN3mw1o+RZX/1OfSTxLTWI0iD1YrXwMdrVwO5LoHhhmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3KWCNx+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3KWCNx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788284909; x=1819820909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vC8GHJre4FTsFyGz4ywEn1uxNmSn657W3ReFGb3s9ww=;
  b=L3KWCNx+x0scDwUdQzHGgXLwbhJc2BtVL8npOmkc3emeDjLWE0IQrNak
   7JRVR7tMkNh04zOdfV7BnUSXpk0ytF9h6fiALfB8EG28/Jzw+i2/EfaLR
   i/bj0TshUXGzyiqu+XNMg+1z3lZn/zOE94qWotA3cbEOL8s8GarTFMe9P
   suBD86r8aGPulSv/MwQW+QSvSAqZJMCI+MriNDBmu/u8Wqz+oMfJ9jAZ8
   H9NM2SP0sKmrScx9SMGS35gnRsLEs7H4pYJ1hj6eUD8ISJbtKyZeErc1V
   tjNVogx6DfB4NoyH0Xo/ghUZwT5cJNqKhCgRlTbYOufqseR8uyYhGmy8/
   A==;
X-CSE-ConnectionGUID: csF7c/hHQWumlhZCQS9+Dw==
X-CSE-MsgGUID: d9ynBSjwRumMOonlXq+5zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99062486"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="99062486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:48:28 -0700
X-CSE-ConnectionGUID: ZXT2vUFfR9WrYCDyqqTgdA==
X-CSE-MsgGUID: owKHzjSoQvObtHJo3H+yBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="265927721"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.72]) ([10.125.110.72])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:48:27 -0700
Message-ID: <1addab64-c71c-4bbe-ae9d-870b3e58f650@intel.com>
Date: Tue, 1 Sep 2026 10:48:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/test: Map mock device nodes to an online node
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, gourry@gourry.net,
 shaikhkamal2012@gmail.com, linux-cxl@vger.kernel.org
References: <20260831175119.3247915-1-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260831175119.3247915-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/26 10:51 AM, Davidlohr Bueso wrote:
> cxl_type3_mem_init() and cxl_type2_mem_init() assign alternating NUMA
> nodes to the mock memdevs to model multi-node topologies. On a
> single-node host node 1 has no pgdat, and the first node-aware
> allocation in an odd device's probe faults on a NULL zonelist:
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
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Applied to cxl/next
6f057dea1525

> ---
>  tools/testing/cxl/test/cxl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 62bd92b3be45..221be4addb0e 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1945,7 +1945,7 @@ static int cxl_type2_mem_init(void)
>  			goto err_mem;
>  		}
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>  		if (rc)
> @@ -1974,7 +1974,7 @@ static int cxl_type3_mem_init(void)
>  			goto err_mem;
>  		}
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>  		if (rc)
> @@ -1991,7 +1991,7 @@ static int cxl_type3_mem_init(void)
>  			goto err_single;
>  		}
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
>  		if (rc)
> @@ -2009,7 +2009,7 @@ static int cxl_type3_mem_init(void)
>  			goto err_rcd;
>  		}
>  		pdev->dev.parent = &rch->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
>  		if (rc)

