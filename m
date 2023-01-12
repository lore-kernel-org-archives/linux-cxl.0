Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859BAC54EBC
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 15:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjALPo4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbjALPoT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 10:44:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E405C1CF
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 07:34:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt7mq1wMvz6J6kK;
        Thu, 12 Jan 2023 23:31:07 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 15:34:52 +0000
Date:   Thu, 12 Jan 2023 15:34:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 8/8] hw/cxl/events: Add in inject general media event
Message-ID: <20230112153451.00005fb4@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com>
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

On Wed, 21 Dec 2022 20:24:38 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> To facilitate testing provide a QMP command to inject a general media
> event.  The event can be added to the log specified.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Hi Ira,

One thing inline that kind of came out of Philippe's review of
the earlier cleanup patches.

> 
> ---
> Changes from RFC:
> 	Add all fields for this event
> 	irq happens automatically when log transitions from 0 to 1
> ---
>  hw/mem/cxl_type3.c          | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  8 ++++
>  include/hw/cxl/cxl_events.h | 20 ++++++++++
>  qapi/cxl.json               | 25 ++++++++++++
>  4 files changed, 146 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a43949cab120..bedd09e500ba 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -916,6 +916,99 @@ static CXLPoisonList *get_poison_list(CXLType3Dev *ct3d)
>      return &ct3d->poison_list;
>  }
>  
> +static void cxl_assign_event_header(struct cxl_event_record_hdr *hdr,
> +                                    QemuUUID *uuid, uint8_t flags,
make that const QemuUUID *uuid
and ...
> +                                    uint8_t length)
> +{
> +    hdr->flags[0] = flags;
> +    hdr->length = length;
> +    memcpy(&hdr->id, uuid, sizeof(hdr->id));
> +    hdr->timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
static const

> +QemuUUID gen_media_uuid = {
> +    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> +                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +};
