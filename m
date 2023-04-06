Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC51C7618D
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Apr 2023 12:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDFM2F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Apr 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDFM2C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Apr 2023 08:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4D6EB7
        for <linux-cxl@vger.kernel.org>; Thu,  6 Apr 2023 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680784035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8VPDq2rzp/RMvuM0GkwvstrEUPv56pcKGMAu1vG79k=;
        b=OAms40dPONsF82WFa2xlcnfuEovH5pFSeROxw9k9XkNsT7nQFLorDuYlpfJNSO4gtS8Bu7
        +1VRyXJlRx5uFLCB1MG8/fapJLbjKQwnoQ7PID1zvyvOhm2p8l/wJKlpnIZS5o+qYXig8V
        ifhAxgG/+8iVEGmSWkIVtWaLwN17aG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-V06NUUPPMyuE5jmh_dCRpQ-1; Thu, 06 Apr 2023 08:27:14 -0400
X-MC-Unique: V06NUUPPMyuE5jmh_dCRpQ-1
Received: by mail-wm1-f72.google.com with SMTP id m27-20020a05600c3b1b00b003ee502f1b16so18224588wms.9
        for <linux-cxl@vger.kernel.org>; Thu, 06 Apr 2023 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680784032; x=1683376032;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8VPDq2rzp/RMvuM0GkwvstrEUPv56pcKGMAu1vG79k=;
        b=ZQMBkQ+IE6jd2A0Yw3h/lQ7fs+ubPZyz6q++EUXOm21NJ5OqM0ddIXrKNGSQch1jVD
         3zVv31z2VqAJjK1vWb7rr4cop0pt74e24kZJPQ6YTqPJuTe7yNFA1D8SVtjcZZBSM31r
         28rACwJxkp/qaDCJlUC1K9E7vDL3JlAkqnt0i6HrTBCx5G9p3LGT8yNRwv7RObnU2GGm
         JiZL9/Gg3LBKgWAEa0FWHLan1tpXnqHtJ6C613h/OdynhtTLqiRisk4/YST//d0ycToT
         L7wk/Eq5iEuT7Uq6uTUo0s04It4oFLBJvc/8c6FeDGhZUUWDD+LMISa2WiBwA7h98aQG
         5mdA==
X-Gm-Message-State: AAQBX9eLKXqMxAFDinSjUwtdSklDeifkWpAaOwBEnJG5CSXdOSHQtrtL
        L5Dc3GF59pkL4BNKF5zmE/5mpsktXib4x1Kj3voAlEmhv8ZIw1jm6CEe2JU+Nlq2pz7ew71PadD
        dzBHh/eJV3bbULR7RatZ1E3fr89mZ
X-Received: by 2002:a1c:7406:0:b0:3ee:18e:a1ef with SMTP id p6-20020a1c7406000000b003ee018ea1efmr6734877wmc.1.1680784032392;
        Thu, 06 Apr 2023 05:27:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zj5O+SuV6Tw/J9ZVlMtHct578hAy7ZuVMILZV4dGS4JekWIUunN5jJ+9DL6SdhkTn/sDSC0A==
X-Received: by 2002:a1c:7406:0:b0:3ee:18e:a1ef with SMTP id p6-20020a1c7406000000b003ee018ea1efmr6734862wmc.1.1680784031963;
        Thu, 06 Apr 2023 05:27:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003ede03e4369sm5268391wmq.33.2023.04.06.05.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:27:11 -0700 (PDT)
Message-ID: <6ebf38f1-b7c4-cb38-b72f-2e406d2a2fdc@redhat.com>
Date:   Thu, 6 Apr 2023 14:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
 <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
 <20230405020027.413578-1-ks0204.kim@samsung.com>
 <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <ZC26HpJiBexoIApc@casper.infradead.org>
 <642dcf4169ae5_21a8294f@dwillia2-xfh.jf.intel.com.notmuch>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
In-Reply-To: <642dcf4169ae5_21a8294f@dwillia2-xfh.jf.intel.com.notmuch>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 05.04.23 21:42, Dan Williams wrote:
> Matthew Wilcox wrote:
>> On Tue, Apr 04, 2023 at 09:48:41PM -0700, Dan Williams wrote:
>>> Kyungsan Kim wrote:
>>>> We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
>>>> a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
>>>> Also, not all kernel objects can be allocated from ZONE_MOVABLE.
>>>>
>>>> ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
>>>> In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
>>>> It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
>>>> In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
>>>>
>>>
>>> I want to clarify that I expect the number of people doing physical CXL
>>> hotplug of whole devices to be small compared to dynamic capacity
>>> devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
>>> device maps 1 or more thinly provisioned memory regions that have
>>> individual extents get populated and depopulated by a fabric manager.
>>>
>>> In that scenario there is a semantic where the fabric manager hands out
>>> 100G to a host and asks for it back, it is within the protocol that the
>>> host can say "I can give 97GB back now, come back and ask again if you
>>> need that last 3GB".
>>
>> Presumably it can't give back arbitrary chunks of that 100GB?  There's
>> some granularity that's preferred; maybe on 1GB boundaries or something?
> 
> The device picks a granularity that can be tiny per spec, but it makes
> the hardware more expensive to track in small extents, so I expect
> something reasonable like 1GB, but time will tell once actual devices
> start showing up.

It all sounds a lot like virtio-mem using real hardware [I know, there 
are important differences, but for the dynamic aspect there are very 
similar issues to solve]

Fir virtio-mem, the current best way to support hotplugging of large 
memory to a VM to eventually be able to unplug a big fraction again is 
using a combination of ZONE_MOVABLE and ZONE_NORMAL -- "auto-movable" 
memory onlining policy. What's online to ZONE_MOVABLE can get (fairly) 
reliably unplugged again. What's onlined to ZONE_NORMAL is possibly lost 
forever.

Like (incrementally) hotplugging 1 TiB to a 4 GiB VM. Being able to 
unplug 1 TiB reliably again is pretty much out of scope. But the more 
memory we can reliably get back the better. And the more memory we can 
get in the common case, the better. With a ZONE_NORMAL vs. ZONE_MOVABLE 
ration of 1:3 on could unplug ~768 GiB again reliably. The remainder 
depends on fragmentation on the actual system and the unplug granularity.

The original plan was to use ZONE_PREFER_MOVABLE as a safety buffer to 
reduce ZONE_NORMAL memory without increasing ZONE_MOVABLE memory (and 
possibly harming the system). The underlying idea was that in many 
setups that memory in ZONE_PREFER_MOVABLE would not get used for 
unmovable allocations and it could, therefore, get unplugged fairly 
reliably in these setups. For all other setups, unmmovable allocations 
could leak into ZONE_PREFER_MOVABLE and reduce the number of memory we 
could unplug again. But the system would try to keep unmovable 
allocations to ZONE_NORMAL, so in most cases with some 
ZONE_PREFER_MOVABLE memory we would perform better than with only 
ZONE_NORMAL.

-- 
Thanks,

David / dhildenb

