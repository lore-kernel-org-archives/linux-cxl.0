Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82913B293
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795289; cv=none; b=DfH3P7/CF95z1xdNHpR7laX+WhUkdU1Y/YSuP+xiNt1ChBShj+jK9TTCuBXOUliGs14YyU1Vr5fep+7sgD2Tklh/j1Vrh/B3URXtlZpmRqCEa/Z1/tEFoeJHV9jfV6dFpCZoCp0MHKIztYkHkQ++mu9ndN+cwSi7cD0yagb8nEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795289; c=relaxed/simple;
	bh=vhPK7SZXKEs7fq0jNA5F1BqQRSF+ZJgFmFgBLAJfg3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfq/SlSuDxMLFqIdhYYhYB22dXsp9Kh718p77w2eU9kugAq+SD9xUmK3/nnNgIGZ8Ge2QGbh+HeqPhIQZPgowJPi4F8dyGPLpg/V76+MLrp4VUh2qRbY6ps4jlfIGhcaTv1YBeC0hHU2SOIAiHfiS1NnKbDU5U8r1XVLVXQil7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9sMg+8a; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9sMg+8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724795287; x=1756331287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vhPK7SZXKEs7fq0jNA5F1BqQRSF+ZJgFmFgBLAJfg3A=;
  b=T9sMg+8azOOc5RdddgRAhTl0NBMRg6ZvSHyGj4cw2bw8rgW5GWtFYR0D
   rbOeorsu6S/90Fk3eyQFZxovyoh6wRvsiFbF51or8a9elqVsXIOssnTps
   3vq+Ez23DoMFjAedog2Bncxse7eMqEVIEa7CgjTv1q6f1BZEypOfGF6GL
   Q1sZjM7GAFcgYvwS1TFbYQ/oeZHCJ6KyxKjYXR9qVBiLcazjs4rwpE6bG
   rdnX0UhOKfGwDdySSOMmVRsmQADWuRbzsznll3Q6RlzV5cI7dX04w9H2J
   Gm/Sd6uzcWQbZHz64hGTtmJjF4HvbWjkgEpFyufv0pHIt+5DS01z78ra4
   A==;
X-CSE-ConnectionGUID: RqpslxgCRne1/UZ2S4y3iA==
X-CSE-MsgGUID: UB6Km3VSQOGvbp2oNS8Gxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23167413"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23167413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:48:06 -0700
X-CSE-ConnectionGUID: sgpVKWIbQuigWxyDfWIFoQ==
X-CSE-MsgGUID: 9V207tBoSIOxTohWVqeQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="100526201"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:48:06 -0700
Message-ID: <08321fa3-9738-428d-964a-63cdd6c06aad@intel.com>
Date: Tue, 27 Aug 2024 14:48:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl: Move mailbox related bits to the same context
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net
References: <20240724185649.2574627-1-dave.jiang@intel.com>
 <20240724185649.2574627-2-dave.jiang@intel.com>
 <20240815175745.000041cc@Huawei.com>
 <01c6f57b-a969-444f-b409-e46e68d4850f@intel.com>
 <20240827162716.00001c2a@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240827162716.00001c2a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/24 8:27 AM, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 10:10:23 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 8/15/24 9:57 AM, Jonathan Cameron wrote:
>>> On Wed, 24 Jul 2024 11:55:16 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>>>> it. This allows isolation of all CXL mailbox data in order to export
>>>> some of the calls to external callers and avoid exporting of CXL driver
>>>> specific bits such has device states. The allocation of
>>>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
>>>> mailbox can be created independently.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
>>> Hi Dave,
>>>
>>> Mostly good, but cxl_mailbox_create() needs another look.
>>> Feels like a bit of cut and paste gone too far ;)
>>>
>>> I'm not entirely convinced it shouldn't just remain embedded in
>>> the parent structure with create replace with just an init()
>>> function.  I don't mind that much though.  
>>
>> I made it a pointer to deal with something like a type2 device without mailbox at all. So I feel like it needs to stand on its own.... but are you saying we should just keep it as an embedded struct in the device context whether a mailbox exists or not?
> 
> It can be optional for a given driver, so type 3 just embeds
> it, a type 2 with the support also embeds and init() the mailbox.
> A type 2 without doesn't embed it in the driver specific structures
> and obviously doesn't init what it doesn't have.

I'll push out a v2 with it embedded. If Alejandro doesn't mind the churn.

DJ

> 
> So just like a mutex inside a driver specific struct
> and similar things.
>>
>> Also, probably need to start thinking about this. Once PCIe MMIO mailbox shows up, we will want to move the register pointer into the mailbox as well to make it independent and having a shared struct between CXL and PCIe. It'll probably end up looking like:
>>
>> struct cxl_mailbox {
>> 	struct mmio_mailbox mbox;
>> }; 
> Yeah. I'd expect a nest like this with container_of() magic used where
> appropriate to get to the parents and probably a few callbacks
> set in the mbox to tie everything together.
> 
> Jonathan
> 
>>
>>>
>>> Jonathan
>>>
>>>   
>>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>>> index 2626f3fff201..9501d2576ccd 100644  
>>>
>>>   
>>>> @@ -1408,6 +1454,34 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>>>  
>>>> +static void free_cxl_mailbox(void *cxl_mbox)
>>>> +{
>>>> +	kfree(cxl_mbox);
>>>> +}
>>>> +
>>>> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev)
>>>> +{
>>>> +	struct cxl_mailbox *cxl_mbox __free(kfree) =
>>>> +		kzalloc(sizeof(*cxl_mbox), GFP_KERNEL);  
>>> This is not somewhere I'd use the __free magic, because
>>> failure to create a mailbox is very likely fatal and doing
>>> so requires the dance with devm_add_action_or_reset() to
>>> just free a structure.
>>>
>>> So I'd just use devm_kzalloc()
>>> and rely on caller to fail probe() or if not to do manual
>>> cleanup of the structure.
>>>
>>> There aren't any failure paths currently where the auto cleanup
>>> gets used anyway other than the devm_add_action_or_reset()
>>> which is not using auto cleanup anyway.
>>>   
>>>> +	int rc;
>>>> +
>>>> +	if (!cxl_mbox)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	cxl_mbox->host = dev;
>>>> +	mutex_init(&cxl_mbox->mbox_mutex);
>>>> +	rcuwait_init(&cxl_mbox->mbox_wait);
>>>> +
>>>> +	rc = devm_add_action_or_reset(dev, free_cxl_mailbox, cxl_mbox);
>>>> +	if (rc) {
>>>> +		cxl_mbox = NULL;  
>>> Non obvious as that's a suppression of what would otherwise
>>> be a double free.  Having to do this rather defeats the point
>>> of the simplification __free normally brings.
>>>   
>>>> +		return ERR_PTR(rc);
>>>> +	}
>>>> +
>>>> +	return no_free_ptr(cxl_mbox);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_create, CXL);  
>>
> 
