Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6788AC3DA7D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjACSH3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjACSHZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 13:07:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E68FCE9
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 10:07:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NmgYr3g6Yz6801v;
        Wed,  4 Jan 2023 02:02:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 18:07:20 +0000
Date:   Tue, 3 Jan 2023 18:07:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 8/8] hw/cxl/events: Add in inject general media event
Message-ID: <20230103180719.00006437@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-8-2ce2ecc06219@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:38 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> To facilitate testing provide a QMP command to inject a general media
> event.  The event can be added to the log specified.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Hi Ira,

Suggestion inline on how to more neatly handle optional arguments using
QMPs inbuilt handling.  Short version is stick a * in front of the
argument name in the json and you get a bonus parameter in the callback
bool has_<name> which lets you identify if it is provided or not.

Jonathan

> 
> ---
> Changes from RFC:
> 	Add all fields for this event
> 	irq happens automatically when log transitions from 0 to 1
> ---
>  hw/mem/cxl_type3.c          | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  8 ++++
>  include/hw/cxl/cxl_events.h | 20 ++++++++++
>  qapi/cxl.json               | 25 ++++++++++++
>  4 files changed, 146 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a43949cab120..bedd09e500ba 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -916,6 +916,99 @@ static CXLPoisonList *get_poison_list(CXLType3Dev *ct3d)
>      return &ct3d->poison_list;
>  }
>  
> +static void cxl_assign_event_header(struct cxl_event_record_hdr *hdr,
> +                                    QemuUUID *uuid, uint8_t flags,
> +                                    uint8_t length)
> +{
> +    hdr->flags[0] = flags;
> +    hdr->length = length;
> +    memcpy(&hdr->id, uuid, sizeof(hdr->id));
> +    hdr->timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +QemuUUID gen_media_uuid = {
> +    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> +                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +};
> +
> +#define CXL_GMER_VALID_CHANNEL                          BIT(0)
> +#define CXL_GMER_VALID_RANK                             BIT(1)
> +#define CXL_GMER_VALID_DEVICE                           BIT(2)
> +#define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +
> +/*
> + * For channel, rank, and device; any value inside of the fields valid range
> + * will flag that field to be valid.  IE pass -1 to mark the field invalid.
> + *
> + * Component ID is device specific.  Define this as a string.
> + */
> +void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
> +                                    uint8_t flags, uint64_t physaddr,
> +                                    uint8_t descriptor, uint8_t type,
> +                                    uint8_t transaction_type,
> +                                    int16_t channel, int16_t rank,
> +                                    int32_t device,
> +                                    const char *component_id,
> +                                    Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    struct cxl_event_gen_media gem;
> +    struct cxl_event_record_hdr *hdr = &gem.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint16_t valid_flags = 0;
> +
> +    if (log >= CXL_EVENT_TYPE_MAX) {
> +        error_setg(errp, "Invalid log type: %d", log);
> +        return;
> +    }
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +    }
> +    ct3d = CXL_TYPE3(obj);
> +    cxlds = &ct3d->cxl_dstate;
> +
> +    memset(&gem, 0, sizeof(gem));
> +    cxl_assign_event_header(hdr, &gen_media_uuid, flags,
> +                            sizeof(struct cxl_event_gen_media));
> +
> +    gem.phys_addr = physaddr;
> +    gem.descriptor = descriptor;
> +    gem.type = type;
> +    gem.transaction_type = transaction_type;
> +
> +    if (0 <= channel && channel <= 0xFF) {
> +        gem.channel = channel;
> +        valid_flags |= CXL_GMER_VALID_CHANNEL;
> +    }
> +
> +    if (0 <= rank && rank <= 0xFF) {
> +        gem.rank = rank;
> +        valid_flags |= CXL_GMER_VALID_RANK;
> +    }
> +
> +    if (0 <= device && device <= 0xFFFFFF) {
> +        st24_le_p(gem.device, device);
> +        valid_flags |= CXL_GMER_VALID_DEVICE;
> +    }
> +
> +    if (component_id && strcmp(component_id, "")) {
> +        strncpy((char *)gem.component_id, component_id,
> +                sizeof(gem.component_id) - 1);
> +        valid_flags |= CXL_GMER_VALID_COMPONENT;
> +    }
> +
> +    stw_le_p(gem.validity_flags, valid_flags);
> +
> +    if (cxl_event_insert(cxlds, log, (struct cxl_event_record_raw *)&gem)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index f2c9f48f4010..62f04d487031 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -2,6 +2,14 @@
>  #include "qemu/osdep.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
> +                                    uint8_t flags, uint64_t physaddr,
> +                                    uint8_t descriptor, uint8_t type,
> +                                    uint8_t transaction_type,
> +                                    int16_t channel, int16_t rank,
> +                                    int32_t device,
> +                                    char *component_id,
> +                                    Error **errp) {}
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp) {}
>  void qmp_cxl_inject_uncorrectable_error(const char *path,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 2df40720320a..3175e9d9866d 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -103,4 +103,24 @@ struct cxl_event_interrupt_policy {
>  /* DCD is optional but other fields are not */
>  #define CXL_EVENT_INT_SETTING_MIN_LEN 4
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +struct cxl_event_gen_media {
> +    struct cxl_event_record_hdr hdr;
> +    uint64_t phys_addr;
> +    uint8_t descriptor;
> +    uint8_t type;
> +    uint8_t transaction_type;
> +    uint8_t validity_flags[2];
> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t device[3];
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> +} QEMU_PACKED;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index b4836bb87f53..56e85a28d7e0 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,31 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-gen-media-event:
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @physaddr: Physical Address
> +# @descriptor: Descriptor
> +# @type: Type
> +# @transactiontype: Transaction Type
> +# @channel: Channel
> +# @rank: Rank
> +# @device: Device
> +# @componentid: Device specific string
> +#
> +##
> +{ 'command': 'cxl-inject-gen-media-event',
> +  'data': { 'path': 'str', 'log': 'uint8', 'flags': 'uint8',
> +            'physaddr': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transactiontype': 'uint8',
> +            'channel': 'int16', 'rank': 'int16',
> +            'device': 'int32', 'componentid': 'str'
> +            }}

From an interface cleanliness point of view I'd rather see
all the optional fields as optional.  That's done by marking them
with a * so
'*channel': 'int16'

Then the signature of the related qmp_cxl_inject_gen_media_event
gains a boolean has_channel parameter (before channel)

Those booleans can be used to set the flags etc.

Very lightly tested: 

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4660a44ef8..cb9bb0b166 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1203,8 +1203,9 @@ void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
                                     uint8_t flags, uint64_t physaddr,
                                     uint8_t descriptor, uint8_t type,
                                     uint8_t transaction_type,
-                                    int16_t channel, int16_t rank,
-                                    int32_t device,
+                                    bool has_channel, uint8_t channel,
+                                    bool has_rank, uint8_t rank,
+                                    bool has_device, uint32_t device,
                                     const char *component_id,
                                     Error **errp)
 {
@@ -1238,22 +1239,22 @@ void qmp_cxl_inject_gen_media_event(const char *path, uint8_t log,
     gem.type = type;
     gem.transaction_type = transaction_type;

-    if (0 <= channel && channel <= 0xFF) {
+    if (has_channel) {
         gem.channel = channel;
         valid_flags |= CXL_GMER_VALID_CHANNEL;
     }

-    if (0 <= rank && rank <= 0xFF) {
+    if (has_rank) {
         gem.rank = rank;
         valid_flags |= CXL_GMER_VALID_RANK;
     }

-    if (0 <= device && device <= 0xFFFFFF) {
+    if (has_device) {
         st24_le_p(gem.device, device);
         valid_flags |= CXL_GMER_VALID_DEVICE;
     }

-    if (component_id && strcmp(component_id, "")) {
+    if (component_id) {
        strncpy((char *)gem.component_id, component_id,
                 sizeof(gem.component_id) - 1);
         valid_flags |= CXL_GMER_VALID_COMPONENT;
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 56e85a28d7..085f82e7da 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -26,8 +26,8 @@
   'data': { 'path': 'str', 'log': 'uint8', 'flags': 'uint8',
             'physaddr': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transactiontype': 'uint8',
-            'channel': 'int16', 'rank': 'int16',
-            'device': 'int32', 'componentid': 'str'
+            '*channel': 'uint8', '*rank': 'uint8',
+            '*device': 'uint32', '*componentid': 'str'
             }}

 ##

> +
>  ##
>  # @cxl-inject-poison:
>  #
> 

