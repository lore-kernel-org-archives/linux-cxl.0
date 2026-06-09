Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E83DFC8F
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009825; cv=pass; b=CgLJ0LTTZG7QeCbPtHJ4zvZbn8C7WpR3m69JM59HhiJ0g40+mYLRtO2MtGhOEuq0cuKUEIE/0j0dkaHM7RycySBQZtxWBL+xKWhercRyLzhw3Lu19gMdLRPdkc3RWEyCVTxSWYn7QjML9Dib+Mh3Zcz0lfj0Wz6ix2GDuCiZQVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009825; c=relaxed/simple;
	bh=g7Xtm/+bdp9gZ9jspWPk37pWcd2cGr/X+adG/VrfTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZCfoje2mzuFEzl9+HIdeAsUEZnyQYd7oJGUn0IHH+xw8HGJS+dIIGxISurIaI4XxngIF62mNDXqDWdejRNaRikdLTeWWTEZ+ruPDHbKxW8W0LftGsRfEWypuoMtDbRc4zBogFcEdspVwzgLkN0uiCopDIoIHjnyAUyNOCYhsZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4n8l6nQ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4n8l6nQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-660ea43107fso5348809d50.0
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 05:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781009823; cv=none;
        d=google.com; s=arc-20240605;
        b=QSsP1XEGoYTK9SSdRU59oHmWlx4NrLhJgPeXEqcfwKpYjk1eVA4swPP9rGYkhMyu5Z
         3DdGBviMxFwlMONcxbiw46tgasqb+ae1BK8OChALGjzYYua4dCwUbGL4KWVeBd25ZTeD
         L3M6GX7ZSpDGMU76oI4e7gnZUXKX0w+liOy6FirOJxjUsoVzpwPi+eM0fYhzgndwY0RF
         wYNc5AQzt1P8ctuRDb0OeBwXl3vNPxIUoL+rPrlNyEPGbzW88YUR6MUYuZIkyCCJ/8LX
         mVuTLZs8V/Pruwc4VhqraI2nbqKIbb9OUmcjaGYs7Y59pKxMPZlwADuit3ddlWpOO3gF
         3ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UCT+nxz25XTondRtnZ91yox9fMv3hsYnWssouvjS+gs=;
        fh=4D6+P17BICZn9jq/b4cT4YjZTh2bDgKz+PPTxmlTHnU=;
        b=P7kb4N6+jOgm0hAzPonaMu15RG4OspAOXNNdsFi1owpqKvUxBQIQEr8MhUJOKkHSoG
         iQmZjF3/P2JjNGM/h90UV+XoWJrXHcBZqFY+ooDpReI88UScgxc+iCzHx8pv2dVnVX3S
         fF4gnVdSURv0TaCJibXVdNEN3MFJuD31ONyPRyg2NrYunJah9wcuvUGFDqosYhOYRMbR
         RhqhfRNGPzRtvGC+gWB9R3nQXlcU4Yz1YeTG9N3bwEzvgcRnOyOiWrz5IFukG/fw081N
         EaR3vKxd3FwYU08qQPODPkWBlVqKnIWpv7s7NXUdm1ffizumOyRr/GDk9HBDV3bk8IDP
         yUuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781009823; x=1781614623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UCT+nxz25XTondRtnZ91yox9fMv3hsYnWssouvjS+gs=;
        b=N4n8l6nQTqL+7MmVpCdpxYULVe5L5tTSamsw9OQRSW4qyDLjk1EIxxOAMptHkO343X
         OktZRxDt7aQA+HlJujaOwSxe+89igyB+typkslbgecvoNZ8glTlP43+/0FwJqGf7wHfO
         gXiSaStEaAkTIK/Ok9EeprEn3FhnE28oCrD4JFRUI3KV8mZRe7+CvW6C4yVPAs4t9Tuq
         B068gCNASffa5Nbo3Xonq6RJiq2HaY44bGtYRTx/UPYI52uu7xmZ3B7SPWhadSmBPWc4
         VKcySDEtjBRnA3rHoRxRxHkIF7rbVWjWWtuL7UPSmw2kbXGmHPFhC5ikX0QUe+VolKp2
         B6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009823; x=1781614623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCT+nxz25XTondRtnZ91yox9fMv3hsYnWssouvjS+gs=;
        b=YHx/pc3lf3obGc+eEKFWAboKQyY7nUWlcjLPozKLtCCWBzWybhlbh/Rfq3MX8sJ6g2
         K2Qv6SMLOFHnzbEV7+ugd32ZGLrSK3pP1WhWJe19O9HGZivzaAGksSdnIWEUiPFxTCcF
         t5fCBmUfa845PBmZVbYytbmT0xPBwqKTd+PzJsdCg8F7Frqu5B8+Zv0kjQpJ8PQumuG0
         KI0S3lqAx8kHjLUTL3/+gJS+hNc9fO2NYOpM7npN65rTJm3MPCZ6pEKPbHtQH9pCBTio
         MAlzIhOs+oKDMn4iTzSo+qw06pn4/3gdqmxxubnMosXFS+DhAWxwqYRiul9oTS6lzIsT
         EaWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ce0N7pqIEIhY+yHb6fLsEFpDZCx5bD0Ho4sMg5bKV+gxT69yqKyO9QS4RLFZn5Jqc3C0tRofPATQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/v+db6JPfChVFUAEhM9rt+qEClHo74oxbyNcgaHgx2eWcxrZd
	N9pG5zHD19uK0JKNJfc9By6APlneELNjxLtP3JmSQ17uWQ5u4M3Pw8phoh++PcdUKgU1gnxrzyI
	iBUW7Ml0OQXvk0EgiHC7uol3a1OxGFG/zSrldsfS3wA==
