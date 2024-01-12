Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6E651
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKGj1X0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705019210; x=1736555210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3E+Vi8Ao0s6+OnPrJwv+CL0o6Z63xYopDERSSAMIybM=;
  b=NKGj1X0FJv6fzfnvQqrDh3wOUrCyNKyTHoCgWP92bvt1pYUbii3itPNe
   Vx/dIWpU9sTVzqRuHYLSaYlTx564vW01HxgVBhYRDmdc6kKRD4GNggnKr
   LivXLOX3g/GP/S3BwWWG6yTrpphp2rUSTQjC4TyUgfOnE6HcoSk22aWYJ
   XNyRwLLd40RgmEi+05qDTCnkkW/PCU7rgntCggSxoEAUXUjJ6Hc26tlFD
   Nwzl9OiBVs/MLnTOR+n4vkt1JXbd5yC2xsIxMiT4KoIVqG+aPC6bH+20H
   A/6imD/awGEDt/I/dUEyIrkIEHxwBPXbEVzB5Sonx0SiOm4nPp4dXllpO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5766639"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="5766639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="955939638"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="955939638"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.69.72])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:26:50 -0800
Date: Thu, 11 Jan 2024 16:26:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question on deferring dax registration to cxl module for
 CXL_REGION
Message-ID: <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
References: <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>

On Thu, Jan 11, 2024 at 09:03:48PM +0000, Hongjian Fan wrote:
> Hi CXL experts,
> 
> 
> I have observed the following behavior on iomem_resourece when CONFIG_CXL_REGION is enabled in the kernel.
> 
> CXL windows are inserted into iomem_resourece based on CEDT CFMWS. If there is only one CXL device attached to the host, the CXL window matches the soft reserved memory range, and the CXL window is inserted as the child of the PCI mem and the parent of the soft reserve. But if there are multiple CXL windows, each of the CXL window is part of the soft reserved memory range, the CXL window is inserted as the child of the soft reserved memory.
> 
> Function dax_hmem_platform_probe defers the dax region registration for the CXL window to cxl module.
> However, two issues seem to occur:
>         1) If the CXL window is not the direct child of the iomem_resourece, dax_hmem_platform_probe will not be able to detect and defer it. This means that if CFMWS contains multiple CXL windows, no deferral would happen.
>         2) If a CXL1.1 device is behind the CXL window, and the dax region registration is deferred. The dax region will not be created because CXL1.1 device doesn't have the HDM decoder and other features needed by the CXL module to create the dax region.
> 
> DAX ( and hmem ) module is not visible to the CXL device's features behind a CXL window, so it is impossible to defer only the CXL window for CXL2.0 devices.
> 
> If I want to make dax region show up when a single CXL1.1 device is attached, I can see two potential approaches:
>         1) Do not defer the CXL window in dax_hmem_platform_probe.
>                 Can we simply not defer? Current code will not defer if multiple CXL windows presents. Is any issue observed when multiple CXL devices are attached?
>         2) Defer all CXL windows, and let cxl module create the dax region for CXL1.1 device.
>                 But where should this creation be? It would be a long path to handle all the unvailable features from function cxl_pci_probe to reach function devm_cxl_add_dax_region.
> 
> Please provide your comments.
> 
> 

Hi Hondjian Fan,

This is familiar. In Aug '23 I stopped work on a patchset [1] aimed at
improving the soft reserved resource handling. From that cover letter:

1) Soft reserved resources were observed as sometimes being the parent
and sometimes being the child of a region resource. Patch 1 clears up
that inconsistency.

2) Soft reserved resources were also observed as stranded after region 
teardown, making the address space the region released unavailable for
reallocation. Patch 2 implements soft reserved resource removal.

By v3 of the set, we were rethinking the approach as Patch 2's juggling
of soft reserved spaces seemed silly and error prone. Also, the folks who
were hitting the soft reserved issue during hotplug were able to use CFMWS
address space not in the Soft Reserved range as a work-around.

Dan offered a couple of new approaches since then:
(I hope I'm not misquoting)

1) Insert cxl intersecting soft reserved resources into a separate
(non iomem_resource) resource tree, when / if any CXL region assembly
fails walk that side tree and move them all over to iomem_resource.

2) Given that it is already the case that the device-dax core waits for
cxl_acpi to mark ranges as IORES_DESC_CXL, and that we do not expect that
to fail. It means that cxl_acpi can then turn around and ask the device-dax
core to cache and delete the soft reserve address ranges. Then if CXL notices
a region assembly failure it can signal device-dax to release that cached
range as a new CXL disconnected DAX region.

3) CXL acpi walks the resource range knowing that at the beginning of time
Soft Reserved ranges are unparented making them easier to delete and
register them as "just in case" recovery ranges to device-dax.

Can you comment on whether any/all of these suggestions seems to address
what you are seeing?

Others thoughts on the approach this might take next.

Thanks,
Alison


[1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/






> 
> Below is the /proc/iomem output from my hardware:
> 
> 1) When there is a single CXL2.0 device on the host, the CXL window is inserted in PCI mem and the soft reserved region is a child of the CXL window:
> 
>         6080000000-707fffffff : CXL Window 0
>           6080000000-707fffffff : region0
>                 6080000000-707fffffff : Soft Reserved
>                   6080000000-707fffffff : dax0.0
>                         6080000000-707fffffff : System RAM (kmem)
> 
>         A cxl region is inserted under the CXL window by function discover_region and the dax region is registered by cxl_dax_region_probe
> 
> 2) When there is a single CXL1.1 device on the host, it is similar but neither cxl region nor dax is created:
> 
>         6080000000-707fffffff : CXL Window 0
>           6080000000-707fffffff : Soft Reserved
> 
>         HDM decoder and other CXL2.0 features are missing from the CXL1.1 device so the CXL driver will not create related CXL structures. Because of the absence of the dax region, there is no numa node created for the cxl memory and the cxl memory is not usable in user space.
> 
> 3) When there are multiple CXL devices, regardless CXL1.1 or 2.0, the CXL window is created under the soft reserved region:
> 
>         6080000000-807fffffff : Soft Reserved
>           6080000000-707fffffff : CXL Window 0
>                 6080000000-707fffffff : region0
>                   6080000000-707fffffff : dax2.0
>                         6080000000-707fffffff : System RAM (kmem)
>           7080000000-807fffffff : CXL Window 1
>                 7080000000-807fffffff : dax3.0
>                   7080000000-807fffffff : System RAM (kmem)
> 
>         Both dax regions are registered by dax_hmem_platform_probe. The cxl region is created under CXL Window for the CXL2.0 devices.
> 
> 
> 
> Thanks,
> Hongjian Fan
> 
> Seagate Internal
> 
