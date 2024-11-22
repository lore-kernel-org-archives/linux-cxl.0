Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A91DE2BD
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306476; cv=none; b=IHddjvNBIoZ2eC2YIdI3PM3eYL30SSuTeq8sfPvPp0/4YTnXSdrQSmBAlsbwKKVVEU/1dknjR5ZFBH/eRD4bFxLhG/v/H2cN19xA7xwwsez8gtjIoyGgcVr8XIGGIr7M/0j5LRK5B2bfiXDQwWkI1GyOhCfcG2bzWdGPp0Rt7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306476; c=relaxed/simple;
	bh=w7oNgnGkjUVT8GGjwL0QR+rs8MlieWWuuM9mx4FWY4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMI+D4q/Ob3k7EcjS7Z5+wa2P7Syfn7dsrOUdFjWpAwA9PCiYMMtu8hBURlRPEHkGB6RbBiWrRwHQFcTtUWpZR4ZjzDAkD/WOS90ZX9aLso8/1D1zlEhG5n7fvTCkhcn+agTFMueE8N3R/StE1PaEuN94MC6dPITuBWa8EWN7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym2dfDBx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym2dfDBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732306475; x=1763842475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w7oNgnGkjUVT8GGjwL0QR+rs8MlieWWuuM9mx4FWY4E=;
  b=Ym2dfDBxg9pYrXttQogsK1mHkv7nO8Lu+1LwVLnJRutgiZnrksX3voFS
   3hUFHX/K7UlP86gb2+u4BljM/Xk1SLOOYwWedY89GnaIcQLAUMc8j+AT5
   eD4cwYEHpoBMO4SLghcfay5yu3gzKPpl7+WSARWvhteFC3vfh17G7SsYt
   grwPMVm05NltuiPl9qap+zgNDF7ETz4o3U9uw5QddGUqu8j0/eiOGEtek
   9I3VqYy6lkD4FsJrtzK7g9y7JPByhyr5IKKvHs2k6zxJKLrfZPoGnk8mb
   +GX5lscCDBwsP9hltmG6Z1MWbWPImDC1gX9EfIVpgbPaDryhlnLxDeyzJ
   Q==;
X-CSE-ConnectionGUID: Cvt+aH1NQpyxsxRjZBH2aQ==
X-CSE-MsgGUID: alByLN1ERfu53fgqH+TeVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49895132"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="49895132"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 12:14:35 -0800
X-CSE-ConnectionGUID: 5pkuEy5SQQCsqjzIRLVMjw==
X-CSE-MsgGUID: mf1IFlV5Q6O/Bvsnq9xFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90660534"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.70]) ([10.125.110.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 12:14:34 -0800
Message-ID: <e461c96c-340e-47b5-9eb0-db2125ed01e2@intel.com>
Date: Fri, 22 Nov 2024 13:14:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for
 user submission
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, Shiju Jose <shiju.jose@huawei.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-6-dave.jiang@intel.com>
 <20241121174748.000046ce@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241121174748.000046ce@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/24 10:47 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:25:38 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add enumeration of Get Feature mailbox command for the kernel to recognize
>> the command being passed in from user space.
>>
>> CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
>>
>> The feature requested is identified by specific UUID.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hmm. Should we push this into Shiju's series if thought is that will land
> first?  Seems harmless but I find it hard to care that much ;)

Yes if Shiju can fold this into his get feature patch that'd be great.

At some point we should stabilize the common patches between the two series and get that committed to cxl/next.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c      | 1 +
>>  include/uapi/linux/cxl_mem.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index f70bd7d28ff8..f49665d3b4d6 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>>  	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>> +	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
>>  };
>>  
>>  /*
>> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>> index bd2535962f70..90dcb9723997 100644
>> --- a/include/uapi/linux/cxl_mem.h
>> +++ b/include/uapi/linux/cxl_mem.h
>> @@ -51,6 +51,7 @@
>>  	___C(CLEAR_LOG, "Clear Log"),					  \
>>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>>  	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>> +	___C(GET_FEATURE, "Get Feature"),				  \
>>  	___C(MAX, "invalid / last command")
>>  
>>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 

