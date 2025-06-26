Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35142EF9A4;
	Thu, 26 Jun 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948346; cv=none; b=BiHcX107Nc6MGqGz+FdIJ0/ZGJ0z9x9qg2W2emFNETVqvWF+8NcqFcVouSWBx7u6wRIiWYAuXfnd9ZNVcKGmApQaReWlSMCAlHOhVgiCuyuJ7frPgBkFMu8utvJ6fSWTuaPKMj1BH/FTdoTxlQn77Zx/Uqz415Svun6EXz2uU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948346; c=relaxed/simple;
	bh=1jC/tGnvYZqIX1z6MW25LhIXH6ubgU5rEfdthqI9T7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/m4rUt2gowkL9stVfgNSSkcfuVNx+MFxyYQcayDHa/IVEUwrH57PgszOka5L+J/BEMzdjYkz9qQguldYRtiVY2SRpzmko11PMDaEWhTIX8sP6V7E029UtB1tvgID0VhWqOnAe1hv/HEY+W1yZNH9XZVU4EVG8Z8Vz9ublxBxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQzYbB+F; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQzYbB+F"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1184028e87.0;
        Thu, 26 Jun 2025 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750948342; x=1751553142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4ep8LpzklDdJ/PRT38YsBKJnMGg/9nUE3qJ238rNuc=;
        b=FQzYbB+FEWv41LK3BZZWc9xBmXjSrBI20FIISTS5xlN4nu+GHu6Pyixf1sLGHR31DT
         73AQj4CqEXq/sxBhNJJMofELAL7y88Y1Tuoj5tVgU8aGkiFBmv6xaekkTKRzd1NYJDBv
         5ancmOy8PReBzVSCJkEXEg4cirEk1KTs/u2s3Z01FqMaysG4+nbvb5+mFxbeninJU1vy
         SsJtSPFNdAMDEvH2Ua6Qcza5T8V0dtWh96bcBXqfrzVEniVf7+u5miyItV93EH0cj6Z1
         q0wQY8t+36XKh0/jRccMwgmjsWTY5okb4ZOt6SJ9sANZ3Zuat4xBrkVTNRkxRkigPbr4
         +8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948342; x=1751553142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4ep8LpzklDdJ/PRT38YsBKJnMGg/9nUE3qJ238rNuc=;
        b=vo5fh6DIkDJSnpulmSQlPNrLT5JIUUlR44K20pxFkmep38w+hp49RxBbstVRESyVS4
         564tv2i9Vk8vpaOOp3avLWt3QSEtuP/HN6zwSu0isslGHwJoo8cBxYPjxPC7emgUrMPi
         0qKYuhNyEhOu6NjBjfSIaY9tvtqo39vxYyhBDyIAwWmG2kANl1H/oZ32fr9GKaaFZJOG
         rvZywNawWxj5z8rmiWBT3GCWO/zKuQ8wRyyLa9Kydunu7bFFZsemBB0zrKs2iPEtAx0Y
         eDdNqhW4wBwM6nogod5qb/wRIQHy9+A4yeSR3ZjiAXkizg9z8ut1tlxilK7SgyfH9tED
         alwg==
X-Forwarded-Encrypted: i=1; AJvYcCWifAWErc4fsBadzqUrWTasM+tlD+g+kOK4FbGUpo6j+vO4OCb19kjSIgLFv0X/9xzK1GoHQCaHzAY+Zwkn@vger.kernel.org, AJvYcCXyJ4P0FNPMQcMAYdhMZZVEheh1kiD+4n3KVTBvg0QXAg07+XAx2P0xbCOCCEBfx+CXP3Nz5rMEteY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SqSm/jg5PUI/MsJQWQXqtRJBnBvhQjftHci/ZSiUNdME03lm
	PhgiPrvGckBv2g9XqfxIabFO8Tzn4IBq9/nvaUxYcT9vokuAPzFRkoRjG3/wHtUuA5EK3+0iF0E
	X+hn1H33xlwfG/olTv/Z5HXR1ROnY31Y=
X-Gm-Gg: ASbGnctnZ7F+u5xP5RMcxIOnosA3RcPPXIPmyAKxXAKBD5rYOX6GiVzr1ri6J7Ttkm0
	e+pFHIj+Oij3HF3cjbdcsCAMjVUs4kQMxoNJgwWOa75rS3AIEraT5q1wO6xmz46p+WdhSMs842X
	3xV+CFsq/zdpthV+oY6nU/vDF4VRfVWJXVBs/u+9C0dRppGvS9wGp5bqL70Q7FdalbpTn7n5BFN
	XhwLg==
