Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB031A275
	for <linux-cxl@vger.kernel.org>; Sun, 12 Apr 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775976022; cv=pass; b=sjPKQXiEl+CWMldVauK/PFhoEi91JVkbdu9/UDUEzZ91Z2oo/cYIVHGDDmZUjHT/Fw8yYXxeBNcAl+0lf6w8Gg5+DTCWeWMSEtCfX8mDdtOZT8Gsxe/4YFr7IY2MgkTeBDlUnd2tR6OTcm4Mc6Y7l4T2QdpjZpNXLprENXU9+yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775976022; c=relaxed/simple;
	bh=a604DeiNAPyMT/Lkekno8TTnpz8UJxsFOLOcq9BBqxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5Sgd615F0M/MEIjbLNkZRLHZqMlXspTKsvA81A3RMO8uXrsYuN3eJ1o4u1TKw9w3Lshf0MRFkBX7q5P9vEDw3Tyc/gB+tu0hDrGgoXRyLWHUDIqog1nKTcCxKU8Vm7iN2AQQJ88fT0fWSlxbhj2JszJV2yOnAmHbdqijrov4jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVDV4AjQ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVDV4AjQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64edf260b49so4786392d50.0
        for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 23:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775976020; cv=none;
        d=google.com; s=arc-20240605;
        b=efA7XZE67uD63DfrCHjuCUPbAB4DVZFnMqKp9WHLNBVoH3CyT8uU+y60/3ZMeWQX47
         VW3/U4HHXtoZf79l79E1oK/lCgXFHOon7Vm0ZacfzzePmbqYBdb7Wj+N8X4lYstbwqys
         8tjpq8yKlWNK+Uyccjli1TY5GG4xhet0W0VcZMtrntrmgDSjjh23NAlkzPWWf2O9lv1v
         tBiU1DPLAcQthzIqL2CsJfel/3Lo5khhbtS4JtwEfIgFk3R1aRWIbSF1uv3x+EMENJcb
         +iD7yFSwHOmvCr/J2+KB3RkdymEKmiIpx/NQQmckuj5iINL0hJQahn4o4DYP+rnChVPG
         9TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        fh=N3bK3/I21Tk8TEnVzdlPk8yTIL8ivc3dyQizdCWpU7k=;
        b=JTsahx5pnYtDMhvswbzyBDrt0FYyQJNXUaZpEFQxL23MtFwU83PlbyHIqx0ec1Md/o
         inPHyY2rgY188iupV1lrpU01tUWKAoCKpBbl6kJOWcqZbv4f/2fqBHoBm5oXqj19HHzr
         B5B6tWSeDhOlNn7yTws4qiSa+37dWWUKyhfyf18HT3rOhzGdHOI6PKV/vLORMWv4UWU4
         nVUyCcO4lEaivWuAjAh7VFR4Mk0zP1U3rcgeGRf2gi6jtgEOk8uofLkHP16tWC1Rk0lZ
         OjKsC/BFKisKWHYgQ0QDdPfWajy0dSLH0aMQWf10UuK523K/xCgMjtmOdj4IXVbKKjXM
         XlkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775976020; x=1776580820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        b=MVDV4AjQwqUIZWMIWMEKKC+C2a9ouvJYGqaFkYnt75JOYR7GqQI44z3D3wFQHmTOGZ
         tuSBBUPTo1iE6Y5pbH8TaQXJWpNmFEJOKxREbrF2evaFC+ZRtjZ3J55BzgLwCxfUp00g
         eAI57Xjgdm2c+YknnE1aBaXqbGAgVWFcH5Z/p9XbniANt6mEWCA18VsF8787M8O0T1le
         +/8CmmPWXSGa6mHTUQ7SNFoMiuhS1vctH0fEJWWa5E/HkZ+geaRKUk53bU/fI9MpwSqH
         0ITfzi4/HGIhzAKQygkuIlzVmXE4YdR+pFe05pSaDMSRs28KBJ+MDTts2Jl9viTwRfj8
         p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775976020; x=1776580820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=353BGQR5E+FUbDTTQca9SIYSG89yYQ90FU4wNhB5wTM=;
        b=r6TEDViy8+kPNwbt9UokZ7MUSbktKdKwoawIAmCc1dK7BeUWM1h6sbuCClNxonMUPm
         Q8KyE3/a5uvoLTgLJalTTdTqubR9svhzZV11kuOipSxJm1P9IQzsVuHmFLEHOjV5bcRS
         05PSiBy/UQ2x8u6SiDTUfifJYHxQQhNZplA/4yH9r+0R3nhv9P8UWDLrghqysZGWwKY1
         i7kx7TsCK6tWRwiQCx6P2v0c95uwKaxUmaGpqvmuV53CIQA44q49Qs6P0ZimRrfExeGV
         fLrxVW1fC256hHKMr0E5VJWIC6J+e5upR9YG0j9aUS2wS5dwtsj4YV2S7kCJHUoemjrb
         cpNg==
