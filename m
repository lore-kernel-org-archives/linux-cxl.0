Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FC2222CC
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756253; cv=none; b=a1dfAqGo6Cdtwu1BqdD6aa7ooyn/HKKaJFcp/0kFKJ3MOW94GPZsApjcJ/YGr0nUZh/I8BWw2+dRu9E7kKUTQQbANQaDHQCdepL+/fpU0PJnr8wai+q5H5t4tZ/nSEUF2oU9ICfxNWp4P52GigsN6EiFEIyp5W0soz7FRuYEujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756253; c=relaxed/simple;
	bh=bPv9A6AUq4toDyl7NuYqUjo0wTN2mB0tseLiMFzysSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DsOaoWQtKJ/Ukruz8MhMeX4qRunsrxru09qrEf78roU0sLu6fksHXk2UOjAs56jMj+RCbkcF+7l7+BpusPlcxQBDjV6KRFi3NaQXg1g7OYs0q3pK81BBsSSClcRPvBPFaRp0tDfMRoYq7UjOlUzn8uJoAI+Dv1mRaOR93sdsqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRJvT4s49z6DL8R;
	Tue, 24 Jun 2025 17:05:41 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 874D11400E3;
	Tue, 24 Jun 2025 17:10:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 11:10:40 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 24 Jun 2025 11:10:40 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Topic: [PATCH v2 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Index: AQHb4S0pyT9Bh5jYhkiiq+FJvwyov7QL9GAAgAYYPRA=
Date: Tue, 24 Jun 2025 09:10:40 +0000
Message-ID: <319046dde35b415eae3d534323102128@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
	<20250619151619.1695-2-shiju.jose@huawei.com>
 <20250620150342.000055aa@huawei.com>
In-Reply-To: <20250620150342.000055aa@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 20 June 2025 15:04
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH v2 1/7] hw/cxl/events: Update for rev3.2 common event
>record format
>
>On Thu, 19 Jun 2025 16:16:13 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record format
>> has updated with Maintenance Operation Subclass, LD ID and ID of the
>> device head information.
>Hi Shiju,
>
>Wrap a little longer - this is sub 70 and should aim for about 75 for comm=
it
>descriptions.
>
>>
>> Add updates for the above spec changes in the related CXL events
>> reporting and QMP command to inject CXL events.
>
>Main comment in here is we need to keep these new parameters as optional a=
s
>we shouldn't go adding required stuff to qapi and perhaps more importantly
>they are actually optional for most events.
>

Hi Jonathan,

Thanks for the feedback.=20
I will change these parameters as optional in qapi  as you suggested.=20

Thanks,
Shiju

