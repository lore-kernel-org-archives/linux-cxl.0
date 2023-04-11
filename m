Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA6C77B61
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDKBBz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKBBy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 21:01:54 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5532683
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 18:01:50 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3CD18200CC1;
        Tue, 11 Apr 2023 00:56:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B64C3201FB4;
        Tue, 11 Apr 2023 00:56:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681174562; a=rsa-sha256;
        cv=none;
        b=vAK3GF50lp7aXKwZfsUiybD/Cl4NP+EthJdMD45RGVZIOeReXqzME1Ahh8+R4xurZ0JquU
        +1hx6JuJxEqhZiYmw4kKazMSFMlUvUgxfOtqm+txaMv55YizKBfDoFIdslyL1IOQWVdChg
        6Cn7158By8c73z1w2AmIyOnk9FYoXz6XLiOHLzQp6y35Bi/GRr74G44hiN3Y30HfojMm0r
        hg0g0ynbyBBx3CqTf8Y6ivdL0HSICEDFwVrQfwUTr2V7+1mB7Tm/8G7rgD+y+ioDHbARnJ
        PToXlWqfUOJcm9QkaERQ14go6YT7S8AkOCZ3asTCKeZpYDHynGev8+mRVYy/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681174562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=CWcJbXfzyJS5/H2yoTYwZXu+gcB/3v29V9Q0XSajINI=;
        b=3Fvfl9L07ke26Hd559iwy0s0Q8WBwqOYh+PD0uL8srf52I62aide8ZE8rnJL79nnU12omY
        R4K9H4xBM3KojFNvEOwY3vqYamQ+GAR5bd2JO52L9ER00ENiPjL18IS1oPax9BGCeMoXSr
        qDp4ERY7939860tBmJrGaxZj+WsVlw1r6UMAmcHLSRkIqXliqqT2j9yr7zX186fgjFoPXV
        AQ1t6n/RU7C8KTuGqOMt5xXbJlqdlOclaV/AYW+zqWXmsfdu62PCniPHNcFt/VPxrMiWat
        TNVnu9RRv8Tn9rcE6vBwxhASe9uq8AQC8emwL6H04+42VMA3KwKwtbDPhMcZHA==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-rd8ct;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Attack-Coil: 38242ba8639e6d8c_1681174563047_542724734
X-MC-Loop-Signature: 1681174563047:1454193143
X-MC-Ingress-Time: 1681174563047
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.176 (trex/6.7.2);
        Tue, 11 Apr 2023 00:56:03 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PwS816n5jzBD;
        Mon, 10 Apr 2023 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1681174562;
        bh=CWcJbXfzyJS5/H2yoTYwZXu+gcB/3v29V9Q0XSajINI=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=WnctCv5oebWitZQ6CLxQZ2VxeP9fzObcBduVii4wGB3L5lidGhdxRH9DlV6gp+U/+
         MjyfQzp9HnCJ0PAWK7a2fXl5nlUkiFXMl4s49gB6byZ+Ki5OXGvX6mOL/7FbeXN+ld
         ksTeusTAge1OutwfzqNHCpePISQnJzxLLhoqLvqMJ2nWQ20Waj00mQFvWziWCIJFax
         Mfy0VceI/jrR6/heqgzCvCUPMXmS2kt8dBE7iKiMeuqd99O8uHUuHBguSRUPO8o3ic
         pRyNbR7ykFXmNFxMkSh8XX96fzhMeO32BoK4Spfp/RvVvJTImaUmnxWV8ksiBdFRoO
         16A01t9WGYL3A==
Message-ID: <9d22b56b-80ef-b36f-731b-4b3b588bc4bd@stancevic.com>
Date:   Mon, 10 Apr 2023 19:56:01 -0500
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
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ZDCv3lxLbquITy8M@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory-

On 4/7/23 19:05, Gregory Price wrote:
> On Fri, Apr 07, 2023 at 04:05:31PM -0500, Dragan Stancevic wrote:
>> Hi folks-
>>
>> if it's not too late for the schedule...
>>
>> I am starting to tackle VM live migration and hypervisor clustering over
>> switched CXL memory[1][2], intended for cloud virtualization types of loads.
>>
>> I'd be interested in doing a small BoF session with some slides and get into
>> a discussion/brainstorming with other people that deal with VM/LM cloud
>> loads. Among other things to discuss would be page migrations over switched
>> CXL memory, shared in-memory ABI to allow VM hand-off between hypervisors,
>> etc...
>>
>> A few of us discussed some of this under the ZONE_XMEM thread, but I figured
>> it might be better to start a separate thread.
>>
>> If there is interested, thank you.
>>
>>
>> [1]. High-level overview available at http://nil-migration.org/
>> [2]. Based on CXL spec 3.0
>>
>> --
>> Peace can only come as a natural consequence
>> of universal enlightenment -Dr. Nikola Tesla
> 
> I've been chatting about this with folks offline, figure i'll toss my
> thoughts on the issue here.

excellent brain dump, thank you


