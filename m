Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215D22D780
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614059; cv=none; b=LgB/MD4sYwWU91/T67oY/hjpsl4SIuOPSzWhL25G0h9jy4myd3q5ZSBQhqDwzZQGqeLNpj5aUVVoshfE2yLCgAt+PhiICZFnvyC/HpfP0ro1DtSvZ2q2MiAFxCXuXhk8u5x9OiGwLbh6Ikz0YZnlGEmj7wpYL15TeC2iG5VFwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614059; c=relaxed/simple;
	bh=SxuSPFaS/gzuAdg0rE8PZ1CiVzIphsqe/A1xJEIYumA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0ltV05++9ybH0tnz1o5Ynn3jdR0N4jNU+3xuN7mCqT/Do9P/XDF9dHFk7DHNHKBRNwO/bQcPKmB6ABJOwOeUSym/Xus4hiWmb2yhqdSR0w+0JHaiUrBJ2kKKZcgoOvCweK91mD8kLCgP44jHeQsI77cQfjXBhpr9x+KGrrHLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b84j55tCcz6L5ZN;
	Fri, 30 May 2025 22:03:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D48A81402FC;
	Fri, 30 May 2025 22:07:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 16:07:33 +0200
Date: Fri, 30 May 2025 15:07:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 02/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <20250530150732.00007220@huawei.com>
In-Reply-To: <20250508001754.122180-3-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
	<20250508001754.122180-3-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  8 May 2025 00:00:58 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Looks like a missing include - though probably due to some indirect include 
going away.

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/i2c_mctp_cxl.c        |  6 ++--
>  hw/mem/cxl_type3.c           |  4 +++
>  include/hw/cxl/cxl_device.h  |  1 +
>  include/hw/cxl/cxl_opcodes.h |  3 ++
>  5 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ed3294530f..d3c69233b8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3280,6 +3280,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
> +static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t num_hosts;
> +        uint8_t num_regions_supported;
> +        uint8_t rsvd1[2];
> +        uint16_t add_select_policy_bitmask;
> +        uint8_t rsvd2[2];
> +        uint16_t release_select_policy_bitmask;
> +        uint8_t sanitize_on_release_bitmask;
> +        uint8_t rsvd3;
> +        uint64_t total_dynamic_capacity;
> +        uint64_t region_blk_size_bitmasks[8];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCRegion *region;
> +    int i;
> +
> +    out->num_hosts = 1;
> +    out->num_regions_supported = ct3d->dc.num_regions;
> +    stw_le_p(&out->add_select_policy_bitmask,
> +             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));

Something seems to have changed upstream so this now needs
#include <qapi/qapi-types-cxl.h> to get these enum values.

> +    stw_le_p(&out->release_select_policy_bitmask,
> +             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
> +    out->sanitize_on_release_bitmask = 0;
> +
> +    stq_le_p(&out->total_dynamic_capacity,
> +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        memcpy(&out->region_blk_size_bitmasks[i],
> +               &region->supported_blk_size_bitmask,
> +               sizeof(out->region_blk_size_bitmasks[i]));
> +    }
> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3401,6 +3447,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>                                       cmd_tunnel_management_cmd, ~0, 0 },
>  };
>  
> +static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> +    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
> +        cmd_fm_get_dcd_info, 0, 0 },
> +};
> +
>  /*
>   * While the command is executing in the background, the device should
>   * update the percentage complete in the Background Command Status Register
> @@ -3703,7 +3754,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>                                             DeviceState *intf,
>                                             size_t payload_max)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> +    if (ct3d->dc.num_regions) {
> +        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
> +    }
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> index 7d2cbc3b75..dd5fc4f393 100644
> --- a/hw/cxl/i2c_mctp_cxl.c
> +++ b/hw/cxl/i2c_mctp_cxl.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/registerfields.h"
> +#include "hw/cxl/cxl_opcodes.h"
>  
>  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
>  
> @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
>           */
>  
>          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> -              msg->command_set < 0x51) &&
> +              msg->command_set < PHYSICAL_SWITCH) &&
>              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> +              msg->command_set >= PHYSICAL_SWITCH &&
> +              msg->command_set < GLOBAL_MEMORY_ACCESS_EP_MGMT)) {
>              buf->rc = CXL_MBOX_UNSUPPORTED;
>              st24_le_p(buf->pl_length, len_out);
>              s->len = s->pos;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 11c38a9292..7129da0940 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -8,6 +8,7 @@
>   *
>   * SPDX-License-Identifier: GPL-v2-only
>   */
> +#include <math.h>
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> @@ -766,6 +767,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>      uint64_t region_len;
>      uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
> +    /* Only 1 block size is supported for now. */
> +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
>      CXLDCRegion *region;
>      MemoryRegion *mr;
>      uint64_t dc_size;
> @@ -811,6 +814,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>              .block_size = blk_size,
>              /* dsmad_handle set when creating CDAT table entries */
>              .flags = 0,
> +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..bebed04085 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
>      uint32_t dsmadhandle;
>      uint8_t flags;
>      unsigned long *blk_bitmap;
> +    uint64_t supported_blk_size_bitmask;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index 26d3a99e8a..c4c233665e 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -61,4 +61,7 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +    FMAPI_DCD_MGMT = 0x56,
> +        #define GET_DCD_INFO 0x0
> +    GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };

