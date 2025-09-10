Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BF26F280
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541375; cv=none; b=Ic87PMCsh6Z3YiWON6wSYZnuDc4NLdWP4wAx+yofKaG7EJcYYNxb9aVmcx8joVWN/UJfq5qLD810HgYpIkPFrzqIUBPqksxwLn8WxV2sVc4jPnScp9M+AR4Tc7rSbFs1yhlEvEQ/cqtnL3lUJon3TRRsC6xfv6onaVigFQnSsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541375; c=relaxed/simple;
	bh=OcqYCaUv6a1bYIBlmrciHrUNg/izdUrYkdqCA3kNjLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIz6dBks3KKajlTTUYbmHWA01870a2edEnIvlDZ7FBZYjcDFA2IXF2KblQW4osKKY5hwBic4HIx1wZkD8cCBxxmoGvYMfkq+ze3uliY0PFjl4ZgUY91tjrd0VJo1iOyn6j/WAR+a+j2cn0M46DGy665zxVyVb0AfUj+P3VLqWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG9dybsu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG9dybsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757541373; x=1789077373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OcqYCaUv6a1bYIBlmrciHrUNg/izdUrYkdqCA3kNjLM=;
  b=mG9dybsuusWq0W5Y1kipHXKyi4A0FTvSmbY97ppzLGQxdbFiYEHyIwHl
   TvHKJMQjFiUNlZgEcAAk0/0NiJk3cMBrh6Ln7iTqWz7BUTFANZklATtsm
   cIiGBC75sowYFLBM+VGAWqg8733oENZnMbuY+Op52jO51DbU76Prd+7dK
   tG22RkM1+s1yRjofmLSwzwR2O73zuOvP2rd5MJZnfSle0vEUGorxejJFd
   GSVJ2ih4vo1b7KqD+crAX16jR1TSN6NEwR1Go6XF1tG35LCekkp7KfzXk
   Hx2q7S067pUYSgyzaaggl3hIcUvVktzrIhIZo16uh2KO/kdFTGJnokCII
   g==;
X-CSE-ConnectionGUID: MDTqseytQNq2s+aIcyY+ZA==
X-CSE-MsgGUID: xA1wgMx1R+em3wXqdALYgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77469957"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="77469957"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:56:12 -0700
X-CSE-ConnectionGUID: aBWQLbTlTGmRJD7Wf5CfCQ==
X-CSE-MsgGUID: Cjb0z3wKSjGQNi4cVUjd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="178708843"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:56:12 -0700
Message-ID: <7774c060-b5ca-4c43-91e3-433503dd487e@intel.com>
Date: Wed, 10 Sep 2025 14:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/18] cxl/cache: Add Cache ID Decoder capability
 mapping
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-15-Benjamin.Cheatham@amd.com>
 <20250819151258.00007ed8.alireza.sanaee@huawei.com>
 <063a72a6-b0c8-401f-a969-1ed8b88c11e5@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <063a72a6-b0c8-401f-a969-1ed8b88c11e5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 11:01 AM, Cheatham, Benjamin wrote:
