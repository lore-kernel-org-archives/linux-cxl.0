Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D70C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 15:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDLPvt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDLPvr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 11:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2317298
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681314659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8Udey6gD7hkKCelqudc6L+j8l+ybiTD+45ym6JKdjU=;
        b=F2Bon8M6GxJ3LePc2CRAb0y+Z3TOJNbJpbXU+F7B9cGXikhccIteO2fXWaTeHN/8ndFEzn
        3UddRIHJBZLxMA8O1P/n9L/r0nBlRm0yNZGbQIW+eW39zMHG03V3trDk6KGrI0+YknHBX6
        SUkYvdN7qHl87FzM40rJnkEWiY0OWWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-jllq_HHbNZSadzSg_1O_bQ-1; Wed, 12 Apr 2023 11:50:58 -0400
X-MC-Unique: jllq_HHbNZSadzSg_1O_bQ-1
Received: by mail-wm1-f69.google.com with SMTP id o4-20020a05600c510400b003eea8d25f06so3288766wms.1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 08:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681314657; x=1683906657;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8Udey6gD7hkKCelqudc6L+j8l+ybiTD+45ym6JKdjU=;
        b=GOHzAGoPkU3ZRlfa3W9kKWFScN3uh6Ue0ODJGsLOV6wHkTgnPoy99wU9i+zTAw91yp
         O4N8G25N7hjlm3Y6G1MNMDoNtZ8aN+y3lDeGLLT2uYbtIib/AnFGcmpe+brie6o1Uss0
         +4TXDYGttPj93zTZWQDHFbHWRHK2fpRI7hxr3Dk/23sX+eHehgUXyWRwcoV2+Q8TsGE9
         XeLt5hwYbBggTCP0BHYvM4lWqkwYmJPDddP0INpO5b0qJlqWAaxoxHJ63AlMYeBD/Bya
         tbSR0E9RXalfiWXKXsU/BVMpAAh8a6jDMSAB2Qud66TGQ0eT807qi+2xmgm10mhKx0qB
         fUVw==
X-Gm-Message-State: AAQBX9evqwnn2qkccFpG6L9+wJ/+gb8qU298AQPydAnw3+qFGtYKdvKj
        CeHr159u2Dw9NG9eC0cnxXeh7K/R63UYXoMyeRzi/3I+XcRsAZkcls1a/bw3m4B6PFiL2wQnhCC
        zSYfGH9i0MUbL8wMdo3EoXDOb02Xy
X-Received: by 2002:a7b:c3c8:0:b0:3ed:f5b5:37fc with SMTP id t8-20020a7bc3c8000000b003edf5b537fcmr2353186wmj.1.1681314657049;
        Wed, 12 Apr 2023 08:50:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350bwlS0al9uG2dSdIlKmYUi9C35HoaEAtA4olxB/jHjibws68jMXRqEnTf209NkApV4poz1+tg==
X-Received: by 2002:a7b:c3c8:0:b0:3ed:f5b5:37fc with SMTP id t8-20020a7bc3c8000000b003edf5b537fcmr2353169wmj.1.1681314656717;
        Wed, 12 Apr 2023 08:50:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b003ee6aa4e6a9sm2935483wmq.5.2023.04.12.08.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 08:50:56 -0700 (PDT)
Message-ID: <efe5dad7-8e58-b416-8108-bb692c726302@redhat.com>
Date:   Wed, 12 Apr 2023 17:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Gregory Price <gregory.price@memverge.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZDV+f7+QH5W/vXAt@memverge.com>
 <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <ZDbNoNN0nkzn4xe6@memverge.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
In-Reply-To: <ZDbNoNN0nkzn4xe6@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 12.04.23 17:26, Gregory Price wrote:
> On Wed, Apr 12, 2023 at 10:38:04AM +0200, David Hildenbrand wrote:
>> On 12.04.23 04:54, Huang, Ying wrote:
>>> Gregory Price <gregory.price@memverge.com> writes:
>>>
>>>> On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
>>>>> Gregory Price <gregory.price@memverge.com> writes:
>>>>>
>>>>> [snip]
>>>>>
>>>>>> 2. During the migration process, the memory needs to be forced not to be
>>>>>>      migrated to another node by other means (tiering software, swap,
>>>>>>      etc).  The obvious way of doing this would be to migrate and
>>>>>>      temporarily pin the page... but going back to problem #1 we see that
>>>>>>      ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>>>>>      troublesome.
>>>>>
>>>>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
>>>>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>>>>> but I think it is fixable.
>>>>>
>>>>> Best Regards,
>>>>> Huang, Ying
>>>>>
>>>>> [snip]
>>>>
>>>> That feels like a hack/bodge rather than a proper solution to me.
>>>>
>>>> Maybe this is an affirmative argument for the creation of an EXMEM
>>>> zone.
>>>
>>> Let's start with requirements.  What is the requirements for a new zone
>>> type?
>>
>> I'm stills scratching my head regarding this. I keep hearing all different
>> kind of statements that just add more confusions "we want it to be
>> hotunpluggable" "we want to allow for long-term pinning memory" "but we
>> still want it to be movable" "we want to place some unmovable allocations on
>> it". Huh?
>>
>> Just to clarify: ZONE_MOVABLE allows for pinning. It just doesn't allow for
>> long-term pinning of memory.
>>
> 
> I apologize for the confusion, this is my fault.  I had assumed that
> since dax regions can't be pinned, subsequent nodes backed by a dax
> device could not be pinned.  In testing this, this is not the case.
> 
> Re: long-term pinning, can you be more explicit as to what is considered
> long-term?  Minutes? hours? days? etc

long-term: possibly forever, controlled by user space. In practice, 
anything longer than ~10 seconds ( best guess :) ). There can be 
long-term pinnings that are of very short duration, we just don't know 
what user space is up to and when it will decide to unpin.

Assume user space requests to trigger read/write of a user space page to 
a file: the page is pinned, DMA is started, once DMA completes the page 
is unpinned. Short-term. User space does not control how long the page 
remains pinned.

In contrast:

Example #1: mapping VM guest memory into an IOMMU using vfio for PCI 
passthrough requires pinning the pages. Until user space decides to 
unmap the pages from the IOMMU, the pages will remain pinned. -> long-term

Example #2: mapping a user space address range into an IOMMU to 
repeatedly perform RDMA using that address range requires pinning the 
pages. Until user space decides to unregister that range, the pages 
remain pinned. -> long-term

Example #3: registering a user space address range with io_uring as a 
fixed buffer, such that io_uring OPS can avoid the page table walks by 
simply using the pinned pages that were looked up once. As long as the 
fixed buffer remains registered, the pages stay pinned. -> long-term

-- 
Thanks,

David / dhildenb

