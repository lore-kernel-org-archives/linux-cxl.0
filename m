Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0673AC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Jul 2022 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGVRnX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiGVRnW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 13:43:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F382114
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 10:43:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so4960847pgc.12
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yjcpn75GzGNM7Zpnku6x2NJQAZqnA1vks1Cz6ADLpDw=;
        b=VhgoQuSluCeIDGfTuXEH1STKWNhjLO64ytvYkV8rQ8xzZR3CssLdYmdQhkLsmNWbuH
         Ft+Evc9z9K2wNfJXJQNOeGyxk99BNgfu8USTZOa9eFIB0Ad0qO3o4quvCNUVqBhkHyHx
         B6cqALV8aTe67qaQV2BUihtXHc7PXgONxDUYS1+f+voYo8RseqsfJPlXE1nmvoyw0w2a
         M91b2+ep7RiNIALwa/tN5QbaondxiZb1E8ULHeNSn/OLeVycG8AnFpNjvuh/lP7YHkDW
         RNE/UxuMzroz5wRZq5/1+uNzbqR9tONMVHj/I4mXlvGrU7awNikCuRY068PKDA9JtuQv
         eYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yjcpn75GzGNM7Zpnku6x2NJQAZqnA1vks1Cz6ADLpDw=;
        b=o4jYnDkdbaCR62NxANIeHe0Q3Forfc5MQNkgTVRxN9Drmhh1g5APKr6pIBdaRFW3Ov
         7TMvk22jen0y2CHzIMCfNhEoD42LGydTn/26kJ/pxQBjBZ1qqo/eUi252H3YPBxeg3ap
         xMMXO3KIj9Oe7Wdj6vebHo4a2XH2mWfizP7Cf2KjFMCvl4i8E36PnN3xx/r6d9qg1nue
         PcD9captihu6VMYfnIFDRSgajK0jRsicTd7w7HqMs0sIDahhROvVFgBUYah/iviL6l1i
         D46IwRrNzdHDyeWiHNki7P18RNo97Bi5CP/TMIJWK//9e7PlMWsYo42fgul0i7X9pn2s
         ZnWQ==
X-Gm-Message-State: AJIora9STnk0+nt0U3wqNqr+ViEH3mzFUJAiSUWa4pPBHcVu6yvYxNXq
        zU4cBXBan/c1GUYg/npHNiw=
X-Google-Smtp-Source: AGRyM1tTqrZpmFI7kjkOXDIG0HnnXvmlZvmhS5xqXfYZM/HWAJ4HSX5cwoDXIr2WEeFwGQ+cHtiKgA==
X-Received: by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id s1-20020a056a00194100b0050d807d530bmr1036364pfk.17.1658511800480;
        Fri, 22 Jul 2022 10:43:20 -0700 (PDT)
