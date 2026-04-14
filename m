Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D531E82F;
	Tue, 14 Apr 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139722; cv=none; b=Dd57iDuJfFOf4KGAIrfsw560Qsc8tk5yJ9jPaWNfQqwA45hT0Q078cjYItSHEIS02LHx86GOpoivJ/ZvHeGOoQEW25RQFUR9etd4QMY71B/aw9lAk9H7t2pGkX+rrCjnkztyQ+fZ321azoTQvBbv6dumQvcfboYllny7eFJlpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139722; c=relaxed/simple;
	bh=ARztGMrXZDnZhS58Mi3ctqJrBRRWG54ZaEx1BBLdL4o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NlRRaAFzSIEj6hsFwbQ3NwwObBH823Qx1qUb6YH1kmY0Fo88ropYVfKsRKNIZZmkQHehJw7s4SbHftYQMflz1NSAiYz3D+D3ZyROH6tAg/K+NN6jEZ30qjI8xbkRc10xAMQGvG8sdfNciw3k2xmSK2bl6LuMdGgTrASHZsJoeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyohq9wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyohq9wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B2BC2BCB6;
	Tue, 14 Apr 2026 04:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776139722;
	bh=ARztGMrXZDnZhS58Mi3ctqJrBRRWG54ZaEx1BBLdL4o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Dyohq9wz3rm78p93OCsju8nvFU97xmlAwQ+978AI66Jo8aZwDpaxYTqC3hlAU8h9d
	 BkQPxTa/ytvCkHrZsYzC9wYJt9tZnHET+W6/9gvsjecgaejkk/LztxQK9Vier0IALN
	 qMPq63pmAGkWqu5knV/oCXO86jmfjqXPX8J9wAXoK+/O1Fy1884c7L7UDG4iGROgDN
	 /fjuma2wcD2BH656Mn3F1BFt+cwGrxWOdUn82t7Xsnac5ps/ar+M+Uif3FyvB45O7N
	 n+O2ii8kis84UGOEKgoJ42R0AgX3WTNw5fJVeOeBZ6obMe1UK41CbMta4QJ1XQlq/Z
	 w+gbk5kOcprVg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21C03F40068;
	Tue, 14 Apr 2026 00:08:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Apr 2026 00:08:40 -0400
X-ME-Sender: <xms:yL3daTlPLijkkyyUeqBN8wkwuqy56urmDvhxKgAjguSka0_XQGq38g>
    <xme:yL3daeVIaOXbeAl-Uwt0gM3ouDEbQI4pb0LaEB36bSVDHAv7oEW2evCPd1EjFV-og
    OZ22RMErIm028LfcCAKk0VoKk3UIUVtlccrwJNnYGh6mXb4YWNqpRc>
X-ME-Received: <xmr:yL3dafvdpLF-BAPT7cn5WiE20_vsNC2_YG51eQUj8P87zACKPDK5hk2mXOtAIVjgjwLY5DG9qC3LWvijoVL0t-sTgXu4yQLAir8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ffkeefgfdutdetjedvhedtgfehiedugedtleduvdfgveejfeetleekgeefteevvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhh
    ohhnrghpsehnvhhiughirgdrtghomhdprhgtphhtthhopegrlhifihhllhhirghmshhonh
    esnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhn
    sehhuhgrfigvihdrtghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlh
    drtghomhdprhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgtvghrohdqphgrlhgruhes
    rghmugdrtghomhdprhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvghtpdhrtg
    hpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhrtghp
    thhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:yL3daZoPt19xMCkTzTGKRk_mwfO_w48S877__1iFm33JImopiaucZw>
    <xmx:yL3dac7hmyRmCWkUFRm2Tzwzk6a8ERCWLyo6BT37jM8DpRZ8la669A>
    <xmx:yL3dafGLSa6YEnLjP9AgjdcN-7cmixRl8tE9AIziXKwhf67Arwo54Q>
    <xmx:yL3dab4F8i0WdrfAGtb2k1y0ewrlagFn9jlS7nu-YWX9fe3_RvhXLw>
    <xmx:yL3daaipqIzMz0E5AjryKYmXQEEbUcsHZpgOlJjRohm2ieM3O1EFub0U>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 00:08:39 -0400 (EDT)
Date: Mon, 13 Apr 2026 21:08:38 -0700
From: Dan Williams <djbw@kernel.org>
To: mhonap@nvidia.com, 
 alwilliamson@nvidia.com, 
 jonathan.cameron@huawei.com, 
 dave.jiang@intel.com, 
 alejandro.lucero-palau@amd.com, 
 dave@stgolabs.net, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 dmatlack@google.com, 
 shuah@kernel.org, 
 jgg@ziepe.ca, 
 yishaih@nvidia.com, 
 skolothumtho@nvidia.com, 
 kevin.tian@intel.com, 
 ankita@nvidia.com
Cc: vsethi@nvidia.com, 
 cjia@nvidia.com, 
 targupta@nvidia.com, 
 zhiw@nvidia.com, 
 kjaju@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 kvm@vger.kernel.org, 
 mhonap@nvidia.com, 
 Alex Williamson <alex@shazbot.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <69ddbdc62016d_147c801004d@djbw-dev.notmuch>
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Subject: Re: [PATCH v2 00/20] vfio/pci: Add CXL Type-2 device passthrough
 support
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Forgive me if any of the commentary below was already hashed out in the
v1 discussion. Your excellent changelog notes make catching up much
easier, thanks!

