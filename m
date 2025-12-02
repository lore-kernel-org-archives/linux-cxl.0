Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EF279792
	for <linux-cxl@vger.kernel.org>; Tue,  2 Dec 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693662; cv=none; b=ie36hub+ARKhtqW9Iq4wzyzTvlxWrfJGJAJZ7Lpm6nNFv92w4U8MLipeJE1zqBYbxMfYLhAlRML/AGqv40gGwH7OaujuMQlx1uu2N9axT7mDFIuZopYK4leqUhyUCkTBzVQNWrqhPZLTiwi49DM2V5NppwSO3A3t+mwP0qLJY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693662; c=relaxed/simple;
	bh=7JWQpNMMWls0pEOEbb/qFxvVCdKg8LNQq2xwgx7Zjik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEt+/j4n+a1Z62scMrHAVIZtLMuhpk1h6w82xOCsipWkhthuvaUhvTwCVtBGpou3T/46EOwSYhQKDB0TJfCsm3KX+nUDsTWzNTaj4/FMhTE3sDl7okMsaoDuwT/L6MHpBLOyB16j9nDiO/xuEiPNm11dvu0oTR/7tHSy9Q5A9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b5ccceb382so26306385a.1
        for <linux-cxl@vger.kernel.org>; Tue, 02 Dec 2025 08:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693660; x=1765298460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yo/Q77iM2dxCsDJX0wSMsdkdBK/3CM2tnqmsgemQ55M=;
        b=qQjoUS6A3C2LHjF7ORhNJpINJRZ2+r23qduihg9MEtwbUFeIGKfQwyFfuxy+faJcdL
         35xlZUscYXudSqAUtXWEikHZysBY0X/3Bl0dRtyxGpxaihUVOTudM16Jmjw/QXtDsQkM
         wKCcathzMggrPcbWkMnt9tgeSl+TzPNQ2TGFYgvervRFfKx3FVEWaG4elFhvkI2waV7q
         zSfQYYqomuZ77IIZXTIo7+6bsexeOWjB+P2/IPG82z1BYyN9pfnq6wVA+NRCzRZl3+p+
         alSgBe3L2dcbqG7CIZXZBSL9SfPb4MWoKQ5EF6p8CiAjDa7svRXXfycVt21wMiqdfM5P
         OWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMy1aaopJ+Jd3JvojXIffwI5AjPdk7YQMt4WSW8e5L7CKehIKiHDuOLgSXwvjBOctNNdvkj8M49f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnz+GPgFV8VXZvOnzMBDw2MNxUB+4G0EPG2/Wh8Z10sBNmPpui
	NlB0ZYT6Or+sReUAPwv4P/KCuz3Dy5yaqow/U5rehGBalDQqZSna4Fagct0Pug+s
X-Gm-Gg: ASbGncvuxzyuYFRExY7mcdgvGI0B2GfwI0gdg/P8Y7dMVLwL2kKkK5IYAfLF9SHmKPH
	+Y5fn1xmSh3Rp0QZE8jqrOEPbtUUjcvTrIa2RPf2Xau1glvlc8Vg5dRsAsWnJqqHlHxnRlmIn5g
	e0FiB9JUOHVu7ppS9bqnNZnF5FPNE0VQc2nvY77s2f3gDKOnt418cw3TDTwVfjs7Vwa6bvLEjjo
	UDggrWu2kZoZs5gZvNqFlb9ptiMXf4X+CWmOC5quDBNU1lYqZ8/fq+Z8c8pKEc6rULFdGT22I0B
	+DfdFdL1Ln6Siz+W+RJ52RjCWXl+m+RfFqCmPt5oJOKc8wmck/+mT1hJu61cRfSJHBmtxjRpynl
	9RXevwX1Mefay7X5o+/Wv+y0n1rPKPJG+dtYgsnshaG8vsW2OoCYrbecwn8SbPnljap7FzJ1FfN
	wn2yMwGCQ3kh5aQ5nXaR1fy8eC97z+qrZIrvjEMSxJf/NbtX/2yxf0
