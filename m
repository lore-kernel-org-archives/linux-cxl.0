Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D8C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Jan 2022 23:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiADXGh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:06:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:60111 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235297AbiADXGg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 4 Jan 2022 18:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641337596; x=1672873596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0FzfibW+Xmv3OQfo7TeVxY+fM5E626bHjHm4BpzUU8=;
  b=Ce2iTU6hKRiqxRLKKUbMJTdb5uRD7C+2pRctwRvthDpBHNKhNS+rCfU3
   0S+oGzFvzzgz3uddw2woayyQ/Pe+H4ITkedosY76c2p99b08eqpDuU5lY
   Y8WF+e3DupglA0F4d2FDua2Rvo1k8s81q+7chsZ/Jk5SE15geDOUuQTwS
   fTxoYEyQFE7/s4tt1PbqH7pbRyd8e0Iw4PVAZgVum/2d9ch2obdR9eGQT
   3h4i/QLhFKm+GPm/Sm8KRRhEjmQHkPOy66QfIrjgw1K3EAZNLg5vGYCv+
   fpWjRG5Z2DL9AOFqTfFbt5f24bPCHKz+xSOoCJNsOC+bE69+H6qwRAz6k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328661590"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="328661590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:06:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="472237294"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:06:20 -0800
Date:   Tue, 4 Jan 2022 15:11:37 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Do not allow immediate mode in
 SET_PARTITION_INFO
Message-ID: <20220104231137.GA789645@alison-desk>
References: <20220103202100.784194-1-alison.schofield@intel.com>
 <CAPcyv4j0wqvX82wPxgvLLu7DcSu4TRs5RE-jXg_YXz=y_7ucrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j0wqvX82wPxgvLLu7DcSu4TRs5RE-jXg_YXz=y_7ucrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks for the review...
On Tue, Jan 04, 2022 at 11:02:19AM -0800, Dan Williams wrote:
> On Mon, Jan 3, 2022 at 12:15 PM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > User space may send the SET_PARTITION_INFO mailbox command using
> > the IOCTL interface. Inspect the input payload and fail if the
> > immediate flag is set.
> >
> > This is the first instance of the driver inspecting an input payload
> > from user space. Assume there will be more such cases and implement
> > with an extensible helper.
> >
> > Note: At this time immediate partitioning is not allowed because the
> > kernel will need to react immediately to this configuration change
> > and that support is not yet implemented.
> 
> I would say:
> 
> In order for the kernel to react to an immediate partition change it
> needs to assert that the change will not affect any active decode. At
> a minimum this requires validating that the device is using HDM
> decoders instead of the CXL DVSEC for decode, and that none of the
> active HDM decoders are affected by the partition change. For now,
> just fail until that support arrives.
> 
Got it! 
> >

snip

> > +static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> > +{
> > +       switch (opcode) {
> > +       case CXL_MBOX_OP_SET_PARTITION_INFO: {
> > +               struct cxl_mbox_set_partition_info *pi;
> > +
> > +               pi = (struct cxl_mbox_set_partition_info *)payload_in;
> 
> No need for a cast since @payload_in is a 'void *'
> 
Got it!

> > +               if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> > +                       return false;
> > +               break;
> > +       }
> > +       default:
> > +               break;
> > +       }
> > +       return true;
> > +}
> > +

snip

> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 8d96d009ad90..e10b86f06c75 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -231,6 +231,13 @@ struct cxl_mbox_set_lsa {
> >         u8 data[];
> >  } __packed;
> >
> > +struct cxl_mbox_set_partition_info {
> > +       u64 volatile_capacity;
> 
> This should be __le64, and it looks like 'struct cxl_mbox_get_lsa' and
> 'struct cxl_mbox_set_lsa' need similar fixups.
> 

Got it and will do!


> > +       u8 flags;
> > +} __packed;
> > +
> > +#define  CXL_SET_PARTITION_IMMEDIATE_FLAG      BIT(0)
> > +
> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> >
> > base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
> > --
> > 2.31.1
> >
