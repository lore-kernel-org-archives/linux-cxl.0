Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EA12FF70
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013078; cv=none; b=ROWitIIzL8bfQYJRQoH9+9s0Q7BcN3fcLnidYNFfJFwBpO4H9ycGxUmSolkahsLX0YQiVKgfUwxO4G4hY2S5fbZWdd8Rli7n00pn32xA/0uJ8H5iI8hpGfSg4WFU2Aj8N8W8utXWnOtdLAuiTWHFFh7/Fnifmh7soU7YMBUjXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013078; c=relaxed/simple;
	bh=TB2rRhi41D1V+X/Hdi2AULchlOzsuP3pFVKAISOOPvQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyISPnFsi3hz6m3CLbp6sOFuG9ai1a/cHxcVg+BGk2NjmDZ3cu6TibID1HSYHY1M0ExPGOxCIhzf/CxgQQH4N/XJ2tzy9K9M+KqYmkI9rlKo5X77r0RcSs+ZjPH4ocjmkt+JfjYu1kE6MHEHiKvnoBTjIFyhrGCluKfE12c8R0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKYD6DRMz6K8j1;
	Fri, 16 Feb 2024 00:01:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B3F51140A86;
	Fri, 16 Feb 2024 00:04:32 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:04:32 +0000
Date: Thu, 15 Feb 2024 16:04:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Gregory Price <gregory.price@memverge.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
	<sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	<richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of
 lookup_tb_ptr helper
Message-ID: <20240215160431.00005355@huawei.com>
In-Reply-To: <CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
	<20240215150133.2088-2-Jonathan.Cameron@huawei.com>
	<CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 15:11:17 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 15 Feb 2024 at 15:02, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
> >
> > From: Peter Maydell <peter.maydell@linaro.org>
> >
> > Peter posted this in the thread trying to fix x86 TCG handling
> > of page tables in MMIO space (specifically emulated CXL interleaved memory)
> > https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t
> >
> > Peter, are you happy to give your SoB on this one?
> >

Thanks, I'll also add a summary of your description of why there is
a bug based on your email to v2 as the above doesn't really
provide any useful info :( 

If a page table is in IO memory and lookup_tb_ptr probes
the TLB it can result in a page table walk for the instruction
fetch.  If this hits IO memory and io_prepare falsely assumes
it needs to do a TLB recompile.
Avoid that by setting can_do_io at the start of lookup_tb_ptr.


> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  accel/tcg/cpu-exec.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 977576ca14..52239a441f 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
> >      uint64_t cs_base;
> >      uint32_t flags, cflags;
> >
> > +    /*
> > +     * By definition we've just finished a TB, so I/O is OK.
> > +     * Avoid the possibility of calling cpu_io_recompile() if
> > +     * a page table walk triggered by tb_lookup() calling
> > +     * probe_access_internal() happens to touch an MMIO device.
> > +     * The next TB, if we chain to it, will clear the flag again.
> > +     */
> > +    cpu->neg.can_do_io = true;
> >      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> >
> >      cflags = curr_cflags(cpu);
> > --  
> 
> Happy to provide a
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> but I'd appreciate RTH's review to confirm this is the right
> way to deal with the problem.
> 
> thanks
> -- PMM

