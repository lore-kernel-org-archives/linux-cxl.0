Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05491DD0F2
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297810; cv=none; b=B5DHoUs1OitPV7beU15oRfh8pQ9POEg+SITKS+9AgRBWs2OlFXKF3IUgPJeUNq8K3FPBFJ2wiiUC8q8ozULFe9mrb+dNqpUAYpT57hlYnJaLYDuUyVz0/8Rb689r3XGwAjr15TjzY7weLsHTU/ZBnpLeLS/r2xOdvc0EXz7F+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297810; c=relaxed/simple;
	bh=xk5TBH72OELJ8Gazi5bGothmxeSQnBHyEi9nxpj25eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BafDw2E1eJRgOoSDM3EMhFqpVfEKfDCAhPf2Uv8hlccgWXEHlHJ+vN+iKBscdguI06wtNoNeXfApJKlZA6+oyB0tNFobvQ9oCaSzjPPYTP6rlDnP2KAjoW5Dg+uWmxPDoJuWXQ+tJI4/rSxJDVl1vaiFRjGbeJMyhvzd7RVZFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeYfirtL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeYfirtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744297809; x=1775833809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xk5TBH72OELJ8Gazi5bGothmxeSQnBHyEi9nxpj25eA=;
  b=AeYfirtLl21MZa5G8aL+oBkjDxFcge38GAM5x6KMyckqfjti2kbVckvw
   w/n9xaZZd09NM9w2dAES6wGTAnABMRC1inIuuf4q9CDvJvKE2sVOGvql4
   Kg0P7wrFxR9u/WlQ5m4BxQkx82irW+/6IUQyCHDv9NndyKKdkXaO7kyb0
   xNi0267LkDEyOIO4CcNoQilzKKGbRyBg0zHgALM6PRtBOCl7jnxfOiOMg
   /xVXpaRyaFf8S6ud49YudYKNwdCmcYfF8OgwjP6BQuKKv22Z0tx7lIHXm
   WUhwWbvbrVb/5i9o/8aXwXBDCSgWwbckZMWqksKRaU9uGMncOOWKF185q
   g==;
X-CSE-ConnectionGUID: nAhXbwluS523fwDaQgkahA==
X-CSE-MsgGUID: 0KkkiR9QTne3SbRYYjSdTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71212119"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="71212119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:10:07 -0700
X-CSE-ConnectionGUID: tTQbinUiQqmiSAof5RUSBw==
X-CSE-MsgGUID: 5epT1rmHSqyVrSdvRSYKWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134104148"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:10:06 -0700
Message-ID: <7938f399-3e96-48a0-8329-5d938728e6dc@intel.com>
Date: Thu, 10 Apr 2025 08:10:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] cxl: Move cxl feature command structs to user
 header
To: Borislav Petkov <bp@alien8.de>
Cc: linux-cxl@vger.kernel.org, jgg@nvidia.com, saeedm@nvidia.com,
 jonathan.cameron@huawei.com, Dan Williams <dan.j.williams@intel.com>,
 Li Ming <ming.li@zohomail.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
 <20250307205648.1021626-3-dave.jiang@intel.com>
 <20250410150315.GHZ_fds7lfQWfdQDrg@fat_crate.local>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250410150315.GHZ_fds7lfQWfdQDrg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 8:03 AM, Borislav Petkov wrote:
> On Fri, Mar 07, 2025 at 01:55:32PM -0700, Dave Jiang wrote:
>> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
>> new file mode 100644
>> index 000000000000..7f7ab4aefec2
>> --- /dev/null
>> +++ b/include/uapi/cxl/features.h
>> @@ -0,0 +1,169 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2024,2025, Intel Corporation
>> + *
>> + * These are definitions for the mailbox command interface of CXL subsystem.
>> + */
>> +#ifndef _UAPI_CXL_FEATURES_H_
>> +#define _UAPI_CXL_FEATURES_H_
>> +
>> +#include <linux/types.h>
>> +#ifndef __KERNEL__
>> +#include <uuid/uuid.h>
>> +#else
>> +#include <linux/uuid.h>
>> +#endif
> 
> This doesn't help in allmodconfig builds:
> 
> In file included from ./usr/include/fwctl/cxl.h:12,
>                  from <command-line>:
> usr/include/cxl/features.h:11:10: fatal error: uuid/uuid.h: No such file or directory
>    11 | #include <uuid/uuid.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [usr/include/Makefile:85: usr/include/fwctl/cxl.hdrtest] Error 1
> make[3]: *** [scripts/Makefile.build:461: usr/include] Error 2
> make[2]: *** [scripts/Makefile.build:461: usr] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/amd/kernel/linux/Makefile:2006: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 

Thanks Boris. Jason has a fix queued for 6.15-rc.
https://lore.kernel.org/linux-cxl/20250407174910.GA1725933@nvidia.com/


Installing the uuid-devel package also helps with the allmodconfig issue for now.



