Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05221B8F8
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704853; cv=none; b=IRSCnLATtxWaDYtSgruiOIWG5qha8BOIHRuVhfwVmNyTGCLc2LhPeRupknd1xzOLM7ZqBOkUhvkLd/BuAm/bGPybJvggS6HNaNJa/FRM+rGv22k4gjT57IA4xHTD2ifz0MMdBBF7VSQ1pc2Q7ueA5ghIrJD66jWP+iTp3+xoG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704853; c=relaxed/simple;
	bh=fW3avi2IgvfnCpVBkPZ7D7yImREwgA8YAZcMh0DoMWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3hw+nEAOns/JbOC7GRqV/Offnodltzl03yf2FrisN97AEjIVKwa5dBNATxpd7l5eLMxd3tSkx1UpuuWp1MUnuDFBiPjP3xYJy+A1A3rTP5nhm8RjMSomfZClCHi9awRR9ScCFLnSMGIp3IpDYcKygLsenNeXzXEQJJ+XPEEFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3/QmoBO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3/QmoBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738704843; x=1770240843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fW3avi2IgvfnCpVBkPZ7D7yImREwgA8YAZcMh0DoMWE=;
  b=O3/QmoBO31KaaJI3GFOnQqWkFYoAC0hLgNoqK+lu/ZUMaGzmqJuJo2iG
   fpK9ZCGfadv7lB9URGz2PZCeIihR8hR/GHzwzTdzmOMO7xoRw2wC4oz2D
   1YDkStKWyCe6CVusYieTbU9H6vlVet+DNQRq0oMG6BsJtT3tFeKGNlVBU
   QIgk+bSVqcjyMDg/68s5gftRUmuviq3n1hvg33+SRYZPY/xYRs6Sb4Xn2
   S+XJokhzpj9Rj5mFvH+qtIYz4jUn8bn72PFCsvg+GShPfBHptePjuunVo
   OENOdFWDafvDZTu6ZBhgmKWlNrqH3gnha0Or2vWugWPoPQLPngQfLL3pd
   g==;
X-CSE-ConnectionGUID: vsBVcGizSp+dygywHtsbSQ==
X-CSE-MsgGUID: 3o6yCOUTSVqMyM1vhi0smA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39155481"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39155481"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:34:01 -0800
X-CSE-ConnectionGUID: TDTQuG+USHGdT11nmot5nw==
X-CSE-MsgGUID: qs0Q2ig7RriI516Nrvqylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114766048"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.57]) ([10.125.110.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:34:01 -0800
Message-ID: <9fb776c4-9090-4735-9ab2-5a89605bf672@intel.com>
Date: Tue, 4 Feb 2025 14:33:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] cxl: DPA partition metadata is a mess...
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alejandro Lucero <alucerop@amd.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 9:24 PM, Dan Williams wrote:
> Changes since v2 [0]:
> - Fix "no partition found" debug messages in update_perf_entry() and
>   cxl_memdev_set_qos_class() (Jonathan)
> - Avoid touching dpa_perf_contains() twice in the series to add / remove
>   NULL check (Alejandro)
> - Add a cxl_mode_name() helper (Jonathan)
> - Use @part as the iterator in cxl_dpa_set_part() to simplify mode
>   lookups (Jonathan)
> - Require ordered + contiguous partitions (Ira and Alejandro)
> - Fix partition detection for BIOS established reservations, and kill
>   CXL_PARTMODE_NONE (Jonathan)
> - Simplify release_skip() reuse its internals for request_skip()
>   (Jonathan)
> - Add patch6 to finish cleanup of explicit partition lookups
> 
> [0]: http://lore.kernel.org/173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com
> 

Series applied to cxl/next

> ---
> 
> As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
> device [1], and Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata.
> 
> In fact there was no design at all, just a couple of open-coded 'struct
> resource' instances for 'ram' and 'pmem' and a pile of explicit code
> referencing those resources directly.
> 
> See patch3 for more details on the specific problems that caused, and
> patch4 for the eyesore reduction of making the DPA allocation algorithm
> partition number agnostic.
> 
> The motivation with this effort is to make it easier to land the Type-2
> and DCD series.
> 
> [1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
> [2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com
> 
> ---
> 
> Dan Williams (6):
>       cxl: Remove the CXL_DECODER_MIXED mistake
>       cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
>       cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
>       cxl: Make cxl_dpa_alloc() DPA partition number agnostic
>       cxl: Kill enum cxl_decoder_mode
>       cxl: Cleanup partition size and perf helpers
> 
> 
>  drivers/cxl/core/cdat.c      |  101 +++++++------
>  drivers/cxl/core/core.h      |    4 -
>  drivers/cxl/core/hdm.c       |  319 ++++++++++++++++++++++++++++++++----------
>  drivers/cxl/core/mbox.c      |   66 +++------
>  drivers/cxl/core/memdev.c    |   66 +++++----
>  drivers/cxl/core/port.c      |   21 ++-
>  drivers/cxl/core/region.c    |  137 +++++++++---------
>  drivers/cxl/cxl.h            |   39 +----
>  drivers/cxl/cxlmem.h         |   52 ++++++-
>  drivers/cxl/mem.c            |    2 
>  drivers/cxl/pci.c            |    7 +
>  tools/testing/cxl/test/cxl.c |   22 +--
>  tools/testing/cxl/test/mem.c |    7 +
>  13 files changed, 519 insertions(+), 324 deletions(-)
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b

