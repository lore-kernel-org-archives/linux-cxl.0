Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B6C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 09:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGXJDr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGXJDq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 05:03:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE74F9
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 02:03:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R8YzT5pj8z6J64p;
        Mon, 24 Jul 2023 17:00:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:03:43 +0100
Date:   Mon, 24 Jul 2023 10:03:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: DCD region base address
Message-ID: <20230724100342.00005c7b@Huawei.com>
In-Reply-To: <DM6PR18MB2844A8A869CFB8932782DD67AF3EA@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844A8A869CFB8932782DD67AF3EA@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 20 Jul 2023 01:43:34 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> Hello All,
> 
> I am adding FM-API support to add DCD extents in QEMU. The current code is not making sense to me.  According to CXL3.0 spec (Table 8-126), region_base should be the DPA and not the size, decode_length is the total region length which is used to program HDM decoders, region_len is the usable length meaning as extents are added the region_len increases up to a max of decode_length. So should be 0 before we add any extents. 
> 
> This is what it should look like in my opinion. Am I correct ?
> 
> --- hw/mem/cxl_type3_old.c    2023-07-19 18:18:54.211748475 -0700
> +++ hw/mem/cxl_type3.c  2023-07-19 18:27:13.468602825 -0700
> @@ -747,10 +747,10 @@
>  static int cxl_create_toy_regions(CXLType3Dev *ct3d)
>  {
>       int i;
> -     uint64_t region_base = ct3d->hostvmem?ct3d->hostvmem->size
> -           :ct3d->hostpmem->size;
> -     uint64_t region_len = 1024*1024*1024;
> -     uint64_t decode_len = 4; /* 4*256MB */
> +    MemoryRegion *mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +    uint64_t region_base = (uint64_t)memory_region_get_ram_ptr(mr);
> +     uint64_t region_len = 0;
> +     uint64_t decode_len = ct3d->dc.host_dc->size / ct3d->dc.num_regions / (256*1024*1024);
>       uint64_t blk_size = 2*1024*1024;
>       struct CXLDCD_Region *region;

What code are we looking at here?

Anyhow, the DPA here is relative to the device which isn't connected to the QEMU implementation
at all.  The address decoder stuff in QEMU will map to the right region wherever it is, we
just need to pretend the go:

[RAM region] [PMem Region] [DC Region]
where any of these are optional and where the Qemu emulation doesn't currently support
sizes that require any padding.

So the offsets above look wrong anyway as it seems to be assuming we either have
volatile or persistent regions but not both.

Jonathan
