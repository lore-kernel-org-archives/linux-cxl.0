Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675F25E45A
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665681; cv=none; b=Bfin3217m2k0EPWol11I2jZ55zskeG6HPGWwx8i756A9Mh6XQaatMgKDInqEdRnRXCCoTJ+VLa8UrTBFfoJUcWsywJaF7LolIToUIHKrJqWklvqgyiFXKtL547jAHdTT2tG1V2CtzS8HVIEErGyKNXc5rrTakc1l/T65WnCXsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665681; c=relaxed/simple;
	bh=baIE4hmpqYLLNCGghGIRvONBll79zsyhoPB2Kf0w64M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj766Cqnu85MmHVI19Zwbtc8zhubDoPDQoLS2iLtvOl+8UGlaC84X2ysK3XNkdGgljc6jxbgpFtW3Rtl4xlrmArbWYVTb6OX6ANsAen/UEHpq/uNbjxcBF375VaGQ5X1nOILh1UKOOgouI+zgkvmV95wq9nimfrbIIRXPyW1BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLe0q8Km; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLe0q8Km"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665680; x=1781201680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=baIE4hmpqYLLNCGghGIRvONBll79zsyhoPB2Kf0w64M=;
  b=YLe0q8KmM9xHauyl/CsuSR4wc9tWrtFdcBawnbeHwkIzD6aiaTyqZX31
   mY5pNXc7vCt4QxijFy7M9rW+xVGBD7DPbqbaKjMaSmozpIehmmzyqNo9N
   pvDpOnSmCYiQyPzKQV9bVACCRolt/zMmaL8jBzh1PfucLYtxzKLjuKivO
   HgXuLN/VCNExZLP0yE0wHDNfF1q/krd99xkAuKXRX/D36CxCOVZtfA9s+
   myS8nEwmCN6kBf8FoM84/1VFcslzYVpzO6MZkQfImB49GOQ9PEXtaUr+O
   Q4kYrMQUkCBJ5bCkI8NqQ2Jk3SSrMXBocodBqtDijoTyxa7Qzy+TAX14s
   Q==;
X-CSE-ConnectionGUID: Ga6RG0f0RZCX2v1X/h4M+Q==
X-CSE-MsgGUID: UGiRzljgRB6SIJFJv/UbpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51736610"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51736610"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:14:39 -0700
X-CSE-ConnectionGUID: GfwLsFpgSOC+6RmhZjj2+g==
X-CSE-MsgGUID: mBZwYimvRbWSWpC7ZO+LpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152539848"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.168]) ([10.125.111.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:14:38 -0700
Message-ID: <78b83a10-ac36-4787-9446-388c5daa289e@intel.com>
Date: Wed, 11 Jun 2025 11:14:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/25 10:17 AM, Dan Williams wrote:
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
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/ras.c | 48 ++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..1173eaff7e2b 100644
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
> @@ -73,13 +71,13 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev;
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
> @@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  	}
>  
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
> +				  match_memdev_by_parent);
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

