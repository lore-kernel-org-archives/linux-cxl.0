Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CF140360;
	Wed, 27 Nov 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702339; cv=none; b=nKgqrTZrUcBZQh2OMWGxx9fEfk9qbFPEhAiwdAvMnIGA7qqq8YCJGL+13Z4ZOmOtOwJ/1KxfPBRg5lvreX5nj0qPd33gYi6QlMEwOWJwbTMkGBEB926W+SkvX/020fONRGxyRJz9EJY1BK8NpwXarrCwysIEoW/gnl0VViFxibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702339; c=relaxed/simple;
	bh=e6lnsTke15tAPeDX+qjTPgwLO/HwREfoYmiMIl73GkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lwrus+kv4aASDovSn/t01n/UzYjmWjMsGCFRw84y8afJ4nSb+qdrbEDufo+asdAX9EOLnbbLY86Re1/QwnDOTDEaWmRb8Cdtk91yZEMyPHCK99guEn+TEGK0hiehKhLtFT33CdT4kdVKePRVu49i81//2G/r1mgErYVqp2AhT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XywBC5cGHz6K71C;
	Wed, 27 Nov 2024 18:08:19 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 9810E1400CA;
	Wed, 27 Nov 2024 18:12:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 11:12:12 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 27 Nov 2024 11:12:12 +0100
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
Thread-Index: AQHbOy/jEKs9N8Ou/EWSGme10Yml3rLJc4IQgABPV4CAAS95QA==
Date: Wed, 27 Nov 2024 10:12:12 +0000
Message-ID: <a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
 <20241126120237.1598854d@gandalf.local.home>
In-Reply-To: <20241126120237.1598854d@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/mixed;
	boundary="_002_a24524dccbf442d5a3c910d7f46c7b6chuaweicom_"
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_a24524dccbf442d5a3c910d7f46c7b6chuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: Steven Rostedt <rostedt@goodmis.org>
>Sent: 26 November 2024 17:03
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
>On Tue, 26 Nov 2024 11:51:23 +0000
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> We are encountering a parsing error ("FAILED TO PARSE") from
>> libtraceevent  when it tries to parse some of the CXL trace events for t=
he user-
>space tool rasdaemon.
>> This issue appeared after new fields were added to the trace events.
>> It was found that the issue does not occur when all or some of the
>> decoded strings for the event's data and flags are removed from the
>> TP_printk() function in the kernel, and only the values are printed inst=
ead.
>> https://elixir.bootlin.com/linux/v6.12/source/drivers/cxl/core/trace.h
>> https://lore.kernel.org/lkml/20241120093745.1847-1-shiju.jose@huawei.c
>> om/
>>
>> Below is the information from the debugging in libtraceevent:
>> The failure occurs in the following functions and locations within libtr=
aceevent:
>> File: src/event-parse.c
>> Function: event_read_format()
>> ret =3D event_read_fields(event->tep, event, &event->format.fields); if =
(ret < 0)
>>     return ret;
>>
>> Function: event_read_fields()
>> if (test_type_token(type, token, TEP_EVENT_ITEM, "field"))
>>     goto fail;
>>
>> Can you recognize if there are any limitations or issues  that would
>> prevent libtraceevent from parsing the trace event in the condition desc=
ribed
>above?
>
>Can you show me the output of the format files for the affected trace even=
ts:
>
> # cat /sys/kernel/tracing/cxl/<affected_event>/format
>
>You can attach it too if your email does whitespace mangling.

Hi Steve,=20

Please find attached, output of  format file for the CXL general media trac=
e event.

>
>Thanks,
>
>-- Steve
Thanks,
Shiju

--_002_a24524dccbf442d5a3c910d7f46c7b6chuaweicom_
Content-Type: text/plain; name="format_cxl_general_media.txt"
Content-Description: format_cxl_general_media.txt
Content-Disposition: attachment; filename="format_cxl_general_media.txt";
	size=4222; creation-date="Wed, 27 Nov 2024 10:10:59 GMT";
	modification-date="Wed, 27 Nov 2024 10:10:59 GMT"
Content-Transfer-Encoding: base64

cm9vdEBsb2NhbGhvc3Q6fiMgY2F0IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2N4
bC9jeGxfZ2VuZXJhbF9tZWRpYS9mb3JtYXQgCm5hbWU6IGN4bF9nZW5lcmFsX21lZGlhCklEOiAx
NDY0CmZvcm1hdDoKCWZpZWxkOnVuc2lnbmVkIHNob3J0IGNvbW1vbl90eXBlOwlvZmZzZXQ6MDsJ
c2l6ZToyOwlzaWduZWQ6MDsKCWZpZWxkOnVuc2lnbmVkIGNoYXIgY29tbW9uX2ZsYWdzOwlvZmZz
ZXQ6MjsJc2l6ZToxOwlzaWduZWQ6MDsKCWZpZWxkOnVuc2lnbmVkIGNoYXIgY29tbW9uX3ByZWVt
cHRfY291bnQ7CW9mZnNldDozOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6aW50IGNvbW1vbl9w
aWQ7CW9mZnNldDo0OwlzaXplOjQ7CXNpZ25lZDoxOwoKCWZpZWxkOl9fZGF0YV9sb2MgY2hhcltd
IG1lbWRldjsJb2Zmc2V0Ojg7CXNpemU6NDsJc2lnbmVkOjA7CglmaWVsZDpfX2RhdGFfbG9jIGNo
YXJbXSBob3N0OwlvZmZzZXQ6MTI7CXNpemU6NDsJc2lnbmVkOjA7CglmaWVsZDppbnQgbG9nOwlv
ZmZzZXQ6MTY7CXNpemU6NDsJc2lnbmVkOjE7CglmaWVsZDp1dWlkX3QgaGRyX3V1aWQ7CW9mZnNl
dDoyMDsJc2l6ZToxNjsJc2lnbmVkOjA7CglmaWVsZDp1NjQgc2VyaWFsOwlvZmZzZXQ6NDA7CXNp
emU6ODsJc2lnbmVkOjA7CglmaWVsZDp1MzIgaGRyX2ZsYWdzOwlvZmZzZXQ6NDg7CXNpemU6NDsJ
c2lnbmVkOjA7CglmaWVsZDp1MTYgaGRyX2hhbmRsZTsJb2Zmc2V0OjUyOwlzaXplOjI7CXNpZ25l
ZDowOwoJZmllbGQ6dTE2IGhkcl9yZWxhdGVkX2hhbmRsZTsJb2Zmc2V0OjU0OwlzaXplOjI7CXNp
Z25lZDowOwoJZmllbGQ6dTY0IGhkcl90aW1lc3RhbXA7CW9mZnNldDo1NjsJc2l6ZTo4OwlzaWdu
ZWQ6MDsKCWZpZWxkOnU4IGhkcl9sZW5ndGg7CW9mZnNldDo2NDsJc2l6ZToxOwlzaWduZWQ6MDsK
CWZpZWxkOnU4IGhkcl9tYWludF9vcF9jbGFzczsJb2Zmc2V0OjY1OwlzaXplOjE7CXNpZ25lZDow
OwoJZmllbGQ6dTggaGRyX21haW50X29wX3N1Yl9jbGFzczsJb2Zmc2V0OjY2OwlzaXplOjE7CXNp
Z25lZDowOwoJZmllbGQ6dTY0IGRwYTsJb2Zmc2V0OjcyOwlzaXplOjg7CXNpZ25lZDowOwoJZmll
bGQ6dTggZGVzY3JpcHRvcjsJb2Zmc2V0OjgwOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTgg
dHlwZTsJb2Zmc2V0OjgxOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggdHJhbnNhY3Rpb25f
dHlwZTsJb2Zmc2V0OjgyOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTggY2hhbm5lbDsJb2Zm
c2V0OjgzOwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTMyIGRldmljZTsJb2Zmc2V0Ojg0Owlz
aXplOjQ7CXNpZ25lZDowOwoJZmllbGQ6dTggY29tcF9pZFsxNl07CW9mZnNldDo4ODsJc2l6ZTox
NjsJc2lnbmVkOjA7CglmaWVsZDp1NjQgaHBhOwlvZmZzZXQ6MTA0OwlzaXplOjg7CXNpZ25lZDow
OwoJZmllbGQ6dXVpZF90IHJlZ2lvbl91dWlkOwlvZmZzZXQ6MTEyOwlzaXplOjE2OwlzaWduZWQ6
MDsKCWZpZWxkOnUxNiB2YWxpZGl0eV9mbGFnczsJb2Zmc2V0OjEyODsJc2l6ZToyOwlzaWduZWQ6
MDsKCWZpZWxkOnU4IHJhbms7CW9mZnNldDoxMzA7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDp1
OCBkcGFfZmxhZ3M7CW9mZnNldDoxMzE7CXNpemU6MTsJc2lnbmVkOjA7CglmaWVsZDpfX2RhdGFf
bG9jIGNoYXJbXSByZWdpb25fbmFtZTsJb2Zmc2V0OjEzMjsJc2l6ZTo0OwlzaWduZWQ6MDsKCWZp
ZWxkOnU4IHN1Yl90eXBlOwlvZmZzZXQ6MTM2OwlzaXplOjE7CXNpZ25lZDowOwoJZmllbGQ6dTgg
Y21lX3RocmVzaG9sZF9ldl9mbGFnczsJb2Zmc2V0OjEzNzsJc2l6ZToxOwlzaWduZWQ6MDsKCWZp
ZWxkOnUzMiBjbWVfY291bnQ7CW9mZnNldDoxNDA7CXNpemU6NDsJc2lnbmVkOjA7CgpwcmludCBm
bXQ6ICJtZW1kZXY9JXMgaG9zdD0lcyBzZXJpYWw9JWxsZCBsb2c9JXMgOiB0aW1lPSVsbHUgdXVp
ZD0lcFViIGxlbj0lZCBmbGFncz0nJXMnIGhhbmRsZT0leCByZWxhdGVkX2hhbmRsZT0leCBtYWlu
dF9vcF9jbGFzcz0ldSBtYWludF9vcF9zdWJfY2xhc3M9JXUgOiBkcGE9JWxseCBkcGFfZmxhZ3M9
JyVzJyBkZXNjcmlwdG9yPSclcycgdHlwZT0nJXMnIHRyYW5zYWN0aW9uX3R5cGU9JyVzJyBjaGFu
bmVsPSV1IHJhbms9JXUgZGV2aWNlPSV4IHZhbGlkaXR5X2ZsYWdzPSclcycgY29tcF9pZD0lc2hw
YT0lbGx4IHJlZ2lvbj0lcyByZWdpb25fdXVpZD0lcFViIHN1Yl90eXBlPSV1IGNtZV90aHJlc2hv
bGRfZXZfZmxhZ3M9JXUgY21lX2NvdW50PSV1IiwgX19nZXRfc3RyKG1lbWRldiksIF9fZ2V0X3N0
cihob3N0KSwgUkVDLT5zZXJpYWwsIF9fcHJpbnRfc3ltYm9saWMoUkVDLT5sb2csIHsgQ1hMX0VW
RU5UX1RZUEVfSU5GTywgIkluZm9ybWF0aW9uYWwiIH0sIHsgQ1hMX0VWRU5UX1RZUEVfV0FSTiwg
Ildhcm5pbmciIH0sIHsgQ1hMX0VWRU5UX1RZUEVfRkFJTCwgIkZhaWx1cmUiIH0sIHsgQ1hMX0VW
RU5UX1RZUEVfRkFUQUwsICJGYXRhbCIgfSksIFJFQy0+aGRyX3RpbWVzdGFtcCwgJlJFQy0+aGRy
X3V1aWQsIFJFQy0+aGRyX2xlbmd0aCwgX19wcmludF9mbGFncyhSRUMtPmhkcl9mbGFncywgIiB8
ICIsIHsgKCgoKDFVTCkpKSA8PCAoMikpLCAiUEVSTUFORU5UX0NPTkRJVElPTiIgfSwgeyAoKCgo
MVVMKSkpIDw8ICgzKSksICJNQUlOVEVOQU5DRV9ORUVERUQiIH0sIHsgKCgoKDFVTCkpKSA8PCAo
NCkpLCAiUEVSRk9STUFOQ0VfREVHUkFERUQiIH0sIHsgKCgoKDFVTCkpKSA8PCAoNSkpLCAiSEFS
RFdBUkVfUkVQTEFDRU1FTlRfTkVFREVEIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDYpKSwgIk1BSU5U
X09QX1NVQl9DTEFTU19WQUxJRCIgfSApLCBSRUMtPmhkcl9oYW5kbGUsIFJFQy0+aGRyX3JlbGF0
ZWRfaGFuZGxlLCBSRUMtPmhkcl9tYWludF9vcF9jbGFzcywgUkVDLT5oZHJfbWFpbnRfb3Bfc3Vi
X2NsYXNzLCBSRUMtPmRwYSwgX19wcmludF9mbGFncyhSRUMtPmRwYV9mbGFncywgInwiLCB7ICgo
KCgxVUwpKSkgPDwgKDApKSwgIlZPTEFUSUxFIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDEpKSwgIk5P
VF9SRVBBSVJBQkxFIiB9ICksIF9fcHJpbnRfZmxhZ3MoUkVDLT5kZXNjcmlwdG9yLCAifCIsIHsg
KCgoKDFVTCkpKSA8PCAoMCkpLCAiVU5DT1JSRUNUQUJMRV9FVkVOVCIgfSwgeyAoKCgoMVVMKSkp
IDw8ICgxKSksICJUSFJFU0hPTERfRVZFTlQiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMikpLCAiUE9J
U09OX0xJU1RfT1ZFUkZMT1ciIH0gKSwgX19wcmludF9zeW1ib2xpYyhSRUMtPnR5cGUsIHsgMHgw
MCwgIkVDQyBFcnJvciIgfSwgeyAweDAxLCAiSW52YWxpZCBBZGRyZXNzIiB9LCB7IDB4MDIsICJE
YXRhIFBhdGggRXJyb3IiIH0sIHsgMHgwMywgIlRFIFN0YXRlIFZpb2xhdGlvbiIgfSwgeyAweDA0
LCAiU2NydWIgTWVkaWEgRUNDIEVycm9yIiB9LCB7IDB4MDUsICJBZHYgUHJvZyBDTUUgQ291bnRl
ciBFeHBpcmF0aW9uIiB9LCB7IDB4MDYsICJDS0lEIFZpb2xhdGlvbiIgfSApLCBfX3ByaW50X3N5
bWJvbGljKFJFQy0+dHJhbnNhY3Rpb25fdHlwZSwgeyAweDAwLCAiVW5rbm93biIgfSwgeyAweDAx
LCAiSG9zdCBSZWFkIiB9LCB7IDB4MDIsICJIb3N0IFdyaXRlIiB9LCB7IDB4MDMsICJIb3N0IFNj
YW4gTWVkaWEiIH0sIHsgMHgwNCwgIkhvc3QgSW5qZWN0IFBvaXNvbiIgfSwgeyAweDA1LCAiSW50
ZXJuYWwgTWVkaWEgU2NydWIiIH0sIHsgMHgwNiwgIkludGVybmFsIE1lZGlhIE1hbmFnZW1lbnQi
IH0sIHsgMHgwNywgIkludGVybmFsIE1lZGlhIEVycm9yIENoZWNrIFNjcnViIiB9LCB7IDB4MDgs
ICJNZWRpYSBJbml0aWFsaXphdGlvbiIgfSApLCBSRUMtPmNoYW5uZWwsIFJFQy0+cmFuaywgUkVD
LT5kZXZpY2UsIF9fcHJpbnRfZmxhZ3MoUkVDLT52YWxpZGl0eV9mbGFncywgInwiLCB7ICgoKCgx
VUwpKSkgPDwgKDApKSwgIkNIQU5ORUwiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMSkpLCAiUkFOSyIg
fSwgeyAoKCgoMVVMKSkpIDw8ICgyKSksICJERVZJQ0UiIH0sIHsgKCgoKDFVTCkpKSA8PCAoMykp
LCAiQ09NUE9ORU5UIiB9LCB7ICgoKCgxVUwpKSkgPDwgKDQpKSwgIkNPTVBPTkVOVCBQTERNIEZP
Uk1BVCIgfSApLCBfX3ByaW50X2hleChSRUMtPmNvbXBfaWQsIDB4MTApLCBSRUMtPmhwYSwgX19n
ZXRfc3RyKHJlZ2lvbl9uYW1lKSwgJlJFQy0+cmVnaW9uX3V1aWQsIFJFQy0+c3ViX3R5cGUsIFJF
Qy0+Y21lX3RocmVzaG9sZF9ldl9mbGFncywgUkVDLT5jbWVfY291bnQKcm9vdEBsb2NhbGhvc3Q6
fiMKCg==

--_002_a24524dccbf442d5a3c910d7f46c7b6chuaweicom_--
