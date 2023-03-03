Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719BFC678D4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 11:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCCLqI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCCLqH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 06:46:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155423DA8
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 03:46:04 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSmJH07nrz6J7qq;
        Fri,  3 Mar 2023 19:41:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 11:46:01 +0000
Date:   Fri, 3 Mar 2023 11:46:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <20230303114600.0000149f@Huawei.com>
In-Reply-To: <64004462d4dec_3a6b5294bc@iweiny-mobl.notmuch>
References: <20230227173416.7740-1-Jonathan.Cameron@huawei.com>
        <20230227173416.7740-7-Jonathan.Cameron@huawei.com>
        <64004462d4dec_3a6b5294bc@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Mar 2023 22:38:26 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> > provides information related to DRAM devices.
> > 
> > Example injection command in QMP:
> > 
> > { "execute": "cxl-inject-dram-event",
> >     "arguments": {
> >         "path": "/machine/peripheral/cxl-mem0",
> >         "log": "informational",
> >         "flags": 1,
> >         "physaddr": 1000,
> >         "descriptor": 3,
> >         "type": 3,
> >         "transaction-type": 192,
> >         "channel": 3,
> >         "rank": 17,
> >         "nibble-mask": 37421234,
> >         "bank-group": 7,
> >         "bank": 11,
> >         "row": 2,
> >         "column": 77,
> >         "correction-mask": [33, 44, 55,66]
> >     }}
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/mem/cxl_type3.c          | 115 ++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |  13 ++++
> >  include/hw/cxl/cxl_events.h |  23 ++++++++
> >  qapi/cxl.json               |  35 +++++++++++
> >  4 files changed, 186 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 5d55943df2..cff5341b7b 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1167,6 +1167,11 @@ static const QemuUUID gen_media_uuid = {
> >                   0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> >  };
> >  
> > +static const QemuUUID dram_uuid = {
> > +    .data = UUID(0x601dcbb3, 0x9c06, 0x4eab, 0xb8, 0xaf,
> > +                 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> > +};
> > +
> >  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
> >  #define CXL_GMER_VALID_RANK                             BIT(1)
> >  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> > @@ -1262,6 +1267,116 @@ void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
> >      }
> >  }
> >  
> > +#define CXL_DRAM_VALID_CHANNEL                          BIT(0)
> > +#define CXL_DRAM_VALID_RANK                             BIT(1)
> > +#define CXL_DRAM_VALID_NIBBLE_MASK                      BIT(2)
> > +#define CXL_DRAM_VALID_BANK_GROUP                       BIT(3)
> > +#define CXL_DRAM_VALID_BANK                             BIT(4)
> > +#define CXL_DRAM_VALID_ROW                              BIT(5)
> > +#define CXL_DRAM_VALID_COLUMN                           BIT(6)
> > +#define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)emacs 
> > +
> > +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> > +                               uint64_t physaddr, uint8_t descriptor,
> > +                               uint8_t type, uint8_t transaction_type,
> > +                               bool has_channel, uint8_t channel,
> > +                               bool has_rank, uint8_t rank,
> > +                               bool has_nibble_mask, uint32_t nibble_mask,
> > +                               bool has_bank_group, uint8_t bank_group,
> > +                               bool has_bank, uint8_t bank,
> > +                               bool has_row, uint32_t row,
> > +                               bool has_column, uint16_t column,
> > +                               bool has_correction_mask, uint64List *correction_mask,
> > +                               Error **errp)
> > +{
> > +    Object *obj = object_resolve_path(path, NULL);
> > +    CXLEventDram dram;
> > +    CXLEventRecordHdr *hdr = &dram.hdr;
> > +    CXLDeviceState *cxlds;
> > +    CXLType3Dev *ct3d;
> > +    uint16_t valid_flags = 0;
> > +    uint8_t enc_log;
> > +    int rc;
> > +
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve path");
> > +        return;
> > +    }
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> > +        error_setg(errp, "Path does not point to a CXL type 3 device");
> > +        return;
> > +    }
> > +    ct3d = CXL_TYPE3(obj);
> > +    cxlds = &ct3d->cxl_dstate;
> > +
> > +    rc = ct3d_qmp_cxl_event_log_enc(log);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Unhandled error log type");
> > +        return;
> > +    }
> > +    enc_log = rc;
> > +
> > +    memset(&dram, 0, sizeof(dram));
> > +    cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram));
> > +    dram.phys_addr = physaddr;  
> 
> I know I did not do this either but now that the devices can be volatile
> memory; Should we try and set the Volatile bit based on the address
> provided?
> 
> Or should we just allow the bits to be set by the user for testing?  I
> think this is what I originally thought but given the new functionality it
> may be best to make this more 'real'?

Good question.  I can see two ways we could improve this.
1) Mask off the volatile bit and replace it - though if we are doing this I
   think we need to break out the remaining flags. In this case that's just
   DPA not repairable flag so far.   That then means we have to keep extending
   the interface to include new flags that are defined in remaining reserved bits.
   (not nice)
2) Check what flag is passed in and return an error if the flag isn't set
   correctly (maybe we can warn?)

Option 3: Assume anyone using this interface isn't going to shoot themselves
in the foot and laugh if they do ;)

We currently allow them to set a bunch of flags that might not be true and could
confuse software as they should line up with something else...
* Poison list overflow.  We can probably tie in autogeneration of that event
  in a future patch set.
* Threshold event. 
* Invalid access.  Another one that we can generate from the condition (future work)

