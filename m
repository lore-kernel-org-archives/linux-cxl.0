Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802C246770
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139926; cv=none; b=Rm26Q2O4lUZ9tcDejz3EtJrtnOi5+dze3ae3hwasqRPbGQJlFBdUdnRafhsbWolLOzhQaN5uu55vVU/dL37MwUMGJnXpllA3NTYVRqnaTK96s1OcXjtqQh6C0Rzc02XMg81x+AP6GucoUjHVV60fA3dshrP6AmwschhyXW7CnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139926; c=relaxed/simple;
	bh=pmzMG2Z/3aTh8MU6m8DyyXw1sDuYWuBtlLhjTTtuyGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfMdROtlOasbEifILMqzwaVVL97ALt6GuocukjOMK3XNxaC/S2syy+GmaJTzNSp/Nb2uwj8BlSr9ySv4cZVgYG6qlR0gAq2mNPjlFErOAELCiXebpnevGsNmhiT2P+K9xYGLOKUvghLVHwkDwHzbl8r3zPiSbWyTxE6dyiEy1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4yFTvGR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4yFTvGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753139925; x=1784675925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmzMG2Z/3aTh8MU6m8DyyXw1sDuYWuBtlLhjTTtuyGo=;
  b=b4yFTvGRh7GaV8AmcUQnNMeWV1d8uvY27cHos39F1iree4+gSJ3Y71fH
   gTWh12O4PqEw/fiS6Fm4/rXMYmfPwNoiU46/8N5jeXyB9uKTqVLjrfPz+
   IMfwYIMZ7wGhNqZ9m7fGDaQgeTIj7DoxlBipt2W0xp7ds1KbXP8oftw0G
   ahr91etVeg81Fa/1Mo6CSUz0K5LDHP8fdnp5gJnOLzEKljxavqKksbnaB
   W+N3P4uEaGuEGhk/BLkE+lFykMoaS5xLbhfy5eS0rMKxJL3PMa6ngBnNc
   3X084RDn2KUqwAD+Sboag3ts+vvMFOq11uxrjBgttNfYe3KM0M3TN0jI8
   g==;
X-CSE-ConnectionGUID: /c8QEUyES8e7LJMBpf1Oew==
X-CSE-MsgGUID: +7sZ4RgmQz66zSshRCFLrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55531117"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55531117"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:18:45 -0700
X-CSE-ConnectionGUID: PNkyjJJwTEyE3uT2h0Um9Q==
X-CSE-MsgGUID: /nWguMB6SkqqZ7s1eacHNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163263061"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:18:39 -0700
Message-ID: <39405a18-f2da-472a-b5b0-8b01b456f1d1@intel.com>
Date: Mon, 21 Jul 2025 16:18:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] cxl/region: Add decoder check to
 check_commit_order()
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 Gregory Price <gourry@gourry.net>, Li Ming <ming.li@zohomail.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-2-dave.jiang@intel.com>
 <687ea083ca60e_134cc7100fd@dwillia2-xfh.jf.intel.com.notmuch>
 <687ebb328b153_137e6b1004a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <687ebb328b153_137e6b1004a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 3:12 PM, dan.j.williams@intel.com wrote:
> dan.j.williams@ wrote:
>> Dave Jiang wrote:
>>> check_commit_order() attempts to convert a device to a decoder without
>>> making sure the device is a decoder. So far this has been working due
>>> to pure luck
>>
>> s/pure luck/cxl_port_attach_region() only handling switch port decoder
>> assignment/
>>
>>> . Issue discovered while doing deferred dport probing when
>>> child ports are now in the midst of decoders due to ordering change
>>
>> s/midst/mix/?
>>
>> So I went looking to see if this change actually makes a difference in
>> the end, or if this was just the result of debugging an interim state of
>> the code that ended up passing non-switch decoders through this path.
>>
>> The disinction matters for understanding code-flow and history here.
>> Like something is wrong if this expectation is violated in some future
>> refactoring and may even be worth putting a dev_WARN_ONCE() in this
>> path.
>>
>> In fact I put a dev_WARN_ONCE in this path with all the patches applied
>> and it never triggers with a cxl test suite run, so I think it is safe
>> to do something like the below.
>>
>> ...but before going there, can you confirm the expectation that the
>> safety is not strictly needed?
> 
> Ok, so I finally remembered the previous discussion here and switch
> ports have both endpoint-port child devices and decoder child devices.
> 
> However, endpoint-ports are always added *after* decoders. That is
> enforced by the fact that decoders are added in cxl_switch_port_probe()
> and endpoint-ports serialize against that before adding new ports.
> 
> The device_for_each_child_reverse_from() staring from a decoder makes
> sure to only see decoder children. So check_commit_order() seeing
> endpoint ports is a bug not something that should be silently allowed.

I think at one point the decoders were pushed to be allocated at a later time. However, the current implementation allocates all the decoders at the time that it was done originally and we just end up updating the targets for the decoders when the dports show up. So I'm thinking maybe this patch can just be dropped. 

