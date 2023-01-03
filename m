Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934DC3DA7D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 16:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjACQa3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjACQaO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 11:30:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01A62DB
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 08:30:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NmdPj4qgcz6HJgg;
        Wed,  4 Jan 2023 00:25:29 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:30:09 +0000
Date:   Tue, 3 Jan 2023 16:30:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 3/8] hw/cxl/mailbox: Use new UUID network order
 define for cel_uuid
Message-ID: <20230103163008.00002547@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-3-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-3-2ce2ecc06219@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:33 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> The cel_uuid was programatically generated previously because there was
> no static initializer for network order UUIDs.
> 
> Use the new network order initializer for cel_uuid.  Adjust
> cxl_initialize_mailbox() because it can't fail now.
> 
> Update specification reference.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I clearly need a 'pending' branch or tag with just the sane / nearly
ready to send upstream stuff on it.  The switch-cci stuff definitely
isn't in that category yet and made this more complex than it needs
to be.

Anyhow, I'll rebase the series to a sensible point in my tree and
push out a new branch for you to sanity check.

This patch and the two before it make sense even without the rest of
the series so I might pull them forwards into a cleanup series I intend
to send out later this week - we'll see how things go.

Assuming any changes to the rest of this series are minor, my thoughts
are we do the following this cycle (and see how far we get)

1) Cleanup series.
2) RAS event series - AER etc.
3) This series
4) Poison series
5) Volatile memory series from Gregory

Might slot the CPMU and ARM64 support in there somewhere, but after this series.

> 
> ---
> Changes from RFC:
> 	New patch.
> ---
>  hw/cxl/cxl-device-utils.c   |  4 ++--
>  hw/cxl/cxl-mailbox-utils.c  | 14 +++++++-------
>  include/hw/cxl/cxl_device.h |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 21845dbfd050..34697064714e 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -267,7 +267,7 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
>      memdev_reg_init_common(cxl_dstate);
>  
> -    assert(cxl_initialize_mailbox(cxl_dstate, false) == 0);
> +    cxl_initialize_mailbox(cxl_dstate, false);
>  }
>  
>  void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
> @@ -289,5 +289,5 @@ void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
>      memdev_reg_init_common(cxl_dstate);
>  
> -    assert(cxl_initialize_mailbox(cxl_dstate, true) == 0);
> +    cxl_initialize_mailbox(cxl_dstate, true);
>  }
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c1183614b9a4..157c01255ee3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -321,7 +321,11 @@ static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -static QemuUUID cel_uuid;
> +/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
> +static QemuUUID cel_uuid = {
> +        .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> +                     0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> +};
>  
>  /* 8.2.9.4.1 */
>  static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
> @@ -684,16 +688,14 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>                       DOORBELL, 0);
>  }
>  
> -int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
> +void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>  {
> -    /* CXL 2.0: Table 169 Get Supported Logs Log Entry */
> -    const char *cel_uuidstr = "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";
> -
>      if (!switch_cci) {
>          cxl_dstate->cxl_cmd_set = cxl_cmd_set;
>      } else {
>          cxl_dstate->cxl_cmd_set = cxl_cmd_set_sw;
>      }
> +
Trivial but this white space change doesn't belong in a patch doing other stuff.
It became irrelevant anyway when I rebased, but I like to moan.


>      for (int set = 0; set < 256; set++) {
>          for (int cmd = 0; cmd < 256; cmd++) {
>              if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
> @@ -707,6 +709,4 @@ int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>              }
>          }
>      }
> -
> -    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 1b366b739c62..3be2e37b3e4c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -238,7 +238,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
>                                        CXL_DEVICE_CAP_HDR1_OFFSET +
>                                            CXL_DEVICE_CAP_REG_SIZE * 2)
>  
> -int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);
> +void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
>  
>  #define cxl_device_cap_init(dstate, reg, cap_id)                           \
> 

