Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6663090DB
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488230; cv=none; b=iawxynXwVU8sp8h3jDYIt4KmpzgUhIwM9L+5NoDVCIo6Wi4IFFgqM0G2Gov0cpPtCIWmAKx4VRrz+KpTv6uZ31LB2nrQzx0W0aiHVSgeWjNAplRMzR/DR9t58fCi7QPZEIROpMyDQdjzv0ciCLAEuxr1D/+wM0qYjbzYKDrtPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488230; c=relaxed/simple;
	bh=PMmbhayhM/No99xTJ2tNUabf2MDu6olcj+8yT1RYeu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCxmvqwQwJS1KxMj4ign4HjvJGFu9+2B6OO9O6hfwcNrd+HZYVhmy9xvaXL/USxpSzj7B3Cpk5MYX4X8+/jqwlfCHvSlCbkK8IOWM++niNOTRnKk5WjuKSeCrMcaUDJN2YjOMZ5tu+RV+i+PS5DQCSJv+CDjZbbyWVHQ91NcQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQlLVfqL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQlLVfqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756488229; x=1788024229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PMmbhayhM/No99xTJ2tNUabf2MDu6olcj+8yT1RYeu0=;
  b=DQlLVfqLbDoXHSpvuSm986dP/5xc06htk598/HpPAtGxuQEB2yd/DWTf
   V+QQxGNbR1Tdi8bOWoGVAwO4W7obnb3Yu0bG1AGXmfYBR5rueV+/mBaxE
   714YUSVi8VINjO6Bzjy8o6nXWi0ojR+aG3Rrzq/5KXjxMfuAS0eP7mNbg
   VnphOB6/4IH1aOMh6JHKnt/4X5CE4XmtZfxIzaPMUljTNzjwxB6PFxuao
   jiaAVmnwLWZe9COsx0OY+jLsASY+9n/Gw5oFB3NiDZU6fXMvXEeKWTvgD
   wkY9Psvvfw/5p45HnwMidPItgSR2MudpUH49AxsS8BfSz+WPX0a7f+suZ
   Q==;
X-CSE-ConnectionGUID: 3E7/Qd/VSFqK8dVZcAlDbA==
X-CSE-MsgGUID: 0k6Ic7gMTSe2S/FGxNf94w==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="57805271"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="57805271"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:23:48 -0700
X-CSE-ConnectionGUID: +Tr6XYAzSimnh13MAuJ7hg==
X-CSE-MsgGUID: u3o877xZTuGUvnGpqmMnGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175726711"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.59]) ([10.247.118.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:23:43 -0700
Message-ID: <2f52ad40-7e85-4466-8d42-190c846fd37c@intel.com>
Date: Fri, 29 Aug 2025 10:23:38 -0700
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
 <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
 <aLHBG5j8rVYhi9cg@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aLHBG5j8rVYhi9cg@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 8:02 AM, Robert Richter wrote:
> On 27.08.25 10:05:05, Dave Jiang wrote:
>>
>>
>> On 8/26/25 12:51 AM, Robert Richter wrote:
>>> On 22.08.25 08:52:39, Dave Jiang wrote:
>>>>
>>>>
>>>> On 8/22/25 2:59 AM, Robert Richter wrote:
>>>>> On 20.08.25 08:20:04, Dave Jiang wrote:
>>>>>> On 8/20/25 5:41 AM, Robert Richter wrote:
>>>>>>> Hi Dave,
>>>>>>>
>>>>>>> see my comments below.
>>>>>>>
>>>>>>> On 14.08.25 15:21:45, Dave Jiang wrote:
>>>>>>
>>>>>> <--snip-->
>>>>>>  
>>>>>>>> +	if (IS_ERR(new_dport))
>>>>>>>> +		return new_dport;
>>>>>>>> +
>>>>>>>> +	cxl_switch_parse_cdat(port);
>>>>>>>> +
>>>>>>>> +	/*
>>>>>>>> +	 * First instance of dport appearing, need to setup the port, including
>>>>>>>> +	 * allocating decoders.
>>>>>>>> +	 */
>>>>>>>> +	if (port->nr_dports == 1) {
>>>>>>>> +		rc = cxl_switch_port_setup(port);
>>>>>>>
>>>>>>> Can't this be done with port creation? I don't see a reason doing this
>>>>>>> late at this point.
>>>>>>
>>>>>
>>>>>> The main reason we are doing this is to move the port register
>>>>>> probing until we know the CXL link is established. Otherwise when
>>>>>> cxl_acpi does probe and calls add_host_bridge_uport(), that
>>>>>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
>>>>>> PCI hotplug support on Intel platforms. The error messages "cxl
>>>>>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
>>>>>> header" is observed. Essentially we can be trying to map registers
>>>>>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
>>>>>> that got pushed out, so did the decoder enumeration.
>>>>>
>>>>> The code suggests the Component Registers of the CXL Host Bridge are
>>>>> not yet ready. Is this delayed after the first Root Port is connected
>>>>> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
>>>>> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
>>>>> the pcie config space, which is enumerated not before a CXL endpoint
>>>>> becomes active. I haven't found a spec refs here. Please explain.
>>>>
>>>
>>>> So the behavior is observed when PCIe hotplug support is turned on
>>>> in BIOS for the Intel platform. A CXL device is plugged in to a RP
>>>> without CXL switches. The thinking is that the CXL link is not fully
>>>> established at the time when cxl_acpi_probe() is running and the
>>>> ports are being added. And the only way to 100% be sure the link is
>>>> established is when we are enumerating the memdev just like the
>>>> dports. Not sure what spec ref are you looking for. Table 8-2
>>>> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
>>>> of presence means either the RP isn't CXL or the CXL link isn't
>>>> established yet. I would assume this would also be true if a CXL
>>>> memdev is hot-plugged into a slot post boot.
>>>
>>> But add_host_bridge_uport() only creates ports for the host bridge
>>> (ACPI0016) devices and enumerates their component registers (CHBCR).
>>
>> And I think that's where the issue is. The component registers via CHBCR isn't there. When I removed this change, this is the signature I get:
>>
>> [ 37.423882] cxl_acpi:cxl_get_chbs:589: acpi ACPI0016:03: UID found: 35  
>> [ 37.424180] cxl_acpi:add_host_bridge_uport:726: acpi ACPI0016:03: CHBCR found for UID 35: 0x00000  
>> 000aabf0000  
>> [ 37.424186] cxl_core:cxl_port_alloc:741: pci0000:3a: host-bridge: pci0000:3a  
>> [ 37.424210] cxl_core:cxl_map_regblock:426: cxl port2: Mapped CXL Memory Device resource 0x0000000  
>> 0aabf0000  
>> [ 37.424213] cxl_core:cxl_probe_component_regs:55: cxl port2: Couldn't locate the CXL.cache and CXL.mem capability array header.
> 
> Hmm, hot-added Host Bridges (and I would count this case to those)
> should use the ACPI _CBR method. That is, else the host bridge should
> be enumerated during boot.

host bridges are there, just not the component registers in the CHBCR it appears.

> 
> Is it just a delay, or does the CHBCR come up not earlier than the
> root port link is up?

Let me get that clarification from the BIOS people.

> 
> Can -EAGAIN be used to reload the driver later if CHBCR init fails?
> IMO, the Component Registers cannot be initialized later as that would
> delay the enablement of the root decoders too. At least only bridges
> that fail to init the CHBCR should be delayed.

I don't follow why this is an issue. Auto region assembly doesn't start until the port hierarchy is established via the first endpoint. So by the time the region code pokes at the decoder registers during region assembly, the component register for CHBCR should have been probed. It seems reasonable to setup the component registers when we find the first dport and thus indicate that everything should be there. Are you observing an issue on a platform?

> 
> The issue and the changes for this are not obvious, please make a
> separate patch for that separate change.

It was in this [1] patch.

https://lore.kernel.org/linux-cxl/20250814222151.3520500-5-dave.jiang@intel.com/

I think the name of the function being discussed confused things. It is now renamed to setup decoders instead of just setup.

DJ

> 
> Thanks,
> 
> -Robert
