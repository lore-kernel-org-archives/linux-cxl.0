Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68F5CDDC
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783618; cv=none; b=W799APAN3x+tInCNThYlSL/Gr49TKyHda7SBU6pcYj9BZRYWEYRJht5skhb+aRFGUNr/D1cKrrT7mZapQC+86NbFFRs2nw8tsDs0YuZke9Q795vsJkdpmgxK6BkZPJRdxxOIRWnhuw3wyVvMuCgu7lHcPYBMUoFVm6W02hlux+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783618; c=relaxed/simple;
	bh=rXqBG2xEQQHC3OE/2/MNY2l1cdoK9SxwhRmgdu82Jw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDSrvkEa7wWKIcUMo3P3/SbKIlr48lleWvLOnoFqPPKhB4ItdbK+xgTzIMiJIXZqdAjF5CXiGYH4ul/c7T7ABiuCJvN6jVEyleT2dwRu+EF4QPTmb4lNXZpF9US2LfPusQkFOrtxxDK3ZqPCTA8tRxWkgnjxYLkm1dWxi0p+eLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxIvzUVl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxIvzUVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707783616; x=1739319616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rXqBG2xEQQHC3OE/2/MNY2l1cdoK9SxwhRmgdu82Jw0=;
  b=OxIvzUVlutAiDjUGoJrJotil6cCpFNi/NzIJRS1w19EZUofm7oM/bTB3
   IK8gD4Fvr4XydDl37Rtll16sq2wVIxk3VEe0JcO+FIU34BtZtSyZCyWxX
   p1RxgFUzTve0ERKR12GYa4ugJ/6WUwOp0Ajv/kFmcg8h7RbOXA3K7xtFq
   QmwObWcfPBa8LhzPnwlqCdXjcCa49nzRgukc2DGTL8dCmJAAsbmT2rwvb
   8UF0lWREN3q4/sMIFVOSevSmUU0JW0UqpFxna6b1Q8krb52SXkrhw4C2y
   GfrLt3W6qgX3amjBj+QY5deajcdJZcgDCxhUlHxuzdgXK9tcm7eZiOy5/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24251018"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="24251018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 16:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935210031"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="935210031"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.42]) ([10.246.113.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 16:20:13 -0800
Message-ID: <fd03964a-0b16-42f3-8572-0a7686beda93@intel.com>
Date: Mon, 12 Feb 2024 17:20:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH SET] cxl: add poison event handler
Content-Language: en-US
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 4:54 AM, Shiyang Ruan wrote:
> Currently driver only trace cxl events, poison injection on cxl memdev
> is silent.  OS needs to be notified then it could handle poison range
> in time.  Per CXL spec, the device error event could be signaled through
> FW-First and OS-First methods.
> 
> This draft patchset adds poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record
>   - CXL driver
>     a. read the POISON event through GMER;
>     b. get POISON list;
>     c. translate DPA to HPA;
>     d. construct a mce instance, then call mce_log() to queue this mce
>        instance;
> 
> This patchset includes 2 patches for qemu, 5 patches for cxl driver.

Hi Ruan,
Next time please split this out and post as 2 different series. You can have the CXL driver series cover letter reference the QEMU changes. And please add QEMU to subject prefix for the QEMU patches. Thank you!

> 
> Shiyang Ruan (5):
>   cxl/core: correct length of DPA field masks
>   cxl/core: introduce cxl_memdev_dpa_to_hpa()
>   cxl/core: introduce cxl_mem_report_poison()
>   cxl/core: add report option for cxl_mem_get_poison()
>   cxl/core: add poison injection event handler
> 
>  arch/x86/kernel/cpu/mce/core.c |  1 +
>  drivers/cxl/core/mbox.c        | 82 +++++++++++++++++++++++++++-------
>  drivers/cxl/core/memdev.c      | 16 ++++++-
>  drivers/cxl/core/region.c      |  8 ++--
>  drivers/cxl/core/trace.h       |  6 +--
>  drivers/cxl/cxlmem.h           | 11 ++---
>  drivers/cxl/pci.c              |  4 +-
>  7 files changed, 97 insertions(+), 31 deletions(-)
> 
