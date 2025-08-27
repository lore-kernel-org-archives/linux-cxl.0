Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA418227B9F
	for <linux-cxl@vger.kernel.org>; Wed, 27 Aug 2025 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314317; cv=none; b=IqsAod8sx4HfVTeucV96nVN+dcbj1ZS7o0wPqfaZm44iRiiuwVj6y2OzgFepP73m4p9g2WcmqnQv61VS8jFAmD910ERre2y7ZBSRnMP2JcLQoY8gCTI870uBdFGpYnw4r8LQvaM7tTh/k2BgoZ69NanXfNBdqpezcdDQf798fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314317; c=relaxed/simple;
	bh=Bc7T/MH7IAqWc3ZTKb4uL6YjphJHj8oUk3QaZ88dUW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD6PmMkbYc59M32zGdIdyvbT8hGyi7QiTUtWzDB9J31JILTpjEOA6KQw39dmo1R+1iRFoulZNpautl43GQxdVU2XaulndIZpRoPxuybzKKUBaKzpW4sJgIeuQjtdnNeI5ydFDbBLkgWacQSv6SBlYpYzVHRoPAUDyEdRmrLMUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2gWfXO0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2gWfXO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756314315; x=1787850315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bc7T/MH7IAqWc3ZTKb4uL6YjphJHj8oUk3QaZ88dUW0=;
  b=H2gWfXO0iQj1643sZHX47UTcIA2Y8Xy9sQj4qv7r0zrRj0q54bGQBPGj
   D/WzM2c+Dk371NOpZP40x+9hNBGZN5v0CAFAxfS9dzjesYPrtGs9bOC+C
   QK75fFwqhtITlNx84/2kK2b+z99+ML9krHV5+WEM6milWarVOLM6aCOO/
   lbMdjT3/bZ90CYbm6xYe3/fGTy9v74/nkCBttWFmmILY6QisLnCM9sqpU
   5tkobrHNfIO4ZpUOBxhq1JaarvnnUs7JUgDbFys9s/J+qsRmHfM6UtNBU
   BO+u7clp37xHzLXXDrTz+aNNLqt18uNe1iM6qndLkqb2rU5DyCqSPPmuz
   A==;
X-CSE-ConnectionGUID: lF1LXVidQfqOFkCeQBqIKA==
X-CSE-MsgGUID: 6KSD2T7xS4OEw/lgKpSDsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="83979200"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="83979200"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 10:05:15 -0700
X-CSE-ConnectionGUID: q2yb+aNuT4avQ5T0lvBbQw==
X-CSE-MsgGUID: /szqUrnNTu+zTin3YRCOiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169819749"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.23]) ([10.247.118.23])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 10:05:10 -0700
Message-ID: <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
Date: Wed, 27 Aug 2025 10:05:05 -0700
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
 <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
 <aK1niOntTRwwZhhv@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aK1niOntTRwwZhhv@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 12:51 AM, Robert Richter wrote:
> On 22.08.25 08:52:39, Dave Jiang wrote:
>>
>>
>> On 8/22/25 2:59 AM, Robert Richter wrote:
>>> On 20.08.25 08:20:04, Dave Jiang wrote:
>>>> On 8/20/25 5:41 AM, Robert Richter wrote:
>>>>> Hi Dave,
>>>>>
>>>>> see my comments below.
>>>>>
>>>>> On 14.08.25 15:21:45, Dave Jiang wrote:
>>>>
>>>> <--snip-->
>>>>  
>>>>>> +	if (IS_ERR(new_dport))
>>>>>> +		return new_dport;
>>>>>> +
>>>>>> +	cxl_switch_parse_cdat(port);
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * First instance of dport appearing, need to setup the port, including
>>>>>> +	 * allocating decoders.
>>>>>> +	 */
>>>>>> +	if (port->nr_dports == 1) {
>>>>>> +		rc = cxl_switch_port_setup(port);
>>>>>
>>>>> Can't this be done with port creation? I don't see a reason doing this
>>>>> late at this point.
>>>>
>>>
>>>> The main reason we are doing this is to move the port register
>>>> probing until we know the CXL link is established. Otherwise when
>>>> cxl_acpi does probe and calls add_host_bridge_uport(), that
>>>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
>>>> PCI hotplug support on Intel platforms. The error messages "cxl
>>>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
>>>> header" is observed. Essentially we can be trying to map registers
>>>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
>>>> that got pushed out, so did the decoder enumeration.
>>>
>>> The code suggests the Component Registers of the CXL Host Bridge are
>>> not yet ready. Is this delayed after the first Root Port is connected
>>> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
>>> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
>>> the pcie config space, which is enumerated not before a CXL endpoint
>>> becomes active. I haven't found a spec refs here. Please explain.
>>
> 
>> So the behavior is observed when PCIe hotplug support is turned on
>> in BIOS for the Intel platform. A CXL device is plugged in to a RP
>> without CXL switches. The thinking is that the CXL link is not fully
>> established at the time when cxl_acpi_probe() is running and the
>> ports are being added. And the only way to 100% be sure the link is
>> established is when we are enumerating the memdev just like the
>> dports. Not sure what spec ref are you looking for. Table 8-2
>> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
>> of presence means either the RP isn't CXL or the CXL link isn't
>> established yet. I would assume this would also be true if a CXL
>> memdev is hot-plugged into a slot post boot.
> 
> But add_host_bridge_uport() only creates ports for the host bridge
> (ACPI0016) devices and enumerates their component registers (CHBCR).

And I think that's where the issue is. The component registers via CHBCR isn't there. When I removed this change, this is the signature I get:

[ 37.423882] cxl_acpi:cxl_get_chbs:589: acpi ACPI0016:03: UID found: 35  
[ 37.424180] cxl_acpi:add_host_bridge_uport:726: acpi ACPI0016:03: CHBCR found for UID 35: 0x00000  
000aabf0000  
[ 37.424186] cxl_core:cxl_port_alloc:741: pci0000:3a: host-bridge: pci0000:3a  
[ 37.424210] cxl_core:cxl_map_regblock:426: cxl port2: Mapped CXL Memory Device resource 0x0000000  
0aabf0000  
[ 37.424213] cxl_core:cxl_probe_component_regs:55: cxl port2: Couldn't locate the CXL.cache and CXL.mem capability array header.

DJ

> The root ports are being added already late as those are part of the
> pci hierarchy. The root ports are discovered in
> devm_cxl_enumerate_ports() not earlier than the mem_dev is probed.
> devm_cxl_add_memdev() is called once the endpoint is probed and the
> CXL link is up.
> 
> That is, function cxl_port_get_or_add_dport() in add_port_attach_ep
> should only add the dport. Then, a retry in the enumeration loop will
> be triggered and the cxl_port for the root port is added. No explicit
> call of cxl_switch_port_setup() should be needed, it can be done
> during cxl_port_probe(). All done late after the endpoint was found.
> 
> -Robert

