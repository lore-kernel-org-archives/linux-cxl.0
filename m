Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAF36CE19;
	Tue, 30 Jun 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834983; cv=none; b=bXqTuzySJzT5MWsAmlopvayr5uwSF5/8DrnjJcn7S1IXiU51yaT4DvsD54sONDvXOU6QN19DBVvryzVszXOHJ7e5Tkz+tBlHV5OELzmPl6LwbFwy2ST8vl19NiHw5EzY6pjIRmVQ+3syDVaVcZgmzTzGP5PYrrle86SoMY4Fb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834983; c=relaxed/simple;
	bh=xVDOUIqDchQXDM+zhDkWofS86o7ev0mLHgdP/Z1zNmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV1f/dLgOTUUJP2a9Dfxf20PKyVy70F4h8msdJoJ6CcPr1JCUafYt0o6A1wcw2q7bgu4pGFuF0eaZc/pLGSj1nFbcAN06RuTBtX0+EgT8PcOCmCzLwUjmx4TTRqBL2o5hZtft0WOowUmR8+g1TxP9OnvVP0zyxZVzcflMTO7C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYnqg0yv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYnqg0yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782834983; x=1814370983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xVDOUIqDchQXDM+zhDkWofS86o7ev0mLHgdP/Z1zNmQ=;
  b=jYnqg0yvKQm3I6lMkF+gIxm8LrS+BqXPI5zC9MaFoE59W27zONZU2nrp
   X0Tikt5BoFGgw74VtYBQ3dTEDzCMT+ayleuti1C/JEt10FPlu9HbTrrqY
   g84TuqcZVuhgFgbRNrUSq5lwAu8QPN+TNNk9Q3pu243xEMZK+btc/LKiz
   kZaXf3YkuNn7o/W5S5ietyAFkdLi+ZwWRKmsjy93ATxRrTmwjZ5iOs2Fq
   bRPN5U+Pdokgv08vbcyc6xttDI8BNP63LaovMjK+x3jorqEO+l0AvVRsu
   XjwZZ9qaZfECs7m6KprtFdfnl4h84UN6mQxlXtj5yJxDFipMaEiAo8G+w
   A==;
X-CSE-ConnectionGUID: fzKNYqHHS3aJc4+9kqvEfg==
X-CSE-MsgGUID: gmGkDsCvSKOH1HEWcqouFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83426015"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83426015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:56:22 -0700
X-CSE-ConnectionGUID: lFEK6LfRQamP5GVWBoinwg==
X-CSE-MsgGUID: XKAYyzf9SmegkzDd7zRTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="247828514"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:56:19 -0700
Message-ID: <9f11ac88-0331-4767-a368-2bc934269ba9@intel.com>
Date: Tue, 30 Jun 2026 08:56:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/region: Scan all partitions for unmapped poison
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-3-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260630074657.43077-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 12:46 AM, Richard Cheng wrote:
> cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
> from ctx->part onward. A fully-mapped partition has no unmapped tail
> , it's a normal per-partition state, but the loop treated it with break,

The comma should be with 'tail'. weird line break?

> aborting the whole sweep and silently skipping unmapped poison in all
> later partition. Use continue so a fully-mapped partition is skipped and
> later partitions are still scanned.
> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..be246fb09c99 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2931,7 +2931,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  			offset = res->start;
>  		length = res->end - offset + 1;
>  		if (!length)
> -			break;
> +			continue;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			continue;

