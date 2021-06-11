Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07204C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB539613D9
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFKRwb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:52:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:47323 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFKRwa (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 13:52:30 -0400
IronPort-SDR: PIde7FWV9eqDVz2QeUh5uHNitDTgm/uOqUv9znbmxcjkavdPiVSOUDPxu3C8u2FF+noK2vbF3p
 dtJLcZMFaxYw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205532924"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205532924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:50:32 -0700
IronPort-SDR: yH12sJsjw/wYo7h+g6FF8+P7RRMe1R93EvdiltuGTd6Qj97cnbWWMuVpjvEop1e3XZcAM1vT8Q
 45w8/H1z0PQg==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="441625664"
Received: from chtanaka-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.138.239])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:50:31 -0700
Date:   Fri, 11 Jun 2021 10:50:30 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/pci: Store memory capacity values
Message-ID: <20210611175030.gytdt3fu5fppy4kp@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
 <20210611002224.1594913-2-ira.weiny@intel.com>
 <CAPcyv4hpDFZj8zr47SLAx7Qy2UMz4c_E648e-ahGyu5nhzjcow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hpDFZj8zr47SLAx7Qy2UMz4c_E648e-ahGyu5nhzjcow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-11 10:26:34, Dan Williams wrote:
> On Thu, Jun 10, 2021 at 5:22 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The Identify Memory Device command returns information about the
> > volatile and persistent memory capacities.  Store those values in the
> > cxl_mem structure for later use.  While at it, reuse the calculation of
> > the volatile and persistent memory byte values to calculate the ram and
> > pmem ranges.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/mem.h |  4 ++++
> >  drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 13868ff7cadf..8bd0d0506b97 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -75,5 +75,9 @@ struct cxl_mem {
> >
> >         struct range pmem_range;
> >         struct range ram_range;
> > +       u64 total_cap_bytes;
> > +       u64 volatile_cap_bytes;
> > +       u64 persistent_cap_bytes;
> 
> Hmm, why these fields?
> 
> I would expect pmem_range and ram_range can already represent these
> values and range_len(pmem_range) + range_len(ram_range) == total
> capacity.

So the way Ira described it (AIUI), pmem_range will be the total partitioned
amount, while persistent_cap_bytes is min(info.persistent capacity, pmem_range)
(same for volatile). But perhaps I misunderstood.
