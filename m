Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FF1991AA;
	Fri, 29 Nov 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886568; cv=none; b=sVhXq4MIfzufRdJZBW3zIadfpsLKNOSJ6JgI7fvY4J1TMdW77lPlNsT4q3WSVEDzLhZ0RUWpmSmSghabPKqwBcWgqqmiEdie0CZsEmr4rrz+mji8ZnSKBnZcUT/SusOaCIvVJnOVhuMx0c0BBHZmyBaCyJVHFkU2sN2MVaPi72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886568; c=relaxed/simple;
	bh=sYfc59DNgMeuMRFfCk7PwPvb08s/LqzJFxW8ncctZyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1jmEUTVUvwpjv1fR92Z7q93Qpv6sgRJI7TFcmFYza2cs1aGFTgDnfGGl/+LMIzSnR791P83fYS+ye1JunvOlSU9moG0Ozm01ohe/CGVq6NjcMfmUT8PMdQ24DGRlbN4688ZL1uqLND827yrQyDl228IIcVG0GD66tQBaaswpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y0DJq1cskz688BZ;
	Fri, 29 Nov 2024 21:18:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D4EDB140680;
	Fri, 29 Nov 2024 21:22:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 14:22:34 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 29 Nov 2024 14:22:34 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>, Steven Rostedt <rostedt@goodmis.org>
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
Thread-Index: AQHbOy/jEKs9N8Ou/EWSGme10Yml3rLJc4IQgABPV4CAAS95QIAATDQAgAA1zlD///prgIABEYyggAHA21A=
Date: Fri, 29 Nov 2024 13:22:34 +0000
Message-ID: <3c9808a694d242cab35bab67602edebf@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
	<20241127104132.6c1729e1@gandalf.local.home>
	<53a299d3cca6417d90d553e8399f834b@huawei.com>
 <20241127133407.7bc1376a@gandalf.local.home>
 <dc8fa73e871949eeaf4117c622d66ac5@huawei.com>
In-Reply-To: <dc8fa73e871949eeaf4117c622d66ac5@huawei.com>
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
>From: Shiju Jose <shiju.jose@huawei.com>
>Sent: 28 November 2024 10:02
>To: Steven Rostedt <rostedt@goodmis.org>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=
;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: RE: [PATCH v4 3/6] cxl/events: Update General Media Event Record =
to
>CXL spec rev 3.1
>
>>-----Original Message-----
>>From: Steven Rostedt <rostedt@goodmis.org>
>>Sent: 27 November 2024 18:34
>>To: Shiju Jose <shiju.jose@huawei.com>
>>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
>><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>>dave@stgolabs.net; linux-cxl@vger.kernel.org;
>>linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
>>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>><prime.zeng@hisilicon.com>
>>Subject: Re: [PATCH v4 3/6] cxl/events: Update General Media Event
>>Record to CXL spec rev 3.1
>>
>>On Wed, 27 Nov 2024 18:20:26 +0000
>>Shiju Jose <shiju.jose@huawei.com> wrote:
>>
>>> I tested removing hdr_uuid and region_uuid from the rasdaemon test
>>> setup as you suggested. As a result, libtraceevent parses correctly,
>>> as you
>>mentioned.
>>>
>>> However, I encounter  similar parsing error ("FAILED TO PARSE") when
>>> I add two additional decoded strings (%s) to the TP_printk, replacing
>>> (%u). Please see the attached format file,
>>"format_cxl_general_media_v3.1_basic", for your reference.
>>
>>Are you sure. I don't see anything wrong with that one. Which version
>>of libtraceevent do you have?
>
>libtraceevent source code version 1.8.4,  build for arm64.

Hi Steve,

I debug this case and please find the info,
1. rasdaemon :  read() from format file return around 1/3rd of the=20
    actual data in the file only when the total size of the format's file
    is above 4K bytes (page size), For example, in this case, the total siz=
e was 4512 bytes,
    but read only 1674 bytes.
    This partial data resulted  tep_parse_event() in libtraceevent failed i=
nternally in the parse_format()    =20
    and  since __parse_event() does not return error when parse_format() fa=
il,
    thus initialization of the event does not fail.
    =20
   The following  solution in rasdaemon solved the issue,=20
   (provided if no other fix for the above issue with read()),=20
    1. read() and accumulate content of format file until EOF reached.
    2. Increased the buffer size from 4K bytes to  8K bytes.
    3. May be __parse_event()  in libtraceevent  and thus tep_parse_event()=
  return error
        when parse_format() fail so that the initialization would fail if t=
he input data is
        corrupted or partial?  =20
>
>>
>>>
>>> I've also attached another format file,
>>> "format_cxl_general_media_v3.1_full",
>>> which contains the complete TP_printk() intended.
>>
>>This one has some complex arguments and also uses the '&' address of an
>>argument.
>Thanks.
>I will debug this when basic one is working.

This case too worked  with above workaround after removing '&' address
from the TP_printk().
>>
>>>
>>> Can you please help or else can you share how to debug these errors
>>> in the libtraceevent setup?
>>
>>Basically, I use the attached program (that just links to libtraceevent).
>>
>>Note, I need to delete the first line of your files, which has the "cat"
>>command. But you can run this on the file itself:
>>
>>  ./tep_load_event
>> /sys/kernel/tracing/events/cxl/cxl_general_media/format
>>
>>But you may need to be root to do that. If root just copies that file,
>>you can then run it as non-root.
>>
>> # cp /sys/kernel/tracing/events/cxl/cxl_general_media/format /tmp  $
>>./tep_load_event /tmp/format
>>
>>I run it under gdb and see where it fails. But it should let you know
>>if it will pass or not. I put a breakpoint on tep_warning and when it
>>gets hit, I examine what it did up to that point.
>
>Thanks Steve for the instructions. I will try this.

I built tep_load_event.c for arm64 and it worked after copy
format file to the /tmp/ folder as you said.
>>
>>-- Steve
>

Thanks,
Shiju
