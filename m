Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167D1E50E;
	Sun, 22 Jun 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750596654; cv=none; b=HAw6qq+B6kHr7481+HAlM1hAQ7fnTMMObnXpgh5Wi4ruvp5Hm+/+2zh9XtwzPSJbSF2e9ENnFBjkRZPpwMjMK1I9UlZiWgX3jfB6Mk0f+vOWi4AimIGIm9kGSuf0jv8CfampHMOzkstgqQsWK5kb7SjVLCpsYCrUtLA3/a+hqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750596654; c=relaxed/simple;
	bh=LP62ThN8+dqGtMsgMUB7WR3DT2vghClJKe04swbOiLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azCRHT02ctzrnLPC7uBEDhGBF7Mag6UFVdUt1J813h4Tly/szNZZs/OA9xC3IifWGhZt8cCKFQ/bjTn7c7ablyxALeeOO/P1Z8637lDy5NDAuiJHrMgI196ZtS2zpdV7MSoANXi3YWjUJYpz8ETm1+DYQhx7dpYMggIGg6UulQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XufU49SF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XufU49SF"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so25250451fa.0;
        Sun, 22 Jun 2025 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750596651; x=1751201451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFFYOfuMXwg0F/A7AmhvhfJNkmAtB4Mz1/92bvCyRBk=;
        b=XufU49SFP38mmWyP8jZURqeMz+3DUlh0GH8j0z0I+//XQoJRCQ6jPZ9Epsn+TzuXWS
         +Vhb9NxLyrYsQGVVkcfp2l8uc8hdvZuBaCoTw89Gdg7cP7RqBieBzgA9N4beSZqeFddk
         juh7UGIUfYjkcRcZIjg/zM8QjYGlQbbCUzsoCtZg0QF1Ztz/bH0Fx6mxlu/TF0bpejdh
         /hoGWZCI+S6dKcTbgyHwbHTsVN5lXtFt8c4obqfyqnOvjzWBoiO67nXx6lcEvdPNO3TA
         y04+hvwiW5JKt7SX3cxi2sOuc/z55Km2tjE0DbhhKky55Pv0FMpwIXwNAnKHUiD5zuN9
         OfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750596651; x=1751201451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFFYOfuMXwg0F/A7AmhvhfJNkmAtB4Mz1/92bvCyRBk=;
        b=UvV0VfBGdGT9U7MiKcdK4x7L8rZNVhWAJaSd4JerlgwToTTNNnajNsrhsSW3jt2cuo
         mOqRZD+4HmUt3Cj6+j83Q9Hibl+FItPmBq2jRFyMswR3Y+7cO71ZgB7ZltDSPiv7z6+5
         6RTsK4GQFVlC9pgI/XiZ3lNjII/YWsvu3Ncew36QSJkCojvOmsRRo7vDFMPhnTUHEg8r
         sunP48q/EEjyOwjNVAmHGUs8jqBKoDir7FoH2/9N95280GXxquCyYfwcmmk2AxhPGMwD
         2zH5rTEKvN63jQ0LTgtPPFwbHD/qHjimwle+yFPS25kxn2bHv33Jzb+ofm5S08w29904
         Yxuw==
X-Forwarded-Encrypted: i=1; AJvYcCVY0zELO3Ps/+4sS8gbeOeNQGZvpIHmKrAt3SNdSVl47jbBpS0MHJZT5Y0NPG/8PH8GttS6e7Qx0sE=@vger.kernel.org, AJvYcCWCE84OY7wPXxJ/9zUnReC9X6/wQgP8VnWTqYYHPtQRuGoLtOcmQ9L+CGYJVUeeYKx6d0PPDw+ekeIfWPDJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6dmxMrEtkHg+fj6iWBNPL4w0ogZVWA7YlvOJCCSXmPjflSY6
	hB65OKF8y8+YedW7ESIu1Pmm9GII2r0IeokJBuil865h9sEXqGUr1XsjYAZ9pGwA/xe8GPOT9wA
	3kcby18nQb7H5vNGEXiPt7L1rpNnYfwERgo5Mwd4=
X-Gm-Gg: ASbGncscnQdmtE/unblFglWqd5pkeHY0d8X9evYQgOpwOvgN9F7Z+lUmKt2Y88Caycy
	O/QUvUpOr0PTccnEb+YA8W7C4RUWKmnx6E66NRo3CTbrRBah06iwa5GDCls5MX8nHpLg02KCftw
	Rw+j6OEC7aTTEnN6wrZtr4jH0wO7rBm4K7I5uBby5Q1NllUuQ7HR3OwU/DmBC0BQdCR3eJABmaX
	xsb/g==
