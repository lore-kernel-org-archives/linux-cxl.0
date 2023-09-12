Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18ECA0EC3
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 11:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjILL51 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjILL5T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 07:57:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5EE10EC
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 04:57:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlMTw1tYxz6HJmq;
        Tue, 12 Sep 2023 19:55:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 12:57:11 +0100
Date:   Tue, 12 Sep 2023 12:57:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <ayush.m55@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] hw/cxl: Add scan media cmd support
Message-ID: <20230912125710.00001e7f@Huawei.com>
In-Reply-To: <20230908073152.4386-4-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-4-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri,  8 Sep 2023 00:31:51 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement the poison list backup functionality by extending the
> qmp poison injection interface to add chunks beyond the poison
> limit and use it to recreate the poison list upon overflow.
> 
> To this end two new lists are added, bkp and results, which are
> drained by moving elements from the backup to the results, which
> are consumed by the respective get scan media results cmd.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Hi Davidlohr,

A few comments inline, but all are superficial so I'll start carrying this
on my tree.  Note I haven't yet tidied anything I commented on up.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 161 ++++++++++++++++++++++++++++++++++--
>  hw/mem/cxl_type3.c          |  22 +++--
>  include/hw/cxl/cxl_device.h |   9 ++
>  3 files changed, 178 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3073222060ab..399ac03962db 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,7 @@ enum {
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> @@ -1037,6 +1038,10 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
>          out->flags = (1 << 1);
>          stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
>      }
> +    if (scan_media_running(cci)) {
> +        out->flags |= (1 << 2);

Define needed for the flag.

> +    }
> +
>      stw_le_p(&out->count, record_count);
>      *len_out = out_pl_len;
>      return CXL_MBOX_SUCCESS;
> @@ -1065,6 +1070,16 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
>              return CXL_MBOX_SUCCESS;
>          }
>      }
> +    /*
> +     * Freeze the list if there is an on-going scan media operation.
> +     */
> +    if (scan_media_running(cci)) {
> +        /*
> +         * XXX: Spec is ambiguous - is this case considered
> +         * a successful return despite not adding to the list?
> +         */

As below. Can't see this one getting clarified.

> +        goto success;
> +    }
>  
>      if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
>          return CXL_MBOX_INJECT_POISON_LIMIT;
> @@ -1080,6 +1095,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
>       */
>      QLIST_INSERT_HEAD(poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +success:
>      *len_out = 0;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1123,6 +1139,17 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>          }
>      }
>  
> +    /*
> +     * Freeze the list if there is an on-going scan media operation.

Single line comment.

> +     */
> +    if (scan_media_running(cci)) {
> +        /*
> +         * XXX: Spec is ambiguous - is this case considered
> +         * a successful return despite not removing from the list?
> +         */

I think we are in impdef territory here, though happy to join the conversation
if you want to raise it in CXL consortium.  Would need an errata though so
I suspect it will stay impdef with likely reasoning being.

OS should only use scan_media if it know poison list is overflowed.
It should know it issued scan media.
It should not do anything so silly has hit the device with a poison clear
in parallel to that.  Hence doesn't matter that this corner is impdef.

I'd like to see a comment to say it is though!

> +        goto success;
> +    }
> +
>      QLIST_FOREACH(ent, poison_list, node) {
>          /*
>           * Test for contained in entry. Simpler than general case
> @@ -1133,7 +1160,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>          }
>      }
>      if (!ent) {
> -        return CXL_MBOX_SUCCESS;
> +        goto success;

Is this a bug fix?  I think the explicit setting of len_out came in somewhere but don't
think it is necessary for commands that have no output payload.  If it is, then we should
set it at the top of the function as they never have a payload.

>      }
>  
>      QLIST_REMOVE(ent, node);
> @@ -1170,6 +1197,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      }
>      /* Any fragments have been added, free original entry */
>      g_free(ent);
> +success:
>      *len_out = 0;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1225,6 +1253,124 @@ cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void __do_scan_media(CXLType3Dev *ct3d)
> +{
> +    CXLPoison *ent;
> +    unsigned int results_cnt = 0;
> +
> +    QLIST_FOREACH(ent, &ct3d->scan_media_results, node) {
> +        results_cnt++;
> +    }
> +
> +    /* only scan media may clear the overflow */
> +    if (ct3d->poison_list_overflowed &&
> +        ct3d->poison_list_cnt == results_cnt) {
> +        cxl_clear_poison_list_overflowed(ct3d);
> +    }
> +}
> +
> +/*
> + * CXL r3.0 section 8.2.9.8.4.5: Scan Media
> + */
> +static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
> +                                       uint8_t *payload_in,
> +                                       size_t len_in,
> +                                       uint8_t *payload_out,
> +                                       size_t *len_out,
> +                                       CXLCCI *cci)
> +{
> +    struct scan_media_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +        uint8_t flags;
> +    } QEMU_PACKED;
> +
> +    struct scan_media_pl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    uint64_t query_start;
> +    uint64_t query_length;
> +    CXLPoison *ent, *next;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
> +
> +    if (query_start + query_length > cxl_dstate->static_mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +    if (ct3d->dc.num_regions && query_start + query_length >=
> +            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {

If in DCD range we will never get to this test as we already failed
on matching against static_mem_size above.

Can we just drop the earlier test?

> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    if (in->flags == 0) { /* TODO */
Good to separate match on first bit vs seeing reserved bits.
Makes no difference today, but will make things potentially easier to extend
in long run.

> +        qemu_log_mask(LOG_UNIMP,
> +                      "Scan Media Event Log is unsupported\n");
> +    }
> +
> +    /* any previous results are discarded upon a new Scan Media */
> +    QLIST_FOREACH_SAFE(ent, &ct3d->scan_media_results, node, next) {
> +        QLIST_REMOVE(ent, node);
> +        g_free(ent);
> +    }
> +
> +    /* kill the poison list - it will be recreated */

Perhaps call out that the spec says a device 'may update it's Poison List...'

> +    if (ct3d->poison_list_overflowed) {
> +        QLIST_FOREACH_SAFE(ent, &ct3d->poison_list, node, next) {
> +            QLIST_REMOVE(ent, node);
> +            g_free(ent);
> +            ct3d->poison_list_cnt--;
> +        }
> +    }
> +
> +    /*
> +     * Scan the backup list and move corresponding entries
> +     * into the results list, updating the poison list
> +     * when possible.
> +     */
> +    QLIST_FOREACH_SAFE(ent, &ct3d->poison_list_bkp, node, next) {
> +        CXLPoison *res;
> +
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +
> +        /*
> +         * If a Get Poison List cmd comes in while this
> +         * scan is being done, it will see the new complete
> +         * list, while setting the respective flag.

I'd be more specific
"while setting the Scan Media in Progress flag in the Get Poison
List Output Payload."


> +         */
> +        if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
> +            CXLPoison *p = g_new0(CXLPoison, 1);
> +
> +            p->start = ent->start;
> +            p->length = ent->length;
> +            p->type = ent->type;
> +            QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> +            ct3d->poison_list_cnt++;

Maybe worth a utility function for this adding one to the poison
list.  Or duplicate the memory and insert that to the poison list?

> +        }
> +
> +        res = g_new0(CXLPoison, 1);
> +        res->start = ent->start;
> +        res->length = ent->length;
> +        res->type = ent->type;
> +        QLIST_INSERT_HEAD(&ct3d->scan_media_results, res, node);
> +
> +        QLIST_REMOVE(ent, node);

Can't we just remove from the poison_list_bkp first then add it
to the scan_media_results list?  I.e. Don't make a new one.

> +        g_free(ent);
> +    }
> +
> +    cci->bg.runtime = MAX(1, query_length * (0.0005L/64));
Spaces around /

> +    *len_out = 0;
> +
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
>  /*
>   * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
>   */
> @@ -1655,6 +1801,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>      [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
>          cmd_media_get_scan_media_capabilities, 16, 0 },
> +    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
> +        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
>  };
>  
>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> @@ -1783,16 +1931,15 @@ static void bg_timercb(void *opaque)
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
>          if (ret == CXL_MBOX_SUCCESS) {
> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
>              switch (cci->bg.opcode) {
>              case 0x4400: /* sanitize */
> -            {
> -                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> -
>                  __do_sanitization(ct3d);
>                  cxl_dev_enable_media(&ct3d->cxl_dstate);
> -            }
> -            break;
> -            case 0x4304: /* TODO: scan media */
> +                break;
> +            case 0x4304: /* scan media */
> +                __do_scan_media(ct3d);
>                  break;
>              default:
>                  __builtin_unreachable();
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b90a7397d62f..aa9fdde1436e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1435,6 +1435,12 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>              cxl_device_get_timestamp(&ct3d->cxl_dstate);
>  }
>  
> +void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
> +{
> +    ct3d->poison_list_overflowed = false;
> +    ct3d->poison_list_overflow_ts = 0;
> +}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> @@ -1470,18 +1476,20 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>          }
>      }
>  
> -    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> -        cxl_set_poison_list_overflowed(ct3d);
> -        return;
> -    }
> -
>      p = g_new0(CXLPoison, 1);
>      p->length = length;
>      p->start = start;
>      p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
>  
> -    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> -    ct3d->poison_list_cnt++;
> +    if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
> +        QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> +        ct3d->poison_list_cnt++;
> +    } else {
> +        if (!ct3d->poison_list_overflowed) {
> +            cxl_set_poison_list_overflowed(ct3d);
> +        }
> +        QLIST_INSERT_HEAD(&ct3d->poison_list_bkp, p, node);
> +    }
>  }
>  
>  /* For uncorrectable errors include support for multiple header recording */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index e824c5ade8a1..eb5c5284fa9f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -385,6 +385,11 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>  #define cxl_dev_enable_media(cxlds)                     \
>          do { __toggle_media((cxlds), 0x1); } while (0)
>  
> +static inline bool scan_media_running(CXLCCI *cci)
> +{
> +    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;

I'd prefer the opcode being built which would mean moving this
implementation down to where we can see the defines.

(MEDIA_AND_POISON << 8) | SCAN_MEDIA 

I considered suggesting a macro, but if we do it should be separate
patch and include the other cases in this file.

Hence one for another day.

> +}
> +
>  static inline bool sanitize_running(CXLCCI *cci)
>  {
>      return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
> @@ -476,6 +481,9 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +    /* Poison Injection - backup */
> +    CXLPoisonList poison_list_bkp;
> +    CXLPoisonList scan_media_results;
>  
>      struct dynamic_capacity {
>          HostMemoryBackend *host_dc;
> @@ -538,6 +546,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>  void cxl_event_irq_assert(CXLType3Dev *ct3d);
>  
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> +void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d);
>  
>  CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
>  

