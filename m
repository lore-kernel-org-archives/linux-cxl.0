Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB6227EAA
	for <linux-cxl@vger.kernel.org>; Tue, 26 Aug 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229508; cv=none; b=tDksvb7SdvqIH2KF8TTZTm8ymNY+4wn6FnhberkbDXd/Zuh9+l7RXHhvUDCH/j7fNTlyNzrpOPL6Pn/Zuwpwlm4kTzQePJdQ8EmPaemweagLxxhxH4tq0TAi/sA1ANnKI1f07xPpInhlJyH2ZmkYYEb37LtVGT317x94R0x7yno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229508; c=relaxed/simple;
	bh=6ziCJiERqwVBoQ+I7K0uy9hTlmzKbwS5S0sIA75LZZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Te+wJJweTePIiTKmL5XjtuJjDOWcFsUREbtISZIzIbK0lcU9vm1Hzgc12sv5LOtd6I2hNeMxsfJZ5PvdeFPLvSsSQNVK6Qt4q/dvk7lrFvLFhcqlJ8NOyQUe8xUDZMd2cfAKlFstY0IkTcCwqMfEz2nPhTiqe5ZyCn6w7IgRKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpAsZ9wo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpAsZ9wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756229506; x=1787765506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ziCJiERqwVBoQ+I7K0uy9hTlmzKbwS5S0sIA75LZZs=;
  b=XpAsZ9wo38hXs57hR5f5y2pjsprY0Cv6J+qC/FnhYO3gXCkNvFpmTRnc
   JXxHsvzuEVYoeoyKyK+x+ViHVh811NYZy71/l+6DNRv+AxY8qgijQyFBY
   rPLpAoTC+5rlB34VFZUD6LzFRM6Wl4mhzP+UjIRyvFLPndtdJGfF0D2Eh
   e0XGBGktYPPKVyR0n2wC2k9mFVwTYjhY6KpTf31GKTNH++iOI6FCZ3SWd
   rQe2mosulOcuHaZQZq4GAbJbFk6JbZ8T8Y2R2DGZwg7M1tv87QqnobMb+
   xh7XjPM5yTvOnxsjfvlHBGJTtTE3mscsTRCncMhfMmExyBIYySyiKGmtF
   A==;
X-CSE-ConnectionGUID: 7avtuvUKR3OM2mIL6AaKpw==
X-CSE-MsgGUID: PayCGCZ7TTKYfpHtJfnHVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69915110"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69915110"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:31:45 -0700
X-CSE-ConnectionGUID: VjIk8R29S8KQjRxz+QOtHw==
X-CSE-MsgGUID: nuBn5iT6RKSGPQgKB7pGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169807530"
Received: from anmitta2-mobl3.gar.corp.intel.com (HELO [10.247.118.12]) ([10.247.118.12])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:31:16 -0700
Message-ID: <3d61803b-496d-40dc-8961-b84c6f7a432f@intel.com>
Date: Tue, 26 Aug 2025 10:31:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
To: "Olivi, Matteo" <molivi3@gatech.edu>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
 <20250110170150.00005446@huawei.com>
 <DM5PR07MB3548AFCDDA3DC39F50EECBE0973DA@DM5PR07MB3548.namprd07.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <DM5PR07MB3548AFCDDA3DC39F50EECBE0973DA@DM5PR07MB3548.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/21/25 7:38 PM, Olivi, Matteo wrote:
