Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08F2D780E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410455; cv=none; b=NP0irzf6D3XYVxbLzc+c6LU+fcwEIpUoEAIE2tuZJR/s2aljCEYWfYmw/AoXhOFJnsKZ6TX9SDWelntwuLEmTHTAeH5Gq7LXZBZ29MUbr1fDk9eUQwO3OfYhykSbKgxEsa5XZAFO/qmQ1W3luLL3Qc1LoWu/Jx/8oKVPumGbeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410455; c=relaxed/simple;
	bh=aX1QeEJeBKbjxo/xhTd9n39mMYTPrnV0cS0hvKBPmOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhIXv00ZcE+dPda6LBLX/6rIG6adwDaahqc8Jh+VEMqIOVZZztSzqzbeLTqN9uT5k2n2jNTeCZi1JwuaBOhj6t/QAzAGFOUidT/WgQMtH2sGxzZOJtkrIMwh5fT/st1TTQb6WBJXV99DZnsWCppPyMqqKYC0du3Fn7YBHrkhKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b941762394aso795354766b.1
        for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 20:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774410451; x=1775015251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iDkth+tKdu52b6B9v0RecpJBQbzK3CBu3cxApoZPG0=;
        b=BfM1DiZMdKYpfKn+gxI2ZifU/p8c4eHuU0eoE7eeFLr/XvWEtCsDNrM+b8jgz3Me4e
         NI/HX8TQADMu5zoFp59H4GX4AJZKQv0+7grFVoRbgg74Ge132ptZeBNkRmHKCHbQksU8
         5uoe1Pb1dmF5FC6w3nF8QXlUKW3HfWf4L1nAP21IITZA5ks7SCoQP3I4l4LQe3lTa0eT
         fji7taKhZ01c9W7no+SC2ivP5MmkgUf0/jyppUCy6OQj7OKnjdvZ29DGcRqozyOLpHjU
         3/cAnNJwvcmURKeEe0ry/rDXzijiaTNCaY+QQJlMkj+YcbBRJQfbRKUhruulEuNjzwJf
         8caA==
X-Forwarded-Encrypted: i=1; AJvYcCVCWFl6+z8iyOJvOePBQhnOuu66TC45Rb+1uofu+rw9Uzpz8cOUzrkEdl2ruhCDb5Adj4m2lvpofmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaK4qoIu/Knn9gXcqcej0Qrk4flno8GzK3xAnxEPONLBZyOBDY
	IbkcBBO92D9bdzbyz2ojJS9nTP7q46OAyV4JtJ/yhJzZMsKl1kZiHC2Ex0T2Fhea41I=
X-Gm-Gg: ATEYQzzyBx1gNqdPmQSrZuynmVcTqYRFlbH2/L+YQrjGLajdE1cp/8p4Bufsq5uawZG
	R65l87YMcnC73ch1nUytfiprjNwdA4XVPevXsbmwSkMSmKNZQIfx0IZuHBWHUGNXBJ8ecvlBdqq
	QMavd1UhrLou4ztmKHIb2klzU0fN/Vf0h13wuoEpviO7i+JvROgF5V1GYpztuNuP5gEmmZnGMpI
	GnDb9DR46faY/dJV+WFHjfWa3UU7jfUbkZiU6kNk/985Au5zNtce7a65XrjK7Qwe2ia/BZWonTa
	/vIDLl7kZcTYAP4Wbal6N2e5zw6QfTOji5Ld3PIrokNa1Z3zQFz3i/tM1SA70CfI6RX7+b2E5ge
	A1cYSD0E6hc8CDDHDgJS4cDl6866XO86+hNxzz2ERRfsclVhKlhF3X4kmgBzx2xJUG9wv1UYRsI
	Q8drhrPVo3KTgUTf/nfqybEZSgF15QymBQ/uhvutSmx/8u/DQqGTuqXC+o8EPbHwSUXw==
X-Received: by 2002:a17:907:e113:b0:b8f:9bea:ad6 with SMTP id a640c23a62f3a-b9a3f17f147mr79310966b.18.1774410450952;
        Tue, 24 Mar 2026 20:47:30 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43c3bsm738879866b.2.2026.03.24.20.47.30
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 20:47:30 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48704db565eso37276415e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 20:47:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGsoVK4eSSV6gW4gZsAqW80imdo+ofNz7RsOIyN663m/jaChv6etsktB0nsJ2VKn9s3eyeUfeIgG0=@vger.kernel.org
X-Received: by 2002:a05:6000:2892:b0:439:b59e:5e65 with SMTP id
 ffacd0b85a97d-43b8896cedbmr2386628f8f.6.1774410450091; Tue, 24 Mar 2026
 20:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309000810.2632065-2-iam@sung-woo.kim> <69c33bbeae7e5_5162110077@dwillia2-mobl4.notmuch>
In-Reply-To: <69c33bbeae7e5_5162110077@dwillia2-mobl4.notmuch>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 24 Mar 2026 23:47:13 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLJvPBYyaAeWzF18mdAu5Xe=HFDCRizogntsLheivgF5Q@mail.gmail.com>
X-Gm-Features: AQROBzAObaGaiC6tLWS1k03DJiuxU5dEx40ekprVoP7C5ef-grjwmcanw5eImPM
Message-ID: <CAJNyHpLJvPBYyaAeWzF18mdAu5Xe=HFDCRizogntsLheivgF5Q@mail.gmail.com>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:35=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Sungwoo Kim wrote:
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
> Good find!
>
> However I am not a fan of the fact that this duplicates this subtle
> dance in multiple places. It looks like we can just make it by the case
> that __cxl_dpa_reserve() establishes the remove action before returning.

This also makes sense to me. Then, we need to change __cxl_dpa_alloc()
in the same way. Will do in V2.

Other than those two, I can find other functions that likely have the
same bug, such as devm_cxl_add_dax_region(), which might race with
cxl_dax_region_release(). To confirm, I'll try to trigger bugs in
these suspicious functions and see if they are indeed buggy.

>
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
>
> Also, I agree with Alison, this is good detail, but way too much detail
> to carry around permanently in the source directly.
>

I will shrink it down. Thanks for the comments.

Sungwoo.
