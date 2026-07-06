Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132F38F252;
	Mon,  6 Jul 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358416; cv=none; b=NwAoSfpKF112pBv7M2XWM1qmh23vZ19NMmWdChKrdY6HH8xbkqobDzgI309uQQX4D3HYZ0p7/JkNeLMVx9Z25Cl0xKoXUv8Kor1z+Cwh+mMmMRELqWUKTSCOiiGjdYUts+RusTunaTkEE5XL7qeUpjJnU/TC//LTyAzEuJjjjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358416; c=relaxed/simple;
	bh=X1xTxRlg3eFYl3aXyFNadv0pUCDM4Rn1MWBFz5jUiDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeC6gaNMHhgLkKY7cIfsZjE90eNzcebLl4RGph2dULXHltFhwajXyQ88idZeZXtEuWXW0xKjt1JjattJvO+18Wgbuc9c/Dj3eI6DYQbiNKBzj7eA38Po3lwsvvuezVOEjmn+bL62KnFzc/TyUXbNvvaXWVLRckhd6sX9FJ1myYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRSQkaDd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRSQkaDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783358415; x=1814894415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X1xTxRlg3eFYl3aXyFNadv0pUCDM4Rn1MWBFz5jUiDA=;
  b=TRSQkaDdW1GckyjWh0w6MIBTPn/IL2JChspEwclRoS/Trd7eX+j6lNgL
   2aS1DmNaZ464uW4wT6hdahwp8Pf1rpGXW29lzXXdImNNIRWfEOnGuMTYB
   Ap4hXywHSIc0sqxQSrVjN6mvWizW1/odzFn4K/HemVgdypP7JTbVTs1wZ
   MOUjC/zmsbBRlNg20aEMNArEPa5OU6vr+nBzEhNxPuKPTSxvz7h9HJfps
   NaUpcJWRfHxJYpiS6jfFqSx1qiSEUPSJ7dWKcTpmPdF9I1D838MmoGnr6
   Tr/ywi7Vz7Q+7MDfn8QZXcn42tKvZ9CRK071f9rHyw28YjhAdF4fZ3VLe
   g==;
X-CSE-ConnectionGUID: C++L1i3AQ9+HSim8TgJSAQ==
X-CSE-MsgGUID: BGwdZHEYQX+h0yofv7X+vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="106797710"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="106797710"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:14 -0700
X-CSE-ConnectionGUID: AKfGmrgOShCC/ei9CZdCPQ==
X-CSE-MsgGUID: TEkoY+eCSCK7r+0ZTgVlOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="251096321"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:13 -0700
Message-ID: <71aaef35-bf04-4300-910d-f9f9d5549e97@intel.com>
Date: Mon, 6 Jul 2026 10:20:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260702090849.47501-1-icheng@nvidia.com>
 <20260702090849.47501-5-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260702090849.47501-5-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/26 2:08 AM, Richard Cheng wrote:
> poison_by_decoder() stops at the last committed decoder and records the
> handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
> starts after the highest DPA allocation instead. Allocation exist for
> uncommitted decoders too, so their DPA is skipped by both phases and
> poison there is never reported. Resume the scan at ctx->offset, and scan
> later partitions in full, restoring the pre-rewrite behavior.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changelog:
> 
> v1->v2:
>     - New added patch ( sashiko's report )
> ---
>  drivers/cxl/core/region.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 52ba8e9e4288..ba77416055f4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2910,7 +2910,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	const struct resource *res;
> -	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc = 0;
>  
> @@ -2923,10 +2922,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  	 */
>  	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
>  		res = &cxlds->part[i].res;
> -		for (p = res->child, last = NULL; p; p = p->sibling)
> -			last = p;
> -		if (last)
> -			offset = last->end + 1;
> +		if (i == ctx->part)
> +			offset = ctx->offset;
>  		else
>  			offset = res->start;
>  		length = res->end - offset + 1;

