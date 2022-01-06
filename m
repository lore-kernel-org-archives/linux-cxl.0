Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F9FC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiAFRdu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:33:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4359 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiAFRdu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Jan 2022 12:33:50 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVD0h0xylz67MYc;
        Fri,  7 Jan 2022 01:31:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 18:33:48 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 17:33:47 +0000
Date:   Thu, 6 Jan 2022 17:33:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 23/28] cxl/region: Implement XHB verification
Message-ID: <20220106173346.00002171@huawei.com>
In-Reply-To: <20220106165815.w22abd3f2ianrvco@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-24-ben.widawsky@intel.com>
        <20220106165547.000016bd@huawei.com>
        <20220106165815.w22abd3f2ianrvco@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 6 Jan 2022 08:58:15 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 22-01-06 16:55:47, Jonathan Cameron wrote:
> > On Fri, 22 Oct 2021 11:37:04 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > Cross host bridge verification primarily determines if the requested
> > > interleave ordering can be achieved by the root decoder, which isn't as
> > > programmable as other decoders.
> > > 
> > > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > > Software Guide, chapter 2.13.14
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  .clang-format        |  1 +
> > >  drivers/cxl/region.c | 81 +++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/trace.h  |  3 ++
> > >  3 files changed, 84 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/.clang-format b/.clang-format
> > > index cb7c46371465..55f628f21722 100644
> > > --- a/.clang-format
> > > +++ b/.clang-format
> > > @@ -169,6 +169,7 @@ ForEachMacros:
> > >    - 'for_each_cpu_and'
> > >    - 'for_each_cpu_not'
> > >    - 'for_each_cpu_wrap'
> > > +  - 'for_each_cxl_decoder_target'
> > >    - 'for_each_cxl_endpoint'
> > >    - 'for_each_dapm_widgets'
> > >    - 'for_each_dev_addr'
> > > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > > index d127c9c69eef..53442de33d11 100644
> > > --- a/drivers/cxl/region.c
> > > +++ b/drivers/cxl/region.c
> > > @@ -30,6 +30,11 @@
> > >  	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
> > >  	     idx++, ep = (region)->targets[idx])
> > >  
> > > +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> > > +	for (idx = 0, target = (decoder)->target[idx];                         \
> > > +	     idx < (decoder)->nr_targets;                                      \
> > > +	     idx++, target = (decoder)->target[idx])
> > > +  
> > target used for too many things in this macro.
> > 
> > I'm messing around with this to poke some of the Qemu stuff and noticed
> > this in passing...
> > 
> > Jonathan  
> 
> Thanks.
> 
> BTW, I have some rather large changes in flight. Might be good to check this
> branch (I'm in force push mode):
> https://gitlab.com/bwidawsk/linux/-/commits/cxl_region
> 
> Also, I have a minor QEMU change (HACK) to support multiple root ports.
> https://gitlab.com/bwidawsk/qemu/-/commit/7c76849f9a4d2bc5fc9c355ed06ea926fc7ab494
Thanks. Will take a look at both.

Mostly I'm interested in the QEMU side of things and trying to get a cleaner
command line working but good to have a way to poke it an check the
CFMWS is correct etc.

Jonathan


