Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5D3E1215;
	Thu,  9 Apr 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753928; cv=none; b=MpW27JQcXxumdVWxQgeixFOliVYBcucKZEDi0Q5daBKsSvN5SoPRmC4FNueLLEW8hD3oLj73rg6gal3tCq7fDXKanEBp2NDlM3J34ZQfzB+l/mlUIQhJenwXtlmeoHTHfGGK9XXWJU/HnOF/nhNV5j74SJfBXtLecNa55fUaBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753928; c=relaxed/simple;
	bh=oC33RQUUkPOsEx8hJIGt80+VB7Bn0+enTUYOE2HC4d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke+kqdhJlrXoysUZ026mhpUxfe457tcHTm2kewpfg4U8bGyF/QCxXdXElABgRCaUMm2juzQMy1vCuLgYcy/Qm6hlfHxONpR2dOGqmctwWwJQeENqkLeq7fMkNYlbJqkEhcYBnDILoa3SPVfzogJ5vLcYH/50dd0S6DwjsmbQFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kx5Zdpm4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx5Zdpm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775753927; x=1807289927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oC33RQUUkPOsEx8hJIGt80+VB7Bn0+enTUYOE2HC4d0=;
  b=kx5Zdpm4y2NfdRC+3V1Xa8V/yvkY8broGIL6JsnSqZ1B0nhCoGWIAPwX
   +O8JlAb2xnejR0nqzWAJb9WzukUclngSI0lENOqBp6OthyFDqjznN1yvy
   mQqdrPhCDEVgfwW1j6L5IZ71Jfr0O+nJ6hpmf3973olE6/TkrJL+O0fv7
   b1ngficZiPqr4sJg68SeKbXySe0WqVnv43VF/1Slg/2zBKS3Qg4IpVMe8
   3TlmYrpHTHXaxa5A2uhXYfYtN+nZimX8KYo3YHIq3Ja97q0c4LL8eG6LO
   TzOCCLMYmVUIW9uMJYsXh9QbJwEvAFZ8mo77jLv33ksYm7v7wEPnPNue+
   w==;
X-CSE-ConnectionGUID: uZ8qVipWRC6jMckwpIDk5Q==
X-CSE-MsgGUID: H2Hh6ubpRCy8NhYt9Am1qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="64306587"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="64306587"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 09:58:47 -0700
X-CSE-ConnectionGUID: iEAuM+8jQG2kLRsu18VDtw==
X-CSE-MsgGUID: Y7q+CaZERGKkmxp0/O0riA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="252148632"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.241]) ([10.125.108.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 09:58:45 -0700
Message-ID: <88a34b0d-8d09-46fd-bcff-d2c1f5afff77@intel.com>
Date: Thu, 9 Apr 2026 09:58:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Validate partition index before array access
To: KobaK <kobak@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260409154445.2416120-1-kobak@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260409154445.2416120-1-kobak@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/26 8:44 AM, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> Check partition index bounds before accessing cxlds->part[] to prevent
> out-of-bounds access when part is -1 or invalid.
> 
> The partition index is read from cxled->part without validation. If it's
> negative or exceeds nr_partitions, accessing cxlds->part[part].mode will
> cause out-of-bounds array access.
> 
> Fixes: 5ec67596e368 ("cxl/region: Drop goto pattern of construct_region()")
> Signed-off-by: Koba Ko <kobak@nvidia.com>

Was this issue encountered during testing or just by inspection (or AI analysis)? I'm just curious on how this condition is triggered and if a regression unit test needs to be added.

DJ

> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index edc267c6cf77a..6be46636db7ee 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3712,6 +3712,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
> +	if (part < 0 || part >= cxlds->nr_partitions) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: invalid partition index %d (max %u)\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			part, cxlds->nr_partitions);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),

