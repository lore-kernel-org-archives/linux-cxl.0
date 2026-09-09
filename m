Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FA545DAA
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990341; cv=none; b=pvq7DNEe34cFaepYxDKru8+6Po0llO/7/Hh/VDI4cyX4CtmSX1L2TM+hmrpwEdtWm44+aRB9p2SWsXdHUt3D268ptAE4murXGYQyBCc16vstlrrIBG2G6eAmHtJjlqRxo3q7mj9eq3NTOBYynYqlZ9cUYpQzqw0MWJAle1C8rFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990341; c=relaxed/simple;
	bh=tU5e0uy4CBnUgfx0QXmd1613Qhs7zhQD23GoNBUA1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hysf/QPAAMDjDHNBzjoKe6FZnG3dLN3PZj2svXRMx5UanToZr8ZmeDOAkkalnXpgo3ZOedu0BVNe8kLm5QgwgsfVF1pVaTusOJLm10s7Xo9pbOld243DsQLs1XOZLbk9VENBJb7yrugW8Eskt3OIVApSCpVOFSzfmuYHgjKSAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oELwyuvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oELwyuvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4776A1F000FF;
	Wed,  9 Sep 2026 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990336;
	bh=p3JOqRNjEFRbAJJo0fUx8czrBAxh+zmthYlxriRAMdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oELwyuvnBIQbd8YmfTDjwq+XBVQWx6OsRGeBLqgFswF7178EZp3QcGVrwa3xlWf5v
	 Giu0tyNHGSC6rZ+MLzWFTb5u2g3nKvsXw+lzyLOCEd2w0Kd6Sfe8vJdG9jFMKJzKqP
	 TjC/OyekKd5e7Zz17CkzUNERTQ3Yi1K+kxNESn+agqsPxJ+KFvsjfNJLFxTNZaO/4B
	 mI0HvlaCu3I1VLT+acXrHnhxNnbh3Tgy6EOOrTqnH1u/aZeIZY8xVp7qVDsE/ebZ+j
	 m5OkTcRlYTtCCpKqyJSY5NOZwWyqk0k/cO58Wb9h53icC+sEq16lDxGQe1GDBhAcJS
	 u/r6V6r1AyRMQ==
Date: Wed, 9 Sep 2026 22:45:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 08/10] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20260909224531.2befc256@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-9-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-9-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:03:00 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Allow auto-committed BI hdm decoders on sane platforms, rejecting
> only broken paths (ie: one that cannot route BISnp, or BI paired
> with a host-only target range type).
> 
> The respective region creation is done like any other committed
> decoder - with cxlds->bi set by the time an decoder attaches.
> 
> Skipping the commit does not weaken the rule stated in "cxl/pci: Add
> BI topology enable/disable". Table 8-152 and Table 8-156 key it on a
> new BI device being enabled anywhere below the port, and a level
> firmware already brought up for this device is not seeing one.
> 
> Whether it did is a property of the path, not of the dport: a level's
> committed state only proves firmware committed for some device below
> it, which need not be this one. So adoption starts from the
> endpoint's own BI Enable - only a device firmware itself enabled can
> have had its BI-ID accounted for above - and a level is then taken
> as found when nothing this driver routed sits below it, the control
> value this driver would write is the one already there, the decoder
> is committed, and the switch's route table - which carries a commit
> of its own that firmware may not have performed - is committed too.
> The first level that falls short ends it: from there up the driver
> is enabling something new, and programs and commits as for any
> other device.
> 
> A committed decoder is refused when the window's restrictions do not
> permit its coherency model, on either axis: a BI decoder under a
> window without the BI restriction, or a host-only or device-coherent
> decoder under a window exposing only the other model (undefined
> behavior per the CFMWS Window Restrictions). Assembly so far never
> consulted the type bits, so a platform that sets them wrongly loses
> auto-assembly of the affected decoders, with the refusal naming the
> window.
> 
> A committed decoder cannot inherit a region's coherency model the way
> a decoder this driver programs does, so the type-mismatch refusal
> that "cxl: Add HDM-DB region creation" removed from
> cxl_region_attach() in favor of inheritance returns there for
> committed decoders, on both axes: the committed Target Range Type,
> kept as the decoder's target_type since enumeration, must match the
> region's, and the committed BI bit, read back from the decoder since
> the driver keeps no copy of it, must match the root's. The refusal
> names both models.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
I'm less confident about the flows where the firmware did stuff in
advance in general as never used them in practice, but far as I can
see this is fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

