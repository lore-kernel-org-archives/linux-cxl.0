Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C706FC3;
	Fri, 10 Jul 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645257; cv=none; b=QC+l4BuKMjp49H+DW8UryrtDCsRGHk0gpa3MibEJoemRIAXf7fPKv6G+EzUcEQjTJgg6LOikit/K/dthRMzMxtAWEUaY1pftxmZNUrCz7Je4h25sTHiCGJZSAklHUtEJLZ7AKlZ9WLEPEGN3ehZcZrNwtj8MxtARHMLssCWnZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645257; c=relaxed/simple;
	bh=D7xsMNqxgtDor3HtGZK+8dics/aLyUyn/u2Y9V+fBsM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ly8l4OgwK6md09gmbKBu7+JociqAISyfKWOUZXHIPwRUsRcK4mB86ag0b54WElqHZRyjQVemSwqsdsstGbVizEIVsPQoA1PCgw09j1ZX/V4my4PGLw8+2TKpa6eI6ZwmFxiep0I4Yc8oPzLma193KziV/al7G32M3REvU+2/DSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfVx0UQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfVx0UQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7586C1F00A3D;
	Fri, 10 Jul 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645256;
	bh=15pjR0K6DIp0dkq2ahqu5yknk8ig1dLWMV+egpv0BGA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=RfVx0UQMsQWT28bdkNdZ3A0/YpaldVNrhaEqSrNnJDNUtOpgPV7YCw05dYpj3UI3P
	 vW8UwoAqsTUzeUOkJT95fI2n/Ot1hpubtGQZhByI7cn6l0oozUewMgTmdY5jsBrUBO
	 o3ZwaHbh/N94CGLaF2NAMFm5V8HO6ecAFRyNSf7l0QatjO1ih9y3/Sp0KHVS5STa26
	 VKh+enQxXReCA6XYrjMiXquyOZSzG8+rHUjHssYWhOrPalWuv9PR1Rty17BG0s06/s
	 2Y6SQUwmQJLM0D+I0/Uxm1crE3We9RI3FA74bCOFVUEVM9NC//cnce6hMRePgYoiXU
	 603Yh5mMX72Lw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EF3FF40068;
	Thu,  9 Jul 2026 21:00:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jul 2026 21:00:54 -0400
X-ME-Sender: <xms:RkRQaixhjYcFLUIlGKbiUyCePNgXUChBwgmx84ppzWv3pr__x5Go8Q>
    <xme:RkRQajLbYHucSL7ZO0PsAMtRM87ipcbCZ-1P7QyyPkVTpHzz5vF9jMX6TR70kUm82
    JI3UCX8lpr5avrCBISbl2fVItK6bOtNddS_Z8OahUfW-cRB-UKpeA>
X-ME-Received: <xmr:RkRQah5RcFMetqbrlzuvSkd4EMeWWkdoNYpjpUGasts8RvbzVGGiZwpCsO_ojTEIjVSDZE2EbXrr04LUMFc719RLrhnKfUUC8Vs>
X-ME-Proxy-Cause: dmFkZTGsYDfGD7sxNcvTONT2+aJJfxqyPBiaS3Mkdh2jbWQu+fCZIX0aLUIqA6NBOWA8Iy
    S1d44AqtcsvdKsUpMKxngGixr3adXdgl4ZOuaGBcCL5Atsk7rMj8Y0O+ujZos1nEh+55jA
    Ie6e3/gtSTxpbAKgKtrC6kwQFFaAICKOvt3RPzvwz0mlrlpz5g/f4kWYD2KuXpKR5O7bHZ
    yb8re0feSEfVGP7S9Y7KDiYnEJqR5E/fpU1i9KHC/VNkmkjNEBepIvCims16M22easzvDT
    8Jts+UjL+EwmjLWu/CuntdiXBoWG2jry8Z+lhmCIbzTr/iY/hO79JgBTMA+jXTXoHF61iK
    9kmeyU/EmT2StFDhfXhISwx2zyjq6HKDkTq5/yWad3UpsDizaxQjfScm9pGnIpcwzSMJd0
    /N13x23xu2QPfEJkTCwxwKLp/UlwP66Kd9ynet1RdNHeVFPWzD/YgUEuf3raGleW9E6mJD
    eFtqzl6vMeJ4iHCrPl6FvznMULI0G19Fe7mxybeOnvVhy45kBAfYgKFNRCHOq2eCV7jC5F
    qFJe5+/P7L+i/Ce4Nk3q4TVyHURA9JgoM95KcBsm0mOEGqAlnJ0SIaIeEjTTP3hVhXMRGF
    +Z6kDdpTejQe/oNWFiV+HjZkjCC27bLjLabbloy8Qmy3sc8n2QGUH+W82apg
