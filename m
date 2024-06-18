Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69A197A7B
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718678960; cv=none; b=bVtkyvSWfWys5JjgsYVjBkIuktNuu7j92aRD8NghcT2k0EbAe2cknBF/LkmSyWI34XPrvW5NlHpNmZeTjU0nvp/JQpfVuOjbNdeD4qXTVuEAuSh9W8WXwgzeVpJfzb7ly8J3y86wjUhCiDVG83c8m8L5IrSysnnKdNhWdnjs6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718678960; c=relaxed/simple;
	bh=H+wKImwFWlhbqoBwZS3YiGuOJ3zmFU15L8tAHgq71tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XguaT89zR32zdSdeWjRPc2/4C03AtrnKhIBr5au/9uDuP+OPEO+4YYhN0I6kfW9rX5nTzwLQw+iPXdWTrNtSJPWB0wSd0vRyn2S47ZCOa60zs9WGe0sxa8xNfc/ThJDiqBYeeIYt3tMp3GWU9v6fJ8FzBBEA389Cx5dlXpRKwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ2Bac5W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ2Bac5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718678959; x=1750214959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+wKImwFWlhbqoBwZS3YiGuOJ3zmFU15L8tAHgq71tY=;
  b=ZZ2Bac5W8LeU43y1jZcvrcOYzcS20up/xjfj3yCR10PSafxpp2UiILSu
   bFwokfi7WLnO4Zz9TeOlbmrOw8bGT8gKuw3q/lZltIQduFPcZlbyTN9tk
   nR0XmLFE3lF/Dvi8jf5Pj3szyJjP85DbwQ7mQ7YVcJWFjya3s+ealDn1t
   eUN8mnNjdvQZAK6Xlz4QgQPI5nvICRoun9NnW7dFCPyaYy+n5AkVAr9uO
   1r9nSMOXn42qubGSaEoxSSDe1Fz2xEC2Fm7f1kz7EMtjD4MbLE2cefpT5
   u5i+XdBSkNiTTfqzTc9YoTvmTJLxGM8LWu+yHugIp2Yg9Vo8jSh4rf3aS
   A==;
X-CSE-ConnectionGUID: UxPuMlRbRC6iB9b/NykPxg==
X-CSE-MsgGUID: vhkCupVARmigCZbCV0EwGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15249293"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15249293"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:49:18 -0700
X-CSE-ConnectionGUID: fkEciA6VQiCQ/GSfLQVdUQ==
X-CSE-MsgGUID: K4W+Ag85Sj+yN8v2SOWk+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41248923"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.195])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:49:17 -0700
Date: Mon, 17 Jun 2024 19:49:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming4.li@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
Message-ID: <ZnD1qxTyiSMvkBTd@aschofie-mobl2>
References: <20240612064423.2567625-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612064423.2567625-1-ming4.li@intel.com>

On Wed, Jun 12, 2024 at 02:44:23PM +0800, Li Ming wrote:
> When CXL subsystem is auto-assembling a pmem region during cxl
> endpoint port probing, always hit below calltrace.
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
> The cxl_nvd of the memdev needs to be available during pmem region
> probe. Currently the cxl_nvd is registered after the end port probe. The
> end point probe, in the case of autoassembly of regions, can cause a
> pmem region probe requiring the not yet available cxl_nvd. Adjust the
> sequence so this dependency is met.
> This requires adding a port parameter to cxl_find_nvdimm_bridge() that
> can be used to query the ancestor root port. The endpoint port is not
> yet available, but will share a common ancestor with it's parent, so
> start the query from there instead.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

DaveJ please clean-up commit msg misspelling when applying.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


