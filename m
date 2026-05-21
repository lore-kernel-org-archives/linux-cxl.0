Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00521CEADB;
	Thu, 21 May 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383630; cv=none; b=Z3RWt82v/AcgkshYs39N53C0dtKQpvZcrX8w0Rj89DsbliKw/HpdaTubvT1WOBn1dD69I7v0/eKkpOutl4L7kwmJZ3y3R6Q8O6dAOXhf+4c84SKK+GfbQuHnNZSFrpw3g2UI+JQ0zA5xABoeb0138f2SxMLMX1Bvn2MSht3roBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383630; c=relaxed/simple;
	bh=4BuoKAybbNM2w16O2i0EHBVte29Wp5lPlFj5qEA/9UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6I0V0pPW4rdF7G/q9cnAiwwWRKBFbI0fPGkMZlSqc2HT77bEWRQUYBw+fVf1leFEDKTlfveNKpNJ3xRCRGSdsocflsEXDOPfTpOAfTnmQeYugn7B7jvvsWlWnbFbHlNMoXbS8kIKpm4tWvnyk5eWKj96LwwuHruZ+nZdDsCuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY30VkJ5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY30VkJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779383628; x=1810919628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4BuoKAybbNM2w16O2i0EHBVte29Wp5lPlFj5qEA/9UI=;
  b=IY30VkJ5FRUW/Ldxk6yjoUW6FOY9q21438h+fwbmX6/IWzVkfIgXcipH
   fF//pNyjWUrYlET8DKh4DRthRMZkw2LovGyQSP+GW0PdUrqZsizVcgHce
   7ysXoSLl89myr/ePfQLg084mRlEmFUxtzBJzgpxbKzWIiueBQ/K0k+k62
   RYWKOD31CHMWpyhoi1LJ3dmfOAohGypkZczLOvqsC8OAR//jshXXBuu2X
   x9+W6haLKAWwSr+cFUQOoJXmUQpf9BExiyBZqM0chCVpUGP+XmFFyPF2M
   29Baq0az8URbYbjntWZL409WDQ1d7kDNnpCkp2nNt9CkernBm3vVeZ9S7
   A==;
X-CSE-ConnectionGUID: SAObfwY5T1KShVtORowVHw==
X-CSE-MsgGUID: m+IcwQ2hQ1WfHrl6kl6IUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="84192087"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="84192087"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:13:48 -0700
X-CSE-ConnectionGUID: h+505psxTgS7A0CiH9l84w==
X-CSE-MsgGUID: AIcvPJN4QdGDE1PmUTVkCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="242383047"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.16]) ([10.125.110.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:13:47 -0700
Message-ID: <ffec8ee4-8e93-4e72-96ac-1e6bdaa18d2e@intel.com>
Date: Thu, 21 May 2026 10:13:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is
 not ready
To: Chen Pei <cp0613@linux.alibaba.com>, djbw@kernel.org
Cc: alison.schofield@intel.com, dave@stgolabs.net, guoren@kernel.org,
 icheng@nvidia.com, ira.weiny@intel.com, jic23@kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 vishal.l.verma@intel.com
References: <6a07730211b81_a6174100c8@djbw-dev.notmuch>
 <20260519015509.4699-1-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519015509.4699-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/18/26 6:55 PM, Chen Pei wrote:
> On Fri, 15 May 2026 12:24:50 -0700, Dan Williams wrote:
> 
>> If the platform is defined to defer PCI root scans then this dependency
>> must be declared. Specifically firmware needs to tell Linux about the
>> dependency given it does not order PCI enumeration before ACPI0017
>> enumeration by default. Something like: 
>>
>>   Device (CXLM) { // ACPI0017
>>       Name (_HID, "ACPI0017")
>>       Name (_DEP, Package () {
>>           \_SB.CXL0, // ACPI0016 host bridge
>>           \_SB.CXL1,
>>       })
>>   }
>>
>> ...in the firmware, and then:
>>
>> acpi_dev_clear_dependencies()
>>
>> ...for each acpi_pci_root_add().
>>
>> Then ACPI0017 will naturally await all of the ACPI0016 devices that the
>> firmware knows about.
> 
> Hi Dan,
> 
> Thanks for the guidance. The _DEP approach is clearly the right way
> to handle this - it's the proper ACPI standard mechanism for declaring
> device dependencies and avoids the permanent defer risk that Dave and
> others raised with the EPROBE_DEFER approach.
> 
> I plan to abandon this patch and implement the _DEP solution instead.
> Let me confirm my understanding of the two changes needed:
> 
> 1. Firmware (QEMU DSDT): Add a _DEP package to the ACPI0017 device
>    that references all ACPI0016 CXL host bridge devices in the system.
> 
> 2. Kernel (drivers/acpi/pci_root.c): Add acpi_dev_clear_dependencies()
>    at the end of acpi_pci_root_add() so that once an ACPI0016 device
>    is bound, its consumers (ACPI0017) are notified and can proceed
>    with probing.

Please submit a patch upstream for this. Thanks!

> 
> Is my understanding correct? Any other changes or considerations
> I might be missing?
> 
> Thanks,
> Pei

