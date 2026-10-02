Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCE253340;
	Fri,  2 Oct 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956535; cv=none; b=bnKXxC+g7Ghn4GDN7fAMzSuglPmqfD0PRzEvsGW3B4aUy/YQ+wboxRLJlDY1Q+qWOaaFRK0jYhW4CmjdshkaDlXDhaRTN+lMvY9elBdtGLEwTqk/b/E73LjZFijnsmkb7wtSc0bfVkzHTfDo5ClEfw5KDtoHV8sHbX5O5YUl/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956535; c=relaxed/simple;
	bh=aHWgelLbqeJUTcWOhhTtpnFYbexepIwgPhAEhUjr8uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbTCkBlKQj/hFFZpHEApj0khWiM6BmP5qmNpBTB6n9M7lG6d9g6fUFlQBDTcvkPWhTZ5TkQgJLGvqyFi7+uFVYlpKb2DJgMOAZkzyZ/xmJ49ndYFPHUggLomqu32VCOmO2a7b2QjyCn8mtiUYPaWD6JUKfjht/+22gR5ThEMRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrJUBVOk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrJUBVOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790956533; x=1822492533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHWgelLbqeJUTcWOhhTtpnFYbexepIwgPhAEhUjr8uo=;
  b=SrJUBVOkMProzKOB55t1lPuz1He7r3Gohf3h9RfNu1wEcLpZTBT0sfoP
   ZpkI9zviAzM9HkLK2rZh1mptNxwDlnqpRrk01EfjTiMiCO4f2eTdZ4pX/
   0pwQReddNo0TA4xyJRvOjhnkaJ6Ay1hfdJzL18YpIGkEMR7g5XS+1Dh1/
   2f9AQnFFkDZgtpMwU+M5jveBjimQf5hbDY8lJDIlGUitSlc58Pj0ZzZK1
   ztsW1C4/P2mctMlCVQfNM8M8DWxHFM7psJGAcbaQPw7D8DCfbV71jzF/B
   nP08JW0CN49sJw0R6eiu7e7SlZnnESupXW1x4zZs70a6FE7mRW++iR2Rz
   A==;
X-CSE-ConnectionGUID: Htuy1obxTmGAfHnkui5fDA==
X-CSE-MsgGUID: 6T6FKPuPTBGcFsY9kAoMsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="113506439"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113506439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:55:33 -0700
X-CSE-ConnectionGUID: pyp3wJ7YT3eCgKhZeJRivQ==
X-CSE-MsgGUID: ov8B0C0KSeO4mOJ59Vdv0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="305776642"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:55:32 -0700
Message-ID: <4ab750ab-ccae-4ba5-9b1f-ad7296ed2547@intel.com>
Date: Fri, 2 Oct 2026 08:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-4-alucerop@amd.com>
 <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
 <cd70c229-0fc6-4259-870f-5bdd6f5a020a@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cd70c229-0fc6-4259-870f-5bdd6f5a020a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/1/26 9:50 PM, Lucero Palau, Alejandro wrote:
