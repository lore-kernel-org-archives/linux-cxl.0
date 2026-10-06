Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B138A736
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324542; cv=pass; b=hOkli9pJDXjU47/LlcOWrhm3F3N2B/+TrtkKd9yoiNZJJzwuXw4Y/xrGAjz1nspw4lBp1imyRoKSMDAKjjmNMOIWZ5CCj3i0LCCqQqZAYmfcskAQ6nvMY4xt6RRVmA+Qa/51p5zckS8f4L+osk5aZBFZejqUAoLpWasgO8LAsSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324542; c=relaxed/simple;
	bh=FVulpAnYmlaz6ZGBqEF0kXcLNEDT1/mgk/OAXn/LvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec0wdi2LqkOttH8eGHrMk/o30XLF/t8ALrOE13lpL/rufiNbev12+Ulwk10Ty8mjiVpHwbFVPR1JJJlB3IVZI1p7VbbBx2aIqHsTYUqQ11VzBBDp6nGyJL2zasIeLWTpYx/zElEqndSLIfwXJdHz62lmsIvu+hRvz+otcXJVb2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RENi2H/L; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RENi2H/L"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6acbdbc1725so4727973a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 15:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791324539; cv=none;
        d=google.com; s=arc-20260327;
        b=iLF7yYo9seA17o90o8xaP//tGblTbWnzDkSm5ei8WsoNStX8Q9lxYDjVDqBo6IT8Ed
         6qNM/ZsxsGt/kXl19c1mQE3b023WFxB1wMiLDQQRka1SBB3qpLx9hMlO0MfzXQPrGGgU
         5QQ2OLUmI/zeVpirEpauvYC+5S2POeI6/vNPeRX0IRB2WscNlbNuSTJPy2KPJ1e5on5w
         mfj0FKGWBqq7+svix4Vl648TaDor5LHKRQ1XTeGSuNn9WZuAdhiwhbYLNZza2OCbpeUC
         eAbN+GZkt3ZQGVj02nHv6NF3UNOp5r3l+XcVoPMqDj+ksTX25VVOfK/FxjXFH5CQ/fDG
         1v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Vo8bv/Mw9ldCtrjaA+pK24JIKyIXZlS7hf38pMZ204=;
        fh=su0NH4OfGtoiqHBMzzX52xPKcKGyhN+MzGugfcIuVWA=;
        b=HVgLztlo/ATmvg2KaMGWYgmwQ8n6OMub5AnIlh6V4vjbCIrcKaWYCuK+EMxDLjUe1U
         ZPwLDU1sGBPFsOYoQ6qZ2Xkq/UqtCxQPMQeustKRlRRkkAefBU/8JtRbiXa6iCYr+wLj
         ub8B4qVg3b1HyR1TM5Te/gJCQCLCfiwpditAv7QGZHG22ANXdJPTtzNfgEPI4o7bZMRA
         VSVRLY2e+tCzjNOD9DSZLgShC8690MXaqGjHftKAa3C2GecN5VFcQs367i3y7o8shnvC
         vjq+a070EiUaXqHIuQG8UqkS8ocSs4RA50FJhjXiaKJ/2/cUCnvzW/uYEof0DQJcK0nq
         7wHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324539; x=1791929339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Vo8bv/Mw9ldCtrjaA+pK24JIKyIXZlS7hf38pMZ204=;
        b=RENi2H/L555rOzWGEQs6/Eq0Fn7a1fzrQNtfPZ6ovCYXAjADlxxsatNfOkgS7RyWd6
         YK7keH0Zbi2L9q+zDDrM+p8HprOJ5OBvkIjr+tWHi++rNCmMauEbjvY2Y1Pe8OG5m9y2
         9OUuFngZshM75EB/x/N8aV4khmCjT/npKefJ2p622i7rRMRtpDTfgeUd8P/uOm7osG1x
         28Ha0ImLvxdcJxs8ae0aUKK3yMihaJx8tdZRXkCEZWJeYWHmfUrriLWiVr6SalS8zN9X
         IwW865z1Z03tO2MA2dUidiG1Z6iLom2bsJTrccizaXmnaYyqbYdX75WzuDWU8wRwzj8R
         6fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324539; x=1791929339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Vo8bv/Mw9ldCtrjaA+pK24JIKyIXZlS7hf38pMZ204=;
        b=qjCpjrmrvL8Pl3Y5+FgKTEx8WL99qQ1G0TuvT9CdarQYr4E8jyIqNuW5PGPRFKp+W5
         H4cneUD5Abe2S4UkyD2DGWzrJg1UiS38kHgI9WAfrdeBTeUB13vrusWoEwxKCfG977Ll
         xD9ZLxg6KAWmImsR4AoqipOGOt1+x0oBIo2Ha2mrf0YOlRXbGmJvN5ccdEiw5IYiZIE9
         7iLmoycD7VRhFrn+sbizhLXll2HuUenF63zM3yXX5HXGFsK1ke+bk1SsLe6WUozQMTcS
         W2IEMT7JcICWAqNWv6fOSlJ66anwA0iu1Zfx7a9UR46YT9uBotfuXbHO5hkC+yMzs/G4
         2oiw==
