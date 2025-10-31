Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFA2192F5
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901114; cv=none; b=AWrfaQtpn+R29KdB8KbefiMJd/C7FzkV4xzv2GCjTl45/Xo5CNevgL+/KKvTQlcKYJuYz1hTTEWRFDDJfWd4IyYghcIYxNiznWVV2xKrO5VxAj4g6t+swX+VOpU/JP67HnuIz1/GlvZXD9KYMhRXubNbWedOjeOZbvczphA019M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901114; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6TxicOHNJ8Xzg77OGtut40Kq3+lNQaEi7DTNBq1eP/waDapN6GQRGy5EG9hnoAvzoIY3KliYcApgkhwIK0jfNOJHmxTwn6mgOVgP0V+8jUMvvoBHqlzLmENK7rsKe/68SzKLe1hH/AK06EUM32P/6zZ037+WWt//0Tco7Gtlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e896e91368so24299131cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 01:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901111; x=1762505911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=bKRkatDStaHMQKx+bSG7SQoQVysEH+7vE0OvOAoHoWe48XkXe8e10f2FSHKoye4woJ
         +165c3PBe+g/eziee6XzPV2n1YDAph3u/wMsbU9LCMBOxTjfSyXyTeD8PDgFI171CxbT
         IODCLwWxZCeIPCMfPChzISzk5Wrxn57OB7AlBetbluzkB5xJYHami8EU/Hg+Va5fNo2f
         U1e+bRrn4CM+iE+0xiDLyHgMm7T2J6xeJ0D6P9Knmu3/X1/7EYSP/skYNvCg3j5bBMXR
         rsiqkxrbkby+qVX2gHpepzblvx9uX9e24e/l45b2JNUYHMhADeTfDBbTnRMs8JT77yz1
         4YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlv7oSMXe+QFZxXyg2uxBmPrPBQqI6V5SS+lE3FYWw8LDbqAs+pnvWXPPGg6DJUYfN6tpxjeRsdbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqBwynQSonh2tHR+9Z9cvmX+7k6jr2ofK4YPVnKlcLRoNbE3X
	jMwSoQAcXj5FBbGeOb1moIjFJcI2+6KU1XAfnDaazifHVvnul6qEybxzkZsxuej2
X-Gm-Gg: ASbGncs2onp9VozLAEKfMyi00Y3qb3rWdctcRgbVjvgHkOXVm9gEyC4d3xK3iRDyaMC
	6imBX9BJ2cSgm+wd0LBdqIxLmvJnIM2W39xEjoQLk6bFlacj0T2FoDsi6CPOrkYnLY9ws89G8NH
	GbXlpYWVkO9Hdq6PfbiqR+2WkILmi7Ff5+JOzFAiycR9yoPZigM+REUmVlVp9p3wSB1nGG+0Lh+
	1D9pLH0/om1inYUIwFGa5Sc3DkoNCMRO1quEcNkjg3BJEbbDL02OtoBCCUihwQatX6k+PPgcqZG
	eU4JpZOuX+ocjGkW7APafYZQvNXus9Qj5s4jkD+Mz3+PnsS/NLxoQwM2ju0OwHXLEZRuT3OcWM+
	cO5/huM0lAlP7YwTDWPLWZEkbeHVtx7TgwXWPUGhPyckuwSd6ajPozGDc6A6O3JmXpBIUUFGU0h
	TBctbWfMmHqtTtToBf+VO1nw/mno16PqlRc5YqabW5+w==
X-Google-Smtp-Source: AGHT+IGnvRqs/wVFZOTyveqM7YRagGVzPdU5z3hDtTcQgRzAwAoD9dxi6f+d/wnVoqWigU8SaDDBNw==
X-Received: by 2002:a05:622a:4898:b0:4ed:2140:7a96 with SMTP id d75a77b69052e-4ed30fff3afmr34451321cf.58.1761901111104;
        Fri, 31 Oct 2025 01:58:31 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed35068cbbsm7701621cf.15.2025.10.31.01.58.30
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:58:30 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e89ac45e61so17715031cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 01:58:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM6h2IA6CsC6B+UHlUV0vlX1fisVvx6skd9L6fDfVSW5lKcwBFpqeYWQZvyM3Oj187ZyQ8y6ZcXq4=@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

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
