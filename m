Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1880C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B87610E9
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhIJIsK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:48:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3755 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIsJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 04:48:09 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H5Tvj4W0zz67lk2;
        Fri, 10 Sep 2021 16:44:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 10:46:57 +0200
Received: from localhost (10.52.123.213) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 09:46:57 +0100
Date:   Fri, 10 Sep 2021 09:46:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <nvdimm@lists.linux.dev>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v4 10/21] cxl/pci: Drop idr.h
Message-ID: <20210910094655.00005481@Huawei.com>
In-Reply-To: <20210909163457.mir5khmdf26awtzc@intel.com>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163116434668.2460985.12264757586266849616.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210909163457.mir5khmdf26awtzc@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.213]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 9 Sep 2021 09:34:57 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-09-08 22:12:26, Dan Williams wrote:
> > Commit 3d135db51024 ("cxl/core: Move memdev management to core") left
> > this straggling include for cxl_memdev setup. Clean it up.
> > 
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for breaking this out.

J
> 
> > ---
> >  drivers/cxl/pci.c |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index e2f27671c6b2..9d8050fdd69c 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -8,7 +8,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/cdev.h>
> > -#include <linux/idr.h>
> >  #include <linux/pci.h>
> >  #include <linux/io.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >   

