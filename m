Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58178C28CF5
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiAZQd0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:33:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:1824 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236744AbiAZQd0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 26 Jan 2022 11:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643214806; x=1674750806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4MAtAySV+/cOqYZqDJI7JxuklTsTLp/8YkISCKNiSI=;
  b=l7Zey8ZHkqJ6AQUyiSgZm2KRP/t8SIBweGD0EPDipcanJwK4nZ0OG3mi
   nwfRCRNnNnVnApQNBRyl9bdID6s0I6ibBGnk2RQcBywA7+CnH84GKSkU9
   jhzHwNpIBHb4d0oK2OF5QTcSCIrFS7oakv+NuwmhnDYzNcqlEoQifYYYr
   2IfTDJKVPY5VONXfg3IgAfsAgFHf2BWMnAtH/djU5gG0cpRPRNh38JY2D
   m614DgmmjTkAUeO/9cDhWAKYdX8hRBU4tg67FPeOCyjGEH0ECBRQj0koE
   rYi+JEbTfaFN407qASl1qQjQyRESu6VcPOYknlgcbey0Q7llfkjFU4CNa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246806687"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246806687"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 08:33:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628355956"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 08:33:23 -0800
Date:   Wed, 26 Jan 2022 08:37:56 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v3 1/6] libcxl: add GET_PARTITION_INFO mailbox
 command and accessors
Message-ID: <20220126163756.GA887955@alison-desk>
References: <cover.1642535478.git.alison.schofield@intel.com>
 <2072a34022dabcc92e3cc73b16c8008656e1084e.1642535478.git.alison.schofield@intel.com>
 <CAPcyv4jde6kd1oT2ZEoGWDiB1E6QX2pYzSHWr=38jtY6XB5ATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jde6kd1oT2ZEoGWDiB1E6QX2pYzSHWr=38jtY6XB5ATA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 26, 2022 at 08:07:17AM -0800, Dan Williams wrote:
> On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Users need access to the CXL GET_PARTITION_INFO mailbox command
> > to inspect and confirm changes to the partition layout of a memory
> > device.
> >
> > Add libcxl APIs to create a new GET_PARTITION_INFO mailbox command,
> > the command output data structure (privately), and accessor APIs to
> > return the different fields in the partition info output.
> >
> > Per the CXL 2.0 specification, devices report partition capacities
> > as multiples of 256MB. Define and use a capacity multiplier to
> > convert the raw data into bytes for user consumption. Use byte
> > format as the norm for all capacity values produced or consumed
> > using CXL Mailbox commands.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Looks good to me, you might want to also add a short note about the
> "cxl_cmd_new_get_partition_info()" API in the "=== MEMDEV: Commands"
> section of Documentation/cxl/lib/libcxl.txt that I started here:
> 
> https://lore.kernel.org/r/164298557771.3021641.14904324834528700206.stgit@dwillia2-desk3.amr.corp.intel.com

Will do.

> 
> Note that I'm not adding every single API there, but I think each
> cxl_cmd_new_<command_type>() API could use a short note.
> 
> That can be a follow on depending on whether Vishal merges this first
> or the topology enumeration series.

Vishal - I think this should follow the topology enumeration series
because it wants to use the cxl_filter_walk() that the topo series
introduces. (to spit out the updated partition info upon completion
of the set-partition-info cmd.)

So, a v4 posting will apply after topo series.

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>




