Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D447ECA0ECF
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjILL0g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjILLZV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 07:25:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAB10D5
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 04:25:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlLjd1V4zz67QKJ;
        Tue, 12 Sep 2023 19:20:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 12:25:14 +0100
Date:   Tue, 12 Sep 2023 12:25:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <ayush.m55@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] hw/cxl: Add get scan media capabilities cmd support
Message-ID: <20230912122514.000040e1@Huawei.com>
In-Reply-To: <20230908073152.4386-3-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-3-dave@stgolabs.net>
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

On Fri,  8 Sep 2023 00:31:50 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Use simple heuristics to determine the cost of scanning any given
> chunk, assuming cost is equal across the whole device, without
> differentiating between volatile or persistent partitions. This
> is aligned to the fact that these constraints are not enforced
> in respective poison query commands.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 53 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4e8651ebe2e9..3073222060ab 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,7 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> @@ -1174,6 +1175,56 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.0 section 8.2.9.8.4.4: Get Scan Media Capabilities
> + */
> +static CXLRetCode
> +cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct get_scan_media_capabilities_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +
> +    struct get_scan_media_capabilities_out_pl {
> +        uint32_t estimated_runtime_ms;
> +    } QEMU_PACKED;
> +
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    struct get_scan_media_capabilities_pl *in = (void *)payload_in;
> +    struct get_scan_media_capabilities_out_pl *out = (void *)payload_out;
> +    uint64_t query_start;
> +    uint64_t query_length;
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
> +
> +    /*
> +     * Just use 400 nanosecond access/read latency + 100 ns for
> +     * the cost of updating the poison list. For small enough
> +     * chunks return at least 1 ms.
> +     */
> +    stl_le_p(&out->estimated_runtime_ms,
> +             MAX(1, query_length * (0.0005L/64)));
Forgot to say I added spaces around the /

> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /*
>   * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
>   */
> @@ -1602,6 +1653,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
>          cmd_media_clear_poison, 72, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
I rewrapped this to keep under 80 chars.

Jonathan

> +        cmd_media_get_scan_media_capabilities, 16, 0 },
>  };
>  
>  static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {

