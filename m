Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282FEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 15:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjFVPHz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFVPHz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 11:07:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6510F4
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 08:07:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn3c6009Hz6J6hd;
        Thu, 22 Jun 2023 23:06:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 16:07:37 +0100
Date:   Thu, 22 Jun 2023 16:07:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20230622160736.00005b81@Huawei.com>
In-Reply-To: <648b2564bf039_1c72cc294bc@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
        <648b2564bf039_1c72cc294bc@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Jun 2023 07:51:16 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> ira.weiny@ wrote:
> > I'm submitting these on behalf of Navneet.  There was a round of
> > internal discussion which left a few questions but we want to get the
> > public discussion going.  A first public preview was posted by Dan.[1]  
> 
> Apologies for not being clear and marking these appropriately.  I
> intended these to be RFC to get the discussion moving forward.  I somewhat
> rushed the submission.  Depending on where the comments in this submission
> go I'll try and make a better determination if the next submission is RFC
> or can be a proper V1.  (Although b4 will mark them v2...  I'll have to
> deal with that.)

Make sure your SoB is added after Navneet to reflect that you are
handling the posting to the mailing list even if you feel changes are insufficient
to merit a Co-developed-by tag. (no idea who is doing what :)

Jonathan


> 
> Ira
> 
> > 
> > The series has been rebased on the type-2 work posted from Dan.[2]  As
> > discussed in the community call, not all of that series is required for
> > these patches.  This will get rebased on the subset of those patches he
> > is targeting for 6.5.  The series was tested using Fan Ni's Qemu DCD
> > series.[3]
> > 
> > [cover letter]
> > 
> > A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
> > device that implements dynamic capacity.  Dynamic capacity feature
> > allows memory capacity to change dynamically, without the need for
> > resetting the device.
> > 
> > Provide initial patches to enable DCD on non interleaving regions.
> > Details:
> > 
> > - Get the dynamic capacity region information from cxl device and add
> >   the advertised DC memory to driver managed resources
> > - Get the device dynamic capacity extent list from the device and
> >   maintain it in the host and add the preallocated memory to the host
> > - Dynamic capacity region support
> > - DCD region provisioning via Dax
> > - Dynamic capacity event records
> >         a. Add capacity Events
> > 	b. Release capacity events
> > 	c. Add the memory to the host dc region
> > 	d. Release the memory from the host dc region
> > - Trace Dynamic Capacity events
> > - Send add capacity response to device
> > - Send release dynamic capacity to device
> > 
> > Cc: Navneet Singh <navneet.singh@intel.com>
> > Cc: Fan Ni <fan.ni@samsung.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: linux-cxl@vger.kernel.org
> > 
> > [1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
> > [3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
> > 
> > ---
> > Navneet Singh (5):
> >       cxl/mem : Read Dynamic capacity configuration from the device
> >       cxl/region: Add dynamic capacity cxl region support.
> >       cxl/mem : Expose dynamic capacity configuration to userspace
> >       cxl/mem: Add support to handle DCD add and release capacity events.
> >       cxl/mem: Trace Dynamic capacity Event Record
> > 
> >  drivers/cxl/Kconfig       |  11 +
> >  drivers/cxl/core/core.h   |   7 +
> >  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++--
> >  drivers/cxl/core/mbox.c   | 540 +++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/core/memdev.c |  72 +++++++
> >  drivers/cxl/core/port.c   |  18 ++
> >  drivers/cxl/core/region.c | 337 ++++++++++++++++++++++++++++-
> >  drivers/cxl/core/trace.h  |  68 +++++-
> >  drivers/cxl/cxl.h         |  32 ++-
> >  drivers/cxl/cxlmem.h      | 146 ++++++++++++-
> >  drivers/cxl/pci.c         |  14 +-
> >  drivers/dax/bus.c         |  11 +-
> >  drivers/dax/bus.h         |   5 +-
> >  drivers/dax/cxl.c         |   4 +
> >  14 files changed, 1453 insertions(+), 46 deletions(-)
> > ---
> > base-commit: 034a16d0165be3e092d60685be7b1b05e6f3059b
> > change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> > 
> > Best regards,
> > -- 
> > Ira Weiny <ira.weiny@intel.com>
> >   
> 
> 

