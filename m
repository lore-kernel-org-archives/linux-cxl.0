Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A616C433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 19 Mar 2022 02:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiCSCSF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 22:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiCSCSF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 22:18:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB61D418B
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 19:16:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so6267453pgg.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D08Z1IWz9Rg3EovO3txrE4trNz8pfjrO3FiGHLe0fY4=;
        b=ytR4qg4s2SdaHw8/60ZyYsEL+o0MRIroK8t+4vd3vQGGQXaeBVDHvH3pTQABA9fGBi
         bCihyBF80s3Jpjh7Y3DKCl1KKyHOqNwKxbGCwMxkRVjqURzdZOy5VjsXqZmJ3WJOIFQu
         q3wkWe/21ZbamwCwCyZI3wE31PY6RjER+iWkg7Ab/Gsv8cbtaZSqwt6ykijphlJNyr5Y
         F34gZ2L3GPCIeZXOUSTanaVMCf4xg2fvwi3J4JzTia3YvOPbvivj5GyOJ7f55UeUgKS1
         +KOYwGEYtOhQMS2diwevMr/AG+aD4LXvyI5cQN1YRWtRR5HeeaS6fGPwB4WdOtxofgaW
         /56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D08Z1IWz9Rg3EovO3txrE4trNz8pfjrO3FiGHLe0fY4=;
        b=UCAhxTXF/c7hgCOqSVgHFtAINYExiC6vbT9Oo/vbuLE6D+hePmA9IhNg36o54reT0A
         qIuP/fZVWf+lPTGy7ZPmPIlD11MUR3G9Irej1/NvbLrHsvZe5RGMY+MdbvGucGZdphro
         +vMcN8fiiYTwD0BfrZrpIhzlDVXjZUlk2aVkgBU657pVEXfC/Ju28PJYz3NnbhHKmEdI
         Waeevo/B2erpiuy3sooWAckH4KIfQ4FHKQMW08XqU/EVMXlJkhIXivpP39kNcSU9Vxzh
         DH7Zl+FN9Ox/XhdAIA63G64OBjIDA7ti+tLlaeAb6ntZzoguOibEaVx2YfThPbbVtA07
         Vm4Q==
X-Gm-Message-State: AOAM533KHHQvQbuy656pZWTlAz3vlAveT2TcHknc0TDlthhFXyp23K94
        lPRUXFj6BUAyLNtg40fkpxD1LkIUPNOJUOTYDjx9BQ==
X-Google-Smtp-Source: ABdhPJxjbPpaLzce2F7SnkU2gEItaDUIRrnZ3crLSMqW3AEXDwWPeMMccffFTXzj0DKBtHO4MLzewIY5EM3Jnp2zXkU=
X-Received: by 2002:a63:2a43:0:b0:376:4b9:f7e0 with SMTP id
 q64-20020a632a43000000b0037604b9f7e0mr9919730pgq.437.1647656204978; Fri, 18
 Mar 2022 19:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220316230303.1813397-1-ben.widawsky@intel.com>
 <20220316230303.1813397-3-ben.widawsky@intel.com> <CAPcyv4j60_puoCe6q2KqWo8f-HzfwumRtgXqyj1Jr9ht+SBhKg@mail.gmail.com>
 <20220318221200.2zj3b7paamsecshb@intel.com>
In-Reply-To: <20220318221200.2zj3b7paamsecshb@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 19:16:35 -0700
Message-ID: <CAPcyv4hVepdg06c6hFF5PL1UjeoHgB98CG-dsNCU-7biL3Un4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] cxl/core: Distinguish cxl_decoder into types
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 18, 2022 at 3:12 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > +struct cxl_root_decoder {
> > > +       struct cxl_decoder base;
> > > +       struct resource res;
> > > +       struct cxl_decoder_targets *targets;
> > > +};
> >
> > This is what I had started to mock up, I think the only differences
> > are no out of line allocations, and the concept that endpoint decoders
> > need to track hpa, dpa, and skip. What do you think?
>
> If we're going through the effort to separate them, I do think it's beneficial
> to pull out target also. Are you so much opposed to that part? What part of the
> out of line allocation do you dislike? It seems fine to me and keeps the alloc
> function fitting on one screen, for me.

Missed replying to this.

What's the benefit though? The size of the targets array will be zero
in endpoint decoders, so it's zero cost to keep them common.
