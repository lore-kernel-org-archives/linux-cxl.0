Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA713A3801
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325213; cv=none; b=ZIwRbSEJaH+7LEpo/L1l+Tb3zQYgqp9vVqvnWPK75VKv5xO672SlcKtODtFQD0X5Upzm81I40xY1bLO6tTvnaTmlKkEiL/2Qpws+EJa+cCDfJXvvVgccbhJJBdbfFcizTHQn2u2Sb4OA16u/LnrjjbgX10VY/ExwDsGNkOvTzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325213; c=relaxed/simple;
	bh=1dSI8uPgrOCxTI9OYz4NnxsIAB9AVvMoJAgxM+7icCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwrrVBBMGfYvUhZhPs0T5Se3wDfcZ8pm6p4DQMSNdz2ho8DNRZ6jjMF/eFCPqDU/DCXzPBr1B8pwpj/l8R1dg2SG9N1+Oh6ZAay/37Bu14PiRfADvvjyQ8+l28e1zAzgcEr9XY1Geu0v/Re8LyIdHxgpUMjHTG213K31QCAGFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6694c9c02c5so3711669a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 21:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325210; x=1774930010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKhP91x60A4htrnyv/lYS4eAgaoQcHw+SQIsdql0cwA=;
        b=TaIvo/2qRNDDYaEfg8cX9FB+UpKuGeFHj3NupDPsikCGz34RSJxoyBi1trykfbQksT
         TbROzgNuxuvHHKUQEUwx5XcM27qVxAwzYxyI6LYfGltPsDYzaJeHOL1RMHWQOjndbAbx
         gApS6jyzhVE/fAdKzKuhWWbWHzPEps6fBuwk8gBTwlR6HqQilTW/IOzt89JdBqT8wsl8
         e6UOicML8XeAfoibDxefA0SU04IVp6l5G7gGy5o5UEKxJUSgcL5yS4UHymb25H/QM32g
         RyGIn7KOvu0zqgXX+0mBh863KO1INtVV0y+YBZKVULx1bv776sZN+4rURXg90dfx2Cjv
         BuLA==
X-Forwarded-Encrypted: i=1; AJvYcCUvjr+m2bJVS/l8BzbcaqZje+l4c69CaFk2iUsUCcHtsDsqxu9xyKzXywtJND4xKkGEJPw9fJXuF+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRH4zUc2h26EJxGCQH0vkUJcoSYhDYgbV5xTNqcYKb808Kv8I
	CtQ0kfYkQRgX2FoVkhopgZVIsUfhIE8iUaURRv/65yKAvzHwyu6wURqEDuVlHNFmWYk=
X-Gm-Gg: ATEYQzxRioyIx9oM16COyjvhHebC7gspVVyx5EoF/HONP0OblcV0ooc/UE+W2QwLG+Y
	5HbiM7c/OBfjtKmh7B4vYOUvFqIER6Gmhk5dBfmpgv7Q1evSFbS4939+IiRcsEbX0CzG0KZ1V+2
	xW/+6XZb4ud7dC+NCs4SGI3GnaljWzPkymfJLT/UvmVHllVeg0w77Z9l6X0aWlwoaL/Fdw+l5HJ
	fyXwRJenCpMmKCi7VG6P09hyUl0AZZB0ZHjhrKdeZERNUW1rFQWF0zIJIb/9Bula60+PWY97juH
	IwNDturBc5KwKY+tmRpcWnRWCPVye6/S6yABS4zg5i4SSMNquBEmm/GInmIAZmU9tPz8ywaDkNd
	0lW7qAC/4lrBhRGc8211Oh597+4LDom1nTKN14RMwmIgCs5Si+VVOD11DEMayAQo+MXERWptSh5
	7fYy+QGY9fHSUMmn1w3d08OcdzgIlyeHIY6E5ACrbaIYm+uepzJfvfXVM=
