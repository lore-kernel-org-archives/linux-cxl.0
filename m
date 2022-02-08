Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77544C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379557AbiBHWZi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386502AbiBHUoh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 15:44:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DCBC0613CB
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644353077; x=1675889077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cejEs7SDq/BPC5ioOdM6B5gGwHsZ5IZnKLaXN02dvUc=;
  b=mVH3zOZcYykNzFcPhn44G7+VthXsW9+Ei5noNXBLK2Ei5QY39iW+OGH8
   /JQaU8HPEvR4qjDAGUg3B/gxTy+lUuSIaLzOcqNEz0qa+gcMNCAesZfMd
   UUTSYjQb/KuT8/bqNgGYouEWYu3yG8le41AuPBRl9bVgLkqmXFI/qAJtJ
   qpyMN2x1rHIj+/uqwBZit528MM/KROt1JN+HULbFLqj9pxS5PEbQNd/4v
   0lemkuDVC3QUW6Z2ykg8UqgFvYGdbFSrS/MiCjMu8n0BmLfvjkqwZr9Bw
   cLI4Fopgrqaa+DqLOl7TF+T6KFsa8hOe/vs41C/Dxh+7lTxUuWU8QyMnK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335450835"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="335450835"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:44:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="773250624"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:44:37 -0800
Date:   Tue, 8 Feb 2022 12:48:42 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v4 2/6] libcxl: add accessors for capacity fields
 of the IDENTIFY command
Message-ID: <20220208204842.GB950445@alison-desk>
References: <cover.1644271559.git.alison.schofield@intel.com>
 <034755a71999a66da79356ec7efbabeaa4eacd88.1644271559.git.alison.schofield@intel.com>
 <CAPcyv4juShujHXrh5ZB7d2sVtE4+sn6idi-KCbKZ=4pwz6jxpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4juShujHXrh5ZB7d2sVtE4+sn6idi-KCbKZ=4pwz6jxpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Got it, thanks!
<eom>

On Tue, Feb 08, 2022 at 12:34:23PM -0800, Dan Williams wrote:
> On Mon, Feb 7, 2022 at 3:06 PM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Users need access to a few additional fields reported by the IDENTIFY
> 
> Ah, I see the "Users need" pattern... To me, the "Users need"
> statement is a step removed / secondary from the real driving
> motivation which is the "CXL PMEM provisioning model specifies /
> mandates".
> 
> It feels like a watered down abstraction to me.
> 
> > mailbox command: total, volatile_only, and persistent_only capacities.
> > These values are useful when defining partition layouts.
> >
> > Add accessors to the libcxl API to retrieve these values from the
> > IDENTIFY command.
> >
> > The fields are specified in multiples of 256MB per the CXL 2.0 spec.
> > Use the capacity multiplier to convert the raw data into bytes for user
> > consumption.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  cxl/lib/libcxl.c   | 36 ++++++++++++++++++++++++++++++++++++
> >  cxl/lib/libcxl.sym |  3 +++
> >  cxl/libcxl.h       |  3 +++
> >  3 files changed, 42 insertions(+)
> >
> > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > index 33cf06b..e9d7762 100644
> > --- a/cxl/lib/libcxl.c
> > +++ b/cxl/lib/libcxl.c
> > @@ -2322,6 +2322,42 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
> >         return le32_to_cpu(id->lsa_size);
> >  }
> >
> > +static struct cxl_cmd_identify *
> > +cmd_to_identify(struct cxl_cmd *cmd)
> > +{
> > +       if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY))
> > +               return NULL;
> > +
> > +       return cmd->output_payload;
> > +}
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_cmd_identify_get_total_size(struct cxl_cmd *cmd)
> > +{
> > +       struct cxl_cmd_identify *c;
> > +
> > +       c = cmd_to_identify(cmd);
> > +       return c ? capacity_to_bytes(c->total_capacity) : ULLONG_MAX;
> > +}
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd)
> > +{
> > +       struct cxl_cmd_identify *c;
> > +
> > +       c = cmd_to_identify(cmd);
> > +       return c ? capacity_to_bytes(c->volatile_capacity) : ULLONG_MAX;
> > +}
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd)
> > +{
> > +       struct cxl_cmd_identify *c;
> > +
> > +       c = cmd_to_identify(cmd);
> > +       return c ? capacity_to_bytes(c->persistent_capacity) : ULLONG_MAX;
> 
> Same style comments as last patch, but otherwise:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
