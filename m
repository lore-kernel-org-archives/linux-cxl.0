Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CF16E879
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186879; cv=none; b=TP2clOAdf/IAjo3jTL9QNubWjwGAQm3/58yjKl5PhICmFOfDSj75GUul0o15uu6kQrX9I0SNvKnJLLgO5DOJUolSaEWCNKL9djIYw8SL4Qhz6ogaKdSPqWKGNOOzeQEy/XicrTRaWBv9bCOM346c1jr5Ozignob/JYvDMFJcJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186879; c=relaxed/simple;
	bh=GvC/K7JVuybvDldmsQgxCWCoVtMR1UW6ILi18RGweV8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMCTqCJxnQb2MxIz54iLd+BxEMbXwxOWBR8u3QveWsmI0g6Fz3jggZyvgwy0luVKn6BTxoSGWngjAl82An4Q5VJQpELX1GcM6Y9nfa6rm6YAtzHsWnLTH4hKN7m3qE+0K968ZZ+gqkl1j42FNrIdeX+8/KfSQQCZya/Kph5hijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vzh5h2Hzvz6K8wD;
	Wed, 12 Jun 2024 18:06:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C01E140A87;
	Wed, 12 Jun 2024 18:07:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 11:07:53 +0100
Date: Wed, 12 Jun 2024 11:07:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Christoph Hellwig <hch@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute
 references
Message-ID: <20240612110752.00007442@Huawei.com>
In-Reply-To: <4dadbadf-529d-6f50-b30e-8a428d8c6a19@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
	<20240516081202.27023-2-alucerop@amd.com>
	<666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
	<ZmkkaOTUFuzIr2cG@infradead.org>
	<4dadbadf-529d-6f50-b30e-8a428d8c6a19@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 06:54:13 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 6/12/24 05:30, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote: =20
> >> alucerop@ wrote: =20
> >>> From: Alejandro Lucero <alucerop@amd.com>
> >>>
> >>> CXL Type 2 devices imply specific vendor drivers binding to those
> >>> devices instead of generic ones offered by CXL core like the PCI driv=
er. =20
> > No, it absolutelt does not.  There is no such thing as a vendor driver
> > in Linux. =20
>=20
>=20
> Well, yes, I see your point, and it is absolutely correct.
>=20
> It was a bad way of explaining the need of a driver supporting a=20
> specific hardware.
>=20
>=20
> >> So I don't like this approach, there are details that are private to t=
he
> >> CXL generic memory-expander use case, and some that are suitable for
> >> CXL.mem and CXL.cache capabilities in other drivers. That distinct
> >> subset should move to include/linux/. I.e. I want to see the increment=
al
> >> conversion of what 3rd party drivers need compared to the generic
> >> expander case, and consider when and where new shared infrastructure
> >> needs to be refactored. =20
> > And I'd much rather keep all these drivers in drivers/cxl/ anyway so
> > that we can keep a tight control over them.
> > =20
>=20
> My initial thought was drivers for ethernet, gpus, or any other kind of=20
> standard device binding to the CXL/PCIe.io and doing the CXL=20
> initialization. Your comment seems to suggest other approach, which I=20
> can only relate to using auxbus for the device CXL.mem and CXL.cache,=20
> and=A0 then being handled by a generic driver inside the CXL core. Is thi=
s=20
> what you are suggesting?
>=20
> If so, I'm not against it, although it would require to study the=20
> implications.

I'd be very careful with that level of complexity.
So far I'm not seeing it as useful for this case (but I could be wrong)

Maybe just a case of well defined library code with only
opaque state etc being exposed by the CXL driver framework.

The bulk of any type2 driver needs to be in the appropriate subsystem
not drivers/cxl/  The non CXL parts will be more important to keep
aligned with appropriate subsystem than the CXL part.=20

Jonathan

>=20
>=20

