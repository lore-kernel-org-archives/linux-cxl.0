Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD541D5CDD;
	Thu, 20 Feb 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073474; cv=none; b=ClvuKg4g4IMV+o+B1Ps5jSmvMkvcU8RhXYSQ5Ua3vPmNHzmOyu0AUwFC/i0JHTIJVT+O29r9vcztheLeYE3yKE5QZqnG1XgdvFGBg7L1XNCDNiznu1Bjr0k7z6axviMdoqKHfrhANGVV2UdstaHBUR/jM95X+HRoqBa4MIGHIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073474; c=relaxed/simple;
	bh=/jO93DbdKWVQELF3GxtLsNc9u6aZr3+EJaziqwQzcuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3OhUTm95xKWHrqIRhcFlAY+dpp4HBuxpNRRC0+pZIMuMalIJWZPTlUd89yCNrZ1EUFDQP898a4iCwERpEOlkhiYrxny8IpxNAxRSO+MjCElYhswpAjhSYZr3FnEcgY5PE53h69NyTBdNS3kGifY4w9/IU4N9IKdkYsvuT83E8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DA8d/h78; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DA8d/h78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740073473; x=1771609473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/jO93DbdKWVQELF3GxtLsNc9u6aZr3+EJaziqwQzcuE=;
  b=DA8d/h789jAvPPh61ZQGpWOK1KBIQDfbe/X891zGmySx5b+lAxMORJzf
   L16fh0dk9GSlAmDn4xWVBEjLgo/qAg5TuxKW90t8SW4A4AGwicAFKmx3U
   Ec1dVqu+E0AwKtFrPhcnlUN19QQuxQhZQlogRsZjxhYd0kh9d4atNGcrl
   TG5sGo5tgdfYPO1K33uSwx2YwMUVtfOTYiCtaTKr5P+0icFy1t4oZU/Yb
   PAK2lyqgABkLvdZjainJ0vVr1dF/ErSpN4Nq0fnZDlEhMR2upZXq9is1l
   WLlMwawsTwaMmHmY/pKQNU4rGkZdZqRGHfqXTRIloDwbPrv2iRz3yh/wQ
   w==;
X-CSE-ConnectionGUID: JYzx23FcQZG9BMypx9x6iQ==
X-CSE-MsgGUID: EMlR937rRyWDXZMCmpctEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40582816"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40582816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:44:32 -0800
X-CSE-ConnectionGUID: ahkX5fqmQNeCGqNHtatM9A==
X-CSE-MsgGUID: ziT3biEuTNyN0dHXmyBMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145967015"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:44:32 -0800
Message-ID: <aedbeda2-84d2-4a20-9933-9866ac270050@intel.com>
Date: Thu, 20 Feb 2025 10:44:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] cxl/region: Add a dev_err() on missing target
 list entries
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
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-17-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-17-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Example log messages:
> 
>   cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
>   cxl_port endpoint6: failed to register decoder6.0: -6
>   cxl_port endpoint6: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3031d4773274..a56b84e7103a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1790,6 +1790,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	}
>  	put_device(dev);
>  
> +	if (rc)
> +		dev_err(port->uport_dev,
> +			"failed to find %s:%s in target list of %s\n",
> +			dev_name(&port->dev),
> +			dev_name(port->parent_dport->dport_dev),
> +			dev_name(&cxlsd->cxld.dev));
> +
>  	return rc;
>  }
>  

