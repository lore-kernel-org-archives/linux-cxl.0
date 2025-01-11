Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EC15666D;
	Sat, 11 Jan 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586974; cv=none; b=edi0ruj4LH8sZDW6DX8Q0jrJhUvzt0jD4Htbsriv3crO1lqXUPcfi6J1VajzU9Zqeav6MaDSTKeTY4fOwUcgheEav+BFWG6ZozlRzYu+u4xK3YSRnyaTV/xqJC0HI1PFMcfqOjgPWy1eJMi41T++HhIO5YrMw0sVDXeQcBY2FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586974; c=relaxed/simple;
	bh=aidAE5sWIzSlsJ8//HNxNtyVM2SswKgKbRtaNpyGLOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YktGqQ8gLGBJK5P7KfM2JfSfa5/S951lo3yU4QTH1xcPKHCk2SuiMIIq5iFKMnVR4hfcaMNf2xqmv8shEdgcjd/GCcWhmMbRYziN/wTJ+MyJ4pkbBL49/XUdln6DejQ5iZWApgTP93ld9c/ND1HUJQ5VfCDVmRfwL+aHaylmCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YVXsK6Cmgz6M4Mw;
	Sat, 11 Jan 2025 17:14:29 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id D7146140442;
	Sat, 11 Jan 2025 17:16:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 11 Jan 2025 10:16:08 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Sat, 11 Jan 2025 10:16:08 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>
Subject: RE: [PATCH v5 4/6] cxl/events: Update DRAM Event Record to CXL spec
 rev 3.1
Thread-Topic: [PATCH v5 4/6] cxl/events: Update DRAM Event Record to CXL spec
 rev 3.1
Thread-Index: AQHbY1anZB/wtlQOlUm4MKKpsVLwfLMQQyoAgAEIbVA=
Date: Sat, 11 Jan 2025 09:16:07 +0000
Message-ID: <5a0d7679f7d44f07a47eb47651f9b8ca@huawei.com>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-5-shiju.jose@huawei.com>
 <678166907eb67_17789429416@iweiny-mobl.notmuch>
In-Reply-To: <678166907eb67_17789429416@iweiny-mobl.notmuch>
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
>Sent: 10 January 2025 18:27
>To: Shiju Jose <shiju.jose@huawei.com>; dave.jiang@intel.com;
>dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH v5 4/6] cxl/events: Update DRAM Event Record to CXL sp=
ec
>rev 3.1
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>
>[snip]
>
>>
>>  TRACE_EVENT(cxl_dram,
>> @@ -527,6 +539,7 @@ TRACE_EVENT(cxl_dram,
>>  		__field(u64, dpa)
>>  		__field(u8, descriptor)
>>  		__field(u8, type)
>> +		__field(u8, sub_type)
>
>I just noticed this with the previous patch too.  To pack the record this =
should be
>below...

Hi Ira,

Thanks for reviewing and for the feedbacks.=20
I have modified for your suggestions and will be in the v6.

Thanks,
Shiju

>
>>  		__field(u8, transaction_type)
>>  		__field(u8, channel)
>>  		__field(u16, validity_flags)
>> @@ -541,6 +554,10 @@ TRACE_EVENT(cxl_dram,
>>  		__field(u8, bank)	/* Out of order to pack trace record */
>>  		__field(u8, dpa_flags)	/* Out of order to pack trace record */
>
>Here.
>
>>  		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
>> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>> +		__field(u8, sub_channel)
>> +		__field(u8, cme_threshold_ev_flags)
>> +		__field(u32, cvme_count)
>>  	),
>
>And these reordered too.  Like this:
>
>diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>cbaf6244d77f..6f4bf4925cbf 100644
>--- a/drivers/cxl/core/trace.h
>+++ b/drivers/cxl/core/trace.h
>@@ -539,7 +539,6 @@ TRACE_EVENT(cxl_dram,
>                __field(u64, dpa)
>                __field(u8, descriptor)
>                __field(u8, type)
>-               __field(u8, sub_type)
>                __field(u8, transaction_type)
>                __field(u8, channel)
>                __field(u16, validity_flags) @@ -553,11 +552,13 @@
>TRACE_EVENT(cxl_dram,
>                __field(u8, bank_group) /* Out of order to pack trace reco=
rd */
>                __field(u8, bank)       /* Out of order to pack trace reco=
rd */
>                __field(u8, dpa_flags)  /* Out of order to pack trace reco=
rd */
>-               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
>+               /* The following are out of order to pack the trace
>+ record */
>                __array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>+               __field(u32, cvme_count)
>+               __field(u8, sub_type)
>                __field(u8, sub_channel)
>                __field(u8, cme_threshold_ev_flags)
>-               __field(u32, cvme_count)
>+               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
>        ),
>
>        TP_fast_assign(
>
>
>
>Other than that it looks good.  Perhaps Dave can just squash this hunk?
>
>Ira
>
>[snip]

