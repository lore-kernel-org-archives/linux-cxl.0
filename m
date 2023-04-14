Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86450C77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 03:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDNDcy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 23:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjDNDcx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 23:32:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E0630C7
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 20:32:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7D47A3410A2;
        Fri, 14 Apr 2023 03:32:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EEFD734048E;
        Fri, 14 Apr 2023 03:32:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681443171; a=rsa-sha256;
        cv=none;
        b=CbNOYIrpjU3iJLCGD1H5zStiv0h5UA2Pppy/fIaGGqC8Ls1W08QE437RRhcQ5sXcHjf7lO
        oN4OAwfiIzP2Ngn/kRREXfMhtDhVCA2zKytz8zKULf961kdnexcye86haH40A1dH0Z7AWn
        t4parBI0YayENDHsTrFxb/8rYKAUCUxRzWCzfjwcpPvGD/q/gupH4PAE+5cv/PNbt46ees
        XFXFWQu1Q4nQoHzhIwyasZ1OCDhljq65u4KV9jQhnjMAbWF+V5RN84be+Y2Xj0gwNIROpK
        PBrdtgIdc44Y6x/4N0eX1FW8iD/OXJxs1lqoUyQ/fQdswKjcctFrrK4fiB5ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681443171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=IEornE/MljjmVXeROCqqlHFDlHCSwEyY42k4wz0BLcs=;
        b=GBpFXNDdautf/vDYVLrK02oB6gm0uhS3EP+Y9XBwae7WEKWZrUJ0JWs1O4OMr5Z2PxP6s+
        HeSO/7wWrGF4GodtcIUH/K4L9DR+zhycagbEiFuz9XqRNvkX9NrWYQsxxRr/pY+eJTqt1V
        GE6ehtmXOcw0jFrI0Urhcj6aoEziVkt2hecPfEN13cCImyK0jm1QlBzs1PgWmRr2y/5ULe
        CfQwzktkEK36FHeqs7LmRamlAPGLSde0JWk3U7z/UM8ANRzYf7aJQ80/xjRhNkkBbCKTj6
        FBG4b41bTliymvEh8+V1ssuEGav52dDOfuZ9gm63dmuNO4cZ4TeN5UqFZFudzA==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-4fxhg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Thread-Zesty: 5dcfe6e72ec270d9_1681443171291_1967959603
X-MC-Loop-Signature: 1681443171291:2412408486
X-MC-Ingress-Time: 1681443171291
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.1 (trex/6.7.2);
        Fri, 14 Apr 2023 03:32:51 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4PyMTZ27z0z29;
        Thu, 13 Apr 2023 20:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681443170;
        bh=IEornE/MljjmVXeROCqqlHFDlHCSwEyY42k4wz0BLcs=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=XMoNXb5wC9P1QecPhve/YyFCd5fw/YT73vxNynTnfk3wgwCJfqqmJ9xZPsNuRgTDt
         ElX8aiWYTp+jhibCuaLyfOuGYcovRzkiJgo413Mh+NPe/AdEjbkbcUafsAwDzSOxPS
         Rym0RoIw+zT58DjzkMMWDG52MSnphKLVN1jPTErUQGfwREl7JP3EhqnT/OEaDJwDFX
         aqwDfnylfP6BjFnhLQqtC/E3iJpMPegteTQd6JY4oBQ6wZMYcaQUbis/hxP6h4glb3
         VPPKIYBhfLAtaCNiGnGc69KDFWknH+W/2l5WfQT8EjgKWf3w5rGdQUIT/Ih1Qzx7Ti
         nhk5RNWwybF0g==
Message-ID: <253e7a73-be3c-44d4-1ca3-d0d060313517@stancevic.com>
Date:   Thu, 13 Apr 2023 22:32:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     Gregory Price <gregory.price@memverge.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <9d22b56b-80ef-b36f-731b-4b3b588bc4bd@stancevic.com>
 <ZDS8WH+yViVfsuMi@memverge.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ZDS8WH+yViVfsuMi@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory-


