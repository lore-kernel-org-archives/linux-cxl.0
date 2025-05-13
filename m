Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29818380
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094458; cv=none; b=Ke+h0pj28gq0c6Pytr3cL8Igo6lOaC9Lp8R6p/qmhiK7v9F9FwZhrKQUecRdZlHYMLCymw3vA4q62SaL3nZWvt6n1imBrXpGGTp1S4A/Z6OObeCrxJOGLvnFdmmn0RG6e6qi+BeyGRGK/Zsi76XmPNOTpUHdN3scVehkiUWJTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094458; c=relaxed/simple;
	bh=EfySpLq9KWqi6GyhgmzjvPcxyOFixktpK2Y+bBRQHvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFUuGEIcjg9Vtpx39C36YZjKcXNcZY/ONckJ88LR6MZZfO5qC2ex3v1K9nXyiHsxffTHGQtUrVxcp8bI2mC9TsReJIg+ljHweLWeatKbgxcrrc/HsBtxw2He90ZG3R1m1lvX/zW0HL00ctK/ny6+I2l2QyVKL9AhCj4z0mDEYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtZYcNnx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtZYcNnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747094456; x=1778630456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EfySpLq9KWqi6GyhgmzjvPcxyOFixktpK2Y+bBRQHvo=;
  b=dtZYcNnxL2qxP+m6SllR7HIKp6R9pqY6D0TdXVimKVQ4Oydzy9iF8Jl0
   gqRShCX9D6KY2jVumdIErzXz44PmIIAd8+5iOHWzLkjxb+F7XVUPZkPet
   cbUtCsZAY/pcew2DTQdIXf94jT67VJb+Eo37ZiHDCHvOpvkBbwvoHmBGF
   8VuaAqOqsqNfUZXO60Dtk9x/RL1wW+dEzQRjTiC2otYtGSfs/FcbXx/S2
   ZrHJEe6lYobRFQTpJNudG79t/T/TAntrELAlV90G4DtbRINpyhkKgJNYx
   c7J33PDNo+A6GtJHONol8fX91PfAhVP4i5jGQ9dhL9fKSD108HMZOcNxV
   w==;
X-CSE-ConnectionGUID: phgopDtvRtGS7cqlj5ghgw==
X-CSE-MsgGUID: ceu013FBRyaG1chcPW5rtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60253432"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="60253432"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:00:55 -0700
X-CSE-ConnectionGUID: istQLv+qQTifCUhhfjTxkg==
X-CSE-MsgGUID: 1/lKGxedRVW/SqQ0Lrhneg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142709465"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:00:55 -0700
Message-ID: <dd0d9c06-115b-4462-84cb-a45d74a6d266@intel.com>
Date: Mon, 12 May 2025 17:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Sync up the driver-api/cxl documentation
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250512235818.1396979-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512235818.1396979-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 4:58 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> pmem.c regs.c mbox.c identifiers were missing. Add them to
> memory-devices.rst following their respective DOC comment includes.
> 
> Two acpi.c identifiers were available, but not used in kernel-doc's:
> 1) Add add_cxl_resources to memory-devices.rst and fix up the Sphinx
> complaint on the ascii art (escape and indent the pipes).
> 2) Add cxl_acpi_evaluate_qtg_dsm to access-coordinates.rst.
> 
> core/features.c is newish. Add a "DOC: cxl features" comment to the
> source and the doc and identifiers to memory_devices.rst.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> DaveJ: the "DOC: cxl features" addition was simply a copy from the
> Kconfig file. Please take a look and I can update.
> 
> 
>  .../driver-api/cxl/access-coordinates.rst      |  3 +++
>  .../driver-api/cxl/memory-devices.rst          | 18 ++++++++++++++++++
>  drivers/cxl/acpi.c                             |  6 +++---
>  drivers/cxl/core/features.c                    |  9 +++++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)

Looks good to me. Although I wonder if you will want to coordinate with Gregory as he's moving some stuff around in his doc series.


> 
> diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
> index b07950ea30c9..5f2ad093fabe 100644
> --- a/Documentation/driver-api/cxl/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/access-coordinates.rst
> @@ -89,3 +89,6 @@ ACPI0017 device to form a new xarray.
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated
>  bandwidth from all the members of the last xarray is updated for the
>  access coordinates residing in the cxl region (cxlr) context.
> +
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :identifiers: cxl_acpi_evaluate_qtg_dsm
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index d732c42526df..f378a5d7ba40 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
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

