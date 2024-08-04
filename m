Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03233BB32
	for <linux-cxl@vger.kernel.org>; Sun,  4 Aug 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722787070; cv=none; b=cr9fTJarYLrRQMqjXGLyiMg4gy4YVdM9jpWFvZrEggFB4QLPr1/q5jG+4vXnbNk3nnyKZDHYbNcSHg9Kzs494S4231s83RUaNjYeABlC71aUjzGeuMo7G9uG18YJtUuiX8zcTZW7O7PlNI4kTrn4KGS3tqB5/L0je+LDV7jgNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722787070; c=relaxed/simple;
	bh=VsP0L0o98BxfNhIvNhtZTdW8dNJliTFioK3jxiChqL8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsvMHsLUtZ+0DtLHT6aNEAMxI7Bq19KHE+1/PSm1f3D7H7zNUKvL1Xq3VdupcABh5U4L/ezLAUy5JLfg6WgbOfrFA8PhhHsib76jIvk2gEWJf1S7U1VxQEM1WPCnowYkNTREDkCsbZ7bVW9TTK9tHsXd3CACy7qUwEo0gtOl2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcPKM2ZJJz67cSV;
	Sun,  4 Aug 2024 23:55:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6FEC140AA7;
	Sun,  4 Aug 2024 23:57:43 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 16:57:43 +0100
Date: Sun, 4 Aug 2024 16:57:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <shiju.jose@huawei.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 -qemu] hw/cxl: Add Maintenance support
Message-ID: <20240804165740.000010fc@Huawei.com>
In-Reply-To: <20240730045722.71482-1-dave@stgolabs.net>
References: <20240730045722.71482-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jul 2024 21:57:22 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds initial support for the Maintenance command, specifically
> the soft and hard PPR operations on a dpa. The implementation allows
> to be executed at runtime, therefore semantically, data is retained
> and CXL.mem requests are correctly processed.
> 

I'm interesting in kernel support for the version without data retention
as well (because we need to add guard rails and mediate it etc).
Anyhow, that can go on top of this with a suitable (unstable probably)
device parameter.

Perhaps it's worth splitting the event record changes where the device
'suggests' repair in one patch and the PPR stuff in the next?
Obviously a device in between would be odd as it could request
something that it doesn't support though.  However, as long as
they are in the same series I don't think we care.

Various other comments inline.

We probably also want to add the health info command sometime soon
which will be partly fed by whether there are outstanding maintenance
requests.

Thanks,

Jonathan


> Keep track of the requests upon a general media or DRAM event.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Only mildly tested through qmp event injection.
> 
> Changes from v1:
>  - Applies on top of 'cxl-temp' branch.
>  - Reworked on top of the now-merged Features 
>  - Decoupled soft and hard ppr attribute structures.
> 
>  hw/cxl/cxl-mailbox-utils.c  | 194 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  72 +++++++++++--
>  hw/mem/cxl_type3_stubs.c    |   4 +-
>  include/hw/cxl/cxl_device.h |  80 +++++++++++++++
>  include/hw/cxl/cxl_events.h |   8 +-
>  qapi/cxl.json               |  14 +++
>  6 files changed, 363 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b752920ec88a..b19225295fa1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

> @@ -1233,6 +1311,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             CXLCCI *cci)
>  {
>      CXLSetFeatureInHeader *hdr = (void *)payload_in;
> +    CXLMemSoftPPRWriteAttrs *sppr_write_attrs;
> +    CXLMemSoftPPRSetFeature *sppr_set_feature;
> +    CXLMemHardPPRWriteAttrs *hppr_write_attrs;
> +    CXLMemHardPPRSetFeature *hppr_set_feature;
>      CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
>      CXLMemPatrolScrubSetFeature *ps_set_feature;
>      CXLMemECSWriteAttrs *ecs_write_attrs;
> @@ -1313,6 +1395,40 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                    ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
>              }
>          }
> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_SPPR_SET_FEATURE_VERSION) {

Why?  I think it is supposed to always be backwards compatible specifically
so we don't need to care about older versions.
If the OS only knows about version 1 I think it can still write to
a device with version 2?

We should check against minimum feature data size though which doesn't
include the sPPR Operation Mode field in writable attributes.


> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        sppr_set_feature = (void *)payload_in;
> +        sppr_write_attrs = &sppr_set_feature->feat_data;
> +        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
> +               sppr_write_attrs,
> +               bytes_to_copy);
> +        set_feat_info->data_size += bytes_to_copy;
> +
> +        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> +            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> +            ct3d->soft_ppr_attrs.op_mode = ct3d->soft_ppr_wr_attrs.`op_mode;
> +            ct3d->soft_ppr_attrs.sppr_op_mode = ct3d->soft_ppr_wr_attrs.sppr_op_mode;
> +        }
> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_HPPR_SET_FEATURE_VERSION) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        hppr_set_feature = (void *)payload_in;
> +        hppr_write_attrs = &hppr_set_feature->feat_data;
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
> @@ -1325,6 +1441,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
>          } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
>              memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
> +        } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
> +            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
> +        } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
> +            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
>          }
>          set_feat_info->data_transfer_flag = 0;
>          set_feat_info->data_saved_across_reset = false;
> @@ -1335,6 +1455,74 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
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

I think we really should do that as part of this series. Should be fairly
simple I think as it's just another event record.

Ideally we'd also provide the injection path to generate those records for
device initiated variants as well.  I think it would be valid to have
the type3 device report that it can do device initiated and still have
it ask the host to do some.  That way we get to test handling / reporting
of both.  Obviously can't do device initiated and CXL.mem interrupted though
as that would be broken.

> +}
> +
> +/* CXL r3.1 section 8.2.9.7.1 - Perform Maintenance (Opcode 0600h) */
> +#define MAINTENANCE_PPR_QUERY_RESOURCES BIT(0)
> +
> +static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in, size_t len_in,
> +                                   uint8_t *payload_out, size_t *len_out,
> +                                   CXLCCI *cci)
> +{

> +    switch (maint_in->class) {
> +    case 0:
> +        return CXL_MBOX_SUCCESS; /* nop */
Maybe reference table 8-110 for this as not immediately obvious
that is a noop from 8.2.9.7.1 (maybe I'm missing something though)

> +    case 1:
CXL_MEMDEV_PPR_MAINT_CLASS
> +        if (maint_in->ppr.flags & MAINTENANCE_PPR_QUERY_RESOURCES) {
> +            return CXL_MBOX_SUCCESS;

Hmm. Odd that this does subtly different things for PPR and sparing
(I was looking at wrong section and thought this needed an event record)

For now we should probably add a limit counter so we can test the
exhausted reply of CXL_MBOX_RESOURCES_EXHAUSTED or whatever the relevant
define is.

> +        }
> +
> +        switch (maint_in->subclass) {
> +        case 0: /* soft ppr */
CXL_MEMDEV_SPPR_MAINT_SUBCLASS etc

> +        case 1: /* hard ppr */
> +            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
> +            return CXL_MBOX_SUCCESS;
> +        default:
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        break;
can't get here
> +    case 2:
> +    case 3:
> +        return CXL_MBOX_UNSUPPORTED;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
or here

> +}
> +

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4114163324bd..b131f32dc840 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -910,6 +910,26 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      }
>      cxl_event_init(&ct3d->cxl_dstate, 2);
>  
> +    /* Set default values for soft-PPR attributes */
> +    ct3d->soft_ppr_attrs.max_maint_latency = 0x5; /* 100 ms */
> +    ct3d->soft_ppr_attrs.op_caps = 0; /* require host involvement */
> +    ct3d->soft_ppr_attrs.op_mode = 0;
> +    ct3d->soft_ppr_attrs.maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS;
> +    ct3d->soft_ppr_attrs.maint_op_subclass = CXL_MEMDEV_SPPR_MAINT_SUBCLASS;
> +    ct3d->soft_ppr_attrs.sppr_flags = CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG;

Memory sparing Event Record Capability Flag says "this bit shall be set if
Get Feature Version is 02h or greater" which it is I think.

> +    ct3d->soft_ppr_attrs.restriction_flags = 0;
> +    ct3d->soft_ppr_attrs.sppr_op_mode = 0;
> +
> +    /* Set default value for hard-PPR attributes */
> +    ct3d->hard_ppr_attrs.max_maint_latency = 0x5; /* 100 ms */
> +    ct3d->hard_ppr_attrs.op_caps = 0; /* require host involvement */
> +    ct3d->hard_ppr_attrs.op_mode = 0;
> +    ct3d->hard_ppr_attrs.maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS;
> +    ct3d->hard_ppr_attrs.maint_op_subclass = CXL_MEMDEV_HPPR_MAINT_SUBCLASS;
> +    ct3d->hard_ppr_attrs.hppr_flags = CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG;

As above. We have to support the memory sparing event record if we want
to be spec compliant for version 2.

> +    ct3d->hard_ppr_attrs.restriction_flags = 0;
> +    ct3d->hard_ppr_attrs.hppr_op_mode = 0;
> +
>      /* Set default value for patrol scrub attributes */
>      ct3d->patrol_scrub_attrs.scrub_cycle_cap =
>                             CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |


...

>  #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
> @@ -1676,6 +1725,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>  
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint8_t class, uint8_t subclass,

Once optional (see below) these will have bool has_...

>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -1714,11 +1764,17 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>          error_setg(errp, "Unhandled error log type");
>          return;
>      }
> +    if (rc == CXL_EVENT_TYPE_INFO &&
> +        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
> +        error_setg(errp, "Informational event cannot require maintanence");
> +        return;
> +    }
>      enc_log = rc;
>  
>      memset(&dram, 0, sizeof(dram));
>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            class, subclass);
>      stq_le_p(&dram.phys_addr, dpa);
>      dram.descriptor = descriptor;
>      dram.type = type;
> @@ -1775,7 +1831,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
>          cxl_event_irq_assert(ct3d);
>      }
> -    return;
> +    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
> +        cxl_maintenance_insert(ct3d, dpa);
> +    }
>  }
>  



> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index e14e56ae4bc2..3e89a074679d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h


>  typedef struct CXLPoison {
>      uint64_t start, length;
>      uint8_t type;
> @@ -442,6 +455,65 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256


> +#define CXL_MEMDEV_SPPR_GET_FEATURE_VERSION    0x02
> +#define CXL_MEMDEV_SPPR_SET_FEATURE_VERSION    0x02
As above, setting version 2 requires the event record
generation on completion. I think we should do that now
rather than have non spec complaint code, or have to change
the versioning later.

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index bdfac67c473e..58e5c2454882 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -42,6 +42,12 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.1 Table 8-43 Common Event Record Format.
> +#
> +# @subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.1 Table 8-43 Common Event Record Format.
Need to be optional as below.

Also the class naming is non obvious.
Maybe just spell it out?
maintenance-operation-class and maintenance-operation-subclass.


> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,6 +80,7 @@
>  ##
>  { 'command': 'cxl-inject-general-media-event',
>    'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'class':'uint8', 'subclass':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> @@ -97,6 +104,12 @@
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
>  #     Event Record, Physical Address.
>  #
> +# @class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.1 Table 8-43 Common Event Record Format.
> +#
> +# @subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.1 Table 8-43 Common Event Record Format.
> +#

These need to be optional given we are adding details to existing interface.
Add a * like for channel and rank and put a default in if not set.


>  # @descriptor: Memory Event Descriptor with additional memory event
>  #     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
>  #     Event Descriptor for bit definitions.
> @@ -133,6 +146,7 @@
>  ##
>  { 'command': 'cxl-inject-dram-event',
>    'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'class':'uint8', 'subclass':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',

