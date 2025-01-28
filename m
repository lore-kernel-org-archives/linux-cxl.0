Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3161B0404
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jan 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079763; cv=none; b=YPJ0flGcmHwjlsicRWxgOauSahGvWS72tbfq3DQgzvyYMYnKhqlHuxgG9YDxSSfaFdOn6SPvLwEuXt0yZpkyzZFHsOEaGYCzkXfA6EkemEBCtf8jZxANQ0Lp6XAWVBdBCYTMm/qieMtY8cBgwzoDSXZXkE9lZ4lYRowSRBl7uDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079763; c=relaxed/simple;
	bh=ayYUVzaoBIrDmcbO2/naag/o4fjohPRaGObRsWQ+es0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxCQG2QGKS16560kbOi+BprI9xWAhmX1D51pGSqBWEnqQZu24g/jAriGWsaIbvAGkCYAjYs/8HQEVyfOnSyBUzxwiFPGEoChKatQitY9Va3sb4RDAOKBsukcA8bGv1lCdDo7yfqJEXbgxnG/6F7Lu3X+apCKYit+o+B7XCfDfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChZz5dZL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChZz5dZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738079760; x=1769615760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ayYUVzaoBIrDmcbO2/naag/o4fjohPRaGObRsWQ+es0=;
  b=ChZz5dZLzIJuWz5Ig9QSeMXg9Rjv9P/5jp0rICxM22si60TqTqBhe7o6
   KbXqA9TvDNMmhvEVGaMR5rC4FzuLqC/K392nKrVWX9EkysYj6mh+jyi8B
   2w+Sl+pDTHbnr77tctbQC2BZlIzXz0h11SdcYnbfdc5hyrIHQRv7Y5aBm
   NHH6JHvzKATkf5/6VKiMMEKLGszdrIiHUMK67LPzHVQ4757NCyeLXP3cK
   EDupKyTzYZq00jVQzdbFjyOdecqNWiVozL3/xxjCd4YkOL4VBNj2RiuVz
   /CwAFvQVMJqT96uQJfuk1LGAorinrnDh89TGgG1e9m/tqy5nlGJXDQ3Ai
   g==;
X-CSE-ConnectionGUID: jt7aUztkRgGM56Zk5IFG+A==
X-CSE-MsgGUID: Xzuw7rTfTI6aVduNSQOOZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56112208"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="56112208"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 07:55:59 -0800
X-CSE-ConnectionGUID: /AbpofqoQjqanss20CBFWw==
X-CSE-MsgGUID: u5hjHHKGShSHNoP2xy2m3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108629316"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.125.108.36]) ([10.125.108.36])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 07:55:59 -0800
Message-ID: <2e21e93f-8ced-4303-bd43-9fa00aece2a1@intel.com>
Date: Tue, 28 Jan 2025 08:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net, jgg@nvidia.com,
 shiju.jose@huawei.com
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
 <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127105132.000072dd@huawei.com>
 <67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <20250128120138.0000599f@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250128120138.0000599f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/28/25 5:01 AM, Jonathan Cameron wrote:
