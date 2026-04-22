Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E583EF0D4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884345; cv=none; b=txAc4pCBY37YGwMyTdsiY8plcbYBMx/iVj545Wj/r10KSDJ6zfDid0NqyP2krvI3cSHjdFIEOnKmVInq8hTYimE2tt/OdJaCKLeG5jdReoMotlP2hwZwvZaI5tmTdWakcN8OBVAoyzVWox/2v8iufsBMiB3a6DfSRelfSttBlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884345; c=relaxed/simple;
	bh=W3gJGhETv1i99hgZ4Qzxlq7+a/rqAi15n3RaJvZubfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOSRNSSGsaABP07H+/gNmFvTNG3GgoY1HXxSlRKJ0hFSJwOS8s7AhE8N/7Oa+hJ605QcWoITEGIvpes4lbHPVmw7XVP+/VtosOCaEkCqf5uBEK7zYyJZiX0gdLVpe1ag3OHtnvrEPSQ2drITGn28rLgRYFVg4o3l8gKhzXUETHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=li7ym60b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="li7ym60b"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c9d03524cso803766066b.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776884332; x=1777489132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4vBmmJ5gC2QCrFlTLiSjZ3SPsY2SAKP5dBxbzswxUI=;
        b=li7ym60beuSB+J0Js5TfsIkV0edlc1kgEB/xClDmYpZYwA4gmF4kZK7vjtuvjWg8vA
         ak5XyXi72tbUNe4sJhtq/RcAPmMHPpzvzaa+m1qCqpBkV+YK7vOjkLKMjsVvLVsPH2EB
         xtYX1AtRI8Qx+Zb5j+yE1wBIyf97jarkyhiMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884332; x=1777489132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4vBmmJ5gC2QCrFlTLiSjZ3SPsY2SAKP5dBxbzswxUI=;
        b=ekyFPu5Lnv37+0WZwH+0eTkFsI2RLksaoDihkmOY8JFQPnFoUEp7yttmrGYuJzKEZF
         dB0QfiMQe+vAFnXr0RQ5K3JtiInhaQfxYlCVDJwKIhIYiBzjr5kB2fhjjhDYXCPzdYMc
         3lGcz2lHh3ad/26zi5kUXYeO41XR6FWCuW95HEcy4jjq1VfSFqdiU7H/NB+sXg8Iv25x
         pkS3vl9spmShavKMwqCf8pRjpHKZ33WBbaPBgj9LoArKIbINYS+oK7NflUWqptBCQPlw
         +6nOnm8SEzAjchds+p9SFY08CzAuDMiCXmcd3fRuws4I2VY9hsHc5Di2Q3Ri1SEQyF4V
         BhJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cL9vBfUgH3xk/J+Z1R+/v1eBrXQk95dqr75PUzlFwoDIFzDOgkS4hYZdg8mbUVDGWEHcSVin/L80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dgFYPd3m8P7kvmYTGQ3TWOu7afbwxHvy2934VMWBPhguFKC+
	VXJWQRX03kAwgwRIoE27OxeVpZ1ZsuBE10grNQcvxsuUt6kcND/9m1aTyDBoWFZvTinZj4z0awJ
	dHDIWWg+x
X-Gm-Gg: AeBDievZNtA5RojE+1ZnrpumTXd3R2adrXUCw0StfCrZdxrajC4BV5Hqgok+UxUH1JM
	i2QXadhWiF4qomL/8Yr9IVEsS4NdM0KcbI1y1s/botlgg7iry2F3iR58YaXPbvfOGL+BzMZ+pS+
	63oqKlEJ2Z5H4ywatW6bbsin4yEKKIi3X4xQHrE/wHRl1+YIKRp5kCc6EtMZ1Iq+dW6BYIgnn4L
	mFy8mtO4O+95CIsWhQMfE5gWW7/UobIlqM4vm5CWthh3kuMS9XaliN7cu/U81iatBB67WpLad9H
	flyeimzgICJ3iES42S+zwiqsP7VcRCOMf2OP13VSPak82aDb5aW7RR3dwXivHpKMOVGv3+KDDMH
	Ao0J0qJ6OvNTtZonmuClDW8CLkQfmQvndw1pOT3Qd3Xc9x6hrDUccjyQoXUabzvcaxbGyfi84bA
	8/P196BL84ZuKvF922Q7mgHxkOtAmVexP6v0oFfy+fSE9A5BptYWZQLV98ncIXtGoWHebldLOqC
	cGaH7clzes=
