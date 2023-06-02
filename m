Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C18C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjFBIeL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFBIeI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 04:34:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97D1A2
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 01:34:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXbpS75L3z67fLC;
        Fri,  2 Jun 2023 16:32:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 09:34:03 +0100
Date:   Fri, 2 Jun 2023 09:34:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/port: Enable the HDM decoder capability for switch
 ports
Message-ID: <20230602093402.0000285b@Huawei.com>
In-Reply-To: <6478d479df118_e067a2946@dwillia2-xfh.jf.intel.com.notmuch>
References: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
        <20230601162712.00003bd5@Huawei.com>
        <6478d479df118_e067a2946@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 1 Jun 2023 10:25:13 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 17 May 2023 20:19:43 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Derick noticed, when testing hot plug, that hot-add behaves nominally
> > > after a removal. However, if the hot-add is done without a prior
> > > removal, CXL.mem accesses fail. It turns out that the original
> > > implementation of the port driver and region programming wrongly assumed
> > > that platform-firmware always enables the host-bridge HDM decoder
> > > capability. Add support turning on switch-level HDM decoders in the case
> > > where platform-firmware has not.
> > > 
> > > The implementation is careful to only arrange for the enable to be
> > > undone if the current instance of the driver was the one that did the
> > > enable. This is to interoperate with platform-firmware that may expect
> > > CXL.mem to remain active after the driver is shutdown. This comes at the
> > > cost of potentially not shutting down the enable on kexec flows, but it
> > > is mitigated by the fact that the related HDM decoders still need to be
> > > enabled on an individual basis.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Derick Marks <derick.w.marks@intel.com>
> > > Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > I doubt anyone will be surprised to hear that the QEMU emulation wasn't
> > checking this bit when doing the topology walk.
> > Oops - I'll put together a fix.
> > 
> > I'm guessing this is already queued or upstream but if not
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> So I took it on faith from the reporter who said "the kernel is failing
> to enable the HDM decoder capability in the root port", but now that I
> go back and read the specification this bit is only applicable to
> *endpoints*. So something else is wrong and this needs to be reverted.

Glad you checked! :)

I'll drop the qemu patch (not posted yet)

Thanks,

Jonathan
