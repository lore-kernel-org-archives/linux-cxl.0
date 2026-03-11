Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DF2DF153
	for <linux-cxl@vger.kernel.org>; Wed, 11 Mar 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212150; cv=none; b=aiFp+HN2YoG9tHK4z2Exii5yZu/O01fINZ+4v43RS/inZTUFy+tgyo0BPnU8vfmbnJ0OHdavMNucdCC1J+zfhFHtMC3EqNkjZhGWY5p3sjMBsfDGg+/JHSmrR4OT8Zl2oSi3R9RKFNBxnEXoDEneUf/li7VaHYD6vjmRpD2uEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212150; c=relaxed/simple;
	bh=/muMKl689VQdgInOnZQpCii5SHPdxchLssMea7AsKpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeJTmPeZ73LvjPtpAixLLNy1RRmGkXBD2ppi05msymsN+z2aGC70S4N+1J4aSGIpFrRfxD+yD4ugLTcQsFWC0JU9N1x8sknqBE8TIZMQsksd9MwMKmTG5nPX4kgWme8q/BCeyC4VbECcS8wrKVfYeQflWYRyGQ4eJhNT/kXDZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b95c0fc928bso714272866b.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 23:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773212147; x=1773816947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiUpbOqkS9uksmn/N5qC8GErk+ixVsmmsHn3JaJbo7k=;
        b=YRXGKwY46UYDjDr9dSmGmhBMl8fi0YUn1HEJbgfh5mdlYaFx8ZDNQ26lF3TjFH8qB5
         KkMtz9hIXBah6OrNCjZnc6M/AikDd0D7vMhkMHyO7RCE/fpSs7pKJgWQYE/XFv2xQYjn
         XoRJ/GqRGp0MDWRjyMHd+VCpGz0vIy9K1h+ODnTloFkEPA4oAQjQVRk5Q4/4hUts51zT
         d3NIqOL5RHHjlPG+TtRqOX5nzmLTHmgxPJ2PxCtLQKZNshfspI6qX1xvRMiAu+0Qpd6S
         f5SKSCFaRQNF2G7+k5U3fpkckjk5uG78HbL7/7SiYsVSxVyY9C1pu3sLkxq6w1lbTGUS
         9nMA==
X-Forwarded-Encrypted: i=1; AJvYcCW/yMwfcmGx5CpTYnK+iC8ezHvlhHuVHcow0fKMMM3feIVjXV6R9i/Abn2RGD1pGXWSfeXX5tJ5gHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EDtYnhNIU3IidpBBZaW5JMzDhRoGPmMud+zvk2uZ4F2OSat6
	JewDjeFwUeTzmZhqAB9Vjbke2YGYYK7GvxF+CeHwAvfXcgemPjHT5To6+fRWdK09sJG2lQ==
X-Gm-Gg: ATEYQzxOFJI5/6GMsCqZx8av0BE4VGEXi7hdphwAso9AKXhxvKMqFJm9//uSPEvRvP3
	DUEPYDNNo+0BTBLOT1rIRdwIctnENjBQhceZFEUtaW+zHkAGKalUSpiFGwZ0ImKODdr0wWFv4bR
	Nt/gFNeIV41ey+4OTW3fzOKVli1JVPVDx7dKs7Oti7kF80+U6RO1643RbpThyKm96vA6v+U8Y2Q
	cbPLqjW7675YgMTrthBIlu4lR2cpS8+sxsKOgZ8hTm4JDkZhyApOBekRtHdt1GWBgMRxpWACO/I
	Wb5uFp6v4nnGENvLMqYE2HMlZJ58HB+WuFwA8+PshU2yxFPwccSKNQxp8jJOFU99+kKcf+wigyn
	iHtP300vc5axGh58HI8e9AB2L6Ly/7WCgI2Wtfouwy2pxMqV7uNP6YqH5i+j2tzIHYJDpc9ckiA
	2Oypa6xxjVJgIKS1nxJxjxCmL8be86oIJjI9qLz2ZnuOZGAPCREJrtNpo=
