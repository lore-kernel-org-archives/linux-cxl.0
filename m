Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F221105
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741828; cv=none; b=uTI0bhrpDPLzxF+VG88/JyVkfgla1ixXwoAShUeMdFoFwH4Lql6YSWd1pAGrvuIzC3fUK8QD+BcRDPFj+NeIJ8l8OOmVwCUpdMcrmnej9TDH3jwpRgTRqvwQMK3p3rFwfMgSafujXcrpXW8Uq4uvBvHtMl8sbwPxozg+knu7014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741828; c=relaxed/simple;
	bh=DM1Ad+3/XOzbM8DUWuV0+UyVRehYzVSt9wNZEFw74Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9dib/JCYsSqrFCxLWSAHxZTsN42iDG24f2XGw0bUSjh96Xs/ZygY/Ff1cGIvc98NeRMe6Wg+WjsdudJiweBi2dhC3VBh5Bs/+Kbop9WX6j3YIAlG6ImWSzs70z4ASTZETlGnJcZjRTGuIh4+8mFRgiKVXM6Lwz1GIdNimgozCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTYno7Pi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTYno7Pi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723741825; x=1755277825;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DM1Ad+3/XOzbM8DUWuV0+UyVRehYzVSt9wNZEFw74Ao=;
  b=WTYno7PizdDGxLLc+SjmbTI9oaiPI5pOVrOpoBx2IgAUTEW/g5hyiNBD
   4B85+vmYSumnAryX9wqwoapA0uUZBgMTDyajX2W5C7WDJpqbtHApXZSze
   gpul0c+pn1eDbZBE7l3Qyga+od+VAvm+47UY7oTD3XDFlayjOFQcBYsb3
   n3N8hU2iDZ9Vn5Wv8gvy2AhIoJTRF16i3LEp1dwF8qLEk+/bCVxmCvh3l
   IxGFEzYBj58AqfpvrJqz0rdSiBQJjl7pdeqjdnZHGVHwpKZGt51BULK0p
   ocPulVH/MvhUzXCo3SzgzVH4pXaCvDssijTIO+ZjpQd4m7TFgOdFzMJyr
   w==;
X-CSE-ConnectionGUID: fXdPm1caRPOX6CVdhk2r1A==
X-CSE-MsgGUID: /u7r3fGDSuOeXIjyooZZkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22172879"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="22172879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 10:10:25 -0700
X-CSE-ConnectionGUID: oDp4VeDCSm2R1h4SRFMVdg==
X-CSE-MsgGUID: QoIdco4PTdWQmcNUh/bcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59088936"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.215]) ([10.125.110.215])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 10:10:24 -0700
Message-ID: <01c6f57b-a969-444f-b409-e46e68d4850f@intel.com>
Date: Thu, 15 Aug 2024 10:10:23 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240815175745.000041cc@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/15/24 9:57 AM, Jonathan Cameron wrote:
> On Wed, 24 Jul 2024 11:55:16 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>> it. This allows isolation of all CXL mailbox data in order to export
>> some of the calls to external callers and avoid exporting of CXL driver
>> specific bits such has device states. The allocation of
>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
>> mailbox can be created independently.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave,
> 
> Mostly good, but cxl_mailbox_create() needs another look.
> Feels like a bit of cut and paste gone too far ;)
> 
> I'm not entirely convinced it shouldn't just remain embedded in
> the parent structure with create replace with just an init()
> function.  I don't mind that much though.

I made it a pointer to deal with something like a type2 device without mailbox at all. So I feel like it needs to stand on its own.... but are you saying we should just keep it as an embedded struct in the device context whether a mailbox exists or not?

Also, probably need to start thinking about this. Once PCIe MMIO mailbox shows up, we will want to move the register pointer into the mailbox as well to make it independent and having a shared struct between CXL and PCIe. It'll probably end up looking like:

struct cxl_mailbox {
	struct mmio_mailbox mbox;
}; 

> 
> Jonathan
> 
> 
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..9501d2576ccd 100644
> 
> 
>> @@ -1408,6 +1454,34 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>  
>> +static void free_cxl_mailbox(void *cxl_mbox)
>> +{
>> +	kfree(cxl_mbox);
>> +}
>> +
>> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev)
>> +{
>> +	struct cxl_mailbox *cxl_mbox __free(kfree) =
>> +		kzalloc(sizeof(*cxl_mbox), GFP_KERNEL);
> This is not somewhere I'd use the __free magic, because
> failure to create a mailbox is very likely fatal and doing
> so requires the dance with devm_add_action_or_reset() to
> just free a structure.
> 
> So I'd just use devm_kzalloc()
> and rely on caller to fail probe() or if not to do manual
> cleanup of the structure.
> 
> There aren't any failure paths currently where the auto cleanup
> gets used anyway other than the devm_add_action_or_reset()
> which is not using auto cleanup anyway.
> 
>> +	int rc;
>> +
>> +	if (!cxl_mbox)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxl_mbox->host = dev;
>> +	mutex_init(&cxl_mbox->mbox_mutex);
>> +	rcuwait_init(&cxl_mbox->mbox_wait);
>> +
>> +	rc = devm_add_action_or_reset(dev, free_cxl_mailbox, cxl_mbox);
>> +	if (rc) {
>> +		cxl_mbox = NULL;
> Non obvious as that's a suppression of what would otherwise
> be a double free.  Having to do this rather defeats the point
> of the simplification __free normally brings.
> 
>> +		return ERR_PTR(rc);
>> +	}
>> +
>> +	return no_free_ptr(cxl_mbox);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_create, CXL);