On 4/10/23 20:48, Gregory Price wrote:
> On Mon, Apr 10, 2023 at 07:56:01PM -0500, Dragan Stancevic wrote:
>> Hi Gregory-
>>
>> On 4/7/23 19:05, Gregory Price wrote:
>>> 3. This is changing the semantics of migration from a virtual memory
>>>      movement to a physical memory movement.  Typically you would expect
>>>      the RDMA process for live migration to work something like...
>>>
>>>      a) migration request arrives
>>>      b) source host informs destination host of size requirements
>>>      c) destination host allocations memory and passes a Virtual Address
>>>         back to source host
>>>      d) source host initates an RDMA from HostA-VA to HostB-VA
>>>      e) CPU task is migrated
>>>
>>>      Importantly, the allocation of memory by Host B handles the important
>>>      step of creating HVA->HPA mappings, and the Extended/Nested Page
>>>      Tables can simply be flushed and re-created after the VM is fully
>>>      migrated.
>>>
>>>      to long didn't read: live migration is a virtual address operation,
>>>      and node-migration is a PHYSICAL address operation, the virtual
>>>      addresses remain the same.
>>>
>>>      This is problematic, as it's changing the underlying semantics of the
>>>      migration operation.
>>
>> Those are all valid points, but what if you don't need to recreate HVA->HPA
>> mappings? If I am understanding the CXL 3.0 spec correctly, then both
>> virtual addresses and physical addresses wouldn't have to change. Because
>> the fabric "virtualizes" host physical addresses and the translation is done
>> by the G-FAM/GFD that has the capability to translate multi-host HPAs to
>> it's internal DPAs. So if you have two hypervisors seeing device physical
>> address as the same physical address, that might work?
>>
>>
> 
> Hm.  I hadn't considered the device side translation (decoders), though
> that's obviously a tool in the toolbox.  You still have to know how to
> slide ranges of data (which you mention below).

Hmm, do you have any quick thoughts on that?


>>> The reference in this case is... the page tables.  You need to know how
>>> to interpret the data in the CXL memory region on the remote host, and
>>> that's a "relative page table translation" (to coin a phrase? I'm not
>>> sure how to best describe it).
>>
>> right, coining phrases... I have been thinking of a "super-page" (for the
>> lack of a better word) a metadata region sitting on the switched CXL.mem
>> device that would allow hypervisors to synchronize on various aspects, such
>> as "relative page table translation", host is up, host is down, list of
>> peers, who owns what etc... In a perfect scenario, I would love to see the
>> hypervisors cooperating on switched CXL.mem device the same way cpus on
>> different numa nodes cooperate on memory in a single hypervisor. If either
>> host can allocate and schedule from this space then "NIL" aspect of
>> migration is "free".
>>
>>
> 
> The core of the problem is still that each of the hosts has to agree on
> the location (physically) of this region of memory, which could be
> problematic unless you have very strong BIOS and/or kernel driver
> controls to ensure certain devices are guaranteed to be mapped into
> certain spots in the CFMW.

Right, true. The way I am thinking of it is that this would be a part of 
data-center ops setup which at first pass would be a somewhat of a 
manual setup same way as other pre-OS related setup. But later on down 
the road perhaps this could be automated, either through some pre-agreed 
auto-ranges detection or similar, it's not unusual for dc ops to name 
hypervisors depending of where in dc/rack/etc they sit etc..



> After that it's a matter of treating this memory as incoherent shared
> memory and handling ownership in a safe way.  If the memory is only used
> for migrations, then you don't have to worry about performance.
> 
> So I agree, as long as shared memory mapped into the same CFMW area is
> used, this mechanism is totally sound.
> 
> My main concerns are that I don't know of a mechanism to ensure that.  I
> suppose for those interested, and with special BIOS/EFI, you could do
> that - but I think that's going to be a tall ask in a heterogenous cloud
> environment.

Yeah, I get that. But in my experience even heterogeneous setups have 
some level of homogeneity, weather it's per rack, or per pod. As old 
things are sunset and new things are brought in, it gives you these 
segments of homogeneity with more or less advanced features. So at the 
end of the day, if someone wants a feature X they will need to 
understand the feature requirements or limitations. I feel like I deal 
with hardware/feature fragmentation all the time, but doesn't preclude 
bringing newer things in. You just have to plant it appropriately.


>>> That's... complicated to say the least.
>>>
>>> <... snip ...>
>>>
>>> An Option:  Make pages physically contiguous on migration to CXL
>>>
>>> In this case, you don't necessarily care about the Host Virtual
>>> Addresses, what you actually care about are the structure of the pages
>>> in memory (are they physically contiguous? or do you need to
>>> reconstruct the contiguity by inspecting the page tables?).
>>>
>>> If a migration API were capable of reserving large swaths of contiguous
>>> CXL memory, you could discard individual page information and instead
>>> send page range information, reconstructing the virtual-physical
>>> mappings this way.
>>
>> yeah, good points, but this is all tricky though... it seems this would
>> require quiescing the VM and that is something I would like to avoid if
>> possible. I'd like to see the VM still executing while all of it's pages are
>> migrated onto CXL NUMA on the source hypervisor. And I would like to see the
>> VM executing on the destination hypervisor while migrate_pages is moving
>> pages off of CXL. Of course, what you are describing above would still be a
>> very fast VM migration, but would require quiescing.
>>
>>
> 
> Possibly.  If you're going to quiesce you're probably better off just
> snapshotting to shared memory and migrating the snapshot.

That is exactly my thought too.

> Maybe that's the better option for a first-pass migration mechanism.  I
> don't know.

I definitely see your point, "canning" and "re-hydration" approach as a 
first-pass. I'd be happy with even just a "Hello World" page migration 
as a first pass :)



> 
> Anyway, would love to attend this session.
> 
> ~Gregory
> 

-- 
--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

