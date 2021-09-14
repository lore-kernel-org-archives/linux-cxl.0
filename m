Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B6C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E000A61056
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 09:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhINJDR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:03:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3790 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhINJDQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 05:03:16 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7y2x2Y8Cz67lk7;
        Tue, 14 Sep 2021 16:59:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:01:58 +0200
Received: from localhost (10.52.120.164) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 10:01:57 +0100
Date:   Tue, 14 Sep 2021 10:01:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 14/21] cxl/mbox: Add exclusive kernel command support
Message-ID: <20210914100154.00007425@Huawei.com>
In-Reply-To: <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210910103348.00005b5c@Huawei.com>
        <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.164]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index df2ba87238c2..d9ade5b92330 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -134,6 +134,37 @@ static const struct device_type cxl_memdev_type = {
> > >       .groups = cxl_memdev_attribute_groups,
> > >  };
> > >
> > > +/**
> > > + * set_exclusive_cxl_commands() - atomically disable user cxl commands
> > > + * @cxlm: cxl_mem instance to modify
> > > + * @cmds: bitmap of commands to mark exclusive
> > > + *
> > > + * Flush the ioctl path and disable future execution of commands with
> > > + * the command ids set in @cmds.  
> >
> > It's not obvious this function is doing that 'flush', Perhaps consider rewording?  
> 
> Changed it to:
> 
> "Grab the cxl_memdev_rwsem in write mode to flush in-flight
> invocations of the ioctl path and then disable future execution of
> commands with the command ids set in @cmds."

Great

> 
> >  
> > > + */
> > > +void set_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds)
> > > +{
> > > +     down_write(&cxl_memdev_rwsem);
> > > +     bitmap_or(cxlm->exclusive_cmds, cxlm->exclusive_cmds, cmds,
> > > +               CXL_MEM_COMMAND_ID_MAX);
> > > +     up_write(&cxl_memdev_rwsem);
> > > +}
> > > +EXPORT_SYMBOL_GPL(set_exclusive_cxl_commands);

...

> > > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > > index 9652c3ee41e7..a972af7a6e0b 100644
> > > --- a/drivers/cxl/pmem.c
> > > +++ b/drivers/cxl/pmem.c
> > > @@ -16,10 +16,7 @@
> > >   */
> > >  static struct workqueue_struct *cxl_pmem_wq;
> > >

...

> >  
> > > +
> > > +     nvdimm_delete(nvdimm);
> > > +     clear_exclusive_cxl_commands(cxlm, exclusive_cmds);
> > > +}
> > > +
> > >  static int cxl_nvdimm_probe(struct device *dev)
> > >  {
> > >       struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
> > > +     struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> > > +     struct cxl_mem *cxlm = cxlmd->cxlm;  
> >
> > Again, clxmd not used so could save a line of code
> > without loosing anything (unless it get used in a later patch of
> > course!)  
> 
> It is used... to grab cxlm, but it's an arbitrary style preference to
> avoid de-reference chains longer than one. However, since I'm only
> doing it once now perhaps you'll grant me this indulgence?
> 

This one was a 'could'.  Entirely up to you whether you do :)

Jonathan


