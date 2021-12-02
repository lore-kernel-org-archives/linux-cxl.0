Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE1DC433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 17:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhLBRgc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhLBRgc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Dec 2021 12:36:32 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD5C06174A
        for <linux-cxl@vger.kernel.org>; Thu,  2 Dec 2021 09:33:09 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so263351pfc.1
        for <linux-cxl@vger.kernel.org>; Thu, 02 Dec 2021 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvp5ZZVf+gFRB813QRMn+idf2w6LTz+G1DUVGRquWsE=;
        b=mx/49XS+lFKNnV0zoFbWseMDJKn031DyN2y0q4Roe7lmuAsrtGvg0tvG+0DTkEjoub
         HAPqsfS1VE0MeY1GRqRpdCyZro8ajNkmasFLglkSYg5X0lrm2VL773ICbxZ62yD40PTg
         ddH9p/gHTTX4oto8KR/Fhnm1mtWs5m2JGb8Lpp+IAALyXvbllj/C7S6tYT8paOGSzvZl
         L3iCnUYQ7pGP5GmkUEGFSlAEYUznpxu0Zy1CAZ3FDh/suTd9//SvJTuhXjQfZQyYTlKX
         MKSqMwg1ngdmGETc0XjY73YqI8iT9q4W6SMBwrH5GcAt5q5sNlh1Fgbz2q0+plNS1LM2
         xJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvp5ZZVf+gFRB813QRMn+idf2w6LTz+G1DUVGRquWsE=;
        b=07phCKhEgKrvN8a27h1hpWCDYrCBDozcQ4A42ugmChgD1pJ/57DwqIuiIwLGSPPBAm
         td2LKcqZ1+cUR/FidihVUkF9Q2GoONanhwDidW7K9XJ95LcI1Qf3ijv3pRYvDihsQw6w
         4HgNA/OFoLACIvFOLzNKWyXDiRzikWY/04YCzU63A8tTAjc17LbvprlDhel35WBsMSX+
         lrMl5kP5wJRD4FQmLzZij2HrTR1NND6BRegPcFtt1yIAB04MIWtuYfiwKf2ggIIyp2/W
         LKQiKQhJODXZBTLS4lcuJrrBbdeIEw7KYHe/fxpcR4/fgNTnBmubIyDSb2TkbExLc0ms
         vMyg==
X-Gm-Message-State: AOAM532AxOqyyaMfM33ZH31e9s5SLyZ+Ycl7+wbsCxHxqg1W9SFzYUbU
        Bwag3HR216/H/CF4yzgbHQgZ1ruAwdxtcJ5fmzRBOA==
X-Google-Smtp-Source: ABdhPJyLIXC9t1T12KFbYq+ZoF3iImpOl6ATm0i8hTORWbT71nfyhBhl3Qw9W05JW9JtPQL39r74U/JhPEwcKUb0oeg=
X-Received: by 2002:a63:5357:: with SMTP id t23mr472658pgl.40.1638466389226;
 Thu, 02 Dec 2021 09:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
 <20211129214721.1668325-4-ben.widawsky@intel.com> <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
 <20211202172435.2f5hlz22cea4l3a3@intel.com>
In-Reply-To: <20211202172435.2f5hlz22cea4l3a3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Dec 2021 09:32:59 -0800
Message-ID: <CAPcyv4h-_bLrZKdSDEozK=2mPRnFsKPtg-iirx8qCEk6Kdk6-w@mail.gmail.com>
Subject: Re: [PATCH 3/9] cxl/pci: Extract device status check
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 2, 2021 at 9:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-12-02 09:09:44, Dan Williams wrote:
> > On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > The Memory Device Status register is inspected in the same way for at
> > > least two flows in the CXL Type 3 Memory Device Software Guide
> > > (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> > > and 2.13.10 Media ready sequence. Extract this common functionality for
> > > use by both.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
> > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index a6ea9811a05b..6c8d09fb3a17 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> > >         return 0;
> > >  }
> > >
> > > +/*
> > > + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> > > + * Device Software Guide
> > > + */
> >
> > This version did not address the feedback about referencing the CXL
> > specification instead of the software guide.
> >
>
> Apologies, I missed that request. I apparently missed your email entirely as I
> was going through the revision.
>
> > > +static int check_device_status(struct cxl_dev_state *cxlds)
> > > +{
> > > +       const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > +
> > > +       if (md_status & CXLMDEV_DEV_FATAL) {
> > > +               dev_err(cxlds->dev, "Fatal: replace device\n");
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       if (md_status & CXLMDEV_FW_HALT) {
> > > +               dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> > > +               return -EBUSY;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /**
> > >   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
> > >   * @cxlds: The device state to gain access to.
> > > @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> > >          * Hardware shouldn't allow a ready status but also have failure bits
> > >          * set. Spit out an error, this should be a bug report
> > >          */
> > > -       rc = -EFAULT;
> > > -       if (md_status & CXLMDEV_DEV_FATAL) {
> > > -               dev_err(dev, "mbox: reported ready, but fatal\n");
> > > +       rc = check_device_status(cxlds);
> > > +       if (rc)
> > >                 goto out;
> > > -       }
> > > -       if (md_status & CXLMDEV_FW_HALT) {
> > > -               dev_err(dev, "mbox: reported ready, but halted\n");
> > > -               goto out;
> > > -       }
> > > +
> > >         if (CXLMDEV_RESET_NEEDED(md_status)) {
> > >                 dev_err(dev, "mbox: reported ready, but reset needed\n");
> > > +               rc = -EFAULT;
> > >                 goto out;
> >
> > It also did not address the feedback that the reset needed check can
> > be dropped because per the spec* it is redundant with the other checks
> > above. The driver need not give up on mailbox commands just because
> > the media is not ready. So this wants a lead-in patch to clean that up
> > first.
>
> Media ready droppage comes in the next patch. I can reorder them if you'd like,
> or I suppose you could do it.

Sure, I'll reorder.

>
> >
> > "This field returns non-zero value if FW Halt is set or Media Status
> > is not in the ready state."
> >
> > Going further I do not think the driver should preemptively abort
> > commands due to device-fatal, or even firmware halt for that matter.
> > The true sign of failure and dead firmware is timed-out responses to
> > incoming commands. Just in case there are some commands still
> > functional in a device-fatal condition, or the firmware-halt indicator
> > was a false positive, let the command through, and then if it fails
> > report these forensic statuses.
>
> I admit I'm not looking for spec reference at this exact moment. I think trying
> to throw commands at the device that has already told us is fatal, is a bad
> idea.

It is always going to be a race condition. The driver can check
preemptively all it wants, but inevitably there will be cases where
the device goes fatal immediately after checking. So, executing
commands against a device with an error status set cannot be
prevented. I am asking to just delete the soft hopeful code and use
the hard timeout fallback exclusively.

> > "Mailbox Interfaces Ready" is the only status that needs to be checked
> > preemptively, and only once at the beginning of time until the next
> > command timeout where the driver collects it to find out what
> > happened.
>
> I think this happens in a later patch too, if I catch your meaning.

Yeah, looks like that patch needs to come first and then a patch to
switch to timeout-only error handling.
