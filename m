Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20399C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiHLVDG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiHLVDF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 17:03:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368FB4409
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 14:03:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so1664827pfy.6
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=P4m7k47YmyqAxiXc+4hspvn7iQFtdR4E+xJ+AzfDovE=;
        b=YaUdcZRGFpR3L1DIlgZanvxWnQ2886+nyqcw+PqGxh0YmZo0sv8YPyr1+BimCsVWbg
         sHoZTUBaXWMGn0HqRKtpBL9dEwKvkfjv7tQCMCfh5K/Glwro18gQGBHuEUETmc8qLA0t
         DFuQ73xCjCEf03uhHUFn6BmLbXdhl+68JGiK9ea2AYHPAzisv/RP6Xk5K7PdxDYOkPum
         bmlPsCQFnTk2FcaWMi/s+DOY/5fEk7irFtXniSkAA0Ckkr3bZbhtrK4f3ogXJBfqTkzt
         JpdtaX7oLmEPoMBHcegqZWCReUFR/CCA33XKApY4H1B+LjvOxxFE2yxrN8KbO0jMPphW
         TXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=P4m7k47YmyqAxiXc+4hspvn7iQFtdR4E+xJ+AzfDovE=;
        b=szuskGtMIE0rUuIW6mGotsq+0TSF3TVqgKuOURVq/GoiJ3fidMHHKqOC8vVBqxl6FY
         skrfE24kzpM8bhO0XakehQSCxVBi82e5Hyopgcya4XDZJZV0lsH026A7CVlyXOnMf0eJ
         VPLbmwVJsSxj8pgXQrsRrPNHjVqbmSsW4qf+3dzbfpudP4UWkdGjBRfabGMULIwpQndL
         P/Dkp6M31bh3fexPBHC06ChcZlh5mY5tEo4cR/Wp3I2EtySZIN7wkQ7mvPR771n8CErk
         iQpOROkKMlC/Ak5jRDMbFJlbI0APG2To7FXh7wQiCk7ofBsBokNrKSqUR2O6N7OZaop+
         DPCA==
X-Gm-Message-State: ACgBeo0AXF7NMC6qYDzXI/3AKbUmy1sBDMMuWy++slH0s5U8DNo1+RLy
        b2TR+K3wsmktjMmfM84Bf+uO70SeElI=
X-Google-Smtp-Source: AA6agR6b/3BrLJzsw0mz73BZduLIQnTnltIA3iCkYNX+sT6yu0mryoraOZ4UVfWZfG3pKUX7otXsmw==
X-Received: by 2002:a63:1751:0:b0:41c:daad:4ad5 with SMTP id 17-20020a631751000000b0041cdaad4ad5mr4422380pgx.226.1660338183950;
        Fri, 12 Aug 2022 14:03:03 -0700 (PDT)
Received: from MacBook-Pro-91.local (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0016dd562430fsm2211529plg.120.2022.08.12.14.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:03:03 -0700 (PDT)
Date:   Fri, 12 Aug 2022 14:03:00 -0700
From:   Matthew Ho <sunfishho12@gmail.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH v4] cxl: Add list verbose option to the cxl command
Message-ID: <YvbABFtbrgU+oWcg@MacBook-Pro-91.local>
References: <20220812181224.89722-1-sunfishho12@gmail.com>
 <5454fd62ff977826d8f741377c942731e861f626.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5454fd62ff977826d8f741377c942731e861f626.camel@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 12, 2022 at 08:04:49PM +0000, Verma, Vishal L wrote:
> On Fri, 2022-08-12 at 11:12 -0700, sunfishho12@gmail.com wrote:
> > From: Matthew Ho <sunfishho12@gmail.com>
> > 
> > This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv.
> > 
> > cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
> > equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
> > cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
> > devices without having to remember which subcommand must be appended for each
> > type of device.
> > 
> > Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> > Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
> > ---
> > Changes since v3[1]
> > 
> >  - Fixed formatting of patch
> >  - Amended patch to apply to latest region driver patches [2]
> >  - Added missed "Acked-by"
> > 
> > [1]: https://lore.kernel.org/linux-cxl/20220722183705.26936-1-sunfishho12@gmail.com/
> > [2]: https://lore.kernel.org/linux-cxl/20220810230914.549611-1-vishal.l.verma@intel.com/
> > 
> > Maybe this could be added to the region driver series?
> 
> Hi Matthew,
> 
> Thanks for the update. I intend to pick up all pending patches in the
> next week or so in preparation for the v74 release, and I will include
> this.

