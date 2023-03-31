Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E0C76196
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCaSPf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCaSPe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 14:15:34 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8ED1D2CE
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 11:15:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 02F288C1C73;
        Fri, 31 Mar 2023 18:15:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 589848C2207;
        Fri, 31 Mar 2023 18:15:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680286531; a=rsa-sha256;
        cv=none;
        b=4RZMKfJcIZa1TtRP1KwCLsp+HTXPg4ooWHe8kSETVlF5ISYJIsFtvrWQ4U+MIBFEfkgzGI
        JXdmZV2Cbpaj5pUpxYzw11kv33GGFYALRXqByj5waCV1q4kt3kv4loEka6pFk0eUT+PGP7
        u7af8e1jBJMwDlWvm1mO5jfBRWhl0xcFO2o9ApUgvHyyi2ioSPAikbzgY7mOwJubCJr3bn
        N7GCmAe5o2wrC6fLS+/BMYbP738OpOS0jDor67l9F9rAXqrI57bgQ1V6CEIlrEoZ29nkTE
        kQvScDNWxvG58rIkkhI4RMc6t2CqmNsTtc19MHl4KW9q2SDjfzZdX2e0/3h5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680286531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=j3L24ZBsOLeH9lhPiSpkHV4mLNUGQbsSedwN/1vKxQk=;
        b=wJe7+4TaO6y8rYj7SXzOktb5jB8G3TOdwEhfD/JDLtyVkctk0DmlJYXtxCy1Xc0VhXgB6I
        QbrLwrCfLx/2smuqlKkf61W/rzpba0PZf4Wgj/GCqZHWcHk0mWzZJWGtQ7AVFk+/FSKLru
        R8fTAENQTBp+3KqUHWFAFrAQeXJFdNspqKwGLZf95/TnzgwWasVZTApyXoxgOZMvpWGBZb
        PSVodFY0lxc7wCaUjoByXycAWaRv1Ztr1AjycOsPaFIgLTDFn8oISZwk3/Y+LQMJY98PQn
        0gG9UJAYOgM4lZDEjOdtwaw9LSdC9Pj3XOX5TYVQfH+PRiF72mtM/+mPdlJlag==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-cbbfh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Robust-Vacuous: 2e12ef17570752d6_1680286531829_3437166632
X-MC-Loop-Signature: 1680286531829:4057621066
X-MC-Ingress-Time: 1680286531829
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.204 (trex/6.7.2);
        Fri, 31 Mar 2023 18:15:31 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Pp7kT6YxqzMG;
        Fri, 31 Mar 2023 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680286531;
        bh=j3L24ZBsOLeH9lhPiSpkHV4mLNUGQbsSedwN/1vKxQk=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=gR5MEgdb7Px/0UE4OozwE9efStked6+WaRQTWDR4U1cliSlvq4c8fmefT5KkTta3P
         ruBCkvKldb6bmbfpr391EOGtH5ZfO/TN5hIDUyYqrUKp7X4aVrYzDhHLGWGIaDNpND
         IWPnHmiLeemyof1oV5bsYCfFH8Up3XVZTkWTAtrJlCllUe/zjtXPbp6RHzeJBGDvDn
         XC3Sce29HisGwUraxZtWH5i/d63Vb/mX9byyxaxXPgeJmL0x5lV5GqcGXacuChppRY
         O8NnTfhahf0uQV2euhWLH6GLkCV7Bi3+G1cQpkvmPEh3NQaC+o/qkUS8J6QqnwzHZM
         5OX+vJC5OACsw==
Message-ID: <7447b9ed-f000-92f9-8044-afa65ef38ce5@stancevic.com>
Date:   Fri, 31 Mar 2023 13:15:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jerome Glisse <jglisse@google.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
 <CAAPL-u9w2K6q4nF6+VKxafZYNr1WqsROYCQc6gqVS0BVXt0-Bg@mail.gmail.com>
 <d733b3a4-757a-624f-18a4-ad27b1ef1f77@linux.dev>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <d733b3a4-757a-624f-18a4-ad27b1ef1f77@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 1/25/23 09:04, Zhu Yanjun wrote:
> 在 2023/1/24 8:57, Wei Xu 写道:
>> On Mon, Jan 23, 2023 at 4:22 PM Yang Shi <shy828301@gmail.com> wrote:
>>>
>>> On Sun, Jan 22, 2023 at 9:51 PM David Rientjes <rientjes@google.com> 
>>> wrote:
>>>>
>>>> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>>>>
>>>>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>>>>
>>>>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko 
>>>>>> <viacheslav.dubeyko@bytedance.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I believe CXL memory is hot topic now. I believe we have multiple 
>>>>>> topics
>>>>>> for discussion. I personally would like to discuss CXL Fabric Manager
>>>>>> and vision of FM architecture implementation. I am going to share 
>>>>>> the topic
>>>>>> in separate email. I would like to suggest a special session for 
>>>>>> CXL memory
>>>>>> related topics.
>>>>>>
>>>>>> How everybody feels about it?
>>>>>>
>>>>
>>>> I think this makes a lot of sense, thanks for suggesting it.
>>>>
>>>> Should this be a BoF or just a normal topic proposal?  I assume that 
>>>> there
>>>> could be several different topics of interest all related to CXL.mem.
>>>>
>>>> Specifically interesting would be the division of work between the 
>>>> kernel
>>>> and userspace to manage memory placement on systems with locally 
>>>> attached
>>>> CXL.  And, further, what APIs userspace would have at its disposal for
>>>> explicit optimization of this placement that would exist beyond what is
>>>> available for NUMA.
>>>
>>> Yeah, in addition, how CXL hierarchy interacts with memory tiering may
>>> be an interesting topic too.
>>>
>>>>
>>>> I assume we might also want to chat about CXL 2.0 extensions that 
>>>> would be
>>>> useful, especially for cloud providers.
>>>>
>>>> I'd be happy to join in any of the proposals for these topics, just 
>>>> let me
>>>> know!
>>>
>>> +1 for me.
>>>
>>
>> I am also interested in these discussions.
> 
> +1， I am interested in this.

+1, also interested in cloud aspects


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
