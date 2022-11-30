Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D428C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiK3SYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiK3SXq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 13:23:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165A4D5E4
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 10:23:12 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMnck1jNTz67mcQ;
        Thu,  1 Dec 2022 02:22:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 19:23:11 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 18:23:10 +0000
Date:   Wed, 30 Nov 2022 18:23:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] cxl/acpi: Support CXL XOR Interleave Math
 (CXIMS)
Message-ID: <20221130182309.000015e4@Huawei.com>
In-Reply-To: <20221130181436.0000782f@Huawei.com>
References: <cover.1669153633.git.alison.schofield@intel.com>
        <168ca3d06756bade7d2d11f2fc9122c19206ff9a.1669153633.git.alison.schofield@intel.com>
        <20221130181436.0000782f@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> > +			   const unsigned long end)
> > +{
> > +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> > +	struct cxl_cxims_context *ctx = arg;
> > +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +	struct device *dev = ctx->dev;
> > +	struct cxl_cxims_data *cximsd;
> > +	unsigned int hbig, nr_maps;
> > +	int rc;
> > +
> > +	rc = cxl_to_granularity(cxims->hbig, &hbig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (hbig == cxld->interleave_granularity) {
> > +		/* IW 1,3 do not use xormaps and skip this parsing entirely */
> > +
> > +		if (is_power_of_2(cxld->interleave_ways))
> > +			/* 2, 4, 8, 16 way */
> > +			nr_maps = ilog2(cxld->interleave_ways);
> > +		else
> > +			/* 6, 12 way */
> > +			nr_maps = ilog2(cxld->interleave_ways / 3);
> > +
> > +		if (cxims->nr_xormaps < nr_maps) {  
> 
> Why is cxims->nr_xormaps > nr_maps not an error?
> Whilst we are just going to drop the extra entries it certainly seems
> like an oddity we should perhaps report?

Ah. I see from your example that a subset can be used so one cxims gets
used for different numbers of iw.  I'd missed that detail but it is clear
we only have one of these for each HBIG.

