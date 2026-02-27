Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112B3563C2
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211448; cv=none; b=TbfJKY8SWZFR2+Xc/6kQ/GXB/NKkqAdu4RsJvckZAxmFaHDsu3oBJXQq/1PVJygOpH8cVICqIrpem01Ajap3U+KXaABc5jnKL0MRmoSbrexkWuKytXhqlHtfX52M1rvghl91VN2qaiAW4m6yhySnH3yUpPEzfqfq6TB5qWZywD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211448; c=relaxed/simple;
	bh=8QooufOo4pPMQ94Tm+1S+IKUXQJzBKWDChzX4qil09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCcNfYBZ8x56ADnCCsHZ3BQntpJzsqwQKSTHwfBF0OBPMy+VdlRNgnNTiLQ9nZeSP2hrLdpu62IJG2ee1Fvz6/HSExexJgwtSw6MITZPkCaLjH3DrYmnTKln9Fz9r1ozShnVNfyQK48ivXqkkofC1J7lcO19COjrTaG7QgY4uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748095963so864048b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 08:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211446; x=1772816246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIGPgG8NajjCLfKfqfkEsLDhUiGu4xrfbhUgqAmvE/8=;
        b=bNCTBoDeJv3+7CsZzYpSgaW29/f9BZQVJaxb5hKv1B434DAee8poFxF4iKyjX1Sdog
         VBJueI6DqxGxd8Gy2GB2cULX+Rni7d22C/7jPcP5Di4SyGavM2WC0RhslkYI8hIUDfP0
         98DzWZt30qpXaDtegKbigcXWfewSYluucGYXukrka5a6A0cqLdnESXRNKgXPHPf2TqlM
         iStXRqXpwPQm+DgbpCjoPNKtqB/fqHCMTRrS5Bz9BZEDQdLMInlDWbZ6KjpC+GA35YuC
         vEeIisbH/5u118nZ8U39ahYIRBzggexEP88zEsoeEBMeRfK+d+QVwyG25GKdT639gI3f
         Vt6g==
X-Forwarded-Encrypted: i=1; AJvYcCVvyRJqLeREBIwLGEaDNVNseSMTlL9ZDMEfCqmFhL6Px9A3mNeZHHTKcdT9bZThbF9B5kCoaKj2K3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoy7so7Dad1xL/jieATPRfSHtF8O0F4s5suUHV8tJ+2/nhwQq5
	r7sHKvOYoB+jfLQP+Wjq2c5gGwC9VI8TCLGpahGu68PVogXJIz69fKayLZcZsY6ktnU=
X-Gm-Gg: ATEYQzzacTG85rZmZR1cww8q804znoWysfAXzWfUnkKD8XgNrGtnMGADn6mmYq9AZ0i
	UcYBU6RynIskSKqQox8sGQNJ9XePx71ytshp2KFk8fA95pS6Rog0OGa+UKgpqyxPS2lSqWD5T83
	dJAYU46VBz9ddss3LXIM4AMpaEV7oh8I739WEpVG/7qtw1GvllUyF5yxi7QVUNHjWOpdLqjhW18
	JpHwVk8Mp5XAm7Z3upEOcxAAmvhJdfaFrCsQz1yjoBb1Wt15xyUgNx5OGRfwkUbLQn6hrDbHUPD
	b0qjHoiaSSANlPdI7IOXzG7QEoDjgm8/qiiMnGSppL6m6HPBX/PZEIoNzEXnQy4C8es9er4UnRd
	pgxx7ONvY46BUZ7es28z/+OY/XDAcwKs5hPOyivj4Wo4ROfNhpacWCNR88zPOr+mFwzNmfW/toy
	G/meCKoz380ozo6NcEy6rSQ7Z2n2IHtVIQBB9dAgq06G/6J/VoYK3DpxqHeM1T6GgQebxDFA==
X-Received: by 2002:a05:6a20:6a04:b0:38e:99a0:105b with SMTP id adf61e73a8af0-395c3b3db2fmr3193496637.51.1772211446237;
        Fri, 27 Feb 2026 08:57:26 -0800 (PST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa632ddesm5213323a12.13.2026.02.27.08.57.25
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:57:25 -0800 (PST)
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732e6a123so350807c88.1
        for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 08:57:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgrobiSoA9x9QFyFyCP/P5uXcKKAdJA0abCBWQaftyG0tz/cpwl9GLuJfFVYxN5FWw/Rh42X4QF5Y=@vger.kernel.org
X-Received: by 2002:a05:6102:c01:b0:5f5:33c9:c9b3 with SMTP id
 ada2fe7eead31-5ff32536408mr1676835137.29.1772211026292; Fri, 27 Feb 2026
 08:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-4-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-4-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2026 17:50:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUAHXNbGfJFcUMQbzPqRS0S_RErU8u7t=AdmX0ZFQMjhQ@mail.gmail.com>
X-Gm-Features: AaiRm53ZqgozcqNHytSHwR_CUbVuY8sQSeRMANHqThlNEOeyZsxQir9SPbAYLBo
Message-ID: <CAMuHMdUAHXNbGfJFcUMQbzPqRS0S_RErU8u7t=AdmX0ZFQMjhQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/28] of: dynamic: Fix overlayed devices not probing
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:56, Herve Codina <herve.codina@bootlin.com> wrote=
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
> [Herve: Rebase on top of recent kernel and use get_device_from_fwnode()]
> [Herve: Add the call to driver_deferred_probe_trigger()]

Thanks, that last change did the trick, finally!

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
> +                       continue;
> +
> +               dev =3D get_device_from_fwnode(fwnode);
> +               if (!dev)
> +                       continue;
> +
> +               if (dev->bus)
> +                       break;
> +
> +               put_device(dev);
> +       } while ((fwnode =3D fwnode_get_next_parent(fwnode)));
> +
> +       /*
> +        * If none of the ancestor fwnodes have (yet) been converted to a=
 device
> +        * that can bind to a driver, there's nothing to fix up.
> +        */
> +       if (!fwnode)
> +               return;
> +
> +       WARN(device_is_bound(dev) && dev->links.status !=3D DL_DEV_DRIVER=
_BOUND,
> +            "Don't multithread overlaying and probing the same device!\n=
");
> +
> +       /*
> +        * If the device has already bound to a driver, then we need to r=
edo
> +        * some of the work that was done after the device was bound to a
> +        * driver. If the device hasn't bound to a driver, running thing =
too

things

> +        * soon would incorrectly pick up consumers that it shouldn't.
> +        */
> +       if (dev->links.status =3D=3D DL_DEV_DRIVER_BOUND) {
> +               fw_devlink_pickup_dangling_consumers(dev);
> +               /*
> +                * Some of dangling consumers could have been put previou=
sly in
> +                * the deferred probe list due to the unavailability of t=
heir
> +                * suppliers. Those consumers have been picked up and som=
e of
> +                * their suppliers links have been update. Time to re-try=
 their

updated

> +                * probe sequence.
> +                */
> +               driver_deferred_probe_trigger();
> +       }
> +
> +       put_device(dev);
> +       fwnode_handle_put(fwnode);
> +}
> +
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>

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
