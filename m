Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E01C4707F
	for <linux-cxl@archiver.kernel.org>; Thu, 27 May 2021 17:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A264A613C9
	for <linux-cxl@archiver.kernel.org>; Thu, 27 May 2021 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhE0Ryn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 May 2021 13:54:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:23450 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE0Ryn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 May 2021 13:54:43 -0400
IronPort-SDR: j8sXyAYBkbklbtK4lFODG1EOnkZHKdygcd4ZmKNKMq8n50Gk514swlURuF6H56WGFzNbBOZEu+
 AcKN5EbCaa5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="189914585"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="189914585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 10:53:06 -0700
IronPort-SDR: xcd39ppBoZq0k8DOoQutcMT3FCfu0KbNIcrtDbYAy0l04N2mPyeq+YoDGaVoNOHX7vsiPEIHhp
 6ZcTFeps13Yg==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477592931"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 10:53:06 -0700
Date:   Thu, 27 May 2021 10:53:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] cxl/mem: Map registers based on capabilities
Message-ID: <20210527175305.GF3697498@iweiny-DESK2.sc.intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
 <20210522001154.2680157-4-ira.weiny@intel.com>
 <20210525105214.00005e54@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525105214.00005e54@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 25, 2021 at 10:52:14AM +0100, Jonathan Cameron wrote:
> On Fri, 21 May 2021 17:11:52 -0700
> <ira.weiny@intel.com> wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The information required to map registers based on capabilities is
> > contained within the bars themselves.  This means the bar must be mapped
> > to read the information needed and then unmapped to map the individual
> > parts of the BAR based on capabilities.
> > 
> > Change cxl_setup_device_regs() to return a new cxl_register_map, change
> > the name to cxl_probe_device_regs().  Allocate and place
> > cxl_register_maps on a list while processing all of the specified
> > register blocks.
> > 
> > After probing all the register blocks go back and map smaller registers
> > blocks based on their capabilities and dispose of the cxl_register_maps.
> > 
> > NOTE: pci_iomap() is not managed automatically via pcim_enable_device()
> > so be careful to call pci_iounmap() correctly.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> A couple of really minor queries inline, but otherwise looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> > 
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index 38979c97158d..add66a6ec875 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/pci.h>
> >  #include "cxl.h"
> >  
> >  /**
> > @@ -12,19 +13,13 @@
> >   * point for cross-device interleave coordination through cxl ports.
> >   */
> >  
> > -/**
> > - * cxl_setup_device_regs() - Detect CXL Device register blocks
> > - * @dev: Host device of the @base mapping
> > - * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
> > - * @regs: Base pointers for device register blocks (see CXL_DEVICE_REGS())
> > - */
> 
> Nice to keep docs given this is an exported function.

I can write something better but the above does not add much IMO.  The
parameter explanations are unnecessary IMO.

> >  
> > @@ -1030,30 +1091,38 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >  		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
> >  			bar, offset, reg_type);
> >  
> > -		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > -			base = cxl_mem_map_regblock(cxlm, bar, offset);
> > -			if (!base)
> > -				return -ENOMEM;
> > -			break;
> > +		base = cxl_mem_map_regblock(cxlm, bar, offset);
> > +		if (!base) {
> > +			ret = -ENOMEM;
> > +			goto free_maps;
> >  		}
> > -	}
> >  
> > -	if (i == regblocks) {
> > -		dev_err(dev, "Missing register locator for device registers\n");
> > -		return -ENXIO;
> 
> Do we have or need an equivalent of this check somewhere else?

Yes agreed!  I moved the check to cxl_probe_regs which returns -ENXIO if the
register sets expected are not found.  A check is also added to RBI_COMPONENT
register type in the following patch.  This was moved mainly because each
register type is going to know better what it needs for proper operation.
cxl_probe_device_regs() really can't know that after this series.

Ira
