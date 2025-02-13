Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31868269824
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484676; cv=none; b=Mq8UYlKcXAhQSCUmxUmBWkMl+/ltG7rAG9hP93mRJAliCWIMGGYPSbQL2hYBWdru+7Redi5XtHe09xyVMu1fUwSI3psW3ziUVPWdkyx97jXwGoGugQMKbP4plNsWuu9LXfTQDjSDVIVtMUzu7ZbeWcgkpytUNeT5Kzt5+w7kQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484676; c=relaxed/simple;
	bh=wHbxgZBbqeQN4tIw5NwwcrMmnbZqgFIDj+0hbZBUqIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLfd6useld5aieF/tRTGiNsiOmHpxv8ZcQQ682ICyOSf8+fh3v/hYreAft6EKjCHCc05NsPZaOU0JpWh00DsKciLofpzjhAwi863UuYChHTeuyYzrRTfjgb0zfmikVOr2cvlKeE+2MAYf2JdznTXpjku8BhfxOwg/zEzTocse+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbBVptrd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbBVptrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739484675; x=1771020675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wHbxgZBbqeQN4tIw5NwwcrMmnbZqgFIDj+0hbZBUqIc=;
  b=RbBVptrdkx+CeimI+1Hnnsv71RhtTAu3y0th59Yawt1TejbVNOcrsFwO
   u3oVpiyG1uzWVs84EEa8mpYNr1zLEcYXZ8pOpHMJV9AtL89LqZ62RHgAa
   lHrOjcVoP+hEwHQd3JyVgvUAlTO82ThXTgMTImpQ5Q+nCWvf1GBClEh43
   KrTVevC8//eKsluYantQU/7BnoTown5oERS/L69Qib9OamXwId2gutR7Z
   n4+LUn5Qp6GXFIVXAfAJoMSm2S79eGGm+mhboOxn8RV1NFbcTeopF/Ga1
   Z2Kn9e4H6asiw4lmWTr0dHCTi/MQbUDQsVunS9hSf5XklJzjv0tKz1fSR
   w==;
X-CSE-ConnectionGUID: 1pjk61JTTeSWmRLyhKed3w==
X-CSE-MsgGUID: Aks5dYeqTOeSin6EbE39VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57617798"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="57617798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:11:15 -0800
X-CSE-ConnectionGUID: bLlIRqwsRYahqrWTiUqYfA==
X-CSE-MsgGUID: giGoWkAVTWuR92PUs6oGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118288856"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:11:13 -0800
Message-ID: <c57ed7ef-9339-4d02-9b01-a4bf30eed46c@intel.com>
Date: Thu, 13 Feb 2025 15:11:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
To: Dan Williams <dan.j.williams@intel.com>, Saeed Mahameed <saeed@kernel.org>
Cc: linux-cxl@vger.kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, Li Ming <ming.li@zohomail.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com> <Z60QCS6o-3VInenG@x130>
 <67ae35fcecf69_2d1e294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67ae35fcecf69_2d1e294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 11:12 AM, Dan Williams wrote:
> Saeed Mahameed wrote:
>> On 11 Feb 11:28, Dave Jiang wrote:
>>> Add definition for fwctl_ops->info() to return driver information. The
>>> function will return a data structure with a reserved u32. This is setup
>>> for future usages.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> drivers/cxl/core/features.c | 11 +++++++++--
>>> include/cxl/mailbox.h       |  1 +
>>> include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
>>> 3 files changed, 29 insertions(+), 2 deletions(-)
>>> create mode 100644 include/uapi/fwctl/cxl.h
>>>
>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>> index db48a8fbde81..923c054599ad 100644
>>> --- a/drivers/cxl/core/features.c
>>> +++ b/drivers/cxl/core/features.c
>>> @@ -354,8 +354,15 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>>>
>>> static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>>> {
>>> -	/* Place holder */
>>> -	return ERR_PTR(-EOPNOTSUPP);
>>> +	struct fwctl_info_cxl *info;
>>> +
>>> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
>>> +	if (!info)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	*length = sizeof(*info);
>>> +
>>> +	return info;
>>> }
>>>
>>> static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>>> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
>>> index c4e99e2e3a9d..60a26a0d8f1f 100644
>>> --- a/include/cxl/mailbox.h
>>> +++ b/include/cxl/mailbox.h
>>> @@ -4,6 +4,7 @@
>>> #define __CXL_MBOX_H__
>>> #include <linux/rcuwait.h>
>>> #include <cxl/features.h>
>>> +#include <uapi/fwctl/cxl.h>
>>> #include <uapi/linux/cxl_mem.h>
>>>
>>> /**
>>> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>>> new file mode 100644
>>> index 000000000000..d21fd6b80c20
>>> --- /dev/null
>>> +++ b/include/uapi/fwctl/cxl.h
>>> @@ -0,0 +1,19 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/*
>>> + * Copyright (c) 2024, Intel Corporation
>>> + *
>>> + * These are definitions for the mailbox command interface of CXL subsystem.
>>> + */
>>> +#ifndef _UAPI_FWCTL_CXL_H_
>>> +#define _UAPI_FWCTL_CXL_H_
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/**
>>> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
>>> + * @reserved: zero
>>> + */
>>> +struct fwctl_info_cxl {
>>> +	__u32 reserved;
>>> +};
>>
>> I would add some useful info such as: num_user_features, mbox->feature_cap,
>> etc ...
> 
> I much prefer Jason's suggestion of just allowing the subsystem to
> opt-out of the 'info' command.
> 
> The Features that are private / exclusive to the kernel are a small
> fixed list that is unlikely to grow.
> 
> There is no need for an info command when documentation can communicate
> what CXL Features are available through the fwctl interface.

Ok this patch is dropped for next rev.


