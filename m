Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36C5226AE;
	Wed, 14 Oct 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998194; cv=none; b=X8oaxqj7q0JLdFFcC2FzB4E8WcWvYpZFazP1PjyeSqy6mhmb7xmp6XeIAK5mcVSudi1aRVcIffJQZwLL94F2+vkCOIiPIJ5ho+0gtGi0pTkkePByLZeyIh+qs7ha3/pyPvNR8gZbDVEbRvSh6rSH2ljJFS6jf+T7ic7Ct+bBUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998194; c=relaxed/simple;
	bh=f6YiD4927Wid/o04YwJDlYA4aM1D/84w4Ea3E21hP2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLKwjOlqJ+dnedvmasn4IDcBE5pSWgmQO9w0x48vAF946dCee0KEl7xs3D756I7GZyxSmlhthUTCqyK+ChsBmluD2AjsLSZ54j+jaXyijT3bc6jPYhSU3K4gmxdqH1wO46VTI4TMbXcXUPsf+Viacvt39N6MFOrhbSFfcHZtgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ+dhGWA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ+dhGWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791998192; x=1823534192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f6YiD4927Wid/o04YwJDlYA4aM1D/84w4Ea3E21hP2I=;
  b=NJ+dhGWANPBuuO3QSFBmHDrnxaW79/DEIZX082C419CudZq2eVtmE05Q
   XfCy39JHrl3dqpQtlITgPNWM0/qP/Fcx8ZnK32WK33VTWllpFhPdekSTd
   uYLXuwf3mGegggJIOCtu1hTn2utz+83K8+Ixw1Tn26g5QXl4iUzbdIfOr
   iZbYeeRVUAz693pQMzJ5s8aaW0NeWghHtmK2RCM4ab1b6IVFIYqruqg6T
   CyWchoDXJU20vk24quJw2AGWi9Rhl2eFcMUpgizegoDYfG2WrnkJQ68FP
   dY3ofPAF5eBk/nIX3nlbQuIoPU2USPxHL2khKZuMzLo9Vdou6ShWk1aYx
   w==;
X-CSE-ConnectionGUID: ++881HQrR4OVuWD5j0hb8A==
X-CSE-MsgGUID: 3GilZYmiRuep7xBWUMfMNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="783995"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="783995"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:16:31 -0700
X-CSE-ConnectionGUID: osIpf7F0St++8G8d1lKc5w==
X-CSE-MsgGUID: fOzaMBbAQpadDQwc0h8mBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3243535"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.36]) ([10.125.110.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:16:29 -0700
Message-ID: <ccfb14ff-989c-44c5-96be-a092a5c0fad9@intel.com>
Date: Wed, 14 Oct 2026 10:16:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] cxl: Provide explicit RAM region creation for
 Type-2 providers
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <1fd14fc6-de0d-4980-ac8b-8138dd5ef17c@amd.com>
 <3466e889-82a0-41ac-9013-7d21020b5092@intel.com>
 <9427af6f-e693-4cdc-8fc3-21c529888125@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <9427af6f-e693-4cdc-8fc3-21c529888125@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/14/26 9:35 AM, Lucero Palau, Alejandro wrote:
> 
> On 14/10/2026 17:23, Dave Jiang wrote:
>>
>> On 10/14/26 8:34 AM, Lucero Palau, Alejandro wrote:
>>> On 07/10/2026 10:05, Richard Cheng wrote:
>>>> A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
>>>> and obtain an HPA range. This requires an existing committed region,
>>>> so registration fails when firmware has not configured one.
>>>>
>>>> Firmware may provide a suitable CFMWS window without programming a
>>>> region.
>>>
>>> Hi Richard,
>>>
>>>
>>> FWIW, I unsuccessfully  tried to explain this possibility to "BIOS people". The fact is, nowadays for AMD and I think for Intel as well, if there is no CXL device detected with CXL.mem enabled, the BIOS will neither set HDMs  nor there will be a CFMWS.
>>
>> Hmmmm....don't they have to reserve CFMWS for hotplug?
> 
> 
> I have to admit I'm a bit lost with hotplugging and CXL needs, and not real experience with hot plug devices at all, but in my mind hotplugging allows a great flexibility which is counterintuitive if you need to know before hand which devices are going to be hot plugged ..., regarding CXL, how a CFMWS can be created without having that information? Maybe there is something in the specs about this and I did not pay attention.
> 

I believe BIOS needs to set aside a range of HPA via CFMWS to allow for hot plugged devices.

> 
> What do you think about my other concern below?
> 
> 
>> DJ
>>
>>>
>>>
>>>> Hot-added devices can have the same requirement. A provider
>>>> needs its endpoint topology established before deciding when to
>>>> create a region and how much memory to map.
>>>
>>> Another unsuccessfully discussion was to avoid BIOS setting HDMs at hotplug time as this could race with host dynamic regions creation.
>>>

The BIOS does not touch device when hot plugged I believe. It's all OS native handled.

>>>
>>> I'm commenting these two things here for maybe having a community/kernel discussion with the goal of defining what BIOSes should do and mostly what they should not do if they want to be compatible with kernel expectations.
>>>
>>>

