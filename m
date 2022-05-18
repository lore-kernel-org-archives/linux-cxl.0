Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiERSWh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiERSWg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 14:22:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACB6F4A7
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 11:22:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i8so2535100plr.13
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46ZJ/H7qr1UvzM+nOVlC8tBntfPV0jlbcM/4KYX1DdQ=;
        b=LWzFM62W2e4lwnDpoo9iO0Sv7QszHjuqycS/V3bYZeigGaMZ/IPcseBfG/y6cdVnlY
         lc8ZespX4lTXKYXtjoOByYbC3Bd5ZtKEzN4rrHPH0Q2yNInAO2YsYFMr1ngULIhnUIsA
         6UOnXxCGqVfMypi+UbyTEJ/nUs+TYyPgHmdsinsLxVEjA1M7aJnN2Kq39L2ObQYFfNSL
         UDsjnMxq5sPbASssGJc+h7L1GrzFTHkYp5SUGMkzcuGUII9MMNyMoe+hODLYIoiy6Zeu
         r9Zc7HvrjPVzK7B0I+naPYxWp10LFDCauAq6S5FFra14SgI+Ktl4dzdJjqTpmKqwA8Ve
         7n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46ZJ/H7qr1UvzM+nOVlC8tBntfPV0jlbcM/4KYX1DdQ=;
        b=I1vS5bVlb4Po1mDiD0IT/15XuytfeaAYyPigaieTWfvQrR3LKCOPJFzlIuGdlNjaNo
         6i9BIO4aLs0KjPBbVjSI0C6k9i5slDyNnoHbAAym+0DFwomUrukaaWuuPKt4RgnM4/nu
         FRjFMW67mC7H5WF5dizekE6WutErg7hvqd6zU7nkm7ijew/HoeC7k2C+TENjmzHLDglj
         xb3PJgF2wpHeUi+mPZJzXXXd0poMClekxlmoBTuVI3HOZrXMqOEod+Hd2BeTWUpCJPjw
         /1DgqE90ZCJGw+lOCXCGx3fcIc6fqnzTJV8YTF+u3aOTdo+uIHPKqASnMYm/uTthkNrL
         DxJQ==
X-Gm-Message-State: AOAM531hoViIBjJAs30J+LQRyMJ+L8ELDA3weE/xHX+vMXoyeWyCZvZR
        OlvlBozjixah/slG2DrmDrxko+zwonRb7BQh5bi0tA==
X-Google-Smtp-Source: ABdhPJxI+80M+1hMoKskJwiAlcMVN2028jNCgJooOzuP3bNA/cgP6lv6xjoDN3DgSJqcI1iSONJGVS7RVgnr7x7V0rY=
X-Received: by 2002:a17:90b:388f:b0:1dc:6e0f:372b with SMTP id
 mu15-20020a17090b388f00b001dc6e0f372bmr701463pjb.93.1652898154555; Wed, 18
 May 2022 11:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237928899.3832067.7236779148367594501.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220518172121.000001c0@Huawei.com> <CAPcyv4jkY4txmuxhTk5oebf6yhbCzrJM5okdssz9HJrnqsgXYg@mail.gmail.com>
 <20220518182050.00000963@Huawei.com>
In-Reply-To: <20220518182050.00000963@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 11:22:23 -0700
Message-ID: <CAPcyv4i9FRDt=3HfSzVfV_Q6-3ScRVBhRhtGd-XSBG=C=jnWBw@mail.gmail.com>
Subject: Re: [PATCH 06/14] cxl/pci: Move cxl_await_media_ready() to the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 18, 2022 at 11:02 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 18 May 2022 09:37:24 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Wed, May 18, 2022 at 9:21 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Thu, 12 May 2022 11:14:49 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > Allow cxl_await_media_ready() to be mocked for testing purposes rather
> > > > than carrying the maintenance burden of an indirect function call in the
> > > > mainline driver.
> > > >
> > > > With the move cxl_await_media_ready() can no longer reuse the mailbox
> > > > timeout override, so add a media_ready_timeout module parameter to the
> > > > core to backfill.
> > > >
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/cxl/core/pci.c        |   48 +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxlmem.h          |    3 +--
> > > >  drivers/cxl/mem.c             |    2 +-
> > > >  drivers/cxl/pci.c             |   45 +-------------------------------------
> > > >  tools/testing/cxl/Kbuild      |    1 +
> > > >  tools/testing/cxl/test/mem.c  |    7 ------
> > > >  tools/testing/cxl/test/mock.c |   15 +++++++++++++
> > > >  7 files changed, 67 insertions(+), 54 deletions(-)
> > > >
> > > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > > index c9a494d6976a..603945f49174 100644
> > > > --- a/drivers/cxl/core/pci.c
> > > > +++ b/drivers/cxl/core/pci.c
> > > > @@ -1,8 +1,11 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-only
> > > >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > >
> > > Curiously I see the pending branch no longer has this include
> > > (which makes sense!)
> >
> > It never had it before since there were no readq calls in core/pci.c
> > until this point.
>
> I meant the cxl/pending tree seems to have a subtle difference
> from what you have emailed out here in that the unnecessary extra
> include isn't there.  Editorial change I guess :)

Do you mean the cxl/preview branch? That's the only one that might get
work-in-progress patches, but 'pending' and 'next' should have 'Link:'
lines for everything that was pulled off the list. The pending branch
has not picked up anything from this series yet.
