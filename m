Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DA28A2D6
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467678; cv=none; b=ejLCqjMZzgZo85ZIbdC3PX7wEWW8g03tI6o9bkR30kf2G7dnDkQkcFW4BEYcn9xrpMyASZzQZzeMLwd9fwra3mmSZ+U4TRCZ+B0T5fSlAxNaSpwGN+914eLz8AYat7FSEVj55PpEOePpp+bUc74L8+nxjQIYcA0fJQDZugdd/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467678; c=relaxed/simple;
	bh=oqixTSNwKxpJ+g9JoTSR9UIJP2SGcVK5XDOPIXK/Sjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dzmh1TUBoPnq88bXXBLoENVn/FeVHN9xP+aFvbKQBXyLobOmkoVRz7Gp+sfTO4AgJjf+z4FVOqr++ymHvXV9/4Uvep+gQQe2KmVCfjO02dMcvhnkezXoN2Vgur98uclP0nAWvawrBSfWUkwdTeuysZuBHeSVpUJxBne9wRFlazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZfye7LJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZfye7LJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739467677; x=1771003677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oqixTSNwKxpJ+g9JoTSR9UIJP2SGcVK5XDOPIXK/Sjk=;
  b=JZfye7LJE6Jji+XD4BUTgFSFRNDW1dxvTcQGCYRwdBAvnW49CcBKUWVL
   zuosKzGPaFVxQMUIyHMA3nQk5DMDPwMfXPUkzfiDIjBMJJcRcx/SAakz3
   Wx45E/bNfUYWuUoK2av0kYiXjLo04hY0+TLHYjdH1Zmhs1vXTWJKFgoZ1
   iYoFFJCk0VETzlDE6ehbYNORqE8dXjrtEaEXzN0c7MQdOdnXqVovfXEZJ
   FgAFvXOllIXkXKKiycBvmmDKRiZO+RGjh/421fWOl5cfl+fL8KlX8nbqM
   +55aNWETkHnAj3OZCEsdc9NQ0j8m03VtDdcp7VrpnyzPDkZ678G4BrVni
   Q==;
X-CSE-ConnectionGUID: WZ7ZRlBHRkaXtQ+eTKRGvw==
X-CSE-MsgGUID: AW5NW4pdRFK2F+7a7kA/OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43021045"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43021045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:27:56 -0800
X-CSE-ConnectionGUID: rp6wkdwXThi+1+F4QvkZxg==
X-CSE-MsgGUID: rRThUFRmS+uPf8TkNUVuug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112952924"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:27:55 -0800
Message-ID: <f54675eb-2bf2-41b0-82c3-f27169d54283@intel.com>
Date: Thu, 13 Feb 2025 10:27:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
To: Saeed Mahameed <saeed@kernel.org>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, jgg@nvidia.com,
 shiju.jose@huawei.com, Li Ming <ming.li@zohomail.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com> <Z60QCS6o-3VInenG@x130>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z60QCS6o-3VInenG@x130>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/25 2:18 PM, Saeed Mahameed wrote:
> On 11 Feb 11:28, Dave Jiang wrote:
>> Add definition for fwctl_ops->info() to return driver information. The
>> function will return a data structure with a reserved u32. This is setup
>> for future usages.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> drivers/cxl/core/features.c | 11 +++++++++--
>> include/cxl/mailbox.h       |  1 +
>> include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
>> 3 files changed, 29 insertions(+), 2 deletions(-)
>> create mode 100644 include/uapi/fwctl/cxl.h
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index db48a8fbde81..923c054599ad 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -354,8 +354,15 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>>
>> static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>> {
>> -    /* Place holder */
>> -    return ERR_PTR(-EOPNOTSUPP);
>> +    struct fwctl_info_cxl *info;
>> +
>> +    info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +    if (!info)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    *length = sizeof(*info);
>> +
>> +    return info;
>> }
>>
>> static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
>> index c4e99e2e3a9d..60a26a0d8f1f 100644
>> --- a/include/cxl/mailbox.h
>> +++ b/include/cxl/mailbox.h
>> @@ -4,6 +4,7 @@
>> #define __CXL_MBOX_H__
>> #include <linux/rcuwait.h>
>> #include <cxl/features.h>
>> +#include <uapi/fwctl/cxl.h>
>> #include <uapi/linux/cxl_mem.h>
>>
>> /**
>> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>> new file mode 100644
>> index 000000000000..d21fd6b80c20
>> --- /dev/null
>> +++ b/include/uapi/fwctl/cxl.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2024, Intel Corporation
>> + *
>> + * These are definitions for the mailbox command interface of CXL subsystem.
>> + */
>> +#ifndef _UAPI_FWCTL_CXL_H_
>> +#define _UAPI_FWCTL_CXL_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
>> + * @reserved: zero
>> + */
>> +struct fwctl_info_cxl {
>> +    __u32 reserved;
>> +};
> 
> I would add some useful info such as: num_user_features, mbox->feature_cap,
> etc ...

Yes those can be useful to the user. I'll add them. 
> 
> Maybe if the callback is not implemented by the fwctl driver, then fwctl
> subsystem should make sure to return a default info struct or some zero
> response buffer.
> 
>> +#endif
>> -- 
>> 2.48.1
>>
>>
> 

