Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F96C7EE2F
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 17:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCBRms (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCBRms (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 12:42:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE453282
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 09:42:44 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSJKD0csYz67DYv;
        Fri,  3 Mar 2023 01:40:16 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 2 Mar
 2023 17:42:41 +0000
Date:   Thu, 2 Mar 2023 17:42:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <20230302174240.00003ed7@huawei.com>
In-Reply-To: <20230227173416.7740-6-Jonathan.Cameron@huawei.com>
References: <20230227173416.7740-1-Jonathan.Cameron@huawei.com>
        <20230227173416.7740-6-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 27 Feb 2023 17:34:14 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> To facilitate testing provide a QMP command to inject a general media
> event.  The event can be added to the log specified.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Link: https://lore.kernel.org/r/20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Took another look at this after some review feedback on remaining endian issues.
There are some of those + the timestamp in the header is not in device time.
I'll fix up for v4.

> +static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                                    const QemuUUID *uuid, uint8_t flags,
> +                                    uint8_t length)
> +{
> +    hdr->flags[0] = flags;
Should be st24_le_p() really and a type big enough to hold a 24 bit

> +    hdr->length = length;
> +    memcpy(&hdr->id, uuid, sizeof(hdr->id));
> +    hdr->timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
This isn't the right timestamp and it should be little endian. 

> +}
> +
> +/* Component ID is device specific.  Define this as a string. */
> +void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
> +                                    uint8_t flags, uint64_t physaddr,
> +                                    uint8_t descriptor, uint8_t type,
> +                                    uint8_t transaction_type,
> +                                    bool has_channel, uint8_t channel,
> +                                    bool has_rank, uint8_t rank,
> +                                    bool has_device, uint32_t device,
> +                                    const char *component_id,
> +                                    Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventGenMedia gem;
> +    CXLEventRecordHdr *hdr = &gem.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint16_t valid_flags = 0;
> +    uint8_t enc_log;
> +    int rc;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +    ct3d = CXL_TYPE3(obj);
> +    cxlds = &ct3d->cxl_dstate;
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    memset(&gem, 0, sizeof(gem));
> +    cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem));
> +
> +    gem.phys_addr = physaddr;
This was the one that was pointed out off list.
Thanks!
> +    gem.descriptor = descriptor;
> +    gem.type = type;
> +    gem.transaction_type = transaction_type;

