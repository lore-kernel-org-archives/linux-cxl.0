Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AECC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 00:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjAXA5d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAXA5c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 19:57:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127C2F79F
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:57:31 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b12so10312561pgj.6
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDCevwPHe22KehV2Fw/2ooqRxEd2Mfutg8NbPOnvlLY=;
        b=fiTBxHEVRR8vBMv5BeMz+Rx7jP3kVGRBNu7sbTS32rxU8+tIO6fsBV1lP244+dKD0m
         O2KtV4utU/G8gOPB6rYUSTi6a+zfaa1V71tEk4Lv8PXinaKLX+lMhUYPgMsUzURS+lgO
         BuuuR9gMPh5Q0VDni8OJG+M3hJTQMxYTs9p7D6DQNatX/CYkdCzJ0cDaBr/ragToJZyR
         iGbmeufANsBBRrHCIOic1FxN4ataY/0+x77yoob5AzW94uJFV56h4+FV7pR6SS18zefW
         tazgIGOfsaQitGJcmUIqVoAJ0ODLaC1l1FCt9V7R3xI68sxeZK/JQcBPOVe7ynhlxnK5
         e+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDCevwPHe22KehV2Fw/2ooqRxEd2Mfutg8NbPOnvlLY=;
        b=4Fba0kPNhaKT7PlC8VlvKqrOyJjkuSYApT4yy9M2CrdtLIdGpSS6AJk5gwhNIxbZaz
         b7W+mWT9pZfaNIGCnjUaigdAM+d1fUMHKIHMt76fw81A/SVUiVH02WgNRb77WaN1LGha
         mpcHe3DEnxyx3XG8hFveSFymBRHOHvvb+bZrRVrMXY7tGm5Jxvg/T6R6SXo8mTd3iC9M
         8YLFGdq6S/4bE1ADSesKcRty6IZQGBmn7HDlen2W49iSoTD/rXsCiLChrv7lN91BW/Uv
         9raXaSvfpwG927RdLGeY6LiaHh4uiGVx3QU/+7qtCgUkE0HWuE5XmQz+p8jglvYrkI/R
         gNGg==
X-Gm-Message-State: AFqh2krEuVllTJW4jAUtMHVOH3knk2Qx1a/UR69F3MVeMKr30T0Q8pt2
        TtYuQuGfBjWemS5GT3KWXIuHamFQeM4HFhu6B839kw==
X-Google-Smtp-Source: AMrXdXsyLYCFH0uyjgF8Cmn7bIBo28Zv0cRsFoKBkNvvq8b4+ip3R3nn/KxWa3J+gg2IbKcS8VGu3eHfSgfLn3py73o=
X-Received: by 2002:a63:fc4b:0:b0:4b7:3d31:95dd with SMTP id
 r11-20020a63fc4b000000b004b73d3195ddmr2477108pgk.93.1674521850730; Mon, 23
 Jan 2023 16:57:30 -0800 (PST)
MIME-Version: 1.0
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com> <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
In-Reply-To: <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 23 Jan 2023 16:57:18 -0800
Message-ID: <CAAPL-u9w2K6q4nF6+VKxafZYNr1WqsROYCQc6gqVS0BVXt0-Bg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jerome Glisse <jglisse@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 4:22 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sun, Jan 22, 2023 at 9:51 PM David Rientjes <rientjes@google.com> wrote:
> >
> > On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
> >
> > > CC: LSF/MM/BPF mailing list. Sorry, missed the list.
> > >
> > > > On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I believe CXL memory is hot topic now. I believe we have multiple topics
> > > > for discussion. I personally would like to discuss CXL Fabric Manager
> > > > and vision of FM architecture implementation. I am going to share the topic
> > > > in separate email. I would like to suggest a special session for CXL memory
> > > > related topics.
> > > >
> > > > How everybody feels about it?
> > > >
> >
> > I think this makes a lot of sense, thanks for suggesting it.
> >
> > Should this be a BoF or just a normal topic proposal?  I assume that there
> > could be several different topics of interest all related to CXL.mem.
> >
> > Specifically interesting would be the division of work between the kernel
> > and userspace to manage memory placement on systems with locally attached
> > CXL.  And, further, what APIs userspace would have at its disposal for
> > explicit optimization of this placement that would exist beyond what is
> > available for NUMA.
>
> Yeah, in addition, how CXL hierarchy interacts with memory tiering may
> be an interesting topic too.
>
> >
> > I assume we might also want to chat about CXL 2.0 extensions that would be
> > useful, especially for cloud providers.
> >
> > I'd be happy to join in any of the proposals for these topics, just let me
> > know!
>
> +1 for me.
>

I am also interested in these discussions.