X-ME-Proxy: <xmx:RkRQaqlN_kciHCe3yx4N5qm5jOMNAgZLdzCwoFdoi-UCaThfLAJ0pg>
    <xmx:RkRQajJAIeOB-_IGDxeXNlQv2hJy-blrgvVqpuscGUEZngm_eczWhw>
    <xmx:RkRQarGIF-29iEmu8dHoriQ1WIx36lZEtKBG3B8F2N1OM6Ar_96Y1w>
    <xmx:RkRQakN5veFz-oz4qh6s7KpyzeKlkgLi6fWKJ_l4YMB9Z7uUvY_41Q>
    <xmx:RkRQal_kPq7fB6UHch4IBRveGlZwljeuKCzcGVUDLouoDp5SWrBnsHkK>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 21:00:54 -0400 (EDT)
Date: Thu, 09 Jul 2026 18:00:53 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: mhonap@nvidia.com, 
 djbw@kernel.org, 
 alex@shazbot.org, 
 jgg@ziepe.ca, 
 jic23@kernel.org, 
 dave.jiang@intel.com, 
 ankita@nvidia.com, 
 alejandro.lucero-palau@amd.com, 
 alison.schofield@intel.com, 
 dave@stgolabs.net, 
 dmatlack@google.com, 
 gourry@gourry.net, 
 ira.weiny@intel.com
Cc: cjia@nvidia.com, 
 kjaju@nvidia.com, 
 vsethi@nvidia.com, 
 zhiw@nvidia.com, 
 mhonap@nvidia.com, 
 kvm@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6a50444528cae_3c589810050@djbw-dev.notmuch>
In-Reply-To: <20260625165407.1769572-2-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-2-mhonap@nvidia.com>
Subject: Re: [PATCH v3 01/11] cxl: Add cxl_get_hdm_info() helper for HDM
 decoder metadata
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

mhonap@ wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> cxl_probe_component_regs() finds the HDM decoder block during device
> probe and caches its location, but does not record the decoder count
> and does not expose the result outside drivers/cxl/.
> 
> In-kernel cxl drivers (Type-2 accelerator drivers, vfio-cxl) need the
> decoder count and the byte offset and size of the HDM block without
> re-running the probe sequence.
> 
> Record decoder_cnt in rmap->count when parsing the HDM capability in
> cxl_probe_component_regs(), extend struct cxl_reg_map with a count
> member, and add cxl_get_hdm_info() to return offset, size, and count
> from the cached map.  Export under the CXL namespace.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/pci.c  | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 +
>  include/cxl/cxl.h       |  4 ++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2bcd683aa286..c917608c16f9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -449,6 +449,39 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
>  
> +/**
> + * cxl_get_hdm_info - Get HDM decoder register block location and count
> + * @cxlds: CXL device state (must have component regs enumerated via
> + *	   cxl_probe_component_regs())
> + * @count:  number of HDM decoders (from HDM Capability bits [3:0])
> + * @offset: byte offset of HDM decoder block within the component register BAR
> + * @size:   size in bytes of the HDM decoder block
> + *
> + * Exported for cxl drivers (in-kernel accelerator drivers, vfio-cxl) that
> + * need HDM decoder metadata from the cached component-register map without
> + * re-running the probe sequence.
> + *
> + * Return: 0 on success. -ENODEV if the HDM decoder block is not present.
> + */
> +int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
> +		     resource_size_t *offset, resource_size_t *size)
> +{
> +	struct cxl_reg_map *hdm = &cxlds->reg_map.component_map.hdm_decoder;
> +
> +	if (WARN_ON(!count || !offset || !size))
> +		return -EINVAL;
> +
> +	if (!hdm->valid)
> +		return -ENODEV;
> +
> +	*count	= hdm->count;
> +	*offset = hdm->offset;
> +	*size	= hdm->size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hdm_info, "CXL");

This is the same information that the CXL reset patches need to cache on
the PCI device. Effectively this level of CXL information deserves to be
as accessible as PCI BAR information, and should not need cxl_dev_state
context to fetch it.

So it would be good to depend on that rather than invent a new export
mechanism.
