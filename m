Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABB4F55BC
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166659; cv=pass; b=UdnaraKmetbYtGgGKWZKQdxYex9iaLn6MLxjUxryv4AWt/Wma3CJesuaX5EocIlQDVw5SILfKRkr7Z+kr+oROYzBlu68T9B3kfV75WL/5+4vgJ5lJHhM/RQPQVpF7q55yQmM5KSO9nIJSDk+8FMshiYXTsOWB8DY7kZZ+sdFqSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166659; c=relaxed/simple;
	bh=9lv8y/8boJJYeoN6PZYJjxSqtNYDKsLSBds0Xi+bxrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMmRRsWdqzOPFM9iyjs8qJWopoDWgqWIQJ6S6H6UUsrh/GkBUX+AQR5nD1N6Fd4O3Nomcqk54y8458yH0mUhFpXyKgq8yCFmhw35ZjHunmwZccHuGsizSaIXcKn9QwT8QlhQlmjbBi0E/Sc9WYoNYvhM1BaFDH2+aH51c4NSL7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ0smH90; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ0smH90"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so24550a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 09:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166652; cv=none;
        d=google.com; s=arc-20260327;
        b=UgMaEmoc6f81912TP3fxWcW5RChU7gKfoMEeZTytS7AX3ieAhZEQDrzigqkcL42MTR
         vu1QmWsoEBzdrslropZrniYDCh5Dfm5sKvDHTxmWlZPq2SsesadXuO4BGeAkoJHi7B7s
         Ru+aXwN41sqp1IaJGGGsu9oujWYUuX19lsJeOa26uk54lNnLX/HKd+BP8b28YKqK/+eV
         7srx18hHCFcAhS3AUrOD+1VJiNJKgwW42SeZInkHkfM2e0UBtU5jXcdpBSe48J4vONgl
         YcULdf3IaT7XZ+b7vddM6+/J+PiLFt2KLJHC12Otg5Pp4AR+TV36Ky3OJrBuJPAuRies
         pVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XT9gf6Lc+1fX8Xrkj2lJ0FO4HQTQ65QLq9M5IgaTRo=;
        fh=/gU4YfpmAXqUIzD0EVIiu/ijGrHr2DPHmvBdFVsD6Ps=;
        b=MmzcDNxrYcdVPk04drSOKXhVbFcxm0Wg+3THBN/sBzZT9JTL/QpL/B0pdgieyECVYU
         7b0+J6e4eLhOeCC0wlKDq7aVjcZBUa4iTZs1E9boMjeqZIYD3oAfXE9YQXyRDdEFmOBH
         mOLmSLFfBCELGVjJh9x4EWXV1ZxmyvQOXonkGXbNvgn4stflgvclAl3Dhwlj/LtljvX0
         BzWVMZApkKH145GonkZmjppF94h+xJPxmErOqnF5OaV4ooMSsPXRkaOQOVLFek4Z1MCq
         Hxqv9364zfGxDGISrRQg7F1shCc5z8lCM/cJ9T30D1yHVLOxpjpPYkfOTKrfGjSUoTnz
         mEgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166652; x=1792771452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0XT9gf6Lc+1fX8Xrkj2lJ0FO4HQTQ65QLq9M5IgaTRo=;
        b=nZ0smH90O2BcJQEHiLGS9+qTMSQvGKRPBudRMNJgFmbiO1irM2c38CQ8mh1Bjnb6/S
         gsLIEygi47TzqyloVfrJKzPzHVd8fR90b39H9xwlPxsRHksQoq2smDIVyHoymS0wPbOz
         dDCgEIBeO8x4I2dNMRKijOWTxECJkhIg8VKUyTNoO30kBsH9vQrw96OgEZZf/LffdmP2
         4ItL28QNdYvOO6fvYG6iI0ALfK3Dj3OuN8p4KVG10VQH5vER/3aRLgShcPdE5c3jg8b7
         TFbAaI2q8unGeogUh/Y6Pei9ESMK4OeJqHHWjW4Tp2OZAWdz1qnYLfaoT5KGEGVxROrX
         9nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166652; x=1792771452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XT9gf6Lc+1fX8Xrkj2lJ0FO4HQTQ65QLq9M5IgaTRo=;
        b=lbohENMcRIVzoYSY+ahiuBXpcCxyiKrYxjlWyibplmx8r199PzWBosTzOiw2okQSnc
         1+zarcqgxfCioR+rpUVUBQBmFn+MTJK9f5gdmE7l72P/EFrQ3q/6eDuH7rtze5xCjtmF
         VMPU0+DhYRRs/neftEXXo3lpG3EOhy94rVw6cqwtfOZBbLFNV1/kJX2/prNR8+BEjAvZ
         OUp5UBvcaMOROJN5EE3OjL6nZ/yI37NzxaO8hjZFrVkgKHvn9lmKHtRuWkqNALdS0Pj0
         4FZk1S8enlzr3O+sPGlQuCGygYKCEgbOSTkiyZoNuRpRjgz5pBOR3OKU17xgtbQS5AJQ
         7R8w==
