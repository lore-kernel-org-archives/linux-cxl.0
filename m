Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689AC38142
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAWQYE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjAWQYE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 11:24:04 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57944EFA7
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 08:24:03 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6A0898C0C6A;
        Mon, 23 Jan 2023 16:24:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B04198C113A;
        Mon, 23 Jan 2023 16:24:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674491041; a=rsa-sha256;
        cv=none;
        b=CD+/CIhV1GPKuNib0ZSE6BEcJ9fNdYWcyJhyegPRnXMEoNbp/UkAUdGiIuiRnz2FFcYOeP
        LhT1XzmdtAO5aIuyW/DsxWz1euf6LXs46h7idMgQIxBQOqmI1zWZ9IifzkRUVvess3iv3G
        F0fWeFJExkRS5t7cR3v1XZwTizZkSbB+WeERdmA8qsXy4dz6/QF6U1ZHIntlXr3Is9Rbtm
        MvEkAadsdzv6CS3qRVvrfoNneZQX08oy43jET18BQglNfua42uPQT4kIduYY2PEE+Je+WW
        ozqX/7pQMu+gK5ibPE4cGf8UuVKzzdpRMhpMP/qVJ9WJFTG0LRNKG/56mhqCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674491041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6bJxkpSqRhgq1dwG0+DDS7aqfHGCC84JHwujNE2bIVU=;
        b=VpQaz6PMoY5V45jwjD+V58G+blqYp9drHEQGlRuaX6NNDW4pTP9+ztgyeLftWTKdfCFLCB
        4cHxszbIsJiQF/xXa5RNovUhl64jUcEwE72jOEo6OEyQcx4DAGqUyenSzIRv6RJ8whNSo9
        mqz8Au3ushVT3DGYACfJ9JX0JmFWK8o+2jzxbIJSNKnIwCDC9GsZ27XAoGO4iisMk2cGgX
        7S1RP8KFlU5sbtVHJeYkgTYPfX8dVTxDA6hD/QomaBeZHo2zu1GJlHoluKXCzpg5nW+HzW
        UphaXl0AYEyN48Fx8nHo6hTsrdzqgvYucuZgs3Us91RRxeDxXDu1GJxw6tBHQQ==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-rsl9k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Arithmetic: 5b6279806130b8a8_1674491042201_3897566151
X-MC-Loop-Signature: 1674491042201:1215177179
X-MC-Ingress-Time: 1674491042201
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.205 (trex/6.7.1);
        Mon, 23 Jan 2023 16:24:02 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4P0wQm5Stwz2j;
        Mon, 23 Jan 2023 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674491041;
        bh=6bJxkpSqRhgq1dwG0+DDS7aqfHGCC84JHwujNE2bIVU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=aQa+DWxiYp2TMM3N+1PJ4aShWBCPPN0plt1mb9vDJgpshtNHIi8G67uxdnzduoOhs
         du8HSUa6GnqEw6v9bO4yaarSQHQBzPTKFOe55gwqmSv6DG/R4yi1TkS2bQYN6yUQQF
         1cXoDSuHd4+zHw7qicFq4WVc1BSB04FI86gD0u8XaadoJC/crOtFtY+ozbIJggDyVQ
         8ZIMZkaO35DNyzMt5pOxfEtawP+nsVmenW/2AR/iawSF37fCLzN2m3HuHOhi8lBgNT
         Uo7FroLvCoQA/ANxJynGpIXuKUne0gPDzIa2nGudEf6lSpAURhjGo6Qb+abvki+v3V
         SbZJZd1D9xDwA==
Date:   Mon, 23 Jan 2023 07:57:23 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     David Rientjes <rientjes@google.com>
Cc:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
Message-ID: <20230123155723.g4ssh6denkav4tng@offworld>
Mail-Followup-To: David Rientjes <rientjes@google.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 22 Jan 2023, David Rientjes wrote:

>On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>
>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>
>> > On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
>> >
>> > Hello,
>> >
>> > I believe CXL memory is hot topic now. I believe we have multiple topics
>> > for discussion. I personally would like to discuss CXL Fabric Manager
>> > and vision of FM architecture implementation. I am going to share the topic
>> > in separate email. I would like to suggest a special session for CXL memory
>> > related topics.
>> >
>> > How everybody feels about it?
>> >
>
>I think this makes a lot of sense, thanks for suggesting it.

Yeah, considering all the CXL interest in last year's lsfmm, I think it would
be good to have a session.

>Should this be a BoF or just a normal topic proposal?  I assume that there
>could be several different topics of interest all related to CXL.mem.

fwiw last year there were 4-5 talks that directly touched on CXL (like half
day).

>Specifically interesting would be the division of work between the kernel
>and userspace to manage memory placement on systems with locally attached
>CXL.  And, further, what APIs userspace would have at its disposal for
>explicit optimization of this placement that would exist beyond what is
>available for NUMA.

+1

>
>I assume we might also want to chat about CXL 2.0 extensions that would be
>useful, especially for cloud providers.
>
>I'd be happy to join in any of the proposals for these topics, just let me
>know!

Likewise.

Thanks,
Davidlohr
