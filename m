Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCEAC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjGMHZJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjGMHYx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 03:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF226B9
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689233007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgHHNUMQekCLPFyLoFSxMBSAfdXYCTsaZ05jN1ABgoY=;
        b=aoZqzl3+ZAwf6X+7CwmSRnD0nqaHNS0pXHY5LP/SNgISdpAYXTL/fr6Tp0nQkViAYZo1AI
        qSV8P7/vd+rn3cWNOH76syWLz7JddRCo75buZQdb0J4IeqBDnEYqvK/dkuO3l9zb+vg1Wl
        He82lwGbgZDKRhi8FHw9jXfEnEdRPLQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-SfoRbl7XOra6HzioCq7jgA-1; Thu, 13 Jul 2023 03:23:26 -0400
X-MC-Unique: SfoRbl7XOra6HzioCq7jgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbcae05906so1690245e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 00:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689233005; x=1691825005;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgHHNUMQekCLPFyLoFSxMBSAfdXYCTsaZ05jN1ABgoY=;
        b=cfqgalIBPz+G1wU2w75D72y/QHaHSTqkccv8zbgTKRlOF0/cX61NwidmP3m/QhECXC
         Ps6dGUxbWjU6nIE34p/P0HrYl4c8t1JAlevGWwu0DarSaGxqGtsCDYurvMGtC80DVzBS
         yyEqJxTiXhps2ySfU1D8JAwklQeaSUeGlQSJwFrLgllUxnQUcTSg3rLn9Up/BUzWlSzD
         1azo7FyK+L+3pGdSC7BXIYHfm7ommy4Q780jMj4fmGHJ8ZzlUFpLAw801HovnW7Hs8Ae
         /pkdKmcTGTvDxUiRoyYDw2P4Nmj0hW17GVqaYv3gbbHN6F1kFFz4gJCecEC3c0KyYT6G
         JtIw==
X-Gm-Message-State: ABy/qLZoHEn0eBGERsu32DWJil3jOCz5CrpM9hRKxZGe4xZc5dSS08be
        J7X1MbIPwRsmWZA9ymlmTc5rPr3xvzN9t0rBDE+zEoZj6P2L49lsqvQ5gzX4UfH9CW/cZTB60n0
        ePejAHPboYh97VDSuyx21
X-Received: by 2002:a7b:c8cf:0:b0:3fa:984d:7e99 with SMTP id f15-20020a7bc8cf000000b003fa984d7e99mr700221wml.22.1689233004717;
        Thu, 13 Jul 2023 00:23:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHp1Dof1hZ5eLgX91wy7JzHUlL7TjMzwPfLhPZe9l5XN/YJjOHJ27klX1+mumUVy1mVfYk1Q==
X-Received: by 2002:a7b:c8cf:0:b0:3fa:984d:7e99 with SMTP id f15-20020a7bc8cf000000b003fa984d7e99mr700199wml.22.1689233004294;
        Thu, 13 Jul 2023 00:23:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003fc01f7b415sm15246910wme.39.2023.07.13.00.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:23:23 -0700 (PDT)
Message-ID: <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
Date:   Thu, 13 Jul 2023 09:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
 <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
 <87edleplkn.fsf@linux.ibm.com>
 <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
 <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
