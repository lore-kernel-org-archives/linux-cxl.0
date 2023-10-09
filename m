Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41D358AA
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLXfk4Ei"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183E10CA
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696864543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxbkxsdepLAwI//Nw1rXTrNsOKPrZ+J+qWsPA89lw+E=;
	b=eLXfk4EiO6rPrDkPGAZJWgUcDa1WjtTK9zyH0+VPq3Ct4rqc8AhkXOGyCCPkGVzlVP5RwT
	LA+KP5C/FxsGE9OthZGgziH+CtXN1/fxz2v6QTxfWTa54i6dhIFPtT3S5HREfB8NlX2WGO
	v5RgU+dUnx9ZnfnlcJgXZL85TWVCVyY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-G7udroy4NOqlI9aSDS4EAA-1; Mon, 09 Oct 2023 11:15:42 -0400
X-MC-Unique: G7udroy4NOqlI9aSDS4EAA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3232c3df248so2913096f8f.3
        for <linux-cxl@vger.kernel.org>; Mon, 09 Oct 2023 08:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864541; x=1697469341;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxbkxsdepLAwI//Nw1rXTrNsOKPrZ+J+qWsPA89lw+E=;
        b=kC8KFM4Y7oIEv64RwimDwXL0mJIQKVfYrUGGuBPe9pJoDtDHt1EeM1c2uPhQJskR8B
         eQmpCB45q3WwQAYt17mIhrUz5O+skbsjeAIsjxj5QyZBLBRw+vPa2GX2fPnxyqgVNXg7
         x+V1bQe+KorPv6oNVJs+t62jmeJZq7fnvgyuzrgj56gxuNaPOXSa2Q3b2Lm6lNGXXm9E
         XcdfoSeu+0KZuSObsD8mYkx8aqq+zEwohEumHsh/MwZZgSKdoLGGgIRtUgFycKdTtEDo
         UFyTJbFzaOg13scslC/gqYlaf9uG9Ofs9dDm3R50sp6mAGDPRWkg1GFDj5/kWtQf7aSD
         fuyA==
X-Gm-Message-State: AOJu0YySkRvvmZ61YZ9phEDseM4goGWXr/ORq9J3Q47W8qSxlaarQ9DI
	m9qN0qWhdu/SaQvyTUZmta+awK36b0EazvI1mFMSMjs7sFc4VklAlnTpR6W8HJCO024AvQuA/uW
	f/9VrxUH3KxSgLjbSeU0v
X-Received: by 2002:a5d:4942:0:b0:323:1a0c:a5e0 with SMTP id r2-20020a5d4942000000b003231a0ca5e0mr13395346wrs.13.1696864541275;
        Mon, 09 Oct 2023 08:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7b2lwzlp+uSM9hiBU+z/Mq/3Q8Bio+XwSc3ICD2i4PuZSt2i99eOmikwZ+NaXx3+BddMdfQ==
X-Received: by 2002:a5d:4942:0:b0:323:1a0c:a5e0 with SMTP id r2-20020a5d4942000000b003231a0ca5e0mr13395322wrs.13.1696864540855;
        Mon, 09 Oct 2023 08:15:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm9921911wrm.64.2023.10.09.08.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 08:15:40 -0700 (PDT)
Message-ID: <0bc29e93-7efe-4bce-ee3f-1fdf76104843@redhat.com>
Date: Mon, 9 Oct 2023 17:15:39 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "osalvador@suse.de"
 <osalvador@suse.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Huang, Ying" <ying.huang@intel.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "Hocko, Michal" <mhocko@suse.com>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "jmoyer@redhat.com" <jmoyer@redhat.com>,
 "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
 <4ad40b9b-086b-e31f-34bd-c96550bb73e9@redhat.com>
 <45cfd268da63eeddb741e9c9c3026b0e15eade4b.camel@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
In-Reply-To: <45cfd268da63eeddb741e9c9c3026b0e15eade4b.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07.10.23 00:01, Verma, Vishal L wrote:
> On Fri, 2023-10-06 at 14:52 +0200, David Hildenbrand wrote:
>> On 05.10.23 20:31, Vishal Verma wrote:
>>>
> <..>
>>> @@ -2167,47 +2221,28 @@ static int __ref try_remove_memory(u64 start, u64 size)
>>>          if (rc)
>>>                  return rc;
>>>    
>>> +       mem_hotplug_begin();
>>> +
>>>          /*
>>> -        * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
>>> -        * the same granularity it was added - a single memory block.
>>> +        * For memmap_on_memory, the altmaps could have been added on
>>> +        * a per-memblock basis. Loop through the entire range if so,
>>> +        * and remove each memblock and its altmap.
>>>           */
>>>          if (mhp_memmap_on_memory()) {
>>> -               rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
>>> -               if (rc) {
>>> -                       if (size != memory_block_size_bytes()) {
>>> -                               pr_warn("Refuse to remove %#llx - %#llx,"
>>> -                                       "wrong granularity\n",
>>> -                                       start, start + size);
>>> -                               return -EINVAL;
>>> -                       }
>>> -                       altmap = mem->altmap;
>>> -                       /*
>>> -                        * Mark altmap NULL so that we can add a debug
>>> -                        * check on memblock free.
>>> -                        */
>>> -                       mem->altmap = NULL;
>>> -               }
>>> +               unsigned long memblock_size = memory_block_size_bytes();
>>> +               u64 cur_start;
>>> +
>>> +               for (cur_start = start; cur_start < start + size;
>>> +                    cur_start += memblock_size)
>>> +                       remove_memory_block_and_altmap(nid, cur_start,
>>> +                                                      memblock_size);
>>> +       } else {
>>> +               remove_memory_block_and_altmap(nid, start, size);
>>
>> Better call remove_memory_block_devices() and arch_remove_memory(start,
>> size, altmap) here explicitly instead of using
>> remove_memory_block_and_altmap() that really can only handle a single
>> memory block with any inputs.
>>
> I'm not sure I follow. Even in the non memmap_on_memory case, we'd have
> to walk_memory_blocks() to get to the memory_block->altmap, right?

See my other reply to, at least with mhp_memmap_on_memory()==false, we 
don't have to worry about the altmap.

> 
> Or is there a more direct way? If we have to walk_memory_blocks, what's
> the advantage of calling those directly instead of calling the helper
> created above?

I think we have two cases to handle

1) All have an altmap. Remove them block-by-block. Probably we should 
call a function remove_memory_blocks(altmap=true) [or alternatively 
remove_memory_blocks_and_altmaps()] and just handle iterating internally.

2) All don't have an altmap. We can remove them in one go. Probably we 
should call that remove_memory_blocks(altmap=false) [or alternatively 
remove_memory_blocks_no_altmaps()].

I guess it's best to do a walk upfront to make sure either all have an 
altmap or none has one. Then we can branch off to the right function 
knowing whether we have to process altmaps or not.

The existing

if (mhp_memmap_on_memory()) {
	...
}

Can be extended for that case.

Please let me know if I failed to express what I mean, then I can 
briefly prototype it on top of your changes.

-- 
Cheers,

David / dhildenb

