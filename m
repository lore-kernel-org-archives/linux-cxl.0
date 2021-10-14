Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8EC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD57461053
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 22:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhJNWmJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 18:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJNWmI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 18:42:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CA4C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 15:40:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g14so6756066pfm.1
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9KSacPX0YLBd/Q4rz2kk8ZGHcfdRztuQaRQoTcyIx0=;
        b=COL/0CBbHLXxLxsHHWC3ZtTTtblqhcbhTbeyyJlDB8OovqrVkVlbCorjdhIet0coTF
         fJQma8IsI5jQwbP8z7q5xenD8bViIJoAeiIoQMuAVmQHFv32QHRNlnmPMNJ+jLghwZFg
         5YIb56BITx5tPU+4xDTHS5wc0BXtGriyJgmDS8Z8YnXl2mMLJV0yFbBAOpjJi7U/yz6F
         o9/swR+glhR0rNNS61LGwdQi6lfIQAOqlK9/85Z3m4HFqOojDs3tmdR+bGP/sPsyRdaW
         x9pKIEBnEL/Cu0KB0hV/2xMyPD2wp/51YuqexXhXKKzwL8tHcwWWo1QRNjOTiqCEUM4M
         P1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9KSacPX0YLBd/Q4rz2kk8ZGHcfdRztuQaRQoTcyIx0=;
        b=1iuU/kkJ+ImBMMRtZ6hEkXqtiGKgYI8NeJoP9afcfH9ENTR2Zsj165UrMw4DfhNLrY
         D+hGA6zmi97JIx9b8R+7ps6cw18rQuEGtMJD/EwaF/djwJfkmac+axVBj3rPV+iLTk6d
         lTYBTzQO4TE+FI7rtS6liUnHAWekApGDDdoqMogQevu9AVGE9cq9Qi+9pcUsmf6e84Ii
         qEsGTwjeOt/ypK1PtxS3vvymz2C1aAV7MT1/xiI+fcKRbgEBKphv2dCSS5JaoyzstYYX
         RsLqIy4VdATFTG/LE2Pq858SId08UPw9I5ZQMjzQsWRoisph/kNssOw/tugPOCwuPv4G
         ajcQ==
X-Gm-Message-State: AOAM531OjGTaC46ti+FAB2IWIaOnYBulacOCzOD0s42vRBH51ZxogSbp
        LtSm7a3FCPsX/qRdTOrUvBNXexGkyiq57l5EouMQXh5F/p8=
X-Google-Smtp-Source: ABdhPJyUBUypi8lCkjhVcZXkvYTm4V+DBHyLxb+8Qn46ZzEncN5bo1bUCABityche0LT9LteCi4nqY3LDwzLx8DhCQE=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr7800995pfb.3.1634251203204; Thu, 14
 Oct 2021 15:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com>
 <20211007082139.3088615-10-vishal.l.verma@intel.com> <CAPcyv4gRM_3UxQkKxLg_up-zNecyTjrvG1CAuJyF1Wd+9bwfUA@mail.gmail.com>
 <39a3f49daff50d8065e95cf4cd5ef4268d3a1c18.camel@intel.com>
In-Reply-To: <39a3f49daff50d8065e95cf4cd5ef4268d3a1c18.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 15:39:53 -0700
Message-ID: <CAPcyv4gH02T29-WQeRORgk6nfn250fY8q00x3aNh0c46V4YXEQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 09/17] util/hexdump: Add a util helper to print a
 buffer in hex
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 14, 2021 at 1:33 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2021-10-14 at 09:48 -0700, Dan Williams wrote:
> > On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > >
> > > In preparation for tests that may need to set, retrieve, and display
> > > opaque data, add a hexdump function in util/
> > >
> > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > >  util/hexdump.h |  8 ++++++++
> > >  util/hexdump.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >
> > If this is just for tests shouldn't it go in tests/ with the other
> > common test helpers? If it stays in util/ I would kind of expect it to
> > use the log infrastructure, no?
>
> Agreed on using the log infra. I was originally using it in the old
> test stuff, but right now there's no user for it.. However having
> something like this was nice when developing the early cmd submission
> stuff. Do you think it would be good to always do a hexdump with dbg()
> when under --verbose for evert cxl_cmd_submit? (and maybe even add it
> for ndctl_cmd_submit later too) Or is that too noisy?

It sounds good as an extra-verbose debug option. At least it would be
more personal preference that -v does not get any more noisy by
default and require -vv to get hexdumps.

> If we want to do that then it makes sense to redo with the logging api,
> else maybe jsut drop this until we have a real in-tree user?

That's always ok in my book.
