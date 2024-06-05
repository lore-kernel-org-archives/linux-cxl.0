Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BB4C619
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602175; cv=none; b=K2KSPRr05h5I+EjMIeIcDzKTTKN1JZnqbZpkJu4Gjh/IbcCloXnP+JqN/CfYlRScZZ3hqikYHaCGT+dkzNN8QKbwhW6fdmFaqEIABVsJMZgtc8GG9uoGkf+cJy6qsqBBjrtkUGaazQLMx6Wfxp4uvzh5T5dCS2R41/wM87vvwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602175; c=relaxed/simple;
	bh=JZSxCyKPW8WiFOxUw+Bzz0C5A6M1vHQyS1QEpJxnrcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzxQy6kQjd50CQ6tKeuDL3b0LwQz+fNfd2HioEnQ5kXoIbtfuljF9e/Vea9mb1VG8YfR3DKKr2R4PSvvUnkLuiY7gCN9yKYZp+iQguWxvvgkxXoYxP7p6ZpBWl2Tlotd8zhD7iYNdLrhNnGmgu0WvvGCuqG4EEdN9B3asRMHhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xx1kig+Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx1kig+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717602174; x=1749138174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZSxCyKPW8WiFOxUw+Bzz0C5A6M1vHQyS1QEpJxnrcY=;
  b=Xx1kig+Zhnrk1XMfgHDI6k/Euyory2GvXKkDDnr7m6xdZq6L6Pn9K+9e
   pmwIQWFXpono4krLl0kSXLU86FrW8gyKNJ0NUpqliSmTKwpkTYfC1BK9d
   lqCh5HHCVFKznckuIo6T4u6EHTryUo7SIldvhtIzwPURw7xTdFLCtbrdY
   dZpPt67GrfrLywNWe9ZUaq+mfCY4UkTT6oyrXi/ck3aHB493mKrbilhbU
   FHWldKKlM4adeXd564g0XmurRklnniDIfIV0qqkwbd7rqSu43/sh7UZdO
   Vdcixccrc7bmjR11veXUWjglzd95u3DGrRKcN5ljhYQoCCV2qtkR4hTgn
   g==;
X-CSE-ConnectionGUID: kvDjC/l3TAmBXMKwAge2dw==
X-CSE-MsgGUID: hqxet0EoRcqcadMRJj9bPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31720901"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="31720901"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:42:54 -0700
X-CSE-ConnectionGUID: QBBE77QOREadOHozuS/xDQ==
X-CSE-MsgGUID: 2/FzpbKDQFKXDp2VFgOZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75108123"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:42:54 -0700
Date: Wed, 5 Jun 2024 08:42:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming4.li@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
Message-ID: <ZmCHfFJXtpx3NZW5@aschofie-mobl2>
References: <20240531070229.1596811-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531070229.1596811-1-ming4.li@intel.com>

On Fri, May 31, 2024 at 03:02:29PM +0800, Li Ming wrote:
> When CXL subsystem is auto-assembling a pmem region during cxl
> endpoint port probing, always output below calltrace.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>  Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x82/0x160
>   ? do_user_addr_fault+0x65/0x6b0
>   ? exc_page_fault+0x7d/0x170
>   ? asm_exc_page_fault+0x26/0x30
>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>   really_probe+0x173/0x410
>   ? __pfx___device_attach_driver+0x10/0x10
>   __driver_probe_device+0x80/0x170
>   driver_probe_device+0x1e/0x90
>   __device_attach_driver+0x90/0x120
>   bus_for_each_drv+0x84/0xe0
>   __device_attach+0xbc/0x1f0
>   bus_probe_device+0x90/0xa0
>   device_add+0x51c/0x710
>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
> 
> Because the cxl_nvd of the memdev is necessary during pmem region
> probing, but the cxl_nvd can be registered only after endpoint port
> probing done, that is a collision dependency, so adjust the sequence
> between cxl_nvd registration and endpoint port registration to guarantee
> there is a cxl_nvd in memdev during the pmem region auto-assembling.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>


I have a WIP cxl unit test for this case - auto assembly of pmem
regions. It's far enough along that I'll offer the tested by tag,
but not far enough along to post for upstream review.

Tested-by: Alison Schofield <alison.schofield@intel.com>

> ---
> 
> 
