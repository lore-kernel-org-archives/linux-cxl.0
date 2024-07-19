Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DF1B86D5
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404113; cv=none; b=XZdgXEVBgNARnnTbD7THiEuTrhjfk3O5pZdjG042Und6iQ8pStoDCZgPubDRFvkvKPbTTN/ZXm8jjwsh4JdWA0DKf8o4Tdqzb7Hpf0sUCrpZCc7G1DgsvqXwdduoQPZKd5E4SakipyCcyfxEFYP3ihjkfqcjGAIJVE9GGIF4BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404113; c=relaxed/simple;
	bh=CqmhVZNzp+/cmZLkywbdswripGKhUIE1hT1pc/hGnlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf9t2m6riBMquZ5Jaie58aF5MBu2lZPcqfz/76nFPBw9wMHpP6MFofwYx+6KdHZRt/ICtks46s8yGe+RDMARDobNwe7y3QtZqbo5Wta1dOpXOI8tWKlI6l8cshsdAPO59lcq8AASpFRE8feHvKFkHsZ6i/SVCF4pTTOFfPANF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KG0HojtA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KG0HojtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721404111; x=1752940111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CqmhVZNzp+/cmZLkywbdswripGKhUIE1hT1pc/hGnlc=;
  b=KG0HojtAag91Lw9u749+vPK5+WHxcaqj039OVUKukZTs65VE0uks9VHx
   mIrRAS4QJlOABWFdrmPXXxHH+uJkSO4Va6mOYMxXTTkdJ2AxExfhNdmOp
   fM+FBvhzovV1j+VD9dPTsD5MCT5Zom+WQhNot1a5WXLhtzxlfmTj5SEc2
   VWH/iegoduhsIT5t40GIUeXIND5CEXOYAT4eCtumGihTG88b/+Helg/pY
   Ea7eDC2Sds0fQ1obMDJH+YA1UgNfhYZ5IFrj1MQ8zcJhqsHOb1hv4a95B
   vvGP7K65nrNwuz5w6cuJL8yYzQQ2vn6i4Ts53WV8eTP2PbgsUPpNhBfdD
   A==;
X-CSE-ConnectionGUID: b6t8n3xgQKCRX77tDKC2kQ==
X-CSE-MsgGUID: 4Lu2V9UnR7uwWg9E4sjsIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18982750"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="18982750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:48:31 -0700
X-CSE-ConnectionGUID: w8xJ/4g0T8GFLH97YGMoaQ==
X-CSE-MsgGUID: Dfg63QHYTie9EQHD8XSMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51221606"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.46]) ([10.125.109.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:48:30 -0700
Message-ID: <daff158a-fe11-48a7-a13d-080950ebf54e@intel.com>
Date: Fri, 19 Jul 2024 08:48:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via
 fwctl
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <6182d104-808f-1edb-9ea2-387c7844dfc5@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6182d104-808f-1edb-9ea2-387c7844dfc5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/18/24 11:23 PM, Alejandro Lucero Palau wrote:
> 
> On 7/18/24 22:32, Dave Jiang wrote:
>> This series add support for CXL feature commands using the FWCTL framework [1].
>> The code is untested and I'm looking for architectural and implementation feedback.
>> While CXL currently has a chardev for user ioctls to send some mailbox
>> commands to a memory device, the fwctl framework provides more security policies
>> that can be a potential vehicle to move CXL ioctl path to that.
>>
>> For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
>> "Set Feature" commands are implemented. The "get" commands under the
>> FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
>> on the effect of the feature. All mailbox commands for CXL provides an effects
>> table that describes the effects of a command when performed on the device.
>> For CXL features, there is also an effects field that describes the effects
>> a feature write operation has on the device per feature. The security policy
>> is checked against this feature specific effects field. Looking for discussion
>> on matching the CXL spec defined effects with the FWCTL security policy.
>>
>> The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t
>>
>> ---
>>
>> Dave Jiang (13):
>>        cxl: Move mailbox related bits to the same context
>>        cxl: Fix comment regarding cxl_query_cmd() return data
>>        cxl: Refactor user ioctl command path from mds to mailbox
>>        cxl: Add Get Supported Features command for kernel usage
>>        cxl/test: Add Get Supported Features mailbox command support
>>        cxl: Add Get Feature command support
>>        cxl: Add Set Feature command support
>>        fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
>>        fwctl/cxl: Add support for get driver information
>>        fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
>>        fwctl/cxl: Add query commands software command for ->fw_rpc()
>>        cxl/test: Add Get Feature support to cxl_test
>>        cxl/test: Add Set Feature support to cxl_test
>>
>>   MAINTAINERS                  |   8 +
>>   drivers/cxl/core/core.h      |   9 +-
>>   drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>>   drivers/cxl/core/memdev.c    |  78 +++++---
>>   drivers/cxl/cxlmem.h         | 141 +++------------
>>   drivers/cxl/pci.c            |  68 ++++---
>>   drivers/cxl/pmem.c           |  10 +-
>>   drivers/cxl/security.c       |  18 +-
>>   drivers/fwctl/Kconfig        |   9 +
>>   drivers/fwctl/Makefile       |   1 +
>>   drivers/fwctl/cxl/Makefile   |   4 +
>>   drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
>>   include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
>>   include/uapi/fwctl/cxl.h     |  92 ++++++++++
>>   include/uapi/fwctl/fwctl.h   |   1 +
>>   include/uapi/linux/cxl_mem.h |   3 +
>>   tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
>>   17 files changed, 1515 insertions(+), 275 deletions(-)
>>
> 
> I can not see any documentation change in that file list.
> 
> I would say for something like what this patchset does, it is mandatory. Isn't it?

Yeah I will write some documentation to detail the new ioctl API. Thanks for the reminder. 
> 
