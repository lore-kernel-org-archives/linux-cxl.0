Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C073F9A1B
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881912; cv=none; b=tn/xeDxgKTcG3lTiTMRwwWnv4y52rc5mxUYjKNLv90n4wVMF4oJcXojj/yRjflCbcgFc43W7WVRpCM77PFmeDfXILz60l416CoHB4AvVmJx1D2ZfjvKr/fNdG7YSddNmaQgE3jevAE5GDNEOo/Fx26NpYq5FHz/CUNLrUU74SH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881912; c=relaxed/simple;
	bh=C/JDoMskpVNUsPhkPS1ppZP++rW/kUPM4ELPNhRx98k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSdMe62V8MPB7hyRbEGf9HBUze9iemY1Wh2O7wT6japzUYKf1e8O7BB1OKJd3SAQR3H5CcVVUionzTw27baJBeI/cAwZZ1UAp4POQ8FvobgJRwHvznBDn1G5o8dFzwNWu+IBbhDgQz7WsRUY4QDdcosxA/dPzSRBM+C1v7J5qEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw1LLbVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw1LLbVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073A71F00A3C
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881910;
	bh=DDPMa0fdpYJQTQJTQSaNefV6P/6fs1Q+aFlsuPZjNBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dw1LLbVcXywjKYCjPXZ2/WQpWvJn0ucy2t7lgvUtZhMLatIy27176C4BofkwkmN+B
	 ypBpx04v3BPZtzRjuYjdfs++wjiL8dtrzo7dw/f+XJCs2QuVZ0w1hstznPcM2efuLr
	 5ZY3Rk/FWvFH40g2THak4JohTOKE60WBJDwPXMcbE3OmFaySAoaHNuygBL1Bo7yZtv
	 o4G0Tbx5cdHlAmIAuQ1Op3UUIOnTm+uwecZyNG6kx5BCBciVP/XRoboE0AzMGyEd/L
	 H5Q5rT6mJ+rSri5DEiuT0Y2XDBGFrlaYkeOnJi5yLqIaIT9V6FI7fdO0mUlIQg0ijo
	 19JAkItuXfA/Q==
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95fa7cd1392so8840905241.2
        for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 04:38:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/WlBBwjzMcjIVBFCnZEWgjaT07tzXk/lWT3gt38AH7hyroJYUMYijPaVXqo4XuzrNnkKkKjWSxrB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OzAelBOgJcfOfMywyWEtGDhptuBCxXfRc/GKBCuoi3YkQmPU
	bG6ia5+iBF9UJpBI/Qf7X3dfWbFTdZSomrw1Cb6QRXRsdoGN2JIvsF+VpleYz8ehcg83k5X5f1K
	n0PDoafRRT5AcDI5VYC4njLWCL9aykkM=
X-Received: by 2002:a05:6122:4317:b0:576:1a8d:8989 with SMTP id
 71dfb90a1353d-58658a3d6f0mr12430648e0c.0.1779881904343; Wed, 27 May 2026
 04:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526025118.38935-1-cp0613@linux.alibaba.com> <20260526025118.38935-3-cp0613@linux.alibaba.com>
In-Reply-To: <20260526025118.38935-3-cp0613@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 May 2026 13:38:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guqiYf-7u-XOHARWZEYytYBZ=5XahXmtXzZ7Urv8bnJA@mail.gmail.com>
X-Gm-Features: AVHnY4K470KiQWLSRdffFvGwoRgQxOZnZHDAqVE4J9GvFpSBp6vdb7nYMJ5CXEQ
Message-ID: <CAJZ5v0guqiYf-7u-XOHARWZEYytYBZ=5XahXmtXzZ7Urv8bnJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host bridge
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, djbw@kernel.org, 
	icheng@nvidia.com, bhelgaas@google.com, guoren@kernel.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 4:51=E2=80=AFAM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> CXL root devices (ACPI0017) declare _DEP on their parent ACPI0016
> PCI/CXL host bridge so that cxl_acpi probes only after acpi_pci_root
> has attached the PCI root and registered it for acpi_pci_find_root().
> However, acpi_dev_ready_for_enumeration() only consults dep_unmet
> when the supplier's HID is on acpi_honor_dep_ids[]; otherwise the
> dependency is silently ignored.
>
> Without honoring the dependency, cxl_acpi can probe before the PCI
> root is ready. The resulting CXL topology is broken: decoder targets
> read as 0 and no port/endpoint devices appear under
> /sys/bus/cxl/devices/.
>
> Add ACPI0016 to acpi_honor_dep_ids[] so the _DEP declared by ACPI0017
> is enforced. This relies on the preceding patch ("ACPI: PCI: clear
> _DEP dependencies after PCI root bridge attach"), which releases the
> dependency once the PCI root is fully enumerated; the two patches
> must be applied together.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 530547cda8b2..5f20e7748f36 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -866,6 +866,7 @@ static const char * const acpi_honor_dep_ids[] =3D {
>         "RSCV0005", /* RISC-V SBI MPXY MBOX */
>         "RSCV0006", /* RISC-V RPMI SYSMSI */
>         "PNP0C0F",  /* PCI Link Device */
> +       "ACPI0016", /* CXL/PCIe host bridge: CXL root (ACPI0017) depends =
on PCI root attach */
>         NULL
>  };
>
> --

If anyone has any objections or comments on this one, please let me
know.  In the absence of any, it will be queued up (as 7.2 material)
next week.

Thanks!
