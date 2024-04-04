Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCC128833
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238422; cv=none; b=kBSaiUynpRsVfzkvhDWx4vvHq/IixYS0YHdTgSODvh6jI28xqgAsmFMSelaXM20K7wC85XrRheYmAXL6SifO5afDSZz3RAJu77Qgtd6Sw3Qi4z27QaUs3i16AfnVYdnyFNwiUM4/tSyhr//+X0RL1zhZKp1KUhzWnBSd5gg6hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238422; c=relaxed/simple;
	bh=rfODg4uIOwf4lILpSoMVXv0CzdO+TcdXMxy6X59JBvg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXsu2yQd9gI5FNN2NLsj4WF35ExiPbWAhfYG+pHKjVcCqEODBTQWViq+sfLMs5cFOJvaJlBI/pR+R0C0Az7WbfcO4D1PP/0kx063sY5bPPa0cbA1rr2XD0txQnuRzqAmxckDn4zQtlxrsUYVZQl7VM4QTb8oC+QBpRQa0PBO7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9NDK1n4nz6G9wD;
	Thu,  4 Apr 2024 21:45:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F64E140A77;
	Thu,  4 Apr 2024 21:46:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:46:56 +0100
Date: Thu, 4 Apr 2024 14:46:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: Dan Williams <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<ira.weiny@intel.com>, <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
Message-ID: <20240404144655.0000679c@Huawei.com>
In-Reply-To: <7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
	<20240329063614.362763-4-ruansy.fnst@fujitsu.com>
	<66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 22:56:58 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/3/30 9:50, Dan Williams =E5=86=99=E9=81=93:
> > Shiyang Ruan wrote: =20
> >> The GMER only has "Physical Address" field, no such one indicates leng=
th.
> >> So, when a poison event is received, we could use GET_POISON_LIST comm=
and
> >> to get the poison list.  Now driver has cxl_mem_get_poison(), so
> >> reuse it and add a parameter 'bool report', report poison record to MCE
> >> if set true. =20
> >=20
> > I am not sure I agree with the rationale here because there is no
> > correlation between the event being signaled and the current state of
> > the poison list. It also establishes race between multiple GMER events,
> > i.e. imagine the hardware sends 4 GMER events to communicate a 256B
> > poison discovery event. Does the driver need logic to support GMER event
> > 2, 3, and 4 if it already say all 256B of poison after processing GMER
> > event 1? =20
>=20
> Yes, I didn't thought about that.
>=20
> >=20
> > I think the best the driver can do is assume at least 64B of poison
> > per-event and depend on multiple notifications to handle larger poison
> > lengths. =20
>=20
> Agree.  This also makes things easier.
>=20
> And for qemu, I'm thinking of making a patch to limit the length of a=20
> poison record when injecting.  The length should between 64B to 4KiB per=
=20
> GMER. And emit many GMERs if length > 4KiB.

I'm not keen on such a restriction in QEMU.
QEMU is injecting lengths allowed by the specification.  That facility is
useful for testing the kernel and the QEMU modeling should not be based
on what the kernel supports.

When you said this I wondered if we had a clever implementation that fused
entries in the list, but we don't (I thought about doing so a long time
ago but seems I never bothered :)  So if you are using QEMU for testing
and you don't want to exceed the kernel supported poison lengths, don't
inject poison that big.

Jonathan

>=20
> >=20
> > Otherwise, the poison list is really only useful for pre-populating
> > pages to offline after a reboot, i.e. to catch the kernel up with the
> > state of poison pages after a reboot. =20
>=20
> Got it.
>=20
>=20
> --
> Thanks,
> Ruan.

