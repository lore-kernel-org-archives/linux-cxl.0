Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37C17C6A
	for <linux-cxl@vger.kernel.org>; Tue, 28 May 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937401; cv=none; b=Gkmg8tyj1VOTuWoGXhwDd9i1+8HH6oDPPO2h1cmyEsGGzo/bz7ZVVv5PNbAU0N0/N8vNSL5xUAANraVu9UjPNxZQ0TQzj3HbyCvDe1RsNyWMW47ALAFwk9qKwYzSreJxjR5fa29RO2YpQv2+Jv509PCrMBqGJJB8XJC6SaU6LGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937401; c=relaxed/simple;
	bh=AB5PYiMkQMNfzqSXgg2VUHGHgPo/YM81gefZsKU4PZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4BYC0OwIwzm3DPlBgzsGwY6F6H8qGGbw4ol/5Ww2taUzy9oLwuLGEJtiwg+LCPYdQpAz0NB3k+tBBcfp02KHbVyde7OVaWH7D6f0ddZB4euq5h79Aoz5GE3OKzmf9r17IBiYYyXo6oAWAUmnfRqUV4dDgMk3DZQMDT+XcOI4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzQVcMGK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzQVcMGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937400; x=1748473400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AB5PYiMkQMNfzqSXgg2VUHGHgPo/YM81gefZsKU4PZM=;
  b=HzQVcMGKwzaveFQuek7ItTXDoeud42gLB9GDDJX7zqSAhqq2wS1SEGBC
   LkHQLwQ4ybFK5JVfTWbgICA7zNnXboptULrjB+LZfkoLlAVDOXnUpyK+P
   gmeZZg+GqiIVhAjQN8yKfglb6FvyeimBsZbX0wQEJiszGG79ZQgfrqvf8
   04UoKoPAroQQSsgU0nyC4Z3H71OGKqWZJrzJhP27MecYmqPSbbXgd6+5l
   PaL844/gODBA7GIUp24QM7h0Mq5KEw1sUnjD67nYGlFbG2cHtpotoZLlK
   UrUKYr0FWbcDK/cX7UE0Okc60Py5eze98eWuWbxEqL4AX0PTPXVT4wQEq
   w==;
X-CSE-ConnectionGUID: oKWVapGjRSmWmuMXuakYJg==
X-CSE-MsgGUID: w8m2luQzTXmMwE3JSvF0iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23920128"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="23920128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:03:19 -0700
X-CSE-ConnectionGUID: h/yD1ncATaSMnylK54ZXiA==
X-CSE-MsgGUID: g+cwqRe/SbaHodpN0bkplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="58411140"
Received: from gtryonx-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.99.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:03:18 -0700
Date: Tue, 28 May 2024 16:03:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH] cxl/test: Add missing vmalloc.h for
 tools/testing/cxl/test/mem.c
Message-ID: <ZlZitSOynKG1h61O@aschofie-mobl2>
References: <20240528225551.1025977-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528225551.1025977-1-dave.jiang@intel.com>

On Tue, May 28, 2024 at 03:55:51PM -0700, Dave Jiang wrote:
> tools/testing/cxl/test/mem.c uses vmalloc() and vfree() but does not
> include linux/vmalloc.h. Kernel v6.10 made changes that causes the
> currently included headers not depend on vmalloc.h and therefore
> mem.c can no longer compile. Add linus/vmalloc.h to fix compile
> issue.

s/linus/linux

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
>   CC [M]  tools/testing/cxl/test/mem.o
> tools/testing/cxl/test/mem.c: In function ‘label_area_release’:
> tools/testing/cxl/test/mem.c:1428:9: error: implicit declaration of function ‘vfree’; did you mean ‘kvfree’? [-Werror=implicit-function-declaration]
>  1428 |         vfree(lsa);
>       |         ^~~~~
>       |         kvfree
> tools/testing/cxl/test/mem.c: In function ‘cxl_mock_mem_probe’:
> tools/testing/cxl/test/mem.c:1466:22: error: implicit declaration of function ‘vmalloc’; did you mean ‘kmalloc’? [-Werror=implicit-function-declaration]
>  1466 |         mdata->lsa = vmalloc(LSA_SIZE);
>       |                      ^~~~~~~
>       |                      kmalloc
> 
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..eaf091a3d331 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/vmalloc.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> -- 
> 2.45.0
> 
