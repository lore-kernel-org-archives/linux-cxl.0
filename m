Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7ACC48BE8
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CD161279
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 19:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhFRTec (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:34:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:20095 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhFRTec (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 18 Jun 2021 15:34:32 -0400
IronPort-SDR: oKheOfOmlJ0AfZjYIqXwlYJz2+EbdKj1Qfh2n3R9P739ApuFvLKPhBnm2EGoemOjofmJr6ev1i
 6vSn9+p2kJxw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193925534"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193925534"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 12:32:21 -0700
IronPort-SDR: ZhmM1+6COwmjRoqeXoBh0+iC10i2cmJ7fjBrvd9Wyey/Nji3r/MmBT/5WDXLGSOgCFBUzWnoHi
 xrsMFDEnntYw==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="422323094"
Received: from pbodapat-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.92])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 12:32:21 -0700
Date:   Fri, 18 Jun 2021 12:32:17 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH V3] cxl/mem: Account for partitionable space in ram/pmem
 ranges
Message-ID: <20210618193217.pakf4ahovstxjp7x@intel.com>
References: <20210617221620.1904031-3-ira.weiny@intel.com>
 <20210618163129.1912453-1-ira.weiny@intel.com>
 <20210618165833.2jem3rshyy7szsm6@intel.com>
 <20210618184832.GD1905674@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618184832.GD1905674@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-18 11:48:32, Ira Weiny wrote:
> On Fri, Jun 18, 2021 at 09:58:33AM -0700, Widawsky, Ben wrote:
> > On 21-06-18 09:31:29, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Memory devices may specify volatile only, persistent only, and
> > > partitionable space which when added together result in a total capacity.
> > > 
> > > If Identify Memory Device.Partition Alignment != 0 the device supports
> > > partitionable space.  This partitionable space can be split between
> > > volatile and persistent space.  The total volatile and persistent sizes
> > > are reported in Get Partition Info.  ie
> > > 
> > > 	active volatile memory = volatile only + partitionable volatile
> > > 	active persistent memory = persistent only + partitionable persistent
> > > 
> > > Define cxl_mem_get_partition(), check for partitionable support, and use
> > > cxl_mem_get_partition() if applicable.
> > 
> > This doesn't look right to me, but I'll happily stand corrected.
> > 
> 
> [snip]
> 
> > > +
> > > +static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (cxlm->partition_align_bytes == 0) {
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This...
> 
> > > +		cxlm->ram_range.start = 0;
> > > +		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> > > +		cxlm->pmem_range.start = 0;
> > > +		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> > > +		return 0;
> > > +	}
> > > +
> > > +	rc = cxl_mem_get_partition_info(cxlm,
> > > +					&cxlm->active_volatile_bytes,
> > > +					&cxlm->active_persistent_bytes,
> > > +					&cxlm->next_volatile_bytes,
> > > +					&cxlm->next_persistent_bytes);
> > > +	if (rc < 0) {
> > > +		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
> > > +		return rc;
> > > +	}
> > 
> > If the command is not supported, you're going to get back -ENXIO here and fail.
> > I think what you want to do also is use IDENTIFY if PARTITION_INFO doesn't
> > exist.
> 
> ... should handle the situation where Get Partition Info is not supported.
> 
> I did not see it explicitly stated but I believe if Partition Align Bytes is
> non-0 then partitioning is supported and Get/Set Partition Info should work.

Ah. I didn't notice that. Perhaps a comment with a spec reference might help the
next person who comes along to look at that. My reading of it is the same
(though not explicit). I wonder why they chose to put that in IDENTIFY...

> 
> > 
> > Assuming my assessment is correct, I think it's time to make
> > cxl_mem_mbox_send_cmd grow a little bit better error handling. I'd recommend
> > something like this and then checking for -ENOTSUPP.
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index b1a5a18dba92..3b7d8a905393 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -92,6 +92,7 @@ struct mbox_cmd {
> >         size_t size_out;
> >         u16 return_code;
> >  #define CXL_MBOX_SUCCESS 0
> > +#define CXL_MBOX_UNSUPPORTED 0x15
> >  };
> > 
> >  static int cxl_mem_major;
> > @@ -876,9 +877,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
> >         if (rc)
> >                 return rc;
> > 
> > -       /* TODO: Map return code to proper kernel style errno */
> > -       if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
> > +       switch (mbox_cmd.return_code) {
> > +       case CXL_MBOX_SUCCESS:
> > +               break;
> > +       case CXL_MBOX_UNSUPPORTED:
> > +               return -ENOTSUPP;
> > +       default:
> > +               /* TODO: Map return code to proper kernel style errno */
> >                 return -ENXIO;
> > +       }
> 
> 
> I'm not opposed to adding this though.

You've resolved my concern, so it's up to you. The other option would be to
check the commands if the command got enabled in cxlm->enabled_cmds.

> 
> Ira
