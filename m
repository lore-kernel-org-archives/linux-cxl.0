Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40149B1EE;
	Fri, 11 Sep 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142667; cv=none; b=OpbWJaHonYjZOIfIZlB6XJJUB8RLNZnKSE+yV8sneCrfCAJK1O5Kpl+UkDDCWxvh+Ffe7/OUW1kbswoFLW+aj0GJR6aIu5nT8QIHUfP3j1PZc+m0/cAEpC18zMGLGaMGSnCj6fnchxDDWWHwlbwUzzi3Efgw/m5BHj6R3Lpd0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142667; c=relaxed/simple;
	bh=jFo8Hd4m85pycyUQC38wiwVhyJpxY+RbIouqwFFeIvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+JkhX/VwQNMszO7azOAqrtNy1ST7jONJxCa4ACB9/LMFRTwKeHVbJH+BEFxZo6TCGn22DOpWqVDWHugbfSln0NJNVZO9OoI1ZEmgfPdl/4q3Vw3R5deQSi2eUPPafY88iNMOUqtr2Ii1zHh1nZd78F8xsc3W2Ot4eAtjm/itDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meL5u9yt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meL5u9yt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789142666; x=1820678666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jFo8Hd4m85pycyUQC38wiwVhyJpxY+RbIouqwFFeIvI=;
  b=meL5u9yt+6h/QPvKeuyCKLe2skY7tzfOLsfTuo+oiN4Kf3CrWzwA9L7L
   QEXtmjBUCx11A4xJE4uH1MxqdrPmXoxPStQIigR1B5j7ohFggfKMwKysc
   SDnS3Wc/OvyS1kg5PrnZe3loy2kvRtVVlQWzLrNgtzR7rJBFaY0Zy5Uu6
   kN7LCaSi3cxejIdUrmTfwwf6BdnMjIef9/zy96a94PX7zV15dM2wIpWiW
   yDWw+tdITd5tKyasAe+2sH99NkLoPE1MtqvMBEmsiL50AU4kTGDv/HQ3o
   3waGhM6YWLtomlT+Sy8ZHuVtQab9cdIjpWITgeLrLkd+Z8WlbHkzdim7J
   A==;
X-CSE-ConnectionGUID: 2o37p6bySTywGY06rcT5nw==
X-CSE-MsgGUID: bIBqreTeRsmUgHHToxYhNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="92117361"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="92117361"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:04:25 -0700
X-CSE-ConnectionGUID: 3YpawXnkRd67FUowBj/S2Q==
X-CSE-MsgGUID: g2ea/M8dT7adJkPeV3/8NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="273878900"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.42]) ([10.125.108.42])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:04:23 -0700
Message-ID: <6f304ebd-91b3-4433-baa6-ae50f38dbea6@intel.com>
Date: Fri, 11 Sep 2026 09:04:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/regs: Reject register blocks in an unassigned BAR
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 linux-cxl@vger.kernel.org
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-kernel@vger.kernel.org
References: <20260910093858.535969-1-junjie.cao@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910093858.535969-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/26 2:38 AM, Junjie Cao wrote:
> cxl_decode_regblock() only checks that the Register Locator offset fits
> pci_resource_len().  A BAR the PCI core could not place is reset to zero
> start, end and flags while config space keeps the firmware value, so a
> zero offset passes and the block is mapped at physical address 0.  On
> x86 ioremap() of the reserved low megabyte succeeds, the component
> register header does not match, and a switch port fails with "HDM
> decoder capability not found", pointing at the HDM decoders rather than
> at the BAR.
> 
> Reject a BAR with no length or still unassigned, next to the existing size
> check.  Skip empty Register Locator entries first: they decode as BAR0
> offset 0 and would trip the check, and nothing looks them up.
> 
> Seen with edk2-stable202602 (f6489621b8ae, reverted in stable202605),
> which places 64-bit non-prefetchable BARs behind a bridge in the
> prefetchable window.  Linux refuses to claim them and the switch
> upstream and downstream port BAR0s find no room in the 32-bit window.
> QEMU q35 with a CXL switch, Fedora 43 edk2-ovmf-20260213, before:
> 
> pci 0000:0d:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
> cxl_port port2: HDM decoder capability not found
> 
> after:
> 
> pcieport 0000:0d:00.0: BAR0: not assigned (type: 1)
> cxl_port port2: No component registers mapped
> cxl_port port2: Failed to map HDM decoder capability
> 
> Link: https://github.com/tianocore/edk2/issues/13104
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Applied to cxl/next:
dc96f35358a1

> ---
>  drivers/cxl/core/regs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..41416fa2ce4a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -277,6 +277,20 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	u64 offset = ((u64)reg_hi << 32) |
>  		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
>  
> +	if (reg_type == CXL_REGLOC_RBI_EMPTY)
> +		return false;
> +
> +	/*
> +	 * A BAR the PCI core could not place is reset to zero; decoding it
> +	 * would map the block at physical address 0.
> +	 */
> +	if (!pci_resource_len(pdev, bar) ||
> +	    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> +		dev_warn(&pdev->dev, "BAR%d: not assigned (type: %d)\n", bar,
> +			 reg_type);
> +		return false;
> +	}
> +
>  	if (offset > pci_resource_len(pdev, bar)) {
>  		dev_warn(&pdev->dev,
>  			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,

