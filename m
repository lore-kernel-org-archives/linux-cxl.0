Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE9207675;
	Wed,  5 Mar 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218071; cv=none; b=B8PVnTQF6MzZaiMvmaK8nAbCqgt8jB9pUwkiet6QBkMyCchjfw0EvMDW/jSToI9lhD/Gmsm8i/O5dlmb2/s1QyngeCaADGN30Gs7C7EcsOS8dAebqK1Y3MXHt4cTpcbnI6mcpNhN/t/Bjn6ewg+idM4dzQWmD2yq2JGMibJcagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218071; c=relaxed/simple;
	bh=LD8ZGvL40HLoK65jjCMTAOR0GJiJLVbwO6x1787IsaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3Dnja6RJG7rVu2JVLUnUlpJRcgHaFo4hVx9xThDJ84zCANi9U7dIGBtGSWHKjF+TGP/fpezoWMBMDpasJM6jiqVmVVHMxCEaDqozc2QE5opiMNTePk8Obql7B0nd/GmJOdSQgvpoOUa0LZB3iZhOVleKNSwjVdw7q4k2ANmU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkgHLaC+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkgHLaC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741218069; x=1772754069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LD8ZGvL40HLoK65jjCMTAOR0GJiJLVbwO6x1787IsaA=;
  b=VkgHLaC+eJonxu+c6q0GzWnLWgZVKk09WcDSdHzR8b7pPhrqHclk60Kr
   QV3aTNO2gsqYE5XIKbdRosnt3NXOGdDa1zHlWRiKt7AorXonyWPyX7UZ3
   EFoAfQvoQL3FChmgwwCGaaiXM/x3OKT0ZrfGQdM+7dJFkCQf0V3KFneKx
   Tj7kxylvkV1Cch7jQjthbxS4IUtTvAUr/uaCcnhmVqSECW8GQm1HNemMT
   9UqwwdBtcT/cuxGd82n4ZfwgM4RZ3WjCVSvzpf+v2vlR2aRWQalz6Fc4g
   zxXFHGaIMl62PIrf/JDcvNtlW7Hdl/wzqZI8Pfb2sohqSaajD/d99zE+4
   A==;
X-CSE-ConnectionGUID: 0FQmIRIoQs259Zd9GKSzYQ==
X-CSE-MsgGUID: AAFMjed3T0KiErqz6WuzWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52416423"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="52416423"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:41:08 -0800
X-CSE-ConnectionGUID: YyV9Ox0tQNmHk/uZ97MIBw==
X-CSE-MsgGUID: r0kd4sCOQPmImpuxN7RFLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119757725"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.222]) ([10.125.109.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:41:09 -0800
Message-ID: <d34016a1-e834-417c-ba2a-028e4e0e9573@intel.com>
Date: Wed, 5 Mar 2025 16:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <04e77063-5676-4435-854c-9488075114c5@intel.com>
 <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 4:34 PM, Gregory Price wrote:
> On Wed, Mar 05, 2025 at 03:44:13PM -0700, Dave Jiang wrote:
>>
>>
>> On 3/5/25 3:20 PM, Gregory Price wrote:
>>> --------------------
>>> Part 0: ACPI Tables.
>>> --------------------
>>> I considered publishing this section first, or at least under
>>> "Platform", but I've found this information largely useful in
>>> debugging interleave configurations and tiering mechanisms -
>>> which are higher level concepts.
>>
>> Hi Gregory,
>> Thanks for detailing all this information. It has been a really good read.
>>
>> Do you intend to also add CDAT information and device performance data calculation related to that? The SRAT/HMAT info only covers CXL memory that are already setup by the BIOS as system memory. Otherwise it only contains performance data for the Generic Port and not the rest of the path to the endpoint.
>>
> 
> Probably CDAT should land in here as well, though in the context of
> simple volatile memory devices it seemed a bit overkill to include it.
> 
> I also don't have a ton of exposure to the GenPort flow of operations,
> so i didn't want to delay what I do have here.  If you have a
> recommended addition - I do intend to go through and edit/reformat most
> of this series after LSF/MM into a friendlier format of documentation.

I can help write it if there's no great urgency. I'll try to find some time creating a draft and send it your way.

DJ

> 
> I wanted to avoid dropping a 50 page writeup all at once with hopes of
> getting feedback on each chunk to correct inaccuracies (see hotplug). So
> I'm certainly open to adding whatever folks think is missing/important.
> 
> ~Gregory

