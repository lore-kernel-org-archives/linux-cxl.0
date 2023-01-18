Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C4C38147
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 11:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjARLGe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 06:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjARLFw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 06:05:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F146F318
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 02:12:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NxhQ14JPMz6J9XP;
        Wed, 18 Jan 2023 18:12:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 10:12:32 +0000
Date:   Wed, 18 Jan 2023 10:12:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 7/8] cxl: Add emulation when HDM decoders are not
 committed
Message-ID: <20230118101231.00001d81@Huawei.com>
In-Reply-To: <25e66916-f05a-d97a-2879-13f08a0a43de@intel.com>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330064247.975161.16867413974628215063.stgit@djiang5-mobl3.local>
        <20230113140712.00004f96@Huawei.com>
        <25e66916-f05a-d97a-2879-13f08a0a43de@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 17 Jan 2023 16:19:39 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/13/23 7:07 AM, Jonathan Cameron wrote:
> > On Mon, 09 Jan 2023 14:44:03 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> For the case where DVSEC range register(s) are active and HDM decoders are
> >> not committed, use RR to provide emulation. A first pass is done to note
> >> whether any decoders are committed. If there are no committed endpoint
> >> decoders, then DVSEC ranges will be used for emulation.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > Hi Dave
> > 
> > One trivial suggestion inline. With that tidied up
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> >> ---
> >>   drivers/cxl/core/hdm.c |   39 ++++++++++++++++++++++++++++++++-------
> >>   drivers/cxl/cxl.h      |    1 +
> >>   2 files changed, 33 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >> index ed5e9ef3aa9b..40844ff2fe52 100644
> >> --- a/drivers/cxl/core/hdm.c
> >> +++ b/drivers/cxl/core/hdm.c
> >> @@ -729,6 +729,33 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> >>   	return 0;
> >>   }
> >>   
> >> +static bool should_emulate_decoders(struct cxl_hdm *cxlhdm)
> >> +{
> >> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> >> +	bool committed;
> >> +	u32 ctrl;
> >> +	int i;
> >> +
> >> +	if (!is_cxl_endpoint(cxlhdm->port))
> >> +		return false;
> >> +
> >> +	if (!hdm)
> >> +		return true;
> >> +
> >> +	/*
> >> +	 * If any decoders are committed already, there should not be any
> >> +	 * emulated DVSEC decoders.
> >> +	 */
> >> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> >> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> >> +		committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);  
> > 
> > FIELD_GET() is nicer than !! I think.
> > 
> > Also, local variable isn't useful so I'd get rid of it.
> > 
> > 		if (FIELD_GET(ctrl, CXL_HDM_DECODER0_CTRL_COMMITTED))
> > 			return false;  
> 
> Compiler does not seem to like single bit mask. How about

That's strange - number of bits shouldn't matter.
hough I got parameters backwards above which doesn't help.
FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl)

> 		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> 			return false;
> > 
> >   
> >> +		if (committed)
> >> +			return false;
> >> +	}
> >> +
> >> +	return true;
> >> +}
> >> +  
> >   
> >>  
> >   

