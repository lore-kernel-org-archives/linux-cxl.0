Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949A4D8DBC
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047915; cv=none; b=k/BJyQXzEa4i3KuruuMG2MJFlPDlboVbH8LDUFBHojziabEsPN7ztDiesUuk1pCJWu4yRT9cGzP4xyRsUEjKM9vRPAbXbEAg+n7SKG9clP3ebmUKQo7idETIUMq/i7cGP4QL8//vwAcczvN8iJNTCocbp6TaP11zAj8UxpmGHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047915; c=relaxed/simple;
	bh=jMAfN8k4Hj0olYun6J8d5deZ3O9uSlo98299HFCbPqM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E6gysif2NhNKq51OrfilXcxWpaeSx7Oig8rcSULkBV+ngyMvx6NB/qlGt6zwNFgYL5TAv5TkaBHNr5BpT3KL/PPLjt3FGjstxYPJ2KnuHe9munx2GqLEh/cAKwRYgpJyPDi5t+fHD8hI7gJYjBQB67S91Fw9lJeI6vJJ1mM4S6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOFJRMWd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOFJRMWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784047913; x=1815583913;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=jMAfN8k4Hj0olYun6J8d5deZ3O9uSlo98299HFCbPqM=;
  b=SOFJRMWddo9AHHlzRJDlD22QX0L9UEsmm3C9RCxlWm7P6khfVKLBnxct
   ap7WmTz2/66Ym3YdHHP8y567Ghqi0gzvUnuknSDe+PbaIVOUBO5adXdux
   w95rsJ/7BuREPzpfFh8V4GNZy1w5f4Cu13dxIZZzYeR5vroHyH6AYAJ+r
   jIB6h1RfVxWhhuFSirxjXOmZ+dxD16R124ad4w6h+duRU1xmqdrRLr6TE
   Ki/jrO+N4LnelidcVV9qMC677ODQNufK8GiU9VIHzh/KVAzbT1H2lA3nv
   3ohh9kM57rYgdk3cp22aa9ZDoGc6PPsSYgT6As8ZCo7DMpQoQDExq4mtQ
   Q==;
X-CSE-ConnectionGUID: yJOOHoyhT2WnZarATDLdyw==
X-CSE-MsgGUID: BIU992+1TNmYXikjRl/K1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84794982"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84794982"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:51:53 -0700
X-CSE-ConnectionGUID: mM1nOwq6TG+srZVUWRl/1A==
X-CSE-MsgGUID: hTEF9OV2TZC16Mapd2oPHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249553520"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:51:52 -0700
Message-ID: <2655ba78-25e6-46b7-89f8-5c348b6ea20d@intel.com>
Date: Tue, 14 Jul 2026 09:51:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/pci: Honor -EPROBE_DEFER from component register
 setup
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, sashiko-bot@kernel.org
References: <20260706224322.714934-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260706224322.714934-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/6/26 3:43 PM, Dave Jiang wrote:
> cxl_pci_setup_regs() for CXL_REGLOC_RBI_COMPONENT can return
> -EPROBE_DEFER on a Restricted CXL Host (RCD) when the upstream port
> has not yet been enumerated and the Component Registers must be
> extracted from the RCRB. cxl_pci_probe() treats every non-zero return
> from that call as the benign "component registers not found" case,
> logs a warning, and continues. The rc is then immediately overwritten
> by the subsequent cxl_pci_type3_init_mailbox() call, so the deferral
> is silently swallowed.
> 
> Return -EPROBE_DEFER instead of continuing so the probe is retried
> once the upstream port is available.
> 
> Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063bbf76b1c9c293ade52ab311018ae6bba11a44
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
430c502c80e5

> ---
>  drivers/cxl/pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..6a132a6c4c5b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -829,10 +829,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>  				&cxlds->reg_map);
> -	if (rc)
> +	if (rc) {
> +		if (rc == -EPROBE_DEFER)
> +			return rc;
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> -	else if (!cxlds->reg_map.component_map.ras.valid)
> +	} else if (!cxlds->reg_map.component_map.ras.valid) {
>  		dev_dbg(&pdev->dev, "RAS registers not found\n");
> +	}
>  
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda

