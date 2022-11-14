Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA0C43219
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiKNRzw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiKNRzV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 12:55:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5272529A
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 09:55:20 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N9xjl0XJ3z689QP;
        Tue, 15 Nov 2022 01:52:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:55:17 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 17:55:17 +0000
Date:   Mon, 14 Nov 2022 17:55:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
        <imammedo@redhat.com>, <ani@anisinha.ca>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Message-ID: <20221114175516.0000375d@Huawei.com>
In-Reply-To: <20221026004737.3646-3-gregory.price@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
        <20221026004737.3646-3-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Oct 2022 20:47:35 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Remove usage of magic numbers when accessing capacity fields and replace
> with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Makes sense. I'll add it to my local tree.

Depending on how timing works out, I might roll this into a wider series
of cleanups sent to Michael or we might want to keep this as part of your
series.

Jonathan
 
> ---
>  hw/cxl/cxl-mailbox-utils.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3e23d29e2d..d7543fd5b4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -15,6 +15,8 @@
>  #include "qemu/log.h"
>  #include "qemu/uuid.h"
>  
> +#define CXL_CAPACITY_MULTIPLIER   0x10000000 /* SZ_256M */
> +
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
>   *  1. Add the command set and cmd to the enum.
> @@ -267,7 +269,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
>  
> -    if (cxl_dstate->pmem_size < (256 << 20)) {
> +    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -412,7 +414,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      uint64_t size = cxl_dstate->pmem_size;
>  
> -    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> +    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -422,8 +424,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
>      /* PMEM only */
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> -    id->total_capacity = size / (256 << 20);
> -    id->persistent_capacity = size / (256 << 20);
> +    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
> +    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
>      id->lsa_size = cvc->get_lsa_size(ct3d);
>      id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
>  
> @@ -444,14 +446,14 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
>      uint64_t size = cxl_dstate->pmem_size;
>  
> -    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> +    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
>      /* PMEM only */
>      part_info->active_vmem = 0;
>      part_info->next_vmem = 0;
> -    part_info->active_pmem = size / (256 << 20);
> +    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
>      part_info->next_pmem = 0;
>  
>      *len = sizeof(*part_info);