So I'm planning to leave this for now and tighten up later.
I don't think we should worry about backwards compatiblity around
better detection of invalid error injection and some of the cases are complex
so we might never do them, instead relying on correct tests.

Jonathan

 
> 
> Either way:
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > +    dram.descriptor = descriptor;
> > +    dram.type = type;
> > +    dram.transaction_type = transaction_type;
> > +
> > +    if (has_channel) {
> > +        dram.channel = channel;
> > +        valid_flags |= CXL_DRAM_VALID_CHANNEL;
> > +    }
> > +
> > +    if (has_rank) {
> > +        dram.rank = rank;
> > +        valid_flags |= CXL_DRAM_VALID_RANK;
> > +    }
> > +
> > +    if (has_nibble_mask) {
> > +        st24_le_p(dram.nibble_mask, nibble_mask);
> > +        valid_flags |= CXL_DRAM_VALID_NIBBLE_MASK;
> > +    }
> > +
> > +    if (has_bank_group) {
> > +        dram.bank_group = bank_group;
> > +        valid_flags |= CXL_DRAM_VALID_BANK_GROUP;
> > +    }
> > +
> > +    if (has_bank) {
> > +        dram.bank = bank;
> > +        valid_flags |= CXL_DRAM_VALID_BANK;
> > +    }
> > +
> > +    if (has_row) {
> > +        st24_le_p(dram.row, row);
> > +        valid_flags |= CXL_DRAM_VALID_ROW;
> > +    }
> > +
> > +    if (has_column) {
> > +        stw_le_p(&dram.column, column);
> > +        valid_flags |= CXL_DRAM_VALID_COLUMN;
> > +    }
> > +
> > +    if (has_correction_mask) {
> > +        int count = 0;
> > +        while (correction_mask && count < 4) {
> > +            stq_le_p(&dram.correction_mask[count],
> > +                     correction_mask->value);
> > +            count++;
> > +            correction_mask = correction_mask->next;
> > +        }
> > +        valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
> > +    }
> > +
> > +    stw_le_p(&dram.validity_flags, valid_flags);
> > +
> > +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
> > +        cxl_event_irq_assert(ct3d);
> > +    }
> > +    return;
> > +}
> > +
> >  static void ct3_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> > diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> > index 55d19b0e03..235c171264 100644
> > --- a/hw/mem/cxl_type3_stubs.c
> > +++ b/hw/mem/cxl_type3_stubs.c
> > @@ -13,6 +13,19 @@ void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
> >                                      const char *component_id,
> >                                      Error **errp) {}
> >  
> > +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> > +                               uint64_t physaddr, uint8_t descriptor,
> > +                               uint8_t type, uint8_t transaction_type,
> > +                               bool has_channel, uint8_t channel,
> > +                               bool has_rank, uint8_t rank,
> > +                               bool has_nibble_mask, uint32_t nibble_mask,
> > +                               bool has_bank_group, uint8_t bank_group,
> > +                               bool has_bank, uint8_t bank,
> > +                               bool has_row, uint32_t row,
> > +                               bool has_column, uint16_t column,
> > +                               bool has_correction_mask, uint64List *correction_mask,
> > +                               Error **errp) {}
> > +
> >  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> >                             Error **errp)
> >  {
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index b189193f4c..a39e30d973 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -123,4 +123,27 @@ typedef struct CXLEventGenMedia {
> >      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> >  } QEMU_PACKED CXLEventGenMedia;
> >  
> > +/*
> > + * DRAM Event Record
> > + * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
> > + * All fields little endian.
> > + */
> > +typedef struct CXLEventDram {
> > +    CXLEventRecordHdr hdr;
> > +    uint64_t phys_addr;
> > +    uint8_t descriptor;
> > +    uint8_t type;
> > +    uint8_t transaction_type;
> > +    uint16_t validity_flags;
> > +    uint8_t channel;
> > +    uint8_t rank;
> > +    uint8_t nibble_mask[3];
> > +    uint8_t bank_group;
> > +    uint8_t bank;
> > +    uint8_t row[3];
> > +    uint16_t column;
> > +    uint64_t correction_mask[4];
> > +    uint8_t reserved[0x17];
> > +} QEMU_PACKED CXLEventDram;
> > +
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 4ec06c0335..32f340d972 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -55,6 +55,41 @@
> >              '*device': 'uint32', '*component-id': 'str'
> >              }}
> >  
> > +##
> > +# @cxl-inject-dram-event:
> > +#
> > +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> > +# This event type is reported via one of the event logs specified via
> > +# the log parameter.
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +# @log: Event Log to add the event to
> > +# @flags: header flags
> > +# @physaddr: Physical Address
> > +# @descriptor: Descriptor
> > +# @type: Type
> > +# @transaction-type: Transaction Type
> > +# @channel: Channel
> > +# @rank: Rank
> > +# @nibble-mask: Identify one or more nibbles that the error affects
> > +# @bank-group: Bank group
> > +# @bank: Bank
> > +# @row: Row
> > +# @column: Column
> > +# @correction-mask: Bits within each nibble. Used in order of bits set
> > +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> > +#
> > +# Since: 8.0
> > +##
> > +{ 'command': 'cxl-inject-dram-event',
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> > +            'physaddr': 'uint64', 'descriptor': 'uint8',
> > +            'type': 'uint8', 'transaction-type': 'uint8',
> > +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> > +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> > +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> > +           }}
> > +
> >  ##
> >  # @cxl-inject-poison:
> >  #
> > -- 
> > 2.37.2
> >   
> 
> 

