Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6D3D1AB3
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945791; cv=none; b=hI2Tx1THKXFbJrgvwkS7w7R3k/toSOcnAEtTBUB7u8DSKa/RsK497Mhozvku6l9OcE+EhYxlS4C7xWG/WHzkn04mPrIvcJ1l2Wm0959qfM9bo92dyqoWLoaorPntdAjeEadEWElwF++FD0TnVKTCRtsJpBr6b4fcv7R5PTdTW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945791; c=relaxed/simple;
	bh=MDBBmeOGt1jJA2QyqYyZpKdJgVhokM9Hyvk+N6kJG7Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/+6fGGp1JDpZ+7XTzNXel323Jv4Ry4nxlamDFZ333QiT7PRb7W4k5NUnIcayj/HkLLJwputE08eszNid8NNuhakdQQqTG0FvbgrzK4wrUlydfwd7USAKmMr3GaSrKeMtjHLYWPnNgbUPxF/XVMMcOaf5xp6iLQQO7zaEOGLABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv8ei3Eh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv8ei3Eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D4B1F01568
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945789;
	bh=osuKNlWwkgDC1U1icT/Qoh45Es9k9O509Xjy31GoFe8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Xv8ei3EhJ4HgzbOdGsjteUPopCkw4XU2rkVeC9+Yfe1nKnNiNuCsJxA2oGOVTwAin
	 saUDbUkbRvVy4G8RMb+sD2xLpnoZ+wb5cFTZpHBb/r3XXd7BgseV4AD9YSzORRN1Qo
	 P6+hM6WkOb7MTC6McLuApcRQCfbbCx9L9oRk3VjEbTuhLzsp4hXtg3FOsuAsAody6o
	 OwWw9b+uJ7KWWbwXq3MgiXGRa4JZiV1mxJaSS7zepZzVlygSaortBcOxlQoHcOw9Zp
	 P8pkZZRMSUTymuvBe/OaVF0AQH8Bu8SUO6au2gniraylnozvssr9Ux9ggfAylFPJnU
	 VMchAFHffC2ew==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso326820e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 09 Sep 2026 02:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy710BYXeYj/ua2rVBf86Ubykm9qqiD2NtLP5xTklSl4Mz4TOEkaQtnbQZTbCdEv6iKSuwVOItd3MU=@vger.kernel.org
X-Gm-Message-State: AFuF++mtMzhfq4948tChWUVYAUTxmq0QKyT9Eq4HT4m1fjuMBJiBZ3nZ
	EzT3neTYcl2EjpFUE768R9mcfmx+ya49TXKq/BreqvdMTtYZCar+iWH328MZMWeFy+LNNAYID6S
	8/cw/9FSFJePMc2t/d8t9WlMPNVflk+hmUFbUaVmM4Q==
X-Received: by 2002:a05:6512:1286:b0:5b7:668a:e8cb with SMTP id
 2adb3069b0e04-5b7668aeb82mr414082e87.31.1788945788232; Wed, 09 Sep 2026
 02:23:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:23:07 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:23:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-6-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 02:23:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfqbjoARAQQ65fpwn8Y8SMXt7BAfvhtfzOj6iQUEYnAPQ@mail.gmail.com>
X-Gm-Features: AcwNN1WZ09Q1SV1ODjBdPMqkfOrJoPMMt-CtgzyA6h5c6HSsWVZpQuvsCQtR_OE
Message-ID: <CAMRc=MfqbjoARAQQ65fpwn8Y8SMXt7BAfvhtfzOj6iQUEYnAPQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/10] cxl/test: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Richard Cheng <icheng@nvidia.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 10:01:04 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly fwnode.dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
>  tools/testing/cxl/test/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 547ebc97bf59..e21e45fe1572 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1678,7 +1678,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  	device_initialize(&adev->dev);
>  	fwnode_init(&adev->fwnode, NULL);
>  	device_set_node(dev, &adev->fwnode);
> -	adev->fwnode.dev = dev;
> +	fw_devlink_set_device(&adev->fwnode, dev);
>  }
>
>  #ifndef SZ_64G
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
