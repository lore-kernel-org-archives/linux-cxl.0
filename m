Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A661C5F2A
	for <linux-cxl@vger.kernel.org>; Fri, 10 Jan 2025 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528518; cv=none; b=fF/+ZasWZXk4B1mLfU9LlqnwyNRYP9xGYDXoluOyvtSWOQbv6+zsBlXUCPjnB2vtmt3Dgxc+4VofftMYTMzXbg43M9pSMAFt9lylp6vf8/XM1X7lCbp8NqUXFwYowKzbRwz9rzWADtrgW5NKa2SDJS6GV1gDcU7fF3b3tlhJC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528518; c=relaxed/simple;
	bh=Q+DpULxb3qzzhHJeZf4GUjM8050Vjrios4Slka0jIlQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSINRq0OM9BdF5b9qsfG4f8CIlbR75XJjLhpuTGnTRzoCS+XUDIEEBPShn+b1FqbW8Fa3LqmpIZSiMFILW/eUPQ0KYpWwJrDJx3bfjrE2wdSozjC8lFYBx5zuAihTPy13PHC5XTdepT9qY0wBy0L5J1LDX60KJnd5SS+ZR1P3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV79g190dz6JB2k;
	Sat, 11 Jan 2025 00:57:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5CC61408F9;
	Sat, 11 Jan 2025 01:01:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 18:01:52 +0100
Date: Fri, 10 Jan 2025 17:01:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Olivi, Matteo" <molivi3@gatech.edu>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
Message-ID: <20250110170150.00005446@huawei.com>
In-Reply-To: <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
References: <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 8 Jan 2025 17:55:41 +0000
"Olivi, Matteo" <molivi3@gatech.edu> wrote:

> Hello,
> I'm a PhD student working on orchestrator support for memory disaggregation.
> 
> I have some questions about how Linux presents CXL memory and its performance
> characteristics to user space.
> 
> 1. What is the simplest way for a user space program (with root privileges) to learn the
> latency and bandwidth between each pair of NUMA nodes (even non-CXL ones)? Are
> reading the HMAT and shelling out to the cxl cli the only two options? I've read
> https://docs.kernel.org/admin-guide/mm/numaperf.html but AFAIU given a memory target
> those sysfs files only report the performance from the local initiators. I care about each pair,
> not just local ones.

Unfortunately the interface indeed only presents a tiny part of the data in a full HMAT table.
The original discussion on this a few years back concluded that was all that made sense
until there was a clear use case for more complete data.

HMAT doesn't have to be complete but I'd assume it normally is.

> 
> 2. Is there a way to get the information question 1 asks for for memory that is physically
> connected to the host, but logically isn't? The ACPI spec https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architecture_Platforms.html#system-resource-affinity-table-definition 
> states that "The SRAT describes the system locality that all processors and memory
> present in a system belong to at system boot. This includes memory that can be hot-added (that
> is memory that can be added to the system while it is running, without requiring a reboot)."
> I interpret that to mean that if (CXL) memory is physically, but not logically, connected to the host,
> the SRAT will still describe the corresponding NUMA node.
> But what about the HMAT? The ACPI spec
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architecture_Platforms.html#heterogeneous-memory-attributes-information
> states that  "The static HMAT table provides the boot time description of the memory latency and bandwidth
> among all memory access Initiator and memory Target System Localities. For hot-added devices and
> dynamic reconfiguration of the system localities, the _HMA object must be used for runtime update."
> but it's unclear to me if that applies only to physically hot-plugged memory or to logically hot-plugged
> memory as well.

The BIOS may have configured the CXL memory and done the work for SRAT and HMAT to include
that memory.  Or it may present HMAT to a generic port entry in SRAT and leave the discovery of
performance to the OS when it is setting up the memory mappings etc.
For now we present the data for the nearest initiator (cpu / cpu or other) to the CXL memory.

> 
> 3. Is there a recommended way for a user space program to tell CXL NUMA nodes from local NUMA nodes
> (both online and offline ones)? One hack would be to check whether the NUMA node has CPUs or not.
> Another option would be shelling out to the cxl-cli. 

In general not really. It's just memory, you should never care that it is CXL beyond that
it's performance characteristics are different and maybe for error handling reasons.
You can indeed use cxl-cli or reads of the sysfs entries that tool is using to figure it out.

> 
> 4. Is there a way for a user space program (with root privileges) to learn IDs of CXL NUMA
> nodes (both online and offline ones) that are globally unique? What I want is:
> a. if two hosts are both connected to the same CXL memory, they should see that memory
> with the same ID.

Look at serial numbers of the devices.  That's not connected to NUMA node IDs that are local
to a given host.  Those can be obtained with lspci and are unique (assuming manufacturer
set them - which sometimes doesn't happen in prototype parts).

> b. two different CXL memory pools will never be seen with the same ID by different hosts.
ID here can't be NUMA node as those are used to index non sparse structures so it wouldn't
scale.

Once we get upstream support for DCD (only sensible way to do pools and remain compliant for
the spec) and tagging of what that provides, then the globally unique ID will be associated
with particular bit of shared memory on the device rather than the whole device.
My guess is that will take a few kernel cycles though.

> 
> All my questions talk about NUMA nodes. I understand that Linux has multiple
> layers of abstractions to represent memory, and NUMA nodes are one of the highest ones.
> If any of the questions above can be answered but at a lower level of abstraction than NUMA
> nodes, that's fine as long as there's a way to map the entity in the lower level of abstraction
> to the corresponding NUMA node.

Hope that helps a little!

Jonathan

> 
> Thanks,
> Matteo Olivi.
> 

