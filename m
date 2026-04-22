Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6658314A6B
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879436; cv=none; b=Bdi27kI9bqGKXIyQ7kQEljPjsSfGnh6XQCMxOZnOLdzNXizjF+yBs5Ys/zqgOG61kECOC70+kfCjcnre26bEyakRiwrtbE8FOK+8D0vyWAHkihHudkUgpqRr4x8wEs7Ivdo4n7PKDog8A6yYWLsxP/7mpnOYWFdPiMvAX6a0Z0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879436; c=relaxed/simple;
	bh=PEC67Z72ISCMHUutb9qe1/Y1CIJmRcte33AN4p2R2vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxORarjfDzsp7GpbmwKE+e+BUbNVJIOea6//JgWd1kixTIX+2LoUn8S1bIqPdD0OhUJKLq0TQpyIRYtk7FgV2G3ZFeJ6t8kfP9dhtkVN2E1oFRVlItp/zcNqkbxR4EBKipqvS74+xBF8RM/frsKAmeTJ1f1fpEn6Wwoxi74NWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so756581966b.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 10:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879433; x=1777484233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XycB5P8XTGXaeVGqnVmOVfspQ1laZv9fkJpPGtynpSA=;
        b=Zmhb6ba94bMGIRyTNWiw7+5J9e09UrsdfQWVjTNXm6BD0Ci0NK29hl4MxKZhmBApNb
         MbD6/kmZtqFG5SAZ0NRPHmDxs9BWuGKa+y9fpr7UEIuyPxPQySPRthAlb8AEcX6dsB/B
         m87U46gaTK8NSqFYiz/Rsx3iQMpcXiVY08M7iCw9rgBmqm+NxaQ0XxkexEDQvdOldHEr
         AZrsxvT51aintfeiUN8IZr+mpgybP19szoQd1oN+Sn3zQ9f4FetpJj6aO6yKdmZFORQg
         aDHJ9PqIb8YwBNLMSD5zs78+dskCsC/6ED3O0xW/e6vxqJOCvagNeZIeliT7j+52NLQY
         Y6Xg==
X-Forwarded-Encrypted: i=1; AFNElJ9RZn0Nl7RM9NBQRLkFeeZFs5Y7MJfiKczbo0790aXlCepHMxSaQMRsocMsEwPL5QVXEb+5b6xKIlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1yqeYzZmYGG+5M3nOC9CXiQww25Df0FdUvl6I4UcEukYV3hj
	GekWZj2h1cuWAGe4bIwKDd9QoiDQKlWtfibnztBLOdlE3BJHOxwMNz8A+Nge8t+/KxE=
X-Gm-Gg: AeBDietAB9YsnPRXQWsxSTbvdibAaS+2UJEbGsYQVOv577806UhIcLkXtcTpVUfJqou
	B3kjt3hgtAV/XHvA4FrTmrTBZZ18WAtbGTcRW6nS5Zyq6WlmzRljft17zce1g0Y7G2UBTWEGNB9
	2J2tL0Sv6Klqlpyg9Ubg42V70IPcboJ0iwPSFUG6ca3OUKYD6UUdGVGjwVCn5Xqx3X70Ed+PuaB
	FKgGOB11nnrA4nfx8OmNB+4CXWUmcGEQoujl4RVPHeF2sBRl0gcEZYxQ7fHob23vH0XzTWIyqwd
	c3OOPIGdqwtrRMkT394dp5VuKDEZeoYCyOb4D+pWTJq7Cg+flDCQLy6e1W1omTZFugZDSJo2byL
	z10O2pPj1Ei5N7Cunqbg9mOUmY2Keq4L7WCyRqsG1NmS2oFHLIPu0nQIniQgCuShoJOiRPje8M7
	GsjDsUeaRSZ/QlW9vKU6dYHRm0Hykj+aKouZl8l267MYmizQDodUWX1fGK1iRAyXzUbuY0fuk=
X-Received: by 2002:a17:907:803:b0:ba6:a05c:ac3f with SMTP id a640c23a62f3a-ba6a05cb5b6mr872015366b.4.1776879431901;
        Wed, 22 Apr 2026 10:37:11 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1b694sm581998566b.29.2026.04.22.10.37.09
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 10:37:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso2174978a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 10:37:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+E9G3zyp/d/V95XstRtbcbky4+kkCQOhkRmzsr+vQmoPeiEYDDQMeKkTDChKRHRHaef22SnV0nvTY=@vger.kernel.org
X-Received: by 2002:a17:907:7295:b0:ba7:3d21:c136 with SMTP id
 a640c23a62f3a-ba73d3108d8mr812474966b.18.1776879429078; Wed, 22 Apr 2026
 10:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-3-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 19:36:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
X-Gm-Features: AQROBzDRSuCo9KZmmr5oDnyHv4O1KWNwiPD4Dqbl5BIkN4nUOYnL3G8AwjYfgqE
Message-ID: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
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
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

CC Douglas

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote=
:
> From: Saravana Kannan <saravanak@google.com>
>
> When an overlay is applied, if the target device has already probed
> successfully and bound to a device, then some of the fw_devlink logic
> that ran when the device was probed needs to be rerun. This allows newly
> created dangling consumers of the overlayed device tree nodes to be
> moved to become consumers of the target device.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8=
x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-3-saravanak@goo=
gle.com/
> [Herve: Rebase on top of recent kernel]
> [Herve: Add the call to driver_deferred_probe_trigger()]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Kalle Niemi <kaleposti@gmail.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -235,6 +235,79 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +static void fw_devlink_pickup_dangling_consumers(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +
> +       guard(mutex)(&fwnode_link_lock);
> +
> +       fwnode_for_each_available_child_node(dev->fwnode, child)
> +               __fw_devlink_pickup_dangling_consumers(child, dev->fwnode=
);
> +       __fw_devlink_link_to_consumers(dev);
> +}
> +
> +/**
> + * fw_devlink_refresh_fwnode - Recheck the tree under this firmware node
> + * @fwnode: The fwnode under which the fwnode tree has changed
> + *
> + * This function is mainly meant to adjust the supplier/consumer depende=
ncies
> + * after a fwnode tree overlay has occurred.
> + */
> +void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
> +{
> +       struct device *dev;
> +
> +       /*
> +        * Find the closest ancestor fwnode that has been converted to a =
device
> +        * that can bind to a driver (bus device).
> +        */
> +       fwnode_handle_get(fwnode);
> +       do {
> +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)

After commit f72e77c33e4b5657 ("device property: Make modifications
of fwnode "flags" thread safe"), this must be changed to:

    if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))

With this change my DT overlays are working again.

I guess keeping the FWNODE_FLAG_* names, but changing their values
from bit masks to bit numbers was probably not such a good idea,
as it fails to catch missing conversions...

> +                       continue;

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
