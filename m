Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B0C001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjGMPoZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjGMPoS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 11:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FA272C
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689263007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLikHNWVNU/FNpgKCSfkRGEY/lyXivfIFOAmn8fr+kQ=;
        b=IZSiiFlLGWQ1NXEcLRUDoX0ot1ss1BfvfMwit3xYxyUw/Q/TOQKzJpYqPsTPQ1Qh9BH1LE
        gWjdEm4F4Ahp+OotnH20PPvhwUBnrDbhfRCmpTpxLGA2V+pV5ZJL3L/EcusmL4AVaD8cP+
        41BkKvrVPkl8IOCxIsToefx0cRpLC3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-ebb5AjowNMuKSu2tZGxTcA-1; Thu, 13 Jul 2023 11:43:26 -0400
X-MC-Unique: ebb5AjowNMuKSu2tZGxTcA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315af0252c2so627828f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 08:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263005; x=1691855005;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLikHNWVNU/FNpgKCSfkRGEY/lyXivfIFOAmn8fr+kQ=;
        b=Kh5/dQWm/799ja5Z4rYbtcHPZUVzfLhrgKq1GhtZl7wbyAMbCTgXRrlieC2q5Km9pg
         yYCh69fznI1F6Wwuf8EEzeYB0dns2Iv2hsHaOtEt/ZvNrCw9/4YCta8il0tQCA2vwOBC
         aKQA0tXlVffNud2FI4Cyjo1equvO5zL+l1rutH0CKWTA6c0i5WSiE9J0Yd4tw8rFh0Jv
         ExHyD/x3GR9lET3qp+L+N+yZ4ZMFNjblmzd3LuNPEboBu6KOXV0rGrToez//1SDnr2d8
         OxrQ8FvDyg6CmDwO5p0P5EzxZ7StO0WWT4TBRddr2DlujpGGPtbkZ1YoTbQNoH+YiEOl
         7m0Q==
X-Gm-Message-State: ABy/qLaESaH1KtrHw0QhgoL+MNKSzOq57k4Qa7xLMdHW20UvJ6UhfFa9
        evt6b7EG/Z6S/joezOXUA78PPjFQj6Brv9Vu4xMHbsXQ2+oUwYIlZ0WoymL7iIlksR/cBwRdgK9
        ko3wbskfeQMV2Ovgr1O5Y
X-Received: by 2002:adf:e681:0:b0:313:f4e2:901d with SMTP id r1-20020adfe681000000b00313f4e2901dmr2049839wrm.22.1689263004840;
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1/YUAbO+tUpcHHd06mVmoTHYbiWHrgz1Hqa9kz78W45sfnOZ2occ1rxo5df7lIzOiCn/o3Q==
X-Received: by 2002:adf:e681:0:b0:313:f4e2:901d with SMTP id r1-20020adfe681000000b00313f4e2901dmr2049814wrm.22.1689263004497;
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b002c70ce264bfsm8285044wru.76.2023.07.13.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:43:24 -0700 (PDT)
Message-ID: <de39c555-e092-8e57-43a4-7a2c56d1e66c@redhat.com>
Date:   Thu, 13 Jul 2023 17:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
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
 <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
 <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
 <80c8654e-21fb-b187-3475-9a1410a53a4e@redhat.com>
 <b62572356db07ae0c3305ed03916b0ff40b14426.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b62572356db07ae0c3305ed03916b0ff40b14426.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 13.07.23 17:40, Verma, Vishal L wrote:
> On Thu, 2023-07-13 at 17:23 +0200, David Hildenbrand wrote:
>> On 13.07.23 17:15, Verma, Vishal L wrote:
>>> On Thu, 2023-07-13 at 09:23 +0200, David Hildenbrand wrote:
>>>> On 13.07.23 08:45, Verma, Vishal L wrote:
>>>>>
>>>>> I'm taking a shot at implementing the splitting internally in
>>>>> memory_hotplug.c. The caller (kmem) side does become trivial with this
>>>>> approach, but there's a slight complication if I don't have the module
>>>>> param override (patch 1 of this series).
>>>>>
>>>>> The kmem diff now looks like:
>>>>>
>>>>>       diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>       index 898ca9505754..8be932f63f90 100644
>>>>>       --- a/drivers/dax/kmem.c
>>>>>       +++ b/drivers/dax/kmem.c
>>>>>       @@ -105,6 +105,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>               data->mgid = rc;
>>>>>        
>>>>>               for (i = 0; i < dev_dax->nr_range; i++) {
>>>>>       +               mhp_t mhp_flags = MHP_NID_IS_MGID | MHP_MEMMAP_ON_MEMORY |
>>>>>       +                                 MHP_SPLIT_MEMBLOCKS;
>>>>>                       struct resource *res;
>>>>>                       struct range range;
>>>>>        
>>>>>       @@ -141,7 +143,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>                        * this as RAM automatically.
>>>>>                        */
>>>>>                       rc = add_memory_driver_managed(data->mgid, range.start,
>>>>>       -                               range_len(&range), kmem_name, MHP_NID_IS_MGID);
>>>>>       +                               range_len(&range), kmem_name, mhp_flags);
>>>>>        
>>>>>                       if (rc) {
>>>>>                               dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>>>>>       
>>>>>
>>>>
>>>> Why do we need the MHP_SPLIT_MEMBLOCKS?
>>>
>>> I thought we still wanted either an opt-in or opt-out for the kmem
>>> driver to be able to do memmap_on_memory, in case there were
>>> performance implications or the lack of 1GiB PUDs. I haven't
>>> implemented that yet, but I was thinking along the lines of a sysfs
>>> knob exposed by kmem, that controls setting of this new
>>> MHP_SPLIT_MEMBLOCKS flag.
>>
>> Why is MHP_MEMMAP_ON_MEMORY not sufficient for that?
>>
>>
> Ah I see what you mean now - knob just controls MHP_MEMMAP_ON_MEMORY,
> and memory_hotplug is free to split to memblocks if it needs to to
> satisfy that.

And if you don't want memmap holes in a larger area you're adding (for 
example to runtime-allocate 1 GiB pages), simply check the size your 
adding, and if it's, say, less than 1 G, don't set the flag.

But that's probably a corner case use case not worth considering for now.

> 
> That sounds reasonable. Let me give this a try and see if I run into
> anything else. Thanks David!

Sure!

-- 
Cheers,

David / dhildenb

