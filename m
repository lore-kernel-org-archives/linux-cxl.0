Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6613BC0D
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212529; cv=none; b=ddCWcHJom+Q2HB5q8dpVSUq/adnMS1BnGXdM0+No//xIWO4nw7FWEeaL9QyIbgT1kw/0UdW0fB3U9mtuY71UP5YX+SJoIGXYCbn1pa9kVGqy3C8seqS6HLAUSwiruu5C0Ndw4dNHKga4trQQ2ga3iuWsr8FjAMTs33beV/ObF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212529; c=relaxed/simple;
	bh=W8Tzmlq9CmcnXK+bmuXjPun6NCxuVwgRhPmvgD4rwlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbMTcoE//H2BUP/DF+RLnaYgbqx6gvu70BoOI/ge6KtKD6KZAL6tPAb9i6ymMiMUG42c0qIWr2SM7DQZkJtFoRefbXquO6jyvj4XnpSw60n7tvVWJoduC8OGpWXDjE6IOINDbe2b8d1F5q5sr0x+Ve16qfLplvgX9pRUhmHr/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNH7JX9I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNH7JX9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732212527; x=1763748527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W8Tzmlq9CmcnXK+bmuXjPun6NCxuVwgRhPmvgD4rwlY=;
  b=lNH7JX9IKdU8krdc3/5yeG0wXX+UaTKgTaZYZvPX0bOaNaTDuVs6pXqO
   rRJVMM/bcefUAJQpByDakZQYApm292nSjrbhF/E6/egxo1kMCZ2bsh9CJ
   LdYCay29Re8S+Ewy5KFN+u/SVrYidcK+d6LKisiSsvdv3g6CyRpSN52mu
   QAjF7QPdnfAIDNjrnvNBttXo5LyrshgH2ChTOX7TkOuLDdnJyApflv7Vk
   Zk7O9VDTnTFg6VcYOlyO18osGQ89mxUrKvg9nHL3Tc8guhNb9IzRo2mbe
   zh4H4+VBVDiWJgJfhMRXPcKWKS9F6iLN8ChtsuWo+dlj/TdN+KGHrZqQA
   w==;
X-CSE-ConnectionGUID: Gp4WHSo7RyWVIKJd7DVLTw==
X-CSE-MsgGUID: +Jrk/GVQSluA+y5BipmcKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43408516"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43408516"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 10:08:47 -0800
X-CSE-ConnectionGUID: fS0WwCoWSJeC2Wbs/rxl3Q==
X-CSE-MsgGUID: PHjcPvP+RzqWuJMmwkSK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90135365"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.245]) ([10.125.109.245])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 10:08:46 -0800
Message-ID: <9e3afbf8-80dd-480b-9735-ce8dcf8bbc75@intel.com>
Date: Thu, 21 Nov 2024 11:08:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/20] cxl: Add Set Feature command support for
 user submission
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-8-dave.jiang@intel.com>
 <20241121174935.00003e2b@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241121174935.00003e2b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/24 10:49 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:25:40 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add enumeration of Set Feature mailbox command for the kernel to recognize
>> the command being passed in from user space.
> 
> This looks unwise to make available on the ioctl. 

Do you mean the current memdev char dev ioctl? Maybe we can introduce a restricted_commands mask to block that on the legacy ioctl? Trying to make the two ioctl paths co-exist is a bit of a pain right now.

DJ
 
> 
>>
>> CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
>>
>> The feature requested is identified by specific UUID.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/mbox.c      | 1 +
>>  include/uapi/linux/cxl_mem.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 4b9abf9a5b2b..739444d34130 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -69,6 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>>  	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>>  	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
>> +	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
>>  };
>>  
>>  /*
>> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>> index 90dcb9723997..469dd481795f 100644
>> --- a/include/uapi/linux/cxl_mem.h
>> +++ b/include/uapi/linux/cxl_mem.h
>> @@ -52,6 +52,7 @@
>>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>>  	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>>  	___C(GET_FEATURE, "Get Feature"),				  \
>> +	___C(SET_FEATURE, "Set Feature"),				  \
>>  	___C(MAX, "invalid / last command")
>>  
>>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 

