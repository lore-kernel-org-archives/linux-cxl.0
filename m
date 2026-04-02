Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24227E05F
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157095; cv=none; b=F3PmVprIpPsoA2Am0rZCYQbIAATaGALi4OiLcHDv0GeXc37a/XtNBf+kJumh9qocAT4SOxsPLFDCkZSYzXSFgUPRAGsDPBlWtfcm0S5UdGDeVnjlXNLHloFusZAyqrh+hWfXgOEVQ4c0txNg4oI1PS1+88TQazz6u0zOdB7vinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157095; c=relaxed/simple;
	bh=f+h2yUsFit12YciS6wY2v/+8838UL2mnZ6sTVBxMrxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnXPB8rOpQoNdgf4Ch7X6IERkTpT21U1B9h1mTZa8xgISirj2n9qxryexPX/AOetLX+gAi+TJ7EYPngRgCqpKlP1V0qbpZUkzGFt2CNEE1shZIPahJApyrJFXOiz2wiCPKmITx3ypAdMCn6hFxwIbGjvVrQm4xeGYmawrr3sytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so150196666b.1
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157092; x=1775761892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vC+4JT/dS3pyqGtdgqedDXsk1rZAjWwGNyMyIzaHiMU=;
        b=TaLoFTJmidZIJZFN/pzQwZ+4KkqDmcLSbO4+xkPmw5BSS3ion+yTsI2rx/LV31Z7of
         kpPVB1/yLAdynJNrshM9MVSNmRGFm6hujTeCc0g7H0k3pkckW4QiyhdGb0UuD9HmeVIe
         r2uMwzTYscTaFLU6TmSczu8G7FpcIlissFYB2/yp+cCXr2UbdGZ1iG88xK5dN2pN04FW
         ZOsOR8L4p+JA4u5kyyLKxftyAzA/pXSpUMqpNv2Sxcb+2cFmk0/dVv1dw8D5xui4DlXs
         cSU4IrtOnqMY/lyX7EVYIgaUjHf9z8YKBAVVzuu/FbfOopkM/HUvJRiaHr7N2lHiKWGh
         +Agg==
X-Forwarded-Encrypted: i=1; AJvYcCVsLEj4cTBtShA3eesSmYSycci4uXS6HItsiYLc0xOSW20d4V+lt2Jz9AsIIBdwiuN4G0y/8tTZTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ8RFXMnrgqC+Oi9feLK+nj+jP/3hxPH1P9tmaIJ1ssScn4mM
	YvOTellWHRNEB4NKdj471S/FPl+UMhsaTp66NiRPsXG0t7UavIPeN0m7PVBeAz2RQPQNlA==
X-Gm-Gg: ATEYQzxsi8fTqa+CrWmHME+DqFdzM7p2h8EV1kCuWxdnjAuz3kmkoVgt4fm7INKK6Ae
	oTsn3l7e5SP+h+ZYuQJDhy0ScmTzNqrNj3i0LDeBnaPFhI370oLrvd4kfiCGcuYZYxu4gKP4Fq+
	qBPJX9FnIil88KG9QHT6ig2c8ZD+r1i1w6v5MfzsVow+/Mw88KlhYyXZJx32elL6zKs1tMviSn3
	mZ8Da9zQoM5a7IHZoDp32qmPNS6SaFY31DbVweKjKrjeB9sewr//ljV8MDlUV30dfYBc1/sJ7pk
	q6daZObIqWASgs96JltHjXc2XWFEoq7ElcfzzZEHwiyK9AzvjsuzNfcDh5/bPAk4rHEc931RVuA
	jpq1GWdgh+En0Oih+e8B1Fgv7zf4okMWvpbsdmVjekrFvNuYq7478WBhKTdIhfD6otm81YHz44e
	4Hx1m14WMHjUSn0EGlvwsL+CBQvCT9+TiPHLSlxvT2wFNzHU9t88OanKI=
X-Received: by 2002:a17:906:9fd0:b0:b93:6ae4:aa83 with SMTP id a640c23a62f3a-b9c675492d0mr5998966b.18.1775157092181;
        Thu, 02 Apr 2026 12:11:32 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff1298sm122422066b.54.2026.04.02.12.11.31
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 12:11:31 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so11746515e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 12:11:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa0pnrH0AXzo26nIDjElcBpimJZ6mYSvdhiS54kAM8Q/jg2k/ExzViradkZrqLvnKLRekBVM6SG4M=@vger.kernel.org
X-Received: by 2002:a05:600c:1f96:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488996e142bmr3222645e9.6.1775157091421; Thu, 02 Apr 2026
 12:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308185958.2453707-2-iam@sung-woo.kim> <69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch>
 <CAJNyHpJ41rHOEu+JQZPTBx9ETof9avCBKqStC4zUU_FDz-sf9g@mail.gmail.com> <69cc961ef12e8_17890410036@dwillia2-mobl4.notmuch>
