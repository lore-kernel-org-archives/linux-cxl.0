Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A74357CEB
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817319; cv=pass; b=CmDG3/GzCEiH05EdoE1JjqhbS3k8Tf2yc1MINLVWV7084z0bUdCIQEYnEJ4+0IMNf8Yk2XxiBnwDhNRNtkwmI++9Shv5Wo5YFx8HOja5sppVRphbBGIDmJ4RyNDi1rJmL94brTlS1KhS6K6sIgFdrPC0oyA1ZJcloOIp0i8YHgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817319; c=relaxed/simple;
	bh=cOwreW6S5TABEHJlwZlMIIHSrtzIZn+nQff2XWEoojc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRevYt1SWNf1IoSUbxa7sGHO7sSIGASuNhRx/ZerkKFRs+CAjJSbKnLuRhgit0KbkCSAKM0obab5ioWbPbuhpyzpLtBzPMFKzDVHgfFdE0xqGC4juvYAnqrngdHif9Mq3EDI+Lm5bTQXib1esolUrLTd0XNrb5qW9aBcB6c9V6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuFZLJC1; arc=pass smtp.client-ip=74.125.224.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuFZLJC1"
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70f9ad8aso656485d50.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 08:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791817317; cv=none;
        d=google.com; s=arc-20260327;
        b=PxWu3sAWIUXDRCgPz7L3E/Wbrc4OKNj1j5OYBKPif6GlXgXyje/ORcl3BDZqqu9DrK
         hD8FVbB72X6pDOfJ5EWLGz04jIItKfbA/+vrHqKWIQQkq+Zwf87HwafkhITPKsNWPIlj
         RV96AyFZSIzkyG50/2ipqHu12H7d0yAPyUWK1kxPXj8Xz2h4bU0vASYXQrW/Qi9GKbR0
         v0gNNtn6JrTR/9OKMpxQV0qQACkbTFKFoAEPt9wlB1cgHkap5BMYYVSu9a67EzlO3GSP
         FGsNsMY4qbqDuYHXPkEUDS7uLFthowVzQz/ms/p3alpBkpG8JGr6v0V3KEh8OMxn9L5a
         JIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KIAMYnoVUBdUzXVqQqDP3VFDzLpC4xBDzQAPsFXbvk4=;
        fh=nxDso1EHnnOtoH2as5n7nkDfGKjuHhidEMIyeatYXDI=;
        b=ZOZ67d+j1a6JF2lh1Xn1gQUktOMwwa2JPxQrS1POUzjsKpTue0+gjTYVvSGp1SYw3M
         eXNoRjPR/U1GGWwJ84gCzmMQ+IG0nsvJP4z2PmmupLCbHdY2S08sZto27lCPfSCKvTt6
         vE8l1HTWow3hh/5u12PezqTYsU4EoXxIAH1hLLW8wtkqSkJIv6X+UR/q0U7wazuGZKD9
         pB+0mO4K8xON/qbbvI5llGIe/fzt1ijBB4burax1ZGl0X+buEo1vg/pBJFEMOCgF8nWt
         OzdqkLe7EcD5x1MZVRN+vIVaGtaP1GhtkxBeFuErH2N+U9mcT+tVPxms4cBTRx2LjBCN
         4WKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817317; x=1792422117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIAMYnoVUBdUzXVqQqDP3VFDzLpC4xBDzQAPsFXbvk4=;
        b=iuFZLJC1n2zDBGrbnsAjhS9nMpI5G4uIyjFF0sdpnfaCs9CaPfqzTaqM/6SqDxbJ7z
         VHvCa4nQCALItIJ7NhIUmdfKwdsVOMezH4OLgp8FMg290SMe1CxKrhTh2Pc3Rl6FInDE
         BAqyp2uoxF4jojWK6c0JK6YbtfLEMoliCff4DhwPvt+GTggIYfZRWfuSh7s38zDgeJne
         VebJdofkYVMBsyXSzbcVzeZ0f5OdXSGYHKuGGngWB5lUK/tlNA7UjSRsulqECZMYJ89S
         UX9a/4Qkrc/dNMcTKFBv65GKC6zZujtLnpEhMfYR0BwwE9+EP/SsF8y4jRRu6PImrAMV
         gLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817317; x=1792422117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIAMYnoVUBdUzXVqQqDP3VFDzLpC4xBDzQAPsFXbvk4=;
        b=woxsgJ2GGUbNu/QaPsYyWuSkBEhsWDKgXiq7ViMN6B+ZQ8VqsbpjWhuULiyTDPZBO9
         lxvFZQgO1gLdng9NIhkYNgFW+zkuSuyIzh8nQUiP39LZK4c6VuqO5CLu8G6L8YQhLnU4
         agHd15xeUI5bubTzyBVzoObEKkUu+Wx+aYmT66bXIBBusZCcx2KAsg5DwgYjxAizyVOF
         jVuZTws5HDRROoIPXPavHvm5S3LXUC7FWT+TPIVwupObHtCTzGudWjaEFfOA6BAppWf6
         skruKlPBQwzWt9DehMfSihGTjV2ysget6njjD4oyoULAGwBXoEGnIMb/2JwDKxTzGwCG
         +jAw==
