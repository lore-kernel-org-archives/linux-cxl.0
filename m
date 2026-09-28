Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF1218592
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635007; cv=none; b=IpAWnb39ohZs10Et6CyWWcMBI3ojB7qlWcsA3ZEwf2Gf3clrWNHJebbMklh9Wj1PhUFDAepqU6Do5SgpSqOwZmVrq/2TRGRC7oaqoczWLMkBndLwQn/fTt2Y00BCUY/cz6slcGVDESwdGsgrnzqdV13iK01tESfbm/qHXWf2Kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635007; c=relaxed/simple;
	bh=G034OHmPS/4vaySIs9IbAZKDAMG0IWSBOpMxQcEvpOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak5YbsRGG5103BmqbXa+bhP3IXEQ/V5NOUAHUWOTudjhxAe8nXocmsF1dbxmxiiuCryB3WWj5uo/wEs7UOrppPudDp9T9uELP1pcboRD84ecyjeyfkUyI9C04T7qvVNajLijtEvSMkGDvxXqtgp8FRI2h+Af36UuFY7nxuPxXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHPR0ZYe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHPR0ZYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635005; x=1822171005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G034OHmPS/4vaySIs9IbAZKDAMG0IWSBOpMxQcEvpOc=;
  b=kHPR0ZYeQwqs8LV7MPWKJL202qg3JSYTKQvMceO4f+mNwty4Z1FmIBI1
   pRiS1kEcZjoq5wbYbx6N1WGIwARnSKy1ZJhJux97/C/or/qUTFjKPAMtu
   X86W4q/nmwziIYugR1xthS8X1kDaE0T+cs1ShrpH3yjXEsrg32jqbyZBE
   SDCfcHr7xHR3swQlENKL2uNolCSrGpvLkuelOl5fUbeiUMz35uXSLJJ9X
   JQ1IIovhVCbd9CPUTNcawDT52qR6rXyHipGigyyqr0dksVjqCXtw0oIcj
   p3lLvZ+Oa2L/A5KIRXy6x2/zBoLEijpxw/pgHx8JBMlzpURBWwhx9bcpB
   A==;
X-CSE-ConnectionGUID: 7uJXwM0YQ/+Byv98/cO2Hg==
X-CSE-MsgGUID: wsJy6dfvR/650Uk+BIhjQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101916429"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101916429"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:36:44 -0700
X-CSE-ConnectionGUID: V69Jxj3nRFCe8ForZ6+LnQ==
X-CSE-MsgGUID: +q2mDE+LSCW+16h1bIp0og==
X-ExtLoop1: 1
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:36:43 -0700
Message-ID: <856dc804-2740-4f8a-97cb-ce86b0b287d5@intel.com>
Date: Mon, 28 Sep 2026 15:36:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/8] Documentation/cxl: Document DPA partition layout
 and ordering rules
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-9-anisa.su@samsung.com>
 <9ffddb3d-9b22-4fe4-b355-bbad82f4b8aa@intel.com>
 <arrhvCTbdD7va7Wm@4470NRD-ASU.ssi.samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <arrhvCTbdD7va7Wm@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 2:53 PM, Anisa Su wrote:
