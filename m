Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91654857A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953484; cv=none; b=rng3koObUPxA8BgGhlZ1C+GKC5Ig7y0gqe+sziVZNj/C6fIG8QK7r0EgTwCIUIC03xSUHlSWLatozPQhR/auwgkq2goh0WbqOUNtqzmM9bM/NLD9bv+l0Ml7SF8f8e012Hzz5sDdewMXe8NqOrezCDWJsPPeozaGouijURGeykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953484; c=relaxed/simple;
	bh=o2WzF/t6msWU5RqpBykSw0CS3QVZFDpT8yngxr1mCgg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbtOjTyTxP67Sq90s4VMfrmCv1leDyTekXbnjix8GZHEPEJ0ReacjTr34uzHh/IdOyf1O8kPRJOPBaF8zDdOdJt3mk6SwVFIZiwCQnRik3xeYTbdkn2FaQwCSldQ1WwBKnit9MqSsnIbGoOFXd2pcpQYpam12lgnJA1dmC+F12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsmHXN/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsmHXN/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB71F00ACF
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953482;
	bh=FmBocDloVqnt9fxeDtFrylQPpruprCsSKsABIgX1uUA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PsmHXN/1LmSL5vjfxnfPlVVh5V675dSmFSqIG6JW/RYPOTF5y8DKg6bl7BhyFSak9
	 6fvpPc3M1/2396QwFRzzIvx0vQ0D6Xjr2KNQ1X1uLmCiy6+VXSQwSuZP3V30CJvSmF
	 6VbHRzrZ9h/7nXFLXQMwv2pxcDph4ncKNcQfLLBMRsN3+RyUWRfkbSMa5so4kn8Bhv
	 NpQpyqbhLnd3QgrVQU73eg6Mz/KcuLL/fMVavoknnLupa152kuE+zgjgkYPZXRxHjE
	 sTYD/aOidLVBRLe2eM2xE3wIobz2ug0NJCNoVNX558avRipg6y64ppo2pd0eWtLNR0
	 WCgZwInf3Tdqw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b81a2d33f7so376732e87.3
        for <linux-cxl@vger.kernel.org>; Wed, 09 Sep 2026 04:31:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKJqpzlEL7WTCHj9HIQk9y7BB5j5B1O/tuPFs0etiEb1m4B0Cx1IZaL6D6z583/q60M2YeYQnISyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l9fFIVGexMMs0wFytUuEAOPNdmJSEqoPrbuP9cVQFo4DpmqBR7
	5A7JfGLpXclQAQiotyFpcYs9bLaDT1gvRNk4H2ezoNH4O8knicvE9fNY8R0OCIECDbMTkTn3gb2
	fiNxyB77BsDOkrR27wgubGoc9OfPnksp4G0ItfBsE/Q==
X-Received: by 2002:a05:6512:250d:b0:5b6:1a7c:59d4 with SMTP id
 2adb3069b0e04-5b61a7c5a90mr5183400e87.46.1788953481262; Wed, 09 Sep 2026
 04:31:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:31:19 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:31:19 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-8-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 04:31:19 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeF1+1L1qO3NkHgK-nA8T-LmY3qJ=yA2tsT7_nDEmpTOQ@mail.gmail.com>
X-Gm-Features: AcwNN1X-SYpdTDZqvUUX2vYKitA7KsBPnLzmy5HJ0ZvOyOzbEwFGKRa35FuLPsw
Message-ID: <CAMRc=MeF1+1L1qO3NkHgK-nA8T-LmY3qJ=yA2tsT7_nDEmpTOQ@mail.gmail.com>
Subject: Re: [PATCH v11 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Richard Cheng <icheng@nvidia.com>, 
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

On Wed, 9 Sep 2026 10:01:06 +0200, Herve Codina <herve.codina@bootlin.com> said:
> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
>
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
>
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
>
>     if (dev->fwnode && dev->fwnode->dev == dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
>
> Because dev->fwnode has been cleared earlier, fw_devlink_set_device()
> is not called and leaves fwnode->dev unchanged. This fwnode device
> (fwnode->dev) becomes an dangling pointer.
>
> If any reference to the OF node is held after this removal, the pointer
> is still accessible using the OF node (np->fwnode.dev) but points to a
> freed area.
>
> The exact same issue is present in the of_pci_make_host_bridge_node()
> error path leading to the exact same dangling fwnode->dev.
>
> Avoid this dangling fwnode->dev pointer by clearing it in
> of_pci_remove_host_bridge_node() and in of_pci_make_host_bridge_node()
> error path.
>
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
