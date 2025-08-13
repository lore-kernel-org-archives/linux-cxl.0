Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388388836
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043605; cv=none; b=SCC9vmkUQsMQjBcb5XRDWQOttbSzivbQ2jdlEkYEEQhH5HYbm2NE6G7VIKh35WZTzxyWIiDEMj4WujV9CVXCQWdcjPMA5oXpRRz7CkVvOFnCiOgS2ZDnJciZnhMgjsSKijG8b0J9XP6bZXwa9yEYVD/+iIK7O/8yVCqxEfR4aLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043605; c=relaxed/simple;
	bh=5cN4wmsk9/qmfIfi8WkqM9NfzuBleuYzPpkRdV05AHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUcZPnXxWdv/ALup0wMbRaVROKe33C/Mf1qzrVT5HwRVw5v0EdHtNFs0z1QZKEejZvQNW4TPOHYhTQzfU7S5rd1UA5zwzdFcuQEk/QHTL+7Y1r2IB1poiwlOMyF0QOicA0ulI8ygrkWyHKr1+7hN6fyknUjOkfW1FQpnmfl8Bbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2/7iAYb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2/7iAYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755043603; x=1786579603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5cN4wmsk9/qmfIfi8WkqM9NfzuBleuYzPpkRdV05AHY=;
  b=D2/7iAYbUEd01aVX4v2kbof77JDMKstPrTdPv2j9B4IppWTIUwyqFxxt
   xHEtSXzaqa+Ev8o9RicCSsZeB5Sg1yndyv51OIn0vYtUTgxh3LmpH8khL
   cYf0oeLkZI9kQmnHZt2lBu4+tXl5yp4ESUKKp0Yu6+yy0lGjVLjjmhED+
   U3tcST9RDK0LK87n/dnHLAxBaT75bDHBc8PaY30nYo86kRoMFJ0AyznXX
   JarPwd0mjmuDKfs0EKA2w+O0vO313c/NXW75ROV9VseNE5BrhxdCRsks1
   BCAD46g3ubMCabh9fQH6veM267Z9Uf2k5kEvQq3HQpdoGPRUff4UJ9mtT
   w==;
