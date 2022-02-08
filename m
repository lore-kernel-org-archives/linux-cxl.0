Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE311C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353514AbiBHR6G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385105AbiBHR5y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 12:57:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A929C02C451
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644343044; x=1675879044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9dmonQbDr5LE4vMviRVOwFGOpE224EqHaooR6zwTOpc=;
  b=KqIejxlusC1xDcGk5r7M5kmh+djHj+zcCXqlkwF59K9nddOfv88eA/cx
   gPhrwnCVgJFF7vpzq5G83KIzvgI4rzn6J0Hkb4ylrIU9w62rVQRlXEOks
   sEJnQgPSdY5PdIpap+lQkR0bqRbmQ5p4bAoXENz9dUHiDIEOltJ62INml
   tr90ESMqENN8M18cluDVBjcwWIlbWjy5bH3ULxP1Rny211c+iLxHIuo3q
   gwIfRNtm8vM7SPckOhNaDX4rF35gvHDAGGaHolp+SSCaZaY1Eu9HnT3Lv
   WDuhk8sBtwNsYYYKlcb4LQmdxYVlLor4xi3VP3Zqvi03r9ydKi6P9C/XA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236416901"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="236416901"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 09:56:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="536643700"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 09:56:54 -0800
Date:   Tue, 8 Feb 2022 10:00:59 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v4 0/6] Add partitioning support for CXL memdevs
Message-ID: <20220208180059.GA949880@alison-desk>
References: <cover.1644271559.git.alison.schofield@intel.com>
 <CAPcyv4ge-QF008ATyPhCzx51aWaqwBRue4gAgV81=BnxzJT_FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ge-QF008ATyPhCzx51aWaqwBRue4gAgV81=BnxzJT_FQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 08, 2022 at 09:23:54AM -0800, Dan Williams wrote:
> On Mon, Feb 7, 2022 at 3:06 PM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Users may want to view and change partition layouts of CXL memory
> > devices that support partitioning. Provide userspace access to
> > the device partitioning capabilities as defined in the CXL 2.0
> > specification.
> 
> This is minor feedback if these end up being re-spun, but "Users may
> want..." is too passive for what this is, which is a critical building
> block in the provisioning model for PMEM over CXL. So, consider
> rewriting in active voice, and avoid underselling the importance of
> this capability.

Yes! I have some words you gave me in another commit I will draw upon.

> 
> > The first 4 patches add accessors for all the information needed
> > to formulate a new partition layout. This info is accessible via
> > the libcxl API and a new option in the cxl list command:
> >
> >     "partition_info":{
> >       "active_volatile_bytes":273535729664,
> >       "active_persistent_bytes":0,
> >       "next_volatile_bytes":268435456,
> >       "next_persistent_bytes":273267294208,
> >       "total_bytes":273535729664,
> >       "volatile_only_bytes":0,
> >       "persistent_only_bytes":0,
> >       "partition_alignment_bytes":268435456
> >     }
> 
> Is this stale? I.e. we discussed aligning the names to other
> 'size'-like values in 'ndctl list' and 'cxl list'.
> 

Yes - that is STALE. The cxl-list patch commit msg has it right.
Will fix here.

 "partition_info":{
      "active_volatile_size":273535729664,
      "active_persistent_size":0,
      "next_volatile_size":0,
      "next_persistent_size":0,
      "total_size":273535729664,
      "volatile_only_size":0,
      "persistent_only_size":0,
      "partition_alignment_size":268435456
    }



> >
> > Patch 5 introduces the libcxl interfaces for the SET_PARTITION_INFO
> > mailbox command and Patch 6 adds the new CXL command:
> >
> > Synopsis:
> > cxl set-partition <mem0> [<mem1>..<memN>] [<options>]
> >
> > -t, --type=<type>       'pmem' or 'volatile' (Default: 'pmem')
> > -s, --size=<size>       size in bytes (Default: all partitionable capacity)
> 
> Spell-check does not like "partitionable"
> 
> s/partitionable/available/

hmm... passes my spell check, but alas, it is overuse of the root word.
I like available. Will change.

> 
> > -a, --align             allow alignment correction
> 
> How about:
> 
> "Auto-align --size per device's requirement."
> 

So much better. Thanks.

> > -v, --verbose           turn on debug
> >
> > The CXL command does not offer the IMMEDIATE mode option defined
> 
> s/CXL/'cxl set-parition'/
> 
> This is a general problem caused by the tool 'cxl' being the same name
> as the specification CXL. When it is ambiguous, go ahead and spell out
> 'cxl <command>'.
> 

Got it.

snip...
