Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A6C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiLFJwV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiLFJvY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 04:51:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC3205DA
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 01:50:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NRFvY4KF0z68967;
        Tue,  6 Dec 2022 17:47:37 +0800 (CST)
Received: from localhost (10.45.155.47) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:50:30 +0000
Date:   Tue, 6 Dec 2022 09:50:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/pci: Remove endian confusion
Message-ID: <20221206095029.000069d5@Huawei.com>
In-Reply-To: <Y47knR08oCyC+uxO@iweiny-desk3>
References: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
        <Y47knR08oCyC+uxO@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.155.47]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 5 Dec 2022 22:43:41 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Mon, Dec 05, 2022 at 08:28:40PM -0800, Dan Williams wrote:
> > readl() already handles endian conversion. That's the main difference
> > between readl() and __raw_readl(). This is benign on little-endian
> > systems, but big endian systems will end up byte-swabbing twice.
> > 
> > Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>  
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Gah. Hate endian mess.  Anyone actually want big endian support? :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pci.c |    7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index cced4a0df3d1..33083a522fd1 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -548,15 +548,14 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
> >  		return false;
> >  
> >  	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> > -	status = le32_to_cpu((__force __le32)readl(addr));
> > +	status = readl(addr);
> >  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> >  		return false;
> >  
> >  	/* If multiple errors, log header points to first error from ctrl reg */
> >  	if (hweight32(status) > 1) {
> >  		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> > -		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
> > -				     CXL_RAS_CAP_CONTROL_FE_MASK);
> > +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
> >  	} else {
> >  		fe = status;
> >  	}
> > @@ -641,7 +640,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
> >  		return;
> >  
> >  	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> > -	status = le32_to_cpu(readl(addr));
> > +	status = readl(addr);
> >  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> >  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> >  		trace_cxl_aer_correctable_error(dev, status);
> >   

