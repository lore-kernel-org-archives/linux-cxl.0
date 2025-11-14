Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05421CC60;
	Fri, 14 Nov 2025 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157946; cv=none; b=ftrxBYMLfsIcFlM33v+vqmFpn7mtBEyqBtxxpDXE9PDp9bafhIt6KjcCFuJFZnXSUnzKhnAr4ajsnoou8Krf4dXPl9MhpohnEaR7gyJ/+Tccq/651CpKsAKHdtR6BpE5H70wmCOw4ZaYXBwISQNk/BnXeWaq9rrHRJ8eIDRvS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157946; c=relaxed/simple;
	bh=OE0EEQs4Dh9mPnzfx4TN7mc4AK5mW4osI+W1S2hgEOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKGjzHbgxxKJ7NWVPy1Y+tBH0Q0wa5uIhvzqXpPTFItqnWgcFRVKIOeywrnTBlZ1kscJP45oKD0t+d6WTS3X9067jnTX54dZigNv3fTQowWzGkVz4zPpyVwxq9JWdNVJh4tJKaxg3Xya0Ur0Rv03hCEtWCxfXDDv6vcZMvnrr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Slx3i+2x; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Slx3i+2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763157945; x=1794693945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OE0EEQs4Dh9mPnzfx4TN7mc4AK5mW4osI+W1S2hgEOo=;
  b=Slx3i+2xFVi5Tp8HONYS8UwFd1XnafJg8UCAr50K6wrA/v0zjZ9Yk4EE
   IONHnXLCTLFM6xYOhx2WZSQqVzx8qrzn9v6xqNORry/SyGT/TPmnZ/NAf
   4ZqvPbJUh9JovCidkQwKLmtDviNJHia+YjAFRWC4M4BY12otNTTqWOidV
   nNS7VBplKCK3ChHxQGmYO2YhnoTBrJXq3OlF/8OBLv5QBE7OaB1h5+rKT
   GWY/+17Ebd2uWdLaJpWJiRPXEMaoQMzH7pj2o0+5lqLXYSyTA0EiaLf9W
   UMKBfqSX/4CcgNvpEZ1b13fPQG7DsYnnIPedAO9D7ZKRoKiXw1DkNQAaU
   w==;
X-CSE-ConnectionGUID: 0Ctf3N3YR2aXk5hia3v3qw==
X-CSE-MsgGUID: oT1tqrALSnKx9o3XaVBALQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="67864040"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="67864040"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 14:05:44 -0800
X-CSE-ConnectionGUID: sGgq4kGNTQKC5X81TJUxdA==
X-CSE-MsgGUID: OCh1FlYaQM+EaVpGnkI91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="189697050"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 14:05:43 -0800
Message-ID: <9750cd82-29be-4830-8b12-9cd397dfd8a6@intel.com>
Date: Fri, 14 Nov 2025 15:05:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] cxl/atl: Lock decoders that need address
 translation
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251114213931.30754-1-rrichter@amd.com>
 <20251114213931.30754-12-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251114213931.30754-12-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 2:39 PM, Robert Richter wrote:
> The current kernel implementation does not support endpoint setup with
> Normalized Addressing. It only translates an endpoint's DPA to the SPA
> range of the host bridge. Therefore, the endpoint address range cannot
> be determined, making a non-auto setup impossible. If a decoder
> requires address translation, reprogramming should be disabled and the
> decoder locked.
> 
> The BIOS, however, provides all the necessary address translation
> data, which the kernel can use to reconfigure endpoint decoders with
> normalized addresses. Locking the decoders in the BIOS would prevent a
> capable kernel (or other operating systems) from shutting down
> auto-generated regions and managing resources dynamically.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/atl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 3b02999d3c59..0590890bd093 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -161,6 +161,24 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * The current kernel implementation does not support endpoint
> +	 * setup with Normalized Addressing. It only translates an
> +	 * endpoint's DPA to the SPA range of the host bridge.
> +	 * Therefore, the endpoint address range cannot be determined,
> +	 * making a non-auto setup impossible. If a decoder requires
> +	 * address translation, reprogramming should be disabled and
> +	 * the decoder locked.
> +	 *
> +	 * The BIOS, however, provides all the necessary address
> +	 * translation data, which the kernel can use to reconfigure
> +	 * endpoint decoders with normalized addresses. Locking the
> +	 * decoders in the BIOS would prevent a capable kernel (or
> +	 * other operating systems) from shutting down auto-generated
> +	 * regions and managing resources dynamically.
> +	 */
> +	cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  	ctx->hpa_range = hpa_range;
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;

