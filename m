Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681B1DE4C4
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065666; cv=none; b=NlPyQjsu4Y5GXhekSLohMuosDXMxkc2iE6pNOfm8Upk0KvCDeYIa2V47n+CelMgvPUEFmtQ8cDJkl/o3L7ThGV63PZpvWG1q9PhfeUiAMDenHEfNTLYVQo1v8jF67+k+unnwRtFK2BncRpVhf2eGWMdAsRODGo+yPCMrLXXQmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065666; c=relaxed/simple;
	bh=rQOMsRGm+VP9bGhdWjWevtqmOzE8h8G8y4d0KdlQoPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eItLa0cfCfO8BknkMi0chazLs+vj383YZa10od8OBP3AkPFJpjtRsjJ9YfO3O6sT8KHGsnyAbjhuo84NStvz907BJc9b8r9HdDvuEOefyIVtRmLGbvV4Mqg6MtPuxMJLFd4DZBuOEPVLdm6WdrUjW+RoVMtcrMix8fzezTla4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaLjpSP1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaLjpSP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740065664; x=1771601664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQOMsRGm+VP9bGhdWjWevtqmOzE8h8G8y4d0KdlQoPo=;
  b=UaLjpSP1ZBrIkEdadeSE/FIDXtumTfm3WyZu86cShKaNUswGFnsEF9QW
   HbZuClUU1r2sYA1QcsG1cIog8TdbFdxQ74RGL4/Jpa3VMio/btsExjd6L
   k8TJg+WZMRmvUYzw7IVPF2F/oMz9TZQKxv8Jwb36h3ParP5X7o0jokngW
   h1hlaOZlJAcImdHHib1zjlSFkYRmmYaQhP25qeOGZbvowAeqmr2JchVgE
   rIbwVTt2CdHxT3A5UyFFawXVrWgtnp0Fk8TWMACMEK7Mm8VBeI8QFtvYA
   t6dC6HNAZpgt7X9W5iBUuIOGV012W7IBwTLVIRH+A7XVbXRLs467DmWeZ
   A==;
X-CSE-ConnectionGUID: KkhL1JXATXaP3J2namTNRg==
X-CSE-MsgGUID: kjMvi/2FS+S4Xo0j3Hzx9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40565746"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40565746"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:34:24 -0800
X-CSE-ConnectionGUID: N5BEe2BmSeyRJ1lm5nmwNw==
X-CSE-MsgGUID: 1xVdjpWXRMS8Gfqm02RICw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115012255"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.109]) ([10.125.110.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:34:23 -0800
Message-ID: <a46ac4cb-cc20-4a96-89f0-743d32197e48@intel.com>
Date: Thu, 20 Feb 2025 08:34:22 -0700
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
 ming.li@zohomail.com, a.manzanares@samsung.com, fan.ni@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250220013604.263489-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 6:36 PM, Davidlohr Bueso wrote:
> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 30 ++++++++++++++++++++----------
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..96fecb799cbc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1072,6 +1072,22 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  #define GPF_TIMEOUT_BASE_MAX 2
>  #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
>  
> +u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port)
> +{
> +	u16 dvsec;
> +
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	dvsec = pci_find_dvsec_capability(to_pci_dev(dev), PCI_VENDOR_ID_CXL,
> +			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +	if (!dvsec)
> +		dev_warn(dev, "%s GPF DVSEC not present\n",
> +			 is_port ? "Port" : "Device");
> +	return dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
> +
>  static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  {
>  	u64 base, scale;
> @@ -1116,26 +1132,20 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
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
> +		if (!dvsec)
>  			return -EINVAL;
> -		}
>  
>  		port->gpf_dvsec = dvsec;
>  	}
>  
> +	pdev = to_pci_dev(dport_dev);
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
>  	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..29f2ab0d5bf6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -901,4 +901,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  #define __mock static
>  #endif
>  
> +u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port);
> +
>  #endif /* __CXL_H__ */

