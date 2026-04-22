Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F180370D67
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886875; cv=none; b=SfQoucuFvF7U8hMKw3MKvKiVbIrYSk03faP6meFymqS4tAtNkbH3//dJkuXzMnLZgXYLPVJBvRYiVGHt7aeZVSAYYK8AjCUtGWPtnltOGk4WuxXOTx1qQpEB9DtLb4hjNzL31spp8WVRKKBXbFPggj0ModAUO/YREaSgOsQ+AIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886875; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loTu4AGbV9FL+t/3fYr60MfSgDxlfGHV3bdjs5J+MI1gPjf7haD6WaI2OJV8IZEkjOzjJ4CcqWrh8xQdA2CYuC8/bJjyWlODGrdjKInXnfLIuJWLzVeexcxAexrapbCDDG2aWiX8EN9Snt1RSv2UxWhcxgFSa0CLxWCgYIrMX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eb1+x0rx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eb1+x0rx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso762299666b.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886870; x=1777491670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=eb1+x0rx/l2XfCKgA70ByALFlS+oJTMeqGyRFNCVs810WygVhfQFIQPRmvN979OUD2
         Ze40Qn2NbXeOgEfdGYhrVCdFVFiYDmcA9DJnQ4zyoBirOJNlnAtBBdwh5uljsizGDCSm
         sYDoV2OpVfEdpnrizh3hbHHHwFOCnJI3JEfQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886870; x=1777491670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=dAffzs8Jt3AIW3CXH0ZHFAIJp0sh5UM02NbpW2eSwWIp6PE9VRNbr0lXRRQz1kwH5l
         bd4cEvRvL+atdhOxl3jE5462SkMsaQ1dDd5NsqmdDo8hotjbYq68PgNxnA6FNMprKpDa
         dMktFEj2w6JVZ+krfDii7dLm/eaDlNKzew1kXtyiojQKrk8xXGjZ0+ikRTW7KUhXK2WK
         sA+ekFjyg/5A/1BcIC0C54jTSRt+luzt4LxtSo/mJqNvKL9WI5ElLENrtqLNYv9zergy
         4nI9xFy6Gxr36xyZ73EDlPs7vebtj4dxshVnt5ssocAbFqNdS/Q2Cq0mNJ7F+0q25MlD
         1aCw==
X-Forwarded-Encrypted: i=1; AFNElJ8MU6/Kh2KdcFR/0PqbiLaOT0fqHhHSxYs2wvrt5NrSDzRYSJZ3o2xkrIjPmXOBdZdD7Gfi1X2+a0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlye0xW095XtCtAeXy2iuDHLBAk3D/s+/9SQEp2JKGpKso5CFU
	btID+uUaIlgSgd8RLSqbqSFR2mH4E4Zk7G/wh4pk0oMJTQHW+51HbObZ2aNPxyf61o3OVzTqepW
	UT7GUldrL
X-Gm-Gg: AeBDiet2v7uQl1XzbKlJ+AW9lu1R3pvdY0FulLm4wl7xj+kFbEmr/7roaODAx3kZZ53
	dABXo5haLcysU5T40n2hs2xQHkh1s/LW8c2ZGSp5yW0FEWE7v2PThNg+5iPncvPUS21b9iw/+RG
	xbjLvLL+NTYpmgfiDCiiGGoLeM0Ybe5ILAUfnkxL5u1r9lfAb2o4EKRyz1RjD1StJ7lthFRaIAz
	ny4WG58Nx4cBRZQDLGq3leQml6P/eKh32ZT5c7lZnWwLjl/yKkPJpwvgoET7rBHJwaDOygZ1o4H
	1xU6vtETwZBhFT+2bisGlsUiHFtK/nrP9SiU2GNBcT2QVULpnAC5kWnwpCjefJQMPDEJOLeLAPa
	/EQmT4Q3cmFLGJIfrH7Zv057IgwrMZNRYF9kU1DUxspsgoR5ptowqB4fmEfb39yI+mhyWuUMrEn
	fqsMigjtMt7auRRsDBUNmr1hVc1XVmF9kP4F8NDf/VwGEV8crU6faKcataBs4z2haUJjAgjZJ+
X-Received: by 2002:a17:907:a0e:b0:ba7:d65f:3b2c with SMTP id a640c23a62f3a-ba7d65f4834mr731202766b.11.1776886869657;
        Wed, 22 Apr 2026 12:41:09 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4555398f8sm579558266b.59.2026.04.22.12.41.09
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:41:09 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba51e69988aso751974466b.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 12:41:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/wq2pV5wq7uLWSYJtIVCiVb7yf+QRg1KK3C7RgDP/PSbu0mb1k84Mubcei29U+Rk/Olbnqi253Cno=@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
