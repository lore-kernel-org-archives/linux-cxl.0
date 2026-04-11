Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D932BF4B
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775948557; cv=none; b=ELGaI3lht7/zSVmMGmkrCdBvVCZpcg0Xchwa7xxVuqisXi1pUygP1UHJ6atI78KMcKro2JsMIFX06LKTs6lf/gx/l3gtDZqrq6pUeXC02iZufRq7u2+U1VXKUxccfMg2Xr8M0nrjK+nWNXWi10hjzAIPop5XCuaqg0B3JOAjedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775948557; c=relaxed/simple;
	bh=5CUnoaDm/f0C0we/UpikDShp/IU32vwibTNzk/jhn/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HI9hZ+eIUEINxEUFXFk/0NWeUZTtyygaR2drqolTcqgJXePlgrUUmqPvOxWeN9JzhA/N2Mihr+5tPexeVddZaVVwl4VAciPbUAIoqnrNckGUp3F1AvNHyfQzfyRHqaJ0KElgB0UR8689dPUi+baj7CheGX+CC3oU/r+7lo3vK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWkmiGnT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWkmiGnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E109DC116C6;
	Sat, 11 Apr 2026 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775948557;
	bh=5CUnoaDm/f0C0we/UpikDShp/IU32vwibTNzk/jhn/U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nWkmiGnT1EqbaKCVGjdJMhJ3pzIEzLzLyYUgWSbK17mkCBf8fYx4qrgwkX9H5eed0
	 eOiuAx+dcf7bxCn2qtwTKpuCKpNksj7a6etcuuo7ZaVi29dTGCVU0wasWijhQWN9DY
	 aPGxTaHt7higbE417ZHGUn4ZcFdj75BajQNSd+3kll7VKpSfmZ1CeQWR30duDngCAE
	 iYOl5fV8tOPDSB09WJFAWgOvvWd0Rx5Xw/2zOTmeDsEWGfqbaYrqGdPi/8nVnDqkya
	 LwJOmutS51rDDxR16+ng1EQtKeAFf5AEDw72tSR3XK7IWomRqzaQLiqhWHVSJhAO60
	 aYWXHB88haRlA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id E5CE8F40077;
	Sat, 11 Apr 2026 19:02:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 11 Apr 2026 19:02:35 -0400
X-ME-Sender: <xms:C9PaaWRM6X4O_HSyvRWxUcfbBieIzd7Q3yIaImVmf0gUla3HBa0qrA>
    <xme:C9PaaVHOFKx9tgfFUtwbO4Ayydn3I1j219XhjjbN869pojQMXIf2yt9JwNUdknrMN
    HjHEgN5LgFYx61LeWnJaZOy8O_ponXwxLEbR1XK-D0fPGrpkS4COzg>
X-ME-Received: <xmr:C9PaabFtWs3CQoxVu3TeEgnG49KLyK1a2IEFRuhn2FAiSA-GREb-fkz4AXBsx8TeA_aKUcQfR7qd13VzF1XyheZfsXdmvF6hchg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghn
    jhgrmhhinhdrtghhvggrthhhrghmsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvrd
    hjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgt
    vghrohdqphgrlhgruhesrghmugdrtghomhdprhgtphhtthhopehluhhkrghsseifuhhnnh
    gvrhdruggv
X-ME-Proxy: <xmx:C9PaaTTZadqmfQH06OTNML7Bt1_GJKj8Frt5nBJQVHu2q616KPWs0A>
    <xmx:C9PaacKpLnqqmdvkguOtFsgvbeLV3MJBkUc8M4XJJIoAdxV1Zkn2Zw>
    <xmx:C9PaaeaXCKxsK2d1hY6u3nFws7TVQkjgtKrjtBEHStou3SPD8aNc_Q>
    <xmx:C9Paae8sbV_wHa1Ma7cQ490M2xUcJC0hLElplBXmnMhTSfNEMnqBUA>
    <xmx:C9PaafZJ3vRo25oof4jyM7oN7p8HGor7MIz0yiY8vsCjpI_8dhybpqWJ>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 19:02:35 -0400 (EDT)
Date: Sat, 11 Apr 2026 16:02:34 -0700
From: Dan Williams <djbw@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, 
 dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alejandro.lucero-palau@amd.com, 
 lukas@wunner.de
Message-ID: <69dad30a614d7_fdcb41008c@djbw-dev.notmuch>
In-Reply-To: <59f69b87-e37e-44c7-8c15-c332118622b5@amd.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <59f69b87-e37e-44c7-8c15-c332118622b5@amd.com>
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[ add Lukas ]

Cheatham, Benjamin wrote:
> On 4/3/2026 4:00 PM, Dan Williams wrote:
> > To date, platform firmware maps accelerator memory and accelerator drivers
> > simply want an address range that they can map themselves. This typically
> > results in a single region being auto-assembled upon registration of a
> > memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> > parameter to retrieve that region while also adhering to CXL subsystem
> > locking and lifetime rules. As part of adhering to current object lifetime
> > rules, if the region or the CXL port topology is invalidated, the CXL core
> > arranges for the accelertor driver to be detached as well.
> 
> I'm probably missing something, but where does the core detach the
> accelerator driver?  I assume it's part of unregister_region(), but
> I'm not seeing any driver_detach() calls on the accelerator device.

It happens in detach_memdev().

> I don't think there's any demand for this at the moment, so it's more
> of a "food for thought" kind of thing, but why not allow for a
> fallback mode of operation instead of detaching the accelerator
> driver? First thing that comes to mind is an optional callback as part
> of struct cxl_memdev_attach that is called by the core during CXL
> removal. The assumption would be that an accelerator driver that
> provides the callback would clean up all of its CXL usage in the
> callback then continue in a PCIe-only mode of operation (hardware
> willing).  When the callback isn't provided, you get the behavior in
> this patch. Again, this isn't needed here but may be a nice
> middle-ground later on down the line.

I think that is possible, and also is not really a CXL specific feature. A
capability to move resources in active use by drivers has been proposed before
[1] (credit: Lukas).

[..]
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 11bc0b88b05f..090f52392b20 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1123,6 +1123,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> >  static void cxl_region_setup_flags(struct cxl_region *cxlr,
> >  				   struct cxl_decoder *cxld)
> >  {
> > +	if (is_endpoint_decoder(&cxld->dev)) {
> > +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +
> > +		/*
> > +		 * When a region's memdevs specify an @attach method the attach
> > +		 * provider is responsible for dispositioning the region for
> > +		 * both probe and userspace management
> > +		 */
> > +		if (cxlmd->attach)
> > +			set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> > +	}
> > +
> 
> It seems unfortunate that you set the region lock bit here and then
> immediately do a check to set the bit again.

There are 2 different cases to lock the region here, presence of attach, or
presence of hardware locked decoder.

> I can't think of a way to leverage cxld->flags for type 2 in an
> ergonomic way though, so I guess it's fine.

The flags are just caching hardware state, I do not want to have drivers
play games with the flags that dilute that "cached hardware value"
meaning.

[..]
> > +/*
> > + * The presence of an attach method indicates that the region is designated for
> > + * a purpose outside of CXL core memory expansion defaults.
> > + */
> > +static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
> > +{
> 
> I think this should be renamed to something like "cxl_region_is_private()"; it
> better matches the intended use of the function while lessening the burden on
> a non-type 2 educated reader. Also has the added benefit of being one less
> change site if the mechanism for determining if a region belongs to an accelerator
> changes in the future.

Why does the CXL core naming need to cater to accelerator vs expansion
use case naming?  CXL core developer needs to understand all the use
cases and wants to make them unified as much as possible.
"cxl_region_is_private()" says nothing about what "private" means and
where to look next. It also muddies the namespace for when CXL regions
start becoming the backing store for "private" nodes. Is that a
"private" region?
