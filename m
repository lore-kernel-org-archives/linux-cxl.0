Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3884E1C;
	Thu, 28 Nov 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788105; cv=none; b=oPJexmm29rY02ACaaDIw3gENJ36bF1H1J40XxN0BJ9RDxikb+VIIDVCdpHhJaR9yqwtAGBudwd+/bHkEZyfcf8Xn6yoSwRoLR1wUgn+A5LfNKod14Hc8Hv2ij/qzayPg6/pUDf/SE3XIr0tUjwt1eC87Vjk4HhA+o9FKlOI4zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788105; c=relaxed/simple;
	bh=Jdns2vx5CZFvAyp+b8F491YQ0UWqFgle+13haa4e7/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6X3AgEkWpR5vsj5x7+ZHm1mKL51dec7SiTZXVRTxLW6QTT8Of5y+z6yJkXLipfRdz3K9c1yTOh2TSQ38gJOy/r41RQMxaC5AgDdHCIrDTSj4ZbsSmRwqmigPzCQ32nI4kte5lJ5G4x0lz+q2ATX7D2D0i+bI4ydMniGpuL3UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XzWvW4d3dz6K6CX;
	Thu, 28 Nov 2024 17:57:43 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A1D211400F4;
	Thu, 28 Nov 2024 18:01:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 11:01:39 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 28 Nov 2024 11:01:39 +0100
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
Thread-Index: AQHbOy/jEKs9N8Ou/EWSGme10Yml3rLJc4IQgABPV4CAAS95QIAATDQAgAA1zlD///prgIABEYyg
Date: Thu, 28 Nov 2024 10:01:39 +0000
Message-ID: <dc8fa73e871949eeaf4117c622d66ac5@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
	<20241127104132.6c1729e1@gandalf.local.home>
	<53a299d3cca6417d90d553e8399f834b@huawei.com>
 <20241127133407.7bc1376a@gandalf.local.home>
In-Reply-To: <20241127133407.7bc1376a@gandalf.local.home>
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
>From: Steven Rostedt <rostedt@goodmis.org>
>Sent: 27 November 2024 18:34
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
>On Wed, 27 Nov 2024 18:20:26 +0000
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> I tested removing hdr_uuid and region_uuid from the rasdaemon test
>> setup as you suggested. As a result, libtraceevent parses correctly, as =
you
>mentioned.
>>
>> However, I encounter  similar parsing error ("FAILED TO PARSE") when I
>> add two additional decoded strings (%s) to the TP_printk, replacing
>> (%u). Please see the attached format file,
>"format_cxl_general_media_v3.1_basic", for your reference.
>
>Are you sure. I don't see anything wrong with that one. Which version of
>libtraceevent do you have?

libtraceevent source code version 1.8.4,  build for arm64.

>
>>
>> I've also attached another format file,
>> "format_cxl_general_media_v3.1_full",
>> which contains the complete TP_printk() intended.
>
>This one has some complex arguments and also uses the '&' address of an
>argument.
Thanks.
I will debug this when basic one is working.
>
>>
>> Can you please help or else can you share how to debug these errors in
>> the libtraceevent setup?
>
>Basically, I use the attached program (that just links to libtraceevent).
>
>Note, I need to delete the first line of your files, which has the "cat"
>command. But you can run this on the file itself:
>
>  ./tep_load_event /sys/kernel/tracing/events/cxl/cxl_general_media/format
>
>But you may need to be root to do that. If root just copies that file, you=
 can then
>run it as non-root.
>
> # cp /sys/kernel/tracing/events/cxl/cxl_general_media/format /tmp  $
>./tep_load_event /tmp/format
>
>I run it under gdb and see where it fails. But it should let you know if i=
t will pass
>or not. I put a breakpoint on tep_warning and when it gets hit, I examine =
what it
>did up to that point.

Thanks Steve for the instructions. I will try this.
>
>-- Steve

Thanks,
Shiju

