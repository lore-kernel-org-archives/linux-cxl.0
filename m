Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A83DDDDD;
	Fri, 29 May 2026 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069917; cv=none; b=NYcyYsbyz5x3hHnzoxgK/i84TXqVE3faSdRDeuSMnNP5w9nVy6mNCflBxklTtJg3oKJRYwKQdra857j39zHuoX1LpT3sYjxZDRbkbAfxM2QRR5E83KGLXn32ZGciowNV0EXk2ezev4xJrFWiUfBbZssiFjmY7LVzKt6slu7IWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069917; c=relaxed/simple;
	bh=GTk9LYoCxbt8zYoKRFMot45nFI7Q2oAgpJ7vlXNwq5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIOD9YupA6YfNhnZK7udM+e6gahahD7Qixpe9r+OGZYt8Tq1FuSvZmpJ1tUQftYmcTGcbuUzTBk7EgfBJtZsCWFKZ92jV/7qkctiLgiSxr0AyPUNaOrpBOwbgzNxuIixRyiE66cqpRPeV0yDG7vd0kKL5qiZCVPnFLQjYNQi/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeZ68ouW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeZ68ouW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3021E1F00A05;
	Fri, 29 May 2026 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069913;
	bh=7yqtQVPXwcWR3ybe8ddbUaUI+JYT3+ddN0veNYVOM4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aeZ68ouWftToQr80mwZCwNLEwvgjKh/e5hfldpXX+R8HdOxIvpgVft23bsbxnxKuR
	 yq/E494ckkkKm14enuR2mI6eBuwWNlz3u/K0OvrjKhyUOO/K5G9KHJ1L0xmpf2XM4n
	 dClKZah5qaaZ6KC5lMfldlgbqV2066b0ouUq9PenREfJkyN6+fakrqnf3gpiDJ2lgG
	 tk6Hmerw6hG9nT539jQV1EYJrPjeEv5Pj9mUtcA17Yz2ktKNEsFJrpcEe2E5gmeQQX
	 L5IoJ1kRfnsqcYphAEzmFkPzpC/aQuQQ5mj9/16ktW6bYVifGvIPo3xcDe0LJm8a8j
	 ydD+IuaTxoD1A==
Date: Fri, 29 May 2026 16:51:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 02/10] ACPI: APEI: GHES: move CPER read helpers
Message-ID: <20260529165137.0cd56e6e@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-2-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-2-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:42 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
> ghes_cper.c so they can be shared with other firmware-first providers.
> This commit only shuffles code; behavior stays the same.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

A couple of things I noticed whilst quickly scan through what was moved inline.

Move itself looks fine to me.
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> new file mode 100644
> index 000000000000..7bb72fe57838
> --- /dev/null
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -0,0 +1,195 @@

> +
> +/* Check the top-level record header has an appropriate size. */
> +int __ghes_check_estatus(struct ghes *ghes,
> +			 struct acpi_hest_generic_status *estatus)
> +{
> +	u32 len = cper_estatus_len(estatus);
> +	u32 max_len = min(ghes->generic->error_block_length,
> +			  ghes->estatus_length);
> +
> +	if (len < sizeof(*estatus)) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
> +		return -EIO;
> +	}
> +
> +	if (!len || len > max_len) {

Obviously this is just a move, but that if !len is silly given that will have failed
the previous check as 0 is definitely less than sizeof(*estatus)

Maybe add a trivial patch to tidy this up and any similar oddities.


> +		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
> +		return -EIO;
> +	}
> +
> +	if (cper_estatus_check_header(estatus)) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Read the CPER block, returning its address, and header in estatus. */
> +int __ghes_peek_estatus(struct ghes *ghes,
> +			struct acpi_hest_generic_status *estatus,
> +			u64 *buf_paddr, enum fixed_addresses fixmap_idx)
> +{
> +	struct acpi_hest_generic *g = ghes->generic;
> +	int rc;
> +
> +	rc = apei_read(buf_paddr, &g->error_status_address);
> +	if (rc) {
> +		*buf_paddr = 0;
> +		pr_warn_ratelimited(FW_WARN GHES_PFX
> +				    "Failed to read error status block address for hardware error source: %d.\n",
> +				   g->header.source_id);

Whilst you are here I don't think anyone would mind if you fix the alignment.
Looks like it's one space short.

> +		return -EIO;
> +	}
> +	if (!*buf_paddr)
> +		return -ENOENT;
> +
> +	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
> +			      fixmap_idx);
> +	if (!estatus->block_status) {
> +		*buf_paddr = 0;
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}

