Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D93EB0E2
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028083; cv=none; b=T75JcwquJKmKTg9gjWOSxpQD0ZuDcDfogDMO/YkVtVf/Gf2n0+yzDl11jFb0CBi4a97DdidPWg6lmd9waXazFMp1wo2tYaByC5Z+qmQftF10I477l6FzXTVwUgvFXj59RzAAFfa+p3Mr3PKPO17xQpy3UosK/DO2C6iIRNuXYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028083; c=relaxed/simple;
	bh=jqnqhGNSXOSVm56VNN0v3orT/JF/LJ436AIUB2xrCqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnxgeyP6PWSkc148jgPGe8YrSkfPs7b9TfX/ALvh6aluYyGNCqvdt+vNYwTzPCFawEz2UrkVht6oYlWW1sDPIPAcSbzUBs3m5WMhWjmsfcM6uuZX5jpPCaUGdQJB1kaEt5jdVhp4jLyEt9IsTC1+XE0RRfPSmA5PE6LSuOTdW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUb9iwpm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUb9iwpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781028083; x=1812564083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jqnqhGNSXOSVm56VNN0v3orT/JF/LJ436AIUB2xrCqM=;
  b=HUb9iwpmiSVHMtrdOtIt59MD3png3SGmgqkLjuivwabaRbI6qOwh7NSK
   jg340TGOQ1KSodA/AuYLTd72lW4Ms5k0hFKwAGyt+KfWqmDDqzQ+k5ULF
   0nHWqt9w/fwrAIfIsNgzrqP+pLD70FLP/TegC4nEzUTMhHpIEHR0/LLWM
   8A0da2nXVk0/838HvpLvtBFZ5Y9tAd53kn1D1dhDdDxLmANgCOaHmzTFl
   LaCHDQZtrprzxMVo933M+POhAokas+8dXZGJv51esuIks7X3brRpgpTB4
   1aLcuSSpvuBgHK9QCDbrqKAX3Eyzz5/qmt/OnE4peLtis/YDz21GpxP98
   w==;
X-CSE-ConnectionGUID: RmwoVv1XThuOfWOH4hzs9Q==
X-CSE-MsgGUID: ZCPo7h7dQIqFpah75c2oMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81707920"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81707920"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:01:22 -0700
X-CSE-ConnectionGUID: VqZOphw/Sj22hNmuGaA6Ww==
X-CSE-MsgGUID: JssyFKtsTWulpweyPe+LKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245087162"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.206]) ([10.125.109.206])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:01:21 -0700
Message-ID: <40cee466-729a-467d-b93e-43c6f5057dfd@intel.com>
Date: Tue, 9 Jun 2026 11:01:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Avoid variable shadowing in region attach
 paths
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260605040504.865728-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605040504.865728-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 9:05 PM, Alison Schofield wrote:
> A couple of symbol declarations shadow earlier variables in the region
> attach paths. Shadowing makes it harder to tell which object is being
> referenced and can obscure future bugs.
> 
> Reuse the existing 'cxld' variable in cxl_port_attach_region() and
> rename the endpoint decoder iterator in cxl_region_attach() to avoid
> shadowing the function parameter.
> 
> No functional change.
> 
> Found with sparse.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
1e1edc973c64307821ee22049908e7ded8f973c2

> ---
>  drivers/cxl/core/region.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..819392c8f753 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1224,8 +1224,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			nr_targets_inc = true;
>  		}
>  	} else {
> -		struct cxl_decoder *cxld;
> -
>  		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  		if (!cxld) {
>  			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> @@ -2189,14 +2187,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	 * will fail when presented as CXL_REGION_F_AUTO.
>  	 */
>  	for (int i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_endpoint_decoder *target = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> -		dev_dbg(&cxled->cxld.dev,
> -			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
> -			(test_pos == cxled->pos) ? "success" : "fail",
> -			test_pos, cxled->pos);
> +		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> +		dev_dbg(&target->cxld.dev,
> +			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
> +			(test_pos == target->pos) ? "success" : "fail",
> +			test_pos, target->pos);
>  	}
>  
>  	return 0;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

