Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51793C61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBVRxw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 12:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBVRxw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 12:53:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4D28854
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 09:53:49 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMNtz27Klz6J6YC;
        Thu, 23 Feb 2023 01:48:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 17:53:46 +0000
Date:   Wed, 22 Feb 2023 17:53:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathie?= =?ISO-8859-1?Q?u-Daud=E9?= 
        <philmd@linaro.org>, Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH 4/6] hw/cxl: QMP based poison injection support
Message-ID: <20230222175345.000041bc@Huawei.com>
In-Reply-To: <63f56c5d6b269_1dc7bb2947c@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
        <20230217181812.26995-5-Jonathan.Cameron@huawei.com>
        <63f56c5d6b269_1dc7bb2947c@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Feb 2023 17:14:05 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > Inject poison using qmp command cxl-inject-poison to add an entry to the
> > poison list.
> > 
> > For now, the poison is not returned CXL.mem reads, but only via the
> > mailbox command Get Poison List.
> > 
> > See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> > 
> > Kernel patches to use this interface here:
> > https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> > 
> > To inject poison using qmp (telnet to the qmp port)
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-inject-poison",
> >     "arguments": {
> >          "path": "/machine/peripheral/cxl-pmem0",
> >          "start": 2048,
> >          "length": 256
> >     }
> > }
> > 
> > Adjusted to select a device on your machine.
> > 
> > Note that the poison list supported is kept short enough to avoid the
> > complexity of state machine that is needed to handle the MORE flag.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > v3:
> > Improve QMP documentation.
> > 
> > v2:
> > Moved to QMP to allow for single command.
> > Update reference in coverletter
> > Added specific setting of type for this approach to injection.
> > Drop the unnecessary ct3d class get_poison_list callback.
> > Block overlapping regions from being injected
> > Handle list overflow
> > Use Ira's utility function to get the timestamps
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |  3 ++
> >  hw/mem/meson.build          |  2 +
> >  include/hw/cxl/cxl_device.h | 20 +++++++++
> >  qapi/cxl.json               | 16 ++++++++
> >  6 files changed, 179 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 580366ed2f..cf3cfb10a1 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -62,6 +62,8 @@ enum {
> >          #define GET_PARTITION_INFO     0x0
> >          #define GET_LSA       0x2
> >          #define SET_LSA       0x3
> > +    MEDIA_AND_POISON = 0x43,
> > +        #define GET_POISON_LIST        0x0
> >  };
> >  
> >  struct cxl_cmd;
> > @@ -267,6 +269,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
> >      id->persistent_capacity = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
> >      id->volatile_capacity = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
> >      id->lsa_size = cvc->get_lsa_size(ct3d);
> > +    id->poison_list_max_mer[1] = 0x1; /* 256 poison records */  
> 
> Using st24_le_p() would be more robust I think.

Ah the wonder of patch reordering. The patch adding that was after this is my queue.
I'll pull it down to before here so we can use it.

There are a bunch of endian issues around here (such as the lsa_size just above
this) but good not to introduce a new one.

I'll circle back around to clean the rest up at a later date.


