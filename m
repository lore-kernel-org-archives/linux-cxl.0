Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980838DC8;
	Wed, 27 Nov 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731634; cv=none; b=uxzgUHdSyz/5dhdA4oZxi0CmWW86DGHxLhdwXJ4bJOOsmTdKGoTwmGHwZ+Xmx25klRe6ZOws8tVrohBH+Zvk5uXaAfzKmvGVAkQ2mubyA2tYicuXnO30Ejejfz2p4y7kUfLIfQ/U7DARpJLpl0YEwu/xRHCgbT9BJS2MEq9IulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731634; c=relaxed/simple;
	bh=6FFfDfSIxcQMI0IYepGwH9vMm5nWmf7q/s4+QGvKe9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C3t1t7r/cCl7rhVFPsGyc1jokRSpRrnZ3RiksBD1s7qftASbqgKaZSf3NV6OdK7tqYBzbjJvg23bzT7FWlMpfMqjE8gfa78+MCU9mfK+RGwzmGcoEWyt0AvlWyeGL+t5NeFpfgQShoHlq1h7GI8qQkHRUDmK2zfWu3dGB9+s4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xz71X6pGDz67jVH;
	Thu, 28 Nov 2024 02:16:32 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D5414140519;
	Thu, 28 Nov 2024 02:20:26 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 19:20:26 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 27 Nov 2024 19:20:26 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Thread-Topic: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Thread-Index: AQHbOy/jEKs9N8Ou/EWSGme10Yml3rLJc4IQgABPV4CAAS95QIAATDQAgAA1zlA=
Date: Wed, 27 Nov 2024 18:20:26 +0000
Message-ID: <53a299d3cca6417d90d553e8399f834b@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
 <20241127104132.6c1729e1@gandalf.local.home>
In-Reply-To: <20241127104132.6c1729e1@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/mixed;
	boundary="_003_53a299d3cca6417d90d553e8399f834bhuaweicom_"
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_003_53a299d3cca6417d90d553e8399f834bhuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

Thanks for the quick reply.
Please find reply inline.

>-----Original Message-----
>From: Steven Rostedt <rostedt@goodmis.org>
>Sent: 27 November 2024 15:42
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=
;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH v4 3/6] cxl/events: Update General Media Event Record =
to
>CXL spec rev 3.1
>
>On Wed, 27 Nov 2024 10:12:12 +0000
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> format:
>> 	field:unsigned short common_type;	offset:0;	size:2;
>	signed:0;
>> 	field:unsigned char common_flags;	offset:2;	size:1;
>	signed:0;
>> 	field:unsigned char common_preempt_count;	offset:3;	size:1;
>	signed:0;
>> 	field:int common_pid;	offset:4;	size:4;	signed:1;
>>
>> 	field:__data_loc char[] memdev;	offset:8;	size:4;
>	signed:0;
>> 	field:__data_loc char[] host;	offset:12;	size:4;	signed:0;
>> 	field:int log;	offset:16;	size:4;	signed:1;
>
>> 	field:uuid_t hdr_uuid;	offset:20;	size:16;	signed:0;
>
>New type for me ;-)
>
>> 	field:u64 serial;	offset:40;	size:8;	signed:0;
>> 	field:u32 hdr_flags;	offset:48;	size:4;	signed:0;
>> 	field:u16 hdr_handle;	offset:52;	size:2;	signed:0;
>> 	field:u16 hdr_related_handle;	offset:54;	size:2;	signed:0;
>> 	field:u64 hdr_timestamp;	offset:56;	size:8;	signed:0;
>> 	field:u8 hdr_length;	offset:64;	size:1;	signed:0;
>> 	field:u8 hdr_maint_op_class;	offset:65;	size:1;	signed:0;
>> 	field:u8 hdr_maint_op_sub_class;	offset:66;	size:1;
>	signed:0;
>> 	field:u64 dpa;	offset:72;	size:8;	signed:0;
>> 	field:u8 descriptor;	offset:80;	size:1;	signed:0;
>> 	field:u8 type;	offset:81;	size:1;	signed:0;
>> 	field:u8 transaction_type;	offset:82;	size:1;	signed:0;
>> 	field:u8 channel;	offset:83;	size:1;	signed:0;
>> 	field:u32 device;	offset:84;	size:4;	signed:0;
>> 	field:u8 comp_id[16];	offset:88;	size:16;	signed:0;
>> 	field:u64 hpa;	offset:104;	size:8;	signed:0;
>> 	field:uuid_t region_uuid;	offset:112;	size:16;	signed:0;
>> 	field:u16 validity_flags;	offset:128;	size:2;	signed:0;
>> 	field:u8 rank;	offset:130;	size:1;	signed:0;
>> 	field:u8 dpa_flags;	offset:131;	size:1;	signed:0;
>> 	field:__data_loc char[] region_name;	offset:132;	size:4;
>	signed:0;
>> 	field:u8 sub_type;	offset:136;	size:1;	signed:0;
>> 	field:u8 cme_threshold_ev_flags;	offset:137;	size:1;
>	signed:0;
>> 	field:u32 cme_count;	offset:140;	size:4;	signed:0;
>>
>> print fmt: "memdev=3D%s host=3D%s serial=3D%lld log=3D%s : time=3D%llu u=
uid=3D%pUb
>len=3D%d flags=3D'%s' handle=3D%x related_handle=3D%x maint_op_class=3D%u
>maint_op_sub_class=3D%u : dpa=3D%llx dpa_flags=3D'%s' descriptor=3D'%s' ty=
pe=3D'%s'
>transaction_type=3D'%s' channel=3D%u rank=3D%u device=3D%x validity_flags=
=3D'%s'
>comp_id=3D%shpa=3D%llx region=3D%s region_uuid=3D%pUb sub_type=3D%u
>cme_threshold_ev_flags=3D%u cme_count=3D%u", __get_str(memdev),
>__get_str(host), REC->serial, __print_symbolic(REC->log, {
>CXL_EVENT_TYPE_INFO, "Informational" }, { CXL_EVENT_TYPE_WARN,
>"Warning" }, { CXL_EVENT_TYPE_FAIL, "Failure" }, { CXL_EVENT_TYPE_FATAL,
>"Fatal" }), REC->hdr_timestamp,
>
>
>> &REC->hdr_uuid,
>
>libtraceevent doesn't know about taking an address with '&'.
>
>If I remove it (and the other one below for region_uuid), it parses fine.
>
>I'll have to add this to the library, as it should be able to handle this.
>I bet I also have to add "%pUb" as well.
>
I tested removing hdr_uuid and region_uuid from the rasdaemon test setup
as you suggested. As a result, libtraceevent parses correctly, as you menti=
oned.

