Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E194C001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 15:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjHDP3A (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjHDP20 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 11:28:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877294EE6
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 08:28:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHTz55JGTz6J6cL;
        Fri,  4 Aug 2023 23:24:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:27:59 +0100
Date:   Fri, 4 Aug 2023 16:27:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 3/9] include/hw/cxl/cxl_device: Rename mem_size
 as static_mem_size for type3 memory devices
Message-ID: <20230804162758.000041ae@Huawei.com>
In-Reply-To: <20230725183939.2741025-4-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4@uscas1p1.samsung.com>
        <20230725183939.2741025-4-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 18:39:55 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
> pmem capacity, preparing for the introduction of dynamic capacity to support
> dynamic capacity devices.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Looks good.  I've picked this up with the author change.

Note that just because I've starting picking these up, doesn't
mean you can't keep changing them, but if you start from where my
gitlab.com/jic23/qemu tree is that will make life easier given
we have a lot of stuff in flight.

Jonathan

p.s. that assumes I've actually pushed the result of this out before
you get back to it!


> ---
>  hw/cxl/cxl-mailbox-utils.c  | 5 +++--
>  hw/mem/cxl_type3.c          | 8 ++++----
>  include/hw/cxl/cxl_device.h | 2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 0fe9f3eb5d..dd5ea95af8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -540,7 +540,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> -    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->total_capacity,
> +            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
> @@ -879,7 +880,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      struct clear_poison_pl *in = (void *)cmd->payload;
>  
>      dpa = ldq_le_p(&in->dpa);
> -    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> +    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
>          return CXL_MBOX_INVALID_PA;
>      }
>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4d68824dfe..3d7acffcb7 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -748,7 +748,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          }
>          address_space_init(&ct3d->hostvmem_as, vmr, v_name);
>          ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
> -        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
> +        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
>          g_free(v_name);
>      }
>  
> @@ -771,7 +771,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          }
>          address_space_init(&ct3d->hostpmem_as, pmr, p_name);
>          ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
> -        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
> +        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
>          g_free(p_name);
>      }
>  
> @@ -984,7 +984,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          return -EINVAL;
>      }
>  
> -    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
> +    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
>          return -EINVAL;
>      }
>  
> @@ -1148,7 +1148,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>          return false;
>      }
>  
> -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
> +    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
>          return false;
>      }
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index dae39da438..503c344326 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -209,7 +209,7 @@ typedef struct cxl_device_state {
>      } timestamp;
>  
>      /* memory region size, HDM */
> -    uint64_t mem_size;
> +    uint64_t static_mem_size;
>      uint64_t pmem_size;
>      uint64_t vmem_size;
>      bool is_dcd;

