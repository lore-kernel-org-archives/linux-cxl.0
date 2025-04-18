Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA777462;
	Fri, 18 Apr 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994243; cv=none; b=uL1aH/s2L8CGKWgZQGizL5jAVQ5J0QM+NNKdAcCcxzWkNlxXcsQq7TBmsULV7iF2VfyxuNpCEMpXFlyCRDt0g9r9uPPJs5WVFZv44QwTmuAntOZEdg4ynIMptLQEN4r85J/4oK20zCNju5F3kUN9TgU9FIQQvaWbJnz1voRynao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994243; c=relaxed/simple;
	bh=Guo5kc5akM2Ea59p9MZSctl9UGkEryYBt2i5gg0ml68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYSLEvfE3KFICXd4Ntt1IKQQ7x8qVS+eFQomCoMDb71XcwaOde0OpSqU4GSdGjWjzdM+9Tz/Zt2OikwSQaQgv/cj96NjC0Ho4tAl+/TJfF5xYEXcXEnYiJpgfeppr6fygOrhRtsDntUXxbDudUsLBWv4D1F2hwB+p4SV2gezPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQEDYGbu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQEDYGbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994241; x=1776530241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Guo5kc5akM2Ea59p9MZSctl9UGkEryYBt2i5gg0ml68=;
  b=lQEDYGbupWG+D9bfK5KxTLWa1Eux77gktgEMHUekxpY3vrOSUzXqqgVv
   VovtzmGncnfbnqy3UkmWXoXiD48ABU9So2x99Ct6wtnR7TdAqdt9cwaA3
   6hsK8simf9vrEdmZDW+B6AfeUqB3xJhWndIa7gI/njAK3YXNgiUd0JOlD
   n6+DgS46zw0A9wNxpY872TUopdooiDnkOvnZI9saWkIUV7XaAc1gzboiw
   9NQuS6Kw3fI9YfkwD+hjIfzLI5O9ZWQa2Zw/ePpAuxnk2tZstGlC/g55a
   gJqZAVjXRvcqd7aWfiLD1aOxnw9ao83A+8hoizIEvtEAGZaD6xn00Z698
   g==;
X-CSE-ConnectionGUID: W35g4XV6S9OXFS8lliyGeA==
X-CSE-MsgGUID: pMm4MJobQLizhMuCtqxSig==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="57287716"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="57287716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:37:21 -0700
X-CSE-ConnectionGUID: copfg2xVQe2539wHMckWMg==
X-CSE-MsgGUID: fL7ygS46RO+/ZjzihauyZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132046149"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.182]) ([10.125.110.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:37:20 -0700
Message-ID: <8ffda58b-0f68-4207-95d7-62c977c8a559@intel.com>
Date: Fri, 18 Apr 2025 09:37:18 -0700
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

Applied to cxl/fixes

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

