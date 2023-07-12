Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBAEB64D9
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 08:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGLIs6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 04:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGLIs4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 04:48:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC72E8
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 01:48:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R1BCV6wc9z67jfR;
        Wed, 12 Jul 2023 16:45:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 12 Jul
 2023 09:48:50 +0100
Date:   Wed, 12 Jul 2023 09:48:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Fan Ni <nifan@outlook.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <nmtadam.samsung@gmail.com>,
        <fan.ni@samsung.com>
Subject: Re: [Question] How to set up DVSEC CXL Range Registers for DCD
 devices
Message-ID: <20230712094849.00000ae2@Huawei.com>
In-Reply-To: <20230711091940.0000533b@Huawei.com>
References: <SG2PR06MB339718DD083E76EEA06008F2B225A@SG2PR06MB3397.apcprd06.prod.outlook.com>
        <20230706094620.000035d2@Huawei.com>
        <qvclgbexammsjxgnoqc7oeeisofl62escgjnzhqdgnapfj4pqi@zcl2jh2slajy>
        <20230711091940.0000533b@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Jul 2023 09:19:40 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 10 Jul 2023 08:36:39 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Thu, 06 Jul 2023, Jonathan Cameron wrote:
> >   
> > >On Thu, 29 Jun 2023 10:10:48 -0700
> > >Fan Ni <nifan@outlook.com> wrote:
> > >    
> > >> Hi,
> > >>
> > >> When preparing the DCD patches for QEMU emulation and testing, I hit an issue
> > >> when trying to load the cxl modules. The issue happens when the kernel tries
> > >> to do cxl pci probe where it checks whether the media is ready
> > >> through cxl_await_media_ready. The function will check dvsec mem range.
> > >>
> > >> In current QEMU code, the dvsec range registers for type3 memdev is set
> > >> only for static ram and pmem in function build_dvsecs, which will cause
> > >> the kernel fails the check of media ready of DCD devices without static
> > >> capacity.
> > >>
> > >> About the issue, I have following questions that want to ask and
> > >> clarify,
> > >>
> > >> 1. do we allow DCD device have no static (RAM/PMEM) capacity at all and
> > >> only dynamic capacity?    
> > >
> > >Yes.  That will probably be a reasonably common configuration so definitely
> > >want that to work.
> > >    
> > >>
> > >> 2. Do we need to set dvsec range registers for dynamic capacity? And how
> > >> if needed?    
> > >
> > >hmm.  I think we should.  Given a DCD device is not an eRCD (though it may
> > >be operating in RCD mode) the memory types are all from CDAT - so I think
> > >we 'could' use either one or two ranges to cover the DCD range.
> > >
> > >Desired interleave is messy but it's only a hint anyway so meh.
> > >Memory active timeout might potentially be different for say a PMEM region
> > >between a volatile range and DCD range but I guess it just needs to be
> > >the biggest of anything covered.    
> > 
> > Btw, we probably want to robustify cxl_await_media_ready() to 1) check for
> > Mem_HwInit_Mode=1 and 2) rely more on Memory_Active_Timeout to set the module
> > parameter.
> > 
> > Also, I was under the impression we wouldn't want to set the dvsec for dynamic
> > capacity exactly because of the active memory timeout, which makes no sense
> > for dcd.  
> 
> Hmm. Not sure if it makes sense or not - there is still memory and you might
> still want to let it finish waking up, even if definition of waking up is
> different. Feels like this is a question to take to CXL SSWG for confirmation,
> unless someone can find an explicit spec reference to say one way or the other.
> 

Question asked - so let us take this discussion to that closed forum until we
have an answer to act on that we can report back here.

Jonathan

> Jonathan
> 
> 
> > 
> > Thanks,
> > Davidlohr  
> 
> 

