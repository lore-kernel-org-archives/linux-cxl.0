Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B46AC001DF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjHDP0S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHDP0B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 11:26:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDA49F0
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 08:25:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHTvZ0jjFz6J67F;
        Fri,  4 Aug 2023 23:21:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:24:55 +0100
Date:   Fri, 4 Aug 2023 16:24:54 +0100
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
Subject: Re: [Qemu PATCH v2 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic
 capacity region representative and mailbox command support
Message-ID: <20230804162454.000052ae@Huawei.com>
In-Reply-To: <20230725183939.2741025-3-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183956uscas1p296403063c710f4b546d4fec7650915c4@uscas1p2.samsung.com>
        <20230725183939.2741025-3-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 18:39:55 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
You should fix the author on these to match the SoB

git commit --amend --author="Fan Ni <fan.ni@samsung.com>" fixes them.

I'm trying to pick these up for my tree as I review them (where they aren't
invasive).  So I'll fix this stuff whilst doing so.

I'm applying on top of the mailbox rework.  Whilst some of that
may take a while to land I think we can move the generalization code
forwards fairly soon and that changes the command functions etc to not
assume as much.

> 
> Per cxl spec 3.0, add dynamic capacity region representative based on
> Table 8-126 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 72 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  6 ++++
>  include/hw/cxl/cxl_device.h | 17 +++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b013e30314..0fe9f3eb5d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/

I'd not document the section here (As otherwise this list will get very messy).

> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -939,6 +941,71 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.1
> + * Get Dynamic Capacity Configuration

Here is a good place for documentation.  I'm trying to slowly standardize these
references though (might do a blanket fixup if I get time next week).
My current preference is:

 * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration
 * (Opcode 4800h)

Long winded but should avoid us being forced to update this for CXL.next when
it's released (and it becomes hard to get old specs)

> + **/
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
> +        CXLDeviceState *cxl_dstate,
> +        uint16_t *len)
> +{
> +    struct get_dyn_cap_config_in_pl {
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_out_pl {
> +        uint8_t num_regions;
> +        uint8_t rsvd1[7];
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;
> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_in_pl *in = (void *)cmd->payload;
> +    struct get_dyn_cap_config_out_pl *out = (void *)cmd->payload;

I've reworked this stuff to take into account the changes in the cci
reworking patch set. Changes the parameter etc but not too hard to 
rebase this.

> +    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
> +            cxl_dstate);
> +    uint16_t record_count = 0, i;
> +    uint16_t out_pl_len;
> +    uint8_t start_region_id = in->start_region_id;
> +
> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);
> +    out->num_regions = record_count;
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                ct3d->dc.regions[start_region_id + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                ct3d->dc.regions[start_region_id + i].decode_len);
> +        stq_le_p(&out->records[i].region_len,
> +                ct3d->dc.regions[start_region_id + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                ct3d->dc.regions[start_region_id + i].block_size);
> +        stl_le_p(&out->records[i].dsmadhandle,
> +                ct3d->dc.regions[start_region_id + i].dsmadhandle);
> +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> +    }
> +
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -977,6 +1044,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
>          cmd_media_clear_poison, 72, 0 },
> +    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
> +        cmd_dcd_get_dyn_cap_config, 2, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> @@ -1164,6 +1233,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>      }
>      for (int set = 0; set < 256; set++) {
>          for (int cmd = 0; cmd < 256; cmd++) {
> +            if (!cxl_dstate->is_dcd && set == DCD_CONFIG) {
> +                continue;
> +            }
Hmm. This doesn't work any more as at the level of this function we now have
a cci rather that the device state.

I've tried dropping in a version of Gregory's dynamic command registration
so we only register the DCD commands if we have enabled them.

>              if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
>                  struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
>                  struct cel_log *log =
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 862107c5ef..4d68824dfe 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1046,6 +1046,12 @@ static void ct3d_reset(DeviceState *dev)
>      uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
>      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
> +    if (ct3d->dc.num_regions) {
> +        ct3d->cxl_dstate.is_dcd = true;
> +    } else {
> +        ct3d->cxl_dstate.is_dcd = false;
> +    }
> +
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_common(&ct3d->cxl_dstate);
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cd7f28dba8..dae39da438 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -212,6 +212,7 @@ typedef struct cxl_device_state {
>      uint64_t mem_size;
>      uint64_t pmem_size;
>      uint64_t vmem_size;
> +    bool is_dcd;
>  
>      struct cxl_cmd (*cxl_cmd_set)[256];
>      CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
> @@ -382,6 +383,17 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +#define DCD_MAX_REGION_NUM 8
> +
> +typedef struct CXLDCD_Region {
> +    uint64_t base;
> +    uint64_t decode_len; /* in multiples of 256MB */
> +    uint64_t len;
> +    uint64_t block_size;
> +    uint32_t dsmadhandle;
> +    uint8_t flags;
> +} CXLDCD_Region;

whilst we aren't always strictly inline with QEMU naming conventions
to match local style at least we should have CXLDCDRegion

> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -413,6 +425,11 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +
> +    struct dynamic_capacity {
> +        uint8_t num_regions; /* 0-8 regions */
> +        struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
Typedef above, so
	   CXLDCDRegion regions[...]

> +    } dc;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"

