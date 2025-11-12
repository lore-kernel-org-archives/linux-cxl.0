Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD82E92DA
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984899; cv=none; b=PinRRiIWQgM1qhWB7uls1RSuOQKExqPNYvNxvULbXt/iNw1ChLQCqsRNcyzvWkSjtVOqD+GGTcRaRj/MoixjF5PlsSCstIUz4lvulDWgmPPviS2z7atZPNuZ7lR1b1q5u0c27F+QcMEmdze4CWScxLD5qpYIEprt9P5BLMO7pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984899; c=relaxed/simple;
	bh=owyogqBuAVW7bQ9lKnJ/8lAnzgSFbsHoIJ+cXsED/p8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lij/7CZGex7JPY1wRiM5gDbTmtLcbD5fk/0+U7GhK+W8F1tttOCbJj9mLsyr9XhyTQkt0h6Xq2QKFnP89Wd2l7yyYMFA9KentLoEguXonTk6t4MqylK/7QjEqzJKf4lJdK4l4mE2IJt5eJLhih5YTEcKxilUEX40Vt+SPdl1sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOWV3UDm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOWV3UDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762984897; x=1794520897;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=owyogqBuAVW7bQ9lKnJ/8lAnzgSFbsHoIJ+cXsED/p8=;
  b=MOWV3UDmC2PeVnsYD1RqlrtSZD3cYMecE/oHVHaXJC3dSJSZVfw+hkJY
   ljICDvilJUuchrDhIKywUFhK4P9pQHTUUWNPn4clvgOvdMiQgTZ7u6uU4
   1FIenQIJq1Y7ycHiwAFoUB/fmitvqJOzvaBnllAj9U+k/q+I4xKdnRg+T
   Io1/0Lld69K8bKz/yvV1wRJm1+kiHHeKu4Gd8A3/DVJAa/luXgWIbg9iE
   xMNp8CitXbzhoLlwbaS1+2UVSsnKDBNdhivMr2m6DGBWnC5yvu1C9tSxR
   I833Tu5OFpkVdSXBR/S/n3Qom0WaGNsPnFi8kOIeZoNhUH+EhrAtugphV
   A==;
X-CSE-ConnectionGUID: LT2d99mMS+CUIhHoiiWcTw==
X-CSE-MsgGUID: j+/gzbY+Qa2pCbEzFZlG0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90531728"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="90531728"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:01:36 -0800
X-CSE-ConnectionGUID: 2Qj0WhfGTf2+c4bws3mvCA==
X-CSE-MsgGUID: /gseOEJUR3mHA6Un92PNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="219985400"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:01:36 -0800
Message-ID: <99bd23dc-c15c-4bff-a23e-02ee4400e782@intel.com>
Date: Wed, 12 Nov 2025 15:01:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Add handling of locked CXL decoder
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251105201826.2901915-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251105201826.2901915-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 1:18 PM, Dave Jiang wrote:
> When a decoder is locked, it means that its configuration cannot be
> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
> locked decoders. Locking happens when bit 8 of the decoder control
> register is set and then the decoder is committed afterwards (CXL
> spec r3.2 8.2.4.20.7).
> 
> Given that the driver creates a virtual decoder for each CFMWS, the
> Fixed Device Configuration (bit 4) of the Window Restriction field is
> considered as locking for the virtual decoder by the driver.
> 
> The current driver code disregards the locked status and a region can
> be destroyed regardless of the locking state.
> 
> Add a region flag to indicate the region is in a locked configuration.
> The driver will considered a region locked if the CFMWS or any decoder
> is configured as locked. The consideration is all or nothing regarding
> the locked state. It is reasonable to determine the region "locked"
> status while the region is being assembled based on the decoders.
> 
> Add a check in region commit_store() to intercept when a 0 is written
> to the commit sysfs attribute in order to prevent the destruction of a
> region when in locked state. This should be the only entry point from user
> space to destroy a region.
> 
> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
> decoder within the kernel driver.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Applied to cxl/next:
2230c4bdc4120417799c74326ade3123da226d54

> ---
> v3:
> - Move region lock check to cxl_region_decode_reset(). (Alejandro)
> ---
>  drivers/cxl/core/hdm.c    |  3 +++
>  drivers/cxl/core/region.c | 19 +++++++++++++++++++
>  drivers/cxl/cxl.h         |  8 ++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..1c5d2022c87a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return;
>  
> +	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +		return;
> +
>  	if (port->commit_end == id)
>  		cxl_port_commit_reap(cxld);
>  	else
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..b52738e46b5d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -245,6 +245,9 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return;
> +
>  	/*
>  	 * Before region teardown attempt to flush, evict any data cached for
>  	 * this region, or scream loudly about missing arch / platform support
> @@ -419,6 +422,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  		return len;
>  	}
>  
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return -EPERM;
> +
>  	rc = queue_reset(cxlr);
>  	if (rc)
>  		return rc;
> @@ -1059,6 +1065,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +static void cxl_region_set_lock(struct cxl_region *cxlr,
> +				struct cxl_decoder *cxld)
> +{
> +	if (!test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +		return;
> +
> +	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +}
> +
>  /**
>   * cxl_port_attach_region() - track a region's interest in a port by endpoint
>   * @port: port to add a new region reference 'struct cxl_region_ref'
> @@ -1170,6 +1186,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  	}
>  
> +	cxl_region_set_lock(cxlr, cxld);
> +
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> @@ -2439,6 +2457,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_region_type;
>  	cxlr->id = id;
> +	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>  
>  	return cxlr;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 231ddccf8977..6382f1983865 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/*
> + * Indicate whether this region is locked due to 1 or more decoders that have
> + * been locked. The approach of all or nothing is taken with regard to the
> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
> + * set.
> + */
> +#define CXL_REGION_F_LOCK 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

