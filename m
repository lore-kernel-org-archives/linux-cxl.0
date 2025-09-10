Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0042DC352
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545929; cv=none; b=Y46h1outal/S5DZlGXKI12QQZ/Iehv8s1Pxa6smpyLtNSDfWO3QVkWthioLTskV6nmWVcdG/zvaG9HoGUZHKZPlYFkgrKdPlxkiyrScoxYBbEuqpf2u3JUVslfllui30so8E7AjvdL3W4XfJdQbS0nOk6A+o0mmjlusBqA70w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545929; c=relaxed/simple;
	bh=mmBs0GfavNf3aOKZrjKx9GZbJrn/JQFWf9fSvaG9sQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A5MoBKqauh8sueLxoCYSU+T22ZKFvt32KfL+vCp86VHyED5vL5EZBu6tdUwCV10qUQUbdhc5Kensi9uAVT1u+HSRetpbOK7ynVn7vOfRGCYjfIJvS5mwVZfGaEkjGjGp++8DKizaa8/DRS5rwvCBhbQOxaKc1TVEe3LgxE51LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjurJldF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjurJldF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757545928; x=1789081928;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mmBs0GfavNf3aOKZrjKx9GZbJrn/JQFWf9fSvaG9sQI=;
  b=NjurJldFdkNMOh9qDrMiSgcgxufEb24Yw0WlAxq5/sVXSbvNoBMF8YiE
   r7ky6qMgk/w1ObvfMIG4GfGms5qKDLGGXp/CmXxMolCvmyM+2tvVL18Sh
   uO6mvwJU3GbSwYr90uRMymPgrug9dm4MVKfd+OlH3Ixu9sF98KsxTFecO
   tUXczVsyvBlergdKjW3P/5SksJNe/iPdUuNmVqtck0gDGnQKE6Ztx0XpF
   XcFYn9xjZ2Dg3U7JKHTsU384hVMgp7QdMPs4fbCH26isjuQWl77S075+c
   /uuUaL8Ei+hQ53/itcciFtnVfqaG9wQIx+16D2mcF7cIIxU0kSjV9cnmk
   w==;
X-CSE-ConnectionGUID: Wl3+cQnFQMuobwuhLL67Rw==
X-CSE-MsgGUID: aRzoVQ4US6mozVtYz+jgzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="85313516"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="85313516"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:12:07 -0700
X-CSE-ConnectionGUID: useCyqhWRSehtPXktJMf2w==
X-CSE-MsgGUID: YDqQ0AcFTH+e9CfBbo3CtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173362957"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:12:07 -0700
Message-ID: <2f651b8a-6185-4a68-84f4-1e8dcd9dbcb5@intel.com>
Date: Wed, 10 Sep 2025 16:12:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> This patch series adds initial CXL.cache support. What I have here only
> allows for adding a cache device to the system, programming/validating
> the system configuration with respect to cache devices, and some basic
> cache reporting/management.
> 
> The general philosophy is to have an endpoint/vendor-specific driver
> that runs through the same steps of adding a cxl_memdev, but for the
> cache portion of the device (both type 1 & 2). Getting cache support for
> a CXL device should be as simple as: get cache information, set up the
> memory region (see below), and then calling devm_cxl_add_cachedev().
> 
> There's a couple of things missing from this set:
> 
> 1) Missing an endpoint driver
> 
> 	I plan on submitting a reference driver (type 1 or 2) with v1, I
> 	figured I'd send out what I have before going much further.

Hi Ben,

Don't mind getting this all sorted out and discussed. But we will need a real vendor device out there at some point as a user for all the code to be merged.

DJ

> 
> 2) Mapping/Reserving host memory used for CXL cache(s)
> 
> 	I'm thinking this will be handled by the endpoint driver, but I'm
> 	not sure what mechanism would be used and whether to integrate it
> 	with the cxl_cache/core. Any thoughts/ideas here are appreciated!
> 
> 3) RAS Support
> 
> 	Same situation as 1) above.
> 
> Some quick notes: The actual cache parts of this set are untested due
> to problems with my set up, but I did make sure nothing here breaks type
> 3 support. I'll have this fixed before sending out a v1. This series is
> based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
> the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
> added Dave's set to help with getting around constraints with HDM
> decoders in CXL.cache device only configurations (see 08/18 for more).
> 
> Patch Breakdown:
> 	- 1 & 2: Preliminary changes for struct cxl_cachedev
> 	- 3: Add struct cxl_cachedev
> 	- 4-8: Preliminary changes for adding cache devices to port
> 	  hierarchy
> 	- 9: Function for getting CXL cache info
> 	- 10: cxl_cache driver (mirrors cxl_mem)
> 	- 11-16: Checking CXL.cache capabilities for system configuration
> 	  validity
> 	- 17-18: Cache device attributes
> 
> [1]:
> Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/
> 
> Ben Cheatham (18):
>   cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
>   cxl: Move struct cxl_dev_state definition
>   cxl/core: Add CXL.cache device struct
>   cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
>   cxl: Change cxl_ep_load() to use struct device * parameter
>   cxl/port, mem: Make adding an endpoint device type agnostic
>   cxl/port: Split endpoint port probe on device type
>   cxl/port: Update switch_port_probe() for CXL cache devices
>   cxl/core: Add function for getting CXL cache info
>   cxl/cache: Add cxl_cache driver
>   cxl/core: Add CXL snoop filter setup and checking
>   cxl/cache: Add CXL Cache ID Route Table mapping
>   cxl/cache: Implement Cache ID Route Table programming
>   cxl/cache: Add Cache ID Decoder capability mapping
>   cxl/cache: Implement Cache ID Decoder programming
>   cxl/cache: Add cache device counting for CXL ports
>   cxl/core: Add cache device attributes
>   cxl/core: Add cache device cache management attributes
> 
>  drivers/cxl/Kconfig         |  14 +
>  drivers/cxl/Makefile        |   2 +
>  drivers/cxl/cache.c         | 276 +++++++++++++++++++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
>  drivers/cxl/core/hdm.c      |  31 +++
>  drivers/cxl/core/memdev.c   |   2 +-
>  drivers/cxl/core/pci.c      | 134 ++++++++++
>  drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/region.c   |  25 +-
>  drivers/cxl/core/regs.c     |  28 ++
>  drivers/cxl/cxl.h           | 193 +++++++++++++-
>  drivers/cxl/cxlcache.h      |  42 +++
>  drivers/cxl/cxlmem.h        | 121 +--------
>  drivers/cxl/cxlpci.h        |  10 +
>  drivers/cxl/mem.c           |  14 +-
>  drivers/cxl/pci.c           |   2 +-
>  drivers/cxl/port.c          |  54 ++--
>  drivers/cxl/private.h       |   8 +-
>  19 files changed, 1569 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/cxl/cache.c
>  create mode 100644 drivers/cxl/core/cachedev.c
>  create mode 100644 drivers/cxl/cxlcache.h
> 