However, I encounter  similar parsing error ("FAILED TO PARSE") when I add =
two additional
decoded strings (%s) to the TP_printk, replacing (%u). Please see the attac=
hed format file,
"format_cxl_general_media_v3.1_basic", for your reference.

I've also attached another format file, "format_cxl_general_media_v3.1_full=
",
which contains the complete TP_printk() intended.
=20
Can you please help or else can you share how to debug these errors in the
libtraceevent setup?

>Thanks,
>
>-- Steve
>
Thanks,
Shiju

--_003_53a299d3cca6417d90d553e8399f834bhuaweicom_
Content-Type: text/plain; name="format_cxl_general_media_v3.1_full.txt"
Content-Description: format_cxl_general_media_v3.1_full.txt
Content-Disposition: attachment;
	filename="format_cxl_general_media_v3.1_full.txt"; size=4999;
	creation-date="Wed, 27 Nov 2024 18:18:37 GMT";
	modification-date="Wed, 27 Nov 2024 18:18:37 GMT"
Content-Transfer-Encoding: base64

cm9vdEBsb2NhbGhvc3Q6fiMgY2F0IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2N4
bC9jeGxfZ2VuZXJhbF9tZWRpYS9mb3JtYXQKbmFtZTogY3hsX2dlbmVyYWxfbWVkaWEKSUQ6IDE0
NjQKZm9ybWF0OgoJZmllbGQ6dW5zaWduZWQgc2hvcnQgY29tbW9uX3R5cGU7CW9mZnNldDowOwlz
aXplOjI7CXNpZ25lZDowOwoJZmllbGQ6dW5zaWduZWQgY2hhciBjb21tb25fZmxhZ3M7CW9mZnNl
dDoyOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dW5zaWduZWQgY2hhciBjb21tb25fcHJlZW1w
dF9jb3VudDsJb2Zmc2V0OjM7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDppbnQgY29tbW9uX3Bp
ZDsJb2Zmc2V0OjQ7CXNpemU6NDsJc2lnbmVkOjE7CgoJZmllbGQ6X19kYXRhX2xvYyBjaGFyW10g
bWVtZGV2OwlvZmZzZXQ6ODsJc2l6ZTo0OwlzaWduZWQ6MDsKCWZpZWxkOl9fZGF0YV9sb2MgY2hh
cltdIGhvc3Q7CW9mZnNldDoxMjsJc2l6ZTo0OwlzaWduZWQ6MDsKCWZpZWxkOmludCBsb2c7CW9m
ZnNldDoxNjsJc2l6ZTo0OwlzaWduZWQ6MTsKCWZpZWxkOnU2NCBzZXJpYWw7CW9mZnNldDoyNDsJ
c2l6ZTo4OwlzaWduZWQ6MDsKCWZpZWxkOnUzMiBoZHJfZmxhZ3M7CW9mZnNldDozMjsJc2l6ZTo0
OwlzaWduZWQ6MDsKCWZpZWxkOnUxNiBoZHJfaGFuZGxlOwlvZmZzZXQ6MzY7CXNpemU6MjsJc2ln
bmVkOjA7CglmaWVsZDp1MTYgaGRyX3JlbGF0ZWRfaGFuZGxlOwlvZmZzZXQ6Mzg7CXNpemU6MjsJ
c2lnbmVkOjA7CglmaWVsZDp1NjQgaGRyX3RpbWVzdGFtcDsJb2Zmc2V0OjQwOwlzaXplOjg7CXNp
Z25lZDowOwoJZmllbGQ6dTggaGRyX2xlbmd0aDsJb2Zmc2V0OjQ4OwlzaXplOjE7CXNpZ25lZDow
OwoJZmllbGQ6dTggaGRyX21haW50X29wX2NsYXNzOwlvZmZzZXQ6NDk7CXNpemU6MTsJc2lnbmVk
OjA7CglmaWVsZDp1OCBoZHJfbWFpbnRfb3Bfc3ViX2NsYXNzOwlvZmZzZXQ6NTA7CXNpemU6MTsJ
c2lnbmVkOjA7CglmaWVsZDp1NjQgZHBhOwlvZmZzZXQ6NTY7CXNpemU6ODsJc2lnbmVkOjA7Cglm
aWVsZDp1OCBkZXNjcmlwdG9yOwlvZmZzZXQ6NjQ7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1
OCB0eXBlOwlvZmZzZXQ6NjU7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1OCBzdWJfdHlwZTsJ
b2Zmc2V0OjY2OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggdHJhbnNhY3Rpb25fdHlwZTsJ
b2Zmc2V0OjY3OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggY2hhbm5lbDsJb2Zmc2V0OjY4
OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTMyIGRldmljZTsJb2Zmc2V0OjcyOwlzaXplOjQ7
CXNpZ25lZDowOwoJZmllbGQ6dTggY29tcF9pZFsxNl07CW9mZnNldDo3NjsJc2l6ZToxNjsJc2ln
bmVkOjA7CglmaWVsZDp1NjQgaHBhOwlvZmZzZXQ6OTY7CXNpemU6ODsJc2lnbmVkOjA7CglmaWVs
ZDp1MTYgdmFsaWRpdHlfZmxhZ3M7CW9mZnNldDoxMDQ7CXNpemU6MjsJc2lnbmVkOjA7CglmaWVs
ZDp1OCByYW5rOwlvZmZzZXQ6MTA2OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggZHBhX2Zs
YWdzOwlvZmZzZXQ6MTA3OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggY21lX3RocmVzaG9s
ZF9ldl9mbGFnczsJb2Zmc2V0OjEwODsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOnUzMiBjbWVf
Y291bnQ7CW9mZnNldDoxMTI7CXNpemU6NDsJc2lnbmVkOjA7CglmaWVsZDpfX2RhdGFfbG9jIGNo
YXJbXSByZWdpb25fbmFtZTsJb2Zmc2V0OjExNjsJc2l6ZTo0OwlzaWduZWQ6MDsKCnByaW50IGZt
dDogIm1lbWRldj0lcyBob3N0PSVzIHNlcmlhbD0lbGxkIGxvZz0lcyA6IHRpbWU9JWxsdSBsZW49
JWQgZmxhZ3M9JyVzJyBoYW5kbGU9JXggcmVsYXRlZF9oYW5kbGU9JXggbWFpbnRfb3BfY2xhc3M9
JXUgbWFpbnRfb3Bfc3ViX2NsYXNzPSV1IDogZHBhPSVsbHggZHBhX2ZsYWdzPSclcycgZGVzY3Jp
cHRvcj0nJXMnIHR5cGU9JyVzJyBzdWJfdHlwZT0nJXMnIHRyYW5zYWN0aW9uX3R5cGU9JyVzJyBj
aGFubmVsPSV1IHJhbms9JXUgZGV2aWNlPSV4IHZhbGlkaXR5X2ZsYWdzPSclcycgY29tcF9pZD0l
cyBjb21wX2lkX3BsZG1fdmFsaWRfZmxhZ3M9JyVzJyBwbGRtX2VudGl0eV9pZD0lcyBwbGRtX3Jl
c291cmNlX2lkPSVzIGhwYT0lbGx4IGNtZV90aHJlc2hvbGRfZXZfZmxhZ3M9JyVzJyBjbWVfY291
bnQ9JXggcmVnaW9uPSVzIiwgX19nZXRfc3RyKG1lbWRldiksIF9fZ2V0X3N0cihob3N0KSwgUkVD
LT5zZXJpYWwsIF9fcHJpbnRfc3ltYm9saWMoUkVDLT5sb2csIHsgQ1hMX0VWRU5UX1RZUEVfSU5G
TywgIkluZm9ybWF0aW9uYWwiIH0sIHsgQ1hMX0VWRU5UX1RZUEVfV0FSTiwgIldhcm5pbmciIH0s
IHsgQ1hMX0VWRU5UX1RZUEVfRkFJTCwgIkZhaWx1cmUiIH0sIHsgQ1hMX0VWRU5UX1RZUEVfRkFU
QUwsICJGYXRhbCIgfSksIFJFQy0+aGRyX3RpbWVzdGFtcCwgUkVDLT5oZHJfbGVuZ3RoLCBfX3By
aW50X2ZsYWdzKFJFQy0+aGRyX2ZsYWdzLCAiIHwgIiwgeyAoKCgoMVVMKSkpIDw8ICgyKSksICJQ
RVJNQU5FTlRfQ09ORElUSU9OIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDMpKSwgIk1BSU5URU5BTkNF
X05FRURFRCIgfSwgeyAoKCgoMVVMKSkpIDw8ICg0KSksICJQRVJGT1JNQU5DRV9ERUdSQURFRCIg
fSwgeyAoKCgoMVVMKSkpIDw8ICg1KSksICJIQVJEV0FSRV9SRVBMQUNFTUVOVF9ORUVERUQiIH0s
IHsgKCgoKDFVTCkpKSA8PCAoNikpLCAiTUFJTlRfT1BfU1VCX0NMQVNTX1ZBTElEIiB9ICksIFJF
Qy0+aGRyX2hhbmRsZSwgUkVDLT5oZHJfcmVsYXRlZF9oYW5kbGUsIFJFQy0+aGRyX21haW50X29w
X2NsYXNzLCBSRUMtPmhkcl9tYWludF9vcF9zdWJfY2xhc3MsIFJFQy0+ZHBhLCBfX3ByaW50X2Zs
YWdzKFJFQy0+ZHBhX2ZsYWdzLCAifCIsIHsgKCgoKDFVTCkpKSA8PCAoMCkpLCAiVk9MQVRJTEUi
IH0sIHsgKCgoKDFVTCkpKSA8PCAoMSkpLCAiTk9UX1JFUEFJUkFCTEUiIH0gKSwgX19wcmludF9m
bGFncyhSRUMtPmRlc2NyaXB0b3IsICJ8IiwgeyAoKCgoMVVMKSkpIDw8ICgwKSksICJVTkNPUlJF
Q1RBQkxFX0VWRU5UIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDEpKSwgIlRIUkVTSE9MRF9FVkVOVCIg
fSwgeyAoKCgoMVVMKSkpIDw8ICgyKSksICJQT0lTT05fTElTVF9PVkVSRkxPVyIgfSApLCBfX3By
aW50X3N5bWJvbGljKFJFQy0+dHlwZSwgeyAweDAwLCAiRUNDIEVycm9yIiB9LCB7IDB4MDEsICJJ
bnZhbGlkIEFkZHJlc3MiIH0sIHsgMHgwMiwgIkRhdGEgUGF0aCBFcnJvciIgfSwgeyAweDAzLCAi
VEUgU3RhdGUgVmlvbGF0aW9uIiB9LCB7IDB4MDQsICJTY3J1YiBNZWRpYSBFQ0MgRXJyb3IiIH0s
IHsgMHgwNSwgIkFkdiBQcm9nIENNRSBDb3VudGVyIEV4cGlyYXRpb24iIH0sIHsgMHgwNiwgIkNL
SUQgVmlvbGF0aW9uIiB9ICksIF9fcHJpbnRfc3ltYm9saWMoUkVDLT5zdWJfdHlwZSwgeyAweDAw
LCAiTm90IFJlcG9ydGVkIiB9LCB7IDB4MDEsICJJbnRlcm5hbCBEYXRhcGF0aCBFcnJvciIgfSwg
eyAweDAyLCAiTWVkaWEgTGluayBDb21tYW5kIFRyYWluaW5nIEVycm9yIiB9LCB7IDB4MDMsICJN
ZWRpYSBMaW5rIENvbnRyb2wgVHJhaW5pbmcgRXJyb3IiIH0sIHsgMHgwNCwgIk1lZGlhIExpbmsg
RGF0YSBUcmFpbmluZyBFcnJvciIgfSwgeyAweDA1LCAiTWVkaWEgTGluayBDUkMgRXJyb3IiIH0g
KSwgX19wcmludF9zeW1ib2xpYyhSRUMtPnRyYW5zYWN0aW9uX3R5cGUsIHsgMHgwMCwgIlVua25v
d24iIH0sIHsgMHgwMSwgIkhvc3QgUmVhZCIgfSwgeyAweDAyLCAiSG9zdCBXcml0ZSIgfSwgeyAw
eDAzLCAiSG9zdCBTY2FuIE1lZGlhIiB9LCB7IDB4MDQsICJIb3N0IEluamVjdCBQb2lzb24iIH0s
IHsgMHgwNSwgIkludGVybmFsIE1lZGlhIFNjcnViIiB9LCB7IDB4MDYsICJJbnRlcm5hbCBNZWRp
YSBNYW5hZ2VtZW50IiB9LCB7IDB4MDcsICJJbnRlcm5hbCBNZWRpYSBFcnJvciBDaGVjayBTY3J1
YiIgfSwgeyAweDA4LCAiTWVkaWEgSW5pdGlhbGl6YXRpb24iIH0gKSwgUkVDLT5jaGFubmVsLCBS
RUMtPnJhbmssIFJFQy0+ZGV2aWNlLCBfX3ByaW50X2ZsYWdzKFJFQy0+dmFsaWRpdHlfZmxhZ3Ms
ICJ8IiwgeyAoKCgoMVVMKSkpIDw8ICgwKSksICJDSEFOTkVMIiB9LCB7ICgoKCgxVUwpKSkgPDwg
KDEpKSwgIlJBTksiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMikpLCAiREVWSUNFIiB9LCB7ICgoKCgx
VUwpKSkgPDwgKDMpKSwgIkNPTVBPTkVOVCIgfSwgeyAoKCgoMVVMKSkpIDw8ICg0KSksICJDT01Q
T05FTlQgUExETSBGT1JNQVQiIH0gKSwgX19wcmludF9oZXgoUkVDLT5jb21wX2lkLCAweDEwKSwg
X19wcmludF9mbGFncyhSRUMtPmNvbXBfaWRbMF0sICIgfCAiLCB7ICgoKCgxVUwpKSkgPDwgKDAp
KSwgIlBMRE0gRW50aXR5IElEIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDEpKSwgIlJlc291cmNlIElE
IiB9ICksIChSRUMtPnZhbGlkaXR5X2ZsYWdzICYgKCgoKDFVTCkpKSA8PCAoMykpICYmIFJFQy0+
dmFsaWRpdHlfZmxhZ3MgJiAoKCgoMVVMKSkpIDw8ICg0KSkpID8gKFJFQy0+Y29tcF9pZFswXSAm
ICgoKCgxVUwpKSkgPDwgKDApKSkgPyBfX3ByaW50X2hleCgmUkVDLT5jb21wX2lkWzFdLCA2KSA6
ICIweDAwIiA6ICIweDAwIiwgKFJFQy0+dmFsaWRpdHlfZmxhZ3MgJiAoKCgoMVVMKSkpIDw8ICgz
KSkgJiYgUkVDLT52YWxpZGl0eV9mbGFncyAmICgoKCgxVUwpKSkgPDwgKDQpKSkgPyAoUkVDLT5j
b21wX2lkWzBdICYgKCgoKDFVTCkpKSA8PCAoMSkpKSA/IF9fcHJpbnRfaGV4KCZSRUMtPmNvbXBf
aWRbN10sIDQpIDogIjB4MDAiIDogIjB4MDAiLCBSRUMtPmhwYSwgX19wcmludF9mbGFncyhSRUMt
PmNtZV90aHJlc2hvbGRfZXZfZmxhZ3MsICJ8IiwgeyAoKCgoMVVMKSkpIDw8ICgwKSksICJDb3Jy
ZWN0ZWQgTWVtb3J5IEVycm9ycyBpbiBNdWx0aXBsZSBNZWRpYSBDb21wb25lbnRzIiB9LCB7ICgo
KCgxVUwpKSkgPDwgKDEpKSwgIkV4Y2VlZGVkIFByb2dyYW1tYWJsZSBUaHJlc2hvbGQiIH0gKSwg
UkVDLT5jbWVfY291bnQsIF9fZ2V0X3N0cihyZWdpb25fbmFtZSkKCg==

