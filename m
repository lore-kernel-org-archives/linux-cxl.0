Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3219E82A
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667534; cv=none; b=gQBBoniqsDBBGxZM0OIiibVdsFQ1aP3lrbp4EFiB2msvM3/FFZ41eKxqRRZ1hodRR5oFVta7cNTakBX8vkhufQkZ2tYcVgS6Jkgjc/MkBmQZVg6AAysRFyip7lzSpWmq8n5mI+6CuIxSgTxgUp8aBnUPFv87jHtU/1Bz5OxAJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667534; c=relaxed/simple;
	bh=zcX/AgMc7T0SWereGnWnnCMiKC6j791RdkflJmO51rs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ5Wap6yYABXmthLn2cyG8HPa+vGL8ITCREzjtMdeCmosByTN8dbCxLpGei+bNTAlwNSC8qxaLsj2YBpK2JTI+PdcFojczW81FF++5ItRoQi/YgQh221chbDD+gfVB7woXVBtBqrcUnek1Cb/05K9LZXkxAElALuzAFnYkD8KS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwwCk5j6zz67G6Z;
	Wed, 29 Oct 2025 00:03:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BCD11402F7;
	Wed, 29 Oct 2025 00:05:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:05:29 +0000
Date: Tue, 28 Oct 2025 16:05:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] cxl: Adjust extended linear cache failure emission
 in cxl_acpi
Message-ID: <20251028160527.00007723@huawei.com>
In-Reply-To: <20251003185509.3215900-1-dave.jiang@intel.com>
References: <20251003185509.3215900-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 11:55:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The cxl_acpi module spams "Extended linear cache calculation failed"
> when the hmat memory target is not found for a node. This is normal
> when the memory target does not contain extended linear cache
> attributes. Adjust cxl_acpi_set_cache_size() to just return 0 if error
> is returned from hmat_get_extended_linear_cache_size(). That is the
> only error returned from hmat_get_extended_linear_cache_size() as
> -ENOENT.
> 
> Also remove the check for -EOPNOTSUPP in cxl_setup_extended_linear_cache()
> since that errno is never returned by cxl_acpi_set_cache_size().
> 
> Suggeted-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Minor thing below. Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> ---
> v2:
> - Rename subject line to reflect new changes.
> - Further analysis of the code and determined this is the correct
>   change.
> ---
>  drivers/cxl/acpi.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d7a5539d07d4..cc4d7bf381d3 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -353,7 +353,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  
>  	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
>  	if (rc)
> -		return rc;
> +		return 0;
>  
>  	/*
>  	 * The cache range is expected to be within the CFMWS.
> @@ -381,15 +381,13 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
>  	if (!rc)
>  		return;
I'd prefer a logic flip so the error is out of line.

	if (rc) {
		/*
		 * Failing to support extended linear cache region resize does not
		 * prevent the region from functioning. Only causes cxl list showing
		 * incorrect region size.
		 */
		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
			 "Extended linear cache calculation failed rc:%d\n", rc);
 		cxlrd->cache_size = 0;
	}
}
>  
> -	if (rc != -EOPNOTSUPP) {
> -		/*
> -		 * Failing to support extended linear cache region resize does not
> -		 * prevent the region from functioning. Only causes cxl list showing
> -		 * incorrect region size.
> -		 */
> -		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> -			 "Extended linear cache calculation failed rc:%d\n", rc);
> -	}
> +	/*
> +	 * Failing to retrieve extended linear cache region resize does not
> +	 * prevent the region from functioning. Only causes cxl list showing
> +	 * incorrect region size.
> +	 */
> +	dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> +		 "Extended linear cache retrieval failed rc:%d\n", rc);
>  
>  	/* Ignoring return code */
>  	cxlrd->cache_size = 0;
> 
> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58

