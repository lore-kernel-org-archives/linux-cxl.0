Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5771CA84
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064222; cv=none; b=PoRybjdzzl5uBKrJCPCxGUxtfZmGIcAPIsF/8GpvDkZ6xKFDkrs/O1jlp5nTsHJEtxPCZs95Ry4fbUxPj1Q5ue/BxKZoM5sGlLsBvSGbIyvQO1ZFX9dmy60DVXqXMQKlc60zCqf8t4JeUrRFa4TGP0BIR+iKsheQRGrP7tdhlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064222; c=relaxed/simple;
	bh=6V0aZxTqkvyH/gwEg750aD9ukzn2lQJYE7cV4gC32To=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPj2udQFwA6TaIac0tpYQaV2XcQyY7HrK+RghLpoLc41OW6g8DPgwNZJbmnIdb+l07lAj3lLDJQmL1CNr0hZGdmqBOhCX5k4HhSv3C+4VHhov14JhPIcod6fj4Tj93lWIBOxX5ePNZZFVDOiYdBs3/nEDjtNbmGEFK7upQXkSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzGpN2rHlz6GBRV;
	Thu, 20 Feb 2025 23:07:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D682140119;
	Thu, 20 Feb 2025 23:10:18 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 16:10:17 +0100
Date: Thu, 20 Feb 2025 15:10:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v3 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Message-ID: <20250220151016.00002536@huawei.com>
In-Reply-To: <20250220052724.1256642-2-vinayak.kh@samsung.com>
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
	<CGME20250220052734epcas5p2c0e082880350b5fa314c9062294bbc80@epcas5p2.samsung.com>
	<20250220052724.1256642-2-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Feb 2025 10:57:22 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> CXL devices supports media operations discovery command.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Hi Vinayak,

Rather than go around again, I've applied this to my CXL staging tree
with the following diff (comments inline below!)

Let me know if I messed up the changes (it wouldn't be the first time :()

Jonathan

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d401c68a38..167a87a7b1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1709,7 +1709,6 @@ enum {
     MEDIA_OP_CLASS_SANITIZE = 0x1,
         #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
         #define MEDIA_OP_SAN_SUBC_ZERO 0x1
-    MEDIA_OP_CLASS_MAX
 };

 struct media_op_supported_list_entry {
@@ -1745,31 +1744,25 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
             uint16_t num_ops;
         } discovery_osa;
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    struct media_op_discovery_out_pl *media_out_pl =
+        (struct media_op_discovery_out_pl *)payload_out;
+    int num_ops, start_index, i;
     int count = 0;
-    int num_ops = 0;
-    int start_index = 0;
-    int i = 0;
-    uint32_t dpa_range_count = 0;
-    struct media_op_discovery_out_pl *media_out_pl = NULL;

     if (len_in < sizeof(*media_op_in_disc_pl)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }

-    media_out_pl = (struct media_op_discovery_out_pl *)payload_out;
     num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
     start_index = media_op_in_disc_pl->discovery_osa.start_index;
-    dpa_range_count = media_op_in_disc_pl->dpa_range_count;

     /*
-     * As per spec CXL 3.2 8.2.10.9.5.3 dpa_range_count
-     * should be zero for discovery sub class command
+     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and start
+     * index should not exceed the total number of entries for discovery sub
+     * class command.
      */
-    if (dpa_range_count) {
-        return CXL_MBOX_INVALID_INPUT;
-    }
-
-    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+    if (media_op_in_disc_pl->dpa_range_count ||
+        start_index > ARRAY_SIZE(media_op_matrix)) {
         return CXL_MBOX_INVALID_INPUT;
     }

@@ -1790,8 +1783,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     }

     media_out_pl->num_of_supported_operations = count;
-    *len_out = sizeof(struct media_op_discovery_out_pl) +
-        (sizeof(struct media_op_supported_list_entry) * count);
+    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
     return CXL_MBOX_SUCCESS;
 }

