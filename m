Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7802882BE
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338380; cv=none; b=RNfiBwiRvrem35kyKmaM8oEy34/kCIrfe1tiiMY9O0pxDbz83klpo1YxA9CdVJaxK/UGH0I24lJvur+YT2fjEzbEYiBafVTitMrHURQD8FYJoGufvm3zT2REf4kTrRUuFfa71tm0DbssZwCqeQeX4Sb59e3LF/prgtAG+0j0pMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338380; c=relaxed/simple;
	bh=Sclp4nUOgxH7mX7VDk8XXDfJ/H74WDc8epZV+8JvEuo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XamM1Iq4rqUM/68UJ/h+KYVEdfZGYew5dS6le1bQlJREO9daLt5bIo8O6kZMCVp9zIKAPkKS+TBulfyqdEeBnZKz+jBicRU7pmNT0Pcw3nhZZnXDdfA28/Nv8nH0Gw9gxC8kivfg5xoSAsQv3G4x+d7ue5PjOeyg0P131eVyvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7jgDJSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7jgDJSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73551F000E9
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782338379;
	bh=+I9vBxeJ26utNBD1tDo4GB5u+5anWMUqyN7jWrGaXrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U7jgDJSuGD/Mywtr1O+swvwqUMjFrMZPfsYVBHSEui8TPHWR+h3xx6uGcKNtQj/VP
	 fp0T7tYTu17h9vxRdYj/nNsHBbZW2gN76kDgULNcLro5WG0ZbF5UF9mahSPpepETs3
	 ZcLVKFLPGOc4fpTvDc1b/tbAEdo2p0VsLEKhBxEI4MkxLa8O5j2Dl42T6HhGOkwDRa
	 IoHiiPgLhKfMd37yBRge9cFP3px2EErjyHnn6xuJrymUt1JED7lHvdZtZMHcy5gFki
	 U8Puq41v2gdJntBZ/cy65DJxl2SFF8n/QyJsNvz8Hrn5YV1XSvRnF7u8Jp7NykPQF/
	 KGDMzi3NUBeuQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 507B1F40087;
	Wed, 24 Jun 2026 17:59:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 17:59:38 -0400
X-ME-Sender: <xms:SlM8auCKjGva29n1fGkldrVXDN3ONy4IXsygKW-Q7yFFYBuFt7eq-A>
    <xme:SlM8av9Y7gflaWb9SVQ8qmRcVfmjT0cp6AWIMNmuj8NgJn4ELY2dGMb5-wsygu4_I
    DE9VZoGR6sdE6eABI9lvkUe-ao1QnNCrqEln-l7JslOmmQdiqNbVHc>
X-ME-Received: <xmr:SlM8au8GA-YIUzH_si0ZcPg3shlGrO2kPoiypZRvRpKSf1s-Tna7o4PE9FXbBPJGdzddbMA40vLs_-WQT4M-6Ms0mXgr1OrZkdY>
X-ME-Proxy-Cause: dmFkZTEvH9iqHq1E17wmFwGwcX5n4pJ2VOr1Ar3HKNsOGEb/fg8VKpf5Tb9l2PtRQ9X1Bg
    fzRniWvGif8NIpxXWAuLZoyRpP3gI2xRo0FF0HblHdcm3VJv9xTbKhA4m+Sy6GHlayTtp1
    iQfc2QJ8MI8QE2V3AGEPznciCl6SM+suYDDDgBt0+FU1iirGdSbDsyz8e0KA3jO3tlnHuM
    wC7SN3XnX88+eD4/M3KAqJbYHc/O/v5m70Fh+7mzVGgZhxkaoKywz30Vd1YdbYZeNEkCuv
    r7p1Ktk0oXt62rWceNYKe0Gu9sKHxV0MCEytKfox+UTag3y8Cffl6+tipmzBkm64PLwQoH
    fkzLZ9OAuFTXHLAnBKcYDYJb0RB/GB+hpiHX8ai7a/WizvmjFfF14T066sAy+CNdI8aIL9
    6I/ousLhGDTtWsrG0/YLeSsAbN9bUEvEiwT16qBrGy4t3p2a4mh3i2Niq348K7hwPukUNd
    G3VbJRraY9LEaEUor0VmsXtu4uzgfqZbesyEeiURMx+MqL/5erZfuqUommlJcKDTTOfXXj
    jKr21DKq36TE7mH9FtGrYyT9qh6v443b07vExrnFUcUjM/fXgq683qETWNFS+g4RBmIsMa
    +uyjQ33YznFgboCAx09e9Ju1Jotzmr1vQKnCTHFmew0kqs5TBl95782eLZ4w
