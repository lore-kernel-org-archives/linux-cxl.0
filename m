Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CC34DB5B
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975763; cv=none; b=mZMEcTqG1hELWw24hlRYhY304khyJD1ifhLm6mcStp3Zi3NsDoBgqg3Gng8lPuK677pBKvlpTBb6ZipDbqk08g3L9cJpE0vGTDCjAEN3neOksYEVu4Hom1s/HZ4+BbML2Zgs0EMAjhAgw0Qnz2XZb4tZNeJOQZ7kij7hOlnAUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975763; c=relaxed/simple;
	bh=cBs5VsCM5bkQCwAVcWEWV1HKeCFrZdeAh6gx6vjF0Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHwg2yEqL//3yhZQ++AW0ajJauP/lVGFB8J1ShSY7D9VFoIVU5p/SMfFUr/iUBPBIL3sXMtQ7zJG+9MWn2wJxImeOlbJH9IxMFL21AqWp1gHmxqUhWMQw4uH9GvU/jWwAo/dTm4QYnE2kp3DPnpRX48Tiwttsa/fT3NvDrFQ0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K352Iz8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K352Iz8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C102C4CEF1
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762975763;
	bh=cBs5VsCM5bkQCwAVcWEWV1HKeCFrZdeAh6gx6vjF0Ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K352Iz8Ah3njTVW7iehUnnH7mqi0Jd6YwMB4qZkyO+cIO1D7Pz6qNEcuOZXb/AXkw
	 pcmFXpcyZMls1fI59UI/29eJypzLeW20lErann0mpshHzt3ur4vj67oY3kW4uBN2+D
	 wdkZ7dKutDKfxp/0HGFCbyl6exwmzFCVe6M/nkpYSoUlXpG0XiZwVxcppdH7WD6Ni9
	 z+iTp0EgYBh7btC3FXy9oVN5fPG+ADnQ8+SmKYuB+BPDNb5Nlzg2CF6LxSEFIG7x6r
	 UwVZqF1WwD656gypaRpT/CvjAXPRt6J5giHHLr3kYehrERBJTQ0mYJ1NxiDLglYNmD
	 Y3PHhD2Z86n6w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so10307a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 11:29:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGsFhfNid1wjpFIhPrwLww+SMzRXJZiicSnAbkTNV5jQ9naDfnQo8FEzis11ZnEtDaJCvPfjhfMuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SR+HA7RCa5mBgqUEi9W0K68Rsv+J9XMZfVkHbcOZ4FBi4HgZ
	/w30SBI8aKqMZPwhFQPvq6P/MS26H/aVLziCzZl0ZwoE+uXoiQCtVp7BViSMEhtqK9ac6Ig3GCm
	x3efBhW33Br+tDipX8HEe4Oh/n+jIRg==
X-Google-Smtp-Source: AGHT+IHHsq6g1iGPfNpj/BGp5eL9w+14A+MEbPOCADp6BJOBMQBWxT0j5cv1w9FevsaSK63J53W6goPTLfg5SnHB+/k=
X-Received: by 2002:a05:6402:34ce:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-6431a4bfc9cmr3902960a12.6.1762975760981; Wed, 12 Nov 2025
 11:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-6-herve.codina@bootlin.com> <20251030141448.GA3853761-robh@kernel.org>
 <20251031162004.180d5e3f@bootlin.com> <20251112142632.GA1610836-robh@kernel.org>
In-Reply-To: <20251112142632.GA1610836-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Nov 2025 13:29:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ89EcUvQnS0xYXOrw6wJ30TT5oFA85eCqHYdu43056cw@mail.gmail.com>
X-Gm-Features: AWmQ_bnvVqS34104BGAfHcYDtcOO0joqpBN-zpybKauFgaXAFRsInCQMBTqH6M4
Message-ID: <CAL_JsqJ89EcUvQnS0xYXOrw6wJ30TT5oFA85eCqHYdu43056cw@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
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

On Wed, Nov 12, 2025 at 8:26=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 31, 2025 at 04:20:04PM +0100, Herve Codina wrote:
> > Hi Rob,
> >
> > On Thu, 30 Oct 2025 09:14:48 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Wed, Oct 15, 2025 at 09:13:52AM +0200, Herve Codina wrote:
> > > > A Simple Platform Bus is a transparent bus that doesn't need a spec=
ific
> > > > driver to perform operations at bus level.
> > > >
> > > > Similar to simple-bus, a Simple Platform Bus allows to automaticall=
y
> > > > instantiate devices connected to this bus.
> > > >
> > > > Those devices are instantiated only by the Simple Platform Bus prob=
e
> > > > function itself.
> > >
> > > Don't let Greg see this... :)
> > >
> > > I can't say I'm a fan either. "Platform bus" is a kernel thing, and t=
he
> > > distinction here between the 2 compatibles is certainly a kernel thin=
g.
> > >
> > > I think this needs to be solved within the kernel.
> >
> > I fully agree with that.
> >
> > >
> > > What I previously said is define a list of compatibles to not
> > > instantiate the child devices. This would essentially be any case hav=
ing
> > > a specific compatible and having its own driver. So if someone has
> > > 'compatible =3D "vendor,not-so-simple-bus", "simple-bus"', when and i=
f
> > > they add a driver for "vendor,not-so-simple-bus", then they have to a=
dd
> > > the compatible to the list in the simple-pm-bus driver. I wouldn't
> > > expect this to be a large list. There's only a handful of cases where
> > > "simple-bus" has a more specific compatible. And only a few of those
> > > have a driver. A more general and complicated solution would be makin=
g
> > > linux handle 2 (or more) drivers matching a node and picking the driv=
er
> > > with most specific match. That gets complicated with built-in vs.
> > > modules. I'm not sure we really need to solve that problem.
> >
> > Right. Let discard the "more general and complicated solution" and focu=
s
> > on the list of compatible to avoid child devices instantiation.
> >
> > Do you mean that, for "simple-bus" compatible we should:
> >  - Remove the recursive device instantiation from of_platform_populate(=
).
>
> That may be a problem I hadn't considered. While we've solved most probe
> ordering issues, I think some may remain. Even when of_platform_populate(=
)
> is called affects this. For example, I tried removing various arm32
> of_platform_.*populate() calls which run earlier than the default call,
> but that broke some platforms. (Looking at the list of remaining ones, I
> fixed the at91 pinctrl/gpio drivers, but never tried to remove the
> calls again.)
>
> Maybe this can be restricted to cases which are not recursively created
> from the root node. Not sure how we detect that. Perhaps no OF_POPULATED
> flag on the parent node? Or we could just enable this for OF_DYNAMIC
> nodes? That should be sufficient for your usecase.

Thinking a bit more about this, I think you don't have to do anything.
If child nodes already got populated, calling of_platform_populate() a
second time is essentially a nop. And for cases you care about, that
wouldn't have happened. Of course, I'd still rather there only be 1
path that devices could have been instantiated.

Rob