X-Received: by 2002:a17:906:33d0:b0:b97:a03c:6f4d with SMTP id a640c23a62f3a-b982f3dbe68mr813236066b.56.1774325209488;
        Mon, 23 Mar 2026 21:06:49 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43b5csm588421966b.1.2026.03.23.21.06.49
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 21:06:49 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3581330f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 21:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTbDzlZWZKkwkuR79wHqqMJAtxHeOkg7frS3JiU0AGjf3exriCK2nvCeGFadKxlyHFnCWMEOInYpg=@vger.kernel.org
X-Received: by 2002:a5d:5f54:0:b0:43b:3d4f:e17a with SMTP id
 ffacd0b85a97d-43b6426d59emr23577137f8f.37.1774325208783; Mon, 23 Mar 2026
 21:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309000810.2632065-2-iam@sung-woo.kim> <68ed44be-9b21-47b7-a833-284aa471fb9b@intel.com>
In-Reply-To: <68ed44be-9b21-47b7-a833-284aa471fb9b@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 24 Mar 2026 00:06:32 -0400
X-Gmail-Original-Message-ID: <CAJNyHpK2fxDL7JxfBYGehBT_RP5r5KETsyAB7a+WK1RK-0pxMg@mail.gmail.com>
X-Gm-Features: AQROBzB8MG1jKaSGNOhXUAz7SG2VG1k0sdIDdFQBtybpKPggsqkOG2P4sJL-m6M
Message-ID: <CAJNyHpK2fxDL7JxfBYGehBT_RP5r5KETsyAB7a+WK1RK-0pxMg@mail.gmail.com>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to gently follow up on this patch.
Are there any concerns or issues about the patch that I should address
before it can be merged?

Best,
Sungwoo.

On Mon, Mar 9, 2026 at 4:21=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
>
>
> On 3/8/26 5:08 PM, Sungwoo Kim wrote:
> > In the following race scenario, devm_remove_action() can be called
> > before devm_add_action(), triggering a warning because there is no
> > action to remove.
> >
> > To fix this, extend a critical section to embrace both
> > __cxl_dpa_reserve() and devm_add_action().
> >
> > task 1:
> > cxl_dpa_alloc()
> >   __cxl_dpa_reserve()    ...(1)
> >   devm_add_action()      ...(4)
> >
> > task 2:
> > cxl_dpa_free()
> >   guard()
> >   if (!cxled->dpa_res)   ...(2) pass, due to (1)
> >     return 0;
> >   devm_cxl_dpa_release()
> >     devm_remove_action()  ...(3) warning, no action is added yet
> >
> > Warning log:
> >
> > WARNING: ./include/linux/device/devres.h:160 at devm_remove_action incl=
ude/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> > WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release dr=
ivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> > WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x32=
0 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 25993 Comm: syz.1.6464 Not tainted 6.19.0-g15a37b05f=
387 #10 PREEMPT(lazy)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-g=
b52ca86e094d-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:devm_remove_action include/linux/device/devres.h:160 [inline]
> > RIP: 0010:devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline]
> > RIP: 0010:cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572
> > Code: 01 31 ff 41 89 c4 89 c6 e8 a9 91 1d fe 45 85 e4 0f 85 55 ff ff ff=
 e8 4b 96 1d fe 90 0f 0b 90 e9 47 ff ff ff e8 3d 96 1d fe 90 <0f> 0b 90 e9 =