X-Google-Smtp-Source: AGHT+IH4Fpz+5v1wK/fCzluw5VWD3NDYDlUKTKYW3qmV2QtkVJPU4+BqHOeYz1Saf5/duaxlSHliOQ==
X-Received: by 2002:a05:620a:4402:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8b33d1b139fmr5814833785a.3.1764693659897;
        Tue, 02 Dec 2025 08:40:59 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1c90cfsm1101387685a.42.2025.12.02.08.40.59
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:40:59 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4eda26a04bfso62455341cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 02 Dec 2025 08:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpXEvw+ev9aWVH3rK9p/jPfjk23MOkvEkBwbHktbf9ZWSAJbUBNsHGVYnAOKPKu8u5tnnYfj+zWq0=@vger.kernel.org
X-Received: by 2002:a05:6102:3048:b0:5db:20ea:2329 with SMTP id
 ada2fe7eead31-5e1de370617mr15734527137.35.1764693347428; Tue, 02 Dec 2025
 08:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com> <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com> <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com> <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com> <20251202102619.5cd971cc@bootlin.com>
In-Reply-To: <20251202102619.5cd971cc@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Dec 2025 17:35:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXogrkTAm=4pC0B+Sybr=PR3XovnBgmiEyTvUMmJHvBRA@mail.gmail.com>
X-Gm-Features: AWmQ_blh_df1oI4YfJoUHGn7ADOVOwmOm5bT6QJUN9usi3sbU4oWN1R6RdMkuuY
Message-ID: <CAMuHMdXogrkTAm=4pC0B+Sybr=PR3XovnBgmiEyTvUMmJHvBRA@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kalle Niemi <kaleposti@gmail.com>, Rob Herring <robh@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 2 Dec 2025 at 10:26, Herve Codina <herve.codina@bootlin.com> wrote:
> On Fri, 28 Nov 2025 10:34:57 +0200
> Kalle Niemi <kaleposti@gmail.com> wrote:
> > >>>>>> Test system testing drivers for ROHM ICs bisected this commit to=
 cause
> > >>>>>> BD71847 drivers probe to not be called.
> > >>>>> This driver (and overlay support) is in linux-next or something o=
ut of
> > >>>>> tree on top of linux-next?
> > >>>>>
> > >>>>> Rob
> > >>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c
> > >>> I don't see any support to apply overlays in that driver.
> > >> Ah. Sorry for the confusion peeps. I asked Kalle to report this with=
out
> > >> proper consideration. 100% my bad.
> > >>
> > >> While the bd718x7 drive indeed is mainline (and tested), the actual
> > >> 'glue-code' doing the overlay is part of the downstream test
> > >> infrastructure. So yes, this is not a bug in upstream kernel - this
> > >> falls in the category of an upstream change causing downstream thing=
s to
> > >> break. So, feel free to say: "Go fix your code" :)
> > >>
> > >> Now that this is sorted, if someone is still interested in helping u=
s to
> > >> get our upstream drivers tested - the downstream piece is just takin=
g
> > >> the compiled device-tree overlay at runtime (via bin-attribute file)=
,
> > >> and applying it using the of_overlay_fdt_apply(). The approach is
> > >> working for our testing purposes when the device is added to I2C/SPI
> > >> node which is already enabled. However, in case where we have the I2=
C
> > >> disabled, and enable it in the same overlay where we add the new dev=
ice
> > >> - then the new device does not get probed.
> > >>
> > >> I would be really grateful if someone had a pointer for us.
> > > Seems to be fw_devlink related. I suppose if you turn it off it works=
?
> > > There's info about the dependencies in sysfs or maybe debugfs. I don'=
t
> > > remember the details, but that should help to tell you why things
> > > aren't probing.
>
> Rob reverted patches but I plan to continue my work on it.
> On my side, I need the reverted patches but I fully understand that, on
> your side, you need a working system.
>
> In order to move forward and find a solution for my next iteration, can y=
ou
> send your overlay (dtso) used in your working and non working cases?

Hmm, I must have missed when Rob applied (part of) this series, as I
do an overlay test (using the out-of-tree configfs) on top of every
(bi-weekly) renesas-drivers release, and saw no issues during the last
few months.

So I applied this series and tested loading my SPI EEPROM overlay.
And it indeed breaks, with the culprit being this particular patch.

Interestingly, quoting from this patch:

   "While the commit fixed fw_devlink overlay handling for one case, it
    broke it for another case. So revert it and redo the fix in a separate
    patch."

Where is the separate patch that redid the fix? I assume it is "[PATCH
v4 03/29] of: dynamic: Fix overlayed devices not probing because
of fw_devlink"?  Unfortunately that doesn't fix the issue for me.

Quoting more from this patch:

   "Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgy=
o8x6=3D9F9rZ+-KzjOg@mail.gmail.com/"

Strange that it claims to fix the issue reported there, as the failure
mode I am seeing is exactly the same as documented in that report?

Do you know what is wrong? The overlay I am using is referenced in
the bug report linked above.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
