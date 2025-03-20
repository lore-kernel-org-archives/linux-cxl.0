Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0B22E403;
	Thu, 20 Mar 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508597; cv=none; b=CHddM26EzeXYo2vWZpilUYhXs3Fzrx2OSucCJud4ZMJHbr1unXyGWZamaq0+RvZS+m760GZkCLL+JqXKcJgtI+rnQzOGcWElJ+JuJa26Ac8J9vu1ojCfYTDgg+osGBrDJFv+9ZUm+gOv/yoQZThKKXuklPivWJTNacKeR7kySso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508597; c=relaxed/simple;
	bh=6f7orNFdsm9t4VeuOI8mJFl42v9q6nq7Ds/4R+jUFTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw/FKejxT9K9jmMi6WYdGoqZl6cIG5cWC6/u6O+lRWT9Xw6VDCyJLCkMU0m4TUo7GJZtpK6DCfjxsrDzIbR7UGWUwb3bhputc9RE6eYI05LWHck5oYTSXTnATm0V/bDleQcc+qkdnlT2TUwCw12EQx6MKqOJI/rNhIg6yIgx1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcvExi1p; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcvExi1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742508595; x=1774044595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6f7orNFdsm9t4VeuOI8mJFl42v9q6nq7Ds/4R+jUFTs=;
  b=KcvExi1pnybTeGxdFxA8CYAspZWHHG6Af7I1nLYJuZhTagJvqcQEYboO
   /sekhph/0g5Vha0FMHutAWg1zplph4ootpEbYYjUkKsLq5w+8xRwd6WQm
   PgubQlBrwQrHt6S6iDcedoZcH1fc01YLavDeLjG7roZZH4byjsho4yOaQ
   OtLCbGDahg1Cq5Rnl/KAfNO5p90jIFF34JqD/HWXguPx2wyLDYZjDGfRK
   ndAY9lLEcua2X6MwpZ+dBGVvW7gyLD/VXWN0WLsFuF0xJ7i61HIOlz7DQ
   wciDkkmdKU3Lz719aqtct+ABckKcgqpbYTis2p7yrAgBuB5W7FqKdpUvQ
   g==;
X-CSE-ConnectionGUID: feHvyByhS5uNdSOxYW+PBw==
X-CSE-MsgGUID: DQa51wPQQX6XwVMTB3XfcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66229623"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66229623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:09:55 -0700
X-CSE-ConnectionGUID: 3QlSYfosQDO2XPTeFkrQAg==
X-CSE-MsgGUID: T6Ln0k3TQi6U5DziJqh8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="154113566"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.123]) ([10.125.110.123])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:09:55 -0700
Message-ID: <68826571-44cf-4abb-9be6-00b64d5ab54d@intel.com>
Date: Thu, 20 Mar 2025 15:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/region: Fix the first aliased address
 miscalculation
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317070124.815028-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250317070124.815028-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/25 12:01 AM, Li Ming wrote:
> In extended linear cache(ELC) case, cxl_port_get_spa_cache_alias() helps
> to get the aliased address of a SPA, it considers the first address in
> CXL memory range is "region start + region cache size + 1", but it
> should be "region start + region cache size".
> 
> So if a SPA is equal to "region start + region cache size", its aliased
> address should be "SPA - region cache size".
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d8bdb53f258..c3f4dc244df7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3460,7 +3460,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  			if (!p->cache_size)
>  				return ~0ULL;
>  
> -			if (spa > p->res->start + p->cache_size)
> +			if (spa >= p->res->start + p->cache_size)
>  				return spa - p->cache_size;
>  
>  			return spa + p->cache_size;

