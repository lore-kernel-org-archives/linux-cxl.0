Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28087C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D71D60EB2
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhHBQay (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:30:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3562 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHBQax (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 12:30:53 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gdk564gTsz6BBS5;
        Tue,  3 Aug 2021 00:30:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:30:42 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 17:30:41 +0100
Date:   Mon, 2 Aug 2021 17:30:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v3 5/6] cxl/pci: Introduce cdevm_file_operations
Message-ID: <20210802173013.00002a40@Huawei.com>
In-Reply-To: <CAPcyv4jyNGrTDG=XGyqYtaCr+gLDjqUnmySD3zTiiTrNfwc51g@mail.gmail.com>
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162767564242.3322476.16483313353240361673.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210802160424.0000641b@Huawei.com>
        <CAPcyv4jyNGrTDG=XGyqYtaCr+gLDjqUnmySD3zTiiTrNfwc51g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 2 Aug 2021 09:15:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Aug 2, 2021 at 8:05 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 30 Jul 2021 13:07:22 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > In preparation for moving cxl_memdev allocation to the core, introduce
> > > cdevm_file_operations to coordinate file operations shutdown relative to
> > > driver data release.
> > >
> > > The motivation for moving cxl_memdev allocation to the core (beyond
> > > better file organization of sysfs attributes in core/ and drivers in
> > > cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
> > > module should be free to come and go without needing to coordinate with
> > > devices that need the text associated with cxl_memdev_release() to stay
> > > resident. The move will fix a use after free bug when looping driver
> > > load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.
> > >
> > > Another motivation for passing in file_operations to the core cxl_memdev
> > > creation flow is to allow for alternate drivers, like unit test code, to
> > > define their own ioctl backends.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> >
> > Hi Dan / Ben,
> >
> > One utterly trivial question inline, otherwise looks good.
> >  
> > > ---
> > >  drivers/cxl/mem.h |   15 ++++++++++++
> > >  drivers/cxl/pci.c |   65 +++++++++++++++++++++++++++++++----------------------
> > >  2 files changed, 53 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > > index 8f02d02b26b4..77f4411c7c6a 100644
> > > --- a/drivers/cxl/mem.h
> > > +++ b/drivers/cxl/mem.h
> > > @@ -34,6 +34,21 @@
> > >   */
> > >  #define CXL_MEM_MAX_DEVS 65536
> > >
> > > +/**
> > > + * struct cdevm_file_operations - devm coordinated cdev file operations
> > > + * @fops: typical file operations  
> >
> > Why typical? Seems that simply saying "file operations" conveys the same
> > information.  What is atypical here?  
> 
> Hmm, I was thinking the need for an extra shutdown operation is
> "atypical", but you're right this description does not add anything.
> I'll change it too:
> 
> @fops: file operations that are synchronized against @shutdown

Indeed, much better.

Jonathan