> ---
>  hw/cxl/cxl-mailbox-utils.c | 133 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..f55a2fe614 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -89,6 +89,7 @@ enum {
>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
>      PERSISTENT_MEM = 0x45,
>          #define GET_SECURITY_STATE     0x0
>      MEDIA_AND_POISON = 0x43,
> @@ -1721,6 +1722,134 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +enum {
> +    MEDIA_OP_CLASS_GENERAL  = 0x0,
> +        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
> +    MEDIA_OP_CLASS_SANITIZE = 0x1,
> +        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
> +        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
> +    MEDIA_OP_CLASS_MAX
Not used.  So I'll drop this last entry.  We can bring it back
easily when we need it.
> +};
> +
> +struct media_op_supported_list_entry {
> +    uint8_t media_op_class;
> +    uint8_t media_op_subclass;
> +};
> +
> +struct media_op_discovery_out_pl {
> +    uint64_t dpa_range_granularity;
> +    uint16_t total_supported_operations;
> +    uint16_t num_of_supported_operations;
> +    struct media_op_supported_list_entry entry[];
> +} QEMU_PACKED;
> +
> +static const struct media_op_supported_list_entry media_op_matrix[] = {
> +    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
> +    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
> +    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
> +};
> +
> +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +        struct {
> +            uint16_t start_index;
> +            uint16_t num_ops;
> +        } discovery_osa;
> +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
> +    int count = 0;
> +    int num_ops = 0;
> +    int start_index = 0;
> +    int i = 0;
These values are always overwritten so no need to init.

> +    uint32_t dpa_range_count = 0;
This one is only used once so I'll switch to just using the
data directly.

> +    struct media_op_discovery_out_pl *media_out_pl = NULL;
Might as well set this initially.
> +
> +    if (len_in < sizeof(*media_op_in_disc_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    media_out_pl = (struct media_op_discovery_out_pl *)payload_out;
> +    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
> +    start_index = media_op_in_disc_pl->discovery_osa.start_index;
> +    dpa_range_count = media_op_in_disc_pl->dpa_range_count;
> +
> +    /*
> +     * As per spec CXL 3.2 8.2.10.9.5.3 dpa_range_count

For local consistency used r3.2 
I theory the spec has a revision and a version though published
specs are all version 1.0

> +     * should be zero for discovery sub class command
> +     */
> +    if (dpa_range_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
> +        return CXL_MBOX_INVALID_INPUT;

I've read the spec again and think I was wrong last time :(
I believe it is only the start_index that we need to check.,
If the end is beyond what was requested we just return fewer.
Sorry about that!

I'll fix that up and change the comment above to also talk about this.
As these two checks are based on same sentence in the spec I'll
combine them using ||

> +    }
> +
> +    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
> +    media_out_pl->total_supported_operations =
> +                                     ARRAY_SIZE(media_op_matrix);
> +    if (num_ops > 0) {
> +        for (i = start_index; i < start_index + num_ops; i++) {
> +            media_out_pl->entry[count].media_op_class =
> +                    media_op_matrix[i].media_op_class;
> +            media_out_pl->entry[count].media_op_subclass =
> +                        media_op_matrix[i].media_op_subclass;
> +            count++;
> +            if (count == num_ops) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    media_out_pl->num_of_supported_operations = count;
> +    *len_out = sizeof(struct media_op_discovery_out_pl) +
> +        (sizeof(struct media_op_supported_list_entry) * count);
For this we can use the more compact
   *len_out = sizeof(*media_out_pl) + sizeof(*media_out_pl->entry) * count;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
> +                                       uint8_t *payload_in,
> +                                       size_t len_in,
> +                                       uint8_t *payload_out,
> +                                       size_t *len_out,
> +                                       CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
> +    uint8_t media_op_cl = 0;
> +    uint8_t media_op_subclass = 0;
> +
> +    if (len_in < sizeof(*media_op_in_common_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    media_op_cl = media_op_in_common_pl->media_operation_class;
> +    media_op_subclass = media_op_in_common_pl->media_operation_subclass;
> +
> +    switch (media_op_cl) {
> +    case MEDIA_OP_CLASS_GENERAL:
> +        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        return media_operations_discovery(payload_in, len_in, payload_out,
> +                                             len_out);
> +    default:
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +}
> +
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -2864,6 +2993,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>           CXL_MBOX_SECURITY_STATE_CHANGE |
>           CXL_MBOX_BACKGROUND_OPERATION |
>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
> +    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
> +        ~0,
> +        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> +         CXL_MBOX_BACKGROUND_OPERATION)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",

