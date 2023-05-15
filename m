Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D9C77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 11:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbjEOLCF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 07:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOLCD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 07:02:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201A93
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 04:02:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKbyQ2YRkz67h72;
        Mon, 15 May 2023 19:01:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 12:01:58 +0100
Date:   Mon, 15 May 2023 12:01:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] hw/cxl: Add get scan media capabilities mailbox
 command support
Message-ID: <20230515120157.00003d89@Huawei.com>
In-Reply-To: <20230426021418.10186-2-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
        <20230426021418.10186-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Apr 2023 19:14:16 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Use simple heuristics to determine the cost of scanning any given chunk,
> assuming cost is even across the whole device.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi.

A few trivial additions / comments / moans.
Obviously it's an RFC but I can't resist pointing things out you'd
fix for the v1.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 45 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 0849cfbc2a4c..f346aa8ce3b2 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -79,6 +79,7 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -882,7 +883,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>              return CXL_MBOX_INTERNAL_ERROR;
>          }
>      }
> -  
> +
Hmm. Where did that white space sneak in? 
I'm guessing in something else I'm carrying on the branch you based on (I'm not
seeing this locally now - so might already be fixed).

Still shouldn't be in here!


>      QLIST_FOREACH(ent, poison_list, node) {
>          /*
>           * Test for contained in entry. Simpler than general case
> @@ -934,6 +935,45 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode
> +cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
> +                                      CXLDeviceState *cxl_dstate, uint16_t *len)
> +{
> +    struct get_scan_media_capabilities_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;

I'd add some blank lines to help readability a little.  One here.

> +    struct get_scan_media_capabilities_out_pl {
> +        uint32_t estimated_runtime_ms;
> +    } QEMU_PACKED;

One here.

> +    struct get_scan_media_capabilities_pl *in = (void *)cmd->payload;
> +    struct get_scan_media_capabilities_out_pl *out = (void *)cmd->payload;
> +    uint64_t query_start;
> +    uint64_t query_length;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    if (query_start + query_length > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /*
> +     * Just use 400 nanosecond access/read latency + 100 ns for
> +     * the cost of updating the poison list. For small enough
> +     * chunks return at least 1 ms.
> +     */
> +    stq_le_p(&out->estimated_runtime_ms,
> +             MAX(1, query_length * (0.0005L/64)));
> +
> +    *len = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -972,6 +1012,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
>          cmd_media_clear_poison, 72, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
> +        cmd_media_get_scan_media_capabilities, 16, 0 },
> +
Grumpy maintainer moment.  No blank line should be added here ;)

>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {

