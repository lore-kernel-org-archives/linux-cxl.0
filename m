Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155973F54CA;
	Wed, 19 Aug 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154713; cv=none; b=fHnKAu+VFIS2amf9cFS1NpbbE5hWLHzuzowv2BTeWVAKadTScoiZRcBqEMqG15YoGs43H2gw9PdUfeaj8NnFp31quQTkXXHB4Tzizc9d+9/OMIZ1A2zAfaJ3MxBNtRQ9JpZCofdbBp1UoWvqMBABDxUO3XqSZgJa+wEjfO5YxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154713; c=relaxed/simple;
	bh=cyYXqUZHLpBXn0j2hXrOwlR2lihbOJI5unarP7n3h/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez6+0Mp/rcddplvWiXMJGZGvVH5oi56Rts01Q9z1pAl2ttSqk2Bk6eP6pn8ygbhlOaLNRU+IFGj3cx5WO+sVAPaSOY+D/MFMhunKaQ8INf26JNnww/tG6dpyDNZ01fHJDnVH7DPNss49hlHEUzjN3NTRFKpspfzkbHW/D5Xxn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZ6DolRw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZ6DolRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787154711; x=1818690711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyYXqUZHLpBXn0j2hXrOwlR2lihbOJI5unarP7n3h/k=;
  b=CZ6DolRwnJHsQdhgfsVRfAmxCOsait6MZ04w/auD+8qGEmN2Ss+dOS+Y
   zZ8Hw2A3kI41KMU6HW/twzWXM+ZdAhsreo+FYvT/yT/imP4v3CvxQWBG3
   QOY68Gbia0YdVubG5GmXCZQsu+mz53PbxrVQdsgO5sMUvVtgE9BPTwL3b
   Zzj6hqyUjbv7s0yWXOj3OQYir1OSl9vCZjz2ZU0f9go3sFzt71L55Ah1i
   a0CLp4ZNiiBAOc6Z1sbqxEM6KqeuzH1JX+YQQVCCJDVjPEJbvySo2BbnS
   FO1uqXbraNWAfFJSLlIM2y2z6yfeKEs6uZHLy0dS1XBTe2WfrfQG7N9LR
   A==;
X-CSE-ConnectionGUID: cEH0DppRTDOZRNIRNyIHRg==
X-CSE-MsgGUID: ipYKYSIkQ1iQ3xFqsLxJnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91487422"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="91487422"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:51:49 -0700
X-CSE-ConnectionGUID: tNr2SmhFQSymp2cy0KA8zw==
X-CSE-MsgGUID: EwfhkAopRcqLYxK4Z3AmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="295502285"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:51:47 -0700
Message-ID: <e1726a8f-0ad6-4098-afcc-b04a3f073e03@intel.com>
Date: Wed, 19 Aug 2026 08:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-5-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813034538.13189-5-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 8:45 PM, Richard Cheng wrote:
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
> index ddf12075b95c..b7dc5d4988da 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	const struct resource *res;
> -	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc = 0;
>  
> @@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

