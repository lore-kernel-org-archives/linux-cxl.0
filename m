Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707A44C658
	for <linux-cxl@vger.kernel.org>; Mon,  5 Oct 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193629; cv=pass; b=XsvBzB8ly9XmxHfYRil8Kmutf9wT0QMVdz+ZfRqwvfukueAbmGpbPoRZ6B29zt3H210UEADYYZBxgQ6ZKAjr82z5SJQ2QKk3ElW8D+PUoqPkMEn1Qwwwt4xa2YdNMhHZ5TXLgL46SaDiqNk6pWeBpwTy3ny7CtIdruQK767jyAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193629; c=relaxed/simple;
	bh=t398vXnJkLdtQG+smof72e6y5/ZQ0xhfNFlipmHb3tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSmrTaNgrW7pd+nJTXxqNsw4yNXsq//x5Hia5PL6FGjDQe0YnS9KO9Od9/Pl/Y5Xkaw9NGLOi5h4/i3Xoe67xxMlc2/x0qXQesztadqhv+BFGTujKrFo0Ex5juW9RfVn/2DRGfa+ZmN0nOlzNfOcacDwavSIyOodBiHgN0XI3Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=crHzQ88/; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="crHzQ88/"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-534af4d1a37so13934181cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 05 Oct 2026 02:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791193619; cv=none;
        d=google.com; s=arc-20260327;
        b=EnmMSVbfJcW2PsPbg6SlAPpw2cmM9i6wRmD8mOuZkhjmm8FqWyxrrAFE5sKCkrPJRk
         ZXGvHK/YBjguniex/ntCN5udRE1cisBmPqVIj6352+qlgQwG+dCjN/NsgOVTVxpZbZer
         mEQa2r7drZkIYriXNqjm8BvRIGWzyybssCctn2ewcMfrwu52ylML9bbmdFqRPZY0rGfK
         CytMqIz/NLrYpMYoO5bLOzJcnd4Qr9oyoROpaDx57C03M9OtWW7/Hf3V7IEoRsdiNe8e
         8EZQTdP9RvkTnM9CHruFJfXX7smuVlGk3sTnyQw2D9buHxDtiNGUbuEJhImEk2VLU/vS
         sCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2x+PPGLVG+ZTg2V6l16xtjRBE7YmaOwtXNyp9L8s3Uo=;
        fh=q1jQxi8Bx9sNn/+1a0+7iQxMSeIQA01WazXSWFM4ZjE=;
        b=Pub/7ZHvQ6iEPa3G7WRwJzTDUaXsUxw7tcwH6OL8woBh9Fhq7OZ8QWec1qYVCWUhym
         TgRDzlJ5jd7meXBiwUa5g+qs4ETFTidKHMDuCZymhCgDn9phu7gbYD8nQtVXBIMJfJ90
         TmPkfdXgwwEkUF3poYPyMSfZ9ggm1P4GrWbFZcCcOAr0uPOP9G++sEYlmmeMICcjU3Ls
         Bo41EiI1wt4KXhlRBFA18BcvZIjxYquVw24rTCc03F8yEX6uU1SRu59nNlHiBDqwalhO
         TW6bfRDrDWy78VruH+zH9jrv7KN/JT/PFz0QzPAXkjY7GEMYIS4TlHLCGsE90ApLx9dW
         G4Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791193619; x=1791798419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2x+PPGLVG+ZTg2V6l16xtjRBE7YmaOwtXNyp9L8s3Uo=;
        b=crHzQ88/ptdiZmXqXRu//UG7sELmHuJUq1z4e7p+A47Kq5avjodvcWruAAiuo3K9y0
         s+kkQSfaDE9CgaeSXSOWH5p/rDStvGd9eF+2DkegQ+r10I08qxf/Ovtjlsl6bpkTzQ+2
         32MsczeVAxpZDvXBuNWn2CJCjDJq5Gocep+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193619; x=1791798419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2x+PPGLVG+ZTg2V6l16xtjRBE7YmaOwtXNyp9L8s3Uo=;
        b=yBH1sAFrYbTaA5A1RIXaJRicdQdS00md8fsGF4EigwTdOwax6jFkSajz9DpYb2YTW6
         wgFXziZh2vMpNUGhEhDydkzT/IOuiIprYbMXlkR04OtJaGYWahWlddoURpQ30E7y94dw
         jUb/C8JXP7j4mtaewJIy/mf+spDNCNlK/HKptgwtGATL9uYeBmsaVk5nEZaZe/1D2dQ5
         LZuy+IZxRU57zOga3e6T54Ta/Xi+pUjC5Qmcj6+H/5sFZ8YllHpwkKagqt9zfv2up3Ci
         6Ox7MprVqYvPDUu2nkS+J4ScuvmYlD56DM81RGTgRFwRQDZcJqAeSlHW9YrRc0H9X1WJ
         B97g==
