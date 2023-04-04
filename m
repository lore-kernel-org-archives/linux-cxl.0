Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997BC6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 09:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjDDJW7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Apr 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjDDJW6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Apr 2023 05:22:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0491980
        for <linux-cxl@vger.kernel.org>; Tue,  4 Apr 2023 02:22:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrMdX5Jvhz67GC0;
        Tue,  4 Apr 2023 17:18:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Apr
 2023 10:22:54 +0100
Date:   Tue, 4 Apr 2023 10:22:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Wire up interrupts for background
 completion
Message-ID: <20230404102253.00004432@Huawei.com>
In-Reply-To: <20230403175224.00004c3f@Huawei.com>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-3-dave@stgolabs.net>
        <20230403175224.00004c3f@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 3 Apr 2023 17:52:24 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 24 Feb 2023 11:44:42 -0800
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > Notify when the background operation is done.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> Hi Davidlohr,
> 
> One trivial inline.  
> 
> Also, the interrupt setup for the PCI cap is missing I think.
> See handling in ct3_realize()

Should have said, for more minor stuff I'm fine just fixing these
up in my staging tree directly.  You can either feedback here or
when I post that series for upstream merge.  

Jonathan
> 
> 
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-device-utils.c   | 10 +++++++++-
> >  hw/cxl/cxl-mailbox-utils.c  | 11 +++++++++++
> >  include/hw/cxl/cxl_device.h |  1 +
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > index 4bb4e85dae19..a4a2c6a80004 100644
> > --- a/hw/cxl/cxl-device-utils.c
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -272,10 +272,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
> >  
> >  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
> >  {
> > -    /* 2048 payload size, with no interrupt */
> > +    const uint8_t msi_n = 9;
> > +
> > +    /* 2048 payload size */
> >      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> >                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
> >      cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
> > +    /* irq support */
> > +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> > +                     BG_INT_CAP, 1);
> > +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> > +                     MSI_N, msi_n);
> > +    cxl_dstate->mbox_msi_n = msi_n;
> >  }
> >  
> >  static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 82923bb84eb0..61f0b8d675bc 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -8,6 +8,8 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "hw/pci/msi.h"
> > +#include "hw/pci/msix.h"
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_events.h"
> >  #include "hw/pci/pci.h"
> > @@ -984,9 +986,18 @@ static void bg_timercb(void *opaque)
> >      cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
> >  
> >      if (cxl_dstate->bg.complete_pct == 100) {
> > +        CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +        PCIDevice *pdev = &ct3d->parent_obj;  
> 
> Should be casting it rather than directly accessing the parent_obj
> PCI_DEVICE(ct3d) should work.
> 
> There is an open question about whether we should be doing similar for the
> cxl_dstate.  I've not figured out the answer yet, but it may well affect this.
> 
> 
> > +
> >          cxl_dstate->bg.starttime = 0;
> >          /* registers are updated, allow new bg-capable cmds */
> >          cxl_dstate->bg.runtime = 0;
> > +
> > +        if (msix_enabled(pdev)) {
> > +            msix_notify(pdev, cxl_dstate->mbox_msi_n);
> > +        } else if (msi_enabled(pdev)) {
> > +            msi_notify(pdev, cxl_dstate->mbox_msi_n);
> > +        }
> >      }
> >  }
> >  
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index dbb8a955723b..f986651b6ead 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -189,6 +189,7 @@ typedef struct cxl_device_state {
> >      struct {
> >          MemoryRegion mailbox;
> >          uint16_t payload_size;
> > +        uint8_t mbox_msi_n;
> >          union {
> >              uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
> >              uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];  
> 
> 

