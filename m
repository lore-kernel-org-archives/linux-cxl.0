Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64F320CAC;
	Tue, 13 Jan 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327251; cv=none; b=tZtGn6KBpkCVafJnmZmEti+4pX3IOZl4jW4No0fpTOkUpzBgHNfbWM4SLkSzEF/kTAlWce/NTHuwXs7M+muLD++XS6KRjrQuyedK6+3ch3xiFxoLetAV4eSnALRJRqFg2L1tJj7ad6Pi0JvkiGR4dFYRUx7FTGknQiUXQy5/lSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327251; c=relaxed/simple;
	bh=utJOcK2eDSYKGkrOI+l1OgcYuTGqY3ept73HW1hVl/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9FawmLduXLjolBrFdSl3yzi6Y5gsvnWwqKqPDDasVMfHnIiDOCLY23uOUWcoHcHkjyCyb7jfOdGALR2nYBezrkFAAiRZrcfO0uwWglwzPZnwamDP4B3+MtOtGgSz5ZGarLWRsYDFbKR3qRM5FENjCL0+tMU9uc4MN8JtYhkei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLEcEkxV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLEcEkxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768327244; x=1799863244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=utJOcK2eDSYKGkrOI+l1OgcYuTGqY3ept73HW1hVl/4=;
  b=gLEcEkxVFMueGoxe69AMoJcIUY675tKCiH945+tsCPoRvQPTu8xy05hR
   QY3JRB/y0PIDwuf5X99dgp8hiFS5QEld20Iy2unN93T0EVNjuLUQMyNKy
   76xV5CP7rFoS8+rGSCGQvYmlUHC0Hz9Y0DaFlBqfHNCNsyicZI1WQ7wkn
   eMI7jmjwM3jo+ZGBInOaI3rJwhJ8d3OYqRZJhCtcjBEuFACHFlJlbJ4fw
   kGbUw8ywnj6DqhnX4bJ7l40bA657IAFthccmbf2gyLS1hatD3usLUZA4n
   Rxf6/W4bm35mq549Fq7qfRNTY/EnL6x2qUQVCfAu4A/dKLHpR8V4NCASO
   A==;
X-CSE-ConnectionGUID: X63rsgTfRJa86gtpNsEIMA==
X-CSE-MsgGUID: NN/ZqDHuScSq+vAazsVmkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73476490"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="73476490"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:00:44 -0800
X-CSE-ConnectionGUID: WdwIhNSkTyOsZWxukvS03w==
X-CSE-MsgGUID: PyVBGZydRwqxEOT5snIGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204341187"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 10:00:43 -0800
Message-ID: <bffeb2ea-f5c3-4ece-81be-74b647f027ac@intel.com>
Date: Tue, 13 Jan 2026 11:00:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
To: dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 1:59 PM, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
>> The CXL driver presently hands policy management over to DAX subsystem
>> for sysram regions, which makes building policy around the entire region
>> clunky and at time difficult (e.g. multiple actions to offline and
>> hot-unplug memory reliably).
>>
>> To support multiple backend controllers for memory regions (for example
>> dax vs direct hotplug), implement a memctrl field in cxl_region allows
>> switching uncomitted regions between different "memory controllers".
>>
>> CXL_CONTROL_NONE: No selected controller, probe will fail.
>> CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
>>                   otherwise register a dax_region
>> CXL_CONTROL_DAX : register a dax_region
>>
>> Auto regions will either be static sysram (BIOS-onlined) and has no
>> region controller associated with it - or if the SP bit was set a
>> DAX device will be created.
>>
>> Rather than default all regions to the auto-controller, only default
>> auto-regions to the auto controller.
>>
>> Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
>> a failure to probe unless a controller is selected.
>>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> ---
>>  drivers/cxl/core/Makefile             |   1 +
>>  drivers/cxl/core/core.h               |   2 +
>>  drivers/cxl/core/memctrl/Makefile     |   4 +
>>  drivers/cxl/core/memctrl/dax_region.c |  79 +++++++++++++++
>>  drivers/cxl/core/memctrl/memctrl.c    |  42 ++++++++
>>  drivers/cxl/core/region.c             | 136 ++++++++++----------------
>>  drivers/cxl/cxl.h                     |  14 +++
>>  7 files changed, 192 insertions(+), 86 deletions(-)
>>  create mode 100644 drivers/cxl/core/memctrl/Makefile
>>  create mode 100644 drivers/cxl/core/memctrl/dax_region.c
>>  create mode 100644 drivers/cxl/core/memctrl/memctrl.c
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 5ad8fef210b5..79de20e3f8aa 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>>  cxl_core-y += ras.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>> +include $(src)/memctrl/Makefile
> 
> Not sure this merits its own directory, but if it does just do the
> canonical:
> 
> obj-y += memctrl/
> 
> ...to add an object-sub-directory.
>  
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 1fb66132b777..1156a4bd0080 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -42,6 +42,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>>  		   u64 dpa);
>> +int cxl_enable_memctrl(struct cxl_region *cxlr);
> 
> This is a "probe" operation not an "enable" in terms of runtime ABI and
> presentation that starts decorating the region. In that respect it also
> is not a "control" as much as an "operation model / driver". So no need
> for a "control" concept, i.e.:
> 
> s/CXL_CONTROL_{NONE,AUTO,DAX}/CXL_DRIVER_{NONE,AUTO,DAX}/
> s/enum cxl_memctrl_mode/enum cxl_region_driver/
> 
> ...otherwise there is nothing in this proposal that makes me want to
> abandon the traditional meaning of a "driver" probing a "resource" in a
> certain way to make it usable with the rest of the kernel.
> 
> Rest of this looks fine. With that fixup if we are going to have a set
> of different region driver modes then the directory can be:
> 
> drivers/cxl/core/region/

Do we still have reasons to keep the region drivers in core? I know Fabio has been looking at moving the region drivers to drivers/cxl/ so the LMH cxl_test stuff doesn't doesn't need to do all the weird stuff to make it work. Maybe we just do the refactor now and move the region drivers outside of core. How about drivers/cxl/region/?

