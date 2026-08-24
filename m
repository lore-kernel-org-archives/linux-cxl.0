Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9266395243;
	Mon, 24 Aug 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612736; cv=none; b=u/ktgVjDSGHQ+Ql5U/wDUHEz+zQcSh10ahfe02Poavj0jDEunUCf6d8pivNux/dhcKfP3qoMCJuEpddwSN5nIZu/oHJrERa0m8phSjU3oReV3lTkAXIeXVaH4vBHfcm5map9F8AHWOD5zrrX7bwbf/gy4Mvh/SU4ugOBWxaLbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612736; c=relaxed/simple;
	bh=SyPjddcppk/zcV/Vwhu9n8DimLPMpB2jYQTOhWQR7co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpjWRh6OYe/Fp4jHQE5sulfp9cJmzxrY6KX+t9jAiv6op74AWkawycywN7FXEWihxHbp/oRJOWHJkciNRA31Xb3RSa8f0rUYg+BhsLeUp9E1/jZpmr99pZnC7D1EuSXM8upNKow/mcyeXfy7KIETuKLxwlBCBEvX7QHgZuJoPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMCZO58x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMCZO58x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD191F00A3A;
	Mon, 24 Aug 2026 23:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787612735;
	bh=CS9dEX2lfRDsUiC2sWmQlOPAW8M6cLVfufSRpHpfBog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jMCZO58xlqkRYZkXNr/9TvGLI6UAckBBfXEk4P7NSeu5LdQAZFf6oknXyV5m277tn
	 0UszbbpRsRFiOTRpnWtrVtJClRfG6DI9cX0mNuje1fwgExKK2uh6bfKZqxOyLxVsih
	 /53jguMrqAwdI0Vce6PTAl2GHVOltYww3E7CFkRQYiJ/sWiwY9vO2Yb6ErZ4QtahzV
	 C7GnoCLa5qvBYmj9zXr7fcxWBsVnOqHAdP040F46aW/Vk1ftr+pvxT9+kpJdvX64KJ
	 +215Sql6r/DIxyHwI/ChPvTMcXU1Gyvo1N7KhnntTxyB4IS/9gcG/EDfAy8FEgwsp/
	 m+yAOn9GkdMEw==
Date: Tue, 25 Aug 2026 00:05:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Message-ID: <20260825000523.3ab0d33d@jic23-huawei>
In-Reply-To: <20260824174936.939059-6-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> extlog_print_pcie() casts pcie_err->aer_info straight to struct
> aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
> software-only header_len and flit fields sit at offset 84 - inside the
> 96-byte aer_info buffer - so the cast fills them with raw firmware bytes.
> pcie_print_tlp_log() uses both to bound a loop over dw[], and a large
> header_len walks past the end of the array.
> 
> Copy aer_info into a zeroed local struct aer_capability_regs and clear
> header_len and flit before passing it on.

The existing code is very odd. It might be nice to clean it up more
generally so that we can handle the rest of the aer_info buffer
via a definition that matches the hardware spec. 

For now I'd be tempted to just copy the bit of the structure that
is matching the spec - side effect being the rest ends up as zero
including the two things you clear.

So just copy to first 4 dw of the header log. 

Jonathan



> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Dropped the now-pointless aer pointer alias.
> ---
>  drivers/acpi/acpi_extlog.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f6e3da4e13e7..6d5532ec0920 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -137,7 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity)
>  {
>  #ifdef ACPI_APEI_PCIEAER
> -	struct aer_capability_regs *aer;
> +	struct aer_capability_regs aer_regs = {};
>  	struct pci_dev *pdev;
>  	unsigned int devfn;
>  	unsigned int bus;
> @@ -149,7 +149,11 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  		return;
>  
>  	aer_severity = cper_severity_to_aer(severity);
> -	aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +	aer_regs.header_log.header_len = 0;
> +	aer_regs.header_log.flit = false;
> +
>  	domain = pcie_err->device_id.segment;
>  	bus = pcie_err->device_id.bus;
>  	devfn = PCI_DEVFN(pcie_err->device_id.device,
> @@ -158,7 +162,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  	if (!pdev)
>  		return;
>  
> -	pci_print_aer(pdev, aer_severity, aer);
> +	pci_print_aer(pdev, aer_severity, &aer_regs);
>  	pci_dev_put(pdev);
>  #endif
>  }

