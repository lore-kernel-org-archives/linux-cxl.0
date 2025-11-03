Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E64279DAE;
	Mon,  3 Nov 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211353; cv=none; b=Y6yYCBBI0r8eBUCJgQ+JnENANC+zkh+BsnGpXbW3ioGA6ssH1LJriXI+FRWUY/kP0SVVw4/BEPj2w5HMqq+rf3O0tlqesTtIXwYrl/mlNjV6OtiQ5ArlaX9QOAY6GnZ5pZfGOQO2halq8nsOqrA+4CXudpYeLzTlzE1ne9L0ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211353; c=relaxed/simple;
	bh=QvMpsgaSDen4lyz7AxCBQwLm8CEwLKEYNKi2d76kCso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkWdOfjkWzJXeWl4EYRG7aR2Udi3O1WlYpMx7s29MxVxehjHyFuMscXS4XW7d8LVE3JDBpInx/FUzhvaGkAuY5iTD/FyCw7h1428J4HSkxCK89h3sJ7a4hXMwMGX/1KdpBAO/Ej1+FK+P4s87V3RLZw6EKSIkjopqHDVZzMC/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed/2eeUb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed/2eeUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762211352; x=1793747352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QvMpsgaSDen4lyz7AxCBQwLm8CEwLKEYNKi2d76kCso=;
  b=Ed/2eeUbv5r/pCnGgbDqYdBqVi9d8ioiYpgl6moJRZdIV63/A6JM1y3j
   PoranySTbE0JlrOIhSkbhPPOH6+rNPBBKgBJq4Vo7CyFXUOQCBEukXHFA
   /kxMmvK8HAXfAHGTg5zgqjNaBhVpVYbYk3cyWkc2zmhnAdlWDMkzUOOmn
   FTgJ6XLyqguuEFUttqQtD5Qbp69fF0BYV7+U8sgq69EExwksFvlQ+FRut
   5ahxGK9q3+yFjZ5n/8aZV7G/JtpRLmZ7yo4+8FCjeaJqjxzTW4XuwxPDJ
   vE8EzYho61mXLVrKhCqLIaZfANI0q6elkA9WbK8TPjdABKaRF0WUFtvsp
   A==;
X-CSE-ConnectionGUID: XVwbS4PlTQ6Nr8fMVsVeng==
X-CSE-MsgGUID: kQLEDBbcT1uGnzZpTUP4nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81705670"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="81705670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:09:11 -0800
X-CSE-ConnectionGUID: EcOEjnIPRkmITq9jZ+s5Iw==
X-CSE-MsgGUID: m4rW2RntRiWAVflq0sNu/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186672685"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:09:10 -0800
Message-ID: <1e3dffee-ffa9-452f-ae9c-83093460103f@intel.com>
Date: Mon, 3 Nov 2025 16:09:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] cxl: Introduce callback for HPA address ranges
 translation
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-9-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-9-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> Introduce a callback to translate an endpoint's HPA range to the
> address range of the root port which is the System Physical Address
> (SPA) range used by a region. The callback can be set if a platform
> needs to handle address translation.
> 
> The callback is attached to the root port. An endpoint's root port can
> easily be determined in the PCI hierarchy without any CXL specific
> knowledge. This allows the early use of address translation for CXL
> enumeration. Address translation is esp. needed for the detection of
> the root decoders. Thus, the callback is embedded in struct
> cxl_root_ops instead of struct cxl_rd_ops.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/region.c | 19 +++++++++++++++++++
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2dd9e9be4889..379a67cc8e31 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3364,6 +3364,15 @@ static int match_root_decoder(struct device *dev, const void *data)
>  	return range_contains(r1, r2);
>  }
>  
> +static int translate_hpa_range(struct cxl_root *cxl_root,
> +			       struct cxl_region_context *ctx)
> +{
> +	if (!cxl_root->ops.translate_hpa_range)
> +		return 0;
> +
> +	return cxl_root->ops.translate_hpa_range(cxl_root, ctx);
> +}
> +
>  static struct cxl_root_decoder *
>  get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
>  		     struct cxl_region_context *ctx)
> @@ -3371,6 +3380,16 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct device *cxlrd_dev;
> +	int rc;
> +
> +	rc = translate_hpa_range(cxl_root, ctx);
> +	if (rc) {
> +		dev_err(port->uport_dev,
> +			"%s:%s Failed to translate address range %#llx:%#llx\n",
> +			dev_name(&ctx->cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			ctx->hpa_range.start, ctx->hpa_range.end);
> +		return ERR_PTR(rc);
> +	}
>  
>  	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
>  				      match_root_decoder);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9a381c827416..94b9fcc07469 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -644,6 +644,7 @@ struct cxl_root_ops {
>  	int (*qos_class)(struct cxl_root *cxl_root,
>  			 struct access_coordinate *coord, int entries,
>  			 int *qos_class);
> +	int (*translate_hpa_range)(struct cxl_root *cxl_root, void *data);
>  };
>  
>  /**