X-ME-Proxy: <xmx:SlM8amcxozbYoPmaWo3OgnU8OJBoJGu70aMtdkdhVBsZd25Wz7qm8w>
    <xmx:SlM8anEONCmQRHcFvv_ZryzFoyQ0ut2CVA3wL74oBmT78qBuUb0n2w>
    <xmx:SlM8akct4ahICOuNxdVp5bdHxkiWeaYLhO7kfw11prn7GDDDyPPzzA>
    <xmx:SlM8ahEb1fP9lTNT2cMV_yXlBjphyoS4EAx4dNjzvwq-avocorU0UA>
    <xmx:SlM8atWM6Fyk-urnH-EsTm_m7QsRAxzncDSYbqae2v9OCp0uB8VCxtaa>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 17:59:37 -0400 (EDT)
Date: Wed, 24 Jun 2026 14:59:36 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: sashiko-bot@kernel.org, 
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
Message-ID: <6a3c5348f2022_f1230100d9@djbw-dev.notmuch>
In-Reply-To: <20260623124057.CDCAF1F000E9@smtp.kernel.org>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-3-alejandro.lucero-palau@amd.com>
 <20260623124057.CDCAF1F000E9@smtp.kernel.org>
Subject: Re: [PATCH v29 2/5] cxl/sfc: Map cxl regs
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

sashiko-bot@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] cxl_dport_map_rcd_linkcap() maps RCD link capability registers using devm on the endpoint's pci_dev, but stores the pointer in the longer-lived cxl_dport, creating a dangling pointer when the endpoint driver unbinds.
> --
> 
> commit 521897a4e4d35020c7cc57f7004dd3c659771f44
> Author: Alejandro Lucero <alucerop@amd.com>
> 
> cxl/sfc: Map cxl regs
> 
> This patch exports cxl core functions to allow a Type2 driver to discover
> and map device registers. It then utilizes these exported functions during
> the sfc driver's cxl initialization path.
> 
> > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > index be252af972ab3..704b0ebae9374 100644
> > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> [ ... ]
> > @@ -42,6 +45,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >  	if (!cxl)
> >  		return -ENOMEM;
> >  
> > +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> > +				&cxl->cxlds.reg_map);
> 
> [Severity: High]
> This is a pre-existing issue, but does adding this call in a new endpoint
> driver expose us to a use-after-free when the endpoint driver unbinds?
> 
> Looking at the call chain, cxl_pci_setup_regs() can call
> cxl_dport_map_rcd_linkcap(). In that function, it allocates an I/O memory
> mapping bound to the endpoint device (pdev) via devres, but stores the
> pointer in the longer-lived dport structure:
> 
> drivers/cxl/core/regs.c:cxl_dport_map_rcd_linkcap() {
>     ...
>     dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev, ...);
>     ...
>     dport->regs.rcd_pcie_cap = dport_pcie_cap;
> }
> 
> Since dport belongs to the upstream CXL port and outlives the pdev binding,
> if the sfc driver unbinds, the devm mapping is freed, leaving
> dport->regs.rcd_pcie_cap as a dangling pointer.
> 
> In a multi-function Restricted CXL Device (RCD), all functions share the
> same upstream host bridge and therefore the same cxl_dport. If multiple
> functions bind to drivers (e.g., cxl_pci and sfc) and sequentially
> overwrite the devres-managed mapping, could unbinding the most recently
> bound function cause a kernel oops later if a user reads the sysfs
> attribute via rcd_pcie_cap_emit()?

Yes, multi-function RCD needs explicit handling to either be marked
unsupported, or to move dport register mapping to a reference counted
arrangement. Likely the former as there are no known multi-function RCDs
and new hardware should be VH compatible. SFC is not an RCD.
