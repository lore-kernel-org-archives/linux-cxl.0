Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EA1F4725
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830859; cv=none; b=WctmMp7b0kB+tg+qWp5O9ujsbg27LkUL45sFvKkZ8OJNXZAmltrESdd3DasgsK4LpHhuDRoJH8dFGNaa0yl3iWTjfeKX+eEcL/wzGWgu9gG9cqSJbcvNfSoQOMx8xQ+9MkTI/Kz8T0gTcueOtyFgllAyth+/Ci+evJAuCEddSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830859; c=relaxed/simple;
	bh=xIFNOkL2jqHGsGKOLKqWidxVYaZ/d3R7afel6N7Nz8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFcmN96hSo4VjR/dAtaQ6Tp+G4WqXIZYQIY+1O9V8JNajB1FfA6MfcPeob6FCi7nGkdPJ95okRD+OANs09MXlEIdAohIFFxim1R0ajsCEf6oOJPz/Fryuoz976fO35Ar5V2SUyM96dHLeYiI6iJI7janNIMZZIBlGBZaCILx5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5bjzOUy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5bjzOUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749830858; x=1781366858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIFNOkL2jqHGsGKOLKqWidxVYaZ/d3R7afel6N7Nz8c=;
  b=n5bjzOUy0eOllp4tAhhk+Ggm6p+iYpMDrCAnIIlhW4UJThIQfzTf1UWh
   h49jyNxDTs/w81BWqCrfqdTfcRcmhikT7xUUoO9lFv6Mc0MIPcFGULfLe
   GUv/1wvHJvhL1i8WvLNZdRm4sOGO5sJxpPGXGHCRML4vCDpVtYdxd7zv+
   j1IQDYwOt7lT8/VLpjjLyZ7C9NFpVHfa3vpWQsIEbQlbg61Xw3wIWJr3k
   fyDGXltdBilMWpfc8hhXgUyTeDSaU+nj/G3HF8m+GTBHVBbiLik0EJFPY
   4lQ5gSZ0V/5eyuP1W/a38hWjCrEy6qA/Jw0hSwoBM2o4I+6Cu6FrC3phS
   A==;
X-CSE-ConnectionGUID: Q7TuqrdZS/+s4jWZ5E91Kw==
X-CSE-MsgGUID: KPG0BH/1RoGiw0FekOLH+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63462440"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="63462440"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:07:37 -0700
X-CSE-ConnectionGUID: Q1cUC8wuRke0xJJVUjVKMw==
X-CSE-MsgGUID: cFgqC9P4SViU86ui1vVFZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="152629961"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.232]) ([10.125.111.232])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:07:35 -0700
Message-ID: <47f0a4ee-92a7-4bb0-ac28-208ab4b2638a@intel.com>
Date: Fri, 13 Jun 2025 09:07:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Terry Bowman <terry.bowman@amd.com>,
 Li Ming <ming.li@zohomail.com>, Alison Schofield
 <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
 <20250612192043.2254617-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250612192043.2254617-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/25 12:20 PM, Dan Williams wrote:
> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
> 
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>    device, nothing guarantees that.
> 
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>    guarantees that.
> 
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>    reason as the trace is 100% generated from data in the record.
> 
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.
> 
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to cxl/fixes

> ---
> Changes in v2:
> * drop the reference from the result of bus_find_device() (Li Ming)
> 
>  drivers/cxl/core/ras.c | 47 ++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..2731ba3a0799 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -31,40 +31,38 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  					       ras_cap.header_log);
>  }
>  
> -static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> -				  struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> +					 struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -	struct cxl_dev_state *cxlds;
>  
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
> -	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	trace_cxl_aer_correctable_error(cxlmd, status);
>  }
>  
> -static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> -				    struct cxl_ras_capability_regs ras_cap)
> +static void
> +cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> +			       struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	struct cxl_dev_state *cxlds;
>  	u32 fe;
>  
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
>  	if (hweight32(status) > 1)
>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>  				   ras_cap.cap_control));
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
>  					  ras_cap.header_log);
>  }
>  
> +static int match_memdev_by_parent(struct device *dev, const void *uport)
> +{
> +	if (is_cxl_memdev(dev) && dev->parent == uport)
> +		return 1;
> +	return 0;
> +}
> +
>  static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -73,13 +71,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	struct cxl_memdev *cxlmd;
>  	int port_type;
>  
>  	if (!pdev)
>  		return;
>  
> -	guard(device)(&pdev->dev);
> -
>  	port_type = pci_pcie_type(pdev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>  	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> @@ -92,10 +89,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  	}
>  
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	struct device *mem_dev __free(put_device) = bus_find_device(
> +		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> +	if (!mem_dev)
> +		return;
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>  }
>  
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

