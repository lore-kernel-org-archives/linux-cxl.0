Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B75C04E69
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Aug 2023 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbjHPSH1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbjHPSHH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Aug 2023 14:07:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B8272C
        for <linux-cxl@vger.kernel.org>; Wed, 16 Aug 2023 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692209224; x=1723745224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfiGJ3aaRVWw41oaA8M38kovpebnG/X6n+sLKlRHb3Q=;
  b=nWLtvbrp99gNKxJJSpJRH3AMfudS/JD+U6niHn5gGPH1SAbiaywUF9PZ
   JehvPBUlfpe1OyLtRRioonjDk8G5K7jun4YSCPlvQFvnXFBsRXwWfu2lL
   8Mc7uom1Csv9H2o41cZgNvhnaKZeyvn5SwKVNBY+OtgSffSRtvoC1KAMQ
   qE2YZiGtqwN2JFJo5NCuGpUZQWr/vKZ4yzE+S0DWzxLTBOzxNsq4662Qg
   JmjZCGF2mb9pBtUVP1DBa8/cdR7skGaWzQ5i+9XEOTPLUK7af/qXiNfS8
   805Ng+rzL/RekhPIZxK0gRo6UaxlP7T66rUwuWmSFyrpVuPN9juNEUTFE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403579234"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="403579234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769303994"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="769303994"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.167])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:07:03 -0700
Date:   Wed, 16 Aug 2023 11:07:01 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     jonathan.cameron@huawei.com, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: fix compile warning for cxl_security_ops extern
Message-ID: <ZN0QRdQ6oZ5ZKraY@aschofie-mobl2>
References: <20230228150911.00002535@Huawei.com>
 <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
 <Y//rABaux/8Cgx0q@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//rABaux/8Cgx0q@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 04:17:04PM -0800, Alison Schofield wrote:
> On Wed, Mar 01, 2023 at 04:06:58PM -0700, Dave Jiang wrote:
> > Jonathan says he has observed compiler warning when using running with W=1
> > C=1 for cxl_security_ops that is declared as an extern in cxl/pmem.c. Move
> > to cxl.h to make it visible to all cxl sources.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > 
> > Hi Jonathan, I was not able to reproduce the issue with W=1 C=1. Can you
> > please see if this fixes what you were seeing? Thanks!
> 
> I was seeing this with make C=2 -Wsparse-all
> Works without complaint now.
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> 

A cleanup for 6.6 -

Tested-by: Alison Schofield <alison.schofield@intel.com>


> > 
> >  drivers/cxl/cxl.h  |    2 ++
> >  drivers/cxl/pmem.c |    2 --
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f2b0962a552d..6f00b938f342 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -10,6 +10,8 @@
> >  #include <linux/log2.h>
> >  #include <linux/io.h>
> >  
> > +extern const struct nvdimm_security_ops *cxl_security_ops;
> > +
> >  /**
> >   * DOC: cxl objects
> >   *
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index 71cfa1fdf902..55930567fc01 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -11,8 +11,6 @@
> >  #include "cxlmem.h"
> >  #include "cxl.h"
> >  
> > -extern const struct nvdimm_security_ops *cxl_security_ops;
> > -
> >  static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> >  
> >  static void clear_exclusive(void *cxlds)
> > 
> > 