Thanks, sounds great! I'll fix the changes in a v5.

> 
> One comment and small typo below - otherwise this looks good.
> 
> > 
> >  Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
> >  cxl/filter.h                   |  1 +
> >  cxl/list.c                     | 21 +++++++++++++++++++++
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> > index 2906c2f6ef4b..0e7727ca167f 100644
> > --- a/Documentation/cxl/cxl-list.txt
> > +++ b/Documentation/cxl/cxl-list.txt
> > @@ -336,6 +336,26 @@ OPTIONS
> >  --region::
> >         Specify the region name to filter the emitted regions.
> > 
> > +-v::
> > +--verbose::
> > +       Increase verbosity of the output. This can be specified
> > +       multiple times to be even more verbose on the
> > +       informational and miscellaneous output, and can be used
> > +       to override omitted flags for showing specific
> > +       information. Note that cxl list --verbose --verbose is
> > +       equivalent to cxl list -vv, and likewise
> > +       cxl list --verbose --verbose --verbose is equivalent to
> > +       cxl list -vvv.
> 
> I'd say a single example, of -vv is sufficient here.

Sounds good, will remove the -vvv example.

> > +       - *-v*
> > +         Enable --memdevs, --regions, --buses,
> > +         --ports, --decoders, and --targets.
> > +       - *-vv*
> > +         Everything *-v* provides, plus include disabled
> > +         devices with --idle.
> > +       - *-vvv*
> > +         Everything *-vvv* provides, plus enable
> 
> The above should be -vv

Oops, thanks for the catch, will fix.

> 
> > +         --health and --partition.
> > +
> >  --debug::
> >         If the cxl tool was built with debug enabled, turn on debug
> >         messages.
> > diff --git a/cxl/filter.h b/cxl/filter.h
> > index d22d8b1f798b..256df49c3d0c 100644
> > --- a/cxl/filter.h
> > +++ b/cxl/filter.h
> > @@ -26,6 +26,7 @@ struct cxl_filter_params {
> >         bool human;
> >         bool health;
> >         bool partition;
> > +       int verbose;
> >         struct log_ctx ctx;
> >  };
> > 
> > diff --git a/cxl/list.c b/cxl/list.c
> > index 5f604ecddf3c..8c48fbbaaec3 100644
> > --- a/cxl/list.c
> > +++ b/cxl/list.c
> > @@ -52,6 +52,8 @@ static const struct option options[] = {
> >                     "include memory device health information"),
> >         OPT_BOOLEAN('I', "partition", &param.partition,
> >                     "include memory device partition information"),
> > +       OPT_INCR('v', "verbose", &param.verbose,
> > +                "increase output detail"),
> >  #ifdef ENABLE_DEBUG
> >         OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
> >  #endif
> > @@ -106,6 +108,25 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> >                 param.memdevs = true;
> >         }
> > 
> > +       switch(param.verbose){
> > +       default:
> > +       case 3:
> > +               param.health = true;
> > +               param.partition = true;
> > +               /* fallthrough */
> > +       case 2:
> > +               param.idle = true;
> > +               /* fallthrough */
> > +       case 1:
> > +               param.buses = true;
> > +               param.ports = true;
> > +               param.decoders = true;
> > +               param.targets = true;
> > +               /*fallthrough*/
> > +       case 0:
> > +               break;
> > +       }
> > +
> >         log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
> >         if (debug) {
> >                 cxl_set_log_priority(ctx, LOG_DEBUG);
> > --
> > 2.34.1
> >
>

Thanks again for the feedback!

Best,
Matthew
