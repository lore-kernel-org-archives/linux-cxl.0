Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B8C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 12:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEOMF3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjEOMFO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 08:05:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1119B3
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 05:04:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKdLc0r3Wz67ynR;
        Mon, 15 May 2023 20:03:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 13:04:32 +0100
Date:   Mon, 15 May 2023 13:04:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] hw/cxl: Add scan media mailbox command support
Message-ID: <20230515130431.00001e7b@Huawei.com>
In-Reply-To: <20230426021418.10186-4-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
        <20230426021418.10186-4-dave@stgolabs.net>
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

On Tue, 25 Apr 2023 19:14:18 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Allow the caller to retrieve the results of a previous scan media
> operation, with similar semantics to the get poison list command.
> Number of returned records is to the max payload output size.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

The special poison type is an issue here as well. As in previous patch
I don't think we need it.  Poison doesn't go away on it's own, so
Scan Media (results) should see all poison that Get Poison List does +
others that didn't fit in the tracking list.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7f29b840a2c9..f978180d8e21 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,7 @@ enum {
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>          #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -1079,6 +1080,58 @@ cmd_media_scan_media(struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +static CXLRetCode cmd_media_get_scan_media_results(struct cxl_cmd *cmd,
> +                                                   CXLDeviceState *cxl_dstate,
> +                                                   uint16_t *len)
> +{
> +    struct get_scan_media_results_out_pl {
> +        uint64_t dpa_restart;
> +        uint64_t length;
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint16_t count;
> +        uint8_t rsvd2[20];
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +    struct get_scan_media_results_out_pl *out = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint16_t record_count = 0, i = 0;
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
> +            record_count++;
> +        }
> +    }
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
> +            uint64_t start, stop;
> +
> +            start = ent->start & 0xffffffffffffffc0;
> +            stop = ent->start & 0xffffffffffffffc0;
> +            stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));

Given type is 0x4 that mask doesn't block us having a value defined in spec as
'all other encodings are reserved'

> +            stl_le_p(&out->records[i].length, (stop - start) / 64);
> +            i++;
> +        }
> +    }
> +
> +    stw_le_p(&out->count, record_count);
> +
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1121,6 +1174,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_scan_media_capabilities, 16, 0 },
>      [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
>          cmd_media_scan_media, 17, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
> +        cmd_media_get_scan_media_results, 0, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {

