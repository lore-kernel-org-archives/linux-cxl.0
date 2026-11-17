Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880380;
	b=x92Sd4jy6i2JygP+iJxl+sRD4jwAvsxsL0OnqyiB8TqI07D7Sqmy44TYw59kkWAFJJYC
	 YQYF1g/5G8zvmVrxCSV4bd0YZ1TAq/U6TTRDtopUg/zR62ev3EAnjrgd9upj8TVqTd77B
	 NzQHqmLSnkEDc+Z4Uk2VxK4zfKH+oHUm9SKZMLQ8gdUt+p5jrHxhHl/+SkBE8LdUz6Sct
	 AV6vI4ncsXjSURAnthCWTETMQGebNwSWeafYtb1PRAMHgvz31lYMleg+m+GYJ25zPlriq
	 H4tXibz9FkxIQ8g5HaLkdS/wcuVUdI1Y5qo0BB/f44fPIEDqLffVsY09vmS3a1t+TDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GcWgNr/O5cWvnHTRiNP0WXv+Dt1GHult5mUfs1zM2x4=;
	b=uTMAdCj8OeUatOn5bJgsajHUuIHtriTN63WZ7RHfvwWbR62COz6lQ7WnJW+bm3MejG9I
	 0KqDmavGx9tmAtWRPxZUdIhWmkeGyEZ+OJxfwnFXIG28zs0M8UcAE+3e5nHMsBxyaXNIo
	 dRPDu3EmY9zk81c6Qg9F+NWjW9M4i9nzJ3T/i7IzvGAJRVAw0wee6YpKnIGJ/g9QgDugl
	 wrO2P3AbbO1puoi8M3TkEqnKpN3CDD9I38A1EAj1zYLLKbyThfOcbZADtEk5kjsNmBZAI
	 DZBigajE672QyRAx34hS9cK4XesfYdmzc/j46puKRSHMa/pT18LCCB+h/1NHMliydOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgRxZAj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B9606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgRxZAj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02E1F000C4;
	Tue, 17 Nov 2026 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794880380;
	bh=GcWgNr/O5cWvnHTRiNP0WXv+Dt1GHult5mUfs1zM2x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YgRxZAj0Ew34GqKsk2UmIUIx3Ulbw9M8mbab9Owtb+hIi/Tc7oKExRJmb391g8F7J
	 eVjyBHR6kVA4g9v5M7xeOoLzDwXHFr8U8ZWxXfRZk5CMLr67wWl0eVeofpND8EaM+j
	 1ZZua034APyPgNqpUCUN72lo+bffcnNq94tAVbpgkT5qtmdoXMezTqEt5ChOm3AXk3
	 V9hhphKylk9jVHNtbTG7P5QrkapathHawqkwqjIu0IwDdaACMFoojo4bO3jsxMWTAv
	 +3G9WaecpCMuqxN1/Yr4O+kCpWFFIvULEx3qHna/kWJaMIBqZWZfWJVvY2vn8KSU/y
	 sOgjYhG4U5Qzw==
Date: Tue, 17 Nov 2026 01:52:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>, linux-cxl@vger.kernel.org, Sashiko AI
 Review <sashiko-bot@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] cxl/region: Carry the effective interleave state
 through target setup
Message-ID: <20261117015252.61d95088@jic23-hlaptop>
In-Reply-To: <e99646b0692e6e01b2f71c6a80cc664b0066db57.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
	<e99646b0692e6e01b2f71c6a80cc664b0066db57.1794010889.git.alison.schofield@intel.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 16:35:00 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> Switch decoder setup derives interleave settings from the parent decoder.
> A passthrough decoder's granularity is a hardware don't-care, so using it
> can cause auto region assembly to reject a downstream decoder whose
> programmed granularity differs from the calculated value.
> 
> User-created regions instead store the calculated granularity in the
> passthrough decoder. Below a 2-way 16K root, that calculation produces
> 32K, exceeding the hardware limit even though the decoder does not
> interleave.
> 
> Carry the effective interleave state in each port's region reference.
> Interleaving decoders establish that state and passthrough decoders
> preserve it for descendants. Store the state because a later endpoint
> may be the first to reach a descendant of an already configured port.
> 
> In both paths, passthrough decoders report the effective granularity
> inherited from above. Their interleave_granularity ABI permits this
> because a single-target decoder never rotates.
> 
> Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
> Fixes: ce32b0c9c522 ("cxl: core/region - ignore interleave granularity when ways=1")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Suggested-by: Richard Cheng <icheng@nvidia.com>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Just one trivial thing though I'm relying on your tests (in the patches
that follow - always rely on you testing well ;) to a degree rather
than chasing through the logic in detail.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>  
> @@ -1589,6 +1602,9 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
>  				cxld->hpa_range.start, cxld->hpa_range.end);
>  			return -ENXIO;
>  		}
> +		/* Report the effective granularity, not the firmware value */

That needs a rewrite as not coming from firmware, coming from a register
(that the firmware programmed but still!)
 


> +		if (iw == 1)
> +			cxld->interleave_granularity = ig;

>  /*

