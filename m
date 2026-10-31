Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473826;
	b=abfu64nclCFQjcZQKU7wqtah2jViSU33hZ/dwwjejASRnMIB/AFK6sK7wE6Z4hAKR1n8
	 uWWqsbjAeYPj4MacAfGxbqtla6LGct0zPY2N53siwf8gqnIqD51NbsynbMfl0SA9DLD8Y
	 KLz5rRh9jJ5PxIxKiWiPUQh6ZePWuxWSdPAgQ2audXTkBqpmSIVdDbTiT+pdOq7AJrQET
	 gXXgavTdmXxRdXpuxwAielBhvTf5mcAe90HmyFJi0Jximz77on55aTHEyAEJXGcxd/tcQ
	 3oc/K3icIutcwBSLv0nz1ts/NO1Z0IGiMapVNezITb8+sRQgpqfTaQ35ifnCGk6uCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
	b=lKD1v1ssVu7Ct97IPR4PVOTIFWxSMjK1bYmGIghcvTxpQbaT/2e3FNgNOtzxL2RRClRI
	 1NIfbx03vG2pIvlRetRrrfMRQbZV0QAujHL+6DvfmbLgtB3sG0RXal8c1lp1/DE1ygfAa
	 //A2Sc00kvMnp9qqYEaRjE458BCMZwzTWlRLvcprhK5cb7CBgP6xO+7BWZ9UhdzLsSoiw
	 PD6NMcjnvafpFRU+/v7y40VoF2jWGePee+GzmZFQQLwed395bxaEKVCH0ZTUwePPrgYVM
	 1Kvps6+73E0L/qj/9cpIoBjycBUku1olPglYgOfRxpJBJT3b5SjnMc3KO4/5uAWtlZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=M0iRGKX4;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F26606A31F
	for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 19:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F26606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=M0iRGKX4
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-353804b591eso2919079eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1793473825; x=1794078625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=M0iRGKX4ZakyHPXgwlWKQuWrbvUmrEt1k4+8j+Da6Dso/Dh7GSCRhGjVKtDYwfzJrj
         2HEAllh00C24MUCD82TGUaZz4bWnjiMTRhAzuWXvWqNUwh9NIMyFAIxSoJmQ4tgmhnAF
         F245HULIR/4UBpfnm4XNgJVWo0HiMpt1bXAuHbkJDG9vLis8pelTxr1WpUiwasUmrW+0
         9tOkzQntOI0UA8bT96YYn1nh7WxQBJCWb1rCljfbu4Ofk4oPQ7yUkax5ncCroyqti4PR
         O+aX72UPS59IWB8w+y+J4RXBJLyCiSRq72tVighCAw7INgBmnyi41FWHKGgDOpB397rH
         f/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473825; x=1794078625;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=A9rDVl6U5fB4PQya+5F8/bJ+YBxM95dowNSQvUJAn+VyCL7K4opUW0r7dcpCt9jv7F
         9xwgSUp42ecmCRKMeBhTr4IpHrNyzYDME+736l1PyJKou85g5XDzBK6PaEs4Tih4m2/n
         EslvOhfRbUFAz7dt2CuhJNCet9h6ZA1qurUJ4TuL9SkKM2z+v5896wzb9N0hMTt7Q8Wh
         DeYaFhB9C1h8jjzHkZGXyRk4zgbBpFos9+xpYZGcnR+O4FtoFT419U0gMjiZD06wgCSL
         M2u1RGdMagqvC+Tnkk16YTeX+3gEYWDwO8mvg/lk5O+UUkyrVdECj9EmjCNRoKRbKtSe
         /Eag==
X-Forwarded-Encrypted: i=1; AKwUvBxxYPT3SZYO2HUZ/rbF6kiwU58Ut60wDO/frHYQHlehHI+p1T+EsGeIqZdhKq4zSF2tmfIqM08PA/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8Mz3AO3/61JX9o2bTmZG4lp6uyTk2iWQnctwfDRVFtwTRnwRi
	oDixbF2IpTV2EyxKA3OOqtCw47YAi96iU4uu7UpTr7wXTh5buVgOSO6hnFhO+ifP2jE=
X-Gm-Gg: AYBFou2593MPglJUWNb6MUIjch3VxNPmy1rzmdM/x3NGPevDB3Rt/bZhOfKYRwUlqY9
	31cn5W0VyGrvMEImOmYcqvhoxWg1RV+8u8dhhqWXJIAHWvxHJUetxOWYd4/khbIdA0Kq7ikM8Ep
	PpeJL8rncvJREEP9wNSKql4Fz2IvmRO0Slp3+V78aivGXXlVQhhN5IeBG4U6qdG/1SYPGVNjIQA
	sPJswXGJhK2sz4YmpYNxCrYCJhgHkCCRX/DCcMIpB5xILd0oJ56EQFm8cK3UrA4yrhqNtB7mmcp
	efS1q68HAdaaBnX6WFl9nQf9Jpb8QyJum2VFC+5BDt09Qo/r4WgDSe+sGXyAs/MGO6inK7Noje8
	7DGI8e+PVS0JqUv9cLUFJLvHs216WLSy4PR/gm7LRyMuYx1rnJX4icLQssj2cA27382E3iT2fH2
	SnaS4mm3F3QbHi3MjDO0bu7GzCVad1coE2GEB7BHAaVP7bTo4NFMmd8tycbvFud1CIk5xU05qpR
	8buZ9o8Fyir4OkNe8J1g5IT6r7MCrIB+1T05tkgH1lC778kNiceZ5DKJ6o+vLgG725hKFNPnR8D
	BjGZu4iwglpDYhVSwI6L7TgfHm2blWj4SogFY1cZlw4X446HKtM=
X-Received: by 2002:a05:701b:4515:20b0:166:5552:780a with SMTP id a92af1059eb24-1ac5b028b11mr7948547c88.8.1793473824427;
        Sat, 31 Oct 2026 12:10:24 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm17384804c88.23.2026.10.31.12.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 12:10:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 12:10:22 -0700
Message-Id: <DMJ9ERWOMF5G.3KVDIP2QE3A7J@nexthop.ai>
Cc: "Richard Cheng" <icheng@nvidia.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 "Richard Fitzgerald" <rf@opensource.cirrus.com>, "David Rhodes"
 <david.rhodes@cirrus.com>, "Linus Walleij" <linusw@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Len Brown" <lenb@kernel.org>, "Davidlohr Bueso"
 <dave@stgolabs.net>, "Jonathan Cameron" <jic23@kernel.org>, "Dave Jiang"
 <dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Dan Williams"
 <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, "Li Ming"
 <ming.li@zohomail.com>, "Lizhi Hou" <lizhi.hou@amd.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Allan Nielsen"
 <allan.nielsen@microchip.com>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, "Steen Hegelund"
 <steen.hegelund@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v13 00/10] lan966x pci device: Add support for SFPs, PCI
 part
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Herve Codina" <herve.codina@bootlin.com>
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herve,

On Mon, Oct 12, 2026 at 04:28:14PM +0200, Herve Codina wrote:
> Patches 8 and 9 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.

We hit exactly this on x86 switch platforms with
CONFIG_PCI_DYNAMIC_OF_NODES. A driver applies a device-tree overlay
onto each Xilinx FPGA PCI endpoint and populates I2C controllers
(xiic), watchdogs and GPIO blocks. Their interrupts go through small
chained irqchips that are themselves fed by the FPGA's MSI vectors.

Without this series, fw_devlink drops every supplier link under the
synthesized PCI root bridge node ("Not linking ... might never become
dev"), so the irqchips end up with no consumers. Unbinding one of them
frees IRQ descriptors that the I2C controllers and the watchdog still
hold. We get a remove_proc_entry "removing non-empty directory 'irq/N'"
WARNING per IRQ, and the I2C controllers are dead until reboot.

With the series applied on v7.3, the device links are created (up to
32 consumers per irqchip), and unbinding an irqchip now unbinds its
consumers first. I tested on two platforms, with 2 and 3 FPGAs (4 and
7 irqchips). Repeated unload/reload of the irqchip driver was clean
every time, and everything probed again afterwards.

Tested-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Thanks,
Abdurrahman
