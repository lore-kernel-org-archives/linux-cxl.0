Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B85C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiCQSWR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiCQSWR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 14:22:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43C220FE6
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:21:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 6so3271944pgg.0
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgHShvCBbkuWjOwVHcdy8uEmylGt44SKsFkYEWydfng=;
        b=DI1EDCDS6S/MxMDRrndh3MXltA1ssYrKs73GiRTEzTNHBMPZnyHCqbVeHUEB1qpHrJ
         OY3hklq/modBWir9wlH+9/n7d7WXPwp/2QNHS0U8npVbqpWL7YaC9uZ9omSl05TA2vbR
         Yo8Mci+dN+yaMFR4TuTlqQ1bVa6IjyedGyo6WVKkpMefsS2R6PEzmC9oncZHS4Vz1F5a
         2h3nqeU5QaPVwhFjYZn9G1ZTbqS8wapT+GD0Ac+B2rzU+3Icht9SCEWEoaS4uRTzPEbm
         klD0Wxmfq6mcIRa4xPulwSMFTC1RkZVBl82ZmrkqqNVq55CO/DM7iQiWyin9hJUDItkl
         F0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgHShvCBbkuWjOwVHcdy8uEmylGt44SKsFkYEWydfng=;
        b=JFLakJhe3hH6RMHet7Ovoi7WgBElavQpS5WXWlFOzCrJyY+EZZtQmTbogWu/4ksWVH
         oR2dwCNBWTj0Uy88Jt8RPEBTvFG4QDbhByaZiq3l0/Tw0Sr6Edf6BgrtChmTPcArF67D
         RTu/T2LTidnLbuMOm3JzJeiTLdbHWlImeLQD//X2DpI3aUsG46n1zxHzA9xQgVYY3ob3
         AYo73bRcorVqNC1xmZCKdojch9UdZjY/FNpDJlGazkbB5EB3CS1vMQUdByB7pcNQgLX8
         Z8L86YgJxtyM8CdUSah0qMo2ZP9Cdo8PczB7+9sGEpHzqIPonQAkhaDdqvcs3JDwhnwg
         FjBw==
X-Gm-Message-State: AOAM530f9YEdYyUFvGVtYNp2CAagw21ZMpY0TL/FUHZ8cbkxMN1nSmx+
        T69y1baFxu+bnJEDXc95IWQHW+pvr0IaQ+ePJ2aTHw==
X-Google-Smtp-Source: ABdhPJyBIMrLMyuq0JYagnLw2bf7HsFS0cg1PYyjzv25c0zsG1rXIhOeZCxW67nWMGvnAIzemv2f1wqIq23Bth6rPnk=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr4811294pgm.40.1647541259875; Thu, 17
 Mar 2022 11:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317175228.wpzot2nu4snc6bz6@intel.com>
In-Reply-To: <20220317175228.wpzot2nu4snc6bz6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Mar 2022 11:20:48 -0700
Message-ID: <CAPcyv4gyaLun3xeo+cp-KVedR1RrSErH9qSyJ=dpL0fYT+Dvww@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not fatal
 to cxl_pci
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 10:52 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-03-14 18:22:38, Dan Williams wrote:
> > cxl_dvsec_ranges(), the helper for enumerating the presence of an active
> > legacy CXL.mem configuration on a CXL 2.0 Memory Expander, is not fatal
> > for cxl_pci because there is still value to enable mailbox operations
> > even if CXL.mem operation is disabled. Recall that the reason cxl_pci
> > does this initialization and not cxl_mem is to preserve the useful
> > property (for unit testing) that cxl_mem is cxl_memdev + mmio generic,
> > and does not require access to a 'struct pci_dev' to issue config
> > cycles.
> >
> > Update 'struct cxl_endpoint_dvsec_info' to carry either a positive
> > number of non-zero size legacy CXL DVSEC ranges, or the negative error
> > code from __cxl_dvsec_ranges() in its @ranges member.
> >
> > Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
> > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pci.c |   27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 257cf735505d..994c79bf6afd 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -463,13 +463,18 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> >       return 0;
> >  }
> >
> > -static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> > +/*
> > + * Return positive number of non-zero ranges on success and a negative
> > + * error code on failure. The cxl_mem driver depends on ranges == 0 to
> > + * init HDM operation.
> > + */
>
> It shouldn't depend on 0 ranges, it depends on ranges matching existing HDM
> decoder ranges. I took a shortcut by just checking global enable originally
> because we didn't yet have code to enumerate decoders (anything else would be a
> crazy BIOS bug that's probably not worth working around).

Hmm, I don't see that as a shortcut. If global enable is set then
there is no requirement that CXL DVSEC matches the HDM decoder ranges,
if global enable is not set then the HDM decoder ranges are not in
effect.

This is what the new comment in cxl_hdm_decode_init() is trying to
clarify. My proposal is that Linux ignores the recommendation which I
think is trying to accommodate legacy CXL 1.1 software stacks which
Linux never had.

        /*
         * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
         * [High,Low] when HDM operation is enabled the range register values
         * are ignored by the device, but the spec also recommends matching the
         * DVSEC Range 1,2 to HDM Decoder Range 0,1 so, non-zero info->ranges
         * are expected.
         */
