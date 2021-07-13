Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80460C07E95
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jul 2021 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DD661361
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jul 2021 21:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhGMVmr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMVmq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jul 2021 17:42:46 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB9C0613DD
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jul 2021 14:39:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso356565ota.6
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jul 2021 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8KTx2Ose4pii2svCA/w8VRn4cl8pFgHnIkh+CmYJ2c=;
        b=LhD8xrWH6oVe/XomegABvQ+eubfFC84EkZ5vxhsOUQYHmsiHTpAYBPi2HaYGZftdul
         iwc0Nt0gmZSe0jCxTt9a1nS8VrYWL6EKZ0keGDuY+jCOWucD9thXM3tdNc7v43c/+UiZ
         zixzPECfFeyFEKe4PoBkHgTyW+XTnBiMr86PlkPem5R4XBXKcWTQC/zEECHRTVoaDDfB
         z55n+AJ2rBrt+aKwpn6CAlZBOSUZ2qS6mO0m5feAcfbp24S/XDySFnFykQWjAVQp/vCM
         Nx+n3kCkJBaqW8tEvmMYGiLGkAYVOt8vuD6V54WEF70Ieb+6vkwWCOMHhkLHsv3sE1h/
         oTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8KTx2Ose4pii2svCA/w8VRn4cl8pFgHnIkh+CmYJ2c=;
        b=Ly1KDU1qMeSBuDkg6qEtsnHygluNs0cwqtjVCOwXaJ95so53hIfz63kU/scVULgfxy
         OWXO4pIBBXJYbJWzISQpmBKRkcr4VUWR5HSjGWyio1jFFKdrE35pHzR3ynf32scGR0oI
         jQnuJojLi6nvvjXSH/+pmxdiITzXf4RTBfi61O8707CqblyTXfd6i6OSArU6s+eDKDJv
         p3x99zcLZFgAgEb9ShqMWB3+8MvNJk8wGb+QKKz/Rei3SKV0NQ8Tjiy7R0ZyIUat+qZN
         e6LNuprR1tNN2St4czSB35BH1RGGWb+SwLucVpCD0u/lk/SD+7h6sZmGSztsaQae0JBF
         SsBw==
X-Gm-Message-State: AOAM531C14I6mNDXEuNuBiTfynAzCsK3Q5zmN5Fbsu8jw4L4A3nwhL6A
        5IjCEcCjjOiZd+V8Q+gV/p3AEb/Knc9W8KH5WPEL2w==
X-Google-Smtp-Source: ABdhPJxBld5GnnB8xBhBT0x95VtLs5hBAuTy2WWsMchLrqn2Gwf/49bHWAk2TmcrGTERUlsC7dkwPnGsPf84Hqoyhjs=
X-Received: by 2002:a9d:8d3:: with SMTP id 77mr5328637otf.6.1626212396000;
 Tue, 13 Jul 2021 14:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
 <20210701201005.3065299-5-vishal.l.verma@intel.com> <CAPcyv4iyhpSYkDKYDjWP61PaahtZrn3pGh7NnfC6jDaNbVEu+w@mail.gmail.com>
 <14151c2efffe947103b881da5bbf38212786aa59.camel@intel.com>
In-Reply-To: <14151c2efffe947103b881da5bbf38212786aa59.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Jul 2021 14:39:45 -0700
Message-ID: <CAPcyv4jpwCK5VUgpc8LBXN=ELxFLQkA7EkTENGfnYSwoHpYPfA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 04/21] libcxl: add support for command query and submission
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 13, 2021 at 2:17 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Mon, 2021-07-12 at 22:12 -0700, Dan Williams wrote:
> > On Thu, Jul 1, 2021 at 1:10 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > >
> > > Add a set of APIs around 'cxl_cmd' for querying the kernel for supported
> > > commands, allocating and validating command structures against the
> > > supported set, and submitting the commands.
> > >
> > > 'Query Commands' and 'Send Command' are implemented as IOCTLs in the
> > > kernel. 'Query Commands' returns information about each supported
> > > command, such as flags governing its use, or input and output payload
> > > sizes. This information is used to validate command support, as well as
> > > set up input and output buffers for command submission.
> >
> > It strikes me after reading the above that it would be useful to have
> > a cxl list option that enumerates the command support on a given
> > memdev. Basically a "query-to-json" helper.
>
> Hm, yes that makes sense..  There may not always be a 1:1 correlation
> between the commands returned by query and the actual cxl-cli command
> corresponding with that - and for some commands, there may not even be
> a cxl-cli equivalent. Do we want to create a json representation of the
> raw query data, or cxl-cli equivalents?

I was thinking it would purely be a list and association of that to
whether there is a cxl-cli helper for it is left as an exercise for
the reader. Especially when there may be commands that are upgraded
versions of existing commands and cxl-cli handles that difference in
the background.

>
> > >
> > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > >  cxl/lib/private.h  |  33 ++++
> > >  cxl/lib/libcxl.c   | 388 +++++++++++++++++++++++++++++++++++++++++++++
> > >  cxl/libcxl.h       |  11 ++
> > >  cxl/lib/libcxl.sym |  13 ++
> > >  4 files changed, 445 insertions(+)
> > >
> > [..]
> > > +static int cxl_cmd_alloc_query(struct cxl_cmd *cmd, int num_cmds)
> > > +{
> > > +       size_t size;
> > > +
> > > +       if (!cmd)
> > > +               return -EINVAL;
> > > +
> > > +       if (cmd->query_cmd != NULL)
> > > +               free(cmd->query_cmd);
> > > +
> > > +       size = sizeof(struct cxl_mem_query_commands) +
> > > +                       (num_cmds * sizeof(struct cxl_command_info));
> >
> > This is asking for the kernel's include/linux/overflow.h to be
> > imported into ndctl so that struct_size() could be used here. The file
> > is MIT licensed, just the small matter of factoring out only the MIT
> > licensed bits.
>
> Ah ok let me take a look.

I would certainly limit to just copying struct_size() for now and not
try to pull the whole header. If it turns into a larger ordeal and not
a quick copy feel free to table it for later.
