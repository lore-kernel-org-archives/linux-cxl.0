Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A517BEC8
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317749; cv=none; b=EtXoDO1x5sLpIgzKX8rLcTj8qs7ZuJVwa1kq+H0Y/ETxO19zTtE7NdvNHXJeNt18SzrthwOlSwcRyP15Awt0suHYAEdH2AvtiY3Nu2iW5eRDA6EibIhkALz3p/lECjYmiivCaAk7ovq4AqbO09eNMeuEFtESa7aiHaKGRTr306E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317749; c=relaxed/simple;
	bh=o4wW4y045oQgWPcENRxkrpyouCbvBW5nOL6d06S7C2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEax8SYxci8p+5qAU0x2A5v3PxIT5aN3+wr+jsHExYR6rPEtswbllQDXC//sNrjc0Sn3iHnbBISTMhd8bBXEmfkvcYylmNXdizVV3DmZftl1H3gQ1hzjo8rPSCcYQE7Nb778HcwsUu5EJ2ehE0qpyFqUVZLdGseXWfLO+ijOgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alOMBQmq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alOMBQmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732317748; x=1763853748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4wW4y045oQgWPcENRxkrpyouCbvBW5nOL6d06S7C2o=;
  b=alOMBQmqbbcv55Qz/89VebOzpmPjYHFREhydrmEWj7i8/lr2/SKeM6Wr
   mJF3i749MI71j2gbVtAZAkoFVuTCtCZuq2XV9YQA02P3L+EGpbAJcGtHp
   MGcnOx2eZh1NpNKlFTxnmIQde8BLBUyPVTMDwJqBkgD02AB6lZkvG+aU8
   SRW9n/elnLyvwXjnzd3/p3keznc/kIJGDhZ9pl5DPYxPRFxdxoT637ERf
   bJ3LJI2GKBxyS7M2pfkRJnM9Jvi1ZDRn6ndrY9Xxisn5dzWedYcAZ2Q5O
   qYC9ClAb3UB65fK9hJH+XVkzJ1aWGJrFEKZAURfR4+/xWKWJvAmfp3alU
   w==;
X-CSE-ConnectionGUID: ganGNX47TjO4gRU8RaDYrQ==
X-CSE-MsgGUID: TeSchpSBSDWRgaYe3ZZf4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43133930"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43133930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:22:27 -0800
X-CSE-ConnectionGUID: ube9KkVtRja+l2BZDGjWPA==
X-CSE-MsgGUID: jdqlLwvyRYCNg83/mWRs0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127010"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:22:27 -0800
Message-ID: <98274806-3d5e-47c9-be84-52035cb3ffd5@intel.com>
Date: Fri, 22 Nov 2024 16:22:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver
 information
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-11-dave.jiang@intel.com>
 <20241121181157.00006eee@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241121181157.00006eee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/24 11:11 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:25:43 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add definition for fwctl_ops->info() to return driver information. The
>> function will return the number of device mailbox commands supported by the
>> fwctl char device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Few minor things inline
> 
> Jonathan
>> ---
>> v2:
>> - Change driver info to report number of commands supported by the driver and device.
>> ---
>>  drivers/cxl/core/mbox.c  | 46 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/fwctl/cxl/cxl.c  | 23 ++++++++++++++++++--
>>  include/cxl/cxl.h        |  2 ++
>>  include/cxl/mailbox.h    |  1 +
>>  include/uapi/fwctl/cxl.h | 22 +++++++++++++++++++
>>  5 files changed, 92 insertions(+), 2 deletions(-)
>>  create mode 100644 include/uapi/fwctl/cxl.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 12758e763650..f464eb42f08a 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -118,6 +118,14 @@ static u8 security_command_sets[] = {
>>  	0x46, /* Security Passthrough */
>>  };
>>  
>> +#define FWCTL_CXL_MAX_COMMANDS 3
> 
> Use this to size the array? Will let us know if it gets
> out of sync.
> 
>> +/* Command set that is allowed with FWCTL-CXL */
>> +static u16 fwctl_command_sets[] = {
>> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +	CXL_MBOX_OP_GET_FEATURE,
>> +	CXL_MBOX_OP_SET_FEATURE,
>> +};
>> +
> 
>>  static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 6bfd7942a3f7..d0939e3bcbc0 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -3,6 +3,8 @@
>>  #ifndef __CXL_GLOBAL_H__
>>  #define __CXL_GLOBAL_H__
>>  
>> +#include <linux/device.h>
> 
> Why in this patch?

I got a 0-day report with this patch complaining about missing 'struct device' definition on some weird arch. May be a current issue that needs a standalone fix.
 
> 
>> +
>>  struct cxl_driver {
>>  	const char *name;
>>  	int (*probe)(struct device *dev);
> 