X-Forwarded-Encrypted: i=1; AFNElJ/VVs+n5gPdq+T27WJ3BxYMEm1ZO5vANB2DgWkCeom9XKAgFrcNkpvwZujOduCwvwsIgM3n1sn96iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFt9qQsDt0ys+rvxpdUm3CColXE1N1YsVcazFhEa4VAbueHHu2
	ZswGVVWLbRpXcDv3qzSmH5hevmvxNxtbdurX77o7777nWhqNEMy9a/REKPBqJJp6ChncGhyOxxZ
	K5zCoVH/pgfCT2HIWIXUXLa9pixe9aEc=
X-Gm-Gg: AeBDieuZ/4zEp0SGhJURF76TFv+Jv51jZXmYndpsztFsDjrMHwn8lHShafZOwkHT95u
	FQpAjsTsd2KlqMbjWXGhdzYc1W3SdSWYhEVSqXvPuLtup7c26u6wN2MGkFR+laL+QccLTJnIAIl
	37dQUtdLRvC8RFIOMrIyIvEwDJRUS+r1xB9H0pOzMZZfG8RQ36Vgqf0GT40K1bAtrgCtcektzUw
	nEBWZYYa0hlZLmGIOaxrYYyRXksQqCKKVqyRdklbmmEq0obgT9xfR0VgDmgVqW+bf5qjCLLKAhc
	UBQx9B0=
X-Received: by 2002:a05:690e:d4a:b0:651:8abe:ce47 with SMTP id
 956f58d0204a3-6518abed70amr7968580d50.5.1775976019736; Sat, 11 Apr 2026
 23:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411145726.2299438-1-lgs201920130244@gmail.com> <69dad954cbd27_fdcb41005c@djbw-dev.notmuch>
In-Reply-To: <69dad954cbd27_fdcb41005c@djbw-dev.notmuch>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sun, 12 Apr 2026 14:40:08 +0800
X-Gm-Features: AQROBzBoQieHezjldgST08cWePETtgJOGA36kUbkZPgBK0CARxWtw3VoS8begvg
Message-ID: <CANUHTR8krObfwdkV9PFkfRcWgiVwSMfmKD0U=xY9_543KxZqTg@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Fix refcount leak in __devm_create_dev_dax()
 error path
To: Dan Williams <djbw@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for the review and for pointing that out.

You are right that my changelog overstated the impact. I do not have a
concrete use-after-free case here, and the practical issue is simply
that after device_initialize(), the embedded struct device should be
released through the device core with put_device(), rather than
freeing dev_dax directly.

I also took a closer look at the release path. Since dev_dax_release()
already handles free_dev_dax_id(), kfree(dev_dax->pgmap), and
kfree(dev_dax), and put_dax() is NULL-safe, the post-initialization
failure paths can be simplified to explicit range cleanup plus
put_device(), once dev->type is assigned before device_initialize().

I'll send a v2 that tightens the changelog around the actual lifecycle
issue and cleans up the error paths accordingly.

Thanks again for the guidance.

Best regards,
Guangshuo

Dan Williams <djbw@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8812=E6=97=A5=
=E5=91=A8=E6=97=A5 07:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Guangshuo Li wrote:
> > After device_initialize(), the lifetime of the embedded struct device i=
s
> > expected to be managed through the device core reference counting.
> >
> > In __devm_create_dev_dax(), several failure paths after
> > device_initialize() free dev_dax directly instead of releasing the
> > device reference with put_device(). This bypasses the normal device
> > lifetime rules and may leave the reference count of the embedded struct
> > device unbalanced, resulting in a refcount leak and potentially leading
> > to a use-after-free.
>
> Please do not list "theoretical" problems as justification. Point to
> real problems.
>
> > Fix this by assigning dev->type before device_initialize(), so the
> > release callback is available for put_device(), and use put_device() in
> > the post-initialization error paths. Keep dev_dax range cleanup explici=
t
> > in the error path.
>
> I see a more straightforward way to address just the practical problem
> that also incorporates the other feedback I have below. Can you spot
> that and fixup the changelog to address the practical impact?
>
> > Fixes: c2f3011ee697f ("device-dax: add an allocation interface for devi=
ce-dax instances")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/dax/bus.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index fde29e0ad68b..8753115cd371 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(stru=
ct dev_dax_data *data)
> >       }
> >
> >       dev =3D &dev_dax->dev;
> > +     dev->type =3D &dev_dax_type;
> >       device_initialize(dev);
> >       dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> >
> > @@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(stru=
ct dev_dax_data *data)
> >       dev->devt =3D inode->i_rdev;
> >       dev->bus =3D &dax_bus_type;
> >       dev->parent =3D parent;
> > -     dev->type =3D &dev_dax_type;
> >
> >       rc =3D device_add(dev);
> >       if (rc) {
> > @@ -1523,14 +1523,21 @@ static struct dev_dax *__devm_create_dev_dax(st=
ruct dev_dax_data *data)
> >
> >  err_alloc_dax:
> >       kfree(dev_dax->pgmap);
> > +     dev_dax->pgmap =3D NULL;
> > +
> >  err_pgmap:
> >       free_dev_dax_ranges(dev_dax);
> > +     put_device(dev);
> > +     return ERR_PTR(rc);
> > +
> >  err_range:
> > -     free_dev_dax_id(dev_dax);
> > +     put_device(dev);
> > +     return ERR_PTR(rc);
>
> Please no gotos with early returns, that makes a mess.
