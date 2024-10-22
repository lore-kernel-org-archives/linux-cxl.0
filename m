Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF11C9B7B;
	Tue, 22 Oct 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620460; cv=none; b=ldzaW7zvf95tc7GaAlf33qZvfw0uvyFAxjuUqUzFBwIyjMZU14wR3vuOGrIR+uOnsS9jo6dMfxhpbJdUneft516SPZSghsNk6Q9YXI7AMA84o+9EiXk9MQg+03yRGbGDW9E4G5IJT/4TnPwFPVHKDg87lvQVa2mnyeywiV3PLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620460; c=relaxed/simple;
	bh=FQAoNqTo3L1gXzNU5EFWOaOOpkEb+ePuzkKcpnzkHPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjHCAXVVjbV5D1H6PW4KBu6fOHx9zzONEe/e8U2Bp2Wg072fgBL3Bh5gBkIEuUdCzBywBByFCVlDGSrAeFR543QmjGyzybOaa3ewxuh0dI8l4smFyB2CbSB/VfQXBk4YpI6vM+NaujWIDT7+35EwK7nM7byfnYvQFuljqS0igiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY0TR2kJlz6K6lT;
	Wed, 23 Oct 2024 02:05:31 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 07165140A9C;
	Wed, 23 Oct 2024 02:07:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 20:07:31 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 22 Oct 2024 20:07:31 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v2 2/6] cxl/events: Add Component Identifier formatting
 for CXL spec rev 3.1
Thread-Topic: [PATCH v2 2/6] cxl/events: Add Component Identifier formatting
 for CXL spec rev 3.1
Thread-Index: AQHbJHFsQjangr5km064qFvNrZTcGrKS3NCAgAAs9XA=
Date: Tue, 22 Oct 2024 18:07:31 +0000
Message-ID: <26859655a08c4e6692abd38f2367f2b8@huawei.com>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
	<20241022105849.1272-3-shiju.jose@huawei.com>
 <20241022175827.000033ef@Huawei.com>
In-Reply-To: <20241022175827.000033ef@Huawei.com>
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
>Sent: 22 October 2024 17:58
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel=
.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dave@stgolabs.net; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>
>Subject: Re: [PATCH v2 2/6] cxl/events: Add Component Identifier formattin=
g for
>CXL spec rev 3.1
>
>On Tue, 22 Oct 2024 11:58:45 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add Component Identifier formatting for CXL spec rev 3.1, Section
>> 8.2.9.2.1, Table 8-44.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/trace.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 7305974e2301..81908072c6f3 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -268,6 +268,26 @@ TRACE_EVENT(cxl_generic_event,
>>  	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
>>  )
>>
>> +/*
>> + * Component ID Format
>> + * CXL 3.1 section 8.2.9.2.1; Table 8-44  */
>> +#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
>> +#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
>> +
>> +#define comp_id_pldm_flags(flags)  __print_flags(flags, " | ",
>	\
>> +	{ CXL_PLDM_COMPONENT_ID_ENTITY_VALID,   "PLDM_Entity_ID[5:0] "
>},	\
>> +	{ CXL_PLDM_COMPONENT_ID_RES_VALID,      "Resource_ID[9:6] " }
>		\
>> +)
>> +
>> +#define cxl_print_component_id(flags, valid_comp_id, valid_id_format,
>comp_id)			\
>> +	(flags & valid_comp_id && flags & valid_id_format) ?
>			\
>> +	(comp_id[0] & (CXL_PLDM_COMPONENT_ID_ENTITY_VALID |
>CXL_PLDM_COMPONENT_ID_RES_VALID)) ?	\
>> +	__print_hex(&comp_id[1], 10) : (comp_id[0] &
>CXL_PLDM_COMPONENT_ID_ENTITY_VALID) ?	\
>> +	__print_hex(&comp_id[1], 6) : (comp_id[0] &
>CXL_PLDM_COMPONENT_ID_RES_VALID) ?		\
>> +	__print_hex(&comp_id[7], 4) : __print_hex(comp_id,
>CXL_EVENT_GEN_MED_COMP_ID_SIZE) :	\
>
>> +	__print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>> +
>Hi Shiju,
>
>This is hard to read and I've lost track of what the aim is.
>Side note that it is probably good to state that in the patch description
>+ give some examples of what this print looks like in the various cases.
>If we are going to print the whole thing in the case where we have no vali=
d bits
>set in byte[1], maybe we just print the whole thing in all cases and just =
add the
>info on whether it is formatted and what those valid bits are in byte[1]?
>
>I was never keen on printing the invalid fields in the first place but thi=
s code
>adopted the convention of validity bits and print what is there where vali=
d or
>not. So maybe the things we should print are:
>Taking GMER as an example.

Hi Jonathan,

>
>Add the component id valid format to show_valid_flags() Then always print =
the
>flags for comp_id_pldm_flags() above whether or not they are valid. Finall=
y print
>the two broken out fields Enity ID and Resource ID.
Will add component id valid format to show_valid_flags().
>
>Whether we also just print the raw versions is another question we need to
>figure out - in the formatted case it is duplication, but if not it includ=
es more
>bytes.
Can do.

For the following component ID with PLDM entity and resource Id are valid
0x03 0x07 0xc5 0x08 0x9a 0x1a 0x0b 0xfc 0x0d 0x0e 0x2f 0x00 0x00 0x00  0x00=
  0x00

For example GMER trace printed as,=20

"comp_id=3DPLDM_Entity_ID[5:0]  | Resource_ID[9:6] 07 c5 08 9a 1a 0b fc 0d =
0e 2f validity_flags=3D'CHANNEL|RANK|DEVICE|COMPONENT|0x10'"

cxl_general_media: memdev=3Dmem0 host=3D0000:0f:00.0 serial=3D3 log=3DFatal=
 : time=3D246865829224 uuid=3Dfbcd0a77-c260-417f-85a9-088b1621eba6 len=3D12=
8 flags=3D'0x1' handle=3D1 related_handle=3D0 maint_op_class=3D0 maint_op_s=
ub_class=3D0 : dpa=3D7c0 dpa_flags=3D'' descriptor=3D'UNCORRECTABLE_EVENT|T=
HRESHOLD_EVENT|POISON_LIST_OVERFLOW' type=3D'TE State Violation' sub_type=
=3D'Media Link Command Training Error' transaction_type=3D'0xc0' channel=3D=
3 rank=3D33 device=3D5 comp_id=3DPLDM_Entity_ID[5:0]  | Resource_ID[9:6] 07=
 c5 08 9a 1a 0b fc 0d 0e 2f validity_flags=3D'CHANNEL|RANK|DEVICE|COMPONENT=
|0x10' hpa=3Dffffffffffffffff cme_threshold_ev_flags=3D'Corrected Memory Er=
rors in Multiple Media Components|Exceeded Programmable Threshold' cme_coun=
t=3D78 region=3D region_uuid=3D00000000-0000-0000-0000-000000000000

Presently print comp_id_pldm_flags with [bitN: bitM] and then corresponding=
 PLDM entity and/or resource ID based on the flags checking in the cxl_prin=
t_component_id().
=20
Other cases,
"comp_id=3DPLDM_Entity_ID[5:0]  07 c5 08 9a 1a 0b validity_flags=3D'CHANNEL=
|RANK|DEVICE|COMPONENT|0x10'"=20
"comp_id=3D Resource_ID[9:6] fc 0d 0e 2f validity_flags=3D'CHANNEL|RANK|DEV=
ICE|COMPONENT|0x10'"

If need to modify, can print as you suggested, =20
... validity_flags, raw comp_id, comp_id_pldm_flags, Enity ID, Resource ID =
...
>
>Jonathan
>
Thanks,
Shiju

>
>
>>  /*
>>   * General Media Event Record - GMER
>>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43

