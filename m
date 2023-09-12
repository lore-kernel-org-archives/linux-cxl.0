Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE3CA0ECA
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjILMEe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILMEd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 08:04:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A210D0
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 05:04:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlMZs1Qg6z6J7tc;
        Tue, 12 Sep 2023 19:59:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 13:04:26 +0100
Date:   Tue, 12 Sep 2023 13:04:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <ayush.m55@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <20230912130425.0000569b@Huawei.com>
In-Reply-To: <20230908073152.4386-5-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-5-dave@stgolabs.net>
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

On Fri,  8 Sep 2023 00:31:52 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Iterate over the list keeping the output payload size into account,
> returning the results from a previous scan media operation. The
> scan media operation does not fail prematurely due to device being
> out of storage, so this implementation does not deal with the
> retry/restart functionality.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
A few comments inline but nothing to stop me carrying this on my
staging tree. (gitlab.com/jic23/qemu cxl-*latestdate*

So I'll apply it there.  Updates welcome or I'll act on comments when
this gets to the top of our queue for upstreaming.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 84 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  2 files changed, 85 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 399ac03962db..109b9ecfabf1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -82,6 +82,7 @@ enum {
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>          #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> @@ -1267,6 +1268,8 @@ static void __do_scan_media(CXLType3Dev *ct3d)
>          ct3d->poison_list_cnt == results_cnt) {
>          cxl_clear_poison_list_overflowed(ct3d);
>      }
> +    /* scan media has run since last conventional reset */
> +    ct3d->scan_media_hasrun = true;
>  }
>  
>  /*
> @@ -1371,6 +1374,85 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +/*
> + * CXL r3.0 section 8.2.9.8.4.6: Get Scan Media Results
> + */
> +static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct get_scan_media_results_out_pl {
> +        uint64_t dpa_restart;
> +        uint64_t length;
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint16_t count;
> +        uint8_t rsvd2[0xc];
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +
> +    struct get_scan_media_results_out_pl *out = (void *)payload_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLPoisonList *scan_media_results = &ct3d->scan_media_results;
> +    CXLPoison *ent, *next;
> +    uint16_t total_count = 0, record_count = 0, i = 0;
> +    uint16_t out_pl_len;
> +
> +    if (!ct3d->scan_media_hasrun) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /*
> +     * Calculate limits, all entries are within the same
> +     * address range of the last scan media call.
> +     */
> +    QLIST_FOREACH(ent, scan_media_results, node) {
> +        size_t rec_size = record_count * sizeof(out->records[0]);
> +
> +        if (sizeof(*out) + rec_size < CXL_MAILBOX_MAX_PAYLOAD_SIZE) {
> +            record_count++;
> +        }
> +        total_count++;
> +    }
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);

Isn't aim of the if in the loop above to ensure this never happens?
I'd hope that code is obvious enough we don't need the additional assert
here.

> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH_SAFE(ent, scan_media_results, node, next) {
> +        uint64_t start, stop;
> +
> +        if (i == record_count) {
> +            break;
> +        }
> +
> +        start = ROUND_DOWN(ent->start, 64ull);
> +        stop = ROUND_DOWN(ent->start, 64ull) + ent->length;

I think we control the way these all turn up so they are multiples of 64.
So this rounding shouldn't be needed (or am I missing something?)

> +        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7)); 

define for that 0x7

> +        stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
> +        i++;
> +
> +        /* consume the returning entry */
> +        QLIST_REMOVE(ent, node);
> +        g_free(ent);
> +    }
> +
> +    stw_le_p(&out->count, record_count);
> +    if (total_count > record_count) {
> +        out->flags = (1 << 0); /* More Media Error Records */
Define perhaps.

> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /*
>   * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
>   */
> @@ -1803,6 +1885,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_scan_media_capabilities, 16, 0 },
>      [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
>          cmd_media_scan_media, 17, BACKGROUND_OPERATION },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
I'll wrap this line whilst applying.

Shortly I'm going to send out a series hammering down
all the line lengths in the CXL code. 

> +        cmd_media_get_scan_media_results, 0, 0 },
>  };
>  
>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index eb5c5284fa9f..e9d130e5c988 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -484,6 +484,7 @@ struct CXLType3Dev {
>      /* Poison Injection - backup */
>      CXLPoisonList poison_list_bkp;
>      CXLPoisonList scan_media_results;
> +    bool scan_media_hasrun;
>  
>      struct dynamic_capacity {
>          HostMemoryBackend *host_dc;

