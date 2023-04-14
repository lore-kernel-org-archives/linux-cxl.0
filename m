Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139EC77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 14:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDNOPv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDNOPu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 10:15:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF522BB93
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 07:15:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pydk35B0Yz6DD36;
        Fri, 14 Apr 2023 22:14:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 15:15:35 +0100
Date:   Fri, 14 Apr 2023 15:15:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl: Add support for device sanitation
Message-ID: <20230414151534.00004c71@Huawei.com>
In-Reply-To: <20230224194443.1990440-4-dave@stgolabs.net>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-4-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Feb 2023 11:44:43 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Make use of the background operations through the sanitize
> command, per CXL 3.0 specs. Traditionally run times can be
> rather long, depending on the size of the media.
> 
> Estimate times based on:
> 	 https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Various comments inline.  I haven't tested this yet so one
or two are educated guesses.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 139 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |   9 ++-
>  include/hw/cxl/cxl_device.h |  17 +++++
>  3 files changed, 162 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 61f0b8d675bc..aa0641f786e2 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -18,6 +18,7 @@
>  #include "qemu/log.h"
>  #include "qemu/units.h"
>  #include "qemu/uuid.h"
> +#include "sysemu/hostmem.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  
> @@ -71,6 +72,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0

I'd add the define along with the feature.
(not that I'm sure we've been doing that for all the existing ones!)

> +        #define SECURE_ERASE  0x1
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> @@ -626,6 +630,109 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* Perform the actual device zeroing */
> +static void __do_sanitization(CXLDeviceState *cxl_dstate)
> +{
> +    MemoryRegion *mr;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +
> +    if (ct3d->hostvmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (mr) {
> +            void *hostmem = memory_region_get_ram_ptr(mr);

I think this only works for ram backends.  Use the
address space writers we use for the decoded accesses.

> +            memset(hostmem, 0, memory_region_size(mr));
> +        }
> +    }
> +
> +    if (ct3d->hostpmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (mr) {
> +            void *hostmem = memory_region_get_ram_ptr(mr);
> +            memset(hostmem, 0, memory_region_size(mr));
> +        }
> +    }
> +    if (ct3d->lsa) {
> +        mr = host_memory_backend_get_memory(ct3d->lsa);
> +        if (mr) {
> +            void *lsa = memory_region_get_ram_ptr(mr);
> +            memset(lsa, 0, memory_region_size(mr));

Be odd if people are using ram for pmem of lsa as it's obviously
not going to persist!

> +        }
> +    }
> +}
> +
> +/*
> + * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
> + *
> + * Once the Sanitize command has started successfully, the device shall be
> + * placed in the media disabled state. If the command fails or is interrupted
> + * by a reset or power failure, it shall remain in the media disabled state
> + * until a successful Sanitize command has been completed. During this state:
> + *
> + * 1. Memory writes to the device will have no effect, and all memory reads
> + * will return random values (no user data returned, even for locations that
> + * the failed Sanitize operation didn’t sanitize yet).

Reference..  Can random be a fixed string?  Easier to spot if testing then
a random number.

> + *
> + * 2. Mailbox commands shall still be processed in the disabled state, except
> + * that commands that access Sanitized areas shall fail with the Media Disabled
> + * error code.
Reference.
> + */
> +static CXLRetCode cmd_sanitize_overwrite(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len)
> +{
> +    uint64_t total_mem; /* in Mb */
> +    int secs;
> +
> +    total_mem = (cxl_dstate->vmem_size + cxl_dstate->pmem_size) >> 20;

The command effects log needs to 'say' if this is a background operation
or not.  Annoying though it is (and I doubt software will care) you can't
mix and match depending on how long the operation happens to take.

Annoying because this is rather cute :)

If we want to test both paths, need to add a parameter for device
creation to say it if is should be background or not.