>Jonathan
>
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c index
>> b5482f58a3..0787a9bfca 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -1780,12 +1780,18 @@ void qmp_cxl_inject_correctable_error(const
>> char *path, CxlCorErrorType type,
>>
>>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>>                               const QemuUUID *uuid, uint32_t flags,
>> -                             uint8_t length, uint64_t timestamp)
>> +                             uint8_t length, uint64_t timestamp,
>> +                             uint8_t maint_class, uint8_t maint_subclas=
s,
>> +                             uint16_t ld_id, uint8_t head_id)
>>  {
>>      st24_le_p(&hdr->flags, flags);
>>      hdr->length =3D length;
>>      memcpy(&hdr->id, uuid, sizeof(hdr->id));
>>      stq_le_p(&hdr->timestamp, timestamp);
>> +    hdr->maint_op_class =3D maint_class;
>> +    hdr->maint_op_subclass =3D maint_subclass;
>> +    hdr->ld_id =3D ld_id;
>2 bytes so
>
>       stw_le_p(&hdr->ld_id, ld_id);
>
>> +    hdr->head_id =3D head_id;
>>  }
>>
>>  static const QemuUUID gen_media_uuid =3D { @@ -1825,7 +1831,9 @@ static
>> int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)  }
>>  /* Component ID is device specific.  Define this as a string. */
>> void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog lo=
g,
>> -                                        uint8_t flags, uint64_t dpa,
>> +                                        uint32_t flags, uint8_t class,
>> +                                        uint8_t subclass, uint16_t ld_i=
d,
>> +                                        uint8_t head_id, uint64_t
>> + dpa,
>>                                          uint8_t descriptor, uint8_t typ=
e,
>>                                          uint8_t transaction_type,
>>                                          bool has_channel, uint8_t
>> channel, @@ -1863,7 +1871,8 @@ void
>> qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>>
>>      memset(&gem, 0, sizeof(gem));
>>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
>> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
);
>> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
,
>> +                            class, subclass, ld_id, head_id);
>>
>>      stq_le_p(&gem.phys_addr, dpa);
>>      gem.descriptor =3D descriptor;
>> @@ -1907,7 +1916,9 @@ void qmp_cxl_inject_general_media_event(const
>char *path, CxlEventLog log,
>>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>>
>> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>> uint8_t flags,
>> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint3=
2_t
>flags,
>> +                               uint8_t class, uint8_t subclass,
>> +                               uint16_t ld_id, uint8_t head_id,
>>                                 uint64_t dpa, uint8_t descriptor,
>>                                 uint8_t type, uint8_t transaction_type,
>>                                 bool has_channel, uint8_t channel, @@
>> -1950,7 +1961,8 @@ void qmp_cxl_inject_dram_event(const char *path,
>> CxlEventLog log, uint8_t flags,
>>
>>      memset(&dram, 0, sizeof(dram));
>>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
>> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
);
>> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
,
>> +                            class, subclass, ld_id, head_id);
>>      stq_le_p(&dram.phys_addr, dpa);
>>      dram.descriptor =3D descriptor;
>>      dram.type =3D type;
>> @@ -2010,7 +2022,9 @@ void qmp_cxl_inject_dram_event(const char *path,
>> CxlEventLog log, uint8_t flags,  }
>>
>>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog
>log,
>> -                                        uint8_t flags, uint8_t type,
>> +                                        uint32_t flags, uint8_t class,
>> +                                        uint8_t subclass, uint16_t ld_i=
d,
>> +                                        uint8_t head_id, uint8_t
>> + type,
>>                                          uint8_t health_status,
>>                                          uint8_t media_status,
>>                                          uint8_t additional_status, @@
>> -2049,7 +2063,8 @@ void qmp_cxl_inject_memory_module_event(const char
>> *path, CxlEventLog log,
>>
>>      memset(&module, 0, sizeof(module));
>>      cxl_assign_event_header(hdr, &memory_module_uuid, flags,
>sizeof(module),
>> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
);
>> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate)=
,
>> +                            class, subclass, ld_id, head_id);
>>
>>      module.type =3D type;
>>      module.health_status =3D health_status; @@ -2284,7 +2299,8 @@
>> static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *pa=
th,
>>       * Event Log.
>>       */
>>      cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(=
dCap),
>> -                            cxl_device_get_timestamp(&dcd->cxl_dstate))=
;
>> +                            cxl_device_get_timestamp(&dcd->cxl_dstate),
>> +                            0, 0, 0, 0);
>As below - we'll need to pass in the validity flags as well for subclass, =
ld-id and
>head-id  as we don't really want to do that bit of computing 'flags' at ea=
ch caller.
>
>>
>>      dCap.type =3D type;
>>      /* FIXME: for now, validity flag is cleared */ diff --git
>> a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c index
>> c1a5e4a7c1..263d8b4609 100644
>> --- a/hw/mem/cxl_type3_stubs.c
>> +++ b/hw/mem/cxl_type3_stubs.c
>> @@ -14,7 +14,9 @@
>>  #include "qapi/qapi-commands-cxl.h"
>>
>>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog l=
og,
>> -                                        uint8_t flags, uint64_t dpa,
>> +                                        uint32_t flags, uint8_t class,
>> +                                        uint8_t subclass, uint16_t ld_i=
d,
>> +                                        uint8_t head_id, uint64_t
>> + dpa,
>>                                          uint8_t descriptor, uint8_t typ=
e,
>>                                          uint8_t transaction_type,
>>                                          bool has_channel, uint8_t
>> channel, @@ -23,7 +25,9 @@ void
>qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>>                                          const char *component_id,
>>                                          Error **errp) {}
>>
>> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>> uint8_t flags,
>> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint3=
2_t
>flags,
>> +                               uint8_t class, uint8_t subclass,
>> +                               uint16_t ld_id, uint8_t head_id,
>>                                 uint64_t dpa, uint8_t descriptor,
>>                                 uint8_t type, uint8_t transaction_type,
>>                                 bool has_channel, uint8_t channel, @@
>> -38,7 +42,9 @@ void qmp_cxl_inject_dram_event(const char *path,
>CxlEventLog log, uint8_t flags,
>>                                 Error **errp) {}
>>
>>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog
>log,
>> -                                        uint8_t flags, uint8_t type,
>> +                                        uint32_t flags, uint8_t class,
>> +                                        uint8_t subclass, uint16_t ld_i=
d,
>> +                                        uint8_t head_id, uint8_t
>> + type,
>>                                          uint8_t health_status,
>>                                          uint8_t media_status,
>>                                          uint8_t additional_status,
>With suggestion below, this will gain bool has_xxx parameters like
>qmp_cxl_inject_general_media already has.
>
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index 831fdefbac..fc6ec82670 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -827,7 +827,9 @@ bool ct3_test_region_block_backed(CXLType3Dev
>*ct3d, uint64_t dpa,
>>                                    uint64_t len);  void
>> cxl_assign_event_header(CXLEventRecordHdr *hdr,
>>                               const QemuUUID *uuid, uint32_t flags,
>> -                             uint8_t length, uint64_t timestamp);
>> +                             uint8_t length, uint64_t timestamp,
>> +                             uint8_t maint_class, uint8_t maint_subclas=
s,
>> +                             uint16_t ld_id, uint8_t head_id);
>
>I think we need to add bools for the presence of maint_subclass, ld_id and
>head_id or we have to modify flags at each caller which is rather ugly.
>It's fine to just fill maint_class in with 0 if not set though as that has=
 no valid bit.
