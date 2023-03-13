Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71302C61DA4
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Mar 2023 16:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCMQQe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCMQQd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Mar 2023 12:16:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC16584B3
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 09:16:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pb1wD2Nbzz6J6jt;
        Tue, 14 Mar 2023 00:15:24 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 16:16:11 +0000
Date:   Mon, 13 Mar 2023 16:16:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Da?= =?ISO-8859-1?Q?ud=E9?= 
        <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v4 6/6] hw/cxl: Add clear poison mailbox command
 support.
Message-ID: <20230313161610.00000feb@huawei.com>
In-Reply-To: <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
        <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 3 Mar 2023 15:09:08 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Another case in here of directly accessing MemoryRegion->size.
I'll fix that up for v5.

...

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 21e3a84785..0d9de0ee03 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }
> +
> +    if (vmr) {
> +        if (dpa_offset < int128_get64(vmr->size)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;

Michael pointed out we shouldn't do this in the Volatile series.
Fixed the same way here with memory_region_size() here and instead
of the int128_get64 above.


> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
> +    return true;
> +}
> +
