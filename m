Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D019E7E3
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907068; cv=none; b=o49cjtpXRdIW+6za7AzXptGhIVQufSr5+EEjv17wh6RlQ1vdcWgA8HCG/KZVh9YaVI/U+5eXkFKlyqEviX1FNFz67X9SG+5v1IaxkxO9YeR/dDMeKZ193Zm/BZlnq/Ru4gVZr57rLpuOPqTVxI6k5UcMTCYK7/cT86+dD360X+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907068; c=relaxed/simple;
	bh=ZZHv57Mr/W2xTIV8MWfB1nA+56d7SNyg3A0phDOJpSc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3kiQPd1VvCdPtAp5GFcVMHEyNlJFXFsZrtU69z89c8kK9awhoyJ9OkwCYOp7+I/++AmEJcxCvBv0Z9z7c25INI/TYLKb/9GkxAWAHZ+eL5ltkXeeQrLs9FCnDWQq5sjO6dOr0O29/bDhSUMRQo+2q/3AmKc0Tta8c3l1xNOGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRwh81bnnz6K9Kw;
	Mon, 14 Oct 2024 19:57:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D463E140519;
	Mon, 14 Oct 2024 19:57:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 13:57:43 +0200
Date: Mon, 14 Oct 2024 12:57:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jonathan Cameron via <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <fan.ni@samsung.com>,
	<prime.zeng@hisilicon.com>, <tanxiaofei@huawei.com>
Subject: Re: [PATCH 1/1] hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS
 control feature tables
Message-ID: <20241014125724.00001b41@huawei.com>
In-Reply-To: <20241014110912.000014ed@Huawei.com>
References: <20240927091743.965-1-shiju.jose@huawei.com>
	<20241014110912.000014ed@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 11:09:12 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Fri, 27 Sep 2024 10:17:43 +0100
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> > control feature.
> > 
> > ECS log capabilities field in following ECS tables, which is common for all
> > memory media FRUs in a CXL device.
> > 
> > Fix struct CXLMemECSReadAttrs and struct CXLMemECSWriteAttrs to make
> > log entry type field common.
> > 
> > Fixes:2d41ce38fb9a (hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature)
Fixes tag format is wrong. I've fixed up as.
Fixes: 2d41ce38fb9a ("hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature")

> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> Hi Shiju
> 
> Sorry for taking so long to get to this! 
> 
> Anyhow, one trivial comment inline that I'll fix up.
> I'm preparing a fixes series today so will include this patch in that.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 27 ++++++++++-----------------
> >  hw/mem/cxl_type3.c          |  9 ++++-----
> >  include/hw/cxl/cxl_device.h | 36 ++++++++++++++++++++++--------------
> >  3 files changed, 36 insertions(+), 36 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c2d776bc96..fa06cd7910 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1152,10 +1152,8 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> >                           (struct CXLSupportedFeatureEntry) {
> >                  .uuid = ecs_uuid,
> >                  .feat_index = index,
> > -                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
> > -                                    sizeof(CXLMemECSReadAttrs),
> > -                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
> > -                                    sizeof(CXLMemECSWriteAttrs),
> > +                .get_feat_size = sizeof(CXLMemECSReadAttrs),
> > +                .set_feat_size = sizeof(CXLMemECSWriteAttrs),
> >                  .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
> >                  .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
> >                  .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
> > @@ -1223,13 +1221,10 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
> >                 (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
> >                 bytes_to_copy);
> >      } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
> > -        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
> > -                                sizeof(CXLMemECSReadAttrs)) {
> > +        if (get_feature->offset >= sizeof(CXLMemECSReadAttrs)) {
> >              return CXL_MBOX_INVALID_INPUT;
> >          }
> > -        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
> > -                        sizeof(CXLMemECSReadAttrs) -
> > -                            get_feature->offset;
> > +        bytes_to_copy = sizeof(CXLMemECSReadAttrs) - get_feature->offset;
> >          bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
> >          memcpy(payload_out,
> >                 (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
> > @@ -1318,19 +1313,17 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >  
> >          ecs_set_feature = (void *)payload_in;
> >          ecs_write_attrs = ecs_set_feature->feat_data;
> > -        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
> > +        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
> >                 ecs_write_attrs,
> >                 bytes_to_copy);
> >          set_feat_info->data_size += bytes_to_copy;
> >  
> >          if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> >              data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> > -            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
> > -                ct3d->ecs_attrs[count].ecs_log_cap =
> > -                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
> > -                ct3d->ecs_attrs[count].ecs_config =
> > -                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
> > -            }
> > +            ct3d->ecs_attrs.ecs_log_cap = ct3d->ecs_wr_attrs.ecs_log_cap;
> > +            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++)  
> Qemu style needs the brackets even for one line cases. I'll fix up whilst applying
> Also side effect will be reducing the diff which is nice to have :)
> 
> > +                ct3d->ecs_attrs.fru_attrs[count].ecs_config =
> > +                        ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
> >          }
> >      } else {
> >          return CXL_MBOX_UNSUPPORTED;
> > @@ -1343,7 +1336,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >          if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> >              memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
> >          } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
> > -            memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
> > +            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
> >          }
> >          set_feat_info->data_transfer_flag = 0;
> >          set_feat_info->data_saved_across_reset = false;
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 3006ca21ad..e10de42254 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1045,16 +1045,15 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >      ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
> >  
> >      /* Set default value for DDR5 ECS read attributes */
> > +    ct3d->ecs_attrs.ecs_log_cap = CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
> >      for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
> > -        ct3d->ecs_attrs[count].ecs_log_cap =
> > -                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
> > -        ct3d->ecs_attrs[count].ecs_cap =
> > +        ct3d->ecs_attrs.fru_attrs[count].ecs_cap =
> >                              CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
> > -        ct3d->ecs_attrs[count].ecs_config =
> > +        ct3d->ecs_attrs.fru_attrs[count].ecs_config =
> >                              CXL_ECS_THRESHOLD_COUNT_DEFAULT |
> >                              (CXL_ECS_MODE_DEFAULT << 3);
> >          /* Reserved */
> > -        ct3d->ecs_attrs[count].ecs_flags = 0;
> > +        ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
> >      }
> >  
> >      return;
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 4b68c52cdc..076eb9814a 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -493,18 +493,6 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
> >  #define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> >  
> >  /* CXL memory device DDR5 ECS control attributes */
> > -typedef struct CXLMemECSReadAttrs {
> > -        uint8_t ecs_log_cap;
> > -        uint8_t ecs_cap;
> > -        uint16_t ecs_config;
> > -        uint8_t ecs_flags;
> > -} QEMU_PACKED CXLMemECSReadAttrs;
> > -
> > -typedef struct CXLMemECSWriteAttrs {
> > -   uint8_t ecs_log_cap;
> > -    uint16_t ecs_config;
> > -} QEMU_PACKED CXLMemECSWriteAttrs;
> > -
> >  #define CXL_ECS_GET_FEATURE_VERSION    0x01
> >  #define CXL_ECS_SET_FEATURE_VERSION    0x01
> >  #define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
> > @@ -513,6 +501,26 @@ typedef struct CXLMemECSWriteAttrs {
> >  #define CXL_ECS_MODE_DEFAULT    0
> >  #define CXL_ECS_NUM_MEDIA_FRUS   3 /* Default */
> >  
> > +typedef struct CXLMemECSFRUReadAttrs {
> > +    uint8_t ecs_cap;
> > +    uint16_t ecs_config;
> > +    uint8_t ecs_flags;
> > +} QEMU_PACKED CXLMemECSFRUReadAttrs;
> > +
> > +typedef struct CXLMemECSReadAttrs {
> > +    uint8_t ecs_log_cap;
> > +    CXLMemECSFRUReadAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
> > +} QEMU_PACKED CXLMemECSReadAttrs;
> > +
> > +typedef struct CXLMemECSFRUWriteAttrs {
> > +    uint16_t ecs_config;
> > +} QEMU_PACKED CXLMemECSFRUWriteAttrs;
> > +
> > +typedef struct CXLMemECSWriteAttrs {
> > +    uint8_t ecs_log_cap;
> > +    CXLMemECSFRUWriteAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
> > +} QEMU_PACKED CXLMemECSWriteAttrs;
> > +
> >  #define DCD_MAX_NUM_REGION 8
> >  
> >  typedef struct CXLDCExtentRaw {
> > @@ -609,8 +617,8 @@ struct CXLType3Dev {
> >      CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
> >      CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
> >      /* ECS control attributes */
> > -    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
> > -    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
> > +    CXLMemECSReadAttrs ecs_attrs;
> > +    CXLMemECSWriteAttrs ecs_wr_attrs;
> >  
> >      struct dynamic_capacity {
> >          HostMemoryBackend *host_dc;  
> 
> 

