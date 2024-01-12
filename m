Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BD74E0A
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfSRdZ+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705076693; x=1736612693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w6xUPSQJChrMK8hNo3FxDC+OlguD4ciW+PrkfdDvROs=;
  b=nfSRdZ+JCpqFK9Bn8YQtisu8N60wh8L/oW2COJE/inyEmEteLu5yunkI
   nKqv94bwPBdEvgyIhm7q7C+CvzxddCHeCoF91f6Zq2m/GK7brP0x9MNZ3
   RSw7Wze/e5xZ6ODCxxPIvHGq66GzYtOpTTV4tVNEeqjivoJQUfEq4aeEc
   8ECy8FkpBUsoJDvy2ssvebHM2DCsPlRejIYcEMkZlRzUcA3jiiTPqATP7
   iVf4kaGbSH7+RVVpZLnREeYq59Nk2H3kufaD9CM7498t1B3i1n/WUAu87
   DzsCmnN80zfozkWFZGLJ3dKwc9Vk8y1BnvvbNl1Lj+apM28UWc0R0Ds8v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12575208"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="12575208"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="873410209"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="873410209"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.99])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:24:51 -0800
Date: Fri, 12 Jan 2024 08:24:49 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	KyungSan Kim <ks0204.kim@samsung.com>,
	Jeongtae Park <jtp.park@samsung.com>,
	Hojin Nam <hj96.nam@samsung.com>
Subject: Re: Question about CXL region initialization
Message-ID: <ZaFn0dfaJ8iOi1UW@aschofie-mobl2>
References: <CGME20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5>
 <20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5>

On Fri, Jan 12, 2024 at 06:22:01PM +0900, Wonjae Lee wrote:
> Hello,
> 
> To test that regions are initialized correctly for different combinations of
> capacities, I connected two CXL devices with different capacities to a CXL v2.0
> compliant system and enabled CXL Interleaving in the BIOS settings. When the
> system boot with Linux 6.7, I noticed something strange. it succeeds in
> initializing region1 but fails to initialize region0 and displays an "HPA order
> violation" message.
> 
> Does anyone have any advice on this? Below is the log for your reference: 
> 
> 1) iomem
> 480000000-AAAffffffff : CXL Window 0
>   480000000-XXXfffffff : region0
>     480000000-XXXfffffff : Soft Reserved
> 28400000000-BBBBfffffff : CXL Window 1
>   28400000000-YYYffffffff : region1
>     28400000000-YYYffffffff : Soft Reserved
>       28400000000-YYYffffffff : dax1.0
>         28400000000-YYYffffffff : System RAM (kmem)
> 
> 2) dmesg - some relevant logs with CXL DEBUG enabled
> ...
> [] cxl_port port1: decoder1.0: range: 0x480000000-0xXXXfffffff iw: 1 ig: 512
> [] cxl decoder1.0: Added to port port1
> [] cxl_port port2: decoder2.0: range: 0x480000000-0xXXXfffffff iw: 1 ig: 512
> [] cxl decoder2.0: Added to port port2
> [] cxl_port port2: decoder2.1: range: 0x28400000000-0xYYYffffffff iw: 1 ig: 256
> [] cxl decoder2.1: Added to port port2
> ...
> [] cxl_port endpoint5: decoder5.0: range: 0x480000000-0xXXXfffffff iw: 2 ig: 256
> [] cxl_port endpoint5: decoder5.1: range: 0x28400000000-0xYYYffffffff iw: 1 ig: 256
> [] cxl_pci 0000:64:00.0: mem1:decoder5.0: construct_region region0 res: [mem 0x480000000-0xXXXfffffff flags 0x200] iw: 2 ig: 256
> [] cxl_pci 0000:64:00.0: mem1:decoder5.1: construct_region region1 res: [mem 0x28400000000-0xYYYffffffff flags 0x200] iw: 1 ig: 256
> ...
> [] cxl region1: mem1:endpoint5 decoder5.1 add: mem1:decoder5.1 @ 0 next: none nr_eps: 1 nr_targets: 1
> [] cxl region1: pci0000:63:port2 decoder2.1 add: mem1:decoder5.1 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
> [] cxl region1: pci0000:63:port2 iw: 1 ig: 256
> [] cxl region1: pci0000:63:port2 target[0] = 0000:63:02.0 for mem1:decoder5.1 @ 0
> [] cxl_region region1: region1: register dax_region1
> ...
> [] cxl_port endpoint6: decoder6.0: range: 0x480000000-0xXXXfffffff iw: 2 ig: 256
> ...
> [] cxl region0: mem0:endpoint6 decoder6.0 add: mem0:decoder6.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [] cxl region0: pci0000:3d:port1 decoder1.0 add: mem0:decoder6.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [] cxl region0: endpoint5: HPA order violation region1:[mem 0x28400000000-0xYYYffffffff flags 0x200] vs [mem 0x480000000-0xXXXfffffff flags 0x200]
> [] cxl region0: endpoint5: failed to allocate region reference
> 
> 
> Looking at the old history, there was an issue with "HPA order violation" and a
> patch was applied, could this be related?
> : https://lore.kernel.org/linux-cxl/20230905211007.256385-1-alison.schofield@intel.com/
>

Hi Wonjae,

I recently came across this issue too and have a patch in test.

That HPA violation check made sense for user created regions where
the CXL driver is programming the decoders. For the auto regions,
it's an issue.  There is no guarantee of the order is which endpoints
are discovered during probe, and since regions are currently created
once all their member endpoints arrive, this out of order violation
occurs.

Your diff makes sense for a work around. The patch checks that the
regions decoders are not misordered, and then ignores the order
violation for auto created regions only.

I'll 'cc you directly on the patch hoping you can test it out.

Thanks,
Alison

> 
> FYI, As an experiment, I tried deleting the below error handling code in
> cxl/core/region.c and both region0 and 1 are initialized successfully.
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3e817a6f94c6..ed08ce7840df 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -771,7 +771,6 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>                                 "%s: HPA order violation %s:%pr vs %pr\n",
>                                 dev_name(&port->dev),
>                                 dev_name(&iter->region->dev), ip->res, p->res);
> -                       return ERR_PTR(-EBUSY);
>                 }
>         }
> 
> 
> Any help would be appreciated.
> 
> Thank you,
> Wonjae
