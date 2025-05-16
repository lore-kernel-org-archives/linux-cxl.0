Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C71D54E9
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410441; cv=none; b=g2UIzp7SBDFkIgTSkdo9/GomM4FgTY7zxysGJOiznRDFwhClZ0NVvpwmXKOR2InS52LHBJZg6YRlnZV6ObyNCxpe5W4Qs5HF095PP3vWR2acOJD6IRnidgP7XOENIYHIx7d7HD9xf9cfVTUY4ds9WgwR6OGeTUVjWfCCjCN5Md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410441; c=relaxed/simple;
	bh=M3a7VOoFP5E6h3Nt7YmbdeJqAJ8tcT9QCfP0hvtQeRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJJmPEqSOckD4Nkz3pwAinHaODrVVCXUJOCYzna7ScKnsTV61jluNiqeykSm1BZz9qLoDS02EUvrAKbfPwknhCMDwDK4C/x3Wax+3H/GENNfTU5ZHJI+brPbGNwuNFS+CjBK9FLw2AiJkk3Tq4RkfNW2jSlY6Ng8AMi/oh48tUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJUNgIzo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJUNgIzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747410441; x=1778946441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M3a7VOoFP5E6h3Nt7YmbdeJqAJ8tcT9QCfP0hvtQeRo=;
  b=hJUNgIzorQgExF3uQz/XXuSYb6wS6XmAzNPN1fAIvRrGGiyATx16+UdM
   /MAZOJyrlVGvhkwq2BRExPH7roHjhEK8vRWEJufLWxelC0nInpuDwDkhG
   UdkaqBFeksqnMaQMej2B5PWY4lrX198aY4TsrMu8cbGFXu+84huEOuCoy
   nv4W9IN9+TNj6PRbtg9wDF3XdfVNcR5HQI62U6g4Pyi2bvatr4+4uUZBY
   ewnUDOHipEz18GeGCfJQZ6vuaSeSZI8wVtirOh3Odv7CfXf3zAoJb6pVf
   QpS6Q8EwkxJJyKQOHKzRmiBBjk07kLdUFoytnRGTmic0Y6JqxcDa5VGOc
   w==;
X-CSE-ConnectionGUID: qHd0cAYiSZOtqy8oSqs1DQ==
X-CSE-MsgGUID: PROlk2yuRJS1DxRmRA+80g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49371836"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49371836"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:47:11 -0700
X-CSE-ConnectionGUID: YLZApq8ySy680lQ3bzbC/Q==
X-CSE-MsgGUID: 90gus05nRTGEYJeAXshchA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139732421"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.60]) ([10.125.109.60])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:47:09 -0700
Message-ID: <9408432e-5254-46c1-9def-9416e93888ba@intel.com>
Date: Fri, 16 May 2025 08:47:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-9-dave.jiang@intel.com>
 <aCNqJ5JI2_U7zh-Z@gourry-fedora-PF4VCD3F>
 <96957e88-778e-41d6-a503-1819fac51855@intel.com>
 <aCYeeLskYgLD-ExC@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCYeeLskYgLD-ExC@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/25 10:03 AM, Gregory Price wrote:
> On Tue, May 13, 2025 at 09:12:00AM -0700, Dave Jiang wrote:
>>
>>
>> On 5/13/25 8:49 AM, Gregory Price wrote:
>>> On Tue, May 06, 2025 at 05:43:08PM -0700, Dave Jiang wrote:
>>>> Add a helper to replace the open code detection of CXL device hierarchy
>>>> root. The helper will be used for delayed hostbridge port creation later
>>>> on.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ignorant terminology question: what's the different between the
>>> "cxl hierarchy head" and "cxl root"?
>>
>> I struggle to find the correct terminology between the head of the PCI (or platform device for cxl_test) hierarchy vs the CXL one we constructed for the 'cxl_port' hierarchy. I'm open to suggestions to use better words to distinguish that. 
> 
> Is there an actual difference or they actually the same "device" - just
> abstracted differently?

One is ACPI1700:nn which is an ACPI device. The other is the PCIe root port and considered a pci_bridge device. So top of two different hierarchies. But what trips me up is cxl_test gets in the mix and this is the top of the platform device hierarchy. So finding a proper word to describe the top of that side is difficult. Otherwise I could just say pci_root or something. But I'm avoiding using the keyword "pci" in core/port.c. 

> 
> ~Gregory

