Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264213B2B1
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013483; cv=none; b=XNqihHivvA6WF7CfW47VwCtVEUROoyn6QnVwLdmXliNkTCrwB1gnVRSt5tkbGAfO9XR57Wpib2EUaF6USatJBVJgs4DD8Pbmo0CfT2J4mXJPhuREX5NWTLVkK42iRgQPgVDoeB0yxSodByl43TNwPNRntdufvh6m4en/HBvKoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013483; c=relaxed/simple;
	bh=y3220wE9Mp7afSvmz/MBx1jvgPsoIiivAJXVJBFoh4U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXllI4nhumq9U3Q52JYgZk6hJMWIi0vrcIhMBaSO7bKLJx42NaGvjN09uPXfwVVRfDhZE/X+dVk8OE1l719v9wAR3CP0CjS9venX+Qww2S1gEcb8eFpCdBqhE8Gdsy7Z3vx6vhhU47tqolfoV9GE0P9Y+zNH5KtynwBM4qbA4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKj15jsHz6K8j1;
	Fri, 16 Feb 2024 00:07:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A60C8140682;
	Fri, 16 Feb 2024 00:11:17 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:11:17 +0000
Date: Thu, 15 Feb 2024 16:11:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
	"Gregory Price" <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
Message-ID: <20240215161116.0000210e@huawei.com>
In-Reply-To: <bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
	<20240215150133.2088-4-Jonathan.Cameron@huawei.com>
	<bdeb194e-28f6-4dda-bf85-bd1a0b983ecd@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 16:33:45 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 15/2/24 16:01, Jonathan Cameron via wrote:
> > On i386, after fixing the page walking code to work with pages in
> > MMIO memory (specifically CXL emulated interleaved memory),
> > a crash was seen in an interrupt handling path.
> >=20
> > Useful part of bt
> >=20
> > Peter identified this as being due to the BQL already being
> > held when the page table walker encounters MMIO memory and attempts
> > to take the lock again.  There are other examples of similar paths
> > TCG, so this follows the approach taken in those of simply checking
> > if the lock is already held and if it is, don't take it again.
> >=20
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   accel/tcg/cputlb.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 047cd2cc0a..3b8d178707 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPU=
TLBEntryFull *full,
> >                                  int mmu_idx, MMUAccessType type, uintp=
tr_t ra)
> >   {
> >       MemoryRegionSection *section;
> > +    bool locked =3D bql_locked(); =20
>=20
> Maybe clearer as:
>=20
>         bool need_lock =3D !bql_locked();
>=20
> >       MemoryRegion *mr;
> >       hwaddr mr_offset;
> >       MemTxAttrs attrs;
> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, C=
PUTLBEntryFull *full,
> >       section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs=
, addr, ra);
> >       mr =3D section->mr;
> >  =20
> > -    bql_lock();
> > +    if (!locked) { =20
>=20
> if (unlikely(need_lock)) {

Isn't this reversed? Until now we've always taken the lock here so I'm gues=
sing
it normally is needed. if (likely(need_lock))?
if we are going to mark it one way or the other.

>=20
> > +        bql_lock();
> > +    }
> >       ret =3D int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
> >                             type, ra, mr, mr_offset);
> > -    bql_unlock();
> > +    if (!locked) { =20
>=20
> Ditto.
>=20
> > +        bql_unlock();
> > +    }
> >  =20
> >       return ret;
> >   } =20
>=20

