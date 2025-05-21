Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209A231A3B
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852774; cv=none; b=bGIiQ6vR/mhsUVpekeUUfUluLwrx05XmVK3n9OTJBiFVFgGaH7Ui8ol7Cb3XqPQAvKGU16GPF8feBkiArYG3+fYe0gLj0pMGwuA6iYxDCiUJNDwmKTCYBPfw1ehLsB9seyu4rLxnh3yW9zATFNTGYxEgSXtGX1OaBmQmlXO3Iho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852774; c=relaxed/simple;
	bh=nm3YFIEmy94gsONlZ/zinbKt1WEKzIi9gx/+czuvCjw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uzlz3dsw8fLtodtmwx+RA38NAKSrfPPjdv6nU5Ynzvx9A65+d5HS28QA46QBtozn47UYF+ZwhCOU8Sgj6ezQSRz1CGGjQscShr39icaUM/N8VGxI+9Eh7yjChu+1lUwiJzZfXxDSHlnj5K33uwqmtb8gZ53rCWXSH5I7UIlHu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+oXS3Fk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+oXS3Fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747852772; x=1779388772;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nm3YFIEmy94gsONlZ/zinbKt1WEKzIi9gx/+czuvCjw=;
  b=H+oXS3FkDjpneBjodGvS0V2BCfeU8I2/3gifZZULdIj2w/LEQOYe9Nty
   bBez366uakb80I3yVHkmq/OLFDdFro7owIbNdKNOpglSkIxVXoGPWfWvo
   t+b67/x8+jdy2Twci1MaAYp4sIYuFMZwKUyWuFzEo5r4INdHL00fd5CvC
   zJhzQL5evAycusqWYnUDT8e/VOE3fHXN6ILjzej/aqvLVDIxkzgsnZPfR
   WS4vDyPZUhMRKfHXj/m+DW/CLlUd2f1yYz83eVRX+z8MH0CoGwmTie4/v
   18DIeb77InfIBoIFIqNHOMtvvYdt9fOL6ZhoRz02gNJmO23hqh1IB3NY2
   A==;
X-CSE-ConnectionGUID: hywIh+ZKSQa6OOGNPXIKTQ==
X-CSE-MsgGUID: YBhBAxRqTISBPfot9YpYvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60487381"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60487381"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:39:30 -0700
X-CSE-ConnectionGUID: zDwc9gwXTPimyvAodCOabg==
X-CSE-MsgGUID: KdYJlpDeRvOHokZXrLxE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="144164628"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.106]) ([10.125.109.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:39:30 -0700
Message-ID: <58d89978-122f-4c79-ba04-98a1ec6e4418@intel.com>
Date: Wed, 21 May 2025 11:39:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] cxl: Add helper to detect top of CXL device
 topology
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Jonathan Cameron <Jonsathan.Cameron@huawei.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-3-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250521183443.3828320-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 11:34 AM, Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.
> 
> Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>

I'll fix the email address. :)
DJ

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 726bd4a7de27..cafb1b13cba1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/*
> + * The terminal device in PCI is NULL and @platform_bus
> + * for platform devices (for cxl_test)
> + */
> +static bool is_cxl_hierarchy_head(struct device *dev)
> +{
> +	return (!dev || dev == &platform_bus);
> +}
> +
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
>  	lockdep_assert_held(&cxl_region_rwsem);
> @@ -1642,11 +1651,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> -		/*
> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> -		 * for platform devices
> -		 */
> -		if (!dport_dev || dport_dev == &platform_bus)
> +		if (is_cxl_hierarchy_head(dport_dev))
>  			return 0;
>  
>  		uport_dev = dport_dev->parent;

