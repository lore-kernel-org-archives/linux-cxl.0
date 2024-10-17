Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFD1DE3AC;
	Thu, 17 Oct 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176131; cv=none; b=Dq19nOnJieMwlsfXSI1lksIgbaoIxvEcX+8/6YiykMshSEDpT8OnLPNcPMlAG0H+GetDEWuz+0zrdG3zRtJe5OtgWkHu6cHRyThUWA0oHpUTO2uBWest8VLcQFpc1kw4XgONiKsdkBZz6b5R72WevQ1lXPmtmR2EyVQ6FgMePxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176131; c=relaxed/simple;
	bh=DUr1Bbl1dTjaF+Myu5nLSC86QGvopTVl0GcWgYO9HFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDvsdUIHKvIRa3rSGJAdfuLnmuyJBDWDFc/zW0FEkWKZccA3wroCqrgSf16bz3kRHxt9rViKDr8ud51n/QDaEB6RLpJH2/dAT6Ef9pVAhF9KFFCLEuM1gwS3K74KKzLb52pcoG/2ICXLmALBipG8haBI+8nnikqdXr5jzCmWjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTr5k6Cl4z6D8XS;
	Thu, 17 Oct 2024 22:37:30 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ABCE1400C9;
	Thu, 17 Oct 2024 22:42:02 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 16:42:02 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 16:42:02 +0200
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
Subject: RE: [RFC PATCH 2/4] cxl/events: Updates for CXL General Media Event
 Record
Thread-Topic: [RFC PATCH 2/4] cxl/events: Updates for CXL General Media Event
 Record
Thread-Index: AQHbH+lA8kAY8gTJ40eyU/HJxBint7KKvdeAgABHIrA=
Date: Thu, 17 Oct 2024 14:42:02 +0000
Message-ID: <4ace141bbae84ef69db3c0ae862e6822@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-3-shiju.jose@huawei.com>
 <20241017132505.00004cf4@Huawei.com>
In-Reply-To: <20241017132505.00004cf4@Huawei.com>
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
>Sent: 17 October 2024 13:25
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel=
.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dave@stgolabs.net; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>
>Subject: Re: [RFC PATCH 2/4] cxl/events: Updates for CXL General Media Eve=
nt
>Record
>
>On Wed, 16 Oct 2024 17:33:47 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
>> Record has updated with following new fields and new types for Memory
>> Event Type and Transaction Type fields.
>> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
>> 2. Corrected Memory Error Count at Event 3. Memory Event Sub-Type
>>
>> The component identifier format has changed (CXL spec 3.1 section
>> 8.2.9.2.1 Table 8-44).
>>
>> Add updates for the above spec changes in the CXL events record and
>> CXL general media trace event implementations.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>It might be worth breaking out the component ID formatting as a separate
>patch.  That comes in 3.1 along with the other fields but is perhaps more
>controversial?
I will add separate patch for component ID formatting.

>
>It's a good change, but will change what is printed. I 'think'
>tracepoint printing is typically not considered ABI though (unlike the tra=
cepoint
>which is!) so should be fine.
>
>Split or not I like the component ID formatting and the reset LGTM I also =
slight
>prefer the fact you inserted new fields in logical places (so disagree wit=
h Alison
>if that's what she meant).
>Good to call that out in the patch description though to highlight it as s=
omething
>people might want to consider.
Sure.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>> ---
>> Question:
>> Want more abbreviations for the long lines of code in
>> show_mem_event_sub_type() and for similar in other patches?
>I raised this in internal review, but don't think it matters that much eit=
her way :)
Ok.

Thanks,
Shiju