X-CSE-ConnectionGUID: uVueG98UTla1OM895wdKBA==
X-CSE-MsgGUID: lxgMMrQTR/umlcYM4GFW6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79902207"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="79902207"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:06:42 -0700
X-CSE-ConnectionGUID: zB6V9CcRTPyOs7t+gnh16Q==
X-CSE-MsgGUID: UyB2aa/MSx2Xl/jznXzzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="197314085"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.149]) ([10.247.119.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:06:39 -0700
Message-ID: <53f02cb0-f1ef-42ab-9df7-8fe7894be32c@intel.com>
Date: Tue, 12 Aug 2025 17:06:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] cxl: Support Poison Inject & Clear by Region
 Offset
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1754290144.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cover.1754290144.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 1:00 AM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Built upon cxl repo branch cxl/next
> A CXL Unit Test update to cxl-poison.sh is posted separately.

Applied to cxl/next
d9412f08e25a

> 
> Changes in v5:
> Changelog appears per patch also.
> Patch 1: Remove stray blank line in cxl_root_decoder_alloc() (DaveJ)
> Patch 5: Update Documentation/driver-api/cxl/maturity.map
> 
> Changes in v4:
> Changelog appears per patch also.
> Add new precursor patch creating a root decoder ops structure (DaveJ)
> Add /* Input validation ensures valid ways and gran */ (Jonathan)
> Use a temp instead of modifying hpa_offset in place (Jonathan)
> Reorder mask addends to match spec definition (Jonathan)
> Add a blank line, remove a blank line (Jonathan)
> s/Deivce/Device in commit log (Jonathan)
> Use div64_u64_rem() for MOD operation (lkp)
> Simplify return in cxl_[inject|clear]_poison() (Jonathan)
> 
> Changes in v3:
> Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
> Collapse a header comment into pos and offset blocks (Jonathan)
> Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
> Mask off bottom bits in < 8 offset case (Jonathan)
> Wrap code comments closer to column 80 (Jonathan)
> Use a continue to un-nest a for loop. (Jonathan)
> Undo v2 return of rc from locked variants. Return 0. (Jonathan)
> Return rc from region_offset_to_dpa_result() if present (Jonathan)
> Remove the errant Documentation/ABI fixup (Jonathan)
> Add the above rc to the dev_dbg message
> 
> Changes in v2:
> Rebased onto cxl repo branch for-6.17/cxl-acquire
> As the ACQUIRE() set noted, ACQUIRE() syntax leads to a checkpatch
> ERROR: do not use assignment in if condition
> We'll have to endure that noise here until that set is merged with
> a checkpatch.pl update or a change to the syntax.
> 
> Changelog appears per patch also:
> Simplify return using test_bit() in cxl_memdev_has_poison() (Jonathan)
> Use ACQUIRE() in the debugfs inject and clear funcs (DaveJ, Jonathan)
> Shift by (eig + eiw) not (eig + 8) in MOD 3 interleaves** (Jonathan)
> Simplify bottom bit handling by saving and restoring (Jonathan)
> Return the rc from locked variants in cxl_clear/inject_poison
> Fail if offset is in the extended linear cache (Jonathan)
> Calculate the pos and dpa_offset inline, not in a helper
> Remove the not customary __ prefix from locked variants
> Added 'cxl' to an existing ABI for memdev clear_poison
> Add and use a root decoder callback for spa_to_hpa()
> Redefine ABI to take a region offset, not SPA (Dan)
> Use div64_u64 instead of / to fix 32-bit ARM (lkp)
> Use div64_u64_rem instead of % for arch safety
> Remove KernelVersion field in ABI doc (Dan)
> Pass pointer to results structures (DaveJ)
> Add spec references and comments (DaveJ)
> Warn against misuse in ABI doc (Dan)
> Add validate_region_offset() helper
> 
> 
> Begin Cover Letter 
> 
> This series allows expert users to inject and clear poison by writing a
> System Physical Address (SPA) to a region debugfs files. At the core of this
> new functionality is a helper that translates an HPA into a Device Physical
> Address (DPA) and a memdev based on the region's decoder configuration.
> 
> The set is not merely a convenience wrapper for these region poison
> operations as it enables these operations for XOR interleaved regions
> where they were previously impossible.
> 
> Patch 1 Creates a root decoder ops structure
> 
> Patch 2 defines a SPA->CXL HPA root decoder callback for XOR Math. It's a
> restructuring and renaming exercise that enables the reuse of an existing
> xormap function in either direction SPA<-->CXL HPA. It gets used in Patch 2.
> 
> Patch 3 introduces the translation logic capable of retrieving the memdev
> and a DPA for a region offset.
> 
> Patch 4 adds a locked variant of the inject and clear poison ops to
> support callers that must hold locks during the entire translation and
> operation sequence. It gets used in Patch 5.
> 
> Patch 5 exposes the capability through region debugfs attributes that 
> only appear when all participating memdevs support the poison commands.
> 
> By the end of Patch 5 a region offset has been translated to a memdev
> and a DPA and can simply be passed through to the pre-existing per memdev
> inject and clear poison routines.
> 
> Alison Schofield (4):
>   cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
>   cxl/region: Introduce SPA to DPA address translation
>   cxl/core: Add locked variants of the poison inject and clear funcs
>   cxl/region: Add inject and clear poison by region offset
> 
> Dave Jiang (1):
>   cxl: Move hpa_to_spa callback to a new root decoder ops structure
> 
>  Documentation/ABI/testing/debugfs-cxl         |  87 +++++++
>  Documentation/driver-api/cxl/maturity-map.rst |   2 +-
>  drivers/cxl/acpi.c                            |  35 ++-
>  drivers/cxl/core/core.h                       |   4 +
>  drivers/cxl/core/memdev.c                     |  60 +++--
>  drivers/cxl/core/port.c                       |   1 +
>  drivers/cxl/core/region.c                     | 237 +++++++++++++++++-
>  drivers/cxl/cxl.h                             |  14 +-
>  drivers/cxl/cxlmem.h                          |   2 +
>  9 files changed, 406 insertions(+), 36 deletions(-)
> 
> 
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f

