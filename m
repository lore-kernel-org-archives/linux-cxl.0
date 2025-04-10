Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17D1D90DF;
	Thu, 10 Apr 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298053; cv=none; b=hFPFhRr7vW6jqU2n+GpaBavNAWSmz7YzlISNd7fTN2Xs+Fm3uUjk0oXNlTvE80DrSkC2ScCpI6fM2TkE6tTVGto9B6qXOnXS8xp3+3RoBVQec9toB23AA9pRHmcLMMrkWhLKYd1hlQDu1GRfyy3ylg2dfTsZxQIGmsZ+jBjpK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298053; c=relaxed/simple;
	bh=L96RyAc5ptYnMenleT5Ncs2DwCRN+ZYa3Gpf5zpz+2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLCMbe9WkeeTKnCHi5/Nc0BxZXA7wDtQ00W2BjbS99Mgtxn3QjSQwuwu/7hPPCFGYcuV34pnLESTu5COeqEwLo+isIcBH5R5CUa96ezgQO4wlngNQGIf4tO6EwYnA9BXT9zbiNM14Fc5HYx/8o7f8SRJuACa5+Z1G3Lt4c4Nk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx2f6WUL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx2f6WUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744298052; x=1775834052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L96RyAc5ptYnMenleT5Ncs2DwCRN+ZYa3Gpf5zpz+2o=;
  b=Jx2f6WULg/KC0KJRy2tIoIfJY4nEt1CjMBClDeQPqKd1Ruht91U80h98
   kFHEgLcRBTxOd6bbrxpPZJXGRCN8wbw1/GFstbOpsPCkV15YX/wf+dndy
   hbz9a6WOLJ1dWZ/7u6cEY2Lg+/AtAsQHONhrlOqhBxLB3iBGo426ArnhW
   X1klr6mmI3W0ZQYVcWyKPLNCplOpR2A3V8DKDuM/Y0nFEF8dAgy0rt/jU
   SpZyjX7WWEq/es7b7N54vD3Zv5LW7t0b7jazZVqUAcGlH7s4/gswZeSdF
   556I6DjM/Mm8uwv5MIK/0Ig/BM2SApg5/2R1G31KdarD6mP5LZbiijiAW
   Q==;
X-CSE-ConnectionGUID: nY7x6TeqRaCliiBwlgtk/A==
X-CSE-MsgGUID: YkvyPsfzRX28Zr+ePdeh6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56495361"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56495361"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:14:11 -0700
X-CSE-ConnectionGUID: 5VDn00G0ThmJ7M5tlfEHZw==
X-CSE-MsgGUID: mHl+XZl7RBy+tua6G6Zv9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128882006"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:14:10 -0700
Message-ID: <37292d0a-ea6e-485e-89bc-5b660c98e84d@intel.com>
Date: Thu, 10 Apr 2025 08:14:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD
 and RCH Ports
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>
References: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/25 12:27 PM, Smita Koralahalli wrote:
> According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
> including Memory Space Enable bit, have no effect on the behavior of an
> RCD Upstream Port. Retaining this check may incorrectly cause
> cxl_pci_probe() to fail on a valid RCD upstream Port.
> 
> While the specification is explicit only for RCD Upstream Ports, this
> check is solely for accessing the RCRB, which is always mapped through
> memory space. Therefore, its safe to remove the check entirely. In
> practice, firmware reliably enables the Memory Space Enable bit for
> RCH Downstream Ports and no failures have been observed.
> 
> Removing the check simplifies the code and avoids unnecessary
> special-casing, while relying on BIOS/firmware to configure devices
> correctly. Moreover, any failures due to inaccessible RCRB regions
> will still be caught either in __rcrb_to_component() or while
> parsing the component register block.
> 
> The following failure was observed in dmesg when the check was present:
> 	cxl_pci 0000:7f:00.0: No component registers (-6)
> 
> Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/regs.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 117c2e94c761..5ca7b0eed568 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -581,7 +581,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	resource_size_t rcrb = ri->base;
>  	void __iomem *addr;
>  	u32 bar0, bar1;
> -	u16 cmd;
>  	u32 id;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
> @@ -603,7 +602,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	}
>  
>  	id = readl(addr + PCI_VENDOR_ID);
> -	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
>  	iounmap(addr);
> @@ -618,8 +616,6 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  			dev_err(dev, "Failed to access Downstream Port RCRB\n");
>  		return CXL_RESOURCE_NONE;
>  	}
> -	if (!(cmd & PCI_COMMAND_MEMORY))
> -		return CXL_RESOURCE_NONE;
>  	/* The RCRB is a Memory Window, and the MEM_TYPE_1M bit is obsolete */
>  	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
>  		return CXL_RESOURCE_NONE;

