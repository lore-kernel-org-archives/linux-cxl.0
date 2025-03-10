Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EA22DFEF;
	Mon, 10 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620289; cv=none; b=Oy4rT8bV8JM5fuEWxHiRFjym39nuDoetXuN7lk8Ml87EF7yljxbkp/3B2ULSz1/8BOdvi27+FxQ3xEPSf0g9ai/xRehnVbQ+GPuktAVopfdgpyDT6g4BX2x1nqPOz5FGCsVthFkcf6wFBtXo9bAiP8bNMgnammCtqLGlSNKEU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620289; c=relaxed/simple;
	bh=7tpV5sa+GTwYPbJyMwGRi8u1w9+/bMIElwEpk5G+vNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7LxU7Xnqb0TlSO5hamIdcX96AISyVpAKJasEsJXlr1M0A/GCAt0f7G+nsSNDJHB95ABmhnQLVr4IkHWUhQWLoG174znBaw86+OMGvZ4v3g3bmgmO6STqpdvptfZ7WlvRv7n69gkiW5OmJ0VRhNa9gwyUO/yd1HsV2ojiyd+xjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG1Puc7b; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG1Puc7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741620288; x=1773156288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tpV5sa+GTwYPbJyMwGRi8u1w9+/bMIElwEpk5G+vNw=;
  b=mG1Puc7bMr13hivUHwCy+Xv2fQEJ0A9eYBbOcLWQhhSvF4865KUED4Ec
   CaWeeeWHJvIHp5rDI/rvtyHOixstUVe3pnOYMlU7yJSSN3CqP0pmFTeSk
   GOwvPfquHSni7GJCv0s7EOyVjBr9rQFXGQc1eotCbZjlVYQJ9jUaX5caL
   6PyWpT1X+y9EyrzpPp6N4Kekilcg2UtIiiFq4pgb9rpZfXlD1Pr2iTkXK
   nx48ppD48ueU9zrYV2VZgdybXzC4pCE3Twu3JlJ+jIMGQ5rDdUXE93be2
   eaLJqYwlH25Wpd3qoD5bQPlPAlfF9+jvNVrz/emVrG1T7q/fBK6I/jvHk
   w==;
X-CSE-ConnectionGUID: kvF3fWDGQ3+u87LZdOH6gg==
X-CSE-MsgGUID: gJ/Dw5GcSXmX3WNJri6U7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42836650"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42836650"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:24:47 -0700
X-CSE-ConnectionGUID: rPaFCSSTQMKNAkCfiF91Gg==
X-CSE-MsgGUID: ENAPmGAOR7yAZvEzWfiMTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120222645"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:24:46 -0700
Message-ID: <0c2a1f2f-539f-4a94-82f4-57406421a3b8@intel.com>
Date: Mon, 10 Mar 2025 08:24:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: fix FWCTL dependency
To: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Robert Richter <rrichter@amd.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310135119.4168933-1-arnd@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250310135119.4168933-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 6:51 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'FWCTL' subsystem is selected by CXL_FEATURES, which is a 'bool' symbol
> with a dependency on CXL_PCI, but referenced by the cxl_core.ko.
> When cxl_core is built-in, but the cxl_pci.ko driver is a loadable mdoule,
> this results in a link failure:
> 
> ld.lld-21: error: undefined symbol: _fwctl_alloc_device
>>>> referenced by features.c:695 (/home/arnd/arm-soc/drivers/cxl/core/features.c:695)
> ld.lld-21: error: undefined symbol: fwctl_register
>>>> referenced by features.c:699 (/home/arnd/arm-soc/drivers/cxl/core/features.c:699)
> ld.lld-21: error: undefined symbol: fwctl_unregister
>>>> referenced by features.c:676 (/home/arnd/arm-soc/drivers/cxl/core/features.c:676)
> 
> Move the 'select' into the symbol that controls the core module instead.
> 
> Fixes: a53a6004e7a5 ("cxl: Add FWCTL support to CXL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks for the fix Arnd. Jason can you please append this fix to your latest branch? Thanks!

> ---
>  drivers/cxl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ed49e7e7e5bc..cf1ba673b8c2 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -7,6 +7,7 @@ menuconfig CXL_BUS
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
> +	select FWCTL if CXL_FEATURES
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> @@ -105,7 +106,6 @@ config CXL_MEM
>  config CXL_FEATURES
>  	bool "CXL: Features"
>  	depends on CXL_PCI
> -	select FWCTL
>  	help
>  	  Enable support for CXL Features. A CXL device that includes a mailbox
>  	  supports commands that allows listing, getting, and setting of