> 
> 
> On 8/19/2025 9:12 AM, Alireza Sanaee wrote:
>> On Tue, 12 Aug 2025 16:29:17 -0500
>> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
>>
>>> The CXL Cache ID Decoder capability is an optional capability present
>>> on CXL downstream switch and CXL-enabled PCIe Root ports. This
>>> capability is required for having multiple CXL.cache enabled devices
>>> under the same port (CXL 3.2 8.2.4.29).
>>>
>>> Add mapping of the capability as part of allocating a CXL cache id for
>>> an endpoint. Implement mapping/validation of the capability in a later
>>> commit.
>>
>> Maybe you keep ID or Cache or Decoder consistent everywhere in the
>> commit message.
> 
> The initial mention was to match the spec, but I don't mind unifying it all.
> 
>>>
>>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>>> ---
>>>  drivers/cxl/cache.c     | 25 +++++++++++++++++++++++++
>>>  drivers/cxl/core/regs.c |  8 ++++++++
>>>  drivers/cxl/cxl.h       |  6 ++++++
>>>  3 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>>> index 24559b9ba8e8..f123d596187d 100644
>>> --- a/drivers/cxl/cache.c
>>> +++ b/drivers/cxl/cache.c
>>> @@ -69,6 +69,27 @@ static int map_cache_idrt_cap(struct cxl_port
>>> *port) BIT(CXL_CM_CAP_CAP_ID_CIDRT));
>>>  }
>>>  
>>> +static int map_cache_idd_cap(struct cxl_dport *dport)
>>> +{
>>> +	int agents;
>>> +
>>> +	if (dport->regs.cidd)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * A missing Cache ID Decoder capability is only an issue
>>> +	 * if there are multiple cache agents in the VCS
>>> +	 */
>>> +	if (!dport->reg_map.component_map.cidd.valid) {
>>> +		agents = atomic_read(&dport->port->cache_agents);
>>> +		return agents > 1 ? -ENXIO : 0;
>>> +	}
>>> +
>>> +	return cxl_map_component_regs(&dport->reg_map,
>>> +				      &dport->regs.component,
>>> +				      BIT(CXL_CM_CAP_CAP_ID_CIDD));
>> Less relevant to this patch. It looks like cxl_map_component_reg
>> receives redundant parameters, both regs.component and reg_map comes
>> from the same structure and other occurrences in the kernel also grab
>> components and reg_map from port, so not sure why two separate
>> parameters are there.
> 
> I *think* they used to be separate and it's a relatively recent change to
> store the parameters together under the same port/dport. Good point though,
> someone could probably take a look at the usage and simplify things accordingly.

Cleanup patches welcome :) 

DJ

> 
>>> +}
>>> +
>>>  static void free_cache_id(void *data)
>>>  {
>>>  	struct cxl_cache_state *cstate = data;
>>> @@ -138,6 +159,10 @@ static int
>>> devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd) rc =
>>> devm_cxl_port_program_cache_idrt(port, dport, cxlcd); if (rc)
>>>  			return rc;
>>> +
>>> +		rc = map_cache_idd_cap(dport);
>>> +		if (rc)
>>> +			return rc;
>>>  	}
>>>  
>>>  	return 0;
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index 0924127bd8fd..1362f4156ee6 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -110,6 +110,13 @@ void cxl_probe_component_regs(struct device
>>> *dev, void __iomem *base, rmap = &map->cidrt;
>>>  			break;
>>>  		}
>>> +		case CXL_CM_CAP_CAP_ID_CIDD:
>>> +			dev_dbg(dev,
>>> +				"found Cache ID decoder capability
>>> (0x%x)\n",
>>> +				offset);
>>> +			length = CXL_CACHE_IDD_CAPABILITY_LENGTH;
>>> +			rmap = &map->cidd;
>>> +			break;
>>>  		default:
>>>  			dev_dbg(dev, "Unknown CM cap ID: %d
>>> (0x%x)\n", cap_id, offset);
>>> @@ -231,6 +238,7 @@ int cxl_map_component_regs(const struct
>>> cxl_register_map *map, { &map->component_map.ras, &regs->ras },
>>>  		{ &map->component_map.snoop, &regs->snoop },
>>>  		{ &map->component_map.cidrt, &regs->cidrt },
>>> +		{ &map->component_map.cidd, &regs->cidd },
>>>  	};
>>>  	int i;
>>>  
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 1a2918aaee62..04fde1a994d0 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -42,6 +42,7 @@ extern const struct nvdimm_security_ops
>>> *cxl_security_ops; #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
>>>  #define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
>>> +#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
>>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>>  
>>>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability
>>> Structure */ @@ -176,6 +177,9 @@ static inline int
>>> ways_to_eiw(unsigned int ways, u8 *eiw) #define
>>> CXL_CACHE_IDRT_TARGETN_VALID BIT(0) #define
>>> CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8) 
>>> +/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
>>> +#define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
>>> +
>>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>>>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
>>> @@ -241,6 +245,7 @@ struct cxl_regs {
>>>  		void __iomem *ras;
>>>  		void __iomem *snoop;
>>>  		void __iomem *cidrt;
>>> +		void __iomem *cidd;
>>>  	);
>>>  	/*
>>>  	 * Common set of CXL Device register block base pointers
>>> @@ -285,6 +290,7 @@ struct cxl_component_reg_map {
>>>  	struct cxl_reg_map ras;
>>>  	struct cxl_reg_map snoop;
>>>  	struct cxl_reg_map cidrt;
>>> +	struct cxl_reg_map cidd;
>>>  };
>>>  
>>>  struct cxl_device_reg_map {
>>
> 
> 