X-Received: by 2002:a17:907:3d86:b0:b93:55ab:1d36 with SMTP id a640c23a62f3a-b972e5e5f73mr70056266b.43.1773212146683;
        Tue, 10 Mar 2026 23:55:46 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9736e2ca31sm3445666b.37.2026.03.10.23.55.46
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 23:55:46 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439f59dfda2so971066f8f.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 23:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/RnuCIBamAx7s6abVV7e68bMwiyAdU/ZDr67eD0zVjMmhIXzHHOpm14ENst+GV1VB3LxZYMW6LmE=@vger.kernel.org
X-Received: by 2002:a05:6000:1acf:b0:439:af96:29d8 with SMTP id
 ffacd0b85a97d-439f8430d59mr2559352f8f.33.1773212145752; Tue, 10 Mar 2026
 23:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308185958.2453707-2-iam@sung-woo.kim> <69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch>
In-Reply-To: <69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 11 Mar 2026 02:55:28 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJ41rHOEu+JQZPTBx9ETof9avCBKqStC4zUU_FDz-sf9g@mail.gmail.com>
X-Gm-Features: AaiRm511luEaaPDh0t9RPwD-iLJ6Z19emC9mCOBpQ43WuJ20ukSx3hmPquc9msI
Message-ID: <CAJNyHpJ41rHOEu+JQZPTBx9ETof9avCBKqStC4zUU_FDz-sf9g@mail.gmail.com>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, daveti@purdue.edu, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Sungwoo Kim wrote:
> > Fix this by replacing devm_release_action() with devm_remove_action_now=
arn()
> > followed by a manual call to unregister_region(). devm_remove_action_no=
warn()
> > removes the devres tracking entry and returns an error code.
>
> No, that is not an acceptable or comprehensive fix. A subsystem should
> never try to double unregister a device. Keep in mind the decoder sysfs
> stays alive while the devres_release_all() actions are running for
> port->uport_dev.  As a result, yes, Davidlohr is right. You can
> theoretically observe the unregister_region() release action firing
> while delete_region_store() is running.

I appreciate your review and suggestion of a new patch. It seems more
complicated than I expected!

I'm new to CXL and device drivers, so I would like to confirm that my
understanding is correct.
- CXL tolpology could be: [upstream] host -> switch(s) -> endpoints(s)
[downstream].
- The host can configure a unique address range (=3D region) to access
each device.
- The bug happened because releasing the same regions can race.
- Although the prior patch handled this, it's insufficient because it
can also race with releasing the device (what Davidlohr had reported).

>
> The only comprehensive fix I currently see to that problem is to indeed
> get it back synchronized under the device lock. This prevents multiple
> requesters from colliding, and from devres_release_all() deleting an
> action that delete_region_store() already committed to handling.
>
> This looks something like schedule the devres action to be released in
> workqueue under guard(device)(&port->udev).

I assume you meant guard(device)(port->uport_dev).

>
> It is ugly, but it may be the case that this wants to synchronously
> delete the region, and asynchronously cleanup the release action.
>
> I.e. unregister_region() grows a new:
>
>         if (!test_and_set_bit(CXL_REGION_F_DELETE, ...)
>
> ...flag to enforce only one path successfully deletes.
> delete_region_store() calls unregister_region() directly. Then the

To fix this, you suggested:
- Add a flag to make unregister_region() idempotent.
- Make delete_region_store() call unregister_region() directly.

Now unregister_region() is race-free. But we need to release an action.

> workqueue's job is to trigger the release action under the lock only if
> port->uport_dev is still driver-attached by the time the workqueue runs.
>

What I'm missing is this part.
How could asynchronous cleanup solve the race? In the worst case, the
workqueue could start immediately after we schedule it. In this case,
it's the same as the synchronous execution.
Or do we have other reasons to make it asynchronous?

> In the meantime the workqueue needs to hold a reference on the region
> device until it can observe the state of CXL_REGION_F_DELETE under the
> device lock.

If it's the same for synchronous execution, we might execute this
directly in unregister_region(), holding
guard(device)(port->uport_dev).

>
> Otherwise I suspect if you put a device_lock() in delete_region_store()
> it will deadlock.
>
> > ------------[ cut here ]------------
> > WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/=
devres.c:824 [inline], CPU#0: syz.1.12224/47589
> > WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 d=
rivers/base/devres.c:817, CPU#0: syz.1.12224/47589
>
> For the next posting, these 2 lines are sufficient, no need for all the
> extra detail of a full backtrace.
>

Copy that.

Thanks again for your detailed reviews.
Sungwoo.