>
>>  bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
>>                                      uint64_t dpa, uint64_t len);
>> bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
>> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
>> index 758b075a64..4d9cfdb621 100644
>> --- a/include/hw/cxl/cxl_events.h
>> +++ b/include/hw/cxl/cxl_events.h
>> @@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
>>
>>  /*
>>   * Common Event Record Format
>> - * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
>> + * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
>>   */
>> -#define CXL_EVENT_REC_HDR_RES_LEN 0xf
>> +#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
>> +#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
>> +#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4) #define
>> +CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5) #define
>> +CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6) #define
>> +CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7) #define
>> +CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
>As below - here we have the 3 valid bits.
>
>>  typedef struct CXLEventRecordHdr {
>>      QemuUUID id;
>>      uint8_t length;
>> @@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
>>      uint16_t related_handle;
>>      uint64_t timestamp;
>>      uint8_t maint_op_class;
>> -    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
>> +    uint8_t maint_op_subclass;
>> +    uint16_t ld_id;
>> +    uint8_t head_id;
>> +    uint8_t reserved[0xb];
>>  } QEMU_PACKED CXLEventRecordHdr;
>>
>>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50 diff --git a/qapi/cxl.json
>> b/qapi/cxl.json index 8f2e9237b1..c38585d3c8 100644
>> --- a/qapi/cxl.json
>> +++ b/qapi/cxl.json
>> @@ -42,6 +42,18 @@
>>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>>  #     Record Format, Event Record Flags for subfield definitions.
>>  #
>> +# @class: Maintenance operation class the device requests to initiate.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @subclass: Maintenance operation subclass the device requests to
>> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @ld-id: LD ID of LD from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @head-id: ID of the device head from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>>  # @dpa: Device Physical Address (relative to @path device).  Note
>>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>>  #     Media Event Record, Physical Address.
>> @@ -73,7 +85,9 @@
>>  # Since: 8.1
>>  ##
>>  { 'command': 'cxl-inject-general-media-event',
>> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
>> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
>> +	    'class':'uint8', 'subclass':'uint8',
>> +	    'ld-id':'uint16', 'head-id':'uint8',
>
>This is a bit of a problem as we should maintain backwards compatibility.
>
>ld-id, head-id etc are optional anyway so should be "*ld-id" and we should=
 then
>check has_ld_id and set the valid bits appropriately.
>
>For class and subclass we should make them optional in this interface and =
follow
>the guidance to set them to 0 if they aren't explicitly set.
>Actually on closer inspection subclass is also optional and has a valid fl=
ag so the
>only one we are making optional in this interface that isn't in the spec i=
s class.
>
>Also good to use fuller name to make it clear these are about maintenance
>classes.  Maybe maint-op-class and maint-op-subclass
>
>Similar comments apply to the other cases.
>
>
>>              'dpa': 'uint64', 'descriptor': 'uint8',
>>              'type': 'uint8', 'transaction-type': 'uint8',
>>              '*channel': 'uint8', '*rank': 'uint8', @@ -93,6 +107,18
>> @@  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common
>> Event
>>  #     Record Format, Event Record Flags for subfield definitions.
>>  #
>> +# @class: Maintenance operation class the device requests to initiate.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @subclass: Maintenance operation subclass the device requests to
>> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @ld-id: LD ID of LD from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @head-id: ID of the device head from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>>  # @dpa: Device Physical Address (relative to @path device).  Note
>>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
>>  #     Event Record, Physical Address.
>> @@ -132,7 +158,9 @@
>>  # Since: 8.1
>>  ##
>>  { 'command': 'cxl-inject-dram-event',
>> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
>> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
>> +	    'class':'uint8', 'subclass':'uint8',
>> +	    'ld-id':'uint16', 'head-id':'uint8',
>
>>              'dpa': 'uint64', 'descriptor': 'uint8',
>>              'type': 'uint8', 'transaction-type': 'uint8',
>>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask':
>> 'uint32', @@ -154,6 +182,18 @@  # @flags: Event Record Flags.  See CXL
>> r3.0 Table 8-42 Common Event
>>  #     Record Format, Event Record Flags for subfield definitions.
>>  #
>> +# @class: Maintenance operation class the device requests to initiate.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @subclass: Maintenance operation subclass the device requests to
>> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @ld-id: LD ID of LD from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>> +# @head-id: ID of the device head from where the event originated.
>> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
>> +#
>>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>>  #     Event Record for bit definitions for bit definiions.
>>  #
>> @@ -184,7 +224,9 @@
>>  # Since: 8.1
>>  ##
>>  { 'command': 'cxl-inject-memory-module-event',
>> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
>> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint32',
>> +	    'class':'uint8', 'subclass':'uint8',
>> +	    'ld-id':'uint16', 'head-id':'uint8',
>>              'type': 'uint8', 'health-status': 'uint8',
>>              'media-status': 'uint8', 'additional-status': 'uint8',
>>              'life-used': 'uint8', 'temperature' : 'int16',

