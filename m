Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA68C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376295AbhLBR2B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:28:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:20153 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242092AbhLBR2A (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Dec 2021 12:28:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223626447"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="223626447"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:24:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="460534702"
Received: from kloo-desk2.amr.corp.intel.com (HELO intel.com) ([10.252.142.111])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:24:37 -0800
Date:   Thu, 2 Dec 2021 09:24:35 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/9] cxl/pci: Extract device status check
Message-ID: <20211202172435.2f5hlz22cea4l3a3@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
 <20211129214721.1668325-4-ben.widawsky@intel.com>
 <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-12-02 09:09:44, Dan Williams wrote:
> On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The Memory Device Status register is inspected in the same way for at
> > least two flows in the CXL Type 3 Memory Device Software Guide
> > (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> > and 2.13.10 Media ready sequence. Extract this common functionality for
> > use by both.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index a6ea9811a05b..6c8d09fb3a17 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >         return 0;
> >  }
> >
> > +/*
> > + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> > + * Device Software Guide
> > + */
> 
> This version did not address the feedback about referencing the CXL
> specification instead of the software guide.
> 

Apologies, I missed that request. I apparently missed your email entirely as I
was going through the revision.

> > +static int check_device_status(struct cxl_dev_state *cxlds)
> > +{
> > +       const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > +
> > +       if (md_status & CXLMDEV_DEV_FATAL) {
> > +               dev_err(cxlds->dev, "Fatal: replace device\n");
> > +               return -EIO;
> > +       }
> > +
> > +       if (md_status & CXLMDEV_FW_HALT) {
> > +               dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> > +               return -EBUSY;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
> >   * @cxlds: The device state to gain access to.
> > @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> >          * Hardware shouldn't allow a ready status but also have failure bits
> >          * set. Spit out an error, this should be a bug report
> >          */
> > -       rc = -EFAULT;
> > -       if (md_status & CXLMDEV_DEV_FATAL) {
> > -               dev_err(dev, "mbox: reported ready, but fatal\n");
> > +       rc = check_device_status(cxlds);
> > +       if (rc)
> >                 goto out;
> > -       }
> > -       if (md_status & CXLMDEV_FW_HALT) {
> > -               dev_err(dev, "mbox: reported ready, but halted\n");
> > -               goto out;
> > -       }
> > +
> >         if (CXLMDEV_RESET_NEEDED(md_status)) {
> >                 dev_err(dev, "mbox: reported ready, but reset needed\n");
> > +               rc = -EFAULT;
> >                 goto out;
> 
> It also did not address the feedback that the reset needed check can
> be dropped because per the spec* it is redundant with the other checks
> above. The driver need not give up on mailbox commands just because
> the media is not ready. So this wants a lead-in patch to clean that up
> first.

Media ready droppage comes in the next patch. I can reorder them if you'd like,
or I suppose you could do it.

> 
> "This field returns non-zero value if FW Halt is set or Media Status
> is not in the ready state."
> 
> Going further I do not think the driver should preemptively abort
> commands due to device-fatal, or even firmware halt for that matter.
> The true sign of failure and dead firmware is timed-out responses to
> incoming commands. Just in case there are some commands still
> functional in a device-fatal condition, or the firmware-halt indicator
> was a false positive, let the command through, and then if it fails
> report these forensic statuses.

I admit I'm not looking for spec reference at this exact moment. I think trying
to throw commands at the device that has already told us is fatal, is a bad
idea.

> 
> "Mailbox Interfaces Ready" is the only status that needs to be checked
> preemptively, and only once at the beginning of time until the next
> command timeout where the driver collects it to find out what
> happened.

I think this happens in a later patch too, if I catch your meaning.

> 
> I'll take a shot at a lead-in patch to that effect.