> +    if (total_mem <= 512) {
> +        secs = 4;
> +    } else if (total_mem <= 1024) {
> +        secs = 8;
> +    } else if (total_mem <= 2 * 1024) {
> +        secs = 15;
> +    } else if (total_mem <= 4 * 1024) {
> +        secs = 30;
> +    } else if (total_mem <= 8 * 1024) {
> +        secs = 60;
> +    } else if (total_mem <= 16 * 1024) {
> +        secs = 2 * 60;
> +    } else if (total_mem <= 32 * 1024) {
> +        secs = 4 * 60;
> +    } else if (total_mem <= 64 * 1024) {
> +        secs = 8 * 60;
> +    } else if (total_mem <= 128 * 1024) {
> +        secs = 15 * 60;
> +    } else if (total_mem <= 256 * 1024) {
> +        secs = 30 * 60;
> +    } else if (total_mem <= 512 * 1024) {
> +        secs = 60 * 60;
> +    } else if (total_mem <= 1024 * 1024) {
> +        secs = 120 * 60;
> +    } else {
> +        secs = 240 * 60; /* max 4 hrs */
> +    }
> +
> +    /* EBUSY other bg cmds as of now */
> +    cxl_dstate->bg.runtime = secs * 1000UL;
> +    *len = 0;
> +
> +    qemu_log_mask(LOG_UNIMP,
> +                  "Sanitize/overwrite command runtime for %ldMb media: %d seconds\n",
> +                  total_mem, secs);
> +
> +    cxl_dev_disable_media(cxl_dstate);
> +
> +    if (secs > 2) {
> +        /* sanitize when done */
> +        return CXL_MBOX_BG_STARTED;
> +    } else {
> +        __do_sanitization(cxl_dstate);
> +        cxl_dev_enable_media(cxl_dstate);
> +
> +        return CXL_MBOX_SUCCESS;
> +    }
> +}
> +


> @@ -970,8 +1094,19 @@ static void bg_timercb(void *opaque)
>  
>          bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
>  
> -        /* TODO add ad-hoc cmd succesful completion handling */
> -
> +        if (ret == CXL_MBOX_SUCCESS) {
> +            switch (cxl_dstate->bg.opcode) {
> +            case 0x4400: /* sanitize */

Build this from the defines and you won't need the comment.

> +                __do_sanitization(cxl_dstate);
> +                cxl_dev_enable_media(cxl_dstate);
> +                break;
> +            case 0x4304: /* TODO: scan media */

Don't add it then.  

> +                break;
> +            default:
> +                __builtin_unreachable();
> +                break;
> +            }
> +        }
>          qemu_log("Background command %04xh finished: %s\n",
>                   cxl_dstate->bg.opcode,
>                   ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 334ce92f5e0f..2b483d3d8ea9 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -12,6 +12,7 @@
>  #include "qemu/pmem.h"
>  #include "qemu/range.h"
>  #include "qemu/rcu.h"
> +#include "qemu/guest-random.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
>  #include "hw/cxl/cxl.h"
> @@ -988,6 +989,10 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
>  
> +    if (sanitize_running(&CXL_TYPE3(d)->cxl_dstate)) {
> +        qemu_guest_getrandom_nofail(data, size);
> +        return MEMTX_OK;
> +    }

Key here is that you are in media disable status.  I'd prefer checking
that to whether sanitize is running. There may be other routes to disabling
it in future.  Also makes me look at right bit of spec for what should be returned.

Speaking of which, where does the spec say what should be returned on
reads to disabled media?  Reference here (or a comment to say it's
not explicitly stated if it isn't) would be good.


>      return address_space_read(as, dpa_offset, attrs, data, size);
>  }
>  
> @@ -1003,7 +1008,9 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>      if (res) {
>          return MEMTX_ERROR;
>      }
> -
> +    if (sanitize_running(&CXL_TYPE3(d)->cxl_dstate)) {
> +        return MEMTX_OK;
> +    }

Leave the blank line here. Maybe one above the new code as well.

>      return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index f986651b6ead..e28536969397 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -346,6 +346,23 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>  
> +static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
> +{
> +    uint64_t dev_status_reg;
reg or val or similar would do.
> +
> +    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> +    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;

I haven't confirmed but I think this needs the endian fixes that we
are slowly pushing through as we touch particular code.  So you'd need to
use a little endian write.

Doesn't this wipe out the mailbox interface ready bit?  Don't want to do that!


> +}
> +#define cxl_dev_disable_media(cxlds)                    \
> +        do { __toggle_media((cxlds), 0x3); } while (0)

I'm surprised we need the do while around this... I guess checkpatch
is moaning about it?

> +#define cxl_dev_enable_media(cxlds)                     \
> +        do { __toggle_media((cxlds), 0x1); } while (0)
> +
> +static inline bool sanitize_running(CXLDeviceState *cxl_dstate)
> +{
> +    return !!cxl_dstate->bg.runtime && cxl_dstate->bg.opcode == 0x4400;

No need for the !! as you are treating it as boolean anyway via the &&

> +}
> +
>  typedef struct CXLError {
>      QTAILQ_ENTRY(CXLError) node;
>      int type; /* Error code as per FE definition */

