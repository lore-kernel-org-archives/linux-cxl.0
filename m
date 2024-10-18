Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268A210FB;
	Fri, 18 Oct 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253392; cv=none; b=B6V6oZ1LL1Wi3e7y63BxjQ3o7h0Mxtz+ipmwAswaWkbGelcmtW1p62o4n4nf1jgYiL53e7eCUT0/a3VYq8AtSs4x27hcZ4+XLRPEpi+a7rYG+McIRXS/iq9eDGu3UA0XH1QTP7SbaoMP4kIN+CamnaPwIVXVJuIPaglae/AoH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253392; c=relaxed/simple;
	bh=Z6IY0WLrQ+mbUTBQmT45upWo6R76pXinWA8IODszsrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aKkm6+phAs7y4kVkh1quc/54oPsy04Mh1AIu0GdUh2LnTo4vvTlkGF2Esc1a/W+6+uumwEJP0tWkOdlPCvXm/MzfwUJkmG+DVHBCrQRrKPWu//kClqeiltVZrB6Z+PLg880wDS1LXoDG6rUeQYeJ4dhDQNK2F8mfxOMc6JBeb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVNlz0vkNz6HJjB;
	Fri, 18 Oct 2024 20:09:03 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D7A21400F4;
	Fri, 18 Oct 2024 20:09:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:09:45 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 18 Oct 2024 14:09:45 +0200
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
Subject: RE: [RFC PATCH 0/4] Updates for CXL Event Records
Thread-Topic: [RFC PATCH 0/4] Updates for CXL Event Records
Thread-Index: AQHbH+k/0+IXcnhOQkao9dWzrwOFcLKMOZUAgAAzP8A=
Date: Fri, 18 Oct 2024 12:09:45 +0000
Message-ID: <5ca992144d644d2b88feb89c8fb5eabd@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
 <20241018120414.00006c61@Huawei.com>
In-Reply-To: <20241018120414.00006c61@Huawei.com>
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
>Sent: 18 October 2024 12:04
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel=
.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; dave@stgolabs.net; linux-
>cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>
>Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
>
>On Wed, 16 Oct 2024 17:33:45 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec rev 3.1 CXL Event Records has updated w.r.t CXL spec rev 3.0.
>> Add updates for the above spec changes in the CXL events records and
>> CXL trace events implementation.
>>
>> Note: Please apply following fix patch first if not present.
>> https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-s
>> hiju.jose@huawei.com/
>>
>> Shiju Jose (4):
>>   cxl/events: Updates for CXL Common Event Record Format
>>   cxl/events: Updates for CXL General Media Event Record
>>   cxl/events: Updates for CXL DRAM Event Record
>>   cxl/events: Updates for CXL Memory Module Event Record
>>
>>  drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
>>  include/cxl/event.h      |  20 +++-
>>  2 files changed, 190 insertions(+), 31 deletions(-)
>>
>
>Hi Shiju,
>
>Why are these an RFC?  Seem in a good state to me and the questions I'm se=
eing
>are naming stuff that to me doesn't justify RFC status.
>
>Jonathan

Hi Jonathan,

I add RFC since it is v1.  I will exclude RFC in v2. =20

Thanks,
Shiju
