Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FC779EC
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803271; cv=none; b=M3rmV4icVi8OXEu2AqAifLlg9WVb1AR/vvYUMYd3+Y5L8GHXhRps8M7GE/2GZKZXEHQExS1xm36r0/ur9Id8Z1xhGcNzP24+q/w6/58ntMG55J7Coeyf4810CpNeJufjh1UnDZSVIJsSxenW4T1fz15DqEp8pxGxzMXetlHZW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803271; c=relaxed/simple;
	bh=UjjqnG4W/HtYkMT9CEM0zIQZHQfN4dCGiw1p10i/mdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8n1hvH/1PZx2ZpC+cVSTHRzh+ZNHCxKrIImAn2yUooQClo6pD3x7IH0DJpjVM/Z7f1Pyu0l7ltCirbkIVTe2nlMkmoWtRngHVgoWjpcdupncyTO00B1EdoowUB+SaMNnfLCpvgQ4WJvZDH3eXEa75KmIzbJKzYDV+KjDDi+WEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKM2HO9s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKM2HO9s"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso1454221a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706803268; x=1707408068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNAeX9MhSd8JANkjCMN1qO6Ct0M9y4aZLFPmuSALAM4=;
        b=KKM2HO9slv2XtXUFC0EbKDCg0TPJEwaU/U4wHLNDDOw3RGICt8Qx/8HCZcQ+V3ly1A
         p6+bEAtJEKMdUFCB8WDsYtYidX3gw4seJDhlRR7WEaucCc9XMmzy5bDpEyrCfmOhevAZ
         Q0WgBjb5XafrQyL6LycQn11dMs7LwOM31vVtTzh//8NHnhYcpThY9svl9Mnp95YXUgh9
         dc1U08nQIugTQOrfywkYjwYdVW73FdFmAMV/5shqql8n2wq6VXbNF2WYprKZgJsGOfS4
         WI9BtE6berpWVHySWJ7c5MGgz1islhmZwQ7om3nptwQf5IXZpOuuZ1nxteYd+dGZmb6T
         BNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803268; x=1707408068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNAeX9MhSd8JANkjCMN1qO6Ct0M9y4aZLFPmuSALAM4=;
        b=ZttUeHVRKkXuSyt52bBVQuEO2lrmV7UpfJUURGVGOhIE1Txi46cjl/BlyON9Aa+RTt
         FbyXm4LS0j71hqGKbGgNEgxrDzj0j6wI1r6wz8rSJinKDmodDan8e77daS1QmubrIMXF
         KSfeByOUKIiFRIB6/U3CugJp7svYX9c6RZ5EdaO3jemSW4Tk79p036fx94wc5MtEN1xR
         NTHRLYKcxI/OXL6wWylqTdTllfpHZpY6YjKiIcsjBWnnxV7/vYz0dn3HryHhbHOTHnAU
         O3OtZudJpdbsgoecHAoiOmiIrfdDZgzMbTJ++fQvun/P9bGQB2pXHhzByTchTjpbBhJx
         mpjQ==
X-Gm-Message-State: AOJu0YziiFhq0kqKCOO6of3vAj3udASKR+i/73O+TvhleAUW0g0AIp+e
	9XQOMY7rvw+3PGFW1JgnnYw7OPk8kC74HAef22wDkIYf26VFhL7t2yNikUVFo7f5YrcxBYC5K0I
	LR3FsrAk8eJlgdDSmpI7SX581xxLJ5rE9RuT3+Q==
X-Google-Smtp-Source: AGHT+IGjhK81r+/kYIABzLNHX37BHHtuIiDYBNMC0rxsvrb7yC7FdU3p9sGF2z0S4EReUawqCm3spucjmfv4rJ5Ppu4=
X-Received: by 2002:a05:6402:2211:b0:55f:6b8:b2fb with SMTP id
 cq17-20020a056402221100b0055f06b8b2fbmr3625596edb.1.1706803267744; Thu, 01
 Feb 2024 08:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com> <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com> <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com> <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
In-Reply-To: <87msskkyce.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:00:56 +0000
Message-ID: <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sajjan Rao <sajjanr@gmail.com>, 
	Gregory Price <gregory.price@memverge.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > So, that looks like:
> >  * we call cpu_tb_exec(), which executes some generated code
> >  * that generated code calls the lookup_tb_ptr helper to see
> >    if we have a generated TB already for the address we're going
> >    to execute next
> >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> >    address for the guest address
> >  * this results in a TLB walk for an instruction fetch
> >  * the page table descriptor load is to IO memory
> >  * io_prepare assumes it needs to do a TLB recompile, because
> >    can_do_io is clear
> >
> > I am not surprised that the corner case of "the guest put its
> > page tables in an MMIO device" has not yet come up :-)
> >
> > I'm really not sure how the icount handling should interact
> > with that...
>
> Its not just icount - we need to handle it for all modes now. That said
> seeing as we are at the end of a block shouldn't can_do_io be set?

The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
which happens earlier than the tb_stop callback (it can
happen in the trans function for branch etc insns, for
example).

I think it should be OK to clear can_do_io at the start
of the lookup_tb_ptr helper, something like:
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca143..7818537f318 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;

+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io =3D true;
+
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);

     cflags =3D curr_cflags(cpu);

-- PMM
