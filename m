Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9473C77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 04:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDNEQ0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 00:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNEQY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 00:16:24 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DD210B
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 21:16:23 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DA94941F45;
        Fri, 14 Apr 2023 04:16:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3E82F41E6F;
        Fri, 14 Apr 2023 04:16:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681445782; a=rsa-sha256;
        cv=none;
        b=lEynDKe47Cr5VpiGDqzD71lybFYLkjlFRrLzu5E65c2og1K0MwEbtnCJFIwUZF7/3ii+mn
        j1uYA2NitC62hSBHvakYjs2PnJLWAGvQHOWPIpBLeSGnl61GYF415425BQMuEFbtHMiVg6
        8C5i7EL1uikwUF+vo/AUdBqVaAYyOAXhqwdy1p3XsY0hmB5p0EgX/G3O0/B2HiOkaSfEuB
        P4V//Uq5sAlAb4qxNCuiaYC+hnKwlkXOI1A8TaX67M+2aBL6tCXe6jW3wXwcHtc9n0E5GK
        SxKqOd0fUpFGeim+eSnGLi+iMvRY4BSkf247YmDCG13ma5ZHZYFTSchVvbj8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681445782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/as/Nvw3cN5cKfjIJaXeek6O7hbJZriTIkoM0kW2bkA=;
        b=XaXxYD8iHqUHF/deLLJ/zN3SLZ3HBnpjQpUGwGhXtg8C2ZGf1B5Yu8CgL4PEUPEUqEKCUv
        C6NytmTZxJYZX6KlITiRwI42AiQBU3YTqLw8wIkS4deD2506r3LmhrVBuMET2lxu534pdy
        fR+W1ULe2lvcEVEwNJVWF4Z2VwG2a25hetY8NrelIKHSlx5wR3I8HIIBLdVl+W70CwH72m
        0eYtb1olAcz+D2V6jlEtOcdvYk3++l2PhSg3+9X4RZWl+WW7Ymkeoc6rZELnX+kZr35zoN
        jTfIdg9GOtWk1f56I0gpAwdWRnIGisz/C6JeKbmYD2IvzwkvK4IIAnuAEHFM4A==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-vr5t4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Industry-Quick: 2223833e254dbf24_1681445782689_1851875865
X-MC-Loop-Signature: 1681445782689:1097326943
X-MC-Ingress-Time: 1681445782688
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.185 (trex/6.7.2);
        Fri, 14 Apr 2023 04:16:22 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4PyNRn2Jqjz89;
        Thu, 13 Apr 2023 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681445782;
        bh=/as/Nvw3cN5cKfjIJaXeek6O7hbJZriTIkoM0kW2bkA=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=aIZBSA/fCH5c6Nabsd+Ebnf1Wu+/0nFY7OxWCsgmih0LU9VRn9nMybYJ8RcqiXJiH
         Ap9PlWmeRfTJtLqnh/3GP0tNj9tfGdwWZGgaj8d4oiaaQIv5y8xWK5BGUA60IPg2f/
         oDxjaB2A0uBH1pFRB9VWva9Ji5Hxh7gZfkungdQBrYD0Bm76EC3si6QDvlzNlUQlM2
         no2wxw7snald7uRillnEfpKnrPKo7kSiXTDpG3ydGEJDz0Y11mXVwKiamFrWJICYGW
         zo68SfgXk68k3mWaHbQMQMANbP1q7X83LA7/IS1phy2MmsomnhWeJn5L7i0otAn1o/
         PItP3ws5U3cfw==
Message-ID: <30f254de-5bbb-bfb9-7321-62dc70db0ba9@stancevic.com>
Date:   Thu, 13 Apr 2023 23:16:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     Gregory Price <gregory.price@memverge.com>,
        David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZDV+f7+QH5W/vXAt@memverge.com>
 <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <ZDbNoNN0nkzn4xe6@memverge.com>
 <efe5dad7-8e58-b416-8108-bb692c726302@redhat.com>
 <ZDbdnRE39Py4X4bT@memverge.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ZDbdnRE39Py4X4bT@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory-


On 4/12/23 11:34, Gregory Price wrote:
> On Wed, Apr 12, 2023 at 05:50:55PM +0200, David Hildenbrand wrote:
>>
>> long-term: possibly forever, controlled by user space. In practice, anything
>> longer than ~10 seconds ( best guess :) ). There can be long-term pinnings
>> that are of very short duration, we just don't know what user space is up to
>> and when it will decide to unpin.
>>
>> Assume user space requests to trigger read/write of a user space page to a
>> file: the page is pinned, DMA is started, once DMA completes the page is
>> unpinned. Short-term. User space does not control how long the page remains
>> pinned.
>>
>> In contrast:
>>
>> Example #1: mapping VM guest memory into an IOMMU using vfio for PCI
>> passthrough requires pinning the pages. Until user space decides to unmap
>> the pages from the IOMMU, the pages will remain pinned. -> long-term
>>
>> Example #2: mapping a user space address range into an IOMMU to repeatedly
>> perform RDMA using that address range requires pinning the pages. Until user
>> space decides to unregister that range, the pages remain pinned. ->
>> long-term
>>
>> Example #3: registering a user space address range with io_uring as a fixed
>> buffer, such that io_uring OPS can avoid the page table walks by simply
>> using the pinned pages that were looked up once. As long as the fixed buffer
>> remains registered, the pages stay pinned. -> long-term
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
>>
> 
> That pretty much precludes live migration from using CXL as a transport
> mechanism, since live migration would be a user-initiated process, you
> would need what amounts to an atomic move between hosts to ensure pages
> are not left pinned.

Do you really need an atomic-in-between-hots? I mean, it's not really a 
failure if you are in the process of migrating pages onto the switched 
cxl memory memory and one of the pages is pulled out of cxl and back on 
the hypervisor. The running VM cpu can do loads and stores from either. 
So it's running, it's not affected. It's just that your migration is 
potentially "stalled" or "canceled". You only encounter issues when all 
your pages are on cxl and the other hypervisor is pulling pages out.


> The more i'm reading the more i'm somewhat convinced CXL memory should
> not allow pinning at all.

I think you want to be able to somehow pin the pages on one hypervisor 
and unpin them on the other hypervisor. Or in some other way "pass 
ownership" between the hypervisor. Right? Because of the scenario I 
mention above, if your source hypervisor takes a page out of cxl, then 
your destination hypervisor has a hole in VMs address space and can't 
run it.

> I suppose you could implement a new RDMA feature where the remote host's
> CXL memory is temporarily mapped, data is migrated, and then that area
> is unmapped. Basically the exact same RDMA mechanism, but using memory
> instead of network. This would make the operation a kernel-controlled
> if pin/unpin is required.

That would move us from the shared memory in the CXL 3 spec into the 
sections on direct memory placement I think. Which in order of 
preference is a #2 for me personally and a "backup" plan if #1 shared 
memory doesn't pan out.




> Lots to talk about.
> 
> ~Gregory
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

