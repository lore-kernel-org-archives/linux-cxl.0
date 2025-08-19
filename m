Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4224502C
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618072; cv=none; b=SxPJCKqKrOaaKRos8V1bDLhQlZ9lNP8cHIrRsxhDtlB+DSPBshDpg3VreP6D/oP2jXc5L6UX2a8Hn1XzETZNWA8DdRx1YIfQf2G+dCkE7NWj7Esf4WpXymJpyd/OyL0dXyiZZ+iEZ1mvuVd6536GXgQVcc0yDlWKLK2BCRGn7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618072; c=relaxed/simple;
	bh=DC3eNvp2rKZWTVF1ewOnHK68s4y+4FSN84eNj0vIHsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1K5D8dw22lXv7eQqtqQ50CPIzlH9+TTS0LUH7DsZ68Lc01RbaGjrkqSSpMMimyFj7H7tJeMm/6LFY1lVsTiM4BEFu3lrZV0ByGpBwxyGME1w0jYsDtDISAb0A90eGLyJOx9cR1Q7bZ0IRRtqpvP1Zc9nl6pXWcoC9mzycjb5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhmzGFky; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhmzGFky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755618071; x=1787154071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DC3eNvp2rKZWTVF1ewOnHK68s4y+4FSN84eNj0vIHsw=;
  b=RhmzGFkyCyPdSneoIYO1Z033C+poEUPX3iB9FyrGkHElk/k9r4F01QHl
   Rog7Szawalgg9TnzDx8KV4dSYuxSZghLBzlXn7AW6vMDAc13I6JED9v8y
   2u/2wK1bXZ5PoCTq4TeqoMD3FS138RVLf2TWz0d/kOkktK1R/Ly/bY8EI
   u3wJyKOK2YXRr9ltZEcUdSQO1fehfQ4USKjuvg9bP25y0+VFaMAcbW4U1
   crTSR5dFvo8pDZ/AyCyhyLiiI/63jmiv8oEnjx5FtRMqX8CrmSW7YGj7G
   7FLbktaQXT/K60LMyrHNDmjnVsuaeH+kPuFwF+5CbNZcEXDkycW9M3iqa
   Q==;
X-CSE-ConnectionGUID: 426NdlNJQ6mHXKhP0zHILA==
X-CSE-MsgGUID: QUoEKBMzTN+ouMJTHTG9mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68964523"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68964523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:41:10 -0700
X-CSE-ConnectionGUID: cgp3+647Tk+piTMzYMFQSg==
X-CSE-MsgGUID: Cdzbn1XiQWy+Hp7pgSeR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173122186"
Received: from unknown (HELO [10.247.119.200]) ([10.247.119.200])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:41:05 -0700
Message-ID: <5d47fec5-3ffa-484b-9820-43f392d84580@intel.com>
Date: Tue, 19 Aug 2025 08:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] cxl: Delay HB port and switch dport probing
 until endpoint dev probe
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Gregory Price <gourry@gourry.net>, Li Ming <ming.li@zohomail.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <aKRGZixtY5AxDUU6@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKRGZixtY5AxDUU6@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 2:39 AM, Robert Richter wrote:
> Dave,
> 
> On 14.08.25 15:21:40, Dave Jiang wrote:
>> v8:
>> - A bit of changes from Dan and Robert's comments. Main change is moving the port MMIO
>>   register probing to after the first dport shows up. This resulted with decoder allocation
>>   happens after the register probe.
>> - See specific commits for more detailed changes.
> 
> thank you for your rework.
> 
>> Dave Jiang (11):
>>   cxl: Add helper to detect top of CXL device topology
>>   cxl: Add helper to reap dport
>>   cxl: Add a cached copy of target_map to cxl_decoder
>>   cxl: Move port register setup to first dport appear
>>   cxl: Defer dport allocation for switch ports
>>   cxl/test: Add cxl_test support for cxl_port_get_possible_dports()
>>   cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
>>   cxl/test: Add support to cxl_test for decoder enumeration mock
>>     functions
>>   cxl/test: Setup target_map for cxl_test decoder initialization
>>   cxl: Change sslbis handler to only handle single dport
>>   tools/testing/cxl: Add decoder save/restore support
> 
> I have tested the whole series and it also solves the non-unique port
> id errors for offline dports we see like:
> 
>  cxl_port port2: unable to add dport247-0000:00:01.3 non-unique port id (0000:00:01.1)
> 
> For the whole series you can add:
> 
> Tested-by: Robert Richter <rrichter@amd.com>

Thank you for testing Robert!
> 
> Thanks,
> 
> -Robert
> 
>>
>>  drivers/cxl/acpi.c                   |   7 +-
>>  drivers/cxl/core/cdat.c              |  25 +-
>>  drivers/cxl/core/core.h              |   2 +
>>  drivers/cxl/core/hdm.c               |  51 ++--
>>  drivers/cxl/core/pci.c               |  82 ++++++
>>  drivers/cxl/core/port.c              | 358 ++++++++++++++++++------
>>  drivers/cxl/core/region.c            |   4 +-
>>  drivers/cxl/cxl.h                    |  44 ++-
>>  drivers/cxl/port.c                   |  29 +-
>>  tools/testing/cxl/Kbuild             |   5 +-
>>  tools/testing/cxl/cxl_core_exports.c |  42 +++
>>  tools/testing/cxl/exports.h          |  21 ++
>>  tools/testing/cxl/test/cxl.c         | 399 ++++++++++++++++++++++++++-
>>  tools/testing/cxl/test/mock.c        |  70 ++++-
>>  tools/testing/cxl/test/mock.h        |   3 +
>>  15 files changed, 963 insertions(+), 179 deletions(-)
>>  create mode 100644 tools/testing/cxl/exports.h
>>
>>
>> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
>> -- 
>> 2.50.1
>>