63 ff ff ff bb f0 ff ff ff e9 68 ff ff ff 48 c7 c7 f4
> > RSP: 0018:ffff888129f77bb8 EFLAGS: 00010282
> > RAX: 00000000000000f3 RBX: ffff888102f64000 RCX: ffffffff837301d3
> > RDX: 0000000000080000 RSI: ffffc90001c5a000 RDI: 0000000000000005
> > RBP: 00000000fffffffe R08: 0000000000000001 R09: ffff888123f98000
> > R10: 00000000fffffffe R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff888102f64040 R14: dffffc0000000000 R15: ffff888102f64000
> > FS:  00007fae0488d6c0(0000) GS:ffff88827086d000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000012f7d6003 CR4: 0000000000770ef0
> > PKRU: 80000000
> > Call Trace:
> >  <TASK>
> >  dpa_size_store+0xfb/0x230 drivers/cxl/core/port.c:269
> >  dev_attr_store+0x58/0x80 drivers/base/core.c:2437
> >  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
> >  kernfs_fop_write_iter+0x3d6/0x5d0 fs/kernfs/file.c:352
> >  new_sync_write fs/read_write.c:595 [inline]
> >  vfs_write+0x68e/0x1050 fs/read_write.c:688
> >  ksys_write+0x12a/0x250 fs/read_write.c:740
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fae0399c669
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fae0488d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00007fae03c15fa0 RCX: 00007fae0399c669
> > RDX: 000000000000000a RSI: 00002000000001c0 RDI: 0000000000000009
> > RBP: 00007fae03a32c71 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fae03c16038 R14: 00007fae03c15fa0 R15: 00007ffe53519fb8
> >  </TASK>
> > irq event stamp: 1021
> > hardirqs last  enabled at (1029): [<ffffffffb7d04c4b>] __up_console_sem=
+0x7b/0x90 kernel/printk/printk.c:347
> > hardirqs last disabled at (1038): [<ffffffffb7d04c30>] __up_console_sem=
+0x60/0x90 kernel/printk/printk.c:345
> > softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __do_softirq ker=
nel/softirq.c:656 [inline]
> > softirqs last  enabled at (1016): [<ffffffffb7b73b93>] invoke_softirq k=
ernel/softirq.c:496 [inline]
> > softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __irq_exit_rcu+0=
xb3/0xe0 kernel/softirq.c:723
> > softirqs last disabled at (1005): [<ffffffffb7b73b93>] __do_softirq ker=
nel/softirq.c:656 [inline]
> > softirqs last disabled at (1005): [<ffffffffb7b73b93>] invoke_softirq k=
ernel/softirq.c:496 [inline]
> > softirqs last disabled at (1005): [<ffffffffb7b73b93>] __irq_exit_rcu+0=
xb3/0xe0 kernel/softirq.c:723
> >
> > Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an end=
point decoder")
> > Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>
> > ---
> >  drivers/cxl/core/hdm.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index e3f0c39e68124..86239b1790a31 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -509,13 +509,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_deco=
der *cxled,
> >       struct cxl_port *port =3D cxled_to_port(cxled);
> >       int rc;
> >
> > -     scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> > -             rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> >
> >       if (rc)
> >               return rc;
> >
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     /* See comments in cxl_dpa_alloc()*/
> > +     rc =3D devm_add_action(&port->dev, cxl_dpa_release, cxled);
> > +     if (rc) {
> > +             __cxl_dpa_release(cxled);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
> >
> > @@ -613,7 +620,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_deco=
der *cxled, u64 size)
> >       struct resource *p, *last;
> >       int part;
> >
> > -     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     lockdep_assert_held_write(&cxl_rwsem.dpa);
> >       if (cxled->cxld.region) {
> >               dev_dbg(dev, "decoder attached to %s\n",
> >                       dev_name(&cxled->cxld.region->dev));
> > @@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cx=
led, u64 size)
> >       struct cxl_port *port =3D cxled_to_port(cxled);
> >       int rc;
> >
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> >       rc =3D __cxl_dpa_alloc(cxled, size);
> >       if (rc)
> >               return rc;
> >
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     /*
> > +      * Add the devres action while still holding cxl_rwsem.dpa to pre=
vent
> > +      * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa=
_free()
> > +      * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
> > +      * devm_remove_action() before devm_add_action() has been called,
> > +      * triggering a WARN_ON in devm_remove_action().
> > +      * Also, devm_add_action_or_reset() cannot be used here because
> > +      * cxl_dpa_release() tries to hold the dpa lock that is already h=
eld,
> > +      * causing a self deadlock.
> > +      */
> > +     rc =3D devm_add_action(&port->dev, cxl_dpa_release, cxled);
> > +     if (rc) {
> > +             __cxl_dpa_release(cxled);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> >  }
> >
> >  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>
>
