Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEA195FD5;
	Wed, 27 Nov 2024 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702537; cv=none; b=tE/rUGSMcoYQ+76X+QPX46oqTeXbbdNCbyVkdCzxzkaC4Jw9tColKOY//hpOiawrLiknlOc56IW3e5hEvXTwfsBj1DbRwV4Mu0ofYx4xMHoKTig1RWfxRu9WMO4wWlzf2R9k8nLU1MpsDPmuvY7gmyJvLyokmUt4u957IK0NKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702537; c=relaxed/simple;
	bh=h8acZ1y9pK046pivY5M0fVYBosnV0EM/PN5VKLkWe+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8cGGTlt3Vf+1vf+zWDn8F8hVn6onTGKK1pDDPMruzi1L5wz6q1n6A/n+M6FkPHXRUakL9Pod2PIXUMV48llYVCBnT1sqpKtCduU6iGEpODhQ/KKzisLM2UHL/DqdT/liW7t6qO21udKf83sj+b3KpEE4McqRbPce10+LK84KRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XywG323qJz6K5rj;
	Wed, 27 Nov 2024 18:11:39 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 2137A140133;
	Wed, 27 Nov 2024 18:15:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 11:15:31 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 27 Nov 2024 11:15:31 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>
Subject: RE: [PATCH v4 1/6] cxl/events: Update Common Event Record to CXL spec
 rev 3.1
Thread-Topic: [PATCH v4 1/6] cxl/events: Update Common Event Record to CXL
 spec rev 3.1
Thread-Index: AQHbOy/hVaHeWoOBMES/mGi8IYplc7LJybMAgAEqHjA=
Date: Wed, 27 Nov 2024 10:15:31 +0000
Message-ID: <1187c8e3618d40cc8afc3eb2624ba790@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
 <20241120093745.1847-2-shiju.jose@huawei.com>
 <Z0YE7C5NkyydjiRR@smc-140338-bm01>
In-Reply-To: <Z0YE7C5NkyydjiRR@smc-140338-bm01>
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
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 26 November 2024 17:27
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=
;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH v4 1/6] cxl/events: Update Common Event Record to CXL
>spec rev 3.1
>
>On Wed, Nov 20, 2024 at 09:37:40AM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format
>> has updated with Maintenance Operation Subclass information.
>The table reference is incorrect, should be Table 8-43 based on spec r3.1,=
 v1.0,
>Auguest 7, 2023.
>
Hi Fan,=20

Thanks for reviewing.  Will fix.

>Other than that,
>
>
>Reviewed-by: Fan Ni <fan.ni@samsung.com>
>
>>
>> Add updates for the above spec change in the CXL events record and CXL
>> common trace event implementations.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/trace.h | 13 +++++++++----
>>  include/cxl/event.h      |  3 ++-
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 8389a94adb1a..7305974e2301 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -166,11 +166,13 @@ TRACE_EVENT(cxl_overflow,
>>  #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
>>  #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
>>  #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
>> +#define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
>>  #define show_hdr_flags(flags)	__print_flags(flags, " | ",
>		   \
>>  	{ CXL_EVENT_RECORD_FLAG_PERMANENT,
>	"PERMANENT_CONDITION"		}, \
>>  	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
>	"MAINTENANCE_NEEDED"		}, \
>>  	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
>	"PERFORMANCE_DEGRADED"		}, \
>> -	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,
>	"HARDWARE_REPLACEMENT_NEEDED"	}  \
>> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,
>	"HARDWARE_REPLACEMENT_NEEDED"	},  \
>> +	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,
>	"MAINT_OP_SUB_CLASS_VALID" }	\
>>  )
>>
>>  /*
>> @@ -197,7 +199,8 @@ TRACE_EVENT(cxl_overflow,
>>  	__field(u16, hdr_related_handle)			\
>>  	__field(u64, hdr_timestamp)				\
>>  	__field(u8, hdr_length)					\
>> -	__field(u8, hdr_maint_op_class)
>> +	__field(u8, hdr_maint_op_class)				\
>> +	__field(u8, hdr_maint_op_sub_class)
>>
>>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)
>		\
>>  	__assign_str(memdev);				\
>> @@ -209,17 +212,19 @@ TRACE_EVENT(cxl_overflow,
>>  	__entry->hdr_handle =3D le16_to_cpu((hdr).handle);
>	\
>>  	__entry->hdr_related_handle =3D le16_to_cpu((hdr).related_handle);
>	\
>>  	__entry->hdr_timestamp =3D le64_to_cpu((hdr).timestamp);
>		\
>> -	__entry->hdr_maint_op_class =3D (hdr).maint_op_class
>> +	__entry->hdr_maint_op_class =3D (hdr).maint_op_class;
>	\
>> +	__entry->hdr_maint_op_sub_class =3D (hdr).maint_op_sub_class
>>
>>  #define CXL_EVT_TP_printk(fmt, ...) \
>>  	TP_printk("memdev=3D%s host=3D%s serial=3D%lld log=3D%s : time=3D%llu
>uuid=3D%pUb "	\
>>  		"len=3D%d flags=3D'%s' handle=3D%x related_handle=3D%x "
>	\
>> -		"maint_op_class=3D%u : " fmt,
>	\
>> +		"maint_op_class=3D%u maint_op_sub_class=3D%u : " fmt,
>	\
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
>> +		__entry->hdr_maint_op_sub_class,	\
>>  		##__VA_ARGS__)
>>
>>  TRACE_EVENT(cxl_generic_event,
>> diff --git a/include/cxl/event.h b/include/cxl/event.h index
>> 0bea1afbd747..e1d485ad376b 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -18,7 +18,8 @@ struct cxl_event_record_hdr {
>>  	__le16 related_handle;
>>  	__le64 timestamp;
>>  	u8 maint_op_class;
>> -	u8 reserved[15];
>> +	u8 maint_op_sub_class;
>> +	u8 reserved[14];
>>  } __packed;
>>
>>  struct cxl_event_media_hdr {
>> --
>> 2.43.0
>>
>
>--
>Fan Ni (From gmail)

Thanks,
Shiju
