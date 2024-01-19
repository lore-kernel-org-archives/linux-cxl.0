Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474D55E4A
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jan 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686619; cv=none; b=Hf1lvNogyXiaYWE/i3XOlPtEO8qa0WhJMEuvgywlP6TjeJrunPyhKClZ7zSMRKCaaUs3zhCbGc/obKj5F/JqkksMjy1+DKaEgoykaXjwqSRDzGwVdftLWbdFI85DEVzPlwuDaYQxiidRmg+dTU5WG6wom9WSX5W7Tmn14oMtdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686619; c=relaxed/simple;
	bh=hQedSQ6sfopsK6YwQG0ts1P75mlvCKewTqKiTLCWV2M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL2E/05v34uuBhZfvnze+xP+YIlC/zmWxmqT/vZP/uZWoZvDmJoAN8Bk+UJqxuXqOi0D44PKU43G001hEyNT5qWl61eLbC5/An2DA1/+kjQ+Bdmc0f1KFzbolN+5FyL4O5pXwth82kcLEAxTOfMqkprfnoy2arGH/4PgufJqs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TGnBK674Bz6JBCj;
	Sat, 20 Jan 2024 01:47:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0944F140B55;
	Sat, 20 Jan 2024 01:50:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 17:50:07 +0000
Date: Fri, 19 Jan 2024 17:50:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <a.manzanares@samsung.com>, <mounika.k@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -qemu] hw/cxl: Add Maintenance support
Message-ID: <20240119175006.00007f74@Huawei.com>
In-Reply-To: <20240117082435.11348-1-dave@stgolabs.net>
References: <20240117082435.11348-1-dave@stgolabs.net>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jan 2024 00:24:35 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds initial support for the Maintenance command, specifically
> the soft and hard PPR operations on a dpa. The implementation allows
> to be executed at runtime, therefore semantically, data is retained
> and CXL.mem requests are correctly processed.
> 
> Keep track of the requests upon a general media or DRAM event.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Hi Davidlohr, some quick comments.  My tree is a bit of a mess at the
moment. Hopefully I'll get that cleaned up soon and pick this and
a few other recent additions up.

Feel free to send a v2 fixing the below, or if not I can probably tweak
what I've pointed out when I queue it up.

> ---
> Only mildly tested through qmp event injection.
> Applies on top of the Features machinery:
> 	https://lore.kernel.org/linux-cxl/20231124135338.1191-2-shiju.jose@huawei.com/
> 
>  hw/cxl/cxl-mailbox-utils.c  | 233 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  52 ++++++--
>  hw/mem/cxl_type3_stubs.c    |   4 +-
>  include/hw/cxl/cxl_device.h |  15 +++
>  include/hw/cxl/cxl_events.h |   5 +-
>  qapi/cxl.json               |  18 +++
>  6 files changed, 314 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 67bfcadf8b49..9df3d2894a9f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -100,13 +100,15 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> -    DCD_MANAGEMENT = 0x56
> +    DCD_MANAGEMENT = 0x56,

oops.  That should be fixed in the DCD patch really.
If it all ends up in my tree without that being tidied up I'll push that
change down if I remember.


> +
> +typedef struct CXLPPReadAttr {
> +    uint8_t max_maint_latency;
> +    uint16_t op_caps;
> +    uint16_t op_mode;
> +    uint8_t maint_op_class;
> +    uint8_t maint_op_subclass;
> +    uint8_t rsvd[9];
> +    uint8_t ppr_flags;

Probably a sepc reference to each of the two types of entry would
be good here. Today they look the same, but who knows in future!

> +    uint16_t restriction_flags;
> +    uint8_t ppr_op_mode;
> +} QEMU_PACKED CXLPPReadAttr;
> +static CXLPPReadAttr cxl_memdev_hppr_feat_read_attr;
> +static CXLPPReadAttr cxl_memdev_sppr_feat_read_attr;

Not liking the non const globals.  We might be emulating a bunch of
different devices...

Make these const and put the rest of the data up here?
Not obvious to me why the code has to fill it in at runtime
though I guess maybe the plan was to make it change?

> +
> +typedef struct CXLPPRWriteAttr {
> +    uint16_t op_mode;
> +    uint8_t ppr_op_mode;
> +} QEMU_PACKED CXLPPRWriteAttr;
> +static CXLPPRWriteAttr cxl_memdev_hppr_feat_write_attr;
> +static CXLPPRWriteAttr cxl_memdev_sppr_feat_write_attr;
> +
> +typedef struct CXLPPRSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLPPRWriteAttr feat_data;
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLPPRSetFeature;
> +
>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1052,7 +1096,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      uint16_t feat_entries = 0;
>  
>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>      req_entries = (get_feats_in->count -
> @@ -1064,6 +1108,62 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      entry = 0;
>      while (entry < req_entries) {
>          switch (index) {
> +        case CXL_FEATURE_SPPR:
> +            /* Fill supported feature entry for sPPR */
> +            get_feats_out->feat_entries[entry] =
> +                           (struct CXLSupportedFeatureEntry) {
> +                .uuid = soft_ppr_uuid,
> +                .feat_index = index,
> +                .get_feat_size = sizeof(cxl_memdev_sppr_feat_read_attr),
> +                .set_feat_size = sizeof(cxl_memdev_sppr_feat_write_attr),
> +                .attrb_flags = BIT(0) | BIT(5),
> +                .get_feat_version = 0x2,
> +                .set_feat_version = 0x2,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +
> +            /* 100 ms */
> +            cxl_memdev_sppr_feat_read_attr.max_maint_latency = 0x5;
> +            /* only start maintanance when explicitly requested */
Add some defines so that becomes obvious from the code perhaps.
> +            cxl_memdev_sppr_feat_read_attr.op_caps = 0;
> +            cxl_memdev_sppr_feat_read_attr.op_mode = 0;
> +            cxl_memdev_sppr_feat_read_attr.maint_op_class = 0x1;
> +            cxl_memdev_sppr_feat_read_attr.maint_op_subclass = 0;
> +            /* dpa support */
> +            cxl_memdev_sppr_feat_read_attr.ppr_flags = BIT(0);
> +            /* data is retained across maintenance */
> +            cxl_memdev_sppr_feat_read_attr.restriction_flags = 0;
> +            cxl_memdev_sppr_feat_read_attr.ppr_op_mode = 0;
> +            break;
> +        case CXL_FEATURE_HPPR:
> +            /* Fill supported feature entry for hPPR */
> +            get_feats_out->feat_entries[entry] =
> +                           (struct CXLSupportedFeatureEntry) {
> +                .uuid = hard_ppr_uuid,
> +                .feat_index = index,
> +                .get_feat_size = sizeof(cxl_memdev_hppr_feat_read_attr),
> +                .set_feat_size = sizeof(cxl_memdev_hppr_feat_write_attr),
> +                .attrb_flags = BIT(0) | BIT(5),
> +                .get_feat_version = 0x2,
> +                .set_feat_version = 0x2,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +
> +            /* 100 ms */
> +            cxl_memdev_hppr_feat_read_attr.max_maint_latency = 0x5;
> +            /* only start maintanance when explicitly requested */
> +            cxl_memdev_hppr_feat_read_attr.op_caps = 0;
> +            cxl_memdev_hppr_feat_read_attr.op_mode = 0;
> +            cxl_memdev_hppr_feat_read_attr.maint_op_class = 0x1;
> +            cxl_memdev_hppr_feat_read_attr.maint_op_subclass = 0x1;
> +            /* dpa support */
> +            cxl_memdev_hppr_feat_read_attr.ppr_flags = BIT(0);
> +            /* data is retained across maintenance */
> +            cxl_memdev_hppr_feat_read_attr.restriction_flags = 0;
> +            cxl_memdev_hppr_feat_read_attr.ppr_op_mode = 0;
> +            break;
>          default:
>              break;
>          }
> @@ -1104,6 +1204,32 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
> +        if (get_feature->offset >= sizeof(cxl_memdev_sppr_feat_read_attr)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(cxl_memdev_sppr_feat_read_attr) -
> +                                             get_feature->offset;
> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> +                               get_feature->count : bytes_to_copy;

min()?

> +        memcpy(payload_out,
> +               &cxl_memdev_sppr_feat_read_attr + get_feature->offset,
> +               bytes_to_copy);
> +    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
> +        if (get_feature->offset >= sizeof(cxl_memdev_hppr_feat_read_attr)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(cxl_memdev_hppr_feat_read_attr) -
> +                                             get_feature->offset;
> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> +                               get_feature->count : bytes_to_copy;
> +        memcpy(payload_out,
> +               &cxl_memdev_hppr_feat_read_attr + get_feature->offset,
> +               bytes_to_copy);
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      *len_out = bytes_to_copy;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1117,6 +1243,106 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             size_t *len_out,
>                                             CXLCCI *cci)
>  {
> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> +
> +    if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
> +        CXLPPRWriteAttr *sppr_write_attr;
> +        CXLPPRSetFeature *sppr_set_feature;
> +
> +        if (hdr->version != 0x2 ||

I guess we have no obligation to support other versions, but in theory they
should be backwards compatible I think...

> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        sppr_set_feature = (void *)payload_in;
> +        sppr_write_attr = &sppr_set_feature->feat_data;
> +        cxl_memdev_sppr_feat_read_attr.op_mode = sppr_write_attr->op_mode;
> +        cxl_memdev_sppr_feat_read_attr.ppr_op_mode = sppr_write_attr->ppr_op_mode;
> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
> +        CXLPPRWriteAttr *hppr_write_attr;
> +        CXLPPRSetFeature *hppr_set_feature;
> +
> +        if (hdr->version != 0x2 ||
> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        hppr_set_feature = (void *)payload_in;
> +        hppr_write_attr = &hppr_set_feature->feat_data;
> +        cxl_memdev_hppr_feat_read_attr.op_mode = hppr_write_attr->op_mode;
> +        cxl_memdev_hppr_feat_read_attr.ppr_op_mode = hppr_write_attr->ppr_op_mode;
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +    return CXL_MBOX_SUCCESS;

I'd return in each leg as then we don't have to go look to see what is left to
do...

> +}

...
> +
> +/* CXL r3.1 section 8.2.9.7.1 - Perform Maintenance (Opcode 600h) */

Add the leading 0, so 0600h to match the spec.

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

Add a define for the one bit in flags so we can name it.

> +                uint64_t dpa;

Yay that's horribly misaligned.  

> +                uint8_t nibble_mask[3];
> +            } ppr;

I'm too lazy to go spec diving but doesn't this want to be marked packed as well?

> +        };
> +    } QEMU_PACKED *maint_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
> +    if (maintenance_running(cci)) {
> +        return CXL_MBOX_BUSY;
> +    }
> +
> +    maint_in = (void *)payload_in;
> +
> +    switch (maint_in->class) {
> +    case 0:
> +        return CXL_MBOX_SUCCESS; /* nop */
> +    case 1:
> +        if (maint_in->ppr.flags & BIT(0)) {
> +            /* resources are always available */

Nice to test what happens if they aren't.  Maybe only allow 10 hard ever?


> +            break;
> +        }
> +
> +        switch (maint_in->subclass) {
> +        case 0: /* soft ppr */
> +        case 1: /* hard ppr */
> +            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
> +            break;
Just return SUCCESS here and save the breaks...

> +        default:
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        break;
> +    case 2:
> +    case 3:
> +        return CXL_MBOX_UNSUPPORTED;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }



...

>  #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
> @@ -1809,6 +1837,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>  
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint8_t class, uint8_t subclass,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -1847,11 +1876,15 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>          error_setg(errp, "Unhandled error log type");
>          return;
>      }
> +    if (rc == CXL_EVENT_TYPE_INFO && (flags & BIT(3))) {
> +        error_setg(errp, "Informational event cannot require maintanence");
> +        return;
> +    }
>      enc_log = rc;
>  
>      memset(&dram, 0, sizeof(dram));
>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate), 0, 0);
>      stq_le_p(&dram.phys_addr, dpa);
>      dram.descriptor = descriptor;
>      dram.type = type;
> @@ -1908,7 +1941,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
>          cxl_event_irq_assert(ct3d);
>      }
> -    return;
> +
> +    if (flags & BIT(3)) {

That 3 should probably be a define. It didn't really matter before as it was
passed through but if we are going to do new stuff based on it we should
name the beast.

> +        cxl_maintenance_insert(ct3d, dpa);
> +    }
>  }
>  

...


> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b2cb280e1631..82b93974b837 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -426,6 +426,11 @@ static inline bool sanitize_running(CXLCCI *cci)
>      return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
>  }
>  
> +static inline bool maintenance_running(CXLCCI *cci)
> +{
> +    return !!cci->bg.runtime && cci->bg.opcode == 0x600;

The !! shouldn't matter for a && as any non 0 integer
will be treated as true.

> +}
> +
>  typedef struct CXLError {
>      QTAILQ_ENTRY(CXLError) node;
>      int type; /* Error code as per FE definition */
> @@ -434,6 +439,13 @@ typedef struct CXLError {
>  
>  typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
>  
> +typedef struct CXLMaintenance {
> +    uint64_t dpa;
> +    QLIST_ENTRY(CXLMaintenance) node;
> +} CXLMaintenance;
> +
> +typedef QLIST_HEAD(, CXLMaintenance) CXLMaintenanceList;
> +
>  typedef struct CXLPoison {
>      uint64_t start, length;
>      uint8_t type;
> @@ -520,6 +532,9 @@ struct CXLType3Dev {
>      /* Error injection */
>      CXLErrorList error_list;
>  
> +    /* Keep track of maintenance requests */
> +    CXLMaintenanceList maint_list;
> +
>      /* Poison Injection - cache */
>      CXLPoisonList poison_list;
>      unsigned int poison_list_cnt;
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4f8cb3215d30..ec3157829f51 100644

...

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 1b134680239b..3e168d306b42 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -43,6 +43,14 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance class operation the device requests to initiate.
> +#     See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common Event
> +#     Record Format.
> +#
> +# @subclass: Maintenance subclass operation the device requests to
> +#     initiate. See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common
> +#     Event Record Format.
Same comments as below.

> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -75,6 +83,7 @@
>  ##
>  { 'command': 'cxl-inject-general-media-event',
>    'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'class':'uint8', 'subclass':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> @@ -94,6 +103,14 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance class operation the device requests to initiate.
Mainentance 
> +#     See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common Event
> +#     Record Format.

I'm planning to shortly send out a patch series that shifts all the references
to r3.1 main aim is just to get to something consistent as a bunch of the
old ones are CXL r2.0 but don't say that.

The traditional option of referencing first introducing spec is fine
in principle but we've not resolved those outside the consortium getting
access to the older specs, so right now such unlucky people can only
see r3.1.

That's not to say I plan to bother updating them when rX.X appears
unless things change.  Hopefully by then we'll have resolved long
term spec access (I can dream!)


> +#
> +# @subclass: Maintenance subclass operation the device requests to
Maintenance operation subclass to match spec naming.
> +#     initiate. See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common
> +#     Event Record Format.

Huh. Not there in my copy of r3.0 (that was added for r3.1)

> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
>  #     Event Record, Physical Address.
> @@ -134,6 +151,7 @@
>  ##
>  { 'command': 'cxl-inject-dram-event',
>    'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'class':'uint8', 'subclass':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',

