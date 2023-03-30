Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9DC761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjC3S2D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjC3S2C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:28:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9854681
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:28:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnX2c1Wytz6J78n;
        Fri, 31 Mar 2023 02:27:20 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:27:59 +0100
Date:   Thu, 30 Mar 2023 19:27:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
Message-ID: <20230330192758.00001c08@Huawei.com>
In-Reply-To: <6425d2be21bce_c7222944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
        <20230330181916.00007fb8@Huawei.com>
        <6425d2be21bce_c7222944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 30 Mar 2023 11:19:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 29 Mar 2023 14:35:43 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > The cxl_port driver attempts to support endpoint devices that do not
> > > advertise a component register block, but by inspection
> > > devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
> > > be skipped.
> > > 
> > > Return early and skip setting target_count since that is only relevant
> > > for switch decoders, not endpoint decoders.  
> > 
> > This is a good observation. It would be nice to not read it for the
> > HDM decoder path either. Obviously we don't use it so that doesn't do
> > any harm, but to someone reading the code it looks like we care about the
> > value.  I'm not immediately sure how we'd establish at this layer that
> > the HDM decoder is a switch or HB one though..  
> 
> @info is NULL when this routine is called for non-endpoint decoders.

Ah, so we could pass a flag into parse_hdm_decoder_caps() and not read
the value if it has no meaning for the particular decoder.

> 
> > > Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")
> > > Tested-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > Patch looks fine to me.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  

