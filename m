Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FDDC48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A03F613F0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 15:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFKQBl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:01:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:56994 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFKQBk (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 12:01:40 -0400
IronPort-SDR: 3RUSO9ff+QTBfY6HW7h8q8JEBcHMJvGhHZf87xQAoeoecVJeavR/NeUeoEjzKj93w2p994aL22
 TKtz/WbxZFqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="185243514"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="185243514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 08:59:42 -0700
IronPort-SDR: PB4b+Dxjbta14wHmJmUdzQ8jgvXjyUnE9DgyCu+GUPZe4t0aS0tgedNnMykoMfDxROrrUYy0k6
 GJUYGWormMKQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483311901"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 08:59:42 -0700
Date:   Fri, 11 Jun 2021 08:59:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mem: Report correct ram/pmem size in sysfs
Message-ID: <20210611155942.GF3697498@iweiny-DESK2.sc.intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
 <20210611002224.1594913-3-ira.weiny@intel.com>
 <20210611120054.00007eb7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611120054.00007eb7@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 9995f97d3b28..bcc2829e4475 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1455,6 +1455,62 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> >  	return ret;
> >  }
> >  
> > +/**
> > + * cxl_mem_get_partition_info - Set partition info
> 
> Having a function call _get_ that is documented as "Set" is somewhat unusual.

Oops...  yea...

> > + * @cxlm: The device to act on
> > + * @active_volatile_cap_bytes: returned active volatile capacity; in bytes
> > + * @active_persistent_cap_bytes: returned active persistent capacity; in bytes
> > + * @next_volatile_cap_bytes: return next volatile capacity; in bytes
> > + * @next_persistent_cap_bytes: return next persistent capacity; in bytes
> > + *
> > + * Retrieve the current partition info for the device specified.  The active
> > + * values are the current capacity in bytes.  If not 0, the 'next' values are
> > + * the pending values, in bytes, which take affect on next cold reset.
> > + *
> > + * Return: 0 if no error: or the result of the mailbox command.
> > + *
> > + * See CXL @8.2.9.5.2.1 Get Partition Info
> > + */
> > +int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> > +			       u64 *active_volatile_cap_bytes,
> > +			       u64 *active_persistent_cap_bytes,
> > +			       u64 *next_volatile_cap_bytes,
> > +			       u64 *next_persistent_cap_bytes)
> > +{
> > +	struct cxl_mbox_get_partition_info {
> > +		u64 active_volatile_cap;
> > +		u64 active_persistent_cap;
> > +		u64 next_volatile_cap;
> > +		u64 next_persistent_cap;
> > +	} __packed pi;
> > +	int rc;
> > +
> > +	/* On error report 0 */
> 
> This command is optional... See below.

I did not realize that...  Ok, this will not work then.

> >  	/*
> >  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> >  	 * For now, only the capacity is exported in sysfs
> >  	 */
> >  	cxlm->ram_range.start = 0;
> > -	cxlm->ram_range.end = cxlm->volatile_cap_bytes - 1;
> > +	cxlm->ram_range.end = active_volatile_cap_bytes - 1;
> 
> This change looks to wipe out the valid settings on a device
> that only does fixed allocations to pmem vs volatile.

Yes it sure will...  :-(

Thanks for pointing it out...
Ira
