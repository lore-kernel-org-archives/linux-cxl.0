Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F837F8B5;
	Fri, 15 May 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873093; cv=none; b=Pw9v+XUDscSrheGxhv5vCaOGEw9Jza94Nz1EJ5SROvdEYsiZsYObNO1yuJWiqrJs6JyzaFsDYmXLcNzsCrQirCHY+ie5H4nL0oSkQR4TdWLZmdsuxdzCTYg0mvxIbgQIM0PNB1lkBHiZsZoGX3Isd/f0cYPMrrzUqyw0FyNeEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873093; c=relaxed/simple;
	bh=qkL5BU4SVPfijSEsBHt+KCBpDD8E9GXUmBpu3uHNoW8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PRymkm6HIptwXwKqR6Up5EXk9+DGYJ8rv+cpaA3rCmIutml8LR7pvujXLb2FLnJHcA9ZlFjyZUTZ6efKmuz9z2ZiNo5/eqgDjx+2hmM+wA2WKbihP11srkZQheiMZNcwHLd0RZZ09CzoZ5ML12FfYmh0RRvskblg1LVpJahmTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIo+hYXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIo+hYXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55939C2BCB3;
	Fri, 15 May 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778873093;
	bh=qkL5BU4SVPfijSEsBHt+KCBpDD8E9GXUmBpu3uHNoW8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gIo+hYXwHYsmvyj/Q0HRxGHgFySAf7RntKmVPNv5+fv3HqGWyEoA2xTHnNXkZzCFT
	 ccuvttH8j4SjiTBj2+W4JaSEz4clARpQd1bKlq2zbRo7TvUeK70nX8gElW4NFYBwu5
	 6sDUcj4goJXZZrSLj8lfFx33hhDMDkFSP9NxuJNCOoXbuAqUBQyqT3oo+x6oRDgedy
	 wgpB8bivHwLKQ3CS561AwlghLneAOrit2AG0ftyCDyhKvjwgIFDq4K4uQQl451owlb
	 lrXrhyjbEp31svxQSwf/pM6hbMwlMj5uLXHobA03i3uudV71LZvJeL3Vx12ISZXUqA
	 8dqfFvcSTo/1Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8BEFDF4006A;
	Fri, 15 May 2026 15:24:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 15 May 2026 15:24:51 -0400
X-ME-Sender: <xms:A3MHapdPbW3pG_Swiqk66IPDE40OOjQuKBZ-Qzeft0B_aZ0mO_qckA>
    <xme:A3MHaq6ABrxJk1v2n3Dd4NBKdpOYYtjtYHzQmrl7JrL7zxqEJK0Z57vCTx0cVD6qW
    nvgfqJjImY4idL0ImpgBN8dgK1hnLpzAkQDylzTtowk7Z8KxAk5VJI>
X-ME-Received: <xmr:A3MHarJrQDI52ywON0akHVLToDZYKrs-9-yKgWMIT42DhXo_OZm-6PE7FIo8zrybRxnvXro5MXiGk5uM3CtZucmrcW06Yj17mPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedvgeehieekteelueffueehfeejjedvjedvveetfefgffev
    hedvuedvffevffdvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudej
    jedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheptghptdeiudefsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepihgthhgvnhhgsehnvhhiughirgdrtghomhdprhgtphhtthhopegrlhhi
    shhonhdrshgthhhofhhivghlugesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvg
    drjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvgesshhtghholhgr
    sghsrdhnvghtpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhrrgdrfigvihhn
    hiesihhnthgvlhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A3MHakUOyBpSCPPk2SsF1GVLYccv01xElG1cJLkTv8aIJgnpeaDjYw>
    <xmx:A3MHanGZBkGYLVNL8dP130VcD41MceInCzQI65KwYnbw4HB-pDKk7A>
    <xmx:A3MHaj4a9a2aC3pEnuKPgxveZJS0YHoX4I4e4OfPR2ahRMwq-gu18Q>
    <xmx:A3MHatdzkx54fp3LhDESKhRPWkViNsbXiRzA01NCzlD_RWJFIAPSVw>
    <xmx:A3MHann87_tnKd39PgYB7_jXm9CBg7QbOMMo9BBI9rvDMYLmDY4hs4vA>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 15:24:51 -0400 (EDT)
Date: Fri, 15 May 2026 12:24:50 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>, 
 icheng@nvidia.com
Cc: alison.schofield@intel.com, 
 cp0613@linux.alibaba.com, 
 dave.jiang@intel.com, 
 dave@stgolabs.net, 
 djbw@kernel.org, 
 guoren@kernel.org, 
 ira.weiny@intel.com, 
 jic23@kernel.org, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 vishal.l.verma@intel.com
Message-ID: <6a07730211b81_a6174100c8@djbw-dev.notmuch>
In-Reply-To: <20260515134652.15486-1-cp0613@linux.alibaba.com>
References: <agV2e28XjW7yOUwH@MWDK4CY14F>
 <20260515134652.15486-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is
 not ready
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Chen Pei wrote:
> On Thu, 14 May 2026 15:31:11 +0800, Richard Cheng wrote:
> 
> > > On some platforms (e.g., RISC-V and ARM64) that use the generic
> > > pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> > > acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> > > In this case, acpi_pci_find_root() returns NULL, causing
> > > to_cxl_host_bridge() to skip the device silently. This results in
> > > incomplete CXL port enumeration on first boot.
> > > 
> > > Fix this by detecting the case where an ACPI0016 device exists but its
> > > PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> > > a deferred probe retry.
> > > 
> > > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> > > ---
> > >  drivers/cxl/acpi.c | 26 ++++++++++++++++++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > >
> > 
> > Hi Chen Pei,
> > 
> > Thanks for the patch.
> > I have a few questions and suggestions regarding to your changes.
> > 
> > First of all I would like in which scenario did you encounter the bug?
> > Any specific CONFIG options and the devices ? what's the error log ?
> > 
> > It would be nice if you can attach it for us.
> 
> Hi Richard,
> 
> Thanks for the review.
> 
> I'm currently working on bringing up CXL support on the RISC-V QEMU
> virt platform with ACPI (EDK2 UEFI firmware). This is still in the
> early debugging/enabling stage.
>
> During testing, I found that cxl_acpi (ACPI0017) probes before
> acpi_pci_root has bound to the ACPI0016 (CXL host bridge) device.
> RISC-V uses the generic pci_acpi_scan_root() implementation, where
> the probe ordering of acpi_pci_root relative to cxl_acpi is not
> guaranteed.
> 
> On x86, acpi_pci_root uses subsys_initcall and binds very early,
> so this race does not manifest there.

If the platform is defined to defer PCI root scans then this dependency
must be declared. Specifically firmware needs to tell Linux about the
dependency given it does not order PCI enumeration before ACPI0017
enumeration by default. Something like: 

  Device (CXLM) { // ACPI0017
      Name (_HID, "ACPI0017")
      Name (_DEP, Package () {
          \_SB.CXL0, // ACPI0016 host bridge
          \_SB.CXL1,
      })
  }

...in the firmware, and then:

acpi_dev_clear_dependencies()

...for each acpi_pci_root_add().

Then ACPI0017 will naturally await all of the ACPI0016 devices that the
firmware knows about.

Otherwise EPROBE_DEFER and scanning for ACPI0016 attachment is
introducing a mess that _DEP was meant to solve.