> On Mon, 27 Jan 2025 16:40:48 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> Jonathan Cameron wrote:
>>>   
>>>>> +}
>>>>> +
>>>>> +static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
>>>>> +					   const struct fwctl_rpc_cxl *rpc_in,
>>>>> +					   size_t *out_len)
>>>>> +{
>>>>> +	struct cxl_mbox_get_sup_feats_out *feat_out;
>>>>> +	struct cxl_mbox_get_sup_feats_in feat_in;
>>>>> +	struct cxl_feat_entry *saved, *pos;
>>>>> +	int requested, copied;
>>>>> +	size_t out_size;
>>>>> +	u32 count;
>>>>> +	u16 start;
>>>>> +
>>>>> +	if (rpc_in->op_size != sizeof(feat_in))
>>>>> +		return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
>>>>> +			   rpc_in->op_size))
>>>>> +		return ERR_PTR(-EFAULT);
>>>>> +
>>>>> +	count = le32_to_cpu(feat_in.count);
>>>>> +	start = le16_to_cpu(feat_in.start_idx);
>>>>> +	requested = count / sizeof(*pos);
>>>>> +
>>>>> +	/*
>>>>> +	 * Make sure that the total requested number of entries is not greater
>>>>> +	 * than the total number of supported features allowed for userspace.
>>>>> +	 */
>>>>> +	if (start >= cfs->num_user_features)
>>>>> +		return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +	requested = min_t(int, requested, cfs->num_user_features - start);
>>>>> +
>>>>> +	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
>>>>> +		   requested * sizeof(*pos);
>>>>> +
>>>>> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>>>>> +		kvzalloc(out_size, GFP_KERNEL);
>>>>> +	if (!rpc_out)
>>>>> +		return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);
>>>>> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
>>>>> +	if (requested == 0) {
>>>>> +		feat_out->num_entries = cpu_to_le16(requested);
>>>>> +		feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
>>>>> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>>>>> +		*out_len = out_size;
>>>>> +		return no_free_ptr(rpc_out);
>>>>> +	}
>>>>> +
>>>>> +	pos = &feat_out->ents[0];
>>>>> +	saved = &cfs->entries[0];
>>>>> +
>>>>> +	copied = 0;
>>>>> +	for (int i = 0; i < cfs->num_features; i++, saved++) {
>>>>> +		if (is_cxl_feature_exclusive(saved))
>>>>> +			continue;    
>>>>
>>>> I think it's fine to let userspace see that exclusive features are
>>>> present, just need to return EBUSY if userspace actually tries to use
>>>> them.  
>>>
>>> To me, a poke it and see interface is really ugly.  
>>
>> That smells more like a matter of documentation. "Doctor it hurts when I
>> try to use the documented kernel-exclusive commands?"
> 
> To me this is a nasty interface design.
> If I'm writing a tool to enumerate what is exposed etc then it will
> have to poke every get command just to list if an interface is available.
> Hopefully none of them have side effects!
> 
>>
>>> In many cases we could let "get" through even if the we are using the interface
>>> via some other kernel path and have it as exclusive.
>>> (I don't know how useful that is, but maybe it makes sense).
>>>
>>> If we ever do that, the only way to discover if an interface is available
>>> will be to try the set interface.  Depending on design of feature
>>> that might have side effects - hopefully get never does!  
>>
>> I would not put it past some future device to make that mistake.
> 
> True.  Though I'd be up for a quirk list to block such commands if we
> see them.  Can't deal with them until we know though.
> 
>>
>>>
>>> Alternatives:
>>> 1. Flag. Maybe add something that makes it discoverable if a feature is
>>>    in exclusive mode or not.  
>>
>> I notice that all existing defined Features set a non-zero "Get Feature
>> Size" in their Supported Feature Entry. I would not say "no" to just
>> zero-ing out Get Feature Size as a hint that "you might get EBUSY due to
>> kernel exclusivity with this command", but that still feels like
>> overkill compared to documentation.
> 
> 'might' is no use. Would have to be definitely as otherwise userspace
> can't know the size that field conveyed.

We could zero the "Set Feature Size" in the "Get Supported Features Supported Feature Entry". To indicate that the Feature cannot be changed. That would be spec compliant. Or is there concern that reading the feature may do something for some devices decide to be weird?

DJ


> 
>>
>>> 2. Query type interface.  So a way to actually ask if a given feature is
>>>    usable.  
>>
>> Not sure we really need a programmatic way to read the documentation.
>>
>> The CXL_MEM_COMMAND_FLAG_EXCLUSIVE flag is for cases where the
>> exclusivity is transient. For these features the exclusivity is
>> permanent, and I hope we never need to cross that
>> transient-exclusivity-bridge for Features.
> 
> It's permanent today, but I can definitely see that not always being
> the case - we may well have future kernel does things in X fashion but
> for legacy support disable that CONFIG option. Not nice but definitely
> plausible.
> 
>>
>>> 3. What we have here.  To me the simplest solution is hide what we can't
>>>    be used.  
>>
>> It is inconsistent that we do not do this for the other kernel exclusive
>> commands in userspace retreived Command Effects Log. The ABI here is raw
>> Get Supported Features payload.
> 
> If they were exposed via similar paths I'd agree consistency matters
> but I 'hope' no one is going to have a tool that mixes fwctl and the
> legacy path.  In my head we add all the useful commands to fwctl
> and that legacy path ends up effectively deprecated.
> 
> Anyhow, I don't feel that strongly about this, it's just a case
> of doesn't smell of roses to me.
> 
>>
>>>>> +	/* These effects supported for all scope */
>>>>> +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
>>>>> +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
>>>>> +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
>>>>> +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
>>>>> +	    scope >= FWCTL_RPC_DEBUG_WRITE)
>>>>> +		return true;    
>>>>
>>>> Looks good for the known bits, but this needs to return false for the
>>>> currently reserved bits because the driver can not assume a security
>>>> model for future effects. If a future spec adds
>>>> FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
>>>> those Feature commands through.
>>>>
>>>> Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
>>>> but here we are. The 'extend' concept is typically something like
>>>> "bit15: go look at this other field in this payload as this 16-bit field
>>>> was exhausted", not "bit9: the bits above this originally defined 16 bit
>>>> field now has more bits", oh well.  
>>>
>>> It's odd but corner case of going from 'unknown' state for the remaining
>>> pair of bits to 0 means this and 1 means this.  
>>
>> I don't understand. 0 means no effect to worry about whether it is
>> defined or not.
>>
>>> Naming though doesn't match the spec that calls it CEL[11:10] valid.
>>> Would be good to name it closer to that as we may well have something
>>> in bits 12 and 15 in future and it doesn't refer to them.  
>>
>> Hopefully we can head off another "valid2" mistake, and I don't think
>> Linux needs to define anything for this bit. That bit's definition is:
>>
>>    "Bit[9]: 1 is recommended, 0 is permitted (CEL[11:10] Valid)"
>>
>> ...which translates to "useless". If 11 or 10 are set, I don't care what
>> value 9 has.
>>
>> If 12:15 are set, I don't care if there is a future valid2
>> bit gating whether or not to use them. Valid bits are for cases that go
>> outside of what Reserved 0 compatibility rules can convey, and I think
>> Reserved 0 compatiblity fully covers us in this case.
> 
> Seems the spec authors disagreed. (obviously I can't comment on that
> discussion).
> 
> Using just what anyone can see (if they have the spec)
> It was a clear spec hole and there wasn't an obvious default for 0 to
> mean so it was a 'read your device docs and act appropriately' case
> before this stuff was added.
> 
> There may be corner cases where the right answer if we know the
> feature is not persisted over a reset but instead panic or take
> some heavy weight action. Same can be true the other way around
> in that we may have to do something heavy to manually reset something
> we don't want to persist over reset. Hopefully not but we'll see.
> 
>>
>> So, if a device use case breaks because they set 10, but clear 9 and
>> expect software to ignore 10 then they get to keep all the pieces
>> because they have already broken the expectations of Reserved 0
>> compat-software created before 9 existed.
> 
> True, but a compliance test should have dealt with that (seems they
> are yet to catch up with this though).
> 
> Jonathan
> 

