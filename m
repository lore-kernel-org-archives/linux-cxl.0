Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD8C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 10:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKKIJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJKKII (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 06:08:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D46745F
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 03:08:05 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mmrz80Cvsz6842y;
        Tue, 11 Oct 2022 18:06:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:08:00 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 11:08:00 +0100
Date:   Tue, 11 Oct 2022 11:07:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] hw/cxl/cxl-events: Add CXL mock events
Message-ID: <20221011110759.00002226@huawei.com>
In-Reply-To: <20221010222944.3923556-4-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
        <20221010222944.3923556-4-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 15:29:41 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> To facilitate testing of guest software add mock events and code to
> support iterating through the event logs.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Various comments inline, but biggest one is I'd like to see
a much more flexible injection interface.  Happy to help code one
up if that is useful.

Jonathan


> ---
>  hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/meson.build          |   1 +
>  include/hw/cxl/cxl_device.h |  19 +++
>  include/hw/cxl/cxl_events.h | 173 +++++++++++++++++++++++++
>  4 files changed, 441 insertions(+)
>  create mode 100644 hw/cxl/cxl-events.c
>  create mode 100644 include/hw/cxl/cxl_events.h
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> new file mode 100644
> index 000000000000..c275280bcb64
> --- /dev/null
> +++ b/hw/cxl/cxl-events.c
> @@ -0,0 +1,248 @@
> +/*
> + * CXL Event processing
> + *
> + * Copyright(C) 2022 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include <stdint.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "qemu/typedefs.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_events.h"
> +
> +struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type)
> +{
> +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> +        return NULL;
> +    }
> +    return &cxlds->event_logs[log_type];
> +}
> +
> +struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log)
> +{
> +    return log->events[log->cur_event];
> +}
> +
> +uint16_t get_cur_event_handle(struct cxl_event_log *log)
> +{
> +    return cpu_to_le16(log->cur_event);
> +}
> +
> +bool log_empty(struct cxl_event_log *log)
> +{
> +    return log->cur_event == log->nr_events;
> +}
> +
> +int log_rec_left(struct cxl_event_log *log)
> +{
> +    return log->nr_events - log->cur_event;
> +}
> +
> +static void event_store_add_event(CXLDeviceState *cxlds,
> +                                  enum cxl_event_log_type log_type,
> +                                  struct cxl_event_record_raw *event)
> +{
> +    struct cxl_event_log *log;
> +
> +    assert(log_type < CXL_EVENT_TYPE_MAX);
> +
> +    log = &cxlds->event_logs[log_type];
> +    assert(log->nr_events < CXL_TEST_EVENT_CNT_MAX);
> +
> +    log->events[log->nr_events] = event;
> +    log->nr_events++;
> +}
> +
> +uint16_t log_overflow(struct cxl_event_log *log)
> +{
> +    int cnt = log_rec_left(log) - 5;

Why -5?  Can't we make it actually overflow and drop records
if that happens?

> +
> +    if (cnt < 0) {
> +        return 0;
> +    }
> +    return cnt;
> +}
> +
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT         BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED      BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED     BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE        BIT(5)
> +
> +struct cxl_event_record_raw maint_needed = {
> +    .hdr = {
> +        .id.data = UUID(0xDEADBEEF, 0xCAFE, 0xBABE,
> +                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +        .length = sizeof(struct cxl_event_record_raw),
> +        .flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> +        /* .handle = Set dynamically */
> +        .related_handle = const_le16(0xa5b6),
> +    },
> +    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +struct cxl_event_record_raw hardware_replace = {
> +    .hdr = {
> +        .id.data = UUID(0xBABECAFE, 0xBEEF, 0xDEAD,
> +                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +        .length = sizeof(struct cxl_event_record_raw),
> +        .flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> +        /* .handle = Set dynamically */
> +        .related_handle = const_le16(0xb6a5),
> +    },
> +    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT            BIT(0)
> +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT               BIT(1)
> +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW          BIT(2)
> +
> +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR                 0x00
> +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR                  0x01
> +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR           0x02
> +
> +#define CXL_GMER_TRANS_UNKNOWN                          0x00
> +#define CXL_GMER_TRANS_HOST_READ                        0x01
> +#define CXL_GMER_TRANS_HOST_WRITE                       0x02
> +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA                  0x03
> +#define CXL_GMER_TRANS_HOST_INJECT_POISON               0x04
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB             0x05
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT        0x06
> +
> +#define CXL_GMER_VALID_CHANNEL                          BIT(0)
> +#define CXL_GMER_VALID_RANK                             BIT(1)
> +#define CXL_GMER_VALID_DEVICE                           BIT(2)
> +#define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +
> +struct cxl_event_gen_media gen_media = {
> +    .hdr = {
> +        .id.data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> +                        0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +        .length = sizeof(struct cxl_event_gen_media),
> +        .flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
> +        /* .handle = Set dynamically */
> +        .related_handle = const_le16(0),
> +    },
> +    .phys_addr = const_le64(0x2000),
> +    .descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +    .type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +    .transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> +    .validity_flags = { CXL_GMER_VALID_CHANNEL |
> +                        CXL_GMER_VALID_RANK, 0 },
> +    .channel = 1,
> +    .rank = 30
> +};
> +
> +#define CXL_DER_VALID_CHANNEL                           BIT(0)
> +#define CXL_DER_VALID_RANK                              BIT(1)
> +#define CXL_DER_VALID_NIBBLE                            BIT(2)
> +#define CXL_DER_VALID_BANK_GROUP                        BIT(3)
> +#define CXL_DER_VALID_BANK                              BIT(4)
> +#define CXL_DER_VALID_ROW                               BIT(5)
> +#define CXL_DER_VALID_COLUMN                            BIT(6)
> +#define CXL_DER_VALID_CORRECTION_MASK                   BIT(7)
> +
> +struct cxl_event_dram dram = {
> +    .hdr = {
> +        .id.data = UUID(0x601dcbb3, 0x9c06, 0x4eab,
> +                        0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +        .length = sizeof(struct cxl_event_dram),
> +        .flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> +        /* .handle = Set dynamically */
> +        .related_handle = const_le16(0),
> +    },
> +    .phys_addr = const_le64(0x8000),
> +    .descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> +    .type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> +    .transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> +    .validity_flags = { CXL_DER_VALID_CHANNEL |
> +                        CXL_DER_VALID_BANK_GROUP |
> +                        CXL_DER_VALID_BANK |
> +                        CXL_DER_VALID_COLUMN, 0 },
> +    .channel = 1,
> +    .bank_group = 5,
> +    .bank = 2,
> +    .column = { 0xDE, 0xAD},
> +};
> +
> +#define CXL_MMER_HEALTH_STATUS_CHANGE           0x00
> +#define CXL_MMER_MEDIA_STATUS_CHANGE            0x01
> +#define CXL_MMER_LIFE_USED_CHANGE               0x02
> +#define CXL_MMER_TEMP_CHANGE                    0x03
> +#define CXL_MMER_DATA_PATH_ERROR                0x04
> +#define CXL_MMER_LAS_ERROR                      0x05

Ah this explains why I didn't find these alongside the structures.
I'd keep them together.  If we need to put the structures in a header
then put the defines there as well.  Puts all the spec related
stuff in one place.

> +
> +#define CXL_DHI_HS_MAINTENANCE_NEEDED           BIT(0)
> +#define CXL_DHI_HS_PERFORMANCE_DEGRADED         BIT(1)
> +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED        BIT(2)
> +
> +#define CXL_DHI_MS_NORMAL                                    0x00
> +#define CXL_DHI_MS_NOT_READY                                 0x01
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST                    0x02
> +#define CXL_DHI_MS_ALL_DATA_LOST                             0x03
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS   0x04
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN     0x05
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT           0x06
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS      0x07
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN        0x08
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT              0x09
> +
> +#define CXL_DHI_AS_NORMAL               0x0
> +#define CXL_DHI_AS_WARNING              0x1
> +#define CXL_DHI_AS_CRITICAL             0x2
> +
> +#define CXL_DHI_AS_LIFE_USED(as)        (as & 0x3)
> +#define CXL_DHI_AS_DEV_TEMP(as)         ((as & 0xC) >> 2)
> +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)  ((as & 0x10) >> 4)
> +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)  ((as & 0x20) >> 5)
> +
> +struct cxl_event_mem_module mem_module = {
> +    .hdr = {
> +        .id.data = UUID(0xfe927475, 0xdd59, 0x4339,
> +                        0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),

As mentioned, below a UUID define for each type in the header
probably makes more sense than having this huge thing inline.

> +        .length = sizeof(struct cxl_event_mem_module),
> +        /* .handle = Set dynamically */
> +        .related_handle = const_le16(0),
> +    },
> +    .event_type = CXL_MMER_TEMP_CHANGE,
> +    .info = {
> +        .health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
> +        .media_status = CXL_DHI_MS_ALL_DATA_LOST,
> +        .add_status = (CXL_DHI_AS_CRITICAL << 2) |
> +                       (CXL_DHI_AS_WARNING << 4) |
> +                       (CXL_DHI_AS_WARNING << 5),
> +        .device_temp = { 0xDE, 0xAD},

odd spacing

> +        .dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +        .cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },

Could make a reasonable number up rather than deadbeef ;)

> +        .cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +    }
> +};
> +
> +void cxl_mock_add_event_logs(CXLDeviceState *cxlds)
> +{

This is fine for initial testing, but I Think we want to be more
sophisticated with the injection interface and allow injecting
individual events so we can move the requirement for 'coverage'
testing from having a representative list here to an external script
that hits all the corners.

I can build something on top of this that lets us doing that if you like.
I have ancient code doing the equivalent for CCIX devices that I never
upstreamed. Would probably do it a bit differently today but principle
is the same. Using QMP  directly rather than qmp-shell lets you do it
as json which ends up more readable than complex command lines for this
sort of structure command.



> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO, &maint_needed);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
> +                          (struct cxl_event_record_raw *)&gen_media);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
> +                          (struct cxl_event_record_raw *)&mem_module);
> +
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &maint_needed);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> +                          (struct cxl_event_record_raw *)&dram);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> +                          (struct cxl_event_record_raw *)&gen_media);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> +                          (struct cxl_event_record_raw *)&mem_module);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
> +                          (struct cxl_event_record_raw *)&dram);
> +
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL,
> +                          (struct cxl_event_record_raw *)&dram);
> +}


> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7b4cff569347..46c50c1c13a6 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -11,6 +11,7 @@
>  #define CXL_DEVICE_H
>  
>  #include "hw/register.h"
> +#include "hw/cxl/cxl_events.h"
>  
>  /*
>   * The following is how a CXL device's Memory Device registers are laid out.
> @@ -80,6 +81,14 @@
>      (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
>       CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
>  
> +#define CXL_TEST_EVENT_CNT_MAX 15

Where did 15 come from?

> +
> +struct cxl_event_log {
> +    int cur_event;
> +    int nr_events;
> +    struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> +};
> +
>  typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>  
> @@ -119,6 +128,8 @@ typedef struct cxl_device_state {
>  
>      /* memory region for persistent memory, HDM */
>      uint64_t pmem_size;
> +
> +    struct cxl_event_log event_logs[CXL_EVENT_TYPE_MAX];
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */
> @@ -272,4 +283,12 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>                              unsigned size, MemTxAttrs attrs);
>  
> +void cxl_mock_add_event_logs(CXLDeviceState *cxlds);
> +struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type);
> +struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log);
> +uint16_t get_cur_event_handle(struct cxl_event_log *log);
> +bool log_empty(struct cxl_event_log *log);
> +int log_rec_left(struct cxl_event_log *log);
> +uint16_t log_overflow(struct cxl_event_log *log);
> +
>  #endif
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> new file mode 100644
> index 000000000000..255111f3dcfb
> --- /dev/null
> +++ b/include/hw/cxl/cxl_events.h
> @@ -0,0 +1,173 @@
> +/*
> + * QEMU CXL Events
> + *
> + * Copyright (c) 2022 Intel
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef CXL_EVENTS_H
> +#define CXL_EVENTS_H
> +
> +#include "qemu/uuid.h"
> +#include "hw/cxl/cxl.h"
> +
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_REC_HDR_RES_LEN 0xf

I don't see an advantage in this define vs just
putting the value in directly below.
Same with similar cases - the define must makes them
a tiny bit harder to compare with the specification when
reviewing.

> +struct cxl_event_record_hdr {
> +    QemuUUID id;
> +    uint8_t length;
> +    uint8_t flags[3];
> +    uint16_t handle;
> +    uint16_t related_handle;
> +    uint64_t timestamp;
> +    uint8_t maint_op_class;
> +    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +} QEMU_PACKED;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +    struct cxl_event_record_hdr hdr;
> +    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} QEMU_PACKED;

Hmm. I wonder if we should instead define this as a union of
the known event types?  I haven't checked if it would work
everywhere yet though.

> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + *
> + * Space given for 1 record
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
> +struct cxl_get_event_payload {
> +    uint8_t flags;
> +    uint8_t reserved1;
> +    uint16_t overflow_err_count;
> +    uint64_t first_overflow_timestamp;
> +    uint64_t last_overflow_timestamp;
> +    uint16_t record_count;
> +    uint8_t reserved2[0xa];
> +    struct cxl_event_record_raw record;

This last element should be a [] array and then move
the handling of different record counts to the places it
is used.

Spec unfortunately says that we should return as many
as we can fit, so we can't rely on the users of this interface
only sending a request for one record (as I think your Linux
kernel code currently does). See below for more on this...


> +} QEMU_PACKED;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +    CXL_EVENT_TYPE_INFO = 0x00,
> +    CXL_EVENT_TYPE_WARN,
> +    CXL_EVENT_TYPE_FAIL,
> +    CXL_EVENT_TYPE_FATAL,
> +    CXL_EVENT_TYPE_DYNAMIC_CAP,
> +    CXL_EVENT_TYPE_MAX
> +};
> +
> +static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> +{
> +    switch (type) {
> +    case CXL_EVENT_TYPE_INFO:
> +        return "Informational";
> +    case CXL_EVENT_TYPE_WARN:
> +        return "Warning";
> +    case CXL_EVENT_TYPE_FAIL:
> +        return "Failure";
> +    case CXL_EVENT_TYPE_FATAL:
> +        return "Fatal";
> +    case CXL_EVENT_TYPE_DYNAMIC_CAP:
> +        return "Dynamic Capacity";
> +    default:
> +        break;
> +    }
> +    return "<unknown>";
> +}
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + *
> + * Space given for 1 record

I'd rather this was defined to have a trailing variable length
array of handles and allocations and then wherever it was used
we deal with the length.

I'm also nervous about limiting the qemu emulation to handling only
one record.. Spec wise I don't think you are allowed to say
no to larger clears.  I understand the fact we can't test this today
with the kernel code but maybe we can hack together enough to
verify the emulation of larger gets and clears...


> + */
> +struct cxl_mbox_clear_event_payload {
> +    uint8_t event_log;      /* enum cxl_event_log_type */
> +    uint8_t clear_flags;
> +    uint8_t nr_recs;        /* 1 for this struct */
> +    uint8_t reserved[3];
> +    uint16_t handle;
> +};
> +
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */

In interests of keeping everything that needs checking against
a chunk of the spec together, perhaps it's worth adding appropriate
defines for the UUIDs?

> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e

As above, I'd rather see these inline.

> +struct cxl_event_gen_media {
> +    struct cxl_event_record_hdr hdr;
> +    uint64_t phys_addr;
Defines for the mask + that we have a few things hiding in
the bottom bits?

> +    uint8_t descriptor;
Defines for the various fields in here?

> +    uint8_t type;
Same for the others that follow.

> +    uint8_t transaction_type;

> +    uint8_t validity_flags[2];

uint16_t probably makes sense as we can do that for this one (unlike the helpful le24 flags fields
in other structures).

> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t device[3];
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> +} QEMU_PACKED;
Would be nice to add a build time check that these structures have the correct
overall size. Ben did a bunch of these in the other CXL emulation and they are
a handy way to reassure reviewers that it adds up right!

> +
> +/*
> + * DRAM Event Record - DER
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
> + */
> +#define CXL_EVENT_DER_CORRECTION_MASK_SIZE   0x20
> +#define CXL_EVENT_DER_RES_SIZE               0x17
Same as above.

> +struct cxl_event_dram {
> +    struct cxl_event_record_hdr hdr;
> +    uint64_t phys_addr;
As before I'd like defines for the sub fields and masks.

> +    uint8_t descriptor;
> +    uint8_t type;
> +    uint8_t transaction_type;
> +    uint8_t validity_flags[2];
uint16_t and same in similar cases.

> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t nibble_mask[3];
> +    uint8_t bank_group;
> +    uint8_t bank;
> +    uint8_t row[3];
> +    uint8_t column[2];
> +    uint8_t correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> +    uint8_t reserved[CXL_EVENT_DER_RES_SIZE];
> +} QEMU_PACKED;
> +
> +/*
> + * Get Health Info Record
> + * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +struct cxl_get_health_info {
Same stuff as for earlier structures.

> +    uint8_t health_status;
> +    uint8_t media_status;
> +    uint8_t add_status;
> +    uint8_t life_used;
> +    uint8_t device_temp[2];
> +    uint8_t dirty_shutdown_cnt[4];
> +    uint8_t cor_vol_err_cnt[4];
> +    uint8_t cor_per_err_cnt[4];
> +} QEMU_PACKED;
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CXL_EVENT_MEM_MOD_RES_SIZE  0x3d
> +struct cxl_event_mem_module {
> +    struct cxl_event_record_hdr hdr;
> +    uint8_t event_type;
> +    struct cxl_get_health_info info;
> +    uint8_t reserved[CXL_EVENT_MEM_MOD_RES_SIZE];
> +} QEMU_PACKED;
> +
> +#endif /* CXL_EVENTS_H */