X-Google-Smtp-Source: AGHT+IFwf0HPUHHBU01IMCEE71dmUV3d1MMeHEiXJeaMpofTIgfboDAXU4JwM8HiZ4bm1qwIXt1fgafzUGdqkcB2cAU=
X-Received: by 2002:a05:651c:4188:b0:32b:7614:5724 with SMTP id
 38308e7fff4ca-32b98e6657fmr18284801fa.5.1750596650813; Sun, 22 Jun 2025
 05:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622120958.475765-1-pranav.tyagi03@gmail.com> <50a01a17-4afc-415d-b5c8-9a84e3bdf191@zohomail.com>
In-Reply-To: <50a01a17-4afc-415d-b5c8-9a84e3bdf191@zohomail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sun, 22 Jun 2025 18:20:39 +0530
X-Gm-Features: Ac12FXwCBi5-E051VA0FIrOZrmrDAPgUljbzWVvxT9GN5qnb5YEmFQa0Fg00NR8
Message-ID: <CAH4c4jLYSXsWE8aDV0Cue0y0xMoYKbfN_Tkoj8SuAreDidG1dw@mail.gmail.com>
Subject: Re: [PATCH] cxl/memdev: automate cleanup with __free()
To: Li Ming <ming.li@zohomail.com>
Cc: rrichter@amd.com, peterz@infradead.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 5:53=E2=80=AFPM Li Ming <ming.li@zohomail.com> wrot=
e:
>
> On 6/22/2025 8:09 PM, Pranav Tyagi wrote:
> > Use the scope based resource management (defined in linux/cleanup.h) to
> > automate the lifetime control of struct cxl_mbox_transfer_fw. This
> > eliminates explicit kfree() calls and makes the code more robust and
> > maintainable in presence of early returns.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  drivers/cxl/core/memdev.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index f88a13adf7fa..be73a6099cb6 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/idr.h>
> >  #include <linux/pci.h>
> > +#include <linux/cleanup.h>
> >  #include <cxlmem.h>
> >  #include "trace.h"
> >  #include "core.h"
> > @@ -802,11 +803,11 @@ static int cxl_mem_activate_fw(struct cxl_memdev_=
state *mds, int slot)
> >  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
> >  {
> >       struct cxl_mailbox *cxl_mbox =3D &mds->cxlds.cxl_mbox;
> > -     struct cxl_mbox_transfer_fw *transfer;
> >       struct cxl_mbox_cmd mbox_cmd;
> >       int rc;
> >
> > -     transfer =3D kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> > +     struct cxl_mbox_transfer_fw *transfer __free(kfree) =3D
> > +             kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> >       if (!transfer)
> >               return -ENOMEM;
> >
> > @@ -822,7 +823,6 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_=
state *mds)
> >       transfer->action =3D CXL_FW_TRANSFER_ACTION_ABORT;
> >
> >       rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > -     kfree(transfer);
> >       return rc;
> the rc can be removed with your change, can be "return cxl_internal_send_=
cmd(cxl_mbox, &mbox_cmd)".
> >  }
> >
> > @@ -880,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_up=
load *fwl, const u8 *data,
> >       struct cxl_dev_state *cxlds =3D &mds->cxlds;
> >       struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
> >       struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > -     struct cxl_mbox_transfer_fw *transfer;
> > +     struct cxl_mbox_transfer_fw *transfer __free(kfree);
> >       struct cxl_mbox_cmd mbox_cmd;
> >       u32 cur_size, remaining;
> >       size_t size_in;
> > @@ -970,7 +970,6 @@ static enum fw_upload_err cxl_fw_write(struct fw_up=
load *fwl, const u8 *data,
> >       rc =3D FW_UPLOAD_ERR_NONE;
> >
> >  out_free:
> > -     kfree(transfer);
> >       return rc;
> >  }
> >
>
> I believe all "goto out_free" in the function are not needed with your ch=
ange.
>
>
> Ming
>

Hi,

Thanks for the feedback.

You're absolutely right - with __free() handling cleanup, the
explicit rc variable and the goto out_free blocks can now be
eliminated.

I'll send a v2 shortly incorporating these cleanups.

Regards
Pranav Tyagi