In-Reply-To: <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 13.07.23 08:45, Verma, Vishal L wrote:
> On Tue, 2023-07-11 at 17:21 +0200, David Hildenbrand wrote:
>> On 11.07.23 16:30, Aneesh Kumar K.V wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>> Maybe the better alternative is teach
>>>> add_memory_resource()/try_remove_memory() to do that internally.
>>>>
>>>> In the add_memory_resource() case, it might be a loop around that
>>>> memmap_on_memory + arch_add_memory code path (well, and the error path
>>>> also needs adjustment):
>>>>
>>>>          /*
>>>>           * Self hosted memmap array
>>>>           */
>>>>          if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>>>>                  if (!mhp_supports_memmap_on_memory(size)) {
>>>>                          ret = -EINVAL;
>>>>                          goto error;
>>>>                  }
>>>>                  mhp_altmap.free = PHYS_PFN(size);
>>>>                  mhp_altmap.base_pfn = PHYS_PFN(start);
>>>>                  params.altmap = &mhp_altmap;
>>>>          }
>>>>
>>>>          /* call arch's memory hotadd */
>>>>          ret = arch_add_memory(nid, start, size, &params);
>>>>          if (ret < 0)
>>>>                  goto error;
>>>>
>>>>
>>>> Note that we want to handle that on a per memory-block basis, because we
>>>> don't want the vmemmap of memory block #2 to end up on memory block #1.
>>>> It all gets messy with memory onlining/offlining etc otherwise ...
>>>>
>>>
>>> I tried to implement this inside add_memory_driver_managed() and also
>>> within dax/kmem. IMHO doing the error handling inside dax/kmem is
>>> better. Here is how it looks:
>>>
>>> 1. If any blocks got added before (mapped > 0) we loop through all successful request_mem_regions
>>> 2. For each succesful request_mem_regions if any blocks got added, we
>>> keep the resource. If none got added, we will kfree the resource
>>>
>>
>> Doing this unconditional splitting outside of
>> add_memory_driver_managed() is undesirable for at least two reasons
>>
>> 1) You end up always creating individual entries in the resource tree
>>      (/proc/iomem) even if MHP_MEMMAP_ON_MEMORY is not effective.
>> 2) As we call arch_add_memory() in memory block granularity (e.g., 128
>>      MiB on x86), we might not make use of large PUDs (e.g., 1 GiB) in the
>>      identify mapping -- even if MHP_MEMMAP_ON_MEMORY is not effective.
>>
>> While you could sense for support and do the split based on that, it
>> will be beneficial for other users (especially DIMMs) if we do that
>> internally -- where we already know if MHP_MEMMAP_ON_MEMORY can be
>> effective or not.
> 
> I'm taking a shot at implementing the splitting internally in
> memory_hotplug.c. The caller (kmem) side does become trivial with this
> approach, but there's a slight complication if I don't have the module
> param override (patch 1 of this series).
> 
> The kmem diff now looks like:
> 
>     diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>     index 898ca9505754..8be932f63f90 100644
>     --- a/drivers/dax/kmem.c
>     +++ b/drivers/dax/kmem.c
>     @@ -105,6 +105,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>             data->mgid = rc;
>      
>             for (i = 0; i < dev_dax->nr_range; i++) {
>     +               mhp_t mhp_flags = MHP_NID_IS_MGID | MHP_MEMMAP_ON_MEMORY |
>     +                                 MHP_SPLIT_MEMBLOCKS;
>                     struct resource *res;
>                     struct range range;
>      
>     @@ -141,7 +143,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>                      * this as RAM automatically.
>                      */
>                     rc = add_memory_driver_managed(data->mgid, range.start,
>     -                               range_len(&range), kmem_name, MHP_NID_IS_MGID);
>     +                               range_len(&range), kmem_name, mhp_flags);
>      
>                     if (rc) {
>                             dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>     
> 

Why do we need the MHP_SPLIT_MEMBLOCKS?

In add_memory_driver_managed(), if memmap_on_memory = 1 AND is effective for a
single memory block, you can simply split up internally, no?

Essentially in add_memory_resource() something like

if (mhp_flags & MHP_MEMMAP_ON_MEMORY &&
     mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
	for (cur_start = start, cur_start < start + size;
	     cur_start += memory_block_size_bytes()) {
		mhp_altmap.free = PHYS_PFN(memory_block_size_bytes());
		mhp_altmap.base_pfn = PHYS_PFN(start);
		params.altmap = &mhp_altmap;

		ret = arch_add_memory(nid, start,
				      memory_block_size_bytes(), &params);
		if (ret < 0) ...

		ret = create_memory_block_devices(start, memory_block_size_bytes(),
						  mhp_altmap.alloc, group);
		if (ret) ...
		
	}
} else {
	/* old boring stuff */
}

Of course, doing it a bit cleaner, factoring out adding of mem+creating devices into
a helper so we can use it on the other path, avoiding repeating memory_block_size_bytes()
...

If any adding of memory failed, we remove what we already added. That works, because as
long as we're holding the relevant locks, memory cannot get onlined in the meantime.

Then we only have to teach remove_memory() to deal with individual blocks when finding
blocks that have an altmap.

-- 
Cheers,

David / dhildenb

