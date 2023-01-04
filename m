Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F6C4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjADU3o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 15:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbjADU3T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 15:29:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A45395D8
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672864158; x=1704400158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LOGJBKZLx16xjqNZevaHTz/H3RvqyNcT+GKr/uZFYuY=;
  b=XviGVDVJhgsC3T/Xsp0H75PzoImhA2H8XlRJyXasbVMmxvvf4+uFf+u2
   KVylDYJJ//BUmlGDKysmCO7Y/C01XATi/XiRC/CM+sta9XuS2rm1cK1Ik
   I8cRFQZBNfXYzZpLWdkLBQZRX5TPoN3C5M+v+TPfhAdyVL3EE4DeWy5ld
   Gq6V4tr3JEt4e+C79HTSotM8en60i/+8WHttw3KadSb/Hb9yPDkdwc1/d
   VMCqLZyfChOKmA/zf6wjDF4SnpxgS/ksQd/L35E1czvFcjvo97zu4LP77
   PWsb97dMVHq+QVBps03hgSfP6i12jrQzgmb9yuRcTGfZ0D29RGluV/Gtb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="324037801"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="324037801"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:29:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723783721"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="723783721"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.42.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:29:16 -0800
Date:   Wed, 4 Jan 2023 12:29:14 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/region: Add a DPA to HPA translation helper
Message-ID: <Y7Xhmrc9s/my7+Jh@aschofie-mobl2>
References: <cover.1669153711.git.alison.schofield@intel.com>
 <31c38d6711cc3a000a5307b8ebf3b6e88675e17f.1669153711.git.alison.schofield@intel.com>
 <20221130163809.00005535@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163809.00005535@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 30, 2022 at 04:38:09PM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 15:07:48 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices may report errors and events using their DPA (device
> > physical address). When a CXL device contributes capacity to a
> > CXL region, the device's physical addresses are mapped to HPA's.
> > (host physical addresses)
> > 
> > Provide a helper to calculate the HPA when given a DPA, a region,
> > and the devices position in the region interleave.
> > 
> > Verify that the HPA is within the expected ranges that this device
> > contributes to the region interleave set.
> > 
> > The initial use case is translating the DPAs that CXL devices
> > report in media error records.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/core.h   |  3 ++
> >  drivers/cxl/core/region.c | 80 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 1d8f87be283f..72b58e53c394 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -67,6 +67,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> >  	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> >  }
> >  
> > +u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
> > +		   struct cxl_endpoint_decoder *cxled);
> > +
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> >  void cxl_mbox_init(void);
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f9ae5ad284ff..c847517e766c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1865,6 +1865,86 @@ static void cxlr_pmem_unregister(void *dev)
> >  	device_unregister(dev);
> >  }
> >  
> > +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int gran = p->interleave_granularity;
> > +	int ways = p->interleave_ways;
> > +	u64 stride;
> > +
> > +	/* Is the hpa within this region at all */
> > +	if (hpa < p->res->start || hpa > p->res->end) {
> > +		dev_dbg(&cxlr->dev,
> > +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> > +		return false;
> > +	}
> > +	/* Is the hpa in an expected stride for its pos(-ition) */
> > +	stride = p->res->start + pos * gran;
> > +	do {
> > +		if (hpa >= stride && hpa <= stride + gran - 1)
> > +			return true;
> > +
> > +		stride = stride + ways * gran;
> > +	} while (stride < p->res->end);
> > +
> > +	dev_dbg(&cxlr->dev,
> > +		"Addr trans fail: hpa 0x%llx not in any stride\n", hpa);
> > +
> > +	return false;
> > +}
> > +
> > +u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
> > +		   struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	u64 dpa_offset, hpa_offset, hpa;
> > +	int rc, pos = cxled->pos;
> > +	u16 eig;
> > +	u8 eiw;
> > +
> > +	rc = ways_to_cxl(p->interleave_ways, &eiw);
> > +	if (rc)
> > +		return rc;
> > +	rc = granularity_to_cxl(p->interleave_granularity, &eig);
> > +	if (rc)
> > +		return rc;
> returning integer as u64, so it won't end up as a useful error code.
> 

You'll see use of ULLONG_MAX as the error rc in the next patch.
Alas, I also decided NOT to keep checking the rc on these functions,
as the validity was checked at the time of storage of ways and gran.

Ducks a bit,
Alison

> > +
snip