X-Forwarded-Encrypted: i=1; AKwUvByc8165vXNk/Bo62o2frEz1bRmGxIQ3FZYeUqVs/SeDUHZyI+zzRpHiISN/MPvmq24+gSbPHRaPGIw=@vger.kernel.org
X-Gm-Message-State: AFuF++k6P6jyxabUfILdzDd/lLmELXGE/9OKJljfu2JZHfPWiTGv9J5Z
	AdLxOH+vlvWT81EeCHu1ULVpkBDbm/PKcigODcZgcGZt+Z1UYPX8tzN1GbCJLoumkZP5TuY9oLJ
	gov0aAHAKayWLaF6uZ+Mlp2jEVptCbYmCl0Mnjq5bwQ==
X-Gm-Gg: AYBFou1JOjfM799HN4dVR90O9sMeM8MwyMYQHbhzKjBaW6HFe8uC55GkQQ2iCSsLOvV
	hVL66375kuzW8kSugGUEHx0XxStNMFDRje/B942G43pRKSEpCN2a7+IPCTC0t6lyrxnGENn7Tq1
	0L3VEnlDfi2n83QtcppuqoI4w+PIYeVncq2ZaJL2AiDSETIQrjt6kWNmnrlGXmDEHQcTFn4E4bz
	Bbw633B7bSeEXC1gU65yxu++Bxcc6VGZsAZQ5bujrTh5ivD4yl3BC/aMgyuMGJPFNA1T5Yg97nr
	9lbkpJg242oNDGtXLhLD1VuY7Fv7jt6dQ10Edx5BKGY2L//3u+T5VisuFOuzgq6QqptTrxipBCu
	lENcydyE37h+/
X-Received: by 2002:a05:622a:4296:b0:533:3fc2:8b19 with SMTP id
 d75a77b69052e-533cba5b5b6mr179731811cf.20.1791193619134; Mon, 05 Oct 2026
 02:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-3-mszeredi@redhat.com>
 <CAOQ4uxjQYaFUG=VT1LoKbs3QUTbTeEy3tTY=_FMujMiWGRR_=A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQYaFUG=VT1LoKbs3QUTbTeEy3tTY=_FMujMiWGRR_=A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Oct 2026 11:46:47 +0200
X-Gm-Features: AclHuK_XtJM6zEUYob9rIZaAPpf4JoILbPUmLW2_NodFgyAwj0rWiXxNnekRhk8
Message-ID: <CAJfpegva+dThGSUf0jEhp_9FTyw6f+ZC-5D0F0R-gPPSxXypYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] fuse: add helpers for EIO return value with kernel message
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Oct 2026 at 18:39, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 5:09=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:

> > @@ -118,11 +111,9 @@ static int fuse_file_uncached_io_open(struct inode=
 *inode,
> >                                       struct fuse_backing *fb)
> >  {
> >         struct fuse_inode *fi =3D get_fuse_inode(inode);
> > -       int err;
> >
> > -       err =3D fuse_inode_uncached_io_start(fi, fb);
> > -       if (err)
> > -               return err;
> > +       if (!fuse_inode_uncached_io_start(fi, fb))
> > +               return fuse_EIO("failed to start uncached I/O");
>
> Why lose the internal error code?
> If server implementation is wrong that is a good hint of what went wrong.
> ETXTBSY is trying to mix cache mode and passthrough mode.
> EBUSY is trying to passthrough to two different backing inodes.

I'll move the error codes back, and turn them into fuse_EIO with an
appropriate message in the caller.

> > @@ -234,22 +228,10 @@ int fuse_file_io_open(struct file *file, struct i=
node *inode)
> >
> >         if (ff->open_flags & FOPEN_PASSTHROUGH)
> >                 err =3D fuse_file_passthrough_open(inode, file);
> > -       else
> > -               err =3D fuse_file_cached_io_open(inode, ff);
> > -       if (err)
> > -               goto fail;
> > +       else if (!fuse_file_cached_io_open(inode, ff))
> > +               err =3D fuse_EIO("conflicting passthrough open");
>
> Same here.
> If we can keep this bit of information and print it - it is helpful IMO,
> even if we don't go all the way to annotate every error case with
> a pretty log.

There is just one way to fail fuse_file_cached_io_open() so I think
this is okay.

Thanks,
Miklos
