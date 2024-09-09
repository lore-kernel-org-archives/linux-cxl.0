Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA68763F8;
	Mon,  9 Sep 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897291; cv=none; b=lfrETM71a9+0i0Q0QzEiFDK7ygwUO0DoPGcEf05quMdcgN9skC5sbuM82lmOWwxKny9q96VRmat8zg8OzU94FcDTSK+Bnebf6/mbJzQXBOZkqrGc0NezD3eopmesuWgwt5yGP9GCtUQCDYJFKxg4ZcuYQA4QmdUslLO20a0ulxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897291; c=relaxed/simple;
	bh=+uGnYCjUT/NVMvr1cpyFalap64xtS8Z9/rfyIqum9vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgZ/YPyCYiSEGCjJG4sX2hOdC0K1DHqsTvPrMEoOWUMlVMO/brNnMaCaCQSZKpka+7hFdFNxR1WqTaah9i71RXJXG968bPK/frlAh1f3xRLzZXslEzLRLvOYnl6AdYRn834qqm29QvxB6uU/jWzYiInmoWLUpJfqtc+uUYYR87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI9AVz+v; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI9AVz+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725897290; x=1757433290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+uGnYCjUT/NVMvr1cpyFalap64xtS8Z9/rfyIqum9vM=;
  b=GI9AVz+v5/lZB4qDydtrDuCu3oiONI/kb0kaERlRDPkE40H2QR9nncUe
   eYtUNCTOXnOk1XTDNubpQolfIqN+hUaZ4k+loarA4KtY9lS1Q34v06FJQ
   CxRTcWo4q6FQ94pB/2U1f9qntDT2x8XLk8FGbezqiPGLxvCwuKxpepoTj
   Ehc/jh1zNuCJeYZhn3knFRXaJfyORwNaZVd1+rDKQJo0ARrUrjp3zmF5X
   DM45IzRvh2ca1ZtmhrW/oOZhuefwK0rVcYd8oSWtcY/gQGIZvkhVUG9TC
   DZfX6HriHPNi+4NFab3ySZYtQoXbqln32uHFEyKuUw0rS1FwDSxkGq6nJ
   g==;
X-CSE-ConnectionGUID: 47FvekFfQJ6TAuqKAoZwOw==
X-CSE-MsgGUID: I/y2+n4UQOCIbqKJHaL7Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24546403"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24546403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:54:49 -0700
X-CSE-ConnectionGUID: YSN3DODbT8upS3OlQCbUmg==
X-CSE-MsgGUID: V772WMAKR96M41s+trwwoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="89998797"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.50]) ([10.125.111.50])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:54:48 -0700
Message-ID: <51e61de6-71de-4d3f-a11f-7e245c3eb969@intel.com>
Date: Mon, 9 Sep 2024 08:54:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: add cxl region test template
To: luzhixing12345 <luzhixing12345@gmail.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240909091938.27647-1-luzhixing12345@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240909091938.27647-1-luzhixing12345@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 2:19 AM, luzhixing12345 wrote:
> CXL2.0 support dynamic provisioning of new memory region,
> add cxl region test template
> 
> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
> ---
>  MAINTAINERS                         | 1 +
>  tools/testing/cxl/Kbuild            | 6 ++++++
>  tools/testing/cxl/cxl_region_test.c | 6 ++++++
>  tools/testing/cxl/test/cxl.c        | 1 +
>  4 files changed, 14 insertions(+)
>  create mode 100644 tools/testing/cxl/cxl_region_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998..708407d34584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5616,6 +5616,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
>  M:	Dan Williams <dan.j.williams@intel.com>
> +M:	luzhixing12345 <luzhixing12345@gmail.com>

lol NAK nice try

>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 3d1ca9e38b1f..8b430274a1ad 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -67,6 +67,12 @@ cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o
>  
> +obj-m += cxl_region.o
> +
> +cxl_region-y += $(CXL_CORE_SRC)/region.o
> +cxl_region-y += config_check.o
> +cxl_region-y += cxl_region_test.o
> +
>  KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
>  
>  obj-m += test/
> diff --git a/tools/testing/cxl/cxl_region_test.c b/tools/testing/cxl/cxl_region_test.c
> new file mode 100644
> index 000000000000..c5859a96e35b
> --- /dev/null
> +++ b/tools/testing/cxl/cxl_region_test.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +
> +#include "watermark.h"
> +
> +cxl_test_watermark(cxl_region);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 90d5afd52dd0..320aaed2df17 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1304,6 +1304,7 @@ static __init int cxl_test_init(void)
>  	cxl_mem_test();
>  	cxl_pmem_test();
>  	cxl_port_test();
> +	cxl_region_test();
>  
>  	register_cxl_mock_ops(&cxl_mock_ops);
>  