> Thanks for the thorough answer.
> 
> Given this part of the answer:
> 
>> The BIOS may have configured the CXL memory and done the work for SRAT and HMAT
>> to include that memory.  Or it may present HMAT to a generic port entry in SRAT and
>> leave the discovery of performance to the OS when it is setting up the memory
>> mappings etc. For now we present the data for the nearest initiator (cpu / cpu or other)
>> to the CXL memory.
> 
> I have three follow-up questions:
> 
> 1. Assume the OS, and not the BIOS, does the discovery. Then, the HMAT would not list the latency and bandwidth to the memory (only to the generic ports). But the sysfs
> files with the latency for local target-initiators pairs would still have the "complete" latency to the memory (as discovered by the OS), right?
> 
> 2. If it's the OS which does the discovery, what information does it use? Does it rely on some firmware hardcoded values like the BIOS, or does it run some measurements
> (e.g. perform some memory requests and time them)? In case it does measurements, how does that work for pooled memory that is physically, but not logically,
> plugged to the host (there's no way to issue memory requests to it)?

This document and the associated docs may be helpful.
https://docs.kernel.org/driver-api/cxl/linux/access-coordinates.html

> 
> 3. Regardless of whether the OS or the BIOS does the discovery, assume the memory is from a CXL pool that is external to the host. A portion of the latency will depend on the PCIe link that will have variable length (and thus latency). There's no way the motherboard firmware can know that latency at boot time. Is the latency for the link accounted for in the HMAT (and the derived sysfs files)?
> 
> Thanks,
> Matteo Olivi.
> ________________________________________
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Sent: Friday, January 10, 2025 12:01 PM
> To: Olivi, Matteo <molivi3@gatech.edu>
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: Re: How to programmatically discover online and offline memory and its latency and bandwidth from user space?
>  
> On Wed, 8 Jan 2025 17:55:41 +0000
> "Olivi, Matteo" <molivi3@gatech.edu> wrote:
> 
>> Hello,
>> I'm a PhD student working on orchestrator support for memory disaggregation.
>>
>> I have some questions about how Linux presents CXL memory and its performance
>> characteristics to user space.
>>
>> 1. What is the simplest way for a user space program (with root privileges) to learn the
>> latency and bandwidth between each pair of NUMA nodes (even non-CXL ones)? Are
>> reading the HMAT and shelling out to the cxl cli the only two options? I've read
>> https://docs.kernel.org/admin-guide/mm/numaperf.html but AFAIU given a memory target
>> those sysfs files only report the performance from the local initiators. I care about each pair,
>> not just local ones.
> 
> Unfortunately the interface indeed only presents a tiny part of the data in a full HMAT table.
> The original discussion on this a few years back concluded that was all that made sense
> until there was a clear use case for more complete data.
> 
> HMAT doesn't have to be complete but I'd assume it normally is.
> 
>>
>> 2. Is there a way to get the information question 1 asks for for memory that is physically
>> connected to the host, but logically isn't? The ACPI spec https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architecture_Platforms.html#system-resource-affinity-table-definition
>> states that "The SRAT describes the system locality that all processors and memory
>> present in a system belong to at system boot. This includes memory that can be hot-added (that
>> is memory that can be added to the system while it is running, without requiring a reboot)."
>> I interpret that to mean that if (CXL) memory is physically, but not logically, connected to the host,
>> the SRAT will still describe the corresponding NUMA node.
>> But what about the HMAT? The ACPI spec
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architecture_Platforms.html#heterogeneous-memory-attributes-information
>> states that  "The static HMAT table provides the boot time description of the memory latency and bandwidth
>> among all memory access Initiator and memory Target System Localities. For hot-added devices and
>> dynamic reconfiguration of the system localities, the _HMA object must be used for runtime update."
>> but it's unclear to me if that applies only to physically hot-plugged memory or to logically hot-plugged
>> memory as well.
> 
> The BIOS may have configured the CXL memory and done the work for SRAT and HMAT to include
> that memory.  Or it may present HMAT to a generic port entry in SRAT and leave the discovery of
> performance to the OS when it is setting up the memory mappings etc.
> For now we present the data for the nearest initiator (cpu / cpu or other) to the CXL memory.
> 
>>
>> 3. Is there a recommended way for a user space program to tell CXL NUMA nodes from local NUMA nodes
>> (both online and offline ones)? One hack would be to check whether the NUMA node has CPUs or not.
>> Another option would be shelling out to the cxl-cli.
> 
> In general not really. It's just memory, you should never care that it is CXL beyond that
> it's performance characteristics are different and maybe for error handling reasons.
> You can indeed use cxl-cli or reads of the sysfs entries that tool is using to figure it out.
> 
>>
>> 4. Is there a way for a user space program (with root privileges) to learn IDs of CXL NUMA
>> nodes (both online and offline ones) that are globally unique? What I want is:
>> a. if two hosts are both connected to the same CXL memory, they should see that memory
>> with the same ID.
> 
> Look at serial numbers of the devices.  That's not connected to NUMA node IDs that are local
> to a given host.  Those can be obtained with lspci and are unique (assuming manufacturer
> set them - which sometimes doesn't happen in prototype parts).
> 
>> b. two different CXL memory pools will never be seen with the same ID by different hosts.
> ID here can't be NUMA node as those are used to index non sparse structures so it wouldn't
> scale.
> 
> Once we get upstream support for DCD (only sensible way to do pools and remain compliant for
> the spec) and tagging of what that provides, then the globally unique ID will be associated
> with particular bit of shared memory on the device rather than the whole device.
> My guess is that will take a few kernel cycles though.
> 
>>
>> All my questions talk about NUMA nodes. I understand that Linux has multiple
>> layers of abstractions to represent memory, and NUMA nodes are one of the highest ones.
>> If any of the questions above can be answered but at a lower level of abstraction than NUMA
>> nodes, that's fine as long as there's a way to map the entity in the lower level of abstraction
>> to the corresponding NUMA node.
> 
> Hope that helps a little!
> 
> Jonathan
> 
>>
>> Thanks,
>> Matteo Olivi.
>>
> 

