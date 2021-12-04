Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B50C433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 01:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbhLDBV3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:21:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:29475 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237601AbhLDBV3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Dec 2021 20:21:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237307226"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237307226"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:18:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="610612433"
Received: from pnaidu-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.128.34])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:18:04 -0800
Date:   Fri, 3 Dec 2021 17:18:02 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/9] cxl/pci: Extract device status check
Message-ID: <20211204011749.4pzpo5wfomarcpw2@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
 <20211129214721.1668325-4-ben.widawsky@intel.com>
 <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
 <20211202172435.2f5hlz22cea4l3a3@intel.com>
 <CAPcyv4h-_bLrZKdSDEozK=2mPRnFsKPtg-iirx8qCEk6Kdk6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h-_bLrZKdSDEozK=2mPRnFsKPtg-iirx8qCEk6Kdk6-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-12-02 09:32:59, Dan Williams wrote:
> On Thu, Dec 2, 2021 at 9:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-12-02 09:09:44, Dan Williams wrote:
> > > On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > The Memory Device Status register is inspected in the same way for at
> > > > least two flows in the CXL Type 3 Memory Device Software Guide
> > > > (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> > > > and 2.13.10 Media ready sequence. Extract this common functionality for
> > > > use by both.
> > > >
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
> > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index a6ea9811a05b..6c8d09fb3a17 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> > > >         return 0;
> > > >  }
> > > >
> > > > +/*
> > > > + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> > > > + * Device Software Guide
> > > > + */
> > >
> > > This version did not address the feedback about referencing the CXL
> > > specification instead of the software guide.
> > >
> >
> > Apologies, I missed that request. I apparently missed your email entirely as I
> > was going through the revision.
> >
> > > > +static int check_device_status(struct cxl_dev_state *cxlds)
> > > > +{
> > > > +       const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > > +
> > > > +       if (md_status & CXLMDEV_DEV_FATAL) {
> > > > +               dev_err(cxlds->dev, "Fatal: replace device\n");
> > > > +               return -EIO;
> > > > +       }
> > > > +
> > > > +       if (md_status & CXLMDEV_FW_HALT) {
> > > > +               dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> > > > +               return -EBUSY;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
> > > >   * @cxlds: The device state to gain access to.
> > > > @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> > > >          * Hardware shouldn't allow a ready status but also have failure bits
> > > >          * set. Spit out an error, this should be a bug report
> > > >          */
> > > > -       rc = -EFAULT;
> > > > -       if (md_status & CXLMDEV_DEV_FATAL) {
> > > > -               dev_err(dev, "mbox: reported ready, but fatal\n");
> > > > +       rc = check_device_status(cxlds);
> > > > +       if (rc)
> > > >                 goto out;
> > > > -       }
> > > > -       if (md_status & CXLMDEV_FW_HALT) {
> > > > -               dev_err(dev, "mbox: reported ready, but halted\n");
> > > > -               goto out;
> > > > -       }
> > > > +
> > > >         if (CXLMDEV_RESET_NEEDED(md_status)) {
> > > >                 dev_err(dev, "mbox: reported ready, but reset needed\n");
> > > > +               rc = -EFAULT;
> > > >                 goto out;
> > >
> > > It also did not address the feedback that the reset needed check can
> > > be dropped because per the spec* it is redundant with the other checks
> > > above. The driver need not give up on mailbox commands just because
> > > the media is not ready. So this wants a lead-in patch to clean that up
> > > first.
> >
> > Media ready droppage comes in the next patch. I can reorder them if you'd like,
> > or I suppose you could do it.
> 
> Sure, I'll reorder.
> 
> >
> > >
> > > "This field returns non-zero value if FW Halt is set or Media Status
> > > is not in the ready state."
> > >
> > > Going further I do not think the driver should preemptively abort
> > > commands due to device-fatal, or even firmware halt for that matter.
> > > The true sign of failure and dead firmware is timed-out responses to
> > > incoming commands. Just in case there are some commands still
> > > functional in a device-fatal condition, or the firmware-halt indicator
> > > was a false positive, let the command through, and then if it fails
> > > report these forensic statuses.
> >
> > I admit I'm not looking for spec reference at this exact moment. I think trying
> > to throw commands at the device that has already told us is fatal, is a bad
> > idea.
> 
> It is always going to be a race condition. The driver can check
> preemptively all it wants, but inevitably there will be cases where
> the device goes fatal immediately after checking. So, executing
> commands against a device with an error status set cannot be
> prevented. I am asking to just delete the soft hopeful code and use
> the hard timeout fallback exclusively.
> 

It doesn't bother me much to do so, but it's not my preference. If you'd like to
change it, go ahead and I will review it. When I wrote the original
implementation, my idea was that command timeout and error conditions driven by
interrupts (media issues, firmware issues, whatever) would be disparate paths.
My belief is the spec allows so much latitude, extra paranoia makes sense.

> > > "Mailbox Interfaces Ready" is the only status that needs to be checked
> > > preemptively, and only once at the beginning of time until the next
> > > command timeout where the driver collects it to find out what
> > > happened.
> >
> > I think this happens in a later patch too, if I catch your meaning.
> 
> Yeah, looks like that patch needs to come first and then a patch to
> switch to timeout-only error handling.
