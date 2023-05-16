Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E9C77B7F
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 09:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjEPJgP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjEPJgN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 05:36:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B9420C
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 02:36:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QL9zv1QVbz6D8Yj;
        Tue, 16 May 2023 17:34:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 10:36:05 +0100
Date:   Tue, 16 May 2023 10:36:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/device: Handle Media Disabled state
Message-ID: <20230516103605.00005093@Huawei.com>
In-Reply-To: <6ydxwjc6dy4pbxblikfglab7txhul5fn3pvcosuwi2ys3j5gfs@y4vp2pfwnswg>
References: <20230418172337.19207-1-dave@stgolabs.net>
        <20230418172337.19207-4-dave@stgolabs.net>
        <20230515133936.00007bce@Huawei.com>
        <6ydxwjc6dy4pbxblikfglab7txhul5fn3pvcosuwi2ys3j5gfs@y4vp2pfwnswg>
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

On Mon, 15 May 2023 09:41:29 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 15 May 2023, Jonathan Cameron wrote:
> 
> >On Tue, 18 Apr 2023 10:23:35 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Ensure that both memory device read/writes and mailbox commands
> >> can deal with the device media being disabled - per CXL 3.0 specs
> >> 8.2.9.8.5.1 - Sanitize. Disabled semantics here are strictly 11b,
> >> however noting that if the media is not in the ready state (01b),
> >> user data is not accessible.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >> ---
> >>  hw/cxl/cxl-mailbox-utils.c  | 15 +++++++++++++++
> >>  hw/mem/cxl_type3.c          | 10 ++++++++++
> >>  include/hw/cxl/cxl_device.h | 33 +++++++++++++++++++++++++++++++++
> >>  3 files changed, 58 insertions(+)
> >>
> >> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> index 224bfdb4bfca..e0e20bc3a2bb 100644
> >> --- a/hw/cxl/cxl-mailbox-utils.c
> >> +++ b/hw/cxl/cxl-mailbox-utils.c
> >> @@ -891,6 +891,21 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> >>          if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
> >>              cxl_cmd->payload = cxl_dstate->mbox_reg_state +
> >>                  A_CXL_DEV_CMD_PAYLOAD;
> >> +
> >> +            if (cxl_dev_media_disabled(cxl_dstate)) {
> >> +                if (h == cmd_events_get_records ||
> >> +                    h == cmd_logs_get_log ||
> >> +                    h == cmd_ccls_get_partition_info ||
> >> +                    h == cmd_ccls_get_lsa ||
> >> +                    h == cmd_ccls_set_lsa ||
> >> +                    h == cmd_media_get_poison_list ||
> >> +                    h == cmd_media_inject_poison ||
> >> +                    h == cmd_media_clear_poison) {
> >> +                        ret = CXL_MBOX_MEDIA_DISABLED;
> >> +                        goto done;
> >> +                }
> >> +            }
> >> +
> >>              /* Only one bg command at a time */
> >>              if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> >>                  cxl_dstate->bg.runtime > 0) {
> >> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> >> index 801f72c5fcae..707bdc263f03 100644
> >> --- a/hw/mem/cxl_type3.c
> >> +++ b/hw/mem/cxl_type3.c
> >> @@ -12,6 +12,7 @@
> >>  #include "qemu/pmem.h"
> >>  #include "qemu/range.h"
> >>  #include "qemu/rcu.h"
> >> +#include "qemu/guest-random.h"
> >>  #include "sysemu/hostmem.h"
> >>  #include "sysemu/numa.h"
> >>  #include "hw/cxl/cxl.h"
> >> @@ -989,6 +990,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> >>      if (res) {
> >>          return MEMTX_ERROR;
> >>      }
> >> +    /* all memory reads will return random values */  
> >
> >Reference for this would be good.  Random is expensive if we can get
> >away with a constant value.  
> 
> Oh I threw out any performance expectations for qemu out the window, otherwise
> I'd cry. Unless it's problem (this is media disabled, so bleh), I would
> prefer keeping it as is.

Fair enough though marked data (the old DEADBEEF or similar) might be more
useful for verifying it worked as expected.

> 
> >> +    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
> >> +        qemu_guest_getrandom_nofail(data, size);
> >> +        return MEMTX_OK;
> >> +    }
> >>
> >>      return address_space_read(as, dpa_offset, attrs, data, size);
> >>  }
> >> @@ -1005,6 +1011,10 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> >>      if (res) {
> >>          return MEMTX_ERROR;
> >>      }
> >> +    /* memory writes to the device will have no effect */
> >> +    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
> >> +        return MEMTX_OK;
> >> +    }
> >>
> >>      return address_space_write(as, dpa_offset, attrs, &data, size);
> >>  }
> >> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> >> index f986651b6ead..3ef7a7cded95 100644
> >> --- a/include/hw/cxl/cxl_device.h
> >> +++ b/include/hw/cxl/cxl_device.h
> >> @@ -346,6 +346,39 @@ REG64(CXL_MEM_DEV_STS, 0)
> >>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
> >>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
> >>
> >> +static inline void cxl_dev_media_toggle(CXLDeviceState *cxl_dstate, int val)
> >> +{
> >> +    uint64_t reg;
> >> +
> >> +    reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
> >> +    if (FIELD_EX64(reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == val) {
> >> +        return;
> >> +    }
> >> +
> >> +    reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> >> +    reg = FIELD_DP64(reg, CXL_MEM_DEV_STS, MBOX_READY, 0x1);
> >> +
> >> +    stq_le_p(&cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS, reg);  
> >
> >Why & ?  
> 
> braino
> 
> Thanks,
> Davidlohr

