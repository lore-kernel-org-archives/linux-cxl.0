Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AEF58AAC
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012572; cv=none; b=tOkTVpFeaNO4dYdT4Tl6JniBhzAsPJ87V4a2Tljs5mR2eAjkHO83ZTN+KsHJqQ+AbLY7wUwwXPnClRCO1IOYVBuyD45F/MDXNyitlupcYy19pGll8p0X5FbX3CA2Xh2rm26b4bPhQndVH+PsHFgSzIjoTqapKErr7i6VRm3JsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012572; c=relaxed/simple;
	bh=mpH6fasVDsPH/dkN/7p/ExaUzC0MYKkU49+omGVA0kM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSxL3AMmRd8/ib2Yy0pAn8CrUg86ObiWsK67tm39sDoi4k16y36Y7JDk/cyz0TcBljqhLDjIlTrT00wE4IgzBApIlKsNCYOulMoCdL6bDZF08j/6r2jlxZ0lfdLK3kUzunqQvjdWMmoK7UljAw8My65ZFvDegfNGyl1H7VBevN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKM905C9z67M1q;
	Thu, 15 Feb 2024 23:52:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 960A414025A;
	Thu, 15 Feb 2024 23:56:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 15:56:05 +0000
Date: Thu, 15 Feb 2024 15:56:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
	"Gregory Price" <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Message-ID: <20240215155604.000078b0@Huawei.com>
In-Reply-To: <5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
	<20240215150133.2088-3-Jonathan.Cameron@huawei.com>
	<5b53790b-8f94-4b21-b1da-e7f278af0dd7@linaro.org>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 16:31:26 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 15/2/24 16:01, Jonathan Cameron via wrote:
> > From: Gregory Price <gregory.price@memverge.com>
> >=20
> > CXL emulation of interleave requires read and write hooks due to
> > requirement for subpage granularity. The Linux kernel stack now enables
> > using this memory as conventional memory in a separate NUMA node. If a
> > process is deliberately forced to run from that node
> > $ numactl --membind=3D1 ls
> > the page table walk on i386 fails.
> >=20
> > Useful part of backtrace:
> >=20
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, fmt=3Dfmt@entry=3D0x555555fe337=
8 "cpu_io_recompile: could not find TB for pc=3D%p")
> >      at ../../cpu-target.c:359
> >      (retaddr=3D0, addr=3D19595792376, attrs=3D..., xlat=3D<optimized o=
ut>, cpu=3D0x555556fd9000, out_offset=3D<synthetic pointer>)
> >      at ../../accel/tcg/cputlb.c:1339
> >      (cpu=3D0x555556fd9000, full=3D0x7fffee0d96e0, ret_be=3Dret_be@entr=
y=3D0, addr=3D19595792376, size=3Dsize@entry=3D8, mmu_idx=3D4, type=3DMMU_D=
ATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, p=3Dp@entry=3D0x7ffff56fddc0, m=
mu_idx=3D<optimized out>, type=3Dtype@entry=3DMMU_DATA_LOAD, memop=3D<optim=
ized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/cputlb.c:2356
> >      (cpu=3Dcpu@entry=3D0x555556fd9000, addr=3Daddr@entry=3D19595792376=
, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, access_type=3Daccess_type@entry=3D=
MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> >      at ../../accel/tcg/ldst_common.c.inc:301
> >      at ../../target/i386/tcg/sysemu/excp_helper.c:173
> >      (err=3D0x7ffff56fdf80, out=3D0x7ffff56fdf70, mmu_idx=3D0, access_t=
ype=3DMMU_INST_FETCH, addr=3D18446744072116178925, env=3D0x555556fdb7c0)
> >      at ../../target/i386/tcg/sysemu/excp_helper.c:578
> >      (cs=3D0x555556fd9000, addr=3D18446744072116178925, size=3D<optimiz=
ed out>, access_type=3DMMU_INST_FETCH, mmu_idx=3D0, probe=3D<optimized out>=
, retaddr=3D0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> >=20
> > Avoid this by plumbing the address all the way down from
> > x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
> > which provide it to probe_access_full() which already handles MMIO acce=
sses.
> >  =20
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Good point!  Sorry Peter.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Thanks
>=20
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> >=20
> > ---
> > Patch posted in reply to thread:
> > https://lore.kernel.org/qemu-devel/ZbvpSaOXzZkqDd6c@memverge.com/
> >=20
> > I checked Gregory was fine with me adding Sign-off / author via the CXL=
 discord.
> > ---
> >   target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
> >   1 file changed, 30 insertions(+), 27 deletions(-) =20
>=20

