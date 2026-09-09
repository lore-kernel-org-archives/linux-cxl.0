Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E517475334
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989511; cv=none; b=FTr4bi0z0M9mgM7UsZCQQkjtl7feV/htnxYDh93LuISrtPSXcu8HSAUI5lAneKK4KtWrcIHLXAGYwOEML4mMT++LF3IrCdarJc1wJdAq+FiQOFK9b+5BJV9lRwRDH3oiPI8NunDcorim+lIOXfTBnGYSVrME3HYnBANFu0YeTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989511; c=relaxed/simple;
	bh=6HSjKhcLQj48Y8VUpvbA3LBkS+qlBaA/2Hpk+t0O1kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USyKWH4wfmmn3Vkzv5dOi7I8tGraFr5DKH2MzXGbPAMiLyWjhjNVtxNrL/vp8npnWrng0t1y9N/8Hlg1UpsId0C/IN0W3ru7l5wRaVJgylRO9z7bQfmlSSzkMxyoYtWLqI8paWKF6KXQFmlkTVCvfFO5hYm2AVpNyYubcLHNuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsPkcGC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsPkcGC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8454E1F000FF;
	Wed,  9 Sep 2026 21:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989498;
	bh=NR56uELVVH1qeukejJisA0GFZtVv7ya2XP8A5KOrEh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bsPkcGC2x3g6W4H4rbo95hsVxO5FQfYJpSLG7mTrzvRTnHmgTiE7F4GzB1DLR6D5r
	 h9hfnEyv8ulDpc1OHdighif9kHYQEFjrDOyhRHGLtb3RpD5KKUINjLD/mMI2Vd0h9G
	 PfzZAdjlRnpRotHarPIed6j3kDdWUPJ2SNO4HTiu2mVk42OLcy6mN0IqnP1CJ1nqcu
	 z9eAdXXbhrksn9NqOuFyQJ39XgDlFc0t/ewnM9v5mxd17bKKvn1gnwstDZVRHAi2ng
	 HqQaXe5dBUOdmuYAIpLTnao1EWQhYputgCyK1rzUs91UUqP9hinyUSpUOPD3ilI0UW
	 MsCWoUkRcbSHw==
Date: Wed, 9 Sep 2026 22:31:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 04/10] cxl: Add HDM-DB region creation
Message-ID: <20260909223133.00bb7b0f@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-5-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:56 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> A region inherits its coherency from the chosen root decoder: HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
> 
> cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
> model at all (neither Device Coherent nor Host-only Coherent), one that
> sets BI together with Host-only Coherent, which the CFMWS definition
> calls undefined behavior, and one that sets BI without Device Coherent,
> since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
> therefore always exposes device-coherent memory and nothing else.
> 
> Surface the topology through read-only sysfs:
> 
>   - decoderX.Y/cap_back_invalidate (root): CFMWS BI restriction.
>   - decoderX.Y/back_invalidate (endpoint): '1' when configured for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder(), restored to the endpoint default on
> detach, and to whatever it was on a failed attach: a refusal may
> come before any inheritance, for a decoder another region owns or
> one firmware committed, and must not relabel it.
> 
> An HDM that reports Unknown coherency support is not rejected.
> Supported Coherency Models is how a device declares whether Target
> Range Type is writable - Host-only+Device Coherent means RW, a single
> model means the bit may be hardwired to it, Unknown declares neither
> - so refusing Unknown would also exclude devices that support both
> models without saying so.
> 
> A Type 3 decoder defaults to host-only and inherits device-coherent
> when it joins an HDM-DB region, which requires cxlds->bi. A Type 2
> decoder defaults to device-coherent and keeps it: an HDM-D region is
> only assembled from a committed decoder, taking that decoder's type,
> so no inheritance is involved.
> 
> The HDM Decoder Control BI bit is set at commit time for a
> device-coherent decoder in a region under a BI root, endpoint and
> switch decoders alike. Whether the device has BI enabled (cxlds->bi)
> is checked when an endpoint attaches and again for every target
> before a commit programs anything, since a reset in between
> invalidates it; the refusal is the same in both places.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Subject to you taking a look at sashiko's reply (or maybe
having addressed in an earlier discussion)

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