X-Gm-Gg: Acq92OEcsCQtTgsEUoAzvQo62/4w+OghqROpf7o0YbtEHNA6Y6aNkCsvu5yUL0aLi/E
	38EmMPtKj8OTljBzm4PNXJW7fJwi7gY8r4mNj126JBEhpTTUPDMdAb52uwgoiahtYCne3Grs+qj
	ZGL4peSzlVtsAVRYlObhsINVcyxWBwk10QKh8cUnjsl4Brhrkl29LSWvgDg58zguh5ODUEqboUc
	Xxt0Yh9g+NljS1zyAD6D2zpviUfHyGF1vu4WaWL0ET7i4205wS1byWsLI2thiIBhCnJORjBN+an
	pcuIrXRg9863YTI1ujCoJcvM68cYq2PR3PitpUBx4g8y6o7fbcNWVDUmHof2zDNbArVhOYWAJj6
	yAA==
X-Received: by 2002:a05:690e:4383:b0:660:9c4e:a44d with SMTP id
 956f58d0204a3-66106dcf382mr13081751d50.6.1781009823286; Tue, 09 Jun 2026
 05:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
 <20260602074127.63819-3-cp0613@linux.alibaba.com> <20260609134659.3dc89b40@jic23-huawei>
In-Reply-To: <20260609134659.3dc89b40@jic23-huawei>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 13:56:51 +0100
X-Gm-Features: AVVi8CcX067O8FqveMn6c_pwXBIWPZLxC-Ew61QuhJcjbG1Hyru1nwk5GqLaktc
Message-ID: <CAFEAcA_m_uR5J53rsDtn6+D47BfVzBn4giksLzjBeF6U2zcuwQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chen Pei <cp0613@linux.alibaba.com>, pbonzini@redhat.com, palmer@dabbelt.com, 
	alistair.francis@wdc.com, liwei1518@gmail.com, 
	daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
	chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, 
	jonathan.cameron@huawei.com, fan.ni@samsung.com, guoren@kernel.org, 
	qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 13:48, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue,  2 Jun 2026 15:41:25 +0800
> Chen Pei <cp0613@linux.alibaba.com> wrote:
>
> > On RISC-V QEMU virt platform with CXL enabled, the probe ordering
> > of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
> > guaranteed. If cxl_acpi probes before acpi_pci_root has attached
> > the CXL host bridges, the CXL port topology will be incomplete
> > because to_cxl_host_bridge() silently skips devices whose PCI root
> > is not yet ready.
> >
> > Add a _DEP object to the ACPI0017 device in the DSDT, declaring
> > its dependency on the ACPI0016 CXL host bridge devices. This tells
> > the OS to defer ACPI0017 enumeration until all ACPI0016 devices
> > have been attached by acpi_pci_root.
> >
> > This requires a corresponding kernel change to call
> > acpi_dev_clear_dependencies() in acpi_pci_root_add().
> >
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
>
> It may be a good idea to add a bios tables test as well.
>
> We only have the x86 q35 one today because I argued at the time
> the ARM64 one would be just duplication.  Now we have this new _DEP
> stuff we should probably add something to cover it.
>
> Please also include an iasl -d dump of the relevant additions to DSDT
> in the patch description.  Much easier to review than the code that
> generates it!
>
> In general looks fine to me and great that you are clearing this up.
> Seems it's luck that x86 and ARM64 worked without this (or strictly
> speaking other things enforcing the ordering).  Ultimately we probably
> want to add this to those two architectures a well.
>
> One small thing inline.

> > +
> > +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> > +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> > +                    num_cxl_hbs++;
>
> I think you only care if there is at least one. Instead of counting, just set
> a bool and break out early if you find one.

> > +                Aml *dep_pkg = aml_package(num_cxl_hbs);

Looks like we need it so we can set the num_elements here.

(If we had a version of aml_package() that let you set the number
of elements after the fact we could do this all with a single loop,
but it doesn't look like we have any other places where that would
be useful. Almost all the callers pass a fixed number.)

-- PMM
