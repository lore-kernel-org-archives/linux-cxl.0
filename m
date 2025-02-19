Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D002147F9
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988489; cv=none; b=EkpS0i98q1yDDF76bUKenEX4p9OIQK1jOfrzIghSUN1Zn+q0q2IoALNf3MNByhCkD8+nJKO4HYVmzGOZFxtssf1CheR4MgNPS7x1JGKC13anoJES1d5EDiV4C/uUw/e9vMLFVLcxGKuSNvSmOVkD1lgoUWgh6hPDkkR86DnUvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988489; c=relaxed/simple;
	bh=wP/FWCcutbAJeF+aaxdbU4nWT//aOGELqPBiUA+jimo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP8CQteUBbmdD2UwzjMnV+/3mL90+cq4OmJ9QqjuxhcH9rcgRXNgkUBo0r95ZoDjUh8V/FabxRPqR4M8ifhhbeqNqHgVzCSHInX/q9DSX7ozdU/1G/S/sskaB5/Dg3/xvaf8gs5U/RwiEsa1VGyoGcl2OA4AbXPyW8RVf/F8GxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAmasmZh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAmasmZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739988488; x=1771524488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wP/FWCcutbAJeF+aaxdbU4nWT//aOGELqPBiUA+jimo=;
  b=mAmasmZhoNy6erLoi7nsBDxvkdrqU37oxKKi3su1zigLyQP2rn9U/o5x
   Zqy/xTxC7Rfz9AocJG1AVtEr/v20eZu+vkHBUpbZNdlii5T/bQjgur6gK
   ObnPSgd8BFav0S16bNmYkD/iRoMbXbmsUU0yfxgSsEfm7EpnFX19QL15E
   di+7JpvM16nJJ82WnWKMB4O+v76b1YTOS6Er1TXdhK9m6OwDFQGdDCfVZ
   x8cg7EQWelVrVrb+ar6KxyCIwJslbkOaGNzbBpcZ854dSP6HFhTd8KI7O
   Cduk60JxhxVGaH+A7/nzy4D3qucj8bLymI1FNwgv8t5hxI4vnbUx7Cc1a
   w==;
X-CSE-ConnectionGUID: LMUXGHtGRCW4rSthA+TqBA==
X-CSE-MsgGUID: Hbw2l4a9SrqE3gUR4qlRnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58149155"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58149155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:08:08 -0800
X-CSE-ConnectionGUID: LSRMkXH1SzGLEJwWYvUHwA==
X-CSE-MsgGUID: iKTWH52uRMqmzgJCGnbF6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114623326"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:27:21 -0800
Message-ID: <0c2f9ba2-19f7-4014-9290-cdf9dc271934@intel.com>
Date: Wed, 19 Feb 2025 09:27:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219062832.237881-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 11:28 PM, Davidlohr Bueso wrote:
> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..2226cca3382d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1072,6 +1072,27 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  #define GPF_TIMEOUT_BASE_MAX 2
>  #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
>  
> +int cxl_gpf_get_dvsec(struct device *dev, bool port)

Maybe consider enum instead of bool. That would make it more readable. if not, maybe rename the bool to is_port

> +{
> +	struct pci_dev *pdev;
> +	int dvsec;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;

Since this function is mostly a wrapper for pci_find_dvsec_capability(), why not have it return type to be u16 and just return 0 here? That way when you check you only need to verify if it's 0 (failed). 

> +
> +	pdev = to_pci_dev(dev);
> +	if (!pdev)
> +		return -EINVAL;

No need to check here. to_pci_dev() does not return a NULL. 

> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +			port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +	if (!dvsec)
> +		pci_warn(pdev, "%s GPF DVSEC not present\n",

why not just dev_warn() since this is cxl code and not PCI core

> +			 port ? "Port" : "Device");
> +	return dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
> +
>  static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  {
>  	u64 base, scale;
> @@ -1116,26 +1137,23 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>  {
>  	struct pci_dev *pdev;
>  
> -	if (!dev_is_pci(dport_dev))
> -		return 0;
> -
> -	pdev = to_pci_dev(dport_dev);
> -	if (!pdev || !port)
> +	if (!port)
>  		return -EINVAL;
>  
>  	if (!port->gpf_dvsec) {
>  		int dvsec;
>  
> -		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -						  CXL_DVSEC_PORT_GPF);
> -		if (!dvsec) {
> -			pci_warn(pdev, "Port GPF DVSEC not present\n");
> +		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
> +		if (dvsec <= 0)
>  			return -EINVAL;
> -		}
>  
>  		port->gpf_dvsec = dvsec;
>  	}
>  
> +	pdev = to_pci_dev(dport_dev);
> +	if (!pdev)
> +		return -EINVAL;

No need to check here. macro does not return NULL.

> +
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..acbbba41356d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -901,4 +901,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  #define __mock static
>  #endif
>  
> +int cxl_gpf_get_dvsec(struct device *dev, bool port);
> +
>  #endif /* __CXL_H__ */

