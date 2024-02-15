Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7E131E3D
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009480; cv=none; b=Nr1SppcpAWnYIltdgCK/KIzY0gy3qC38w7BvkoTQRpPl7NRpt19g3J1xiXdQZiMEroBsn2dwJt0F9yK4xSsiObDf7OQaNxa+sjzcdIHiO4YMB8CJNm5I0G/TyD01x57afNTMa5zLwt8cC7aWWOrOvOWoE+uoq0kVBqbEoZ5/c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009480; c=relaxed/simple;
	bh=58Y5UMqwkeyhHG5qEaXE8cK9cQJqv9dwayQKk+Xu++E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqLr2eZe2CNuYcmH0+UyML77qbAnvL8YGQa/uxDqtOpn/xtlZMRZEuyOfG9hfZGbBfLMSFDGn8IIKEx/TpRZLfhG1dw6zKnOg4W31MaRiYEpMilsJzH3If58jHr8zjdcJausyrVlXQ1/OxeWfX4+5KKIu5QUbzYwYZHb5PMSFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJCN4b10z6J9fv;
	Thu, 15 Feb 2024 23:00:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 38083140B55;
	Thu, 15 Feb 2024 23:04:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 15:04:34 +0000
Date: Thu, 15 Feb 2024 15:04:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
	<sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, "Dimitrios
 Palyvos" <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240215150433.00007a51@Huawei.com>
In-Reply-To: <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
	<CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
	<CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
	<20230823175056.00001a84@Huawei.com>
	<CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
	<CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
	<20240126123926.000051bd@Huawei.com>
	<ZbPTL00WOo7UC0e6@memverge.com>
	<20240126171233.00002a2e@Huawei.com>
	<CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
	<20240201130438.00001384@Huawei.com>
	<CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
	<20240201140100.000016ce@huawei.com>
	<CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
	<87msskkyce.fsf@draig.linaro.org>
	<CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Feb 2024 16:00:56 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 1 Feb 2024 at 15:17, Alex Benn=E9e <alex.bennee@linaro.org> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes: =20
> > > So, that looks like:
> > >  * we call cpu_tb_exec(), which executes some generated code
> > >  * that generated code calls the lookup_tb_ptr helper to see
> > >    if we have a generated TB already for the address we're going
> > >    to execute next
> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> > >    address for the guest address
> > >  * this results in a TLB walk for an instruction fetch
> > >  * the page table descriptor load is to IO memory
> > >  * io_prepare assumes it needs to do a TLB recompile, because
> > >    can_do_io is clear
> > >
> > > I am not surprised that the corner case of "the guest put its
> > > page tables in an MMIO device" has not yet come up :-)
> > >
> > > I'm really not sure how the icount handling should interact
> > > with that... =20
> >
> > Its not just icount - we need to handle it for all modes now. That said
> > seeing as we are at the end of a block shouldn't can_do_io be set? =20
>=20
> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
> which happens earlier than the tb_stop callback (it can
> happen in the trans function for branch etc insns, for
> example).
>=20
> I think it should be OK to clear can_do_io at the start
> of the lookup_tb_ptr helper, something like:
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca143..7818537f318 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      uint64_t cs_base;
>      uint32_t flags, cflags;
>=20
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io =3D true;
> +
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>=20
>      cflags =3D curr_cflags(cpu);
>=20
> -- PMM

Hi Peter,

I've included this in the series I just sent out:
https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron@h=
uawei.com/T/#t

Could you add your Signed-off-by if you are happy doing so?

Jonathan