X-Received: by 2002:a17:907:985:b0:ba9:2f5a:fa38 with SMTP id a640c23a62f3a-ba92f5afde1mr559600966b.0.1776884331820;
        Wed, 22 Apr 2026 11:58:51 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e502sm572736966b.61.2026.04.22.11.58.51
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 11:58:51 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bab8ae52954so136347566b.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 11:58:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+wO7KSu73lL400XTyy4brf3/0irDSjYvySR3BG9HGTfUhujmiJUiBCe05Y7gEPcZq+OF/9EAPThow=@vger.kernel.org
X-Received: by 2002:a05:6000:2f8a:b0:43d:7a08:a5e6 with SMTP id
 ffacd0b85a97d-43fe3e073c9mr39087653f8f.29.1776883909243; Wed, 22 Apr 2026
 11:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
In-Reply-To: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 11:51:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
X-Gm-Features: AQROBzAV3w_CPq4qi5veiP_uOv4VWrOsaTYpBbypDAKqTbu6jiZzeNsnLIn0Vds
Message-ID: <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

Hi,

On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Herv=C3=A9,
>
> CC Douglas
>
> On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wro=
te:
> > From: Saravana Kannan <saravanak@google.com>
> >
> > When an overlay is applied, if the target device has already probed
> > successfully and bound to a device, then some of the fw_devlink logic
> > that ran when the device was probed needs to be rerun. This allows newl=
y
> > created dangling consumers of the overlayed device tree nodes to be
> > moved to become consumers of the target device.
> >
> > Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> > Reported-by: Herve Codina <herve.codina@bootlin.com>
> > Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgy=
o8x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> > Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com=
/
> > Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.co=
m/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Link: https://lore.kernel.org/lkml/20240411235623.1260061-3-saravanak@g=
oogle.com/
> > [Herve: Rebase on top of recent kernel]
> > [Herve: Add the call to driver_deferred_probe_trigger()]
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Kalle Niemi <kaleposti@gmail.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -235,6 +235,79 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct fwnode_handle *fwnode,
> >                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
> >  }
> >
> > +static void fw_devlink_pickup_dangling_consumers(struct device *dev)
> > +{
> > +       struct fwnode_handle *child;
> > +
> > +       guard(mutex)(&fwnode_link_lock);
> > +
> > +       fwnode_for_each_available_child_node(dev->fwnode, child)
> > +               __fw_devlink_pickup_dangling_consumers(child, dev->fwno=
de);
> > +       __fw_devlink_link_to_consumers(dev);
> > +}
> > +
> > +/**
> > + * fw_devlink_refresh_fwnode - Recheck the tree under this firmware no=
de
> > + * @fwnode: The fwnode under which the fwnode tree has changed
> > + *
> > + * This function is mainly meant to adjust the supplier/consumer depen=
dencies
> > + * after a fwnode tree overlay has occurred.
> > + */
> > +void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
> > +{
> > +       struct device *dev;
> > +
> > +       /*
> > +        * Find the closest ancestor fwnode that has been converted to =
a device
> > +        * that can bind to a driver (bus device).
> > +        */
> > +       fwnode_handle_get(fwnode);
> > +       do {
> > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
>
> After commit f72e77c33e4b5657 ("device property: Make modifications
> of fwnode "flags" thread safe"), this must be changed to:
>
>     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
>
> With this change my DT overlays are working again.
>
> I guess keeping the FWNODE_FLAG_* names, but changing their values
> from bit masks to bit numbers was probably not such a good idea,
> as it fails to catch missing conversions...

Crud, I should have thought about that. :( Do you think it's worth it
to do a rename at this point to catch future problems?

-Doug