--_003_53a299d3cca6417d90d553e8399f834bhuaweicom_
Content-Type: text/plain; name="format_cxl_general_media_v3.1_basic.txt"
Content-Description: format_cxl_general_media_v3.1_basic.txt
Content-Disposition: attachment;
	filename="format_cxl_general_media_v3.1_basic.txt"; size=4463;
	creation-date="Wed, 27 Nov 2024 18:18:37 GMT";
	modification-date="Wed, 27 Nov 2024 18:18:37 GMT"
Content-Transfer-Encoding: base64

cm9vdEBsb2NhbGhvc3Q6fiMgIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL2V2ZW50cy9j
eGwvY3hsX2dlbmVyYWxfbWVkaWEvZm9ybWF0IApuYW1lOiBjeGxfZ2VuZXJhbF9tZWRpYQpJRDog
MTQ2NApmb3JtYXQ6CglmaWVsZDp1bnNpZ25lZCBzaG9ydCBjb21tb25fdHlwZTsJb2Zmc2V0OjA7
CXNpemU6MjsJc2lnbmVkOjA7CglmaWVsZDp1bnNpZ25lZCBjaGFyIGNvbW1vbl9mbGFnczsJb2Zm
c2V0OjI7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1bnNpZ25lZCBjaGFyIGNvbW1vbl9wcmVl
bXB0X2NvdW50OwlvZmZzZXQ6MzsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOmludCBjb21tb25f
cGlkOwlvZmZzZXQ6NDsJc2l6ZTo0OwlzaWduZWQ6MTsKCglmaWVsZDpfX2RhdGFfbG9jIGNoYXJb
XSBtZW1kZXY7CW9mZnNldDo4OwlzaXplOjQ7CXNpZ25lZDowOwoJZmllbGQ6X19kYXRhX2xvYyBj
aGFyW10gaG9zdDsJb2Zmc2V0OjEyOwlzaXplOjQ7CXNpZ25lZDowOwoJZmllbGQ6aW50IGxvZzsJ
b2Zmc2V0OjE2OwlzaXplOjQ7CXNpZ25lZDoxOwoJZmllbGQ6dTY0IHNlcmlhbDsJb2Zmc2V0OjI0
OwlzaXplOjg7CXNpZ25lZDowOwoJZmllbGQ6dTMyIGhkcl9mbGFnczsJb2Zmc2V0OjMyOwlzaXpl
OjQ7CXNpZ25lZDowOwoJZmllbGQ6dTE2IGhkcl9oYW5kbGU7CW9mZnNldDozNjsJc2l6ZToyOwlz
aWduZWQ6MDsKCWZpZWxkOnUxNiBoZHJfcmVsYXRlZF9oYW5kbGU7CW9mZnNldDozODsJc2l6ZToy
OwlzaWduZWQ6MDsKCWZpZWxkOnU2NCBoZHJfdGltZXN0YW1wOwlvZmZzZXQ6NDA7CXNpemU6ODsJ
c2lnbmVkOjA7CglmaWVsZDp1OCBoZHJfbGVuZ3RoOwlvZmZzZXQ6NDg7CXNpemU6MTsJc2lnbmVk
OjA7CglmaWVsZDp1OCBoZHJfbWFpbnRfb3BfY2xhc3M7CW9mZnNldDo0OTsJc2l6ZToxOwlzaWdu
ZWQ6MDsKCWZpZWxkOnU4IGhkcl9tYWludF9vcF9zdWJfY2xhc3M7CW9mZnNldDo1MDsJc2l6ZTox
OwlzaWduZWQ6MDsKCWZpZWxkOnU2NCBkcGE7CW9mZnNldDo1NjsJc2l6ZTo4OwlzaWduZWQ6MDsK
CWZpZWxkOnU4IGRlc2NyaXB0b3I7CW9mZnNldDo2NDsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxk
OnU4IHR5cGU7CW9mZnNldDo2NTsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOnU4IHRyYW5zYWN0
aW9uX3R5cGU7CW9mZnNldDo2NjsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOnU4IGNoYW5uZWw7
CW9mZnNldDo2NzsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOnUzMiBkZXZpY2U7CW9mZnNldDo2
ODsJc2l6ZTo0OwlzaWduZWQ6MDsKCWZpZWxkOnU4IGNvbXBfaWRbMTZdOwlvZmZzZXQ6NzI7CXNp
emU6MTY7CXNpZ25lZDowOwoJZmllbGQ6dTY0IGhwYTsJb2Zmc2V0Ojg4OwlzaXplOjg7CXNpZ25l
ZDowOwoJZmllbGQ6dTE2IHZhbGlkaXR5X2ZsYWdzOwlvZmZzZXQ6OTY7CXNpemU6MjsJc2lnbmVk
OjA7CglmaWVsZDp1OCByYW5rOwlvZmZzZXQ6OTg7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1
OCBkcGFfZmxhZ3M7CW9mZnNldDo5OTsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOl9fZGF0YV9s
b2MgY2hhcltdIHJlZ2lvbl9uYW1lOwlvZmZzZXQ6MTAwOwlzaXplOjQ7CXNpZ25lZDowOwoJZmll
bGQ6dTggc3ViX3R5cGU7CW9mZnNldDoxMDQ7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1OCBj
bWVfdGhyZXNob2xkX2V2X2ZsYWdzOwlvZmZzZXQ6MTA1OwlzaXplOjE7CXNpZ25lZDowOwoJZmll
bGQ6dTMyIGNtZV9jb3VudDsJb2Zmc2V0OjEwODsJc2l6ZTo0OwlzaWduZWQ6MDsKCnByaW50IGZt
dDogIm1lbWRldj0lcyBob3N0PSVzIHNlcmlhbD0lbGxkIGxvZz0lcyA6IHRpbWU9JWxsdSBsZW49
JWQgZmxhZ3M9JyVzJyBoYW5kbGU9JXggcmVsYXRlZF9oYW5kbGU9JXggbWFpbnRfb3BfY2xhc3M9
JXUgbWFpbnRfb3Bfc3ViX2NsYXNzPSV1IDogZHBhPSVsbHggZHBhX2ZsYWdzPSclcycgZGVzY3Jp
cHRvcj0nJXMnIHR5cGU9JyVzJyB0cmFuc2FjdGlvbl90eXBlPSclcycgY2hhbm5lbD0ldSByYW5r
PSV1IGRldmljZT0leCB2YWxpZGl0eV9mbGFncz0nJXMnIGNvbXBfaWQ9JXMgaHBhPSVsbHggcmVn
aW9uPSVzIHN1Yl90eXBlPSclcycgY21lX3RocmVzaG9sZF9ldl9mbGFncz0nJXMnIGNtZV9jb3Vu
dD0ldSIsIF9fZ2V0X3N0cihtZW1kZXYpLCBfX2dldF9zdHIoaG9zdCksIFJFQy0+c2VyaWFsLCBf
X3ByaW50X3N5bWJvbGljKFJFQy0+bG9nLCB7IENYTF9FVkVOVF9UWVBFX0lORk8sICJJbmZvcm1h
dGlvbmFsIiB9LCB7IENYTF9FVkVOVF9UWVBFX1dBUk4sICJXYXJuaW5nIiB9LCB7IENYTF9FVkVO
VF9UWVBFX0ZBSUwsICJGYWlsdXJlIiB9LCB7IENYTF9FVkVOVF9UWVBFX0ZBVEFMLCAiRmF0YWwi
IH0pLCBSRUMtPmhkcl90aW1lc3RhbXAsIFJFQy0+aGRyX2xlbmd0aCwgX19wcmludF9mbGFncyhS
RUMtPmhkcl9mbGFncywgIiB8ICIsIHsgKCgoKDFVTCkpKSA8PCAoMikpLCAiUEVSTUFORU5UX0NP
TkRJVElPTiIgfSwgeyAoKCgoMVVMKSkpIDw8ICgzKSksICJNQUlOVEVOQU5DRV9ORUVERUQiIH0s
IHsgKCgoKDFVTCkpKSA8PCAoNCkpLCAiUEVSRk9STUFOQ0VfREVHUkFERUQiIH0sIHsgKCgoKDFV
TCkpKSA8PCAoNSkpLCAiSEFSRFdBUkVfUkVQTEFDRU1FTlRfTkVFREVEIiB9LCB7ICgoKCgxVUwp
KSkgPDwgKDYpKSwgIk1BSU5UX09QX1NVQl9DTEFTU19WQUxJRCIgfSApLCBSRUMtPmhkcl9oYW5k
bGUsIFJFQy0+aGRyX3JlbGF0ZWRfaGFuZGxlLCBSRUMtPmhkcl9tYWludF9vcF9jbGFzcywgUkVD
LT5oZHJfbWFpbnRfb3Bfc3ViX2NsYXNzLCBSRUMtPmRwYSwgX19wcmludF9mbGFncyhSRUMtPmRw
YV9mbGFncywgInwiLCB7ICgoKCgxVUwpKSkgPDwgKDApKSwgIlZPTEFUSUxFIiB9LCB7ICgoKCgx
VUwpKSkgPDwgKDEpKSwgIk5PVF9SRVBBSVJBQkxFIiB9ICksIF9fcHJpbnRfZmxhZ3MoUkVDLT5k
ZXNjcmlwdG9yLCAifCIsIHsgKCgoKDFVTCkpKSA8PCAoMCkpLCAiVU5DT1JSRUNUQUJMRV9FVkVO
VCIgfSwgeyAoKCgoMVVMKSkpIDw8ICgxKSksICJUSFJFU0hPTERfRVZFTlQiIH0sIHsgKCgoKDFV
TCkpKSA8PCAoMikpLCAiUE9JU09OX0xJU1RfT1ZFUkZMT1ciIH0gKSwgX19wcmludF9zeW1ib2xp
YyhSRUMtPnR5cGUsIHsgMHgwMCwgIkVDQyBFcnJvciIgfSwgeyAweDAxLCAiSW52YWxpZCBBZGRy
ZXNzIiB9LCB7IDB4MDIsICJEYXRhIFBhdGggRXJyb3IiIH0sIHsgMHgwMywgIlRFIFN0YXRlIFZp
b2xhdGlvbiIgfSwgeyAweDA0LCAiU2NydWIgTWVkaWEgRUNDIEVycm9yIiB9LCB7IDB4MDUsICJB
ZHYgUHJvZyBDTUUgQ291bnRlciBFeHBpcmF0aW9uIiB9LCB7IDB4MDYsICJDS0lEIFZpb2xhdGlv
biIgfSApLCBfX3ByaW50X3N5bWJvbGljKFJFQy0+dHJhbnNhY3Rpb25fdHlwZSwgeyAweDAwLCAi
VW5rbm93biIgfSwgeyAweDAxLCAiSG9zdCBSZWFkIiB9LCB7IDB4MDIsICJIb3N0IFdyaXRlIiB9
LCB7IDB4MDMsICJIb3N0IFNjYW4gTWVkaWEiIH0sIHsgMHgwNCwgIkhvc3QgSW5qZWN0IFBvaXNv
biIgfSwgeyAweDA1LCAiSW50ZXJuYWwgTWVkaWEgU2NydWIiIH0sIHsgMHgwNiwgIkludGVybmFs
IE1lZGlhIE1hbmFnZW1lbnQiIH0sIHsgMHgwNywgIkludGVybmFsIE1lZGlhIEVycm9yIENoZWNr
IFNjcnViIiB9LCB7IDB4MDgsICJNZWRpYSBJbml0aWFsaXphdGlvbiIgfSApLCBSRUMtPmNoYW5u
ZWwsIFJFQy0+cmFuaywgUkVDLT5kZXZpY2UsIF9fcHJpbnRfZmxhZ3MoUkVDLT52YWxpZGl0eV9m
bGFncywgInwiLCB7ICgoKCgxVUwpKSkgPDwgKDApKSwgIkNIQU5ORUwiIH0sIHsgKCgoKDFVTCkp
KSA8PCAoMSkpLCAiUkFOSyIgfSwgeyAoKCgoMVVMKSkpIDw8ICgyKSksICJERVZJQ0UiIH0sIHsg
KCgoKDFVTCkpKSA8PCAoMykpLCAiQ09NUE9ORU5UIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDQpKSwg
IkNPTVBPTkVOVCBQTERNIEZPUk1BVCIgfSApLCBfX3ByaW50X2hleChSRUMtPmNvbXBfaWQsIDB4
MTApLCBSRUMtPmhwYSwgX19nZXRfc3RyKHJlZ2lvbl9uYW1lKSwgX19wcmludF9zeW1ib2xpYyhS
RUMtPnN1Yl90eXBlLCB7IDB4MDAsICJOb3QgUmVwb3J0ZWQiIH0sIHsgMHgwMSwgIkludGVybmFs
IERhdGFwYXRoIEVycm9yIiB9LCB7IDB4MDIsICJNZWRpYSBMaW5rIENvbW1hbmQgVHJhaW5pbmcg
RXJyb3IiIH0sIHsgMHgwMywgIk1lZGlhIExpbmsgQ29udHJvbCBUcmFpbmluZyBFcnJvciIgfSwg
eyAweDA0LCAiTWVkaWEgTGluayBEYXRhIFRyYWluaW5nIEVycm9yIiB9LCB7IDB4MDUsICJNZWRp
YSBMaW5rIENSQyBFcnJvciIgfSApLCBfX3ByaW50X2ZsYWdzKFJFQy0+Y21lX3RocmVzaG9sZF9l
dl9mbGFncywgInwiLCB7ICgoKCgxVUwpKSkgPDwgKDApKSwgIkNvcnJlY3RlZCBNZW1vcnkgRXJy
b3JzIGluIE11bHRpcGxlIE1lZGlhIENvbXBvbmVudHMiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMSkp
LCAiRXhjZWVkZWQgUHJvZ3JhbW1hYmxlIFRocmVzaG9sZCIgfSApLCBSRUMtPmNtZV9jb3VudApy
b290QGxvY2FsaG9zdDp+Iwo=

--_003_53a299d3cca6417d90d553e8399f834bhuaweicom_--
