Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A9C77B78
	for <linux-cxl@archiver.kernel.org>; Wed,  3 May 2023 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjECXmJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 May 2023 19:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECXmI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 May 2023 19:42:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904C900E
        for <linux-cxl@vger.kernel.org>; Wed,  3 May 2023 16:42:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 38E01922D6E;
        Wed,  3 May 2023 23:42:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B1189922CAA;
        Wed,  3 May 2023 23:42:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683157325; a=rsa-sha256;
        cv=none;
        b=Q5RB/NxJ//JFQatqH0DsojgM4t2BERhDKW39wpVyYMxKBCcrsRg5TfM6b7fVODdaO55Z4P
        /MZojnq3e8CF9IgtDeF1I1QT7pQ+0Vo6cKTUQ+iQRHMp4y1IYlKQxFIxCnSrJ92HiJTQHQ
        vVemJkEVaHwzPADdQJceMLF1CkBkmzZFLl1dOfwFmqVxYgOpUzXXy1CZMmhTydtCPGOGvn
        +x4ebx0AvwZhOdR3yENH0LfYrgs8efQk2Nsb6Q+5Ul7zHsHuxo5RuB4IRB112YQ+ImsNFm
        tchXUH3xRjgDf6t6qXcyUuW8ikpzvcMpeCZ/RiBAi3c15EFSX23bpvB3h3JAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683157325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6Fl+TE24h/cXTZYsl2ydKjUvZhBWezigFN426bbRXhc=;
        b=uXAyjGRLAGEGRjCvXIsqUla3xWuF9o2TCOgqpjYkaB+IcO5iErz/hCYorA+Q22sQFSUxsI
        qCEqyYmh8+byDKZsedeZeocpm5sWYC1Tztqhni2KTeDTXFfqt9u18rUiYX2A1IU+8XDskQ
        agQrC8DK0t8LszY7TjzjHMAxiJLPy2I80cipB/pB0VgIwfMORyiZfyvWLYMpjKOYLTn77h
        VPsWfOZE+IWUB5L/0bVxNeUg76xxxK3CSju2RwgfpDHUGUfxN04GvQ1RfhY2Zq61edDqrR
        Th3lF2P2PzgRBrRJWuxWe8EnTAoYiZb8of2V3xiPsTR7z9rsf86y6an84lsYtQ==
ARC-Authentication-Results: i=1;
        rspamd-6bfb6b59b5-85htg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Tank: 23fd55f034b3cb78_1683157326028_3312701159
X-MC-Loop-Signature: 1683157326028:1094234701
X-MC-Ingress-Time: 1683157326028
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.179 (trex/6.7.2);
        Wed, 03 May 2023 23:42:06 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4QBYQ45pzxz21;
        Wed,  3 May 2023 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1683157325;
        bh=6Fl+TE24h/cXTZYsl2ydKjUvZhBWezigFN426bbRXhc=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=cecviFhK3VbN0Qy3IojLvL2kSa+CAO8QY93elN0VWNWg4Kmp6BfB78ihKqQCZLmOk
         4SiTzTMWwmoB7gSwbU/ArZxrNUgCF18ZPmYgUqVL+PIunQdEjVZxC7zXO4q04OrqSC
         LISJcIgIp2vw6nKih28PwtcZ36GyxMgzpzXbf9+Z5SoBm/6Fl6atnTPpORWekG3w6+
         qBC1GiOK9MNiXKTqY1a/sofcajDGZQY9btO/ScW2nPV6YY9HUOWvopocpYbrx/oSSd
         huCOybR+4TtMYZCOE9Y0mQP4s+64H8V2ccHpKwHkYvVbgN577sTdeG2L2rOH/2aiU8
         AyOLZeQY0vekg==
Message-ID: <43e81295-3ef3-e10d-4af8-cf53f06c7120@stancevic.com>
Date:   Wed, 3 May 2023 18:42:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Gregory Price <gregory.price@memverge.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZDV+f7+QH5W/vXAt@memverge.com>
 <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <ec7399fbd74d43a06edc8b344fccddbdef44a101.camel@HansenPartnership.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ec7399fbd74d43a06edc8b344fccddbdef44a101.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi James, sorry looks like I missed your email...


