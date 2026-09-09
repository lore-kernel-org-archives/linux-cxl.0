Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D58448B80
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944755; cv=none; b=iElKQJC0Y/UXq4nuckE7vSsmaphPEol6GseLKfZ70ZcImBurRuU0tNoy6Mmj33rs4+jh8yFY05mfSJrpfYL6xx/jnyjBtd842hKdMimMtiQqFjdGmZFhQNhJkQhpHk0DJi0zeDus+7Z1q1DkZX3F6qnYgbk5p0ZWdwJEcrL1tPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944755; c=relaxed/simple;
	bh=ReaMXwc2wrbtnGIzzccFig9moI+aYzLT2sJV31wZqwE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lek1g6ohiSRkiSJcrLb2mLX4Zj8AJCHpMD6+ORpsoAxtwENHWcL3cqDfCScGqZhfWDki+CpPDBwqzX7fchstYoS57/5CO/oc2mLLCv8C0qsMWUpdcDE56LVIEFrcZvOU6wYcodO1hKzCikE5QRuOicxx/cSTt7L66lFyv8Z2wQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwh9CtZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwh9CtZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712161F00ACA
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944752;
	bh=7A2lhD4vBmTBsUTDOlsEZ7tAto0p+g+2lDwyQEnjMa0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Qwh9CtZ60lcUh+6Vx3xu0PvyzAv9IEx8yP3Cj7vuUyEv5FS/Y/+V8Sid6Y0ulQVIw
	 xDIygxcP6doTXnIudr7mumozD63paDikWLkOCF5/pP+q1MaKzswb1+QHzn+8WAugOk
	 WO9BHV2U3smZ8kou9g4qE/vxK3R/+0+hkEbbcJsooHaPTy7Yeh1DVXrYj6f1N288Fv
	 v4uDD8Wo/qmbbrwRlLgg4/rWktY29IJa+rsY11mzr4jrQkTJg1pH+d8TDKWN1QyJL9
	 U0gZaRoKQvpUillXIc6IWZO0uCEelTLoQPToCs+VQJ1TDUi9oHAAqRx+vYd2I4UAu1
	 HXJjTig5WPvXg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b4a9994c20so5911743e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 09 Sep 2026 02:05:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxmavrlgQy2+zDKzNEnh2wIvodY8p6Vdp9OfZFmHHjNPA9RCgEaEfbXUOhjgr774NqvjgUKNKt4Rak=@vger.kernel.org
X-Gm-Message-State: AFuF++l7dmX8+R+Qi4s/QDedLqNVBXtJRuo/HlsKT6aVBf8mj9IlpB43
	Hv4mT3TlLsZS18ADc89znhBXzu0SJvbYeLHQl7vay/Ohud0K2JgUrgwy3D4yVeJmnPuKNShTQ7m
	NiklAb+x+zENUByurKCEwcDcSYIxn96KG8qdKYuKxXg==
X-Received: by 2002:a05:6512:839c:b0:5b6:172a:c3ad with SMTP id
 2adb3069b0e04-5b6172ac8e2mr3931277e87.23.1788944750950; Wed, 09 Sep 2026
 02:05:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:05:49 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:05:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-3-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 02:05:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc1ePP2nZkHij9Y4fX336SG=h2fzyy8tEQEtvHQr2fiqQ@mail.gmail.com>
X-Gm-Features: AcwNN1WKTbmqgMCh7V872_4tRwDJEAMS-fOBWcNn9vbiedgRsODRtFcaFT7QPGc
Message-ID: <CAMRc=Mc1ePP2nZkHij9Y4fX336SG=h2fzyy8tEQEtvHQr2fiqQ@mail.gmail.com>
Subject: Re: [PATCH v11 02/10] drivers: core: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
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

On Wed, 9 Sep 2026 10:01:01 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a1..3268e9350c86 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3754,7 +3754,7 @@ int device_add(struct device *dev)
>  	 * device and the driver sync_state callback is called for this device.
>  	 */
>  	if (dev->fwnode && !dev->fwnode->dev) {
> -		dev->fwnode->dev = dev;
> +		fw_devlink_set_device(dev->fwnode, dev);
>  		fw_devlink_link_device(dev);
>  	}
>
> @@ -3929,7 +3929,7 @@ void device_del(struct device *dev)
>  	device_unlock(dev);
>
>  	if (dev->fwnode && dev->fwnode->dev == dev)
> -		dev->fwnode->dev = NULL;
> +		fw_devlink_set_device(dev->fwnode, NULL);
>
>  	/* Notify clients of device removal.  This call must come
>  	 * before dpm_sysfs_remove().
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
