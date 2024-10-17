Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383F1D90AD;
	Thu, 17 Oct 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158003; cv=none; b=dQTzZWdaAlQ8d2TCnU7K1yhIAe83J9NRzv2O5233ueeAgQhorXfDEIu8E4ffd+ooaXC2NaRdy9vVIDSM7XX2X44aBcOHTO0He7g7MLkCpQMPoT8rjgToqnjm4omDyGLRyZufuos73pps9WlX2KabIWP4VnNE69LYES+mUMmSXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158003; c=relaxed/simple;
	bh=xuD9QTlnC6oLH7eRBWFZmhsv/WyLxcLAV9aZjEiXovo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5iTL2Gy+qbgKTfGbut4m6LQEPGORCaIUTT+zjICP7avYKCKILPWnRk8TvTS9OfhjjYCo8M+HXrLbUPx1Rwn1e3YUTZqMaDINpnGukcR2LXYji5/tJUxkKJ55uf4W5BntHhEDIlhpo4qr6O5+I0gVEEKSPtIHQvwnHhMjJl+oZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTjSR0xWlz689SY;
	Thu, 17 Oct 2024 17:38:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id C74861400C9;
	Thu, 17 Oct 2024 17:39:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 11:39:58 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 11:39:58 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH 0/4] Updates for CXL Event Records
Thread-Topic: [RFC PATCH 0/4] Updates for CXL Event Records
Thread-Index: AQHbH+k/0+IXcnhOQkao9dWzrwOFcLKJu8cAgADzmYA=
Date: Thu, 17 Oct 2024 09:39:58 +0000
Message-ID: <9e221493ff4a456cbdd1b773c670d1c7@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
 <ZxAppnCBf4wFgcQ0@aschofie-mobl2.lan>
In-Reply-To: <ZxAppnCBf4wFgcQ0@aschofie-mobl2.lan>
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
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 16 October 2024 22:01
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; vishal.l.verma@intel.com;
>ira.weiny@intel.com; dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-
>kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
>
>On Wed, Oct 16, 2024 at 05:33:45PM +0100, shiju.jose@huawei.com wrote:
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
>
>Thanks, this looks useful! I didn't review line by line but do have some f=
eedback
>before for a v1:
Hi Alison,
Thanks for the feedbacks.

>
>- Suggest being more explicit in the commit msg(s). Something like:
>cxl/events: Update Common Event Record to CXL spec 3.1
Sure. Will add.

>
>- I was a bit surprised that this doesn't simply append new fields to the
>TP_printk() output. Is there some reason for that?
Will do. Thought print new fields before region_name and region_uuid.=20

>
>- How about updating the mock of these events to include these new fields.=
 I
>don't think this introduces any new formats, but I would certainly eyeball=
 all 3:
>dmesg tp_printk, trace file, and monitor output because all 3 (sadly) pres=
ent a
>bit differently.
>
I will update the CXL mock test for these new fields.
=20
>-- Alison
>
>>
>>  drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
>>  include/cxl/event.h      |  20 +++-
>>  2 files changed, 190 insertions(+), 31 deletions(-)
>>
>> --
>> 2.34.1
>>
>
Thanks,
Shiju
