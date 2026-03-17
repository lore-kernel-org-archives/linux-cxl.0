Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31273081A2;
	Tue, 17 Mar 2026 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782693; cv=none; b=mCPCMcV+U7OKZd7X6kqZmvQgP79bgByD4vHqf3ofnr5m0vi7KldYH9vWQR5JW4LOWB4Dz1Mr9EaDTr7CgJidsaya2Ad3Fjgux0tCicx3QlXhoxbbcdcPzZC1pqqui8ftnbQT1gdI2RkI3+snQ9WWsJOOwSvrVvQnPPI2TZ/FQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782693; c=relaxed/simple;
	bh=fyjW+SjlG0dtP6UuyaAG54lfNmKF8VYWoUaYk51k2SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJwYBJqAoEbr2hPhodSv2MMU78hdTyZJWt8escYbZ1RBFPTrlz9OmdxUByI0lnhdwFSl5CPvUmEk105xoCFn5fjyOPiCycwHs38ptO+idBlj2AbXqXPN4276y6e5fZJrog+AP3EVusWUs344Pw/McQ5hqLMBsIeDuIAdFYWeygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=UsUdJKxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbP5U1Aw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="UsUdJKxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbP5U1Aw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0042B1400103;
	Tue, 17 Mar 2026 17:24:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Mar 2026 17:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773782688;
	 x=1773869088; bh=3MZOnnp2V/38CG7PZGVwO0DWeBD5hMT+NJkU2Hm0nH4=; b=
	UsUdJKxY8ZFg+9ahVspXKEbW2QeMkScw1YdLM6G2zmZ33m0VgCCwoBWDKn74/qyS
	vJo/p+A5YbgsOprgc3q2a+MgTUATOmvZ/PCNfkHOQ6EDdIAiGAX09mtC49hg4M2W
	7hZYxfZLjybSX+cTNmnDUwTEPpSxRtE1WrJ8tFxNJB8eS2Fa2smwD8YrgFqCzKsG
	YqQCDto96RTwT1XeYZaC3PLSyfano9c6NptBi+1whxBZ/W/Mz5DGDH7h6Gb6v1Hh
	45VVuHgoTXq0VRWPeKPIvIQF7RApUMP7fjRGaFurc2qgBW1SvydfWSYywgbnKrJA
	pjU7qEoJvRK2vH40sEPGbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773782688; x=
	1773869088; bh=3MZOnnp2V/38CG7PZGVwO0DWeBD5hMT+NJkU2Hm0nH4=; b=U
	bP5U1AwoiZ6evdT4XmR2VsjwPTh09DQHRjqO4p+Yh1iCLYRDOUELwl5czV9ZHAd2
	Pgfx9D/9gbCvfUUVW1n4WMDg+YuctkitXTpZaxcfIGX8CQ6vWTgfx/lsLWBxH/7l
	LHBVq1AjhJidQey4kvqbNjZVTr41EH9fECUDLaLe6laebw42olnW6zxsQ9WDRMq9
	K2/OaEhflg79ZhFMBJbPUOXlLgx4MSFlDBs1kEa+BjEYo5FHSkeU/odKjJWXTMkN
	SXHs5Vg7yO5gsfZBmYSTFSCZ2IL2jiVU8e2pGdGs1sCXQ2dEkMMgcEX/kJZrsTiu
	NY83p6EtVv1DWcJRYoZHA==
X-ME-Sender: <xms:oMa5aWA6kq-bOhv_n7eln2DKThkR39B08JLNbBwxSA8Rzk1CJShpEg>
    <xme:oMa5aZkQpIs6AVqIGpFghy3HJTFnjaZk131gkGQWlT7Z9a2tNtH-2yoIwR3XVIsff
    isvCd5FnKsr6gdTq6IHAwgg8ToW_uCrh1do_iJNgFN78G5VtJHy>
X-ME-Received: <xmr:oMa5aSrkPNsAOimO7auv_2Y5Fc-uiQid4ODGby6HWb9GWwVx-6lq_Too2a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvdeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrghdprhgtph
    htthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghp
    thhtohepmhhhohhnrghpsehnvhhiughirgdrtghomhdprhgtphhtthhopegrnhhikhgvth
    grsehnvhhiughirgdrtghomhdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepvhhsvghthhhisehnvhhiughirgdrtghomhdprhgtphhtthhope
    hjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehmohgthhhssehnvhhiughirgdr
    tghomhdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:oMa5aQhhhfG9aUhZo77VHyeheHz3DP03XWOw0HsavGfeixfLYjb6Qg>
    <xmx:oMa5aUiHL2XOHzXqPyomLJaODK32CBKPux60D3O3THywga_bwSTOTA>
    <xmx:oMa5aeEA2NZ1D0_rlQpdtd46qSKWluxJTjHWwAMWYrx_5GoAGi8buw>
    <xmx:oMa5afBatq4xsoNCmS4Bw3l6PlqscDfjyqxNeuDXOjqsLPfCEy728A>
    <xmx:oMa5aRDcU-FvkadiB5VMaRO7jM_dsY0jj5bwCDBu8vJIDvjFnWlvY5Pt>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 17:24:46 -0400 (EDT)
