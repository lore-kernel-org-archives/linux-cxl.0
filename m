Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25D37F8BD
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639141; cv=none; b=taODaL/7dcbkKxrD0OtjLI1cFoALqLQbc/tqV+BHi/sKLta61TeMehy63AI/naBzSeu8Q6ybS9CTM8jQaE6tHbgpElEaTxU46CMd0BSpl8lO5MffX1pGYAzRK40hQC4yAhl6jZmsgNMtEID1wBPgAGQzs+XGT3xZQTdQu2HwUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639141; c=relaxed/simple;
	bh=jljFiHkFfpce/ByVg3Qz76c1ppzXOIcei79Jhi1oB5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZqr6GMATS5mZepjbL1p3N7FpWJgRbf/+d4yMCKF8cxVSV1Z4O2qPu1H9WhvwYg+bwkEc/dDh3KDfYTDfUR/pIOKN1N7mdYqu9WzYK76eoUx/rMn92Mogxwgk06nfCcMTVS48iuHklmOcOw3twByKbyyAcwbw066cC4cvlQuCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0M+47FO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0M+47FO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790639138; x=1822175138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jljFiHkFfpce/ByVg3Qz76c1ppzXOIcei79Jhi1oB5w=;
  b=Q0M+47FOzJhyuMuuGfxgGl40n8eMJkkNbholqPM8q2seWQQ+Oq0XUJV4
   6bYRxxv9YS9Bg+sc2QUwhY1m/FhKEWfdmbMjlZbmp178gvJ9Z/5z8yllY
   BLT4mw4tfX+dxw5FIcyQ68TKu/N7nutOVi8H40orNUbilJT+CfWYMqh5U
   EKLQnZs93cbZpWCJl4POSGisqNKXhxlWzI/hx5rU9NzKF6fMa1UrC7rm+
   46V07C15zaEf9yHDRxo9HtqJlXFKCpNBLlZnJBWo3fiIpgOaTO40cV0G5
   33Fxy7fypcpOhVJt0SiSKeJBeiRzq9OvXNhRVm8+JQBQ9ZMSmISte+H4c
   A==;
X-CSE-ConnectionGUID: yI6+PnTMQYya0TYNf9/sFA==
X-CSE-MsgGUID: g7s/vrfsS4u0yLSYh2xxdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93841513"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="93841513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:45:38 -0700
X-CSE-ConnectionGUID: tA72DVsYRnebFEMqHJVLyA==
X-CSE-MsgGUID: nQq+UoNMSNuPFbqX2w3A0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283272528"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:45:37 -0700
Message-ID: <5f468582-f9cc-4d13-951b-a8be833a157a@intel.com>
Date: Mon, 28 Sep 2026 16:45:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/pci: Use the Device GPF DVSEC for restricted
 endpoints
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
 <20260922100026.3742401-2-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922100026.3742401-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 3:00 AM, Guixin Liu wrote:
> cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
> from the PCIe type of the given device, and only a plain endpoint
> counts as a device. A restricted CXL device is an endpoint too, but
> it falls into the port case and is probed for the Port GPF DVSEC
> instead of the Device GPF DVSEC.
> 
> On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
> lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
> shutdown count stays invalid, and the warning complains about a
> missing Port GPF DVSEC on a device.
> 
> Treat restricted endpoints as devices.
> 
> Fixes: 36aace15d9bd ("cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..e31aad7a525a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -804,7 +804,8 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>  		return 0;
>  
>  	pdev = to_pci_dev(dev);
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT ||
> +	    is_cxl_restricted(pdev))
>  		is_port = false;
>  
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,

