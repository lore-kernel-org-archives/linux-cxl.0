Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734D28FD
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430461; cv=none; b=Rx4nFOkYswtHGJqIrvXfjRxG0mo6qHSeBlJFwg7blqdKvqY2sglCAa5zfN3eXvp1KmUgjLkkPQpyAelew61f8PrYeQGrVCuMWe3AXdGQIw33mWt9yt+ptQunYR/X6kYto+hSOUwHEmQwN5DSG50EGmJcDE3wWWs1TyIVxhXCDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430461; c=relaxed/simple;
	bh=bQLubKPdiAUkQbi2rOKagAhNnq/w06kpcgzCjHbcjBU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0Hi1oR7JXskcwuJ2a+g0yuUB1g9+zMI0rYx/i7ihwPeo4hWGzH4JmlSnczPoyDrjYMwBSVIu8TljM9axZmSImH9RFqDKJ8vO/stVyWkKptmjVb3aR8iNBz5CenI/373SF23KVLoK3x0o4AY0KViDQR/W/3o2OLzdclRfxX1SOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bP0Qb71ZLz6L4xl;
	Fri, 20 Jun 2025 22:36:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B4DC8140447;
	Fri, 20 Jun 2025 22:40:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:40:54 +0200
Date: Fri, 20 Jun 2025 15:40:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 6/7] hw/cxl: Add Maintenance support
Message-ID: <20250620154052.00002a17@huawei.com>
In-Reply-To: <20250619151619.1695-7-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
	<20250619151619.1695-7-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 16:16:18 +0100
<shiju.jose@huawei.com> wrote:

> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> This adds initial support for the Maintenance command, specifically
> the soft and hard PPR operations on a dpa. The implementation allows
> to be executed at runtime, therefore semantically, data is retained
> and CXL.mem requests are correctly processed.
> 
> Keep track of the requests upon a general media or DRAM event.
> 
> Post Package Repair (PPR) maintenance operations may be supported by CXL
> devices that implement CXL.mem protocol. A PPR maintenance operation
> requests the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support PPR features
> may implement PPR Maintenance operations. DRAM components may support two
> types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
> (sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
> but the repair is lost with a power cycle.
> 
> CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
> maintenance operation and section 8.2.10.7.1.3 describes the device's
> hPPR (hard PPR) maintenance operation feature.
> 
> CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
> configuration.
> 
> CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
> configuration.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Hi.

Various minor comments inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 191 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  57 +++++++++++
>  include/hw/cxl/cxl_device.h |  88 +++++++++++++++++
>  3 files changed, 336 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 83668d7d93..87c5df83b0 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -89,6 +89,8 @@ enum {
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
>          #define SET_FEATURE   0x2
> +    MAINTENANCE = 0x06,
> +        #define PERFORM 0x0
>      IDENTIFY    = 0x40,
>          #define MEMORY_DEVICE 0x0
>      CCLS        = 0x41,
> @@ -1239,6 +1241,8 @@ typedef struct CXLSupportedFeatureEntry {
>  enum CXL_SUPPORTED_FEATURES_LIST {
>      CXL_FEATURE_PATROL_SCRUB = 0,
>      CXL_FEATURE_ECS,
> +    CXL_FEATURE_SPPR,
> +    CXL_FEATURE_HPPR,
>      CXL_FEATURE_MAX
>  };

> @@ -1441,6 +1499,26 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          memcpy(payload_out,
>                 (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
>                 bytes_to_copy);
> +    } else if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
> +        if (get_feature->offset >= sizeof(CXLMemSoftPPRReadAttrs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(CXLMemSoftPPRReadAttrs) -
> +                                             get_feature->offset;
> +        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
> +        memcpy(payload_out,
> +               (uint8_t *)&ct3d->soft_ppr_attrs + get_feature->offset,
> +               bytes_to_copy);
> +    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
> +        if (get_feature->offset >= sizeof(CXLMemHardPPRReadAttrs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(CXLMemHardPPRReadAttrs) -
> +                                             get_feature->offset;

This indent style doesn't match what we do elsewhere.  Either put it
after the = or 4 spaces in from the line above.

> +        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
> +        memcpy(payload_out,
> +               (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
> +               bytes_to_copy);
>      } else {
>          return CXL_MBOX_UNSUPPORTED;
>      }
> @@ -1552,6 +1630,42 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                          ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
>              }
>          }
> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_SPPR_SET_FEATURE_VERSION) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        CXLMemSoftPPRSetFeature *sppr_set_feature = (void *)payload_in;
> +        CXLMemSoftPPRWriteAttrs *sppr_write_attrs =
> +                            &sppr_set_feature->feat_data;
> +        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
> +               sppr_write_attrs,
> +               bytes_to_copy);
> +        set_feat_info->data_size += bytes_to_copy;
> +
> +        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> +            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> +            ct3d->soft_ppr_attrs.op_mode = ct3d->soft_ppr_wr_attrs.op_mode;
> +            ct3d->soft_ppr_attrs.sppr_op_mode = ct3d->soft_ppr_wr_attrs.sppr_op_mode;
> +        }
> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_HPPR_SET_FEATURE_VERSION) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        CXLMemHardPPRSetFeature *hppr_set_feature = (void *)payload_in;
> +        CXLMemHardPPRWriteAttrs *hppr_write_attrs =
> +                            &hppr_set_feature->feat_data;

As in earlier patch - I'd just do this before checking hdr->version.
Should safe as we are just casting to potentially wrong structure definitions,
not using those until after the header check.

> +        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
> +               hppr_write_attrs,
> +               bytes_to_copy);
> +        set_feat_info->data_size += bytes_to_copy;
> +
> +        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> +            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> +            ct3d->hard_ppr_attrs.op_mode = ct3d->hard_ppr_wr_attrs.op_mode;
> +            ct3d->hard_ppr_attrs.hppr_op_mode = ct3d->hard_ppr_wr_attrs.hppr_op_mode;
> +        }
>      } else {
>          return CXL_MBOX_UNSUPPORTED;
>      }
> @@ -1564,7 +1678,12 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
>          } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
>              memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
> +        } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
> +            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
> +        } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
> +            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
>          }
> +
>          set_feat_info->data_transfer_flag = 0;
>          set_feat_info->data_saved_across_reset = false;
>          set_feat_info->data_offset = 0;
> @@ -1574,6 +1693,72 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
> +{
> +    CXLMaintenance *ent, *next;
> +
> +    QLIST_FOREACH_SAFE(ent, &ct3d->maint_list, node, next) {
> +        if (dpa == ent->dpa) {
> +            QLIST_REMOVE(ent, node);
> +            g_free(ent);
> +            break;
> +        }
> +    }
> +    /* TODO: produce a Memory Sparing Event Record */

This todo is one we should resolve as it means we can then
comply with the spec that requires these to be possible for the feature
version we are claiming to support.  They might not be turned on though
so we'll need to check for that as well.

> +}
> +
> +/* CXL r3.2 section 8.2.10.7.1 - Perform Maintenance (Opcode 0600h) */
> +#define MAINTENANCE_PPR_QUERY_RESOURCES BIT(0)
> +
> +static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in, size_t len_in,
> +                                   uint8_t *payload_out, size_t *len_out,
> +                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t class;
> +        uint8_t subclass;
> +        union {
> +            struct {
> +                uint8_t flags;
> +                uint64_t dpa;
> +                uint8_t nibble_mask[3];
> +            } QEMU_PACKED ppr;
> +        };
> +    } QEMU_PACKED *maint_in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
> +    if (maintenance_running(cci)) {
> +        return CXL_MBOX_BUSY;
> +    }
> +
> +    switch (maint_in->class) {
> +    case 0:
> +        return CXL_MBOX_SUCCESS; /* nop */
> +    case 1:

There are already defines for these and the subclass.  Good
to use them here as well. Might need to add a define for 0 as well.

> +        if (maint_in->ppr.flags & MAINTENANCE_PPR_QUERY_RESOURCES) {
> +            return CXL_MBOX_SUCCESS;
> +        }
> +
> +        switch (maint_in->subclass) {
> +        case 0: /* soft ppr */
> +        case 1: /* hard ppr */
> +            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
> +            return CXL_MBOX_SUCCESS;
> +        default:
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        break;
> +    case 2:
> +    case 3:
> +        return CXL_MBOX_UNSUPPORTED;
That's interesting. I'm not sure we can differentiate between unsupported
and invalid as it depends which spec people are reading + what ECNs etc.
So I'd return CXL_MBOX_INVALID_INPUT for these as well.
The reasoning being that Unsupported is specifically that the command
is not supported, not particular parameters like these.



> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 81774bf4b9..965ad3402d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1205,6 +1205,30 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>          ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
>      }
>  
> +    /* Set default values for soft-PPR attributes */
> +    ct3d->soft_ppr_attrs = (CXLMemSoftPPRReadAttrs) {
> +        .max_maint_latency = 0x5, /* 100 ms */
> +        .op_caps = 0, /* require host involvement */
> +        .op_mode = 0,
> +        .maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS,
> +        .maint_op_subclass = CXL_MEMDEV_SPPR_MAINT_SUBCLASS,
> +        .sppr_flags = CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG,
Also CXL_MEMDEV_SPPR_MEM_SPARING_EV_REC_CAP I think
as it is required for version 2 and above.

There is a todo comment so maybe fine to leave for now.
Hopefully no one assumes this is set based on the version alone.

Perhaps that's the next thing to enable as if we do put
out he records I think this feature could be considered fully
emulated whereas now it is sort of half done.

> +        .restriction_flags = 0,
> +        .sppr_op_mode = 0
> +    };
> +
> +    /* Set default value for hard-PPR attributes */
> +    ct3d->hard_ppr_attrs = (CXLMemHardPPRReadAttrs) {
> +        .max_maint_latency = 0x5, /* 100 ms */
> +        .op_caps = 0, /* require host involvement */
> +        .op_mode = 0,
> +        .maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS,
> +        .maint_op_subclass = CXL_MEMDEV_HPPR_MAINT_SUBCLASS,
> +        .hppr_flags = CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG,

As above. I think we need to send the event records on completion
if they are enabled.


> +        .restriction_flags = 0,
> +        .hppr_op_mode = 0
> +    };