> 
> > +    id->inject_poison_limit = 0; /* No limit - so limited by main poison record limit */
> >  
> >      *len = sizeof(*id);
> >      return CXL_MBOX_SUCCESS;
> > @@ -356,6 +360,82 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * This is very inefficient, but good enough for now!
> > + * Also the payload will always fit, so no need to handle the MORE flag and
> > + * make this stateful. We may want to allow longer poison lists to aid
> > + * testing that kernel functionality.
> > + */
> > +static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
> > +                                            CXLDeviceState *cxl_dstate,
> > +                                            uint16_t *len)
> > +{
> > +    struct get_poison_list_pl {
> > +        uint64_t pa;
> > +        uint64_t length;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_poison_list_out_pl {
> > +        uint8_t flags;
> > +        uint8_t rsvd1;
> > +        uint64_t overflow_timestamp;
> > +        uint16_t count;
> > +        uint8_t rsvd2[0x14];
> > +        struct {
> > +            uint64_t addr;
> > +            uint32_t length;
> > +            uint32_t resv;
> > +        } QEMU_PACKED records[];
> > +    } QEMU_PACKED;
> > +
> > +    struct get_poison_list_pl *in = (void *)cmd->payload;
> > +    struct get_poison_list_out_pl *out = (void *)cmd->payload;
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +    uint16_t record_count = 0, i = 0;
> > +    uint64_t query_start = in->pa;  
> 
> Should we verify Bits[5:0] are 0?

Yes, plus looking again at this code, it needs a bunch of le handling like
all the other mailbox commands.  In the interests of not making that worse
I'll fix this one up whilst we are here.

> 
> > +    uint64_t query_length = in->length;  
> 
> Isn't in->length in units of 64bytes?  Does that get converted somewhere?
Good spot. I guess all my test values happen to be small so I never noticed.
Clearly need to update those!



> 
> > +    CXLPoisonList *poison_list = &ct3d->poison_list;
> > +    CXLPoison *ent;
> > +    uint16_t out_pl_len;
> > +
> > +    QLIST_FOREACH(ent, poison_list, node) {
> > +        /* Check for no overlap */
> > +        if (ent->start >= query_start + query_length ||
> > +            ent->start + ent->length <= query_start) {
> > +            continue;
> > +        }
> > +        record_count++;
> > +    }
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    memset(out, 0, out_pl_len);
> > +    QLIST_FOREACH(ent, poison_list, node) {
> > +        uint64_t start, stop;
> > +
> > +        /* Check for no overlap */
> > +        if (ent->start >= query_start + query_length ||
> > +            ent->start + ent->length <= query_start) {
> > +            continue;
> > +        }
> > +
> > +        /* Deal with overlap */
> > +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> > +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> > +                   query_start + query_length);
> > +        out->records[i].addr = start | (ent->type & 0x3);  
> 
> cpu_to_le64()?
> 
> > +        out->records[i].length = (stop - start) / 64;  
> 
> cpu_to_le32()?

yup. Though I'll use stw_le_p() etc

Usual problem of when you've looked at code too many times you forget
the newer issues identified in other patches that apply here.

Oh for that big endian CXL emulated machine to make all these
stand out in spectacular fashion.

> 
> > +        i++;
> > +    }
> > +    if (ct3d->poison_list_overflowed) {
> > +        out->flags = (1 << 1);
> > +        out->overflow_timestamp = ct3d->poison_list_overflow_ts;  
> 
> cpu_to_le64()?
> 
> > +    }
> > +    out->count = record_count;
> > +    *len = out_pl_len;
> > +    return CXL_MBOX_SUCCESS;
> > +}

...

> >  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 8b7727a75b..3585f78b4e 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -925,6 +925,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,

> > +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> > +                           Error **errp)
> > +{
> > +    Object *obj = object_resolve_path(path, NULL);
> > +    CXLType3Dev *ct3d;
> > +    CXLPoison *p;
> > +
> > +    if (length % 64) {
> > +        error_setg(errp, "Poison injection must be in multiples of 64 bytes");
> > +        return;
> > +    }

Relevant to below response.  Length is 64 byte aligned, not to be multiplied by
64 (unlike the CXL commands).

...
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index b6b51ced54..6055190ca6 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -2,6 +2,9 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/qapi-commands-cxl.h"
> >  
> > +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> > +                           Error **errp) {}

Added an error_setg()  inline with Philippe's feedback.

> > +
> >  void qmp_cxl_inject_uncorrectable_errors(const char *path,
> >                                           CXLUncorErrorRecordList *errors,
> >                                           Error **errp) {}
> > diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> > index 56c2618b84..930c67e390 100644
> > --- a/hw/mem/meson.build
> > +++ b/hw/mem/meson.build
> > @@ -10,3 +10,5 @@ softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
> >  softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
> >  
> >  softmmu_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
> > +softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
> > +softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))

Gah. Rebase error. This is duplicated.

> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index ac7e167fa2..bc099d695e 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -5,6 +5,22 @@
> >  # = CXL devices
> >  ##
> >  
> > +##
> > +# @cxl-inject-poison:
> > +#
> > +# Poison records indicate that a CXL memory device knows that a particular
> > +# memory region may be corrupted. This may be because of locally detected
> > +# errors (e.g. ECC failure) or poisoned writes received from other components
> > +# in the system. This injection mechanism enables testing of the OS handling
> > +# of poison records which may be queried via the CXL mailbox.
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +# @start: Start address  
> 
> NIT: "Must be 64 bytes aligned."
> 
> > +# @length: Length of poison to inject  
> 
> NIT: "Must be in multiples of 64 bytes."
Must be an integer multiple of.  I decided the CXL convention of
* 64 was not intuitive so at least for the qapi I can use real numbers!
> 
> Ira

Thanks for your feedback - very useful! Also makes it clear I need
to do a scrub of all the mailbox commands to ensure little endian
setters and getters are used.

Some other changes coming from Philippe's review of the AER set
may affect this so those will have to come to a conclusion before
I post v2.

Thanks,

Jonathan
> 
> > +##
> > +{ 'command': 'cxl-inject-poison',
> > +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> > +
> >  ##
> >  # @CxlUncorErrorType:
> >  #
> > -- 
> > 2.37.2
> >   
> 
> 

