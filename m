Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EB3CB550;
	Thu, 10 Sep 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054690; cv=none; b=tcrRytFFPBQxRj7mcl/qdPoDIX4WpfxrntGeppPwgu1MT4X+O6UFwayrFt6oWseA9Hys9SoB+vWmTX+k2CtIKcgilir2M25BdOHI7PVf7NeQRstXunOlCssNEiGQ73nkRAdzIb128eYnLPQK39ms42ZEHkXX4sDPWAn74GTHGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054690; c=relaxed/simple;
	bh=rEKy5X1sh5qAuBwZ27Qqx+FBatgEzsupkaYMGoVgVp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avjwVup4QTFrUPN68Drk6U2p6slfZP0YxmmtUeYuI5fMTt4jAEx9azRFYT3KwznlxmzSm24ur/loLc68LGf7KVDI6OEfygWDONLgVfxlL6AYsfrSUlTeowM7mWoXPIbvVWAkUs7uiM9GmqgHE4Duvp72p1lOwOzYp2THLHvpQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmVI80RP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmVI80RP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789054688; x=1820590688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rEKy5X1sh5qAuBwZ27Qqx+FBatgEzsupkaYMGoVgVp8=;
  b=DmVI80RP4s3LOxKN7ImkreUVjxnRgYoix54B/J+II1fNb1EfUYaGw1U9
   LHMVeqOmcJDfGNxIZnRZL+kO77A++t7StYvGkHo5dI/fTwnzf5ZQNrG68
   5CuNFfjHLrOO7zAZacTAEtIoIbRzOHgRVezi/0kAJ/KBFWfRzDZKfYmGq
   6KStBOepTBH4+jkWjvxz0okbU6O//WyhrR5p/p7HMqH4QzwIZlGYn7fo7
   h6Y/SSqdOX/R4qP4m5ilArs6No+z9UZbBzd7ko9w3qvZG6BKHc9OMdQrK
   qBGaAxlQJ/bp0L/6uuLbhFSOYPx6U5ahwHQh6XW4a3veK7xAx6FxbR2FN
   A==;
X-CSE-ConnectionGUID: FH2aqWauRCKUfc5owi+FBg==
X-CSE-MsgGUID: nKx+MUD3S/idkCY0mdm1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="101026801"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="101026801"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:38:08 -0700
X-CSE-ConnectionGUID: 9/dwAEaTSi6CjlcWAey2ag==
X-CSE-MsgGUID: ss0vcrLxQlKwkxYdZrjUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="272180698"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.223]) ([10.125.111.223])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:38:08 -0700
Message-ID: <6bb0b537-eaef-48a6-aadb-232e44522dee@intel.com>
Date: Thu, 10 Sep 2026 08:38:06 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

