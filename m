Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2BC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FED161027
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhKJTGL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:06:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:5201 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhKJTFn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 10 Nov 2021 14:05:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219636391"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="219636391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 11:01:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="452426593"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 11:01:51 -0800
Date:   Wed, 10 Nov 2021 11:01:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [INTERNAL PATCH 2/2] cxl/cxlmem: Change cxl_mem to a more
 descriptive name
Message-ID: <20211110190151.GJ3538886@iweiny-DESK2.sc.intel.com>
References: <20211102202901.3675568-1-ira.weiny@intel.com>
 <20211102202901.3675568-3-ira.weiny@intel.com>
 <20211110174010.000055c2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110174010.000055c2@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 10, 2021 at 05:40:10PM +0000, Jonathan Cameron wrote:
> On Tue, 2 Nov 2021 13:29:01 -0700
> <ira.weiny@intel.com> wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The cxl_mem object actually represents the state of a CXL device within the
> > driver.  This is data layered on top of the PCI or other device.  Even though
> > the only device currently represented is a memory device, calling this cxl_mem
> > is confusing because this is not solely a CXL memory device.  Furthermore,
> > cxl_memdev does drive a CXL memory device.  So changing the name helps to
> > distinguish these to structures.
> > 
> > Update the structure name, function names, and the kdocs to reflect the
> > real uses of this structure.
> > 
> > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> ...
> 
> >  struct cxl_memdev *
> > -devm_cxl_add_memdev(struct cxl_mem *cxlm)
> > +devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> Just noticed on a read through (I'm trying to catch up with recent changes)
> 
> Combine the above 2 lines into one.  Could do it as a tidy up
> patch if too late to fold into this patch.

Dan has already taken this into pending.  I'll send a clean up.

Ira

> 
> Thanks,
> 
> Jonathan
> 
> 
> >  {
> >  	struct cxl_memdev *cxlmd;
> >  	struct device *dev;
> >  	struct cdev *cdev;
