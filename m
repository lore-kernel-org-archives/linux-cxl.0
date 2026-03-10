Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859630F534
	for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155357; cv=none; b=bLaSg2WIp085ZzDq6yRXZamGejfSegMDLWhc9cnmZ++NbBTYB2QLmh3hBD/8YbRvoOoBvzfjDgMLlf7loDNutnGeUu9aQ9BXJDsTSBmcH7M5bhQhgAOeK0IS09g4oxfneZa6nhjmgNZm0ueVEf698izMSlksO0TaEgRRqij0Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155357; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnWvVBJTEtFdIp0Ugk0aZqY/I4BP3bd/VrLU0ovLHhRGmUT9hdRWS9Rxb+3R0nDLum/B7mROBek3NthRg7igeo7xu4/2/jhgsQbm7YxuDw8425dBN3diSElCrYngJyr2jbzlM2Csy03G8ttjpD05D1+8md89uRQQ7FODCjLYYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb40149037so1385388085a.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 08:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155355; x=1773760155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=Zf7HIrdBoHmo3bfpMfJ4/F4h+nC07XIP/itluUD6j2Vc5kdwdtRlz4bUSd9A5QAOi0
         Kyu0hwRySWIrKWgpMS9yVkwNqjiH8mm+JrFM+yCwF+dAJ6Xf+dp0eK7fJyt7qOaE1eq2
         rR3ndqSY9NTJvCkfDdV+kSP+OPVvvWzMbtroAaFRBG6EqfF3zsczWSPhoamcGeQN8t6X
         0QiVAgzuC+xpLz0P6M4AFwR8GyRAzHRFmAe2j6bhsRp0unuQviyPuLBepZPbko/127Si
         XcWZMH3yiOhTzloERaTBfPVC7ElqR+xd14cpfI4a7qjs+b3QEse7EOKy9y7lZ3Pw4fiN
         GqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXgRp6z2s+p5lgO1E8aG55zHAdFmzw1DjnO6xPYMRthIQGnaE21wL7VzZ2IA2w9aF2te8p9qNfmtlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuti+rhdUq4waOILrVkN1O/CBLjS039ezPUfzDesp5YCpvp5ZY
	8QmpZokoNa0DcPGO117NSa+ZyQNwicbtTF0XHekA/tya6LpCkrOxy31ZOFU3lnSS
X-Gm-Gg: ATEYQzxjOBEPaXe/6aqaTwjZTzD8r97qsTh5gP+aKUF4P925w+8bzRq/Hx1Z6HvyGIn
	DSH8At0mI/8ScGhWmOfOL5x+7OceJEJIh26m/x3tvhxLXD/DqIUT857TitZ9FNMG0gg2Y+tTPFN
	h47RCfgwwYiNAvJIXlc6nPSp54fDzQc8eGaD6EVEiyh1mSDquKVcUgSY/zCuPErT1ndtRrY4h0U
	e1fc5OUryzm19/nDyEgEmOBHmMoMW1gN79+c+QYzKwNzvxaxM8+J9boCa6omgQWoOOjahca5g2j
	Rahlb0w5Rj+B48LksvM3Blet8nobDVPmHY1lWXmTF0NfKqSlQENcTK0Ir8i7kOhIrg8AlZuigML
	DgfDkCbS5hUP4h+XC5yJSXmj0su6v6Cj8ALfw4Xf20OHFUKgLNxafvbXOzYGYuX76dJ+jRErUmD
	ekDNx1VKPug+NWF43f8tFGEO9kmla1qfsOnhSAWspIgEUcEAZm4hdmzZmJYGT+
X-Received: by 2002:a05:620a:4694:b0:8cd:8635:c063 with SMTP id af79cd13be357-8cd8635d189mr901770685a.50.1773155355359;
        Tue, 10 Mar 2026 08:09:15 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8251fe72sm537866085a.30.2026.03.10.08.09.14
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:09:14 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so87034926d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 08:09:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLV4laqK0uViw3W61vGIqqQr7g5EOsG3IRAAh/dq3QjRyzLddgHcb5TYWDRsJBBL0M2I0af7+G9XA=@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

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
