Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6B2F29
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639405; cv=none; b=VgNPp4HyefGag6QaRQ2WE3dtbqJmnTzikidu11sTZPp7f10vQ6QHk5tziAtkE0ruWeOiAZ+MuXbI8+odT7N/NQP3dFq7pu6A6ycEsxlj6+ODtZc8b/88GIOZ2llU94wdlQYkgeF6aJq7ZdgcjSjWsuDrgi3qyqMz3Ui+I8i+m+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639405; c=relaxed/simple;
	bh=AaEskmMpBIrS77PRfWnirVLEEjuLDRInw+CJMrYfVAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVqBAR5hV4D2kZCY83ymGAs62FL76XWs+l0iIJjUxLfRlr5un4IEahhohj4uSOkBy4buqQiU0e7jrXXjGo8ydJOOApMKNLuE52MY9NT5KE2ve0Gy9BqEcLlYuDRrM0yrO7Jh/IDKfDnVUhrUs0sxkDa9moIRJ7adeYga2qcYO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aodLL71g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aodLL71g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731639404; x=1763175404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AaEskmMpBIrS77PRfWnirVLEEjuLDRInw+CJMrYfVAw=;
  b=aodLL71gicGEq0LxEcio0aMzv+04N1Khv4PT2dKkxEiMClwnMIygIsZf
   UjBbs3nhYeio565D9VbX/FXxvMK2NDnTTbqoUE+1bWuiDiXIR6i13pGZu
   w5LIkX2b1Tush4etyIL9C+EFdtjwJMRDrQgcHpu0MV1G3px7HgQr5lV25
   9jOUJkvYyWRydd5d8jC890MIBhkyMsRN4UM4ScnyZINElXWyBhY8ZeyqN
   vwvCYDfFu40NRvGJU9YTTR4+VU6GE46HrjsoKlY6x5z4vA36+qJr8L9LG
   o57W3FHy5JfUCTZL7g5C/sFZl2/A3ConCjyW9ZSp7GXyG0TSKUZh+qDML
   Q==;
X-CSE-ConnectionGUID: Wi2IPXNpQ7K6wK/gXkEN7Q==
X-CSE-MsgGUID: aCMbR3rXTBi2D/X5mo5QDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="57030453"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="57030453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 18:56:35 -0800
X-CSE-ConnectionGUID: q92l7zrkScONqYprVk/98g==
X-CSE-MsgGUID: CH7HdAVET7uZhf2xmYA8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="119330835"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 18:56:34 -0800
Date: Thu, 14 Nov 2024 18:56:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <Zza4YONsVxWa8rpL@aschofie-mobl2.lan>
References: <20241114213439.6022-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114213439.6022-1-dave@stgolabs.net>

On Thu, Nov 14, 2024 at 01:34:39PM -0800, Davidlohr Bueso wrote:
> If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
> returning that value, instead of zero. Found by code inspeaction.
>

I agree that the return value should be 0 if we get this far,
because all rc's that need to be returned, are returned immediately.

But...the set and check of 'rc' for the calls cannot lead to a
'return rc' seems like a bad pattern. Most of those are dev_dbg()
messages.

This last one that bit us here, is repeating the same pattern of those
before it:

	rc = cxl_pci_ras_unmask(pdev);
        if (rc)
                dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");

This can be:

	if (cxl_pci_ras_unmask(pdev))
		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");

There are a bunch that follow this pattern in that function, mostly in
the pmu_count loop.

How about tidying up the rc pattern throughout the function?

--Alison


> Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..01092e5b3b46 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -948,7 +948,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	pci_save_state(pdev);
>  
> -	return rc;
> +	return 0;
>  }







>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> -- 
> 2.47.0
> 
> 
