Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37EC76196
	for <linux-cxl@archiver.kernel.org>; Sat,  8 Apr 2023 01:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDHBd1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 21:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDHBd0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 21:33:26 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE91113D3
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 18:33:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E8779540A96;
        Sat,  8 Apr 2023 01:33:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6F58F540C1C;
        Sat,  8 Apr 2023 01:33:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680917598; a=rsa-sha256;
        cv=none;
        b=2akKHVZe2iBwohOGDeZrzTseIJcD6p6uG29UaG1afpmSZBayJ0i9KubwZhHjhJoV/k1Oq6
        T52DsUAz4xSZTblwIrM1UG4QVbiRWxwiK2VqlElAhrHDsUz/h9wsrFIDg+bytl4ZncTxRS
        HNuqM9z5GabZewG3hQ4OQNwBEUmhaJggGXNuBAkyI5Y/bshaa3XPxRt/Hrlqbj0BadX0+T
        MDBzVJFNeLM1Hif0sTsvtbc5LzJjhH24YQNUVutu52qfDS9LLJ4dxgBGBYOgsZ21erVQRJ
        kSTwvEb6Le2b3BwnSpcFpiEwQpPS614xjEmtVwV2kmPS+9m3spMCXdKr1gMeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680917598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=la/yFC5BS6MKKninFxgeefnhJSls0usViO3A5BOrUtI=;
        b=HPTGeI8rKSQ349i0rdeHpxy2UNd9zwyMXFgYZIH4rlqKEglps7HyzLhThYbp59ObIyL58R
        /JzET0go1LBTUgTO3ijDuRGMoUxgv0OkmQbIfzI11+WYf6Dw2hqCBjb6BVaeAR7WU/Oelg
        s13Cepatm5QRwlUz3/WGxABnNPZmJTLT0oCpycv74UvggRrwAhTkV9WlfzRJUDGFSjjQvu
        1IsM0rxn81a92XZmtqCnsNEO7MPJsz+7TKGq7vWxzBRDu7dYsCQs1x0jFFOjZYermpbVrJ
        N9wMxu2AuryPnd91Te3bEPAoQl/GN6QhaE9ZSrSAo3M4Ht1ndRG8ISZRaCpiRw==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-65p7t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Daffy: 0baed25459aded13_1680917598746_451456551
X-MC-Loop-Signature: 1680917598746:3624612456
X-MC-Ingress-Time: 1680917598746
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.77 (trex/6.7.2);
        Sat, 08 Apr 2023 01:33:18 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Ptd6P4x22z1p;
        Fri,  7 Apr 2023 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680917598;
        bh=la/yFC5BS6MKKninFxgeefnhJSls0usViO3A5BOrUtI=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=Rque07UHK3S1AakuUgaGRupkgpRBGnEI7ftcjYrsnh3IRnl3wD4vv6UstZg5//36U
         or7trcQKTKJQZDKnWyAWrFcJynOKhTTqZE9XjNwmTBW7u4U3Jr0k9fHb3T4gBUTPC+
         vxlIMlwohQrB9yuG+jgiBh8H6YJEtIkT+JeNHOgOWDEp3OJGkjioxbtttGfr8btcsz
         PEY9TwN8byecZpWnJ70RD6pgIpRjNNW1gIQ/XTxB4c6fdlAd5OfjGQz9oa6R9fw0cu
         2EbSMFNn1Jc0h75RhMbxayqrNqopIYzAPRhbZbtAPPQ0DNZcnxHneQRoC9DDT2KFX1
         WQgKU/GEwobzA==
Message-ID: <879ef647-d766-28a0-a881-218bee965683@stancevic.com>
Date:   Fri, 7 Apr 2023 20:33:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_C?=
 =?UTF-8?B?WEwgbWVtb3J54oCL?=
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <CADrL8HXLEd8PsCn0y7hfFNsGPoV8nyXokL-_wmmXE=TuV6ML=g@mail.gmail.com>
 <8fada43c-8319-4d1a-9614-3ac3c76d59f3@google.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <8fada43c-8319-4d1a-9614-3ac3c76d59f3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi David-

On 4/7/23 18:17, David Rientjes wrote:
> On Fri, 7 Apr 2023, James Houghton wrote:
> 
>> On Fri, Apr 7, 2023 at 5:05 PM Dragan Stancevic <dragan@stancevic.com> wrote:
>>>
>>> Hi folks-
>>>
>>> if it's not too late for the schedule...
>>>
>>> I am starting to tackle VM live migration and hypervisor clustering over
>>> switched CXL memory[1][2], intended for cloud virtualization types of loads.
>>>
>>> I'd be interested in doing a small BoF session with some slides and get
>>> into a discussion/brainstorming with other people that deal with VM/LM
>>> cloud loads. Among other things to discuss would be page migrations over
>>> switched CXL memory, shared in-memory ABI to allow VM hand-off between
>>> hypervisors, etc...
>>>
>>> A few of us discussed some of this under the ZONE_XMEM thread, but I
>>> figured it might be better to start a separate thread.
>>>
>>> If there is interested, thank you.
>>
>> Hi Dragan,
>>
>> Thanks for bringing up this topic. I'd be very interested to be part
>> of this BoF, as I'm also interested in using CXL.mem as a live
>> migration mechanism.
>>
> 
> Thanks for cc'ing me, this would be very interesting to talk about.  Count
> me in!
> 
>>> [1]. High-level overview available at http://nil-migration.org/
>>> [2]. Based on CXL spec 3.0
>>>
> 
> Dragan: I'm curious about the reference to CXL spec 3.0 here, is there
> something specific about 3.0 that this work depends on or should we be
> good-to-go with 2.0 as well?  (Are you referring to 3.0 for security
> extensions?)

I'm referencing 3.0 with regards to switched/shared memory as defined in 
Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, figure 
1-4, black color scheme circle(3) and bars.


It may be possible to do it with 2.0 but as far as I understand[1] the 
2.0 spec it might be a lot more involved/clunky. I think new 3.0 
features make it easier



[1]. I would love to read 2.0 spec, but I don't have access to 2.0 
spec(only 3.0). But that is my understanding from speaking with some CXL 
folks at last years plumbers when I floated this idea with them.

--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

