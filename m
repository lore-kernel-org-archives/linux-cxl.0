Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BC2367C3
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570721; cv=none; b=hkKOZeJ74C3APRwp7uScVvuEhnyYQTlzmqBGManT+1Uze7N9mDfPxE449SMEGilPX3wPVBmXdysbfxJiHm1cm0vPeG/b+0XkZHa9aMht/NqVNB2EYsd6uekSdULzYxVXbW022KrwhmbGwEiOG42CzgKoo4SrIV1uzWkJIbKXn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570721; c=relaxed/simple;
	bh=PgcC84qh380rIC9noLGYfvG+S19BjlZ1aie0cOm//oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUBm67ICD5uXMaxr70XS8K2noO1erF/0s9l/5zWMsX17xJEvKSxrNJ55j9EnNSGIRGojBd/h8D/7y6EZ22UfhE9wjwhs/ud8QVunPLdlZOZF35yzS0Z5TThsj+6+ax8Y7dVLI/lxPL1cS7cFLiPmu93yzzaIWeyFbpM7xYtEIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElnvyLzq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElnvyLzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749570719; x=1781106719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PgcC84qh380rIC9noLGYfvG+S19BjlZ1aie0cOm//oI=;
  b=ElnvyLzqtoUpD7xTJHd12vK/Sv8WqFbHdRIaF0SO5qDnDCYP8aDVG96G
   OCP4TMLVDwoEbUxIfrMUT/UnGcS55P/gf3JVsUnze5fLib1tlqXlMF1Zn
   y+3b0c2vPjCP9+udX7DW0OzJYg9/Lv7kVS3s78yDyqXAexhaUwkTXiUZ/
   /3k6pypJVx33FowSero3lyNop608YEAhXJ7C+T5NCdCTOgrklGwkPFOAb
   q/j5syTU+VEvno847NKIrp+FkLJ4XkPqY9djH/uD1NI6XG6W3YnbrLZBi
   JjRApVMiRZcu0BLDCUvct4sMQ0uouLvFNUtRlDQIPaghdcj9ClG/Jf7Mi
   Q==;
X-CSE-ConnectionGUID: Ue3uaGYFSXin0FtVmF5eaA==
X-CSE-MsgGUID: TM0Le8SSR5y5xNNF6pqEqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51784256"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51784256"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 08:51:59 -0700
X-CSE-ConnectionGUID: 8MsIIT3xTnSmP7+2V5+OBw==
X-CSE-MsgGUID: eOXYeVbASAqSrIuC2faSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="170070734"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.135]) ([10.125.111.135])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 08:51:58 -0700
Message-ID: <aa582093-ff13-4bfc-afbf-83326074bf3d@intel.com>
Date: Tue, 10 Jun 2025 08:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api/cxl: Introduce conventions.rst
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, fabio.m.de.francesco@linux.intel.com,
 Jonathan.Cameron@huawei.com
References: <20250603185254.3730099-1-dan.j.williams@intel.com>
 <aEgrIeoOR3J0Iaqs@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aEgrIeoOR3J0Iaqs@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 5:54 AM, Robert Richter wrote:
> Dan,
> 
> On 03.06.25 11:52:54, Dan Williams wrote:
>> There exists shipping platforms that bend, break, or otherwise lean on
>> ambiguities in the CXL specification. Without driver changes to accommodate
>> these deviations, end users are left without CXL subsystem RAS features.
>> Specifically, provisioning, error translation, and other flows require the
>> CXL subsystem to understand the platforms CXL topology beyond undecorated
>> memory address ranges.
> 
> thank you for addressing and documenting this. That helps following a
> process to generalize platform specifics and add them to the spec and
> Linux driver.
> 
>>
>> Those isolated compatibility problems risk growing into deeper upstream
>> maintenance burden if different platform vendors arrive at diverging
>> solutions. For example, there are multiple options for resolving
>> low-memory-mmio intersecting large-interleave-ways CXL windows. Linux
>> should only entertain one solution to that problem.
>>
>> Now, with the ACPI Specification Working Group, situations like this would
>> be resolved with the "Code First ECN" process to codify Linux expectations
>> in a specification. In the absence of such a process for the CXL
>> specification, create a file in Linux documentation to detail the
>> motivations, assumptions, tradeoffs, and proposals for amending
>> specification language.
> 
> I have found a collection of ACPI ECNs here:
> 
>  https://github.com/pmem/acpi-spec-ecr
>  https://github.com/pmem/acpi-spec-ecr/blob/main/cxl-hmat-ext-linear.md
> 
> Is there the plan to have a repo like this for CXL? Or just use
> Documentation/driver-api/cxl/ for this?
> 
>>
>> The goal is to capture the issues such that platform vendors arrive at
>> compatible solutions for these problems and serve as a repository for
>> potential specification updates. The expectation is to update
>> conventions.rst along with CXL subsystem code changes to accommodate the
>> platform topology.
> 
> Ah, so it will be part of conventions.rst for each ECN, right?
> 
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Though it is already applied:
> 
> Reviewed-by: Robert Richter <rrichter@amd.com>

I had to fix something for linux-next, so I applied your review tag.

DJ

> 
>> ---
>>  Documentation/driver-api/cxl/conventions.rst | 48 ++++++++++++++++++++
>>  Documentation/driver-api/cxl/index.rst       |  2 +
>>  2 files changed, 50 insertions(+)
>>  create mode 100644 Documentation/driver-api/cxl/conventions.rst

