Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB8491598
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757264; cv=none; b=iJWJec8OmVgfKjM0FktYfjP5hZdzO7KJ02MBdZFlc+Kz/Pud6PwBP3ekh6zkx/OytKTCnaeNus4r04C57h/v96rzoGZo9fYBf0HyzVPyykNLL5r6Dr7pJDCmW9ZiX3Ns7xKX+wnbsnFbVDku+WcTubxnkczUMhfQjZTRoBY3FL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757264; c=relaxed/simple;
	bh=7AVB4oKOGpFNPCjktEW1+iVva/fhnOdX2f+KLoQmgJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpztKqxW4CrHw3PywPwcI8A4nwlzef+wr8uCql5sT9ESxppwDkOJXKbWPTg+aUq47aNnn3oLtbgQ1pRoKA1bF9G4Kijv9hJluvcyZqgtzLb8aD7mGore1weksrSy8tKQcJibHUaz2seU8mkSbRx96LAGvvrE8kLMBm2+YCv6wwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/JGl8/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/JGl8/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A8A1F0089B
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757249;
	bh=a4C+G9CZdKBqoIP81nEtsin1gFdiRAlmn8K6K4qkvrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B/JGl8/aSNmBuBEK53tCNvCf00dibx5JzECzlF1DRcWahhEyZ4+87fmJVnVwWcVsp
	 9/1GPZqrOTcmjFGmVhhL5kaAhHQn34mRFxSCxasNnOMBQuFqLbhPPhjUv3IaiHUeHJ
	 R9vDXkgJVJT99y4ososy4F7yU5ERw2lKSo9eg9ytt9N1pSv7QlIiaHdzWwFOVYT/5V
	 71sL2ol5U0NffKQ6VFEN03Kh/D9v6z0EqGnJQdHvAhflc6J/lhnd/RQAvcn4Z2Yj4k
	 jMW2vkY/59in9wvAIfzPhyXyG1HZY8uyy32lIzgiwj8kY+e8eFmJuZW4N3Notl0Gyo
	 4piW9ogbBQfhQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so1019322e87.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 11:47:29 -0700 (PDT)
X-Gm-Message-State: AFuF++l1hUhnAIR7gn9jJvgh5QcOFPxD8Qu5uT93ty28RkktSEwGaEh6
	afAQpMWwjQXf/HMHUP3tv3/4f6YEI0D9GSfwR2at/El5KjPQ/jDudUyw1Lumn8mGaHKGhhDOKgV
	SOv7Pe9LeTuWajpe6rGUWiGjBWTRhT+8=
X-Received: by 2002:a05:6512:3ca1:b0:5b6:1a7c:59cf with SMTP id
 2adb3069b0e04-5b8c1836f2dmr1156768e87.41.1789757247608; Fri, 18 Sep 2026
 11:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
 <20260716181114.35962-2-alejandro.lucero-palau@amd.com> <4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
In-Reply-To: <4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 18 Sep 2026 20:46:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSwUPPWd36qBOOz42jiopfMTpVBK+J=H_stOdDXkhfBA@mail.gmail.com>
X-Gm-Features: AcwNN1X7a5XGQhDXcJeogzNvOAoJojFgVbM4wZeFHY-emCO8sEq24MK79wbUyM4
Message-ID: <CAJZ5v0gSwUPPWd36qBOOz42jiopfMTpVBK+J=H_stOdDXkhfBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Alejandro Lucero <alucerop@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:28=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> =
wrote:
>
>
>
> On 7/16/26 11:11 AM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> >
> > Remove __meminitdata from hmat_adist_nb declaration preserving it even
> > when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> > registrations using register_mt_adistance_algorithm() will find a
> > notifier chain likely corrupted.
> >
> > This is the case when cxl_region_probe() calls
> > register_mt_adistance_algorithm() what can happen when CXL regions
> > are dynamically created at any time from Type3 device(s) or when a Type=
2
> > device is initialized at its driver probe.
> >
> > Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT=
")
> >
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Applied as 7.4 material, thanks!

> > ---
> >  drivers/acpi/numa/hmat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 9792dc394756..3006789ae31f 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier=
_block *self,
> >       return NOTIFY_STOP;
> >  }
> >
> > -static struct notifier_block hmat_adist_nb __meminitdata =3D {
> > +static struct notifier_block hmat_adist_nb =3D {
> >       .notifier_call =3D hmat_calculate_adistance,
> >       .priority =3D 100,
> >  };
>
