Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD46FBF
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877971; cv=none; b=PtHgpIAu4nMpsAwjL7/wE1SROD7XugoAB4aEUIsjL9M7+rr+lFK8Mg514GoJ7JPmsk0OEmDIaEgiTH5tX5SxRU3AjaElThg73vSaj4UJ+xfGvq1/3lotLvY/wgBj/YvAxiWWTATdkldKbrFGd9eGvVdVyW086VUlOaV+cZ0CZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877971; c=relaxed/simple;
	bh=HU/NFUI1wvbkTX4Ta9uKBDKFub65eyrEsQlyJ517oZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVAW+wPkaG8iIefEVOes6LvxMkxmnAhc/WTkPLtFFX0TDu1/WAQP0lO2gJ8Vz4scMY3N0AkIsFJ1NZOk/PVQYT+Jud8jorn1w3sSR8SKOCnOVxk9kBXdYIrbEt0cF1zAONY7i4+K1eMUnGmf0kWpR19Jgc1APSWvNa4RD9V0oYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSQT2Zat; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSQT2Zat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755877969; x=1787413969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HU/NFUI1wvbkTX4Ta9uKBDKFub65eyrEsQlyJ517oZo=;
  b=SSQT2ZatdKLUOi+PbVkmzWsATt9KhP7Ej8/nb9xe6w4rOEADkcgnvgAb
   njzj2XemB43K4DfHSlESNZWNEOPEhHySxQFsTubOYHPVzF0b26JkI7gGY
   aOumh2Z7FpFSn492rNLXRJgcmnp/XXr9VvPmCqru36acKBnkGAyD3IpBB
   sKGwRNSlw0MJZOtsZgnOjC+MX88uXzwoGs3jyI8mx5L0HrH6jKlazbw11
   YnDC0X2DMLp9eLd83opMLt3cEJ5Vu68OPccJBrJY+2Zya8PtFfObHBpSA
   5JJxZNoajctWphK9rVrDT11zUcFADf0cC6uhBknTxuk6PTGJqSZ9o0yeN
   w==;
X-CSE-ConnectionGUID: 3yll/4a5SH+nGeuiwGD0BQ==
X-CSE-MsgGUID: Lx1sUfwISXGzSlNUYj6yBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58284787"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58284787"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:52:49 -0700
X-CSE-ConnectionGUID: Nqy5+v2eQxWWhM4BpVwcGQ==
X-CSE-MsgGUID: JgNNgeFcSWyxLOJ5ssQG4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169100729"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.119.220]) ([10.247.119.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:52:44 -0700
Message-ID: <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
Date: Fri, 22 Aug 2025 08:52:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
 <aKg_gBw1Q29BaXdp@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKg_gBw1Q29BaXdp@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 2:59 AM, Robert Richter wrote:
> On 20.08.25 08:20:04, Dave Jiang wrote:
>> On 8/20/25 5:41 AM, Robert Richter wrote:
>>> Hi Dave,
>>>
>>> see my comments below.
>>>
>>> On 14.08.25 15:21:45, Dave Jiang wrote:
>>
>> <--snip-->
>>  
>>>> +	if (IS_ERR(new_dport))
>>>> +		return new_dport;
>>>> +
>>>> +	cxl_switch_parse_cdat(port);
>>>> +
>>>> +	/*
>>>> +	 * First instance of dport appearing, need to setup the port, including
>>>> +	 * allocating decoders.
>>>> +	 */
>>>> +	if (port->nr_dports == 1) {
>>>> +		rc = cxl_switch_port_setup(port);
>>>
>>> Can't this be done with port creation? I don't see a reason doing this
>>> late at this point.
>>
> 
>> The main reason we are doing this is to move the port register
>> probing until we know the CXL link is established. Otherwise when
>> cxl_acpi does probe and calls add_host_bridge_uport(), that
>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
>> PCI hotplug support on Intel platforms. The error messages "cxl
>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
>> header" is observed. Essentially we can be trying to map registers
>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
>> that got pushed out, so did the decoder enumeration.
> 
> The code suggests the Component Registers of the CXL Host Bridge are
> not yet ready. Is this delayed after the first Root Port is connected
> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
> the pcie config space, which is enumerated not before a CXL endpoint
> becomes active. I haven't found a spec refs here. Please explain.

So the behavior is observed when PCIe hotplug support is turned on in BIOS for the Intel platform. A CXL device is plugged in to a RP without CXL switches. The thinking is that the CXL link is not fully established at the time when cxl_acpi_probe() is running and the ports are being added. And the only way to 100% be sure the link is established is when we are enumerating the memdev just like the dports. Not sure what spec ref are you looking for. Table 8-2 indicates that those 2 DVSECs are mandatory for CXL root ports. Lack of presence means either the RP isn't CXL or the CXL link isn't established yet. I would assume this would also be true if a CXL memdev is hot-plugged into a slot post boot.   

> 
> Thanks,
> 
> -Robert

