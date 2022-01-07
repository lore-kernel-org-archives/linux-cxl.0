Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C11C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jan 2022 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiAGUWF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jan 2022 15:22:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:64536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbiAGUWF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 7 Jan 2022 15:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641586925; x=1673122925;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=sFft1/EOmBMZw4fgNz9ww5b/Em9YHY9qTt5HGYs9I9Y=;
  b=ikRXkXuhF8NsXWFmGb0SBddtPIC0wUOfiqt+d3nsk4rLJZmhnzO3x2S6
   PGdp4BKEl7F+FVJVdpWGqgPxOOg9Wk0WsxjQcQ70BL6Zc/PKH3A+QqIV1
   F6YUuq0jEbGm4hzb73HtTMZgX+/CsvGRbLCyM+oJ1QA/QdXfiFUQq+flA
   R4QwNWYy3hmQN+aGN1FekrfHOzY4DXHpTv1N8SzAeJKG2yhjJ4eTGPltL
   vO2GPeksN13pk6a4zlm6lGIOFzyePkelFQ5defKgXplWig5/7f6JZ6sNn
   IQsmRv5DMs66iVVr4cO4ncRVp7GJLpYhhqhMMXXUDJCNQQ14zEzT/YpgV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222925268"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="222925268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:20:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527492991"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:20:27 -0800
Date:   Fri, 7 Jan 2022 12:25:37 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 2/7] libcxl: add accessors for capacity fields of
 the IDENTIFY command
Message-ID: <20220107202537.GC803588@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <577012d59f5b6b9754d2ce1147585ce5f91a3108.1641233076.git.alison.schofield@intel.com>
 <20220106203639.GC178135@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106203639.GC178135@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 06, 2022 at 12:36:39PM -0800, Ira Weiny wrote:
> On Mon, Jan 03, 2022 at 12:16:13PM -0800, Schofield, Alison wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add accessors to retrieve total capacity, volatile only capacity,
> > and persistent only capacity from the IDENTIFY mailbox command.
> > These values are useful when partitioning the device.
> 
> Reword:
> 
> The total capacity, volatile only capacity, and persistent only capacity are
> required to properly formulate a set partition info command.
> 
> Provide functions to retrieve these values from the IDENTIFY command.  Like the
> partition information commands these return the values in bytes.
> 

Will reword. Thanks.

> > 
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_cmd_identify_get_total_capacity(struct cxl_cmd *cmd)
> 
> Is there someplace that all the libcxl functions are documented?  Like the
> other functions I would like to ensure the user knows these are returning
> values in bytes.

There is a libcxl manpage, source at:
ndctl/Documentation/cxl/lib/libcxl.txt

Synopsis is:
#include <cxl/libcxl.h>
cc ... -lcxl

It describes how to use libcxl, ie alloc, submit, and get info back from
a command. I believe the intent is the user references cxl/libcxl.h to
find the accessors available. Along that line, it doesn't make any
sweeping statements about formats of data returned and I believe, based
on Dan's comments about the long descriptive names, that is by design.
ie. the name should say it all.

I'll rename these all to be _bytes instead of _capacity, as you
suggested in the prior patch.

> 
> Ira
> 
snip
> > +{
