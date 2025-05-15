Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8C296736
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301224; cv=none; b=GkCoCTcg0wzNllj4Qo7azu7d++KkL4i8gtn1iRs2IiPqQGZqmliUxj/eAP3sS28Jqmpw57tYJVNVLQovZ56q5SZqwN7AfUcb2eqjar8yGybeBk1gzPvK7hEhytifyEDfgWBuXvJlXhqJh18CNxeZxsJTGgbatLIYJ3IkfdQWKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301224; c=relaxed/simple;
	bh=cjYHBfa1+bS7d3rr8isXPTstLl8bjW6aKTyjEG46U8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/Qtxf88PKnJbAK1NX5D9t2EyKpiUHAjGDfjTKdXzJ8gCxFOlIKWSPSuOwu+P+4nbbH1PoH67yY9zb7NHopPwsbBIf2EuhYcIefOwHcCMGflRC5deyyB1SqqXsvKu483uqgboQrkZWNsYID/MprUIQNXvYPRVaKAFVshi+dk16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZylCB1Dj5z6K6Sr;
	Thu, 15 May 2025 17:24:06 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AA6C140144;
	Thu, 15 May 2025 17:26:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 May 2025 11:26:58 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 15 May 2025 11:26:58 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, Linuxarm <linuxarm@huawei.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 1/1] cxl/events: Update Common Event Record to CXL spec
 rev 3.2
Thread-Topic: [PATCH 1/1] cxl/events: Update Common Event Record to CXL spec
 rev 3.2
Thread-Index: AQHbxOOSBVRcfkYHSEuRh8BhYU4fKLPSXLwAgAEO8QA=
Date: Thu, 15 May 2025 09:26:57 +0000
Message-ID: <eabd1bd3c92d46a7886fad4cd95fde1a@huawei.com>
References: <20250514151913.752-1-shiju.jose@huawei.com>
 <aCTq7IX49iLBiwJL@aschofie-mobl2.lan>
In-Reply-To: <aCTq7IX49iLBiwJL@aschofie-mobl2.lan>
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
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 14 May 2025 20:12
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; dave@stgolabs.net=
;
>Jonathan Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; nifan.cxl@gmail.com; Linuxa=
rm
><linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 1/1] cxl/events: Update Common Event Record to CXL spe=
c
>rev 3.2
>
>On Wed, May 14, 2025 at 04:19:13PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.10.2.1 Table 8-55, Common Event Record format
>> has updated with LD-ID and ID of the device head fields.
>
>This comment is less important now that I've opened the spec and looked th=
em
>up. In addition to a spec reference, please take a moment in this commit
>message to describe the new fields and what they offer.

Hi Alison,

Thanks for the feedback. I will add description for the new fields. =20

>
>nit below -
>
>
>
>>
>> Add updates for the above spec changes in the CXL events record and
>> CXL common trace event implementation.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/trace.h | 22 ++++++++++++++++------
>>  include/cxl/event.h      |  4 +++-
>>  2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 25ebfbc1616c..ce482e57a477 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -214,12 +214,16 @@ TRACE_EVENT(cxl_overflow,
>>  #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
>>  #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
>>  #define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
>> +#define CXL_EVENT_RECORD_FLAG_LD_ID_VALID	BIT(7)
>> +#define CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID	BIT(8)
>>  #define show_hdr_flags(flags)	__print_flags(flags, " | ",
>		   \
>>  	{ CXL_EVENT_RECORD_FLAG_PERMANENT,
>	"PERMANENT_CONDITION"		}, \
>>  	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
>	"MAINTENANCE_NEEDED"		}, \
>>  	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
>	"PERFORMANCE_DEGRADED"		}, \
>> -	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,
>	"HARDWARE_REPLACEMENT_NEEDED"	},  \
>> -	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,
>	"MAINT_OP_SUB_CLASS_VALID" }	\
>> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,
>	"HARDWARE_REPLACEMENT_NEEDED"	}, \
>> +	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,
>	"MAINT_OP_SUB_CLASS_VALID" }, \
>> +	{ CXL_EVENT_RECORD_FLAG_LD_ID_VALID,	"LD_ID_VALID" }, \
>> +	{ CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID,	"HEAD_ID_VALID" } \
>>  )
>
>Is there some spurious changes above? I don't see why HW_REPLACE line
>needed an edit.

