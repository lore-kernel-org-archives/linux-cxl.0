Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69071F2B83
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174891; cv=none; b=XfMoet1ymXenoReDJZQHz8zZBg8mhG6b3f4/ZcXYtqNPNEu45NnogHmc+IXk5TeaheOYGecsf7HQqk/LuD0sMoRUiCYo8wrqfhscLnEAiIXLqAEYX3LDOzfaz9ddAnDNCTETONJuZDePArQqEhvOXgQdwME4fiu3Dc1AN3n1v90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174891; c=relaxed/simple;
	bh=ObIdonvy2XaQzTD4I9qRBky7/QI2SjhJC9fg6Aq9974=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgIpNvYOwtzFvfkk8Wuw6L3FrtYtPNsGBb4+k3ObjSooN10C/yFHSciZmSH2fgusFUqnYkfC+VI1VgLwJI4Oi8eTnk0waJEtKmxHwdOGaD8z/pzg8cEqwe+GrL6UOyxvUUnTeFljbU7LZXS2g2LoPo49iM84gavXpjI/M1I6DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKRAMu21; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKRAMu21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747174890; x=1778710890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ObIdonvy2XaQzTD4I9qRBky7/QI2SjhJC9fg6Aq9974=;
  b=BKRAMu21eWMUy+qd6fSlcc96LzRJPwGB81ZX93nAKWR9N9oPOsR/JxzB
   y1CvHsUHeFtXtmiuhkFPQOE3lGAtALuZ1JfhYDqJgmHF1pK53w9yfMrAb
   ifMvZY4EknetV8QuHDx7Lc/TR9KeElwfQFw5egIggduxOY+KZ73GoZvxM
   SMj10MizCj9H24pTde7GhkuEIlRMvExJ2KDj/2jZzyBv3NECxk7Fq5ooE
   MRnx4Bq42dTG3HOM9X7/AqW3Q6pULsk5w4M03JFT2x8+Mzl/o77ZbJcK3
   hMsl8Oo9/E3qPVIPviaXDQj39zwOTS/ZptNlDCExNXwi9AXtVWB3fsXBH
   g==;
X-CSE-ConnectionGUID: X5lMlVPNRmuM2e4BPVSVyA==
X-CSE-MsgGUID: FFxgPLqYTLipEqmrTV1Swg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48156814"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="48156814"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:21:29 -0700
X-CSE-ConnectionGUID: LnrEv/QmTkSBtkz7WxdpKA==
X-CSE-MsgGUID: pROAK8WYQomD+2CCQ5LSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="138826004"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.16]) ([10.125.109.16])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:21:28 -0700
Message-ID: <0771f05f-864c-417c-8b54-fb4aa3f891af@intel.com>
Date: Tue, 13 May 2025 15:21:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Sync up the driver-api/cxl documentation
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250513215813.1419645-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250513215813.1419645-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 2:58 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> pmem.c regs.c mbox.c identifiers were missing. Add them to
> memory-devices.rst following their respective DOC comment includes.
> 
> Two acpi.c identifiers were available, but not used in kernel-doc's:
> 1) Add add_cxl_resources to memory-devices.rst and fix up the Sphinx
> complaint on the ascii art by escaping it.
> 2) Add cxl_acpi_evaluate_qtg_dsm to access-coordinates.rst.
> 
> core/features.c is new. Add a "DOC: cxl features" comment to the
> source and identifiers to memory_devices.rst.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied to cxl/next

> ---
> 
> Change in v2:
> - rebased on cxl/next with Gregory's Boot to Bash
> 
> 
>  .../cxl/linux/access-coordinates.rst           |  3 +++
>  .../driver-api/cxl/theory-of-operation.rst     | 18 ++++++++++++++++++
>  drivers/cxl/acpi.c                             |  6 +++---
>  drivers/cxl/core/features.c                    |  9 +++++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> index 71024fa0f561..7f949cc4ece5 100644
> --- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> @@ -90,3 +90,6 @@ under the same ACPI0017 device to form a new xarray.
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated
>  bandwidth from all the members of the last xarray is updated for the
>  access coordinates residing in the cxl region (cxlr) context.
> +
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :identifiers: cxl_acpi_evaluate_qtg_dsm
> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
> index 32739e253453..1b854b11f575 100644
> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
> @@ -347,6 +347,9 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/cxl.h
>     :internal:
>  
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :identifiers: add_cxl_resources
> +
>  .. kernel-doc:: drivers/cxl/core/hdm.c
>     :doc: cxl core hdm
>  
> @@ -371,12 +374,27 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/core/pmem.c
>     :doc: cxl pmem
>  
> +.. kernel-doc:: drivers/cxl/core/pmem.c
> +   :identifiers:
> +
>  .. kernel-doc:: drivers/cxl/core/regs.c
>     :doc: cxl registers
>  
> +.. kernel-doc:: drivers/cxl/core/regs.c
> +   :identifiers:
> +
>  .. kernel-doc:: drivers/cxl/core/mbox.c
>     :doc: cxl mbox
>  
> +.. kernel-doc:: drivers/cxl/core/mbox.c
> +   :identifiers:
> +
> +.. kernel-doc:: drivers/cxl/core/features.c
> +   :doc: cxl features
> +
> +.. kernel-doc:: drivers/cxl/core/features.c
> +   :identifiers:
> +
>  CXL Regions
>  -----------
>  .. kernel-doc:: drivers/cxl/core/region.c
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 587ad5289f7e..a1a99ec3f12c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -749,10 +749,10 @@ static void remove_cxl_resources(void *data)
>   * expanding its boundaries to ensure that any conflicting resources become
>   * children. If a window is expanded it may then conflict with a another window
>   * entry and require the window to be truncated or trimmed. Consider this
> - * situation:
> + * situation::
>   *
> - * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
> - * |--------------- "System RAM" -------------|
> + *	|-- "CXL Window 0" --||----- "CXL Window 1" -----|
> + *	|--------------- "System RAM" -------------|
>   *
>   * ...where platform firmware has established as System RAM resource across 2
>   * windows, but has left some portion of window 1 for dynamic CXL region
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index bdc2c492bdff..5461cf07e65c 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -9,6 +9,15 @@
>  #include "core.h"
>  #include "cxlmem.h"
>  
> +/**
> + * DOC: cxl features
> + *
> + * A CXL device that includes a mailbox supports commands that allows
> + * listing, getting, and setting of optionally defined features such
> + * as memory sparing or post package sparing. Vendors may define custom
> + * features for the device.
> + */
> +
>  /* All the features below are exclusive to the kernel */
>  static const uuid_t cxl_exclusive_feats[] = {
>  	CXL_FEAT_PATROL_SCRUB_UUID,

