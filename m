Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85674C7EE29
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjFHPWL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFHPWL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 11:22:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA2E2
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 08:22:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcSc81Xxmz6J6sS;
        Thu,  8 Jun 2023 23:21:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 16:22:04 +0100
Date:   Thu, 8 Jun 2023 16:22:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
Message-ID: <20230608162203.00003788@Huawei.com>
In-Reply-To: <BYAPR12MB33364671B3FD0721174A3F49BD50A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
        <BYAPR12MB333690E529D339194795EF50BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
        <20230608114710.000058e8@Huawei.com>
        <BYAPR12MB33364671B3FD0721174A3F49BD50A@BYAPR12MB3336.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 8 Jun 2023 14:34:48 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Thursday, June 8, 2023 5:47 AM
> > To: Vikram Sethi <vsethi@nvidia.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>; linux-cxl@vger.kernel.org;
> > ira.weiny@intel.com; navneet.singh@intel.com
> > Subject: Re: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
> > local memory
> > On Wed, 7 Jun 2023 21:09:21 +0000
> > Vikram Sethi <vsethi@nvidia.com> wrote:
> >   
> > > Thanks for posting this Dan.  
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Sent: Sunday, June 4, 2023 6:33 PM
> > > > To: linux-cxl@vger.kernel.org
> > > > Cc: ira.weiny@intel.com; navneet.singh@intel.com
> > > > Subject: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator
> > > > with local memory
> > > >
> > > > Mock-up a device that does not have a standard mailbox, i.e. a
> > > > device that does not implement the CXL memory-device class code, but
> > > > wants to map "device" memory (aka Type-2, aka HDM-D[B], aka  
> > accelerator memory).  
> > > >
> > > > +
> > > > +       cxlrd = cxl_hpa_freespace(endpoint, &endpoint->host_bridge, 1,
> > > > +                                 CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> > > > +                                 &max);
> > > > +  
> > >  
> >   
> > > IIUC, finding free HPA space is for the case where the platform FW has
> > > not already allocated it and initialized the HDM ranges in the device
> > > decoders, correct? If the accelerator driver recognized that FW had
> > > initialized its HPA ranges in the device decoders (without
> > > committing/locking the decoders), could it skip the cxl_hpa_freespace
> > > call? It would seem reasonable for FW to init the decoder but not
> > > commit/lock it.  
> > 
> > I'd find it a bit odd if firmware did a partial job...
> > Why do you think it might?  To pass a hint to the kernel?
> >   

> Firmware could certainly initialize, commit, and lock the decoder for
> accelerators that are soldered on the motherboard. I just wasn't sure
> if the CXL core code could deal with a committed and locked decoder. 

It can for type 3 devices, I haven't checked it still applies for
this type 2 code.

> I was also thinking about chiplets within a package with new
> specifications like UCIe where it is possible that chip designers
> assigned a fixed HPA range in the chip address map to a CXL device
> chiplet's HDM. Would it be sufficient for FW to convey this by
> committing and locking the decoders, or would we need some new ACPI
> flags telling the kernel that this device's decoders can really
> decode a fixed HPA range and not to change the fixed values? A
> similar notion exists in PCIe of fixed BARs called enhanced
> allocation with hardwired addresses.

If they are hard wired then FW should just lock them I think.

Jonathan

