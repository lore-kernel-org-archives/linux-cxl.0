Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A31C68B
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84DCCA;
	Fri,  3 Nov 2023 09:12:05 -0700 (PDT)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMQhq4CHsz6K7Gp;
	Sat,  4 Nov 2023 00:11:07 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 16:12:02 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Fri, 3 Nov 2023 16:12:02 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Topic: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Index: AQHaDQgRQ2vINXGk70OHbaqSCzYaYrBoqc8AgAAYFhA=
Date: Fri, 3 Nov 2023 16:12:02 +0000
Message-ID: <547d055eb85d4cee9c636c69e89a82ed@huawei.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
	<20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
 <20231103142756.00000e20@Huawei.com>
In-Reply-To: <20231103142756.00000e20@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.48.153.224]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected



>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 03 November 2023 14:28
>To: Ira Weiny <ira.weiny@intel.com>
>Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
>Jiang <dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com=
>;
>Vishal Verma <vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
>linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>cxl@vger.kernel.org; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace kn=
own
>events
>
>On Wed, 01 Nov 2023 14:11:18 -0700
>Ira Weiny <ira.weiny@intel.com> wrote:
>
>> The uuid printed in the well known events is redundant.  The uuid
>> defines what the event was.
>>
>> Remove the uuid from the known events and only report it in the
>> generic event as it remains informative there.
>>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
>Removing the print is fine, but look like this also removes the actual tra=
ce point
>field.  That's userspace ABI.  Expanding it is fine, but taking fields awa=
y is more
>problematic.
>
>Are we sure we don't break anyone?  Shiju, will rasdaemon be fine with thi=
s
>change?

The field hdr_uuid is removed from the common CXL_EVT_TP_entry shared by th=
e
trace events cxl_generic_event, cxl_general_media, cxl_dram and cxl_memory_=
module .
rasdaemon will break because of this while processing these trace events
and also affects the corresponding error records in the SQLite data base.=20
Rasdaemon needs update to avoid this.
=20
>
>Thanks,
>
>Jonathan
>

Thanks,
Shiju

>
>
>> ---
>>  drivers/cxl/core/trace.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> a0b5819bc70b..79ed03637604 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -189,7 +189,6 @@ TRACE_EVENT(cxl_overflow,
>>  	__string(memdev, dev_name(&cxlmd->dev))			\
>>  	__string(host, dev_name(cxlmd->dev.parent))		\
>>  	__field(int, log)					\
>> -	__field_struct(uuid_t, hdr_uuid)			\
>>  	__field(u64, serial)					\
>>  	__field(u32, hdr_flags)					\
>>  	__field(u16, hdr_handle)				\
>> @@ -203,7 +202,6 @@ TRACE_EVENT(cxl_overflow,
>>  	__assign_str(host, dev_name((cxlmd)->dev.parent));
>	\
>>  	__entry->log =3D (l);
>	\
>>  	__entry->serial =3D (cxlmd)->cxlds->serial;				\
>> -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));
>	\
>>  	__entry->hdr_length =3D (hdr).length;
>	\
>>  	__entry->hdr_flags =3D get_unaligned_le24((hdr).flags);
>	\
>>  	__entry->hdr_handle =3D le16_to_cpu((hdr).handle);
>	\
>> @@ -212,12 +210,12 @@ TRACE_EVENT(cxl_overflow,
>>  	__entry->hdr_maint_op_class =3D (hdr).maint_op_class
>>
>>  #define CXL_EVT_TP_printk(fmt, ...) \
>> -	TP_printk("memdev=3D%s host=3D%s serial=3D%lld log=3D%s : time=3D%llu
>uuid=3D%pUb "	\
>> +	TP_printk("memdev=3D%s host=3D%s serial=3D%lld log=3D%s : time=3D%llu =
"
>	\
>>  		"len=3D%d flags=3D'%s' handle=3D%x related_handle=3D%x "
>	\
>>  		"maint_op_class=3D%u : " fmt,
>	\
>>  		__get_str(memdev), __get_str(host), __entry->serial,
>	\
>>  		cxl_event_log_type_str(__entry->log),
>	\
>> -		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry-
>>hdr_length,\
>> +		__entry->hdr_timestamp, __entry->hdr_length,
>	\
>>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,
>	\
>>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,
>	\
>>  		##__VA_ARGS__)
>> @@ -231,15 +229,17 @@ TRACE_EVENT(cxl_generic_event,
>>
>>  	TP_STRUCT__entry(
>>  		CXL_EVT_TP_entry
>> +		__field_struct(uuid_t, hdr_uuid)
>>  		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
>>  	),
>>
>>  	TP_fast_assign(
>>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
>> +		memcpy(&__entry->hdr_uuid, &rec->hdr.id, sizeof(uuid_t));
>>  		memcpy(__entry->data, &rec->data,
>CXL_EVENT_RECORD_DATA_LENGTH);
>>  	),
>>
>> -	CXL_EVT_TP_printk("%s",
>> +	CXL_EVT_TP_printk("uuid=3D%pUb %s", &__entry->hdr_uuid,
>>  		__print_hex(__entry->data,
>CXL_EVENT_RECORD_DATA_LENGTH))  );
>>
>>

