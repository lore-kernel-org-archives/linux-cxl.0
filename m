Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C8433A8;
	Mon, 23 Jun 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690282; cv=none; b=uvz9qJb25GSFD8SmGijSMEDKseNU1y73CtaidfK/X/MpME89g5q9zijZ7RxWJEpjNBDFxgzxA9u8K5UJsEkD/DFqVvK7Crjgw3le39QdQou4ZrdXvE43mOwi3NNIdIz4uFbWloct/0JRkbIq1n+l/JYvThT3T1W/V2PInZu2blM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690282; c=relaxed/simple;
	bh=bf8TIBVP9FgVJ5xoztwF4ppRrlZy1qaZ4xMEOoPGxTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRoGOjLclduccY5EabrNV49YgjUdWZvOccXklHZxS4DDYu43aN3MDbnv3uTp28MtRA2CnqiKHLn9ptRNAG23XPCS9UU+xV6muC/aCisCesZK6DX6Cxw+NzIQwNSwNalg/cIFtj7NHDUzFZKJPl8jNbxDgh3NG2SDmcJlfbu+lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OToxZIIP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OToxZIIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690281; x=1782226281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bf8TIBVP9FgVJ5xoztwF4ppRrlZy1qaZ4xMEOoPGxTk=;
  b=OToxZIIPzMJnMOEm1orRee6NCbmoYeCWPjxh73/rfoijqLt/2jjAk9/N
   6jACQBzVgl4yILxalpzLg+lq7ORQKWbFuVvLt10BLzanfkzYjEf4HB06e
   /KwKI0H/b5HsKUwvglFGIL3OMko81AGZ+XMuF7iN3TrEaThdV2PwAZgi7
   9BVxJTMm74jj/bueBTsIvGW8HyRGEYincw9yFFSO0DB4oMOGaZaIYfR0u
   GBnyGwdz1pUqVmLnViDQRTaK+aWmM85dQHvmCjF/DQr21/Fvpfx7LZ3lC
   2PZo751ZzIMssvcESQwKHguVUciC4AKcQIxhvnt1noV9DfwEclQG/S6bh
   g==;
X-CSE-ConnectionGUID: 2sxCJPUGTdCsiUPA6If1gw==
X-CSE-MsgGUID: sQMUtJvSRaOWenyMklUpuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52771202"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52771202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:51:20 -0700
X-CSE-ConnectionGUID: WxtZ9p+QR/GGBqrdHa+MUQ==
X-CSE-MsgGUID: RRtWJ+zdTbm2BjGCpiAudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="152139979"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.178]) ([10.125.108.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:51:20 -0700
Message-ID: <99145cb3-1cb7-43ef-84bd-203616d00681@intel.com>
Date: Mon, 23 Jun 2025 07:51:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] cxl/decoder: Drop pointless locking
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-5-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250619050416.782871-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/25 10:04 PM, Dan Williams wrote:
> cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
> decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
> dpa settings since it is merely clearing out whatever was there previously.
> 
> Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.
> 
> In preparationg for converting to rw_semaphore_acquire semantics, drop this
> locking.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 81556d12e9b8..e9cb34e30248 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -914,7 +914,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  			"%s: out of order reset, expected decoder%d.%d\n",
>  			dev_name(&cxld->dev), port->id, port->commit_end);
>  
> -	down_read(&cxl_dpa_rwsem);
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> @@ -923,7 +922,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	up_read(&cxl_dpa_rwsem);
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
>  

