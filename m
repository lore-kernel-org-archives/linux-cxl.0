Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399FC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 12:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbjEOMkx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbjEOMj2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 08:39:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03312E4F
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 05:35:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKdyt2llMz6J6KY;
        Mon, 15 May 2023 20:31:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 13:35:41 +0100
Date:   Mon, 15 May 2023 13:35:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/mbox: Wire up interrupts for background
 completion
Message-ID: <20230515133540.00006db6@Huawei.com>
In-Reply-To: <20230418172337.19207-3-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
        <20230418172337.19207-3-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:23:34 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Notify when the background operation is done.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
A comment inline on an overall limitation of the qemu CXL code so far.
Otherwise LGTM.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/cxl/cxl-device-utils.c   | 10 +++++++++-
>  hw/cxl/cxl-mailbox-utils.c  | 11 +++++++++++
>  hw/mem/cxl_type3.c          |  2 +-
>  include/hw/cxl/cxl_device.h |  1 +
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 4bb4e85dae19..b10ab390234c 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -272,10 +272,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
>  
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    /* 2048 payload size, with no interrupt */
> +    const uint8_t msi_n = 11;

Not expecting you to do it in this series, but note that the interrupt handling
should allow for us not getting enough vectors and having to change the mapping
on the fly.  I've been meaning to tidy that up for a while. IT will mean this
needs to be non const and not written just at init time.

> +
> +    /* 2048 payload size */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
>      cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
> +    /* irq support */
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     BG_INT_CAP, 1);
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     MSI_N, msi_n);
> +    cxl_dstate->mbox_msi_n = msi_n;
>  }
>  
>  static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1a4480d42908..224bfdb4bfca 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -8,6 +8,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_events.h"
>  #include "hw/pci/pci.h"
> @@ -980,9 +982,18 @@ static void bg_timercb(void *opaque)
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
>  
>      if (cxl_dstate->bg.complete_pct == 100) {
> +        CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +        PCIDevice *pdev = PCI_DEVICE(ct3d);
> +
>          cxl_dstate->bg.starttime = 0;
>          /* registers are updated, allow new bg-capable cmds */
>          cxl_dstate->bg.runtime = 0;
> +
> +        if (msix_enabled(pdev)) {
> +            msix_notify(pdev, cxl_dstate->mbox_msi_n);
> +        } else if (msi_enabled(pdev)) {
> +            msi_notify(pdev, cxl_dstate->mbox_msi_n);
> +        }
>      }
>  }
>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 63c28a1ed5d2..801f72c5fcae 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -777,7 +777,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> -    unsigned short msix_num = 10;
> +    unsigned short msix_num = 12;
>      int i, rc;
>  
>      QTAILQ_INIT(&ct3d->error_list);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index dbb8a955723b..f986651b6ead 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -189,6 +189,7 @@ typedef struct cxl_device_state {
>      struct {
>          MemoryRegion mailbox;
>          uint16_t payload_size;
> +        uint8_t mbox_msi_n;
>          union {
>              uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
>              uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];

