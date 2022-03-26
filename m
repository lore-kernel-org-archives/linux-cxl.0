Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511B7C433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 26 Mar 2022 00:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiCZAgO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiCZAgN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 20:36:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F5022BD74
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 17:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254878; x=1679790878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8VksD6usnGgVINvNuKKMtGdNVT4W928iPymo05eX/QI=;
  b=VVAj38cdP/c2KsoT1HlItjBXUbRjh8hti5GGDpiKStNAEnWV2cTBQS/C
   joH9vO1WZuuFI6UJ6BnT0Xu17MLzssINhCFmmFiuqinDIx2rdz/4n9oPy
   wKjCj5k5TZnVtVxx+4luKl7T6q2Mj3MLUmuF3MULTiwiZylO0nbG2do2W
   RFSqY1Sz4ROI4p8lRrR9pNztWemvd3+SeOv0uXIPEUnERg/w6+IaJRxbk
   /rtr1/Z9t+66w2I/xiKlC0RtbW2c1DjM/UXrjFbr0Lmex3FPhzRnkLaAD
   NeSanwxcnpofy0Y8uQi1PyzzwWAEGPeu0jZS6tbYQvE1r6qpIzh7hMkuU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283622376"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283622376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="501944678"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:34:37 -0700
Date:   Fri, 25 Mar 2022 17:37:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the
 validation path
Message-ID: <20220326003711.GB1153706@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
 <20220324011126.1144504-5-alison.schofield@intel.com>
 <20220325105413.00002ac5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325105413.00002ac5@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 10:54:13AM +0000, Jonathan Cameron wrote:
> On Wed, 23 Mar 2022 18:11:21 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Since the validation of a mailbox command is done as it is built,
> 
> Perhaps reword this.  I agree it's desirable to have validation
> and build together but this says 'is done' and it wasn't done until
> this patch.
> 
> > move that work out of the dispatch path and into the validation
> > path.
> > 
> > This is a step in refactoring the handling of user space mailbox
> > commands. The intent is to have all the validation work originate
> > in cxl_validate_cmd_from_user().
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Sometimes things can get broken into too many baby steps!
> 
> This change looks odd until patch 7 given info is passed twice
> in mbox_cmd and out_cmd.  Maybe note in the patch description that
> out_cmd will be brought local in a few patches time?
> Probably not worth working out how to reorder and squish the patches
> to make this easier to review.

I'm reworking w your feedback and will take another pass at this 
piece, and either change it or document it better.

As you've seen, I did a build up of the new way, then a tear down
of the old way. Let me see if there is a graceful way of avoiding
the overlap here.

Thanks for the review.
Alison

> 
> Otherwise, one trivial inline.
> 
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/mbox.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d4233cfb2f99..205e671307c3 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -324,6 +324,7 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
> >   * @cxlds: The device data for the operation
> >   * @send_cmd: &struct cxl_send_command copied in from userspace.
> >   * @out_cmd: Sanitized and populated &struct cxl_mem_command.
> > + * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
> >   *
> >   * Return:
> >   *  * %0	- @out_cmd is ready to send.
> > @@ -340,7 +341,8 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
> >   */
> >  static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
> >  				      const struct cxl_send_command *send_cmd,
> > -				      struct cxl_mem_command *out_cmd)
> > +				      struct cxl_mem_command *out_cmd,
> > +				      struct cxl_mbox_cmd *mbox_cmd)
> >  {
> >  	int rc;
> >  
> > @@ -361,6 +363,14 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
> >  	else
> >  		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
> >  
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* Sanitize and construct a cxl_mbox_cmd */
> > +	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
> > +			     out_cmd->info.size_in, out_cmd->info.size_out,
> > +			     send_cmd->in.payload);
> > +
> return cxl_to_mbox_cmd()....
> 
> >  	return rc;
> >  }
> >  
> > @@ -478,6 +488,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> >  	struct device *dev = &cxlmd->dev;
> >  	struct cxl_send_command send;
> >  	struct cxl_mem_command c;
> > +	struct cxl_mbox_cmd mbox_cmd;
> >  	int rc;
> >  
> >  	dev_dbg(dev, "Send IOCTL\n");
> > @@ -485,7 +496,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> >  	if (copy_from_user(&send, s, sizeof(send)))
> >  		return -EFAULT;
> >  
> > -	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
> > +	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
> >  	if (rc)
> >  		return rc;
> >  
> 