mhonap@ wrote:
> From: Manish Honap <mhonap@nvidia.com>
> =

> CXL Type-2 accelerators (e.g. CXL.mem-capable GPUs) cannot be passed
> through to virtual machines with stock vfio-pci because the driver has
> no concept of HDM decoder management, DPA region exposure, or component=

> register emulation.  This series wires all of that into vfio-pci-core
> behind a new CONFIG_VFIO_CXL_CORE optional module, without requiring a
> variant driver.
> =

> When a CXL Device DVSEC (Vendor ID 0x1E98, ID 0x0000) is detected at
> device open time, the driver:
> =

>   - Probes the HDM Decoder Capability block in the component registers
>     and allocates a DPA region through the CXL subsystem.  On devices
>     where firmware has already committed a decoder, the kernel skips
>     allocation and re-uses the committed range.
> =

>   - Builds a kernel-owned shadow of the HDM register block.  The VMM
>     reads and writes this shadow through a dedicated COMP_REGS VFIO
>     region rather than touching the hardware directly.  The kernel
>     enforces CXL 3.1 bit-field rules: reserved bits, read-only bits,
>     the COMMIT/COMMITTED latch, and the LOCK=E2=86=920 reprogram path f=
or
>     firmware-committed decoders.
> =

>   - Exposes the DPA range as a second VFIO region (VFIO_REGION_SUBTYPE_=
CXL)
>     backed by the kernel-assigned HPA.  PTEs are inserted lazily on fir=
st
>     page fault and torn down atomically under memory_lock during FLR.

I assume, or hope this means expose a CXL region as
VFIO_REGION_SUBTYPE_CXL, as DPA is a device-internal address space that
VFIO probably does not need to worry about. VFIO likely only needs to
care about system visible resource.

If / when interleaving arrives for CXL accelerators the 1:1 vfio-pci to
DPA to CXL region HPA association breaks. Ok, to assume 1:1 for now.

>   - Intercepts writes to the CXL DVSEC configuration-space registers
>     (Control, Status, Control2, Status2, Lock, Range Base) and replays

Range Base is ignored when global HDM Decoder Control is enabled. I
would hope that this enabling ditches CXL 1.x legacy wherever possible.

>     them through a per-device vconfig shadow, enforcing RWL/RW1CS/RWO
>     access semantics and the CONFIG_LOCK one-shot latch.

Linux should have no need to ever trigger CXL register bit locks. That
is only for firmware to make changes immutable if the firmware has
requirements that nothing moves for its own purposes.

Now, it makes sense to configure the vCXL device to be locked at setup,
but I do not currently see the use case for the vBIOS to mutate and lock
the configuration.

[..] =

>   - Includes selftests

Yay!

>     covering device detection, capability parsing,
>     region enumeration, HDM register emulation, DPA mmap with page-faul=
t
>     insertion, FLR invalidation, and DVSEC register emulation.
> =

> The series is applied on top of the cxl/next branch using the base
> specified at the end of this cover letter plus Alejandro's v23 Type-2
> device support patches [1].

One of the sticking points of the accelerator series has been how many
details of the CXL core internal object lifetime leak out.

My hope / thought experiment is that the initial version of this
enabling only needs to facilitate getting a VMM established CXL region
into a guest. With that VFIO only needs is the CXL region HPA and MMIO
layout so that CXL registers can be trapped and non-CXL registers can be
direct mapped.

> Series structure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

>   Patches 1-5 extend the CXL subsystem with the APIs vfio-pci needs.
> =

>   Patches 6-8 add the vfio-pci-core plumbing (UAPI, device state,
>   Kconfig/build).
> =

>   Patches 9-15 implement the core device lifecycle: detection, HDM
>   emulation, media readiness, region management, DPA region, and DVSEC
>   emulation.
> =

>   Patches 16-18 wire everything together at open/close time and
>   populate the VFIO ioctl paths.
> =

>   Patches 19-20 add documentation and selftests.
> =

> Changes since v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[..]
> HDM API simplification (patch 1)
> =

>   v1 exported cxl_get_hdm_reg_info() which returned a raw struct with
>   offset and size fields. v2 replaces it with cxl_get_hdm_info() which
>   uses the cached count already populated by cxl_probe_component_regs()=

>   and returns a single struct with all HDM metadata, removing the need
>   for callers to re-read the hardware.

What is the accelerator use case to support multiple CXL regions per
device?

In other words, it feels ambitious to support that while simultaneously
kicking the "interleave" question down the road. If we are going for
initial simplicity that also means single region to start.

> cxl_await_range_active() split (patch 4)
> =

>   cxl_await_media_ready() requires a CXLMDEV mailbox register, which
>   Type-2 accelerators may not have.  v2 splits out cxl_await_range_acti=
ve()
>   so the HDM range-active poll can be used independently of the media
>   ready path.

This feels like a detail vfio-pci does not need to worry about. The core
knows that the device does not have a mailbox and the core knows it
needs to await range ready when probing HDM. Something is broken if
vfio-pci needs to duplicate this part of the setup.

> LOCK=E2=86=920 transition in HDM ctrl write emulation (patch 11)
> =

>   v1 did not handle the case where a guest tries to clear the LOCK bit
>   to reprogram a firmware-committed decoder. v2 allows this transition
>   and re-programs the hardware accordingly.

? Guest has no ability to manipulate Host HPA mappings. A protocol for a
guest to work with a host to remap HPA does not sound like a v1
requirement. This would be equivalent to a guest asking to move a host
PCI BAR.
