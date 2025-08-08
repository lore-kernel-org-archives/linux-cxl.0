Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EC246BCD
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661894; cv=none; b=fD620leRoKsI71AiTf6DvdxuFREMCWIjmMz9pxTuitDwGAKaf0ZBT9L+WvByPJjl2ky1CU1DXUN5kGTCePF2ywHJBw9M+iibJz+5P/NlCHEjLroHcvRbOQ0ASRnbebHdG/cJ5pd9Drwg/PFMDNY5oDf0dh+4bXmIGO3dQ8pavZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661894; c=relaxed/simple;
	bh=ppgfC4X+4obFhVi5rFQM1UupDlLjZ00cOV0sfVj8PF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QwgTjpV1VCxGeC4QG/cCIzNWhMNP7un8t2B+YkmQcJXZDtVjBgVHIoTqjxbYQncccsGy6hwL4oQulA5gNR4PHDk3zGn5hNNINJHcFpDom42lPPCkgEt/1COUppwRX522281LkXwEfqcwJcf/0KfGlT21EaF+QWj1yeIWh9+ocDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz5JT6GLFz6L4vy;
	Fri,  8 Aug 2025 22:00:09 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D40D5140427;
	Fri,  8 Aug 2025 22:04:48 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Aug 2025 16:04:48 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 8 Aug 2025 16:04:48 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Topic: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Index: AQHcB7IbgHJy8x5snE+W5U6ovLZH5LRYkanpgAA5niA=
Date: Fri, 8 Aug 2025 14:04:48 +0000
Message-ID: <a6a73b09a26149e8ac4f867ecab89b03@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
	<20250807154346.2209-2-shiju.jose@huawei.com> <87ldnuhzes.fsf@pond.sub.org>
In-Reply-To: <87ldnuhzes.fsf@pond.sub.org>
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
>From: Markus Armbruster <armbru@redhat.com>
>Sent: 08 August 2025 11:38
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
>record format
>
><shiju.jose@huawei.com> writes:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record format
>> has updated with optional Maintenance Operation Subclass, LD ID and ID
>> of the device head information.
>>
>> Add updates for the above optional parameters in the related CXL
>> events reporting and in the QMP commands to inject CXL events.
>>
>> In qapi/cxl.json added fields of Common Event Record to a common
>> structure CXLCommonEventBase.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>Please split this patch for easier review:
>
>1. CXLCommonEventBase.  Pure refactoring.
>
>2. Add new members.

Sure. I will do.
>

Thanks,
Shiju
