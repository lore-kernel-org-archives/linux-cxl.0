Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB48393DF9;
	Mon, 24 Aug 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613123; cv=none; b=M4rsq/wjgVAuMj1fCZy1aAxSlHP1SAWOZN4qZWqgD8FpzpX2YrKvB8gxSs88pdMr9X494f0JUS2cNc/zTPdUD5Drt5hXSMhUBVz6cmwJsjFLoucTW1iia5fCVHQNrm1ES4nemtrSlmlAluhRDuPYA1bZMp8HmRAQwCnDU0sEtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613123; c=relaxed/simple;
	bh=Qg/KAF6vMHRBHEAm8EWUa4+/ztkAJU75HM7EBrkVVww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSK0HVALHBrjRhCa+4KHsbLbIwNiNfx3Vwvt2CaLQxepyTM2OVxj8Xtekivs0t+ZQeRfBkizlMZ6hqr0Ah2uL0WDzMX8VGqMhrHfLWipLjG4CL3SiCGidSFq2aKR2pcT1qPLuuoQL0/CQRbxfhSHL83/Cy3VsPJuA3sClYIVKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkKxu32I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkKxu32I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE721F000E9;
	Mon, 24 Aug 2026 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787613122;
	bh=SIrc6riXRNjLPSzUIT2mELl5yJPLjRRKFZ0MdfitrzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gkKxu32IOxEnysjskJQzEaQT6qn+cYvetuAsCL5VmjcBqGFWdm8D7aICDRBP3J7GK
	 8A0yetVfGskenLWJgfzjTkrylC+6+GijAKDNcr50/zRfY8AEUzfGO9trGmGHnLB78p
	 jngSbFdtYvFSoxnhHObieB1V/J+X3OlDv55VODOQZPcXdOrDFPDGEGu0dF0kmbccnk
	 WT3fjgt4QWe2pCxjB1+t5Z8+ksa7h6eWdwlKjs78K5tQtJ0iI/LoTnRWbFIS4Y9pFW
	 To/BclS/wQdx6Drp33ywxQ7JPo2UsbM0vlqFwTHOIrhLTe1y5spJcgGPWXZhyKQnwC
	 9yiJiAeQ6DQrw==
Date: Tue, 25 Aug 2026 00:11:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com
Subject: Re: [PATCH v4 07/13] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER
 guard typo
Message-ID: <20260825001150.351e7a24@jic23-huawei>
In-Reply-To: <20260824174936.939059-8-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The guard reads "#ifdef ACPI_APEI_PCIEAER" rather than
> "#ifdef CONFIG_ACPI_APEI_PCIEAER". That symbol is never defined, so the
> extlog PCIe AER handling is always compiled out.
> 
> Use the CONFIG_ prefixed symbol.
> 
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Yikes.

Raises some testing questions. I guess a last minute edit perhaps.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> ---
> v4:
> - Corrected the Fixes tag: e778ffefa34d added the "#ifdef ACPI_APEI_PCIEAER"
>   guard, not 95350effc3ad.
> - Dropped Reported-by: sashiko-bot; it reviewed this patch rather than
>   reporting the typo.
> ---
>  drivers/acpi/acpi_extlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 3aec73187b51..ebedf3b136a8 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity, u32 len)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct aer_capability_regs aer_regs = {};
>  	struct pci_dev *pdev;
>  	unsigned int devfn;