> Some things to consider:
> 
> 1. If secure-compute is being used, then this mechanism won't work as
>     pages will be pinned, and therefore not movable and excluded from
>     using cxl memory at all.
> 
>     This issue does not exist with traditional live migration, because
>     typically some kind of copy is used from one virtual space to another
>     (i.e. RMDA), so pages aren't really migrated in the kernel memory
>     block/numa node sense.

right, agreed... I don't think we can migrate in all scenarios, such as 
pinning or forms of pass-through, etc

my opinion just to start off, as a base requirement, would be that the 
pages be movable.



> 2. During the migration process, the memory needs to be forced not to be
>     migrated to another node by other means (tiering software, swap,
>     etc).  The obvious way of doing this would be to migrate and
>     temporarily pin the page... but going back to problem #1 we see that
>     ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>     troublesome.

Yeah, true. I'd have to check the code, but I wonder if perhaps we could 
mapcount or refount the pages upon migration onto CLX switched memory. 
If my memory serves me right, wouldn't the move_pages back off or stall? 
I guess it's TBD, how workable or useful that would be but it's good to 
be thinking of different ways of doing this


> 3. This is changing the semantics of migration from a virtual memory
>     movement to a physical memory movement.  Typically you would expect
>     the RDMA process for live migration to work something like...
> 
>     a) migration request arrives
>     b) source host informs destination host of size requirements
>     c) destination host allocations memory and passes a Virtual Address
>        back to source host
>     d) source host initates an RDMA from HostA-VA to HostB-VA
>     e) CPU task is migrated
> 
>     Importantly, the allocation of memory by Host B handles the important
>     step of creating HVA->HPA mappings, and the Extended/Nested Page
>     Tables can simply be flushed and re-created after the VM is fully
>     migrated.
> 
>     to long didn't read: live migration is a virtual address operation,
>     and node-migration is a PHYSICAL address operation, the virtual
>     addresses remain the same.
> 
>     This is problematic, as it's changing the underlying semantics of the
>     migration operation.

Those are all valid points, but what if you don't need to recreate 
HVA->HPA mappings? If I am understanding the CXL 3.0 spec correctly, 
then both virtual addresses and physical addresses wouldn't have to 
change. Because the fabric "virtualizes" host physical addresses and the 
translation is done by the G-FAM/GFD that has the capability to 
translate multi-host HPAs to it's internal DPAs. So if you have two 
hypervisors seeing device physical address as the same physical address, 
that might work?


> Problem #1 and #2 are head-scratchers, but maybe solvable.
> 
> Problem #3 is the meat and potatos of the issue in my opinion. So lets
> consider that a little more closely.
> 
> Generically: NIL Migration is basically a pass by reference operation.

Yup, agreed


> The reference in this case is... the page tables.  You need to know how
> to interpret the data in the CXL memory region on the remote host, and
> that's a "relative page table translation" (to coin a phrase? I'm not
> sure how to best describe it).

right, coining phrases... I have been thinking of a "super-page" (for 
the lack of a better word) a metadata region sitting on the switched 
CXL.mem device that would allow hypervisors to synchronize on various 
aspects, such as "relative page table translation", host is up, host is 
down, list of peers, who owns what etc... In a perfect scenario, I would 
love to see the hypervisors cooperating on switched CXL.mem device the 
same way cpus on different numa nodes cooperate on memory in a single 
hypervisor. If either host can allocate and schedule from this space 
then "NIL" aspect of migration is "free".


> That's... complicated to say the least.
> 1) Pages on the physical hardware do not need to be contiguous
> 2) The CFMW on source and target host do not need to be mapped at the
>     same place
> 3) There's not pre-allocation in these charts, and migration isn't
>     targeted, so having the source-host "expertly place" the data isn't
>     possible (right now, i suppose you could make kernel extensions).
> 4) Similar to problem #2 above, even with a pre-allocate added in, you
>     would need to ensure those mappings were pinned during migration,
>     lest the target host end up swapping a page or something.
> 
> 
> 
> An Option:  Make pages physically contiguous on migration to CXL
> 
> In this case, you don't necessarily care about the Host Virtual
> Addresses, what you actually care about are the structure of the pages
> in memory (are they physically contiguous? or do you need to
> reconstruct the contiguity by inspecting the page tables?).
> 
> If a migration API were capable of reserving large swaths of contiguous
> CXL memory, you could discard individual page information and instead
> send page range information, reconstructing the virtual-physical
> mappings this way.

yeah, good points, but this is all tricky though... it seems this would 
require quiescing the VM and that is something I would like to avoid if 
possible. I'd like to see the VM still executing while all of it's pages 
are migrated onto CXL NUMA on the source hypervisor. And I would like to 
see the VM executing on the destination hypervisor while migrate_pages 
is moving pages off of CXL. Of course, what you are describing above 
would still be a very fast VM migration, but would require quiescing.



> That's about as far as I've thought about it so far.  Feel free to rip
> it apart! :]

Those are all great thoughts and I appreciate you sharing them. I don't 
have all the answers either :)


> ~Gregory
> 


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

