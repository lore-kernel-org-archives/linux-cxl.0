Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F242C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 23:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjESXgZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 19:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjESXgX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 19:36:23 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059361BD
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 16:36:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 28512500FB2;
        Fri, 19 May 2023 23:28:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 937CB501528;
        Fri, 19 May 2023 23:28:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684538900; a=rsa-sha256;
        cv=none;
        b=zc3eRKi2uwpqg9e3fS3E64gckvTbSj2iqhwiCc95Yj4I4gJZeRjpYh/yaTO38FtOKX6EA9
        fW7pPyDiiAOJRGroD270Rtu7H4aQwFSqrd3aPcF3x9XxNJduxxTaAg3I5PR2xq1ZfC4CZW
        oWPVkdoQFeskvQOiv5JKof4lUm83krjW9NsN9ZeFbjey8LODnA+sXH1hu5ox877ns9a7jM
        Umx4MAe4ujr+rOLtR1VSxTo6k/gjq/3w45GAD9eJCS2hIiaozRRjPscNEH/+6xaABLFf39
        OLN+gUjIKQkCaTCDv04cBsW62jJYQpMiqSSvdfKVl4QrOcIzvMjPdCM2t818EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684538900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BTY1nVHIWaKNRTnld8EcGBN+NzVKL2PtN7tw4OrKpwk=;
        b=tOkoesqhCNM3wHeCWJjBaieES/LytyNN4+exPI3DmNKldmUkloAemzEeG3MWR6zCbGb9Ho
        L6jgJ790Tmcyw4ty9tQsIDnnqnN/FmjFyZwJ1gABnm1JVnjqDSzDXZ7u3x5bkasMuYUzrN
        lTdEzjTTVB7O/+PmxiK4iZLWLpbLrduP+b/O5XWLYSv+dclOYiLM6M3+uK1Rk/SYjFOd6x
        L+o/YRNmDNl+KjHkVG+eAeVHmiKgk2sIBMmj4DPATlDaf/HWraBWjQkzUrSpxTezFq/SmF
        s7c2poH0bu0HiFYJT3Vzi6uq1YJwW8R0OX+Qk0XAJitHhnXWXn6eQRVLy68uTQ==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-fb6gl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Gusty: 376e23904c13b070_1684538900970_2789901594
X-MC-Loop-Signature: 1684538900970:1839786600
X-MC-Ingress-Time: 1684538900970
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.166 (trex/6.8.1);
        Fri, 19 May 2023 23:28:20 +0000
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4QNNLq33qfzBY;
        Fri, 19 May 2023 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684538900;
        bh=NMYbsLr7kvwYorBJBiuvVPD9JqnmnD9bl6hqFM3z3R4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CW2Astoz5aH1FIFjI4pKUoyU/74GPwP1Hdi+LeXib5BIAmR8/Fb7QMZFtET27GeK4
         A/CAe46nd0egr9m9iHcgtgUF5AiqC+b7VQLSjmMe8tMi2UYKvYKdt7uTYd7UjYfyVD
         MZMDcssIO5ElF5bNEN02nOhQVkvPCnncIeNb2WW1nTsnvBdOTxoyR7zXlZIR/IK2zb
         7JJ1ux3m5PFSEo7qF0YgWAjn4HXNZm+kcZu/LNmbK9VI7t3Rwz9QzGEG8p6mu/HzE8
         NWrcr81ysPO35ppm+FuR0M8QcYlUxI7FSuwVDGoWTzGIE+ORauST2gW7VBFt2zk/Mx
         oAzwWsNzfVWaw==
Date:   Fri, 19 May 2023 15:55:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH 1/3] rcuwait: Support timeouts
Message-ID: <lmlp2meczedtkxdlv7gnbom232nnn7mrx2xejhpufphhzljxvl@2ox2qf4skxqg>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-2-dave@stgolabs.net>
 <6467ec6ae116d_682c12942e@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6467ec6ae116d_682c12942e@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> Introduce rcuwait_wait_event_timeout(), with semantics equivalent
>> to calls for the simple and regular waitqueue counterparts.
>
>So my first reaction to this is "what is rcuwait, never heard of that
>before?", and "how did Davidlohr find this facility and why does he
>think it suitable here?". Then I go to read the history to get smarter
>about this thing and the author is: Davidlohr Bueso <dave@stgolabs.net>,
>aha!
>
>The critical insight for me was:
>
>https://lore.kernel.org/all/1484148146-14210-2-git-send-email-dave@stgolabs.net/

Just a general note that per

154abafc68b (tasks, sched/core: With a grace period after finish_task_switch(), remove unnecessary code)

... that the exit_notify() caveat no longer applies.

>...i.e. that rcuwait is suitable for waiting for a condition to fire
>while holding another exclusive lock like a mutex() as is the case with
>the CXL mbox code. Did I get that right?

Yes. For this particular patchset it made sense to go this way in terms
of semantics (this use-case is obviously not a performance sensitive path,
nor do any of the rt benefits of not having to deal with a q->lock).

>My recommendation would be to include some text like "Recall that
>rcuwait is suitable in this scenario because..." reminders at least
>until more driver people understand when and how to use it.

Sure.

>> Cc: peterz@infradead.org
>> Cc: mingo@redhat.com
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>> Only cc'ing sched folks this patch to avoid spamming. fyi the actual user
>> comes up in patch 3 (cxl/mbox: Add background cmd handling machinery),
>> but found a few other potential users in various drivers, so more could
>> be added.
>
>FWIW this looks like a straightforward addition of timeout support to
>rcuwait_wait_event() to me.
>
>What acks are required to take this through the CXL tree? Or are you
>the rcuwait maintainer?

No, I am not the maintainer, changes have been routed usually through
tip folks. Conceptually at least I think Peter was ok with it, but
ultimately an explicit ack/nack would be required.

Thanks,
Davidlohr
