Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDFC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73946128C
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhFNQXH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 12:23:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3238 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhFNQXH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Jun 2021 12:23:07 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3bvh26Qnz6H7TM;
        Tue, 15 Jun 2021 00:08:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 18:21:02 +0200
Received: from localhost (10.52.124.209) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 17:21:01 +0100
Date:   Mon, 14 Jun 2021 17:20:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce concept of region
 configuration
Message-ID: <20210614172055.00007ae3@Huawei.com>
In-Reply-To: <20210614161851.iipfwo5dvxkht7yw@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
        <20210610185725.897541-5-ben.widawsky@intel.com>
        <20210611145206.00003c50@Huawei.com>
        <20210614161851.iipfwo5dvxkht7yw@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.209]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Jun 2021 09:18:51 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-06-11 14:52:06, Jonathan Cameron wrote:
> > On Thu, 10 Jun 2021 11:57:25 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > The region creation APIs leave a region unconfigured. Configuring the
> > > region will work in the same way as similar subsystems such as devdax.
> > > Sysfs attrs will be provided to allow userspace to configure the region.
> > > Finally once all configuration is complete, userspace may "commit" the
> > > config. What the kernel decides to do after a config is committed is out
> > > of scope at this point.
> > > 
> > > Introduced here are the most basic attributes needed to configure a
> > > region.
> > > 
> > > A x1 interleave example is provided below:
> > > 
> > > decoder1.0
> > > ├── create_region
> > > ├── delete_region
> > > ├── devtype
> > > ├── locked
> > > ├── region1.0:0
> > > │   ├── offset
> > > │   ├── size
> > > │   ├── subsystem -> ../../../../../../../bus/cxl
> > > │   ├── target0
> > > │   ├── uevent
> > > │   ├── uuid
> > > │   └── verify
> > > ├── size
> > > ├── start
> > > ├── subsystem -> ../../../../../../bus/cxl
> > > ├── target_list
> > > ├── target_type
> > > └── uevent
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl |  27 +++
> > >  drivers/cxl/mem.h                       |   2 +
> > >  drivers/cxl/region.c                    | 227 +++++++++++++++++++++++-
> > >  3 files changed, 255 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index 699c8514fd7b..d7174a84f70d 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -159,3 +159,30 @@ Description:
> > >  		integer is returned describing the first error found in the
> > >  		configuration. A verified region can still fail binding due to
> > >  		lack of resources.
> > > +
> > > +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{offset,size}  
> > 
> > I missed this before, but why do we need X.Y in the region naming given it's
> > always inside decoderX.Y.  Seems like RegionZ would work.
> >   
> 
> Yes. There are two options, either we do X.Y:Z, or Z where Z is globally unique
> across all decoders. The reason for this is the devices are symlinked into sysfs
> and so you can't have the same Z for multiple regions in different decoders.
> 
> My preference is to have regionX.y:[0-n] for each decoder, rather than the globally
> unique. I'll entertain an argument the other way though.

I'm happy with either approach.

Thanks,

Jonathan