X-Forwarded-Encrypted: i=1; AKwUvBz1PJh2niItbP6wJnA+Y0k9EeNlQWZGVIo+UsEo0PIAvV/gYdhaWJsETAuuPrCpfq2OVzKIgeECAOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6bTS/TKOPdsOqaZFca2LBvINxDG6ELA4twk0PO2yQxCE++rBQ
	vASkze7foJTkWwbQ+CIuWCgfaidUy5wxlzWY/hzxV8P1IS0a/oV1hwwZ6OxZmi903I9/YyMubCR
	QNiZpFn2YDaJ1EfCteu29g1ukbNZEODEESCgrhoY=
X-Gm-Gg: AYBFou0K86OWvVp//pWfeQq45XCXoBhdSBCUbfArNC4rWOOGcMRemvtt8GRWd4xzZc7
	CnsBPRmNzK9pLlMUp2hJqL+cJUiKxRmu+LL3I3Xm1bOQrwRHKpalAQwBS+r8DjQZWEclAlc5BSp
	OLVpYxKkMLBAUAAdO8Uv27B2z4yBjHGBW7isrTc895C9DnNarlrQinYJ/nm5lSee0yGjxHPsxcn
	godzSNRj8t6D+YCzh1tWIj31KpiZWW43OkmpyF0JtQzV3ZjBda8bCv3G/bmb1CIbCaKXVUQ8FqY
	2p/sEs1rqjU4NDLswkauJnO9/3KFkKYa9rEGHjAiblvAGtzIQRqii3qd
X-Received: by 2002:a05:6402:4402:b0:6b1:c299:b3f8 with SMTP id
 4fb4d7f45d1cf-6b1c299b53dmr13158335a12.33.1792166651834; Fri, 16 Oct 2026
 09:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008112004.1899560-1-mszeredi@redhat.com> <20261008112004.1899560-9-mszeredi@redhat.com>
 <sashiko-outbox-164097@kernel.org> <CAOssrKeEOMUHz_Esfi6L0tu0rbd+aMbb9+fi9fzFYu5NWczOZA@mail.gmail.com>
In-Reply-To: <CAOssrKeEOMUHz_Esfi6L0tu0rbd+aMbb9+fi9fzFYu5NWczOZA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Oct 2026 18:03:59 +0200
X-Gm-Features: AclHuK-Evug5KGDMq7YW7UlXb9Ln9FrCYT22ooxxec4w9tRZ6QLvbe-ThSbMDYI
Message-ID: <CAOQ4uxhgFM=SN_WKGp8PXGpHJhk=vr9ADS0OU-UeEv8Mrba-XQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] fuse: add extent map I/O support
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <john@groves.net>, 
	sashiko-reviews@lists.linux.dev, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:26=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> [Restored Cc list]
>
> On Thu, Oct 8, 2026 at 1:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> > > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > > index e9ab1aea34e27..040817ad76e94 100644
> > > --- a/fs/fuse/passthrough.c
> > > +++ b/fs/fuse/passthrough.c
> > [ ... ]
> > > @@ -74,10 +73,13 @@ ssize_t fuse_passthrough_write_iter(struct kiocb =
*iocb,
> > >       if (!count)
> > >               return 0;
> > >
> > > -     inode_lock(inode);
> > > +     guard(rwsem_write)(&inode->i_rwsem);
> > > +
> > > +     if (!backing_file)
> > > +             return fuse_ext_map_write_iter(iocb, iter);
> >
> > [Severity: High]
> > Does this introduce an ABBA deadlock between pipe_lock and the inode lo=
ck?
> >
> > For normal passthrough, fuse_passthrough_splice_write() acquires the in=
ode
> > lock first, and then calls backing_file_splice_write(), which ultimatel=
y
> > acquires pipe_lock() via the backing file's splice_write callback.
> >
> > However, the EXTMAP DAX path added below for splice_write() directly ca=
lls
> > iter_file_splice_write(), which acquires pipe_lock() first. That functi=
on then
> > invokes fuse_passthrough_write_iter() where the inode lock is acquired =
here
> > via guard(rwsem_write).
>
> Brute force fix would be to prevent mixing plain and ext-map
> passthrough.   Might be a good idea anyway.

You mean not mix on the same fs?
Make sense. So another init flag?

>
> However I'm thinking about why fuse_passthrough_splice_write() needs
> to lock the fuse inode.
>
> Tracing back through git history that inode lock really originates
> from commit 2a92e07edc5e ("ovl: add ovl_write_iter()"), which added
> stacked writes.  That was copied into ovl_splice_write() by commit
> 9b91b6b019fd ("ovl: fix deadlock in splice write").   Which was then
> added to fuse_passthrough_splice_write() by commit 5ca73468612d
> ("fuse: implement splice read/write passthrough").
>
> Even for the original ovl code, I don't see an explanation for the
> inode lock, but I'm probably missing something.
>
> Amir, any thoughts about why that inode_lock() could be necessary?
>

It is my understanding that the inode lock is used to synchronize the
copy of size/mtime from the backing inode to the ovl inode by
ovl_file_end_write().

We don't have this model in fuse passthrough (yet).
I think that fuse_passthrough_end_write() do not need to be synchronized
so could probably lose the inode lock in fuse passthrough.
If we even implement the inode passthrough mode where the
backing inode attributes are the source of truth, it will surely be
a mode that does not mix ext-map.

Thanks,
Amir.
