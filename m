Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA1233148
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678457; cv=none; b=D+WYkMnHEUHg9GbK4ppNd1lZEE1BWONoa3iqKpdFxAoob6Cfh7o68KFUnsysyL71oxDFHem/CsdHng89lCNc4knsba2hg/q0HXNy33oVaRP6mpkjDjS9Ev6777dg3DLFRMGrnefHrmwhg8py0KSbzsZupejaYNwSLuCrEIG840o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678457; c=relaxed/simple;
	bh=NGNm8hT5JYoXFD7YIurgbAel3ZlFZMvYtVBkrH4oNxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krkUW3FD5Zk2ahTwdathkJEb4iQ4ujnI9zlCpjhrsJVn8HomYcimtJJnfOCEuNM3XkTcbbJ1JiY1bNyEE5W0Rhd4Ya3HGbiuELZVeI4VvdguaCsZ+6BOBWfKVrUtZZ1VXzOyGKA9vp3QYq6iIrtH1LF06XURLEHAIIY12+q1r7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhzsM3sFlz6GDnR;
	Wed, 16 Jul 2025 23:06:15 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 204DD14044F;
	Wed, 16 Jul 2025 23:07:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 17:07:30 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 17:07:30 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 4/4] cxl/events: Trace Memory Sparing Event Record
Thread-Topic: [PATCH 4/4] cxl/events: Trace Memory Sparing Event Record
Thread-Index: AQHb9kO6Uc9VaGVuKEu4UNi+z0QNP7Q0mbEAgABAF5A=
Date: Wed, 16 Jul 2025 15:07:30 +0000
Message-ID: <785c4282201c4cc0b5b4cdae68408f38@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
	<20250716104945.2002-5-shiju.jose@huawei.com>
 <20250716141644.00000347@huawei.com>
In-Reply-To: <20250716141644.00000347@huawei.com>
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
>Sent: 16 July 2025 14:17
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; dave.jiang@intel.=
com;
>alison.schofield@intel.com; dave@stgolabs.net; vishal.l.verma@intel.com;
>ira.weiny@intel.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH 4/4] cxl/events: Trace Memory Sparing Event Record
>
>On Wed, 16 Jul 2025 11:49:45 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL rev 3.2 section 8.2.10.2.1.4 Table 8-60 defines the Memory Sparing
>> Event Record.
>>
>> Determine if the event read is memory sparing record and if so trace
>> the record.
>>
>> Memory device shall produce a memory sparing event record 1. After
>> completion of a PPR maintenance operation if the memory sparing event
>> record enable bit is set (Field: sPPR/hPPR Operation Mode in Table
>> 8-128/Table 8-131).
>> 2. In response to a query request by the host (see section
>> 8.2.10.7.1.4) to determine the availability of sparing resources.
>> The device shall report the resource availability by producing the
>> Memory Sparing Event Record (see Table 8-60) in which the channel,
>> rank, nibble mask, bank group, bank, row, column, sub-channel fields
>> are a copy of the values specified in the request. If the controller
>> does not support reporting whether a resource is available, and a
>> perform maintenance operation for memory sparing is issued with query
>> resources set to 1, the controller shall return invalid input.
>>
>> Example trace log for produce memory sparing event record on
>> completion of a soft PPR operation,
>> cxl_memory_sparing: memdev=3Dmem1 host=3D0000:0f:00.0 serial=3D3
>> log=3DInformational : time=3D55045163029
>> uuid=3De71f3a40-2d29-4092-8a39-4d1c966c7c65 len=3D128 flags=3D'0x1' hand=
le=3D1
>> related_handle=3D0 maint_op_class=3D2 maint_op_sub_class=3D1
>> ld_id=3D0 head_id=3D0 : flags=3D'' result=3D0
>> validity_flags=3D'CHANNEL|RANK|NIBBLE|BANK GROUP|BANK|ROW|COLUMN'
>> spare resource avail=3D1 channel=3D2 rank=3D5 nibble_mask=3Da59c bank_gr=
oup=3D2
>> bank=3D4 row=3D13 column=3D23 sub_channel=3D0
>> comp_id=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> comp_id_pldm_valid_flags=3D'' pldm_entity_id=3D0x00 pldm_resource_id=3D0=
x00
>>
>> Note: For memory sparing event record, fields 'maintenance operation
>> class' and 'maintenance operation subclass' are defined twice, first
>> in the common event record (Table 8-55) and second in the memory
>> sparing event record (Table 8-60). Thus those in the sparing event
>> record coded as reserved, to be removed when the spec is updated.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>Only comment formatting related.
>
>Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> ---
>>  drivers/cxl/core/mbox.c  |   6 +++
>>  drivers/cxl/core/trace.h | 100
>+++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h     |   8 ++++
>>  include/cxl/event.h      |  33 +++++++++++++
>>  4 files changed, 147 insertions(+)
>>
>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> c3cd871942c5..2c291fb1857c 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -888,6 +888,106 @@ TRACE_EVENT(cxl_memory_module,
>>  	)
>>  );
>>
>> +#define CXL_MSER_QUERY_RESOURCE_FLAG			BIT(0)
>> +#define CXL_MSER_HARD_SPARING_FLAG			BIT(1)
>> +#define CXL_MSER_DEV_INITED_FLAG			BIT(2)
>> +#define show_mem_sparing_flags(flags)	__print_flags(flags, "|",
>	\
>> +	{ CXL_MSER_QUERY_RESOURCE_FLAG,		"Query Resources" },
>		\
>> +	{ CXL_MSER_HARD_SPARING_FLAG,		"Hard Sparing" },
>		\
>> +	{ CXL_MSER_DEV_INITED_FLAG,	"Device Initiated Sparing"
>	}	\
>
>Spacing before the } is inconsistent for this last line.  Copy whatever we=
 have in
>the file already and if it is inconsistent (which it is) pick most common =
option.

Thanks Jonathan.
I will correct in v2.
>
>> +)
>

Thanks
Shiju
