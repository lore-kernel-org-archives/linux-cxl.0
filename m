Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5187C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB450613D9
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFKUBq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:01:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:4680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKUBq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 16:01:46 -0400
IronPort-SDR: 7qWEYFHAJgn6A2ADnkpei5g16KiAjcLkj9kbrlj8Cx4yrXzN9YD0F2QSDvatFcLksFdHT1lsPc
 ND+QGa1+SGYg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="192911985"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="192911985"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:59:47 -0700
IronPort-SDR: U47nFeF6WetDB58pGWPHOJN/S3fjCu+TI8M6998AOCtjFcMa+G4yUjWqyFOqK45Kkot9+2eQsb
 47ytR77fOknA==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="638792046"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:59:47 -0700
Date:   Fri, 11 Jun 2021 12:59:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mem: Report correct ram/pmem size in sysfs
Message-ID: <20210611195946.GC1600546@iweiny-DESK2.sc.intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
 <20210611002224.1594913-3-ira.weiny@intel.com>
 <CAPcyv4iZU3ZC9DWsXf1=MEjrftea_88+Adm-me8cuw9e4YkiGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iZU3ZC9DWsXf1=MEjrftea_88+Adm-me8cuw9e4YkiGw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 10:14:31AM -0700, Dan Williams wrote:
> On Thu, Jun 10, 2021 at 5:22 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Memory devices may specify volatile only, persistent only, and
> > partitionable space which when added together result in a total capacity.
> >
> > The partitionable space is configurable between volatile and persistent
> > space.  To account for the dynamic partitionable space the correct ram
> > and pmem size information is reported in the Get Partition Info device
> > command.
> >
> > Define cxl_mem_get_partition() and call it to retrieve the correct
> > ram and pmem ranges sizes.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/pci.c | 97 +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 90 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 9995f97d3b28..bcc2829e4475 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1455,6 +1455,62 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> >         return ret;
> >  }
> >
> > +/**
> > + * cxl_mem_get_partition_info - Set partition info
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
> > +                              u64 *active_volatile_cap_bytes,
> > +                              u64 *active_persistent_cap_bytes,
> > +                              u64 *next_volatile_cap_bytes,
> > +                              u64 *next_persistent_cap_bytes)
> 
> Similar to how cxl_mem_identify() populates data in cxl_mem, I would
> expect this routine to do the same.
> 
> > +{
> > +       struct cxl_mbox_get_partition_info {
> > +               u64 active_volatile_cap;
> > +               u64 active_persistent_cap;
> > +               u64 next_volatile_cap;
> > +               u64 next_persistent_cap;
> > +       } __packed pi;
> > +       int rc;
> > +
> > +       /* On error report 0 */
> > +       *active_volatile_cap_bytes = 0;
> > +       *active_persistent_cap_bytes = 0;
> > +       *next_volatile_cap_bytes = 0;
> > +       *next_persistent_cap_bytes = 0;
> > +
> > +       rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> > +                                  NULL, 0, &pi, sizeof(pi));
> > +
> > +       if (rc)
> > +               return rc;
> > +
> > +       *active_volatile_cap_bytes = le64_to_cpu(pi.active_volatile_cap);
> > +       *active_persistent_cap_bytes = le64_to_cpu(pi.active_persistent_cap);
> > +       *next_volatile_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> > +       *next_persistent_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> > +
> > +       *active_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +       *active_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +       *next_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +       *next_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mem_get_partition_info);
> 
> Why is this exported? Only the PCI driver cares about this.

Once we get to dynamic partitioning I would expect it to need to be exported...
But I think you are correct...  No need to do that until we need it.

Ira
