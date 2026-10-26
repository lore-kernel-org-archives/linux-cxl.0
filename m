Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054308;
	b=vnq0GMEpFLBEIiIqXXou0FrzEJ0wDujTlFX2nCpeXUq1h4qiEe7heIi1fnyjTSxGCa8G
	 bYbngl2FwswrkZ6UpS9JjHD+PxCwlaV+gA7nkDYF7HSed0BnIzwVG3FcTXvCLnLRs/ODf
	 hTuPqIRRHRttL1onamc4fzrS+j80+2ntdr17vyUyYXaSiSvUvq0gYhXI0Z/WfwdaAfIqv
	 OLY4pln2hndVZkOeCtA5zrsTmHID1snlPL0693lJEt1J6XtyfI82C1UmLiSFtc3q3mGx/
	 ewYxjGvHY0pwVo1nIwtI54gqaectK8a9LLurJT++MoIBWydpdmQ+qw/Yykb+3oHpM6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054308;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tYqFZ+ILq/e0Mry1ziT1anZMjrDNikiOmGSQo98PRGM=;
	b=YjBNtT19+h/8tF02Dxa0DzPCzPkPegNiWUF6M2so+ojnTSXPXtrKxeyDSAbj3o6g5grs
	 cdVH1WThCQq4AfHY5QKgknionPjyIyOuXLlF6fULsKwZT4WPhJC+XmpZr3W40Ssoy1sTb
	 Ikm9xigYqc6KyK0vlASW8iYDwkkjACEvZ1ZjBgkjvGYrWQd4iFarJs4O5DNqwKo5vl16b
	 dcqWRUrf5XbpDDhVo4DllyWS7gYdLhFdmw/5GxDaWsGJpkJPhbH/SaP9fsEPEfiKsTDtc
	 saI+m+1JrFfQmmWFl1FTW+bmZiOZMeuIvlNuOttS/kZ6F2fNGDzF/nO6vyPI8U93xSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z34UZhj4;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D89606A31A
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z34UZhj4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793054307; x=1824590307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=11pD2+ghfQ40A6wNgUQYWaxWrvENLkV0kfeeWA0+Bhs=;
  b=Z34UZhj4T3B6YXAVHwD1FUlc7yNl4o7alwpwutcyV2txgElOIJvDRpXd
   ML2IYTnD6DgcBpzChZcHd1iA0AIYcwGfJDgve7zm0Y54H+wFxx8YJTYN+
   8CaX0aijIaL4EMNb8CcLZDARbs3gZ9sZFg6Dcel8F6YUMM1I8CRnWKzG9
   NrcyAYJmbx7LokTqbpXJxRcJwHAeUCWRv4eSA6MpEcmft+Q+GhlUsSd7G
   odlGfwusDTF+8ySXtzSvDTseU9z8r+YJ0n6yvI+NYYj9f+xFF12ES3W3I
   1Td7PTmpYX4GmuP3QwmNQDsPB794MKbkjsgRCq/bRP9SIWUxNd2+H7dnZ
   Q==;
X-CSE-ConnectionGUID: wmciGJ3lSaKcMwkLOzlQzw==
X-CSE-MsgGUID: VAqdjt2SSSq/RPW3jIzaMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1625416"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1625416"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:38:27 -0700
X-CSE-ConnectionGUID: O8i3fqUmR7mNmJHYwneOQw==
X-CSE-MsgGUID: hc9OcyQ4SueuugXvK9u09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4410467"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.108.112]) ([10.125.108.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:38:26 -0700
Message-ID: <1f08a647-0d24-4103-9382-61eb9b7517a5@intel.com>
Date: Mon, 26 Oct 2026 15:38:25 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl/region: Make repeated targetN writes no-ops
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/26 9:16 AM, Alison Schofield wrote:
> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). This can be reproduced through
> sysfs:
> 
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> An existing check recognizes when the decoder already occupies the
> requested position, but does not prevent the attachment from proceeding
> and modifying region state.
> 
> Move the check ahead of the attachment work, so a repeat write succeeds
> as a no-op without modifying region state.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Note: cxl_region_perf_data_calculate() currently updates region performance
> data before attachment validation completes. This is a pre-existing issue
> that will be addressed separately. This patch places the repeated-write
> no-op check before that call, so the issue does not affect this fix.
> 
> Changes in v2:
> - New Subject line. v1 as 'Reject a repeat write of an ...'
>   v2 does not reject, it treats as no-op and protects region state
> - Keep repeat write as a no-op instead of failing with -EBUSY (JonathanC)
> - Check before the decoder's bandwidth is added to the region
> - Correct the Fixes tag
> 
> v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
> ---
>  drivers/cxl/core/region.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..c8dbd9b29899 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (p->targets[pos] == cxled)
> -		return 0;
> -
>  	if (p->targets[pos]) {
>  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
>  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> @@ -2128,6 +2125,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	/* Already at @pos: succeed before changing any region state */
> +	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled)
> +		return 0;

I think we probably should do -EEXIST here. As far as the user visible aspect. Previously when this happened, the user just finds out that the region is broken later on. If you add an errno here, the user gets to find out earlier and it allows them to figure out what's wrong with their setup script. Given that there has never been a scenario where the user set an existing decoder and successfully configured a region, I don't think it's necessary to preserve that original behavior.

DJ

> +
>  	cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222

