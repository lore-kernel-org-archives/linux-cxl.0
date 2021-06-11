Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D041FC48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E1160E0C
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFKUAY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:00:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:32805 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKUAY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 16:00:24 -0400
IronPort-SDR: ncghmrRAP0SGri4StIlW4FgFYbrezRSZcH/tMNybjtgC6gLEg9bpVAlHFqHdNDwg+sD2V/9oHM
 dxYXym1qGEmA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="269449157"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="269449157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:58:24 -0700
IronPort-SDR: cU9sY6tX1Mc5GAUL7QBgOOtMAp1eCqZUJNJ1SieMhQnF2u7jyFSpkFBxfDUJMg84U580f5h9JT
 t9P2P/RpGW0w==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="483378562"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:58:24 -0700
Date:   Fri, 11 Jun 2021 12:58:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/pci: Store memory capacity values
Message-ID: <20210611195824.GB1600546@iweiny-DESK2.sc.intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
 <20210611002224.1594913-2-ira.weiny@intel.com>
 <CAPcyv4hpDFZj8zr47SLAx7Qy2UMz4c_E648e-ahGyu5nhzjcow@mail.gmail.com>
 <20210611175030.gytdt3fu5fppy4kp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611175030.gytdt3fu5fppy4kp@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 10:50:30AM -0700, Widawsky, Ben wrote:
> On 21-06-11 10:26:34, Dan Williams wrote:
> > On Thu, Jun 10, 2021 at 5:22 PM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > The Identify Memory Device command returns information about the
> > > volatile and persistent memory capacities.  Store those values in the
> > > cxl_mem structure for later use.  While at it, reuse the calculation of
> > > the volatile and persistent memory byte values to calculate the ram and
> > > pmem ranges.
> > >
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/mem.h |  4 ++++
> > >  drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
> > >  2 files changed, 37 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > > index 13868ff7cadf..8bd0d0506b97 100644
> > > --- a/drivers/cxl/mem.h
> > > +++ b/drivers/cxl/mem.h
> > > @@ -75,5 +75,9 @@ struct cxl_mem {
> > >
> > >         struct range pmem_range;
> > >         struct range ram_range;
> > > +       u64 total_cap_bytes;
> > > +       u64 volatile_cap_bytes;
> > > +       u64 persistent_cap_bytes;
> > 
> > Hmm, why these fields?
> > 
> > I would expect pmem_range and ram_range can already represent these
> > values and range_len(pmem_range) + range_len(ram_range) == total
> > capacity.
> 
> So the way Ira described it (AIUI), pmem_range will be the total partitioned
> amount, while persistent_cap_bytes is min(info.persistent capacity, pmem_range)
> (same for volatile). But perhaps I misunderstood.

Yes persistent is 'persistent only'...  so s/cap/only/ is probably better name.

pmem_range.len() may == persistent_cap_bytes.  But does not need to.

Ira
