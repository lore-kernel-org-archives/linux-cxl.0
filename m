Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3126290
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958921; cv=none; b=dbMCm3ZZSwKTCHeeHm8vuQ9zMxqVyNmccPTEzVsJc7132l/lvOCuR6eykUrdVYWzwCqcfXBbVjuhwMQs6kOwHucuyazRGnbmxyTkweeQOUPw+/4j1yeAijAraI2+aaIOM0qfK1Vo/6hPCFm7IicZz+hUGfiJuur93Cf71p/ncnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958921; c=relaxed/simple;
	bh=VxxLLwSWDKAZh0hknqXTuaSbAr304ysMILQWluEnEDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xyngl1i5GSuLz6YRq27SIOTQbtsgwem4rh6d4jUmJFG4Pc34GfdX/nc0LBSRaLEUwcc7K9L+v0XKUwfe8+6HxEwstXAYBg+WmORLdFy0BGXnu72sRlr1k5IjBTqNGbj3DbVtKMjHu6d2wYkDCkOltFmbiKunSrrSnCwsTnledyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQUTCd8z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQUTCd8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748958920; x=1780494920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VxxLLwSWDKAZh0hknqXTuaSbAr304ysMILQWluEnEDw=;
  b=ZQUTCd8z5pp0kQhPKl8xjjoRg8xVX3zjjomtIU1jFhzu4bJUOp+ZUOUx
   2ZifUraQZAwKz8sqTFk1j1tvH38T+m3MCWxwXxwkduAUHw3G/4VWiCAT1
   LHNO2yfOhSy5IcSo0wCPMGXduOtDwv8nEPinW6scjI1fbSiNomtj7t78d
   x1HTqiUZIejJaEruEGS8DpHMg96n7YNbNUj9uhkuITGJbKRMtA7grc5Ih
   rDWu4b0DllOti2+TFxZ1xt2JEmAuAniX3M75Elf1TCxK2RdWp5pmSbm+m
   PG60rGZkvFL53SkEpzSpxIu/FO0K3uy4yDeEIqWr/hGbI7h1vSb8VD6ua
   w==;
X-CSE-ConnectionGUID: fpElRKCAS22sX6ui3m4EOg==
X-CSE-MsgGUID: /tcU58uUShiTs5Z8Fb4GAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50916360"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50916360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:55:17 -0700
X-CSE-ConnectionGUID: ZxiYWW1HS1GCi4NdJhU3NA==
X-CSE-MsgGUID: OnLjcS/aTJGNsIqkfQoTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145835497"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:55:16 -0700
Message-ID: <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
Date: Tue, 3 Jun 2025 06:55:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>,
 Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
 Li Ming <ming.li@zohomail.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aDm3zR2LkC3joLFL@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/25 6:51 AM, Robert Richter wrote:
> Dave,
> 
> thanks for your series.
> 
> On 21.05.25 11:34:34, Dave Jiang wrote:
>> v3:
>> - Main changes revolve around improving naming of hostbridge uport and dport (Gregory)
>> - See specific patches for detailed change log
>>
>> This series attempts to delay the setup of dports and Host Bridge (HB) register
>> until when the endpoint device (memdev) is being probed. At this point,
>> the CXL link is established and all the devices along the CXL link path up to
>> the Root Port (RP) should be active.
>>
>> And hopefully this help a bit with Robert's issue raised in the "Inactive
>> downstream port handling" series [1]. Testing would be appreicated. Thank you!
>>
>> [1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> Dave Jiang (9):
>>   cxl/region: Add decoder check to check_commit_order()
>>   cxl: Add helper to detect top of CXL device topology
>>   cxl: Separate out CXL dport->id vs actual dport hardware id
>>   cxl: Remove adding of port_num via devm_cxl_add_dport()
>>   cxl: Defer hardware dport->port_id assignment and registers probing
>>   cxl/test: Add workaround for cxl_test for cxl_core calling mocked
>>     functions
>>   cxl: Change sslbis handler to only handle single dport
>>   cxl: Create an xarray to tie a host bridge to the cxl_root
>>   cxl: Move enumeration of hostbridge ports to the memdev probe path
> 
> I have tested your series and this solves the enumeration issue with
> ports where the link of its downstream ports is down and that have
> duplicate port ids. For the whole series you can add:
> 
> Tested-by: Robert Richter <rrichter@amd.com>
> 
> However, some observations:
> 
> The port_num can no longer retrieved using sysfs. Previously, the X in
> dportX could be used to identify the port number (former port_id)
> which was identical to the numbers in the sysfs target_list entries.
> This is esp. useful to reconstruct the decoder tree and map pci child
> devices and its decoders to a parent decoder including its positions
> in the target list. Maybe create a targetX symlink from the decoder
> device to the child decoders of it?

The numbers in the target_list are dport->id and should reflect the dportX. Is this not what you are seeing?

> 
> Due to the different initialization order there is an odd port
> numbering now showing up with unexpected, out-of-order sequence
> numbers, e.g.:
> 
> /sys/bus/cxl/devices/port1/endpoint2
> /sys/bus/cxl/devices/port1/endpoint3
> /sys/bus/cxl/devices/port1/endpoint6
> /sys/bus/cxl/devices/port4/endpoint5
> /sys/bus/cxl/devices/port4/endpoint7
> /sys/bus/cxl/devices/port4/endpoint10
> /sys/bus/cxl/devices/port4/endpoint11
> /sys/bus/cxl/devices/port8/endpoint9
> /sys/bus/cxl/devices/port12/endpoint13
> /sys/bus/cxl/devices/port12/endpoint14
> 
> Still, this is correct, but maybe we could force a specific order
> during initialization, such as per-port initialization which should
> result in a defined order? Note the shared numbering of ports and
> endpoints is also confusing, maybe that could be changed here too?

I think the upstream expectation WRT sysfs device number enumeration (for all Linux kernel devices) is that no ordering should be expected as the devices are initialized async. And previous ordering appearance is merely coincidence and not the expectation. And the expectation for user tools is that they should not depend on device numbering order and identify the devices by other stable means.  

> 
> Going to review your patches.

Thank you!
> 
> Thanks for your patches.
> 
> -Robert