Received: from MacBook-Pro-91.local (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090ac21300b001f0368d7f41sm3682998pjt.26.2022.07.22.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:43:20 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:43:17 -0700
From:   Matthew Ho <sunfishho12@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com
Subject: Re: [ndctl PATCH v2] cxl: Add list verbose option to the cxl command
Message-ID: <YtrhtW7iEGBs6xKq@MacBook-Pro-91.local>
References: <20220721192447.16958-1-sunfishho12@gmail.com>
 <62d9e4e0d0d16_17f3e829497@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d9e4e0d0d16_17f3e829497@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 21, 2022 at 04:44:32PM -0700, Dan Williams wrote:
> sunfishho12@ wrote:
> > From: Matthew Ho <sunfishho12@gmail.com>
> > 
> > This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv, and
> > builds on this pending patch series that adds region listing support:
> > 
> > https://lore.kernel.org/linux-cxl/20220715062550.789736-1-vishal.l.verma@intel.com/
> > 
> > cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
> > equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
> > cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
> > devices without having to remember which subcommand must be appended for each
> > type of device.
> 
> Looks good, minor comments below that after addressing you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> > 
> > Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> > Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
> > ---
> > 
> > Changes since v1 (previously titled "Add list all option to the cxl command"):
> >  - cxl list -v, cxl list -vv, cxl list -vvv replace cxl list --all,
> >  providing greater control over detail of the output. --human has been excluded
> >  as it can be appended by the user.
> > 
> >  Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
> >  cxl/filter.h                   |  1 +
> >  cxl/list.c                     | 17 +++++++++++++++++
> >  3 files changed, 38 insertions(+)
> > 
> > diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> > index 2906c2f6ef4b..f069aee8c674 100644
> > --- a/Documentation/cxl/cxl-list.txt
> > +++ b/Documentation/cxl/cxl-list.txt
> > @@ -336,6 +336,26 @@ OPTIONS
> >  --region::
> >  	Specify the region name to filter the emitted regions.
> > 
> > +-v::
> > +--verbose::
> > +	Increase verbosity of the output. This can be specified
> > +	multiple times to be even more verbose on the
> > +	informational and miscellaneous output, and can be used
> > +	to override omitted flags for showing specific
> > +	information. Note that cxl list --verbose --verbose is
> > +	equivalent to cxl list -vv, and likewise
> > +	cxl list --verbose --verbose --verbose is equivalent to
> > +	cxl list -vvv.
> > +	- *-v*
> > +	  Automatically enable --memdevs, --regions, --buses,
> > +	  --ports, --decoders, --targets.
> > +	- *-vv*
> > +	  Everything *-v* provides, plus automatically include
> > +	  disabled devices with --idle.
> > +	- *-vvv*
> > +	  Everything *-vv* provides, plus automatically enable
> > +	  --health and --partition.
> 
> These descriptions can drop the word "automatically" without any loss of clarity.
>

Sounds good, will drop that in a follow up patch.

> > +
> >  --debug::
> >  	If the cxl tool was built with debug enabled, turn on debug
> >  	messages.
> > diff --git a/cxl/filter.h b/cxl/filter.h
> > index d22d8b1f798b..256df49c3d0c 100644
> > --- a/cxl/filter.h
> > +++ b/cxl/filter.h
> > @@ -26,6 +26,7 @@ struct cxl_filter_params {
> >  	bool human;
> >  	bool health;
> >  	bool partition;
> > +	int verbose;
> >  	struct log_ctx ctx;
> >  };
> > 
> > diff --git a/cxl/list.c b/cxl/list.c
> > index 5f604ecddf3c..4763c7c36024 100644
> > --- a/cxl/list.c
> > +++ b/cxl/list.c
> > @@ -52,6 +52,8 @@ static const struct option options[] = {
> >  		    "include memory device health information"),
> >  	OPT_BOOLEAN('I', "partition", &param.partition,
> >  		    "include memory device partition information"),
> > +	OPT_INCR('v', "verbose", &param.verbose,
> > +		 "increase output detail"),
> >  #ifdef ENABLE_DEBUG
> >  	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
> >  #endif
> > @@ -106,6 +108,21 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> >  		param.memdevs = true;
> >  	}
> > 
> > +	switch (param.verbose){
> > +	default:
> > +		break;
> > +	case 3:
> > +		param.health = true;
> > +		param.partition = true;
> 
> add a "/* fallthrough */;" statement here...
> 
> > +	case 2:
> > +		param.idle = true;
> 
> ...and here.
> 
> > +	case 1:
> > +		param.buses = true;
> > +		param.ports = true;
> > +		param.decoders = true;
> > +		param.targets = true;
> 
> ...and a "break;" here just because the ndctl project tries to follow
> kernel C-style.
>

Will combine this with David's suggestion to add a "case 0:", thanks for
the feedback.

Best,
Matthew

> > +	}
> > +
> >  	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
> >  	if (debug) {
> >  		cxl_set_log_priority(ctx, LOG_DEBUG);
> > --
> > 2.34.1
> > 
> 
> 