Date: Tue, 17 Mar 2026 15:24:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: alex@shazbot.org, <mhonap@nvidia.com>, <aniketa@nvidia.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <mochs@nvidia.com>, <skolothumtho@nvidia.com>,
 <alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
 <dave.jiang@intel.com>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
 passthrough
Message-ID: <20260317152445.67a93881@shazbot.org>
In-Reply-To: <20260313121341.00001bfa@huawei.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-19-mhonap@nvidia.com>
	<20260313121341.00001bfa@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 12:13:41 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Thu, 12 Mar 2026 02:04:38 +0530
> mhonap@nvidia.com wrote:
> 
> > From: Manish Honap <mhonap@nvidia.com>
> > ---
> >  Documentation/driver-api/index.rst        |   1 +
> >  Documentation/driver-api/vfio-pci-cxl.rst | 216 ++++++++++++++++++++++
> >  2 files changed, 217 insertions(+)
> >  create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
> > 
> > diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> > index 1833e6a0687e..7ec661846f6b 100644
> > --- a/Documentation/driver-api/index.rst
> > +++ b/Documentation/driver-api/index.rst  
> 
> >  
> >  Bus-level documentation
> >  =======================
> > diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
> > new file mode 100644
> > index 000000000000..f2cbe2fdb036
> > --- /dev/null
> > +++ b/Documentation/driver-api/vfio-pci-cxl.rst  
> 
> > +Device Detection
> > +----------------
> > +
> > +CXL Type-2 detection happens automatically when ``vfio-pci`` registers a
> > +device that has:
> > +
> > +1. A CXL Device DVSEC capability (PCIe DVSEC Vendor ID 0x1E98, ID 0x0000).
> > +2. Bit 2 (Mem_Capable) set in the CXL Capability register within that DVSEC.  
> 
> FWIW to be type 2 as opposed to a type 3 non class code device (e.g. the
> compressed memory devices Gregory Price and others are using) you need
> Cache_capable as well.  Might be worth making this all about
> CXL Type-2 and non class code Type-3.
> 
> > +3. A PCI class code that is **not** ``0x050210`` (CXL Type-3 memory device).
> > +4. An HDM Decoder block discoverable via the Register Locator DVSEC.
> > +5. A pre-committed HDM decoder (BIOS/firmware programmed) with non-zero size.  
> 
> This is the bit that we need to make more general. Otherwise you'll have
> to have a bios upgrade for every type 2 device (and no native hotplug).
> Note native hotplug is quite likely if anyone is switch based device
> pooling.
> 
> I assume that you are doing this today to get something upstream
> and presume it works for the type 2 device you have on the host you
> care about.  I'm not sure there are 'general' solutions but maybe
> there are some heuristics or sufficient conditions for establishing the
> size.
> 
> Type 2 might have any of:
> - Conveniently preprogrammed HDM decoders (the case you use)
> - Maximum of 2 HDM decoders + the same number of Range registers.
>   In general the problem with range registers is they are a legacy feature
>   and there are only 2 of them whereas a real device may have many more
>   DPA ranges. In this corner case though, is it enough to give us the
>   necessary sizes?  I think it might be but would like others familiar
>   with the spec to confirm. (If needed I'll take this to the consortium
>   for an 'official' view).
> - A DOE and table access protocol.  CDAT should give us enough info to
>   be fairly sure what is needed.
> - A CXL mailbox (maybe the version in the PCI spec now) and the spec defined
>   commands to query what is there.  Reading the intro to 8.2.10.9 Memory
>   Device Command Sets, it's a little unclear on whether these are valid on
>   non class code devices but I believe having the appropriate Mailbox
>   type identifier is enough to say we expect to get them.
> 
> None of this is required though and the mailboxes are non trivial.
> So personally I think we should propose a new DVSEC that provides any
> info we need for generic passthrough.  Starting with what we need
> to get the regions right.  Until something like that is in place we
> will have to store this info somewhere.
> 
> There is (maybe) an alternative of doing the region allocation on demand.
> That is emulate the HDM decoders in QEMU (on top of the emulation
> here) and when settings corresponding to a region setup occur,
> go request one from the CXL core. The problem is we can't guarantee
> it will be available at that time. So we can 'guess' what to provide
> to the VM in terms of CXL fixed memory windows, but short of heuristics
> (either whole of the host offer, or divide it up based on devices present
>  vs what is in the VM) that is going to be prone to it not being available
> later.
> 
> Where do people think this should be?  We are going to end up with
> a device list somewhere. Could be in kernel, or in QEMU or make it an
> orchestrator problem (applying the 'someone else's problem' solution).

That's the typical approach.  That's what we did with resizable BARs.
If we cannot guarantee allocation on demand, we need to push the policy
to the device, via something that indicates the size to use, or to the
orchestration, via something that allows the size to be committed
out-of-band.  As with REBAR, we then need to be able to restrict the
guest behavior to select only the configured option.

I imagine this means for the non-pre-allocated case, we need to develop
some sysfs attributes that allows that out-of-band sizing, which would
then appear as a fixed, pre-allocated configuration to the guest.
Thanks,

Alex
