Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9095C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjC3TEL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC3TEK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 15:04:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC21FEC
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 12:04:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnXmk3sVHz6J9ZF;
        Fri, 31 Mar 2023 03:00:22 +0800 (CST)
Received: from localhost (10.195.247.161) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 20:04:07 +0100
Date:   Thu, 30 Mar 2023 20:04:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
Message-ID: <20230330200406.00002a54@Huawei.com>
In-Reply-To: <6425d9b6bf502_c722294db@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
        <20230330181916.00007fb8@Huawei.com>
        <6425d2be21bce_c7222944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <20230330192758.00001c08@Huawei.com>
        <6425d9b6bf502_c722294db@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.161]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 30 Mar 2023 11:49:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 30 Mar 2023 11:19:42 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:  
> > > > On Wed, 29 Mar 2023 14:35:43 -0700
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >     
> > > > > The cxl_port driver attempts to support endpoint devices that do not
> > > > > advertise a component register block, but by inspection
> > > > > devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
> > > > > be skipped.
> > > > > 
> > > > > Return early and skip setting target_count since that is only relevant
> > > > > for switch decoders, not endpoint decoders.    
> > > > 
> > > > This is a good observation. It would be nice to not read it for the
> > > > HDM decoder path either. Obviously we don't use it so that doesn't do
> > > > any harm, but to someone reading the code it looks like we care about the
> > > > value.  I'm not immediately sure how we'd establish at this layer that
> > > > the HDM decoder is a switch or HB one though..    
> > > 
> > > @info is NULL when this routine is called for non-endpoint decoders.  
> > 
> > Ah, so we could pass a flag into parse_hdm_decoder_caps() and not read
> > the value if it has no meaning for the particular decoder.  
> 
> How about kerneldoc on 'struct cxl_hdm' clarifying @target_count and
> other fields, because I don't see the benefit of logic to skip parsing
> that field. The overhead of an MMIO cycle to read the capability
> register has already been spent.
> 

Ok. I guess it's harmless even it if gains meaning in some later spec
version as we don't use it for anything.

Jonathan
