Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448348;
	b=H57XEQPePtCIVAnwr1D9KcZ3u60P34gQXk/GQefUcvoNFBM2YP4Ayp0xjudMImE6Q3df
	 MrF1n4NaO6DII6NkACiht1BE2kG7hFw87AlkLTq4cIXYJP/Fls5mD+DpFzpUSG7N9iIzJ
	 UPKasBZsnp1sYkT+3+stiXLj0/3VTCsFYQ8cHClhwQ2PFZ51z19P78TNx9cWE6YS6jael
	 XJBuDO83vmLz/ojXeWM2ermTbDalF3GX916mSvFLJ1BGBgfk6dtvUvG9GL1uU2JUVrPNU
	 lkJEVxlPJoZkWt1dQZbFBjp5T7wm9BGcdqfDRGvcvwHnfE3g7S7ThL+wVBhsnJapkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448348;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ex5Qom/Novcw2Ezs+0SDNP42YlQeSwGPdXGV5r3koP8=;
	b=dLMnv/chXX8UiOoODZq0kRMtdCIkPER9ZAz2I29bULxR5hlaNjMXnrcP75XFdVl1LG5V
	 pGV3CFO0rkZUK/HpzPRpsIewwTw9eAfxbqGJvZ4W8P9lWsF6Kncw387CEyPu4/y3E08M+
	 fY1VsqTgYPRRrJo11XpJLk8/VWfjOV7mXif3LXEnstPmUBGRtdBD52W5YAryWizo4UZH8
	 kC9jl0XbxUidZVRqK+QIVRLTCwoYF3QpWnz9JLzRgHCMm2ZtHF7YyD3ZNAYrbOrcGvEsz
	 ZrVg2eyPGTyxQKSh2Ilg2cW4VTl9PEPj3EwkP9O7o5zjUQmC2097MOnLDuMUC+ARvaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSIaqQvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22465606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 12 Nov 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSIaqQvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5EC1F00A05;
	Thu, 12 Nov 2026 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448347;
	bh=ex5Qom/Novcw2Ezs+0SDNP42YlQeSwGPdXGV5r3koP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gSIaqQvSPrLL8zNH9NJpDDzGrryhZ0GQ2b5ZSQvEYAohsRxPqKVIC2zOKfQVf+TUA
	 AkM7mYcWgzumnleNwrQ2oeVMHcRIqcRq1Hm+QJ/vL1yACebHcWGYY2ZhfWRPBYmu9v
	 q0DiUhyIPxCN3FbJt/YWXY7sOzHqvPmeVcC2Dmzldr1CzrJb4RHIJLTKUJPujzNDuS
	 JU/hk1SR5tfMPmeSPXSckkV2rk5Ylg/7/mCuLm5yqRhtgu/nu9r7OLuspIRXhmNNgQ
	 DF5kfwmguvFfuNoiEAStTLxMV2KoTTgQA+sdvgQhm1fVjTMJfltzqa854K+K/5b3GE
	 W2Hh+kso5tKGA==
Date: Thu, 12 Nov 2026 01:52:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Yukiya Takaki
 <fj2110jc@fujitsu.com>
Subject: Re: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
Message-ID: <20261112015219.55bb312a@jic23-hlaptop>
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Nov 2026 09:28:53 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
>=20
> Hello,
>=20
> This series adds cxl-type2, an emulated CXL Type-2 device with volatile
> device memory. It is emulated in such a way that all the Linux checks
> are satisfied so that CXL passthrough using vfio-pci (vfio-cxl) can be
> developed and tested in a guest without Type-2 hardware.
>=20
> This series builds on the Type-2 model from Zhi's series (carried in
> C=C3=A9dric's tree) and carries one fix from Shuai's tree. Shuai's tree a=
lso
> set up the decoders through device properties and stubbed CXL Reset; the
> firmware setup and CXL Reset here are new code.
> Carried patches keep their authors, with a note for each change.
>=20
> The device:
> - PCI ID 1b36:0017 and the processing accelerator class 0x1200;
> - PCIe DVSEC for CXL Devices with CXL.cache, CXL.mem, one HDM range,
>   cache write-back and invalidate, CXL Reset and Mem Clr; Register
>   Locator and Flex Bus Port DVSECs;
> - CXL.cache advertised but not modelled. The device sends no CXL.cache
>   requests, and its memory is host RAM, which is coherent already. A
>   cache write-back and invalidate completes at once. The capability is
>   set because vfio-cxl takes a device as Type-2 only when it reports
>   both CXL.cache and CXL.mem;
> - component registers with one HDM decoder;
> - slot 0, function 0 below a CXL root port of a pxb-cxl, memory in one
>   fixed memory window selected with fmw-index, cold plug only (no
>   hotplug or unplug), not migratable.
>=20
> No Linux driver claims the device on its own. cxl_pci does not bind to
> the accelerator class, and sfc, the other driver that calls the CXL
> core Type-2 interface, matches only its own devices. A guest binds
> cxl-type2 to vfio-pci, which hands it to vfio-cxl. Testing the CXL core
> Type-2 interface without vfio-cxl needs a driver for 1b36:0017 that
> calls it. There is none yet.
>=20
> QEMU has no firmware that commits the HDM decoders of a CXL route at
> boot, and Linux attaches a Type-2 device only to a committed region
> (devm_cxl_probe_mem()). So QEMU does that step itself.

Just in case you missed it, Yukiya Takaki is looking at bios programmed
flows.  https://lore.kernel.org/all/cover.1793003983.git.fj2110jc@fujitsu.c=
om/

My immediate thought is follow a similar flow to the one I suggested
in that patch. Doing CXL setup in QEMU but the PCI enumeration in the bios
doesn't seem like a sustainable model to me. I'd much prefer to see a bios
flow with just the QEMU generate tables updated in a similar fashion to
how DSDT is updated for PXBs.

Alternative for you (assuming you care more about arm than x86) might
be to just use the SBSA model and do the full enumeration in firmware.

Unfortunately I have quite a large backlog so might be a while before
I get a chance to take a close look at this series (or the kernel ones!)

Jonathan