> 
> On 01/10/2026 23:11, Dave Jiang wrote:
>>
>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>>> specs restrict to the first one, PF0, the discovery and management of
>>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>>> obtain the CXL.mem range to work with somehow.
>>>
>>> Add a device link between the cxl region a PF0 memdev is attached to and
>>> the non-PF0 wanting to use the CXL region. A CXL region release will
>>> trigger such a PF to be released from its driver first.
>>>
>>> PF0 being unbound from its driver triggers memdev and region release
>>> leading to non-PF0s being unbound first keeping the CXL memory use safe.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 92 +++++++++++++++++++++++++++++++++++++++
>>>   include/cxl/cxl.h         |  2 +
>>>   2 files changed, 94 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index b3419df586b9..799cb6e75639 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>>       return ERR_PTR(rc);
>>>   }
>>>   +static int match_memdev_by_parent_device(struct device *dev, const void *data)
>>> +{
>>> +    const struct device *pf_dev = data;
>>> +    struct cxl_memdev *cxlmd;
>>> +
>>> +    if (!is_cxl_memdev(dev))
>>> +        return 0;
>>> +
>>> +    cxlmd = to_cxl_memdev(dev);
>>> +    return (cxlmd->cxlds->dev == pf_dev);
>> cxlmd->cxlds can be NULL? How about just do dev->parent == pf_dev instead?
> 
> 
> Not for a type2 memdev. This function should only used inside the next one. Maybe it is worth a comment.
> 
> 
>>> +}
>>> +
>>> +static int __cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>>> +                    struct range *range)
>>> +{
>>> +    struct device *mem_dev __free(put_device) =
>>> +        bus_find_device(&cxl_bus_type, NULL, pf0,
>>> +                match_memdev_by_parent_device);
>>> +    struct cxl_attach_region *attach;
>>> +    struct cxl_memdev *cxlmd;
>>> +
>>> +    if (!mem_dev)
>>> +        return -ENODEV;
>>> +
>>> +    cxlmd = to_cxl_memdev(mem_dev);
>>> +    attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
>> Probably not likely for a type2 device, but is there any possibility that attach == NULL?
> 
> 
> As explained in my reply to your patch2 concern,  this can not happen due to the device locking. If the memdev is there, the attach is there. All that happens at PF0 initialization, with the PF0 device locked. With the locking gone, memdev+attach do exist or they do not.
> 
>>> +
>>> +    /*
>>> +     * The cxlmd object does exist and it can be found in the cxl bus after
>>> +     * creation but before attach probe setting the proper HPA range. If so,
>>> +     * the caller will need to try later.
>>> +     */
>>> +    if (attach->hpa_range.end == CXL_RESOURCE_NONE)
>>> +        return -EPROBE_DEFER;
>>
>> Maybe you'll need something like this below to ensure that the region is valid still. And you can drop the above with the below code.
>>
>>        scoped_guard(rwsem_read, &cxl_rwsem.region) {
>>                cxlr = READ_ONCE(attach->cxlr);
>>                if (!cxlr)
>>                        return -EPROBE_DEFER;
>>                get_device(&cxlr->dev);
>>        }
>>        struct device *region_dev __free(put_device) = &cxlr->dev;
>>
>>        /*
>>         * Region deletion holds regions_lock across xa_erase() and device_del().
>>         * Being in the xarray under regions_lock means the region is still
>>         * registered, and a link added now is torn down by its deletion. Drop
>>         * cxl_rwsem.region above first: regions_lock nests outside it.
>>         */
>>        cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>        guard(mutex)(&cxlrd->regions_lock);
>>        if (xa_load(&cxlrd->regions, cxlr->id) != cxlr)
>>                return -ENODEV;
>>
>>        /* A decommit releases the region driver after dropping the rwsem */
>>        guard(rwsem_read)(&cxl_rwsem.region);
>>        if (cxlr->params.state != CXL_CONFIG_COMMIT)
>>                return -ENODEV;
> 
> 
> Because what I explained before, with the device locking and the region only disappearing at PF0 release  which holds the device lock, I do not think this finer concurrency protection is needed.

See my response to patch 2.

DJ

> 
> 
> Thank you,
> 
> Alejandro.
> 
> 
>> DJ
>>
>>> +
>>> +    /*
>>> +     * Create the device link between the region and the consumer device.
>>> +     * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
>>> +     * consumer unbinds first with no consequences for the supplier.
>>> +     */
>>> +    if (!device_link_add(pfx, &attach->cxlr->dev,
>>> +                 DL_FLAG_AUTOREMOVE_CONSUMER)) {
>>> +        dev_err(pfx, "device link creation failed\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    range->start = attach->hpa_range.start;
>>> +    range->end = attach->hpa_range.end;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * cxl_get_range_and_link - register a device link with the region PF0 memdev
>>> + * is attached to. The region release will imply the link consumer to be unbound
>>> + * from its driver first. Return the cxl region range to work with related to
>>> + * PF0 memdev initialization.
>>> + *
>>> + * @pf0: device to use for finding target memdev and supplier for the link
>>> + * @pfx: device to link to PF0's memdev region, the link consumer.
>>> + * @range: to be set with the PF0's memdev attach region range.
>>> + *
>>> + * Return: 0 or error.
>>> + */
>>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>>> +               struct range *range)
>>> +{
>>> +    int rc;
>>> +
>>> +    if (!pf0 || !pfx)
>>> +        return -EINVAL;
>>> +
>>> +    /*
>>> +     * PF0 cxl memdev once created and region attached can only be removed
>>> +     * when PF0 unbinds from its driver which implies to obtain the device
>>> +     * lock before the unwinding starts. If this call from other PF races
>>> +     * with such unbinding:
>>> +     *
>>> +     * 1) if this next lock is obtained first, the device link is
>>> +     *    created and the later unwinding will trigger consumer (PF
>>> +     *    calling here) unbinding first.
>>> +     *
>>> +     *  2) if it is the unbinding the one getting the lock first, the
>>> +     *    memdev will not be there aymore.
>>> +     */
>>> +    device_lock(pf0);
>>> +    rc = __cxl_get_range_and_link(pf0, pfx, range);
>>> +    device_unlock(pf0);
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_range_and_link, "CXL");
>>> +
>>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>>                      unsigned long arg)
>>>   {
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 802b143de83d..b28dce1f6f76 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -228,4 +228,6 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>>                         struct range *range);
>>>     int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>>> +               struct range *range);
>>>   #endif /* __CXL_CXL_H__ */

