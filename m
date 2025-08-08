Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BA1B7F4
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661862; cv=none; b=gK4tePocuP3pWZzezcJUb1el0wfNQ0H31tg+ipYpvoOdxL65qA/Y6APjciiuU4Wqh5PSpBRT6XaV9FIQR7DBAgz1ob1lw04HA5gPoBHxEnLngwqrjSYU4dUumWWJquYko0EnnhV3sg9ehr87IwAXC9h8HvozjjMjRp2ea4t6nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661862; c=relaxed/simple;
	bh=lH0qbFTTYUMTqXMaqajFGf+9gnpTLp5KVV1ioocLXHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oitBphfUtg64NVYoNv7MxAkTOJBz2wpRNzpEncEEp3e4hAHiTuypG5e3XujJJ+VYjy/ImVLNJ15SxoeuNx2RRdI/L3IcM6gfG9IgbB13EwQs+dzNgML2mB6XS37xa+yVpRv+d0qVJf0rGucq7AxWRf5BLXapPK2CnyQtVOesyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz5Hr33LGz6L4vy;
	Fri,  8 Aug 2025 21:59:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6817A14022E;
	Fri,  8 Aug 2025 22:04:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Aug 2025 16:04:15 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 8 Aug 2025 16:04:15 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "armbru@redhat.com"
	<armbru@redhat.com>, "dave@stgolabs.net" <dave@stgolabs.net>, Linuxarm
	<linuxarm@huawei.com>
Subject: RE: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Topic: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Index: AQHcB7IbgHJy8x5snE+W5U6ovLZH5LRYn+mAgAArEnA=
Date: Fri, 8 Aug 2025 14:04:15 +0000
Message-ID: <891c3fc930fa45cc9a3b01ac028a4c15@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
	<20250807154346.2209-2-shiju.jose@huawei.com>
 <20250808142907.000022f4@huawei.com>
In-Reply-To: <20250808142907.000022f4@huawei.com>
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
>Sent: 08 August 2025 14:29
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; armbru@redhat.com;
>dave@stgolabs.net; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
>record format
>
>On Thu, 7 Aug 2025 16:43:40 +0100
><shiju.jose@huawei.com> wrote:
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
>Hi Shiju,
>
>Sign off chain doesn't make sense. Drop my SoB.  I guess this is because i=
t went
>through my tree at some stage and hence was tagged by me. Given it's your
>patch, you should drop that from new versions.
Hi Jonathan,

Thanks. I will do.

>
>Jonathan
>
>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Thanks,
Shiju
