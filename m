Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A7EC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjDTQfq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjDTQfn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 12:35:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E03584
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682008513; x=1713544513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xuAmcvWDwV3CSuZM/G5OEQsoS25gwoCfiFFwgPN6NWg=;
  b=etU3RRb7MjEgpTRe04719mV+lnZZIYRPrzu+ScpxXMP2LBTzYWKoDxTk
   /D1NQzuN6yqHw/2wy1j1ljg5A+DaxJGU9JmLIbPZetdU+alnUWCw4OMJ/
   EzGbK396Pb7q5S+cF6e/nqkroBKvTh9CTxDzXnk+0d5hpoZFIG5kdOrDr
   Q7A8rhJNuCpQwKJYqO3z0fUY7sDtGVE6DBm8Gzjl2BFkPI2CBF9R7wHGS
   Cedv84ESdanaOzeAWtgYUQb5niAt6oMA+TJVyA5Sc6QkAqtrnsf45ep6h
   eHlX2cGDNjVX/tKaXtAf2VSrD2eIntRqezzJ9hM4X70oMttduA8Iu0xGT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334627828"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="334627828"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="866336453"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="866336453"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.228.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:15:26 -0700
Date:   Thu, 20 Apr 2023 09:15:24 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [NDCTL PATCH 0/3] ndctl: Add support of QoS Throttling Group
 (QTG) id for CXL CLI
Message-ID: <ZEFlHFpf70f6TnRC@aschofie-mobl2>
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
 <ZDnKciEJe80+2yrz@aschofie-mobl2>
 <cbee0ae4-0aa5-d2aa-649d-a0c2ef4b2e83@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbee0ae4-0aa5-d2aa-649d-a0c2ef4b2e83@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 04:27:47PM -0700, Dave Jiang wrote:
> 
> 
> On 4/14/23 2:49 PM, Alison Schofield wrote:
> > On Fri, Apr 14, 2023 at 10:42:55AM -0700, Dave Jiang wrote:
> > > The series adds support for the kernel enabling [1] of QoS Throttling Group
> > > (QTG) id. The kernel exports a QTG id for the root decoders (CFMWS) and as
> > > well as for the CXL memory devices. The QTG id exported for a device is
> > > calculated by the driver during device probe. Currently a QTG id is exported
> > > for the volatile partition and another for the persistent partition. In the
> > > future QTG id(s) will be exported for DCD regions. Display of QTG id is
> > > through the CXL CLI list command.
> > > 
> > > A QTG id check as also been added for region creation. A warning is emitted
> > > when the QTG id of a memory range of a CXL memory device being included in
> > > the CXL region assembly does not match the QTG id of the root decoder. Options
> > > are available to suppress the warning or to fail the region creation. This
> > > enabling provides a guidance on flagging memory ranges being used is not
> > > optimal for performance for the CXL region to be formed.
> > 
> > Can you cut/paste me some cxl list sample output?  I'm not going to be
> > trying this out to review.


Thanks for the samples.
The cxl list man page sample output may need updating.
Alison


> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":49660559360,
>     "size":4294967296,
>     "interleave_ways":1,
>     "max_available_extent":4294967296,
>     "pmem_capable":true,
>     "volatile_capable":true,
>     "accelmem_capable":true,
>     "qtg_id":0,
>     "nr_targets":1
>   },
>   {
>     "decoder":"decoder0.1",
>     "resource":53955526656,
>     "size":4294967296,
>     "interleave_ways":2,
>     "interleave_granularity":8192,
>     "max_available_extent":4294967296,
>     "pmem_capable":true,
>     "volatile_capable":true,
>     "accelmem_capable":true,
>     "qtg_id":0,
>     "nr_targets":2
>   }
> ]
> 
> # cxl list
> [
>   {
>     "memdev":"mem3",
>     "ram_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:c5:00.0"
>   },
>   {
>     "memdev":"mem5",
>     "pmem_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:c2:00.0"
>   },
>   {
>     "memdev":"mem2",
>     "ram_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:c4:00.0"
>   },
>   {
>     "memdev":"mem7",
>     "pmem_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:c3:00.0"
>   },
>   {
>     "memdev":"mem6",
>     "ram_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:38:00.0"
>   },
>   {
>     "memdev":"mem1",
>     "pmem_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:37:00.0"
>   },
>   {
>     "memdev":"mem4",
>     "ram_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:39:00.0"
>   },
>   {
>     "memdev":"mem0",
>     "pmem_size":268435456,
>     "qtg_id":0,
>     "serial":0,
>     "host":"0000:36:00.0"
>   }
> ]
> 
> 
> 
> > 
> > Thanks!
> > 
> > 
> > > 
> > > [1]: https://lore.kernel.org/linux-cxl/168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3/T/#t
> > > 
> > > ---
> > > 
> > > Dave Jiang (3):
> > >        ndctl: Add QTG ID support for the root decoder
> > >        ndctl: Add QTG ID support for the memory device
> > >        ndctl: add QTG ID check for region creation
> > > 
> > > 
> > >   Documentation/cxl/cxl-create-region.txt |  9 ++++
> > >   cxl/json.c                              | 22 +++++++++-
> > >   cxl/lib/libcxl.c                        | 31 ++++++++++++++
> > >   cxl/lib/libcxl.sym                      |  3 ++
> > >   cxl/lib/private.h                       |  3 ++
> > >   cxl/libcxl.h                            |  5 +++
> > >   cxl/region.c                            | 57 ++++++++++++++++++++++++-
> > >   7 files changed, 128 insertions(+), 2 deletions(-)
> > > 
> > > --
> > > 
