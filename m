Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE46C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62D06112F
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhKJW3s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:29:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:14823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhKJW3r (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 10 Nov 2021 17:29:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="212832319"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="212832319"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 14:26:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="452500338"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 14:26:59 -0800
Date:   Wed, 10 Nov 2021 14:26:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/memdev: Clean up the function declaration of
 cxl_add_memdev()
Message-ID: <20211110222658.GK3538886@iweiny-DESK2.sc.intel.com>
References: <20211110191425.3761515-1-ira.weiny@intel.com>
 <CAPcyv4hQF=vTcLRRQP3hsMTGTOTMkgVw2Q2AYeJoye+jhBjA6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hQF=vTcLRRQP3hsMTGTOTMkgVw2Q2AYeJoye+jhBjA6g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 10, 2021 at 02:26:01PM -0800, Dan Williams wrote:
> On Wed, Nov 10, 2021 at 11:14 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Function return type and declaration should be on the same line.
> >
> > [1] https://lore.kernel.org/linux-cxl/20211103223413.n6fmf3gtop56wssz@intel.com/T/#m75fee4f12193169da20278cd48e9c655e904c88e
> >
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/memdev.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 5341b0ba99a7..61029cb7ac62 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -276,8 +276,7 @@ static const struct file_operations cxl_memdev_fops = {
> >         .llseek = noop_llseek,
> >  };
> >
> > -struct cxl_memdev *
> > -devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> 
> I went ahead and just folded this in since this commit has not been
> finalized on cxl/next yet.


Works for me!  Thanks.
Ira

