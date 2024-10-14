Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77A1CACE8
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919008; cv=none; b=CffcXvtQO3ahUsocrH2Jct5IYFf+tWwvimE8/l1HzHN6DXAxQmTYYwgmkuRL14rm/z/eQuTR2MPOlzaiWnoAA1606UXoaVKcx+dkN3XG+k/Sn0A7eP/TIepazxz+57meR8zlhuEH+gKOndT+VZ3o3RYdmtsAbtL1uqaZWlms3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919008; c=relaxed/simple;
	bh=nQxtEVbr7kGLi1E5jS0D4st03+SyxP7dTbTt8mqmMko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWYbOj4/x/g2WMMNiTaj183fVD2T+Lby+3WxRb9gV+rd+lumPCMYGVJP3MGkTMPu2napIbWiV0C2gQoJKLN7T7Bw9HHsp23o2RuflDXMznZjDfOr+3PeE4tYOYV3jnqtEQpOssGB3D0LzPicvu2TpVa+EIkBksVe0A5UbPquQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS14X4Kqvz6GByn;
	Mon, 14 Oct 2024 23:15:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BC9A1400CA;
	Mon, 14 Oct 2024 23:16:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 17:16:43 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Oct 2024 17:16:43 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 1/1] cxl/events: Fix Trace DRAM Event Record
Thread-Topic: [PATCH 1/1] cxl/events: Fix Trace DRAM Event Record
Thread-Index: AQHbHkWZEnbgbq/HpUGDXi3ssQ4G17KGMtYAgAAkioA=
Date: Mon, 14 Oct 2024 15:16:43 +0000
Message-ID: <05305df495904b9f99fcb52f67a66762@huawei.com>
References: <20241014143003.1170-1-shiju.jose@huawei.com>
 <670d2fc83b507_1357e2294c1@iweiny-mobl.notmuch>
In-Reply-To: <670d2fc83b507_1357e2294c1@iweiny-mobl.notmuch>
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
>From: Ira Weiny <ira.weiny@intel.com>
>Sent: 14 October 2024 15:51
>To: Shiju Jose <shiju.jose@huawei.com>; dave.jiang@intel.com;
>dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dave@stgolabs.net; linux-
>cxl@vger.kernel.org
>Cc: Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH 1/1] cxl/events: Fix Trace DRAM Event Record
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
>>
>> Fix decode memory event type field of DRAM Event Record.
>> For e.g. if value is 0x1 it will be reported as an Invalid Address
>> (General Media Event Record - Memory Event Type) instead of Scrub
>> Media ECC Error (DRAM Event Record - Memory Event Type) and so on.
>>
>> Fixes: 2d6c1e6d60ba ("cxl/mem: Trace DRAM Event Record")
>
>I assume this is causing issues with user space?
This change directly affects kernel logging for memory event type in DRAM  =
event record only.
However similar fix is needed in rasdaemon too because I referred the kerne=
l code for the
CXL event logging part in the user space.
>
>If so I will add...
>
>Cc: <stable@vger.kernel.org> # 6.3.x
>
>... and queue this up in cxl-fixes.
>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>> Updates for event records in CXL spec r3.1 will follow shortly.
>>
>>  drivers/cxl/core/trace.h | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 9167cfba7f59..cdffebcf20a4 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -279,7 +279,7 @@ TRACE_EVENT(cxl_generic_event,
>>  #define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
>>  #define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
>>  #define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
>> -#define show_mem_event_type(type)	__print_symbolic(type,
>	\
>> +#define show_gmer_mem_event_type(type)	__print_symbolic(type,
>		\
>>  	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },
>		\
>>  	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid
>Address" },	\
>>  	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path
>Error" }	\
>> @@ -373,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
>>  		"hpa=3D%llx region=3D%s region_uuid=3D%pUb",
>>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>>  		show_event_desc_flags(__entry->descriptor),
>> -		show_mem_event_type(__entry->type),
>> +		show_gmer_mem_event_type(__entry->type),
>>  		show_trans_type(__entry->transaction_type),
>>  		__entry->channel, __entry->rank, __entry->device,
>>  		__print_hex(__entry->comp_id,
>CXL_EVENT_GEN_MED_COMP_ID_SIZE), @@
>> -391,6 +391,17 @@ TRACE_EVENT(cxl_general_media,
>>   * DRAM Event Record defines many fields the same as the General Media
>Event
>>   * Record.  Reuse those definitions as appropriate.
>>   */
>> +#define CXL_DER_MEM_EVT_TYPE_ECC_ERROR			0x00
>> +#define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
>> +#define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
>> +#define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
>> +#define show_dram_mem_event_type(type)  __print_symbolic(type,
>			\
>> +	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },
>			\
>> +	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub
>Media ECC Error" },	\
>> +	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid
>Address" },		\
>> +	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data
>Path Error" }		\
>> +)
>> +
>>  #define CXL_DER_VALID_CHANNEL				BIT(0)
>>  #define CXL_DER_VALID_RANK				BIT(1)
>>  #define CXL_DER_VALID_NIBBLE				BIT(2)
>> @@ -477,7 +488,7 @@ TRACE_EVENT(cxl_dram,
>>  		"hpa=3D%llx region=3D%s region_uuid=3D%pUb",
>>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>>  		show_event_desc_flags(__entry->descriptor),
>> -		show_mem_event_type(__entry->type),
>> +		show_dram_mem_event_type(__entry->type),
>>  		show_trans_type(__entry->transaction_type),
>>  		__entry->channel, __entry->rank, __entry->nibble_mask,
>>  		__entry->bank_group, __entry->bank,
>> --
>> 2.34.1
>>
>
>
Thanks,
Shiju
