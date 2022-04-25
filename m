Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E3BC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Apr 2022 18:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbiDYTAi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Apr 2022 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiDYTAh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Apr 2022 15:00:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC5B8239
        for <linux-cxl@vger.kernel.org>; Mon, 25 Apr 2022 11:57:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y14so14888589pfe.10
        for <linux-cxl@vger.kernel.org>; Mon, 25 Apr 2022 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6o+SI4yj6/1QuIDP6FADkDckBUMPioD3y38MqpuhkSo=;
        b=P1K4PYS25TS0Jd/Wx1fojI8IZ5I9h3+RLAY7MrwpwNS/97M2bik+Fzj4uCxSceTFqC
         By1zfFuX/dRkCdeEJYZr+gPWBQpJmKS+xMan4GPia2P7HYavXB/ti79lxVJxwM7d4LM4
         aPK1RRSJ/R9VAaoblJjSjAtxHnDWIJPEq87p8VBqlTtFdSmnFgJdFtRWqMM0h49u6xc9
         rhrP0KJj3lMgZHRcTs+tyLa2KjZgBcbNipfstGdWxKKlnvCyT2TaW1Syc4TU9KG3ibtj
         4zHlVZKN7G/200mOGcecQer5k4ANX/oi0/zChwRmOOQUjYp8HN+wmH5LUUnSU34FuuRS
         Hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6o+SI4yj6/1QuIDP6FADkDckBUMPioD3y38MqpuhkSo=;
        b=eb7ynhhzRJMBOms98F5hgV0/sIlH5dzdf6rP25U+EBCJP601i7Vc1+b66ODIte/7Gc
         MmZDhd96sKWYr9zZYAh6/RSetIr6BGtbRfRCR8rJGXSnyf8zJITu7/LoY8RjX7cQyWJr
         OFi2zUkY04K5jEHCW4r+dcFyjyMS9WLvpIX6fbL8++SiOq4IjR0jgCWpJwarAok9u30e
         iT+19gdg0k2R2J9ukMvIo+TLOG5XXxDyxJSDDUCjvJKz3p/viQWFosEO4wS8LMep6XdG
         aDPTi4dGec+WM77LRhDN0Mgr5h205UYU690EINE2QRQH4WBIjJutkQdqN1NBmVeLA/l9
         Tf/g==
X-Gm-Message-State: AOAM533Q4OwMoFl7B22RHDeyO0aUKMv4BEY1nnHT3FeOH8S87dQ1CBe2
        YOVmc/r7WsEG7fGIth47PeGGiVVzoE9tKFUu/+TgjA==
X-Google-Smtp-Source: ABdhPJyUxljZXNAY57tBgo6I/sBtSCxjGKyLUSTbY3/eBgitnlYZPc3dWMb2Osy5fBb0Ykt3C3DNXYRbEpXXGPyfmdk=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr20248514pfb.86.1650913052859; Mon, 25
 Apr 2022 11:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3> <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
 <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com>
 <20220425103307.GI2731@worktop.programming.kicks-ass.net> <CAPcyv4i9ONW5w6p2P+E5rpw25_kmzpYf6SbmRM4+eP5hK4si-A@mail.gmail.com>
In-Reply-To: <CAPcyv4i9ONW5w6p2P+E5rpw25_kmzpYf6SbmRM4+eP5hK4si-A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Apr 2022 11:57:21 -0700
Message-ID: <CAPcyv4hT7TcTxV_x1hhp8zVev21SMMUO7o2NkJw5OozjDRO4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 25, 2022 at 9:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Apr 25, 2022 at 3:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Apr 23, 2022 at 10:27:52AM -0700, Dan Williams wrote:
> >
> > > ...so I'm going to drop it and just add a comment about the
> > > expectations. As Peter said there's already a multitude of ways to
> > > cause false positive / negative results with lockdep so this is just
> > > one more area where one needs to be careful and understand the lock
> > > context they might be overriding.
> >
> > One safe-guard might be to check the class you're overriding is indeed
> > __no_validate__, and WARN if not. Then the unconditional reset is
> > conistent.
> >
> > Then, if/when, that WARN ever triggers you can revisit all this.
>
> Ok, that does seem to need a dummy definition of lockdep_match_class()
> in the CONFIG_LOCKDEP=n case, but that seems worth it to me for the
> sanity check.

Thankfully the comment in lockdep.h to not define a
lockdep_match_class() for the CONFIG_LOCKDEP=n stopped me from going
that direction.