X-Forwarded-Encrypted: i=1; AKwUvBzcmAh/M3Ahg7wIJaDW061GZunat/ibwkODevFkmcDoLCwl7ZQoeEmwT/s6UuO6PzId8zNydYjrSRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4rZ2r5lhcS/byRbrYuEqLRudXOgvzT83VcakbTxPGAN/RiNA7
	/nBdDi1pSK+ECZJvcLshCJUWPjB4n0DdHswupi19olYzawAXGPpkYhE1tlMY5jSEKuZQL1q8M3n
	OtRmgg1X1321Z+IkLNYZdKZlZGIbtanM=
X-Gm-Gg: AYBFou0s12okCc+O5/4BaJwsjZFdihDvFH6FqOaBXgQjZxRyYbEfc0vvuHnnxi7MMGF
	R+mUQ9mVtgNmmxmHyL2K5TkJHyj3V6yQlzuDTOgzB47bEk03gtzGomeZVPS5b+WTTnskcSJOKMx
	F26u9ba8fuyWUSPBDan+ReH1iJlJ+dVsnlgKTDhYLnyE8o9VtyEkEMZf2oKeawYDL7nEJUc9REN
	/HiJ1A4k4Z1xX+k09VdDHdlxddpoBBHWvZD5bSUHe1kwB+szu/a8ucDNw5kD4j9+3xUO+0uj4Mn
	RfddUPMm4MNmm7EfM2sH0obPWX0JVCH1rO56yetJzsLXg5lMFJRR1U+couBIcjp5f8g4gOS/XxF
	Jk3YLfMA5rfU=
X-Received: by 2002:a05:6402:51ce:b0:6af:bd48:4b2c with SMTP id
 4fb4d7f45d1cf-6aff2daf769mr405047a12.5.1791324538890; Tue, 06 Oct 2026
 15:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006180115.1425232-1-mszeredi@redhat.com> <20261006180115.1425232-5-mszeredi@redhat.com>
In-Reply-To: <20261006180115.1425232-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Oct 2026 00:08:46 +0200
X-Gm-Features: AclHuK-kNEGr89TsaMC-r6qkBAXhNslF5fmkkNhAIDRFq3AWhso05mVTqiKMWVw
Message-ID: <CAOQ4uxjRAgNKEKOj3yrh0fp_uBdQ-G=5C55G6M8vyjWgp2zvoA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fuse: support 64 bit, server allocated backing ID
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, John Groves <john@groves.net>, 
	"Darrick J . Wong" <djwong@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 8:01=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Add support for server allocated 64-bit backing IDs alongside the
> existing kernel allocated 32-bit IDs.
>
> Opened with FUSE_DEV_IOC_BACKING_CREATE, the backing ID sent via
> fuse_backing_create_in.backing_id.
>
> Closed with FUSE_NOTIFY_BACKING_REMOVE.  Since close only provides the
> backing ID, not the file descriptor, it doesn't have to be done with an
> ioctl.
>
> Backing ID can take any 64 bit value other than zero.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/backing.c         | 179 ++++++++++++++++++++++++++++----------
>  fs/fuse/dev.c             |  24 +++++
>  fs/fuse/dev.h             |   3 +
>  fs/fuse/fuse_i.h          |  24 ++++-
>  fs/fuse/inode.c           |  15 +++-
>  fs/fuse/notify.c          |  28 ++++++
>  fs/fuse/passthrough.c     |   3 +
>  include/uapi/linux/fuse.h |  22 ++++-
[...]
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index cbb10e19e7e8..b5b51865d59f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1408,13 +1408,24 @@ static void process_init_reply(struct fuse_args *=
args, int error)
>                          * them together.
>                          */
>                         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
> -                           (flags & FUSE_PASSTHROUGH) &&
> +                           (flags & (FUSE_PASSTHROUGH | FUSE_PASSTHROUGH=
_V2)) &&
>                             arg->max_stack_depth > 0 &&
>                             arg->max_stack_depth <=3D FILESYSTEM_MAX_STAC=
K_DEPTH &&
>                             !(flags & FUSE_WRITEBACK_CACHE))  {
>                                 fc->passthrough =3D 1;
>                                 fc->max_stack_depth =3D arg->max_stack_de=
pth;
>                                 fm->sb->s_stack_depth =3D arg->max_stack_=
depth;
> +                               if (flags & FUSE_PASSTHROUGH_V2) {

Since I was contemplating myself on whether I should also add an init flag
FUSE_PASSTHROUGH_INO, it occured to me that arg->max_stack_depth
has plenty of spare bits to host FUSE_PASSTHROUGH_* feature flags.

So if we rebrand it as arg->passthrough_params

#define FUSE_PASSTROUGH_PARAMS(max_backing_stack_depth, flags) \
             ((max_backing_stack_depth & 0xff) + 1) | ((flags & 0xff) << 8)

We could use a feature flag  FUSE_PASSTROUGH_SERVER_ID_64
instead of wasting another init flag
It also avoid the unneeded questions/documentation/awkwardness
regarding FUSE_PASSTHROUGH_V2 with/out FUSE_PASSTHROUGH

But mostly, it leaves room for more extensions.

> +                                       /* Prevent race with fuse_backing=
_open() */
> +                                       scoped_guard(spinlock, &fc->lock)=
 {
> +                                               if (fc->backing_id_32)
> +                                                       ok =3D false;
> +                                               else
> +                                                       fc->backing_id_64=
 =3D true;
> +                                       }
> +                                       if (ok)
> +                                               fuse_backing_files_init_6=
4(fc);
> +                               }

See my comments on backing_id_32 gating on the v2 patch.

Thanks,
Amir.
