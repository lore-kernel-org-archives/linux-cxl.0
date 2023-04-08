Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DEFC7619A
	for <linux-cxl@archiver.kernel.org>; Sat,  8 Apr 2023 16:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDHQbb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 8 Apr 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHQba (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 8 Apr 2023 12:31:30 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2F7DBD
        for <linux-cxl@vger.kernel.org>; Sat,  8 Apr 2023 09:31:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0603A2004F7;
        Sat,  8 Apr 2023 16:31:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2503F2025E5;
        Sat,  8 Apr 2023 16:25:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680971101; a=rsa-sha256;
        cv=none;
        b=LwITwJizDqFQYM+qaoUrQTsNhJMV1IkqUCYJ3T1Fdzrp9Qnqb29cIYjBmDEzksooyLfjNQ
        FyzaYMRNCtZi+sGnuxkW+5Zgtu1FZf+77vw9JPHg4eReItoEu9/pqiRRM0CP4wYXznQ90B
        4Rw27WuvtvL5uN/3L6W4X6Yo6IkWKkCaY+6rOhIF7+xbtimg/TlAGlr3z7KzD62h91uqHN
        7f1ccIm4CAKejyhBIlNfFJOzdU8W0OOEibhvuLzgFC8FEW51YEmzEQ7r4n1WCyNXps304L
        1205l8vZCYDYLYqrOUv1Vqo7yxsfJFOX7MQ0/iLhwAvv5QXv9FQqQdzD3kYeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680971101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Q15BRLxpQIPEm91Mp3ow0K/nfpWZAmYlHh/cVpShUpg=;
        b=OIz3m+IGnLBEkyUklvvwfnZ1KB+XDCXL7Vq6C9rDsc5TWfD7Jwh7+Knx0VW6GYv+F5LFSN
        pK1k4qigk7mtpEIMu/HPDSF/qtPKLUMtAK/4WXedRcHhKyLdpMGXm8N9+GE+8DNtrqgjDk
        XP1Vys7Dczsr9DKDJmGvUIbXcAqX/QhJR+pU9t/U5YsJHKj5aGL4fqLkvTvB5GSJNuvlHa
        9DEZloUzYRGQibqEAY+u3z6wd8VEVsOCppKnk3YLkIseHFpFFjSU3DaZgGc+hl1PEpYQ34
        f5rwo13DlnpGAG9LeAZG2Ds9Cuc46ihiv676I7dBYq7kkWf+1U+YQshz80EWFw==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-xkv7t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Name: 5640c2ac40e51051_1680971102281_1465795904
X-MC-Loop-Signature: 1680971102281:3103371782
X-MC-Ingress-Time: 1680971102280
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.66.14 (trex/6.7.2);
        Sat, 08 Apr 2023 16:25:02 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Pv0vJ2GVKzC6;
        Sat,  8 Apr 2023 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680971100;
        bh=Q15BRLxpQIPEm91Mp3ow0K/nfpWZAmYlHh/cVpShUpg=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=z1xoBzErwPtXTu3rKXOhpivONDBXDPmxY0Xtve+P7vW5RDb36iUbZZwc6vcb486Zc
         shFlorX694QO6S4id0GJEV8Z0g1+bFxkUjhVa/IGLM5pR18+sx7/PA+mj8p92pcQF4
         DMKXAOGBks2r2K3sLdA4mwUhAnel0CmuA5sAUnn6Q+/g3muKBcKdyaOES90LhwLYDD
         P4YZIvdMSkR51/QwIMgo7rQTayshNK/60KosFl57Fw+4qONWhfTi/oN1wY0sF+l/WQ
         uu92HqUuxsJN/JgI7JoKD2gkoHv8e3rYKn/z1N3ZH6T0MU6O0Qmt1TnlsX5HTw5tlM
         75FrorBnOeCjg==
Message-ID: <3803d836-c2d1-2fe0-3dda-cbfff604d619@stancevic.com>
Date:   Sat, 8 Apr 2023 11:24:59 -0500
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


Sorry hit send too soon, and then had hosting provider issues... the 
hypervisor clustering part[1] might not work on CXL 2.0


[1]. http://nil-migration.org/ds-nil-migration-p12.png



--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

