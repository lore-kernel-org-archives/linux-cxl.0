Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA877243369
	for <linux-cxl@vger.kernel.org>; Sun,  9 Feb 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739065594; cv=none; b=gESaSSegGoCeX/hystZeit/+4pxWVUVyRb2wzcjd6s6j8roCT9oghen+uEFhY0DwTmqU4ZwCUUYSNV5AJLg5tiyIgYQ8iNDSgGp7rQ/5P+a7LskjptR0KRYLUAygdJLnJ6qpCzQYi8jdkIa3WaPf8mz0mG8cTszkc+MFQRh4tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739065594; c=relaxed/simple;
	bh=pn9rpmhaBQs7XWJoRFSEIOMSHsm3U2pa/vc4la0TCiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN3suxLmCmwyDkFJv8cG/LoDZoui+BhG26RT9Y8ZAW4bcoDcpO0aXkrR7dxkAXbZ0+JTvm2tCSAxC9FTshipYAq7INjOsoexoYUHfdhxsHvr2TZZw5StFPeo4yXWog37wDRx1Lii8Y4sXe23PPymlnnRMw+91q9Rr4+5mnM45P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVPhLi+O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVPhLi+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739065592; x=1770601592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn9rpmhaBQs7XWJoRFSEIOMSHsm3U2pa/vc4la0TCiY=;
  b=lVPhLi+OM7J0JH5FDW7YNPLaSqOUdEXhzRy0ccPrPHR9BX9/Ib4Le6k/
   19VoUjUBw0mIXFE9FB1D/7+1M+mA8NscDkqiGPoJw4K178M8CrD51sZbY
   4CtK2CqV/fvxbzJwiBtAjxGBkQl5g6hNRreJx+dN0DJ928L1Ts78a3UBH
   XOQ+KiwScK2RJqMk6l+m5htIRQ+Wxur79fRNKsB6u73aXNtwWg6IperTT
   LwP/fV7srwfJ3SfZHXRxHFKQt1VZkuMt7A8shovzzPJhrJ8oxqT01BcMy
   HPkR6DNSa2Rca08Xj1DRl/XK7H79gTx2hXPOQ6EbWp5UQRsaJmlqqi42m
   A==;
X-CSE-ConnectionGUID: E0SGek7fSHqbZJhPcGTfJw==
X-CSE-MsgGUID: ZUeE2nvXTxq5SGdn9MWRuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="42516972"
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="42516972"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 17:46:31 -0800
X-CSE-ConnectionGUID: 4MP1j8XTR4ezm+0vKkGFLg==
X-CSE-MsgGUID: EpOiMZ5CT0izH29DPsXSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="111689501"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.139])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 17:46:30 -0800
Date: Sat, 8 Feb 2025 17:46:28 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 1/1] daxctl: Output more information if memblock is
 unremovable
Message-ID: <Z6gI9AI5slmNc7S2@aschofie-mobl2.lan>
References: <20241204161457.1113419-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204161457.1113419-1-ming.li@zohomail.com>

On Thu, Dec 05, 2024 at 12:14:56AM +0800, Li Ming wrote:
> If CONFIG_MEMORY_HOTREMOVE is disabled by kernel, memblocks will not be
> removed, so 'dax offline-memory all' will output below error logs:
> 
>   libdaxctl: offline_one_memblock: dax0.0: Failed to offline /sys/devices/system/node/node6/memory371/state: Invalid argument
>   dax0.0: failed to offline memory: Invalid argument
>   error offlining memory: Invalid argument
>   offlined memory for 0 devices
> 
> The log does not clearly show why the command failed. So checking if the
> target memblock is removable before offlining it by querying
> '/sys/devices/system/node/nodeX/memoryY/removable', then output specific
> logs if the memblock is unremovable, output will be:
> 
>   libdaxctl: offline_one_memblock: dax0.0: memory371 is unremovable
>   dax0.0: failed to offline memory: Operation not supported
>   error offlining memory: Operation not supported
>   offlined memory for 0 devices
> 
> Besides, delay to set up string 'path' for offlining memblock operation,
> because string 'path' is stored in 'mem->mem_buf' which is a shared
> buffer, it will be used in memblock_is_removable().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---

Hi Ming,

I was looking to merge this today but realized that I only have
a test for it in the 'affirmative'. The ndctl:dax unit tests exercise
this path, but since nfit-test module requires CONFIG_MEMORY_HOTREMOVE
I could only prove that this works one way. I put in some printfs and
saw it in action:
        libdaxctl: memblock_is_removable: Ming: memblock_is_removable()
        libdaxctl: offline_one_memblock: Ming: return from memblock_is_removable()

Let's get another reviewer eyes on this before merging.
Also, if you can add your qemu (i'm guessing) demo that would be helpful.

Also, we were having discussions about exposing more info to user, but I
think that can be a follow on. You can propose that it another patch after
this one, if you think it is worthwhile.



snip