In-Reply-To: <69cc961ef12e8_17890410036@dwillia2-mobl4.notmuch>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 3 Apr 2026 04:11:15 +0900
X-Gmail-Original-Message-ID: <CAJNyHpLGv2TJWHs1vN5exenzQRFbGHKtD8RDX+sdQqBzAvStog@mail.gmail.com>
X-Gm-Features: AQROBzDcZToAH71-geyLsthyMb6lU0rLwoNY0OgVR4fTMxdDTFqBbzasoaWq50c
Message-ID: <CAJNyHpLGv2TJWHs1vN5exenzQRFbGHKtD8RDX+sdQqBzAvStog@mail.gmail.com>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, daveti@purdue.edu, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:51=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Sungwoo Kim wrote:
> > On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Dan Williams <dan.j.williams@in=
tel.com> wrote:
> > >
> > > Sungwoo Kim wrote:
> > > > Fix this by replacing devm_release_action() with devm_remove_action=
_nowarn()
> > > > followed by a manual call to unregister_region(). devm_remove_actio=
n_nowarn()
> > > > removes the devres tracking entry and returns an error code.
> > >
> > > No, that is not an acceptable or comprehensive fix. A subsystem shoul=
d
> > > never try to double unregister a device. Keep in mind the decoder sys=
fs
> > > stays alive while the devres_release_all() actions are running for
> > > port->uport_dev.  As a result, yes, Davidlohr is right. You can
> > > theoretically observe the unregister_region() release action firing
> > > while delete_region_store() is running.
> >
> > I appreciate your review and suggestion of a new patch. It seems more
> > complicated than I expected!
>
> Yes, the CXL subsystem is unfortunately... complicated.
>
> > I'm new to CXL and device drivers, so I would like to confirm that my
> > understanding is correct.
> > - CXL tolpology could be: [upstream] host -> switch(s) -> endpoints(s)
> > [downstream].
> > - The host can configure a unique address range (=3D region) to access
> > each device.
> > - The bug happened because releasing the same regions can race.
> > - Although the prior patch handled this, it's insufficient because it
> > can also race with releasing the device (what Davidlohr had reported).
>
> The patch was technically correct but it relies on a design that
> requires depending on a double free semantic. Apparently Rust needs it
> to enforce a higher level semantic, but in C we need to handle that
> semantic directly.
>
> > > The only comprehensive fix I currently see to that problem is to inde=
ed
> > > get it back synchronized under the device lock. This prevents multipl=
e
> > > requesters from colliding, and from devres_release_all() deleting an
> > > action that delete_region_store() already committed to handling.
> > >
> > > This looks something like schedule the devres action to be released i=
n
> > > workqueue under guard(device)(&port->udev).
> >
> > I assume you meant guard(device)(port->uport_dev).
>
> Correct. When I say "something like" it almost always means "be careful
> what I am about to say is full of bugs" so, good catch.
>
> > > It is ugly, but it may be the case that this wants to synchronously
> > > delete the region, and asynchronously cleanup the release action.
> > >
> > > I.e. unregister_region() grows a new:
> > >
> > >         if (!test_and_set_bit(CXL_REGION_F_DELETE, ...)
> > >
> > > ...flag to enforce only one path successfully deletes.
> > > delete_region_store() calls unregister_region() directly. Then the
> >
> > To fix this, you suggested:
> > - Add a flag to make unregister_region() idempotent.
> > - Make delete_region_store() call unregister_region() directly.
> >
> > Now unregister_region() is race-free. But we need to release an action.
> >
> > > workqueue's job is to trigger the release action under the lock only =
if
> > > port->uport_dev is still driver-attached by the time the workqueue ru=
ns.
> > >
> >
> > What I'm missing is this part.
> > How could asynchronous cleanup solve the race? In the worst case, the
> > workqueue could start immediately after we schedule it. In this case,
> > it's the same as the synchronous execution.
>
> Asynchronous cleanup gets us into a context where we are safe to acquire
> locks. delete_region_store can not hold guard(device)(port->uport_dev).
> You can try it to see the full lockdep splat. It is setup by fact that
> unregistering the root decoders is performed under that lock.
> Unregistering root decoder flushes userspace out of sysfs attribute
> handlers. If those are holding the lock themselves it is an ABBA
> deadlock.

I really appreciate your detailed comments. I understood that the
async work can safely wait for and attain the lock.
The lock is required to ensure that port->uport_dev is still driver-attache=
d.
The previous patch was working but it was over-tailored for preventing
double-free.
So, using the workqueue, we can perform devm_release_action() without
losing a certain abstraction level (no over-tailoring).

>
> I circled back to this because the CXL accelerator patches also have a
> reason to autocleanup regions so this would be another source of
> cxl_region deletion to rendezvous.

Okay. other CXL types could be another reason for not depending on the
double-free semantics.
I'll add a workqueue for devm_release_action() in V3.

Thank you again,
Sungwoo.
