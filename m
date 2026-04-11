Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BC23C8C7
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775939644; cv=none; b=CboatMYXVHkPhlOkB3xUsLQgB2uuaQ/8U4ZZ3spdn0k2GW6L5S/CSPERq0T+iWMU6x/OTxLEX44rfI/RFaAukdWPt2nxUetzCk4TsQIe73ND27iYtitc7YnPTjbAM7FFa7KHMqj1vtYdoTAFGblhsu/fzWD61Wbh8G7LkGJCX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775939644; c=relaxed/simple;
	bh=app2aui8UEOrRvZgTU8XLr+WPmeAVSBWqCVffZeBF6Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WlPWnsmwty/u8dtfSuxcnLSzk2QTuPBr/pI4900xEQwP2MMpu5Vxi5kj/oZXt1bvGEm/qh1BSKUqwPqu40K2TBAqS2/OHRoAA8gOF7Fco9jSVGDMLqjUsBpVM4+AOaJfyKk/lLjcNnaX3r0f4gLKA3GA5jIVLuFGowy8AtqFrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpe/bv6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpe/bv6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E68C2BCB2;
	Sat, 11 Apr 2026 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775939644;
	bh=app2aui8UEOrRvZgTU8XLr+WPmeAVSBWqCVffZeBF6Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jpe/bv6I0nRUxA2Vgw9deSuWrTT8DiKmv0NvZRJYmpQui26doiEycDTjljilPB7bN
	 ZiDibNnwk45k0KMjLjytf9IbNuz6CnEJbt/iEOeVX0Mh3EDbfkuMzIavMVXwS8UWTr
	 umBfWH4S5jz+TKMRZsGjiGC+NLwjED2DQAEiKK9frJZQNLNN0BQRaQlR2qn/Ux44Es
	 gU8xYFXq5RKuHuLkGTvSYULTFRxVJfTwdCY48zEgiF3Z6ar0rrxBaDvyA1djpxtQrD
	 FF7B6Tv1qyeasYzVlr0cFQCdTCqdTPCD07UAINh7Ukghw/kIjCtvpHiFqr0QUkiOoj
	 5SLSb/rfD3ldw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86DC3F40068;
	Sat, 11 Apr 2026 16:34:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 16:34:02 -0400
X-ME-Sender: <xms:OrDaaX1Ne3YYo53nrg8urcajCVzkbmSox_8BfVgbsR10tPkleCbevw>
    <xme:OrDaabAB5xwWHk1Akb45Xo0TsgVeedABWNTdOuH5pv3uRv4C5rf1IOF5KyQFlJNqC
    AtvjaJinMBAj6XF5xA-jYw4nBMkDsi2hJh_NGzSpbxWNXJRiM_89LM>
X-ME-Received: <xmr:OrDaacIHoIkDa5y1et5-O6jUZJ5unFo_4qj8s41RJnDWPoxPrSFcQ4PSUfWUgAqpRTo3EqzAfT5Epb9luPw-gox37ytCSUTlvEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhn
    rghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinh
    hugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegurghvvgesshhtghholhgr
    sghsrdhnvghtpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpd
    hrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhr
    tghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpth
    htohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:OrDaaclPldSnOxdHDbASWk6qMBllT-Uzh8ucQwwTo_KHO-euJ2UbFw>
    <xmx:OrDaadaKlE0vGSEWPSI99KbWEYW2i8J6o3Vl-EAflNSjbAqj-kJieg>
    <xmx:OrDaaQ9ID4ZmUZD__gfIg7v8oi7R_OtWsTIy6Iy7l-3OPeYngvLkoA>
    <xmx:OrDaaUZhubI7y8hJ7LvPRDIuxo6nAO76XH6R4ZL2Wr1gQLo1uaQ4Qg>
    <xmx:OrDaaSdQUDdYE3oXVeD3bBQtDIn0zcx4PgYPEDRQIiApRNCSZ7WT0xZP>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 16:34:01 -0400 (EDT)
Date: Sat, 11 Apr 2026 13:34:00 -0700
From: Dan Williams <djbw@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, 
 dave@stgolabs.net, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com
Message-ID: <69dab038caf54_46de10051@djbw-dev.notmuch>
In-Reply-To: <20260323150847.00002e6a@huawei.com>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
 <20260323150847.00002e6a@huawei.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Sun, 22 Mar 2026 09:16:36 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > core/region.c is overloaded with per-region control logic (pmem, dax,
> > sysram, etc). Move the pmem region driver logic from region.c into
> > region_pmem.c make it clear that this code only applies to pmem regions.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
[..] 
> > +static struct lock_class_key cxl_pmem_region_key;
> > +
> 
> > +
> > +/**
> > + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> > + * @cxlr: parent CXL region for this pmem region bridge device
> > + *
> > + * Return: 0 on success negative error code on failure.
> 
> FWIW the lifetime management in here feels way to complex to me.  Not
> a problem for this patch and I'm not immediately sure what we can do about it.
> 
[..]
> > +	scoped_guard(device, &cxl_nvb->dev) {
> > +		if (cxl_nvb->dev.driver)
> > +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> > +					cxlr_pmem_unregister,
> > +					cxlr_pmem);
> > +		else
> > +			rc = -ENXIO;
> As an example. If we happen to take this path... Where is the device_add() undone?

Yes, but thankfully this a leftover from "cb9cfff82f6a cxl/acpi:
Simplify cxl_nvdimm_bridge probing" where the "!cxl_nvb->dev.driver"
case was obviated. It should not be the case that this can end up with a
disabled "nvdimm-bridge".

Still more complicated than I would like. I believe that this should be
able to rely on the same base unwind logic as other regions and memdevs.
I.e. region comes down on either CXL-root removal or any member memdev
removal. Just not clear that this reduces complexity vs just refactors
it out of devm_cxl_add_pmem_region().