Just removed an extra space that was present in the line with HARDWARE_REPL=
ACEMENT_NEEDED
to make it identical to the rest.

>
>>
>>  /*
>> @@ -247,7 +251,9 @@ TRACE_EVENT(cxl_overflow,
>>  	__field(u64, hdr_timestamp)				\
>>  	__field(u8, hdr_length)					\
>>  	__field(u8, hdr_maint_op_class)				\
>> -	__field(u8, hdr_maint_op_sub_class)
>> +	__field(u8, hdr_maint_op_sub_class)			\
>> +	__field(u16, hdr_ld_id)					\
>> +	__field(u8, hdr_head_id)
>>
>>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)
>		\
>>  	__assign_str(memdev);				\
>> @@ -260,18 +266,22 @@ TRACE_EVENT(cxl_overflow,
>>  	__entry->hdr_related_handle =3D le16_to_cpu((hdr).related_handle);
>	\
>>  	__entry->hdr_timestamp =3D le64_to_cpu((hdr).timestamp);
>		\
>>  	__entry->hdr_maint_op_class =3D (hdr).maint_op_class;
>	\
>> -	__entry->hdr_maint_op_sub_class =3D (hdr).maint_op_sub_class
>> +	__entry->hdr_maint_op_sub_class =3D (hdr).maint_op_sub_class;
>	\
>> +	__entry->hdr_ld_id =3D le16_to_cpu((hdr).ld_id);
>	\
>> +	__entry->hdr_head_id =3D (hdr).head_id
>
>clean
>
>>
>>  #define CXL_EVT_TP_printk(fmt, ...) \
>>  	TP_printk("memdev=3D%s host=3D%s serial=3D%lld log=3D%s : time=3D%llu
>uuid=3D%pUb "	\
>>  		"len=3D%d flags=3D'%s' handle=3D%x related_handle=3D%x "
>	\
>> -		"maint_op_class=3D%u maint_op_sub_class=3D%u : " fmt,
>	\
>> +		"maint_op_class=3D%u maint_op_sub_class=3D%u ld_id=3D%x "
>	\
>> +		"head_id=3D%x : " fmt,
>	\
>
>clean
>
>>  		__get_str(memdev), __get_str(host), __entry->serial,
>	\
>>  		cxl_event_log_type_str(__entry->log),
>	\
>>  		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry-
>>hdr_length,\
>>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,
>	\
>>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,
>	\
>> -		__entry->hdr_maint_op_sub_class,	\
>> +		__entry->hdr_maint_op_sub_class, __entry->hdr_ld_id,
>	\
>> +		__entry->hdr_head_id,
>	\
>>  		##__VA_ARGS__)
>
>OK (only OK because I may have just started a new line to avoid the (-))
Will do.
>
>>
>>  TRACE_EVENT(cxl_generic_event,
>> diff --git a/include/cxl/event.h b/include/cxl/event.h index
>> f9ae1796da85..f4cb8568566b 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -19,7 +19,9 @@ struct cxl_event_record_hdr {
>>  	__le64 timestamp;
>>  	u8 maint_op_class;
>>  	u8 maint_op_sub_class;
>> -	u8 reserved[14];
>> +	__le16 ld_id;
>> +	u8 head_id;
>> +	u8 reserved[11];
>>  } __packed;
>
>clean
>
>>
>>  struct cxl_event_media_hdr {
>> --
>> 2.43.0
>>

Thanks,
Shiju