X-Forwarded-Encrypted: i=1; AKwUvBylXDdYz+Jj3iobXgqkpnwIR0FKRAKkx0OaE+xrRnPGKA4Sce9oM9zG3S9yHaIC0PI8eXWHW/kOB40=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDQWfsesvTdhbSRTSQ4kijYKofR6UwkNSMmNstp3tHqRYZTLwo
	0ghPf5qUADsn1hcE2dKtakciAmdrxKm84po3vuetzGW9YsJjnTn5iJM7ImrIf64/b3L6SOsNQEC
	YIgPOGN+9kRkMlczpplmZLbMfo7qtwLU=
X-Gm-Gg: AYBFou2LzRDZgft552eh+i9rLHaMCw/XQ/Ee/Mq7x6Dav3ByRCehIctxNKgpTlCZ6c4
	7LnM2y9mPeTRzCRBeLbXr0jtJYerZSXGf8vnp3dz5uOUGmgmKGGOnpg5Y/5thlgE8bi9Z8almZK
	Rei1XqxgOAsCtTIVSBU5Yuh5hASaqD24JFObQr5FHfEFTx/rDuGY7wZVa9zLTyJM1Bq3wEBkg6i
	Rwo/0uAX4n7buDcYH/oKm3+u+Eadyr+uoWc3w4uPp01wgfw7lqHrXl2vbwBIunvRToNnN2vJp4N
	I7HxYV2WEPUschQU7YSM3aYLSFegbnMTRV5gSEXSaBaDIP8fBcJARQ==
X-Received: by 2002:a05:690e:169f:b0:677:ab1e:92a8 with SMTP id
 956f58d0204a3-679369840e4mr3810866d50.28.1791817317057; Mon, 12 Oct 2026
 08:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011132017.31131-1-jianyungao89@gmail.com> <20261012152830.5406d532@jic23-hlaptop>
In-Reply-To: <20261012152830.5406d532@jic23-hlaptop>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Mon, 12 Oct 2026 23:01:45 +0800
X-Gm-Features: AclHuK8D_Mlx_jmV0S7_mwmzxgLO6vaiUUSAFEJ32lGeOuz-LFaYscxAPVUV5CY
Message-ID: <CAHP3+4CC1DFcUNrWDG7Xg0yi26zQb5DNEp8BLgVyh-Vo5yUHjg@mail.gmail.com>
Subject: Re: [PATCH] dax: fix dax_core_init error return code
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you for the review!

For the goto err_fs change, I agree it's unnecessary since there's
nothing to clean up at that point. I will drop it in v2.

For the return 0 -> return rc change, I also can't think of a reason
to deliberately swallow the error. I'll keep this change and cc the
DAX maintainers for their input.

Best regards,
Jianyun

On Mon, Oct 12, 2026 at 10:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 11 Oct 2026 21:20:17 +0800
> jianyungao89@gmail.com wrote:
>
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > dax_core_init() mistakenly returns 0 on error paths. Change the
> > error return to use rc so the actual error code is propagated
> > to the caller.
>
> What is the user visible impact of this failing?
>
> >
> > Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >  drivers/dax/super.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 45f84b0eb909..0f35f65363ee 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -723,7 +723,7 @@ static int __init dax_core_init(void)
> >
> >       rc =3D dax_fs_init();
> >       if (rc)
> > -             return rc;
> > +             goto err_fs;
> I don't see an advantage in this bit.  It is a fairly common preference
> to error out directly where there is nothing to do.
>
> >
> >       rc =3D alloc_chrdev_region(&dax_devt, 0, MINORMASK+1, "dax");
> >       if (rc)
> > @@ -738,7 +738,8 @@ static int __init dax_core_init(void)
> >       unregister_chrdev_region(dax_devt, MINORMASK+1);
> >  err_chrdev:
> >       dax_fs_exit();
> > -     return 0;
> > +err_fs:
> > +     return rc;
> I'm not sure about this one.  Will need input from the DAX
> folk on whether they were deliberately eating the error return
> here. Not that I can immediately think of a reason to do so!
>
> Jonathan
>
>
> >  }
> >
> >  static void __exit dax_core_exit(void)
>
