Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B932C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiERRVl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiERRVk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:21:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCDC6EB30
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:21:39 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3KSH1s2tz688wM;
        Thu, 19 May 2022 01:17:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 19:21:37 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 18:21:37 +0100
Date:   Wed, 18 May 2022 18:21:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Validate port connectivity before dvsec
 ranges
Message-ID: <20220518182135.00002c09@Huawei.com>
In-Reply-To: <CAPcyv4ib5-9W+dvHBgO5y06Gwt69NJXPc8b+GsuF-wiYT9iuPw@mail.gmail.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237928334.3832067.16326444799383620141.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220518171305.000033c4@Huawei.com>
        <CAPcyv4ib5-9W+dvHBgO5y06Gwt69NJXPc8b+GsuF-wiYT9iuPw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 18 May 2022 09:41:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, May 18, 2022 at 9:15 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 12 May 2022 11:14:43 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > In preparation for validating DVSEC ranges against the platform declared
> > > CXL memory ranges (ACPI CFMWS) move port enumeration before the
> > > endpoint's decoder validation. Ultimately this logic will move to the
> > > port driver, but create a bisect point before that larger move.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/mem.c |   36 ++++++++++++++++++------------------
> > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index fed7f10ef9b2..80e75a410499 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -140,22 +140,6 @@ static int cxl_mem_probe(struct device *dev)
> > >       if (work_pending(&cxlmd->detach_work))
> > >               return -EBUSY;
> > >
> > > -     rc = cxlds->wait_media_ready(cxlds);
> > > -     if (rc) {
> > > -             dev_err(dev, "Media not active (%d)\n", rc);
> > > -             return rc;
> > > -     }
> > > -
> > > -     /*
> > > -      * If DVSEC ranges are being used instead of HDM decoder registers there
> > > -      * is no use in trying to manage those.
> > > -      */
> > > -     if (!cxl_hdm_decode_init(cxlds)) {
> > > -             dev_err(dev,
> > > -                     "Legacy range registers configuration prevents HDM operation.\n");
> > > -             return -EBUSY;
> > > -     }
> > > -
> > >       rc = devm_cxl_enumerate_ports(cxlmd);
> > >       if (rc)
> > >               return rc;
> > > @@ -171,16 +155,32 @@ static int cxl_mem_probe(struct device *dev)
> > >               dev_err(dev, "CXL port topology %s not enabled\n",
> > >                       dev_name(&parent_port->dev));
> > >               rc = -ENXIO;
> > > -             goto out;
> > > +             goto unlock;
> > >       }
> > >
> > >       rc = create_endpoint(cxlmd, parent_port);
> > > -out:
> > > +unlock:  
> >
> > Trivial but I think this rename of the label would be better in the earlier
> > patch where you first added the if (rc) below.
> > I suppose it is arguable that the previous patch is a fix so should be minimal
> > though so I'm not that bothered if you leave it here.
> >  
> 
> True, the rename is just as much a part of what "9ea4dcf49878 PM: CXL:
> Disable suspend" was missing as the fix, I'll go ahead and make the
> adjustment.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm lazy enough not to look again for something so trivial ;)
