Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082BEC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 01:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCBBf5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBBf4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 20:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03542D16A
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 17:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677720910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RYQXI4gn9jDV24DMvr8JslmvQdkIeiQx0d/hMAPS0p4=;
        b=O+UmWKItwQQ7mDXzz0JJN0NgWdpoz+YD+UAPPMkFR3zMG3Cp2OhdykonvOnPkqU1TqEvPd
        Tub2LKGJhzorsu3Eqj2cDcsQPlDrkP0HS9KZktFRnsSMhB7kxTUAuAUnthSxPErUjN70t9
        1AHSDrgKyZAPDXSqEvyNEB2Q9NWhFP4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-M3LT57zGOUajCD9mhclP-A-1; Wed, 01 Mar 2023 20:35:09 -0500
X-MC-Unique: M3LT57zGOUajCD9mhclP-A-1
Received: by mail-wm1-f69.google.com with SMTP id f26-20020a7bcd1a000000b003e71cde0e70so426571wmj.0
        for <linux-cxl@vger.kernel.org>; Wed, 01 Mar 2023 17:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677720908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYQXI4gn9jDV24DMvr8JslmvQdkIeiQx0d/hMAPS0p4=;
        b=QHM1TG6N5AVCidgJWpuI+FfGRnc1Ud00Qs3Hz4kNp9d2bhx2MzmshyV1roJUja7WQx
         V4WDCFxuktYl8+0VFCdgAfexG3d9HKz4Tuxrg56aevfBTfSSOdqGC/Ov48nvNxa0zwLu
         tCaERdAJRyMgYcObVFuqmGMt78C/E8Rr+fNibqXnr9cErDzsA/Au1RIHdtYQYeYDqjFG
         F9R60YPgWsQH6br66pUMrxOHcMDzRIVVDI2pTdPQCC0aFlRE81wjz/2l5H4DC7Jlbtwn
         iMD2ZG+9PerSKBlX9r4zYzjTy2y8Jg8d25YGoSebukleAMwQNbgt/KxC8dXrhzKQ0w8m
         8rMA==
X-Gm-Message-State: AO0yUKVqJyJStupW6Vygd7ZF2WNaFhvsLffNV3DINuDBVxh0/sP5vSYD
        LIoYtnKVe39uI+IX7DbpI53r5+4K8oubkZl7ha3RkwDhkvIdz12IEl6chN2MnbESRnv6L/OsaO9
        LxLxkJ5tvjeaXstvjdCOU
X-Received: by 2002:a05:600c:2e95:b0:3ea:e7e7:95d9 with SMTP id p21-20020a05600c2e9500b003eae7e795d9mr7088459wmn.32.1677720905167;
        Wed, 01 Mar 2023 17:35:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/a2wrJr/jaelFoL9tD0k149SogAHY8rGq8LyKfCcL9A2sdHmca24qtMWwb924Pwk+OzF36Lg==
X-Received: by 2002:a05:600c:2e95:b0:3ea:e7e7:95d9 with SMTP id p21-20020a05600c2e9500b003eae7e795d9mr7088441wmn.32.1677720904803;
        Wed, 01 Mar 2023 17:35:04 -0800 (PST)
Received: from redhat.com ([2.52.141.194])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b002c54911f50bsm14013259wru.84.2023.03.01.17.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 17:35:04 -0800 (PST)
Date:   Wed, 1 Mar 2023 20:35:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/6] hw/cxl: QMP based poison injection support
Message-ID: <20230301203423-mutt-send-email-mst@kernel.org>
References: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
 <20230227170311.20054-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230227170311.20054-5-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 27, 2023 at 05:03:09PM +0000, Jonathan Cameron wrote:
> Inject poison using qmp command cxl-inject-poison to add an entry to the
> poison list.
> 
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List.
> 
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> 
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> 
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
> 
> Adjusted to select a device on your machine.
> 
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

You need to CC QAPI maintainers.

> ---
> v2:
> Improve QMP documentation.
> Fix up some endian issues
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 90 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 +++
>  include/hw/cxl/cxl_device.h | 20 +++++++++
>  qapi/cxl.json               | 18 ++++++++
>  5 files changed, 190 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 702e16ca20..792d3ee5aa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -62,6 +62,8 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -295,6 +297,10 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
> +    /* 256 poison records */
> +    st24_le_p(id->poison_list_max_mer, 256);
> +    /* No limit - so limited by main poison record limit */
> +    stw_le_p(&id->inject_poison_limit, 0);
>  
>      *len = sizeof(*id);
>      return CXL_MBOX_SUCCESS;
> @@ -384,6 +390,88 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * This is very inefficient, but good enough for now!
> + * Also the payload will always fit, so no need to handle the MORE flag and
> + * make this stateful. We may want to allow longer poison lists to aid
> + * testing that kernel functionality.
> + */
> +static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
> +                                            CXLDeviceState *cxl_dstate,
> +                                            uint16_t *len)
> +{
> +    struct get_poison_list_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_out_pl {
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint64_t overflow_timestamp;
> +        uint16_t count;
> +        uint8_t rsvd2[0x14];
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_pl *in = (void *)cmd->payload;
> +    struct get_poison_list_out_pl *out = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint16_t record_count = 0, i = 0;
> +    uint64_t query_start, query_length;
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignemnt required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +        record_count++;
> +    }
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        uint64_t start, stop;
> +
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +
> +        /* Deal with overlap */
> +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> +                   query_start + query_length);
> +        stq_le_p(&out->records[i].addr, start | (ent->type & 0x3));
> +        stl_le_p(&out->records[i].length, (stop - start) / 64);
> +        i++;
> +    }
> +    if (ct3d->poison_list_overflowed) {
> +        out->flags = (1 << 1);
> +        stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
> +    }
> +    stw_le_p(&out->count, record_count);
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -411,6 +499,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> +    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> +        cmd_media_get_poison_list, 16, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 572ad47fa2..21e3a84785 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
> +{
> +        ct3d->poison_list_overflowed = true;
> +        ct3d->poison_list_overflow_ts =
> +            cxl_device_get_timestamp(&ct3d->cxl_dstate);
> +}
> +
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLType3Dev *ct3d;
> +    CXLPoison *p;
> +
> +    if (length % 64) {
> +        error_setg(errp, "Poison injection must be in multiples of 64 bytes");
> +        return;
> +    }
> +    if (start % 64) {
> +        error_setg(errp, "Poison start address must be 64 byte aligned");
> +        return;
> +    }
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    ct3d = CXL_TYPE3(obj);
> +
> +    QLIST_FOREACH(p, &ct3d->poison_list, node) {
> +        if (((start >= p->start) && (start < p->start + p->length)) ||
> +            ((start + length > p->start) &&
> +             (start + length <= p->start + p->length))) {
> +            error_setg(errp, "Overlap with existing poisoned region not supported");
> +            return;
> +        }
> +    }
> +
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        cxl_set_poison_list_overflowed(ct3d);
> +        return;
> +    }
> +
> +    p = g_new0(CXLPoison, 1);
> +    p->length = length;
> +    p->start = start;
> +    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
> +
> +    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> +    ct3d->poison_list_cnt++;
> +}
> +
>  /* For uncorrectable errors include support for multiple header recording */
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index d574c58f9a..fd1166a610 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -3,6 +3,12 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
>                                           Error **errp)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 02befda0f6..32c234ea91 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -242,6 +242,18 @@ typedef struct CXLError {
>  
>  typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
>  
> +typedef struct CXLPoison {
> +    uint64_t start, length;
> +    uint8_t type;
> +#define CXL_POISON_TYPE_EXTERNAL 0x1
> +#define CXL_POISON_TYPE_INTERNAL 0x2
> +#define CXL_POISON_TYPE_INJECTED 0x3
> +    QLIST_ENTRY(CXLPoison) node;
> +} CXLPoison;
> +
> +typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> +#define CXL_POISON_LIST_LIMIT 256
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -264,6 +276,12 @@ struct CXLType3Dev {
>  
>      /* Error injection */
>      CXLErrorList error_list;
> +
> +    /* Poison Injection - cache */
> +    CXLPoisonList poison_list;
> +    unsigned int poison_list_cnt;
> +    bool poison_list_overflowed;
> +    uint64_t poison_list_overflow_ts;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> @@ -289,4 +307,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> +
>  #endif
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4be7d46041..9ebd680dfe 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,24 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-poison:
> +#
> +# Poison records indicate that a CXL memory device knows that a particular
> +# memory region may be corrupted. This may be because of locally detected
> +# errors (e.g. ECC failure) or poisoned writes received from other components
> +# in the system. This injection mechanism enables testing of the OS handling
> +# of poison records which may be queried via the CXL mailbox.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @start: Start address - must be 64 byte aligned.
> +# @length: Length of poison to inject - must be a multiple of 64 bytes.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-poison',
> +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> +
>  ##
>  # @CxlUncorErrorType:
>  #
> -- 
> 2.37.2

