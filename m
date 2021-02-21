Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E2C433DB
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 03:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F4964F00
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 03:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhBUDrq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 Feb 2021 22:47:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:65026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbhBUDrp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 20 Feb 2021 22:47:45 -0500
IronPort-SDR: c3FUbvG2Xtsmf0RLgULR4XjOsaw6YnNOmaw6tS/owVOz2le0nDmeQM0qJGHmBmHDVmYc0/8J8Y
 BdfTKD0/yOHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="248239173"
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="248239173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:47:04 -0800
IronPort-SDR: NQUZQkOffegfvlmDz8DEVmZW4xAEpO3VT8A2fC1d1RnTxw/3Uhz8BRmbKTzn4aqLt6gOAe8Fpn
 QX9TYuwfddDg==
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="401826933"
Received: from aevangel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:47:04 -0800
Date:   Sat, 20 Feb 2021 19:47:03 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
Message-ID: <20210221034703.ncetonon7iseqd72@intel.com>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-20 18:38:36, Dan Williams wrote:
> On Sat, Feb 20, 2021 at 1:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > When submitting a command for userspace, input and output payload bounce
> > buffers are allocated. For a given command, both input and output
> > buffers may exist and so when allocation of the input buffer fails, the
> > output buffer must be freed. As far as I can tell, userspace can't
> > easily exploit the leak to OOM a machine unless the machine was already
> > near OOM state.
> >
> > This bug was introduced in v5 of the patch and did not exist in prior
> > revisions.
> >
> 
> Thanks for the quick turnaround, but I think that speed introduced
> some issues...
> 
> > While here, adjust the variable 'j' found in patch review by Konrad.
> 
> Please split this pure cleanup to its own patch. The subject says
> "Fixes", but it's only the one fix.
> 

This was intentional. I pinged you internally to just drop it if you don't like
to combine these kind of things. It didn't feel worthwhile to introduce a new
patch to change the 'j'. I agree with Konrad that 'j' is not the best variable
name to use. Konrad, maybe you'd like to send a fixup for that one?

I will drop this hunk.

> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Since the commit is upstream add a "Fixes" line:
> 
> Fixes: 583fa5e71cae ('cxl/mem: Add basic IOCTL interface")
> 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan and I didn't pre-review this.

My bad on this. It was a mistake that I pulled the info from the original patch
I was fixing.
