Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3235C25B50
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAXAWb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAXAWa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 19:22:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EA367E8
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:22:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v23so13179567plo.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ4oslfHB0qpcy2XO48k4CBtTAPuNjBPY2V6lCxjAoQ=;
        b=l+v3c67sQ6gkV2I8s7q8MhjFkAwrqJe26ugMi9mNmDs3XGfravmMc1I8VoJg+LQL8J
         ZRe6IHV/GG/9bl77MONp9DOgI3qOpRzuFthFGnYMEbU8GAJrHlAueFYpkRJLFv1izMdx
         +dSaSPSg4nBTBtDW2rkIVte2J9T+nAh+di3/DNVVd3FwRSJRKwldTLUdSsasJRIghVqH
         WlhfUjJa01OSJ9FcT3EPeu9m0GwkMk+8MIrKAfcZG2yvGKK5hmz6mWaMklOz/Hc2vwzN
         2EunoApDBBdNcwDleHd5A4+rcdX1ib9SUjMIbdApAmyonmHt7TAplvQt7/rWFBJm7A8J
         1Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ4oslfHB0qpcy2XO48k4CBtTAPuNjBPY2V6lCxjAoQ=;
        b=NJNiiJnfvwadgm6TBaSQhJWhLm7mqluF4sPs7YJIZk3c/QApZwshUGSsezoPI3czak
         XNU0s8rAsM3KK+/Zok4LyTz8cTsBhROKe1CM2kp5BtRtXVPJtv6hH9ebHYLiaNC9N0RY
         0MpIRYvibirUngHGtFgvXd7t/IgiucJDVsUePwJuhyfD/a07V1C270LzUUP1Qk7yRtem
         i+LzrGBsqVAJkjfcIT+zfeWafjID35L/91o4zA3hDtdR8HKE6rptYzhaDrUVkzwHap0G
         KG54PiZTdYKBC5umxVQu/PLcyPspLDndYqgvnWhibJhkCNxyzwR8j+JMkeDwaU/8GLwV
         8qtg==
X-Gm-Message-State: AFqh2kr72XeDjqE0XTqTFWpbyDBZFVudRvchx8DCx30eN6j4N0xU60fb
        bgA6Jx2zR5/QtblSWi9CXk3P0RgBV8182mmyM9s=
X-Google-Smtp-Source: AK7set/9VdBU6WV2PDZw3ApUtxb0xj/i3jUsBdc0OYxamODH8lZgUhWNRWnZtN3pjUUBE9Ad5GhcO6fIJRfQe07WGao=
X-Received: by 2002:a17:90a:1cc:b0:22b:e6e9:366c with SMTP id
 12-20020a17090a01cc00b0022be6e9366cmr249588pjd.38.1674519748675; Mon, 23 Jan
 2023 16:22:28 -0800 (PST)
MIME-Version: 1.0
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com> <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
In-Reply-To: <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 23 Jan 2023 16:22:17 -0800
Message-ID: <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
To:     David Rientjes <rientjes@google.com>
Cc:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Jan 22, 2023 at 9:51 PM David Rientjes <rientjes@google.com> wrote:
>
> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>
> > CC: LSF/MM/BPF mailing list. Sorry, missed the list.
> >
> > > On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
> > >
> > > Hello,
> > >
> > > I believe CXL memory is hot topic now. I believe we have multiple topics
> > > for discussion. I personally would like to discuss CXL Fabric Manager
> > > and vision of FM architecture implementation. I am going to share the topic
> > > in separate email. I would like to suggest a special session for CXL memory
> > > related topics.
> > >
> > > How everybody feels about it?
> > >
>
> I think this makes a lot of sense, thanks for suggesting it.
>
> Should this be a BoF or just a normal topic proposal?  I assume that there
> could be several different topics of interest all related to CXL.mem.
>
> Specifically interesting would be the division of work between the kernel
> and userspace to manage memory placement on systems with locally attached
> CXL.  And, further, what APIs userspace would have at its disposal for
> explicit optimization of this placement that would exist beyond what is
> available for NUMA.

Yeah, in addition, how CXL hierarchy interacts with memory tiering may
be an interesting topic too.

>
> I assume we might also want to chat about CXL 2.0 extensions that would be
> useful, especially for cloud providers.
>
> I'd be happy to join in any of the proposals for these topics, just let me
> know!

+1 for me.

>