X-Google-Smtp-Source: AGHT+IFx4sduEJGCHwL3U+pSB2Tg8LNQZ44ZqhdKUQhPbzhrEtPy2s8ZWPFPfbdHNZSYNd8FSRJALxpHY5AcPjo/atk=
X-Received: by 2002:ac2:568e:0:b0:553:2e0f:96c with SMTP id
 2adb3069b0e04-554fdd0e51fmr2690042e87.23.1750948341966; Thu, 26 Jun 2025
 07:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623083841.364002-1-pranav.tyagi03@gmail.com> <aFrBeCn-j_AB1yzv@rric.localdomain>
In-Reply-To: <aFrBeCn-j_AB1yzv@rric.localdomain>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 26 Jun 2025 20:02:10 +0530
X-Gm-Features: Ac12FXysQiC9JCtpThr23nOptpbU1SVBPAIAYLzmUaBViKaSpsg8hiX7ofi6dBg
Message-ID: <CAH4c4jLAfMTn6wN3wJSOQZ3mAoYC3uhswDu6c+c6v-wv8mSifQ@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/memdev: automate cleanup with __free()
To: Robert Richter <rrichter@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.li@zohomail.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:47=E2=80=AFPM Robert Richter <rrichter@amd.com> w=
rote:
>
> On 23.06.25 14:08:41, Pranav Tyagi wrote:
> > Use the scope based resource management (defined in linux/cleanup.h) to
> > automate the lifetime control of struct cxl_mbox_transfer_fw. This
> > eliminates explicit kfree() calls and makes the code more robust and
> > maintainable in presence of early returns.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  drivers/cxl/core/memdev.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index f88a13adf7fa..38f4449f9740 100644
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
> > @@ -802,11 +803,10 @@ static int cxl_mem_activate_fw(struct cxl_memdev_=
state *mds, int slot)
> >  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
> >  {
> >       struct cxl_mailbox *cxl_mbox =3D &mds->cxlds.cxl_mbox;
> > -     struct cxl_mbox_transfer_fw *transfer;
> >       struct cxl_mbox_cmd mbox_cmd;
> > -     int rc;
> > -
> > -     transfer =3D kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> > +
> > +     struct cxl_mbox_transfer_fw *transfer __free(kfree) =3D
> > +             kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
>
> I don't see a reason for __free() here as there are no early exits.
>
> >       if (!transfer)
> >               return -ENOMEM;
> >
> > @@ -821,9 +821,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_=
state *mds)
> >
> >       transfer->action =3D CXL_FW_TRANSFER_ACTION_ABORT;
> >
> > -     rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > -     kfree(transfer);
> > -     return rc;
> > +     return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> >  }
> >
> >  static void cxl_fw_cleanup(struct fw_upload *fwl)
> > @@ -880,7 +878,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_up=
load *fwl, const u8 *data,
> >       struct cxl_dev_state *cxlds =3D &mds->cxlds;
> >       struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
> >       struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > -     struct cxl_mbox_transfer_fw *transfer;
> > +     struct cxl_mbox_transfer_fw *transfer __free(kfree);
>
> Jonathan already catched this.
>
> >       struct cxl_mbox_cmd mbox_cmd;
> >       u32 cur_size, remaining;
> >       size_t size_in;
> > @@ -949,7 +947,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_up=
load *fwl, const u8 *data,
> >       rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> >       if (rc < 0) {
> >               rc =3D FW_UPLOAD_ERR_RW_ERROR;
> > -             goto out_free;
> > +             return rc;
>
> If you want to remove the goto here, just free transfer right after
> calling cxl_internal_send_cmd(). It is no longer used then.
>
> I only want those cleanup helpers where they are actually useful and
> do not just add complexity.
>
> Thanks,
>
> -Robert
>
> >       }
> >
> >       *written =3D cur_size;
> > @@ -963,14 +961,11 @@ static enum fw_upload_err cxl_fw_write(struct fw_=
upload *fwl, const u8 *data,
> >                       dev_err(&cxlmd->dev, "Error activating firmware: =
%d\n",
> >                               rc);
> >                       rc =3D FW_UPLOAD_ERR_HW_ERROR;
> > -                     goto out_free;
> > +                     return rc;
> >               }
> >       }
> >
> >       rc =3D FW_UPLOAD_ERR_NONE;
> > -
> > -out_free:
> > -     kfree(transfer);
> >       return rc;
> >  }
> >
> > --
> > 2.49.0
> >

Thank you for the feedback. I understand your concerns and completely
agree with your reasoning. Please pardon my misjudgment in sending this
patch. I am still a beginner with kernel development and learning to
better assess what makes a meaningful contribution.

Regards
Pranav Tyagi
