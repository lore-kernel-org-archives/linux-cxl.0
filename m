Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03478F40;
	Tue,  7 Jan 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267868; cv=none; b=dDRJRQrc6T0005CmYXjZoZvNhXVBME7YaPQX1aeWc8BA0tpCoM+JgT3bUrakIN3KwH2X03laRTIqRfIOqyPk+mEqRx3jUQj/Dp1PZh2fu5g75ERofsDV+p/sA2xOxe9DiYNyjN2Kdb/o+Oyv6wb+dLptaSk2SjqoMY74Ua2jB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267868; c=relaxed/simple;
	bh=i3Kz07eu+qo9J9xe554n54uFCbpbydbUPLAhYKEU32A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z89dJqdXnmCLlVsrhlwxgxHUHVhgyYZUiIRHLCfdNDTrAP3bfWfwHOtKzzNun47T+Gxjc4BHY39FRzPELDvovjd+PO+S5Zmp44iPwo3Wz7iiV6uH13OW9udyF2zL/MwuBQ5gr6BiM5VEoo9fMg9pWxUyL4t3XbYQwFxESGMgnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbsdHA4c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbsdHA4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736267865; x=1767803865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i3Kz07eu+qo9J9xe554n54uFCbpbydbUPLAhYKEU32A=;
  b=fbsdHA4cfo8ctULeL30+SekzjPh1RbFej4BOaXAB1YDC5SUKGZDiQ20K
   wfuWC0NCJg1ipJqParnzz4BVu8BQJuc/Y07I8pYE8AEUWZOIvTrsT/pfG
   4Xuf8rcfhujXyRwehVFvAF2Fd9938YmQQ42CuBooQ3XtmleQkqu6rMJWu
   CawFy6oLxccB2A8ZbXElEpiMM0jc13gndgLgOZo79POqkyYogyDRdINMi
   k5dprgpU7K3Gpgygq+He/mqNwC5QOWbIe38arcDC7IDhWPQ1jemWw4yrQ
   YnQPccM1ZJ1EP039U8+XLNN/p1m3I43BDgFFboXEh5ehYJ3WhafDjBn/E
   g==;
X-CSE-ConnectionGUID: G9fZD9qRQmaZtXpz6LtFJg==
X-CSE-MsgGUID: arGFOwCPSpKpVcZblZgtTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36353151"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="36353151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 08:37:45 -0800
X-CSE-ConnectionGUID: kAN0xY1bTKCDcXQoIFtjpA==
X-CSE-MsgGUID: b7yneOtWSoqEUFKm/vwMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140163495"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 08:37:44 -0800
Message-ID: <d31c9a2d-d650-4b7b-9ec4-2347db07bbdb@intel.com>
Date: Tue, 7 Jan 2025 09:37:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/29] cxl: Remove else after return
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-2-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250107141015.3367194-2-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/25 7:09 AM, Robert Richter wrote:
> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Just send this ahead of the series to reduce this series size. It's trivial enough I can probably take it for 5.13 merge window.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/cdat.c   | 2 +-
>  drivers/cxl/core/pci.c    | 3 ++-
>  drivers/cxl/core/region.c | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..2e69d9f27028 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
>  	 */
>  	if (entry == 0xffff || !entry)
>  		return 0;
> -	else if (base > (UINT_MAX / (entry)))
> +	if (base > (UINT_MAX / (entry)))
>  		return 0;
>  
>  	/*
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b3aac9964e0d..3e8d20f8955c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 */
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
> -	else if (!hdm)
> +
> +	if (!hdm)
>  		return -ENODEV;
>  
>  	root = to_cxl_port(port->dev.parent);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b98b1ccffd1c..9b3efa841c8f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1915,7 +1915,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "region already active\n");
>  		return -EBUSY;
> -	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +	}
> +
> +	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "interleave config missing\n");
>  		return -ENXIO;
>  	}

