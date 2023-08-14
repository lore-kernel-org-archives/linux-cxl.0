Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C7C001DB
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Aug 2023 07:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjHNHVJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 03:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjHNHVF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 03:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB010CE
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691997617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKY0cWansTn2sEL2WxZ0Fij0kBQM026mOZKicS65Eq4=;
        b=RXuS2IjBm/ooV+hoo98s0n3WsnS6BXgU29wbUF3qX0wwhG52qCcW8M5gSAsBWb3nK0AeAN
        mWE6NFj+Ohhn2QzHJWkgg7x/mqvzE7A/EoACYBbUX23tK9NQ5ii3sqCNlcC/vYy5tbM/Fo
        hdlP/gnJmBWXcVpRZL03wBj/S6WSNJY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-9jAd_yJ8P4G_FanpjFs_Ew-1; Mon, 14 Aug 2023 03:20:15 -0400
X-MC-Unique: 9jAd_yJ8P4G_FanpjFs_Ew-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9cd6a555aso38588951fa.3
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 00:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691997613; x=1692602413;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKY0cWansTn2sEL2WxZ0Fij0kBQM026mOZKicS65Eq4=;
        b=ZDrDFaWE8x7pXyzeys5Zjw9SYOJTTG+MqhqVoZSSf3PRj6em69bNbAbbtMsM1C/fEP
         o+rybScsP7c3yNizq5LuYNFWLAkuF9u3e2UZLl46a+iOYMRh2OhAFMBRh2nBoEBpZYFe
         TyP3O3htfKgB7G5uylTKQpjsSMfjYFtU1OxdBtZZvTGBFxnnnez/BOrGb196Nm5VLknN
         5M5h0NEjKEWACGnk+lZOAsingAFA5ASFLIueJU+x2dVD5muAc9mkWIScJDBe30h2rGb5
         vQiaeXCCYIw3R7va24lUhOTiPard3aXy8uE9oFN9fx6SmruFmdkHMLSLMdhkOUxKzK+f
         ebWw==
X-Gm-Message-State: AOJu0YzmROcLKi8qmhF7iegyVcF5vY8SwTUnfJVBKNKNDXVWumiyJOXZ
        NqrVaL4EDFk2rjZvuzjT+TyKB1S4o4e1wXy/UvWNpu2+IHzhepY3Lf59wX3vBfl/AtQTcDHAFI9
        wFZ2W0A2Y5EpD8MTxYMxi
X-Received: by 2002:a05:6512:3985:b0:4fd:f77d:5051 with SMTP id j5-20020a056512398500b004fdf77d5051mr7102540lfu.26.1691997613535;
        Mon, 14 Aug 2023 00:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxFH/xSsrS7cCDMRZUmdj0b6BcGtlavDhBDrFjlcKGEEig3zD2C6+9p5Bp+5A4BT4BRvhHWQ==
X-Received: by 2002:a05:6512:3985:b0:4fd:f77d:5051 with SMTP id j5-20020a056512398500b004fdf77d5051mr7102519lfu.26.1691997613136;
        Mon, 14 Aug 2023 00:20:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003fe2a40d287sm13602203wmk.1.2023.08.14.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:20:12 -0700 (PDT)
Message-ID: <6ce08d40-332b-217e-6203-c73dd7203e96@redhat.com>
Date:   Mon, 14 Aug 2023 09:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
To:     "Huang, Ying" <ying.huang@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Bernhard Walle <bernhard.walle@gmx.de>
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
 <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
 <87wmyp26sw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <abe41c22f72ad600541c6f2b199180b1cbcbb780.camel@intel.com>
 <87jzty9l6w.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87jzty9l6w.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 14.08.23 08:45, Huang, Ying wrote:
> "Verma, Vishal L" <vishal.l.verma@intel.com> writes:
> 
>> On Mon, 2023-07-24 at 13:54 +0800, Huang, Ying wrote:
>>> Vishal Verma <vishal.l.verma@intel.com> writes:
>>>
>>>>
>>>> @@ -2035,12 +2056,38 @@ void try_offline_node(int nid)
>>>>   }
>>>>   EXPORT_SYMBOL(try_offline_node);
>>>>
>>>> -static int __ref try_remove_memory(u64 start, u64 size)
>>>> +static void __ref __try_remove_memory(int nid, u64 start, u64 size,
>>>> +                                    struct vmem_altmap *altmap)
>>>>   {
>>>> -       struct vmem_altmap mhp_altmap = {};
>>>> -       struct vmem_altmap *altmap = NULL;
>>>> -       unsigned long nr_vmemmap_pages;
>>>> -       int rc = 0, nid = NUMA_NO_NODE;
>>>> +       /* remove memmap entry */
>>>> +       firmware_map_remove(start, start + size, "System RAM");
>>>
>>> If mhp_supports_memmap_on_memory(), we will call
>>> firmware_map_add_hotplug() for whole range.  But here we may call
>>> firmware_map_remove() for part of range.  Is it OK?
>>>
>>
>> Good point, this is a discrepancy in the add vs remove path. Can the
>> firmware memmap entries be moved up a bit in the add path, and is it
>> okay to create these for each memblock? Or should these be for the
>> whole range? I'm not familiar with the implications. (I've left it as
>> is for v3 for now, but depending on the direction I can update in a
>> future rev).
> 
> Cced more firmware map developers and maintainers.
> 
> Per my understanding, we should create one firmware memmap entry for
> each memblock.

Ideally we should create it for the whole range, ti limit the ranges. 
But it really only matters for DIMMs; for dax/kmem, we'll not create any 
firmware entries.

-- 
Cheers,

David / dhildenb

