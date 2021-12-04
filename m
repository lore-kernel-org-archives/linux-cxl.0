Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DDC433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 02:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhLDCUq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhLDCUp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Dec 2021 21:20:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B868EC061751
        for <linux-cxl@vger.kernel.org>; Fri,  3 Dec 2021 18:17:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id k26so205733pfp.10
        for <linux-cxl@vger.kernel.org>; Fri, 03 Dec 2021 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAVZHhKiwxe8o9CR1A1cC3pUTmxpa3Rj/7ZFA7ByBh0=;
        b=8L9zEC3jnT2QrbcmdqqpRW3Aq8KtU58y5rKiTDmhCXhczFM+AhIrk4tIHVKwM9I28Y
         ykLAmWtv6Qusj64bgClDsn/mxrU3whj4v3hY5lCLMabIwjEaIUrThTpaeUuCEmy8hNZQ
         yko8QZFMUE8nSlujrlXLsIp/uolWajhJNi4IXbR+a6YqBAgwTHGR1lv5LU49UMFhOEJ9
         V4U3rTf8enMwYYr9/tnrwZiR9YZyPX3xlCAhIdcel6KtUeEDROggT2J0MLNdNA/2gUm1
         01Wqxx440d5knMI4iuBrkWSRlIjd2V8KOYiAhnJEJeE/jywBKnH6rCR35VGN1tHK7yms
         9Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAVZHhKiwxe8o9CR1A1cC3pUTmxpa3Rj/7ZFA7ByBh0=;
        b=VhBwyyEIk7EEW99uasoHEpd1AtnvG2LJftOFUSOHSVW5L4elsxCuPERNmYvydsfZ1x
         GaRVx2Vyad1bI8NECQXyR3apibx04U8zTPa9x1G3PkEpX7S0W1MsCLFHIf4Oxw6d/GPx
         4IY8dl6V89VpVw15AbyHP8tc9WIO3+SAUBHzOmMsvXPClULqT/qPkb4F9oqajKooGgkn
         GGbp8DnsPdcxmqGhhqc+T+POWrStG/LJJWEywG3DDpyPA2VyK1VyuKQf33hDJu8h3jF5
         v45GA0gNXNEBIe/HxGm4PSkZ+gvO8ktksWcexc33PuOm77a1HV1DdQWwXqyHyZhLBkXO
         ujmw==
X-Gm-Message-State: AOAM5333QKoxEPKo1tqG4QEZLm3M0pZ5sCCucZowk1hWyuL7PvMVs4r4
        x6j7Bs5aEFjLdsl/ERMYmUfKYQwVubo8hHn0yM4Tiw==
X-Google-Smtp-Source: ABdhPJw1nBuR6Fw8JKD1nhk9dE7eepf/LQDXytlKAFboaR1vUjgJe4FrQGtF7pJMRkETCydFXGpXxGtDBAApRWO4NRQ=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr23295388pfe.86.1638584240066; Fri, 03
 Dec 2021 18:17:20 -0800 (PST)
MIME-Version: 1.0
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163855974164.1338601.11643774914793606293.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211204013659.helfmgrwu2e44e7n@intel.com>
In-Reply-To: <20211204013659.helfmgrwu2e44e7n@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 18:17:11 -0800
Message-ID: <CAPcyv4haLct7SrvbO88dmcQESg4qj=9-GpG9_x5YO75uMWeLpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cxl/pci: Implement Interface Ready Timeout
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Dec 3, 2021 at 5:37 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-12-03 11:29:01, Dan Williams wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > The original driver implementation used the doorbell timeout for the
> > Mailbox Interface Ready bit to piggy back off of, since the latter does
> > not have a defined timeout. This functionality, introduced in commit
> > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
> > the recent "Add Mailbox Ready Time" ECN timeout indicates that the
> > mailbox ready time can be significantly longer that 2 seconds.
> >
> > While the specification limits the maximum timeout to 256s, the cxl_pci
> > driver gives up on the mailbox after 60s. This value corresponds with
> > important timeout values already present in the kernel. A module
> > parameter is provided as an emergency override.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: add modparam, drop check_device_status()]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pci.c |   34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8dc91fd3396a..519795432708 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1,7 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/moduleparam.h>
> >  #include <linux/module.h>
> > +#include <linux/delay.h>
> >  #include <linux/sizes.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> > @@ -35,6 +37,19 @@
> >  /* CXL 2.0 - 8.2.8.4 */
> >  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> >
> > +/*
> > + * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > + * dictate how long to wait for the mailbox to become ready. The new
> > + * field allows the device to tell software the amount of time to wait
> > + * before mailbox ready. This field allows for up to 255 seconds. 255
> > + * seconds is unreasonable long, and longer than other default timeouts
>
> s/unreasonable/unreasonably

yup.

>
> > + * in the OS. Use the more sane, 60 seconds instead.
> > + */
> > +static unsigned short mbox_ready_timeout = 60;
> > +module_param(mbox_ready_timeout, ushort, 0600);
> > +MODULE_PARM_DESC(mbox_ready_timeout,
> > +              "seconds to wait for mailbox ready status");
> > +
>
> It's a bit of a weird thing to set as a modparam since it's not module specific,
> but device specific. However, I suppose it's better than hardcoded 60s and I
> can't come up with a better alternative. Perhaps mention this in the commit
> message?

The individual device timeout doesn't matter.

"This timeout is the singleton 'Linux' policy."

Does that clarify?

>
> >  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> >  {
> >       const unsigned long start = jiffies;
> > @@ -281,6 +296,25 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
> >  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >  {
> >       const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> > +     unsigned long timeout;
> > +     u64 md_status;
> > +
> > +     timeout = jiffies + mbox_ready_timeout * HZ;
> > +     do {
> > +             md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > +             if (md_status & CXLMDEV_MBOX_IF_READY)
> > +                     break;
> > +             if (msleep_interruptible(100))
> > +                     break;
> > +     } while (!time_after(jiffies, timeout));
>
> One thing I noticed after I wrote these using time_after... time_before_eq()
> might be a better fit. I'm slightly annoyed both APIs exist, but...

I don't think an occasional extra 100ms matters.

>
> > +
> > +     if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> > +             dev_err(cxlds->dev,
> > +                     "timeout awaiting mailbox ready, device state:%s%s\n",
> > +                     md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
> > +                     md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
> > +             return -EIO;
> > +        }
> >
> >       cxlds->mbox_send = cxl_pci_mbox_send;
> >       cxlds->payload_size =
> >
>
> All in all, LGTM

cool.