On 4/12/23 10:15, James Bottomley wrote:
> On Wed, 2023-04-12 at 10:38 +0200, David Hildenbrand wrote:
>> On 12.04.23 04:54, Huang, Ying wrote:
>>> Gregory Price <gregory.price@memverge.com> writes:
> [...]
>>>> That feels like a hack/bodge rather than a proper solution to me.
>>>>
>>>> Maybe this is an affirmative argument for the creation of an
>>>> EXMEM zone.
>>>
>>> Let's start with requirements.  What is the requirements for a new
>>> zone type?
>>
>> I'm stills scratching my head regarding this. I keep hearing all
>> different kind of statements that just add more confusions "we want
>> it to be hotunpluggable" "we want to allow for long-term pinning
>> memory" "but we still want it to be movable" "we want to place some
>> unmovable allocations on it". Huh?
> 
> This is the essential question about CXL memory itself: what would its
> killer app be?  The CXL people (or at least the ones I've talked to)
> don't exactly know.


I hope it's not something I've said, I'm not claiming VM migration or 
hypervisor clustering is the killer app for CXL. I would never claim 
that. And I'm not one of the CXL folks. You can chuck me into the "CXL 
enthusiasts" bucket.... For a bit of context, I'm one of the 
co-authors/architects of VMware's clustered filesystem[1] and I've 
worked on live VM migration as far back as 2003 on the original ESX 
server. Back in the day, we introduced the concept of VM live migration 
into the x86 data-center parlance with a combination of a process 
monitor and a clustered filesystem. The basic mechanism we put forward 
at the time was: pre-copy, quiesce, post-copy, un-quiesce. And I think 
most hypervisor after which added live migration are using loosely the 
same basic principles, iirc xen introduced LM 4 years later in 2007 and 
KVM about the same time or perhaps a year later. Anyway, the point that 
I am trying to get to is, it bugged me 20 years ago that we quiesced, 
and it bugs me today :) I think 20 years ago, quiescing was an 
acceptable compromise because we couldn't solve it technologically. 
Maybe 20-25 years later, we've reached a point we can solve it 
technologically. I don't know, but the problem interests me enough to try.


>  Within IBM I've seen lots of ideas but no actual
> concrete applications.  Given the rates at which memory density in
> systems is increasing, I'm a bit dubious of the extensible system pool
> argument.   Providing extensible memory to VMs sounds a bit more
> plausible, particularly as it solves a big part of the local overcommit
> problem (although you still have a global one).  I'm not really sure I
> buy the VM migration use case: iterative transfer works fine with small
> down times so transferring memory seems to be the least of problems
> with the VM migration use case

We do approximately 2.5 Million live migrations per year. Some 
migrations take less than a second, some take roughly a second, and 
others on very noisy VMs can take several seconds. Whatever that average 
is, let's say 1 second per live migration, that's cumulatively roughly 
28 days of steal lost to migration per year. As you probably know, live 
migrations are essential for de-fragmenting hypervisors/de-stranding 
resources and from my perspective, I'd like to see them happen more 
often with a smaller customer impact.


> (it's mostly about problems with attached devices).

That is purely virtualization load type dependent. Maybe for the cloud 
you're running devices are a problem(I'm guessing here). For us this is 
a non existent problem. We serve approximately 600,000 customers and 
don't do forms of pass-through so it's literally a non issue. What I am 
starting to tackle with nil-migration is to be able to migrate live and 
executing memory, instead of frozen memory. Which should especially help 
with noisy VMs, and in my experience customers of noisy VMs are more 
likely to notice steal and complain about steal. I understand everyone 
has their own workloads, and the devices problem will be solved in it's 
own right, but it's out of scope for what I am tackling with 
nil-migration. My main focus at this time is memory and context migration.


<  CXL 3.0 is adding sharing primitives for memory so
> now we have to ask if there are any multi-node shared memory use cases
> for this, but most of us have already been burned by multi-node shared
> clusters once in our career and are a bit leery of a second go around.

Chatting with you at the last LPC, and judging by the combined gray hair 
between us, I'll venture to guess we've both fallen off the proverbial 
bike, many times. It's never stopped me from getting back on. Issue 
interest me enough to try.

If you don't mind me asking, what clustering did you work on? Maybe I am 
familiar with it


> 
> Is there a use case I left out (or needs expanding)?
> 
> James
> 



[1]. https://en.wikipedia.org/wiki/VMware_VMFS

--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

