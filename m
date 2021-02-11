Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB5C433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C67564E5F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhBKSNu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:13:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2554 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhBKSLd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Feb 2021 13:11:33 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dc4LG52WLz67hjG;
        Fri, 12 Feb 2021 02:05:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 19:10:40 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 18:10:40 +0000
Date:   Thu, 11 Feb 2021 18:09:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Da?= =?ISO-8859-1?Q?ud=E9?= 
        <f4bug@amsat.org>, Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 05/31] hw/cxl/device: Implement basic mailbox
 (8.2.8.4)
Message-ID: <20210211180939.00004e65@Huawei.com>
In-Reply-To: <20210202005948.241655-6-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 1 Feb 2021 16:59:22 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> This is the beginning of implementing mailbox support for CXL 2.0
> devices. The implementation recognizes when the doorbell is rung,
> handles the command/payload, clears the doorbell while returning error
> codes and data.
> 
> Generally the mailbox mechanism is designed to permit communication
> between the host OS and the firmware running on the device. For our
> purposes, we emulate both the firmware, implemented primarily in
> cxl-mailbox-utils.c, and the hardware.
> 
> No commands are implemented yet.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Sorry review is a little incoherent. It's a lot of patches
so I've ended up looking at your tree then trying to figure out
which patch a given comment belongs alongside.

> ---
>  hw/cxl/cxl-device-utils.c   | 125 ++++++++++++++++++++++-
>  hw/cxl/cxl-mailbox-utils.c  | 197 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/meson.build          |   1 +
>  include/hw/cxl/cxl.h        |   3 +
>  include/hw/cxl/cxl_device.h |  28 ++++-
>  5 files changed, 349 insertions(+), 5 deletions(-)
>  create mode 100644 hw/cxl/cxl-mailbox-utils.c
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index bb15ad9a0f..6602606f3d 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -40,6 +40,111 @@ static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
>      return 0;
>  }
>  


> +
> +#define define_mailbox_handler_zeroed(name, size)                         \
> +    uint16_t __zero##name = size;                                         \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> +    {                                                                     \
> +        *len = __zero##name;                                              \

Why not just use the value of size here?

__zero##name isn't used anywhere else.

> +        memset(cmd->payload, 0, *len);                                    \
> +        return CXL_MBOX_SUCCESS;                                          \
> +    }
> +#define define_mailbox_handler_const(name, data)                          \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> +    {                                                                     \
> +        *len = sizeof(data);                                              \
> +        memcpy(cmd->payload, data, *len);                                 \
> +        return CXL_MBOX_SUCCESS;                                          \
> +    }
> +#define define_mailbox_handler_nop(name)                                  \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> +    {                                                                     \
> +        return CXL_MBOX_SUCCESS;                                          \
> +    }
> +

