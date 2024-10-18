Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639520E307;
	Fri, 18 Oct 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210982; cv=none; b=NeNplVTo2MbvyAr61+ymw8clwW89re73qjypsEWnZsI8carUS1oKwZ4t4yMU8pJ8mpWV6x/ffgVjk5n4nB3DwkP2XtHgzv57ILFEeUOw2RcggPWWQPuCFhBRYNM+nrIs+Eq0GV54Tq2r7rhhZ7l6s+yF4AbpddazMnyY6mgzllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210982; c=relaxed/simple;
	bh=mm617MohGOfK7LHgQ7hK/GoPRl7lE/vc9SFRSwsYdms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJQQld54Dq0J7XekraWthqltr956Ih0YpbHof04IXB/tq6P5wmctYtnBiJPIq7y143FRD3XVmaA1MLMp6MWd/Q0ZPUrD0Ta+K8E51fvqujpVVeNjFoL4ulEqqhg5fqYXThT6idnJt8bvAxrXIJVNQ1wpoD2aJKEUYA9sL4d6gqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh8kmKWy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh8kmKWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729210980; x=1760746980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mm617MohGOfK7LHgQ7hK/GoPRl7lE/vc9SFRSwsYdms=;
  b=eh8kmKWyuR4I5aW2zpD64ak53NRbD/NI0BTXVUbZPvfvdmKs2mjY+weF
   OfZrVN0y0bZlN8PmwAapxShzPG0nI8TJ53H+Obl7Evi6oMvL6I03DlGpi
   ibyJs/g4ULMD6VwMDqnPm0nmYVfb0fDIJWctQoT4egwJO4oMUZIRXdLTb
   jCEuzlEN0Dcv2NhKWhTLCVw5YGvA5MuewQi9mPCzqqOtnNZacjigOBaEl
   Ghf9hdZucZNetfR4MhyQznn8qcxDYSF1r5ecxgICypFsC8uBgsrKwdvs2
   2wilXE+oiGNTRUMbTUhS0ECg3WRtG45PpomEF2ibzXKZyIIzW+Z8YG/JY
   g==;
X-CSE-ConnectionGUID: qzXT0z+1TYGojdGKX2sGmQ==
X-CSE-MsgGUID: OuZ1GrvNSPWsbP/aw5MsVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28825509"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28825509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:22:58 -0700
X-CSE-ConnectionGUID: 5lmcvQweTwStCz5lNLTSaw==
X-CSE-MsgGUID: oPJiw1muQzelQTbAnAWsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83539278"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.53])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:22:58 -0700
Date: Thu, 17 Oct 2024 17:22:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016015213.900985-1-lizhijian@fujitsu.com>

On Wed, Oct 16, 2024 at 09:52:13AM +0800, Li Zhijian wrote:
> The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
> PCI/PCIe CXL device only while cxl_test was implemeneted by platform
> device.
> 
> Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
> for cxl_core so that the cxl_test goes well.
> 
> Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
> will cause a kernel panic with calltrace:

snip

> ---
>  tools/testing/cxl/Kbuild      | 2 ++
>  tools/testing/cxl/mock_cdat.c | 8 ++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 tools/testing/cxl/mock_cdat.c
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index b1256fee3567..ed9f50dee3f5 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
> +ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> @@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> +cxl_core-y += mock_cdat.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-y += config_check.o
> diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.c
> new file mode 100644
> index 000000000000..99974153b3f6
> --- /dev/null
> +++ b/tools/testing/cxl/mock_cdat.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 FUJITSU LIMITED. All rights reserved. */
> +
> +#include <cxl.h>
> +
> +void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> +{
> +}

The addition of file mock_cdat.c made me wonder why this wrapper couldn't join
all the other __wrap's defined in test/mock.c. I tried, as you probably did,
and see the circular dependency. I mention it here in case anyone else has a
way to simplify this.

Otherwise LGTM:
Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> -- 
> 2.44.0
> 
