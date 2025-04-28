Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF061F4199;
	Mon, 28 Apr 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878092; cv=none; b=eb80CbDcsbNIidORYjy+CVIFQpS+lAz5ETOkTYlQSWxo0puJg7U8gCuHcp1FNu01UnQf51XjkPy4vQkgNqhDRRf3SCbQPB3duJFnr+Jkg4xjNSqxV1XwQ16CTvSSPv/W+0nQ+H9l7epTZJADKg1hNDDOgg4LizR25+4Xzsrk9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878092; c=relaxed/simple;
	bh=eUlXJLbLI0evP2NCBgC9iVd7P+RAYKc4rK0nLJsUf+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKUpux8pSnb5441fRiz9zIKK0F57c2OISDe85ABFYNHCbxpbmAtHzt3K3IJPObmkpwqys0CgmqzTtXRY0WPdDAscOmjKQ5pFRnAHEJwkWFcVghC+TQ/4iFCBhR/evgccfuI3I2cwcQjbD4nuNOmTrt6FcJcwrOhbOrQg8SUfGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1aQQ1R5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1aQQ1R5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745878091; x=1777414091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eUlXJLbLI0evP2NCBgC9iVd7P+RAYKc4rK0nLJsUf+E=;
  b=B1aQQ1R5YpdsCyEEhHhjRQ4I4eWtTYcxDVFGfg2gxuAAB9NQUFL6F1ps
   SpL3bjEJNOqJZ1GRbLBEdGqOkAreSVVNrFFeq3xwoBrHtDS3GZiF99wqQ
   FIayz/css5zlLM5yY6XPnOb3cZXuA9uI2MhyVE5T7fPyUbG1UpnGePBUp
   pByUEMMCn4nOw/zmAs7GyZ0RHK+Yc8G4Dr+XrLAxdBs595rRgbt3dTxCg
   M3g+d3QbuKbP+CpRpJSIr8mVpX5wv0jJw5zKZuUEPAf8iU5jTZHL8dtxS
   x6XnhjtxfLVPup8WkQn7fMUFsjwsWp5tA7/yUMnTisTT+ThvHPVWup/dV
   g==;
X-CSE-ConnectionGUID: 1vI2k0PKSaWAbGGOZTDATg==
X-CSE-MsgGUID: mDqd9izLTh+vL6y936O6rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="57687208"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="57687208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:08:09 -0700
X-CSE-ConnectionGUID: GtcKC3woR025oH6oV/WB+A==
X-CSE-MsgGUID: A9Ap8yQ0RgGXaqXcugnE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133955512"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:08:08 -0700
Message-ID: <fe3e2a84-babb-470f-b7ac-03c1fbcdbc29@intel.com>
Date: Mon, 28 Apr 2025 15:08:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-4-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250428214318.1682212-4-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:43 PM, Robert Richter wrote:
> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6386e84e51a4..80bfd8ca4f8d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -416,9 +416,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  
> +	/*
> +	 * If the HDM Decoder Capability does not exist and DVSEC was
> +	 * not setup, the DVSEC based emulation cannot be used.
> +	 */
>  	if (!hdm)
>  		return -ENODEV;
>  
> +	/* The HDM Decoder Capability exists but is globally disabled. */
> +
> +	/*
> +	 * If the DVSEC CXL Range registers are not enabled, just
> +	 * enable and use the HDM Decoder Capability registers.
> +	 */
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -427,6 +437,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. Check if at least one DVSEC range is enabled and allowed by
> +	 * the platform. That is, the DVSEC range must be covered by a locked
> +	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
> +	 * cannot be used.
> +	 */
> +
>  	root = to_cxl_port(port->dev.parent);
>  	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>  		root = to_cxl_port(root->dev.parent);
> @@ -454,15 +476,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return -ENXIO;
>  	}
>  
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> -	 */
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");

