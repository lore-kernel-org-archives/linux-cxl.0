Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B81EA7E9
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320483; cv=none; b=vFaLq5C/6RyPN5MyNv7zhZyrABYXlDTs4dt1nuu6gWQQ9r/vtrrRF7431lYvGsRNVk2XQInPwcamvMN+KTle2QuhYny/PqzvPnx18jfOOAq8YvP/qb2YO+jKGdQkBhS+E0tugvGRSstNrCrSU2deIayHIEDfqzTheKgrbEYPd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320483; c=relaxed/simple;
	bh=D42tfT8HOOsysn1EVRbfDvIW5ZY6PaoeHscl9kLqjDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCMmdXxNglXqTCdIQbSycPPVLfOTSekQrLRSd6qJajeSnd+kMk7nmGXUH1x4GBaoqp3Y8rBDJxAu5Zp2LoxM1ePX0iD9NuESPHjq/Az7J2qq/1ZT6BQSfF75rMJNwAJkOklUybvrWsjBgoj4dm7N4cYm0T8GuXX6QtfOZWeRuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+S9cuFr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+S9cuFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754320482; x=1785856482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D42tfT8HOOsysn1EVRbfDvIW5ZY6PaoeHscl9kLqjDQ=;
  b=k+S9cuFrXtowKzfHjsW/I+RKy6N2VLU2sf2benQHrUvf1b34asQsxg93
   iiRGhT3j7kyzPGSVvsI1rU7ptwOHTSjKEESoEaaLadxBMDES5NFkGxSU0
   lazkZfeWJ4K02L8YANRhH929yBcxIayms3z4fuIx8SYm12autFzLluOSR
   EPFDGHVndrjcliQb59+0E8BqY8mmoSK0uMt+XAfR+qb1MkYNcF9HAq+ef
   tNu65A0Ru91uogO4OvZ6M5jsKp7b38D5RQY4YJcgIRa4I3pt0BXL6KX/H
   1j5W6IIrrhJLoGLo9wjCkYVhqgm3AQUydo1se3yoG9QX/p8/4czr8pjjT
   g==;
X-CSE-ConnectionGUID: l0f3Lc7lSIawLfiYu3mfAQ==
X-CSE-MsgGUID: Lm6t/+MmR3KfZ0bGd7sNVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="67654159"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67654159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 08:14:42 -0700
X-CSE-ConnectionGUID: 0xBWRxywQI+o3la0tuk9BA==
X-CSE-MsgGUID: /Os2sGgEQTqM59q2Z8/6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168392947"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.66]) ([10.247.119.66])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 08:14:35 -0700
Message-ID: <29af4cc2-6a7d-4960-ac30-eb41238ad478@intel.com>
Date: Mon, 4 Aug 2025 08:14:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
 <3be496e0-a651-4dfe-b3d7-01df30350893@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3be496e0-a651-4dfe-b3d7-01df30350893@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 8:04 AM, Bowman, Terry wrote:
> On 7/30/2025 10:25 AM, Dave Jiang wrote:
>> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
>> the config. The config will depend on CPER or PCIE AER to build.
>> Move the related RAS code from core/pci.c to core/ras.c.
>>
>> Cc: Robert Richter <rrichter@amd.com>
>> Cc: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Make cxl_handle_rdport_errors() static. (Dan)
>> ---
>>  drivers/cxl/Kconfig       |   4 +
>>  drivers/cxl/core/Makefile |   2 +-
>>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |   8 -
>>  drivers/cxl/cxlpci.h      |  16 ++
>>  tools/testing/cxl/Kbuild  |   1 +
>>  7 files changed, 334 insertions(+), 328 deletions(-)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 48b7314afdb8..b36bb0cabe58 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -233,4 +233,8 @@ config CXL_MCE
>>  	def_bool y
>>  	depends on X86_MCE && MEMORY_FAILURE
>>  
>> +config CXL_RAS
>> +	def_bool y
>> +	depends on ACPI_APEI_GHES || PCIEAER_CXL
>> +
>>  endif
> 
> Hi Dave,
> 
> Can PCIEAER_CXL and CXL_RAS be combined or must they remain separate?
> They both enable CXL specific AER and RAS handling.

I don't have any objections. CXL_RAS will just depends on PCIEAER with the merge.

Thoughts Jonathan and Dan?

> 
> -Terry
> 

