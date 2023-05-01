Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E6C77B73
	for <linux-cxl@archiver.kernel.org>; Mon,  1 May 2023 23:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjEAXvD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 May 2023 19:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjEAXtR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 May 2023 19:49:17 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B1358C
        for <linux-cxl@vger.kernel.org>; Mon,  1 May 2023 16:49:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D95C55C18F8;
        Mon,  1 May 2023 23:49:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 571295C1861;
        Mon,  1 May 2023 23:49:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682984954; a=rsa-sha256;
        cv=none;
        b=37giloz0JYXilvc37oiB+2CNif+YQyZHx3KlMOJyBg1nKaMK0EAFWwjX7SdEV2Zkfa/A5K
        AiRi0Hnwx589Z9Ig/lI5FzJ5lEEQX9/4nivche88YCwJemwQOq/35KruutsJa7sUoVM+ge
        o3cyFFLRj1hL+km60XQaemYre+OGQlRuGQ6lPv0vTB3rn3rR83l+XJhk2QsTGtopsIKvA5
        5bMox3VKeMFg6qhiGxeU77AEmnphX96FIyZd/vqbetCKss1WW8Snc+xFEC14f29KmLnBap
        CY5iJU0VNlw1FLn5SLLrpCwj6ugSgJz3RJpbs/UIAAgi1N4AYc9KkBBGTE3EJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682984954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=27vbAUGZ+hqc0WK3Yz+IRYFIhtDEndf2DlyXxyoHHWc=;
        b=3v5xwVogpFHZXjiH1369Icjj49n+gwoiQDnGXCexNmF2dT2eCMLnU2zok/0+1i1O2Wcu9u
        cAPRfJkHtFnyywGDb0ExJHulDp11q1hOwxJeepD3oqbOeaSHO/AuoyyXAgn1RgCvix92bk
        bva/w9iOpOFXsFvPfj5Nz0waa1YfD3+lQO6rmRYAu/1lrQBwYNOoNw2HP+W+1HpbbIs+Y2
        KpMHk944BfNfCcVSTy21ICYQu9i2VQGV6wowpZzekaEVkTSV+fwtXJGv5N6x+PKVHDo79P
        pl+IViJw8iJsn7nOuGuEwJA+rOmrB3Yo1788nwRc7R41pCsmBObJkCpOzMqyQQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-v7wvb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Inform-Cooing: 02015a924e94606e_1682984954677_1031524346
X-MC-Loop-Signature: 1682984954677:1030373058
X-MC-Ingress-Time: 1682984954677
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.236 (trex/6.7.2);
        Mon, 01 May 2023 23:49:14 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4Q9KgF4H5Rz60;
        Mon,  1 May 2023 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1682984954;
        bh=27vbAUGZ+hqc0WK3Yz+IRYFIhtDEndf2DlyXxyoHHWc=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=OjKrVC1Wogff2+SQ+7JqVXSHIUFcou0SDq2RkmFMDBaQpCx8INyjwVG96NHLTSVYd
         9VpuwmwkYtIeTyZADCMEcMZd622Fn10vf9NYSqn03NObNASkhIMiK+0bImyYIXYbwj
         bQ/udSdgDdefm0YE0fPYAxosO0TETUcTL5rRmOqZA2tYJ6etAKOSxv9n/06zf/8r2u
         kDWFo11sMeLrzl9KY/hxfH60UVwwIfdv/xiEOlydLuL4Sjt18oHQozFCj65srvbWn8
         ih2cZ2ze/EZkWgOWL9jrDUsXwkTkRL0hhPjqiPmCCT4LLBcozywOrhcTI3qKdSt26N
         MFXnqapinxq7Q==
Message-ID: <9130d889-7cfe-9040-d887-380be67410d2@stancevic.com>
Date:   Mon, 1 May 2023 18:49:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     nil-migration@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <14a601ea-8cf8-bb9c-a87a-63567c5aba5b@intel.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <14a601ea-8cf8-bb9c-a87a-63567c5aba5b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dave-

sorry, looks like I've missed your email

On 4/11/23 13:00, Dave Hansen wrote:
> On 4/7/23 14:05, Dragan Stancevic wrote:
>> I'd be interested in doing a small BoF session with some slides and get
>> into a discussion/brainstorming with other people that deal with VM/LM
>> cloud loads. Among other things to discuss would be page migrations over
>> switched CXL memory, shared in-memory ABI to allow VM hand-off between
>> hypervisors, etc...
> 
> How would 'struct page' or other kernel metadata be handled?
> 
> I assume you'd want a really big CXL memory device with as many hosts
> connected to it as is feasible.  But, in order to hand the memory off
> from one host to another, both would need to have metadata for it at
> _some_ point.

To be honest, I have not been thinking of this in terms of a "star" 
connection topology. Where say each host in a rack connects to the same 
memory device, I think I'd get bottle-necked on a singular device. Evac 
of a few hypervisors simultaneously might get a bit dicey.

I've been thinking of it more in terms of multiple memory devices per 
rack, connected to various hypervisors to form a hypervisor traversal 
graph[1]. For example in this graph, a VM would migrate across a single 
hop, or a few hops to reach it's destination hypervisor. And for the 
lack of better word, this would be your "migration namespace" to migrate 
the VM across the rack. The critical connections in the graph are 
hostfoo04 and hostfoo09, and those you'd use if you want to pop the VM 
into a different "migration namespace", for example a different rack or 
maybe even a pod.

Of course, this is quite a ways out since there are no CXL 3.0 devices 
yet. As a first step I would like to get to a point where I can emulate 
this with qemu and just prototype various approaches, but starting with 
a single emulated memory device and two hosts.

> So, do all hosts have metadata for the whole CXL memory device all the
> time?  Or, would they create the metadata (hotplug) when a VM is
> migrated in and destroy it (hot unplug) when a VM is migrated out?

To be honest I have not thought about hot plugging, but might be 
something for me to keep in mind and ponder about it. And if you have 
additional thoughts on this I'd love to hear them.

What I was thinking, and this may or may not be possible, or may be 
possible only to a certain extent, but my preference would be to keep as 
much of the metadata as possible on the memory device itself and have 
the hypervisors cooperate through some kind of ownership mechanism.


> That gets back to the granularity question discussed elsewhere in the
> thread.  How would the metadata allocation granularity interact with the
> page allocation granularity?  How would fragmentation be avoided so that
> hosts don't eat up all their RAM with unused metadata?

Yeah, this is something I am still running through my head. Even if we 
have this "ownership-cooperation", is this based on pages, what happens 
to the sub-page allocations, do we move them through the buckets or do 
we attach ownership to sub-page allocations too. In my ideal world, 
you'd have two hypervisors cooperate over this memory as transparently 
as CPUs in a single system collaborating across NUMA nodes. A lot to 
think about, many problems to solve and a lot of work to do. I don't 
have all the answers yet, but value all input & help


[1]. https://nil-migration.org/VM-Graph.png

--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

