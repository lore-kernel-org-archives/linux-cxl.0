Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B3ECAAD5
	for <linux-cxl@archiver.kernel.org>; Sat, 27 Aug 2022 01:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiH0BKN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0BKM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Aug 2022 21:10:12 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F74B0EF
        for <linux-cxl@vger.kernel.org>; Fri, 26 Aug 2022 18:10:07 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id d14so1127061ual.9
        for <linux-cxl@vger.kernel.org>; Fri, 26 Aug 2022 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aiXjSA13WPgAPgKh7tM/zQRSomp+DQxma2fUgKyiYTA=;
        b=CHH3TpYZeHHoZQo5vDtO9cBAcWR65YEtTcknzN0diMBVDU1hE0wx6nWmfYLGO5qdiC
         4Int3FfaTf8w9EkJ10zfxlXAaUP4ltDsgASxownP57CEsSdM1OPwAVHMUzDMtZRFjWM4
         JWYz+sKeGH7giVNC2G2e/4L8yxEnoAlgqKhtLvTMorEbJKfSSkATO96mL+AIaSo/kqO4
         2Sc5I8Knt5bRnIFwLxOx2yfYlkRHvgc3UukD/JG2/7doElBXcn5uwAO4Rm811aeRogW+
         7dZDCueKUFE/iOypt6y+qfhCYBMPMMHT2tE/sIhHlJS9lSLtKNoMFB+uLDIVqv+6WKCC
         YOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aiXjSA13WPgAPgKh7tM/zQRSomp+DQxma2fUgKyiYTA=;
        b=BAe7tRbER3Je0p7jlPi/m8WZ1Rtsa+cwfpdA6+F+TWm8ZQRAeHFZaGYHPmwZNBXxzy
         aLw6YO3KAw2JtqsNUXrcSdDnsnFkNqls2RgeCe2BgsHtZgKU6uzjZZuqVkf6QVHIfcTj
         lvpcCZgU09QOK4pnBCBEPRUQeX4ohE3RUCOrWaLwcwTVkKxU2iCsj+eKTQ214mcrbkob
         jfribBfcMEXvCfOHOP2UaJr/v4LtA6PlxXsIyfReE5595Fvmpa2+tFdwvI4V3pZn8n8S
         uQhigRhWX07RyDf+nOGHajjUaKLVRKYrhH3G1Ew4DPTtEuf1e/RBS0xxnzOmICL2YVpq
         hxTA==
X-Gm-Message-State: ACgBeo1RC0dL56bn+X7mOkgs4dk5vU36nj1OnqA9+O16lo/dapu1+PUc
        OEJN4SuJX0UAUKjVJHeI5RZrhLwsfA5SwOpWxJFm6w==
X-Google-Smtp-Source: AA6agR48YHpjMmVrgshnD9gYygPhOH6EkRxMkk7dzB/R5x4NHW8gOjjrhmAjH66vLnRPNSgwRWbmq3VRTI7OQWx8UKw=
X-Received: by 2002:ab0:14ad:0:b0:39f:255c:2ea9 with SMTP id
 d42-20020ab014ad000000b0039f255c2ea9mr756082uae.52.1661562606818; Fri, 26 Aug
 2022 18:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220826223511.170256-1-alison.schofield@intel.com> <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
In-Reply-To: <Ywle+96kZr5Y6Kn/@aschofie-mobl2>
From:   David Gow <davidgow@google.com>
Date:   Sat, 27 Aug 2022 09:09:54 +0800
Message-ID: <CABVgOSkdXPw3yx=J+=YLxgu=0kpBGD5MvPJr0=_VO4jgrSBpPw@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: Allow trace events in modules with TAINT_TEST
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Aug 27, 2022 at 8:02 AM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> + David Gow - Submitter of the new taint type
>
> On Fri, Aug 26, 2022 at 03:35:11PM -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> > introduced a new taint type, TAINT_TEST, to signal that an
> > in-kernel test has been run.
> >
> > TAINT_TEST taint type defaults into a 'bad_taint' list for
> > kernel tracing and blocks the creation of trace events. This
> > causes a problem for CXL testing where loading the cxl_test
> > module makes all CXL modules out-of-tree, blocking any trace
> > events.
> >
> > Trace events are in development for CXL at the moment and this
> > issue was found in test with v6.0-rc1.
> >
> > Reported-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---

This seems fine to me: thanks for catching it. Test modules should be
safe enough to load for this.

Does the comment in tracepoint_module_coming() need updating as well?
https://elixir.bootlin.com/linux/v6.0-rc2/source/kernel/tracepoint.c#L650

Regardless, this is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> >  kernel/tracepoint.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 64ea283f2f86..5f17378c9dc2 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
> >  bool trace_module_has_bad_taint(struct module *mod)
> >  {
> >       return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> > -                            (1 << TAINT_UNSIGNED_MODULE));
> > +                            (1 << TAINT_UNSIGNED_MODULE) |
> > +                            (1 << TAINT_TEST));
> >  }
> >
> >  static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
> >
> > base-commit: 4c612826bec1441214816827979b62f84a097e91
> > --
> > 2.31.1
> >