> On Mon, Sep 21, 2026 at 03:02:49PM -0700, Dave Jiang wrote:
>>
>>
>> On 9/18/26 1:30 PM, Anisa Su wrote:
>>> DC Partitions complicate DPA ordering. Add a DPA Partitions section to
>>> cxl-driver.rst describing spec-mandated and Linux requirements for the
>>> layout.
>>>
>>> maturity-map.rst breaks the DCD entry into sub-items so the map shows
>>> what this series lands: partition enumeration is [1], event handling
>>> and DC-backed DAX regions remain [0] until the follow-on series enables
>>> them. The parent stays [0]; nothing is usable yet.
>>>
>>> Suggested-by: Gregory Price <gourry@gourry.net>
>>> Signed-off-by: Anisa Su <anisa.su@samsung.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> ---
>>> Changes:
>>> [jonathan]: drop paragraph describing "support for additional
>>> dc partitions may be added later..." to avoid predicting future work in
>>> documentation
>>> [davidlohr]: add DCD sub-items to maturity-map.rst so a multi-step
>>> upstreaming shows users what is there and sets expectations.
>>> ---
>>>  .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
>>>  Documentation/driver-api/cxl/maturity-map.rst |  4 +++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
>>> index dd6dd17dc536..eb4de2a9a9af 100644
>>> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
>>> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
>>> @@ -181,6 +181,41 @@ A Memory Device is a discrete base object that is not a port.  While the
>>>  physical device it belongs to may also host an `endpoint`, the relationship
>>>  between an `endpoint` and a `memdev` is not captured in sysfs.
>>>  
>>> +DPA Partitions
>>> +~~~~~~~~~~~~~~
>>> +A memory device presents its capacity as one flat `Device Physical Address`
>>> +(DPA) space divided into `partitions`, which Linux lays out in a fixed
>>> +order::
>>> +
>>> +  DPA 0                                                     end
>>> +  +---------------+---------------+---------------------------+
>>> +  |      ram      |     pmem      |       dynamic_ram_1       |
>>> +  +---------------+---------------+---------------------------+
>>> +  part[0]         part[1]         part[2]
>>> +
>>> +Part of that order is required by the CXL specification and part of it is a
>>> +Linux choice.
>>> +
>>> +The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
>>> +Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
>>> +at DPA 0 and pmem starts at the DPA immediately following it.
>>> +
>>> +Dynamic Capacity partitions only need to be 256MB aligned according to
>>> +CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
>>> +(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
>>> +(static) capacity and its first DC partition, or between one DC partition
>>> +and the next.
>>> +
>>> +Linux chooses not to support gaps between static and dynamic capacity: the
>>> +first DC partition must begin at the DPA immediately following static
>>> +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
>>> +a device with no static capacity at all.
>>> +
>>> +Currently, only one dynamic partition is supported. A device may report up
>>> +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
>>> +`dynamic_ram_1`. Gaps between DC partitions are not checked, since only the
>>> +first is used.
>>> +
>>>  Port Relationships
>>>  ~~~~~~~~~~~~~~~~~~
>>>  In our example described above, there are four host bridges attached to the
>>> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
>>> index 282c1102dd81..fefd31899229 100644
>>> --- a/Documentation/driver-api/cxl/maturity-map.rst
>>> +++ b/Documentation/driver-api/cxl/maturity-map.rst
>>
>> Maybe hold off this commit for when everything goes in? Otherwise it's weird that there's documentation but no code.
>>
> On Patch 2 and 8 from v12, which add the dynamic_ram_1 partition and enforce
> that there is no gap between static capacity and dynamic, I received feedback
> that it's not clear whether this is from the spec or a Linux rule: 
> 
> patch 2:
> https://lore.kernel.org/linux-cxl/anIMLnbG_KmRfjv6@gourry-fedora-PF4VCD3F/
> 
> patch 8:
> https://lore.kernel.org/linux-cxl/anFCdsSo6dvxfFrZ@aschofie-mobl2.lan/
>>> @@ -150,6 +150,10 @@ Memory-pooling
>>>  * [1] Hotplug of LDs (via PCI hotplug)
>>>  * [0] Dynamic Capacity Device (DCD) Support
>>>  
>>> +  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
>>> +  * [0] Extent add / release event handling
>>> +  * [0] DC-backed DAX regions
>>
>> I would just update maturity map once when the entire DCD code is in.
>>
> I received the feedback from v13 that if the DCD series is going to be split up,
> "the maturity map should indicate what is there and help users understand and set 
> expectations."
> 
> https://lore.kernel.org/linux-cxl/20260908102124.2231730-2-anisa.su@samsung.com/T/#me40889025337fdd9584182bf80cc6dbca45aec9d
> 
> But I could squash this with the documentation commit at
> the end of the full series? https://lore.kernel.org/linux-cxl/20260625112638.550691-32-anisa.su@samsung.com/

Nah just leave it.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Thanks,
> Anisa
>>> +
>>>  Multi-host sharing
>>>  ------------------
>>>  
>>
> 

