Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B071DE3A5;
	Mon, 31 Mar 2025 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445880; cv=none; b=JFemOyFh1f3UsWRjz2SVmIAwdHCbpRoD/QUsidIlP5fevTGaYMj5xlKUyQRk5p0F6ZAdvgG/2ZRorTiRIGPUQzjff/XK7QjLsIbHqljG2TjiNVHCFevtsmv/oQJIzvVKZjmoY0puCkx4Zb6U8cwLyulJv3zlPHg4XLq0Bb3pgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445880; c=relaxed/simple;
	bh=2QhJhyZweJegw6w8Qqbk89k/YUlGN7JAZ3aC1DGnFf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHa7eNDIiNwFhuSJYfCSmnynrkCNzVb8A+nm0GSY9qOqNoPshn9hlydWU3Ei+5uIsNEO1ivv+ojYmeZzeSACsolM9KwdEsHGe04m43sDM4k+7y7uPhzV+CU6cjldY9JuJtgVaA5sy+NRqpuKFrLE9GmyqDrIrFIzcgm/UScd4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMOgiko8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMOgiko8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3750CC4CEE3;
	Mon, 31 Mar 2025 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743445879;
	bh=2QhJhyZweJegw6w8Qqbk89k/YUlGN7JAZ3aC1DGnFf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMOgiko8Oby62xNgaIMkVcL0Tv5EUH5EZjFppUBodrpkeOmi/ven8fFfp51FLFjlc
	 0ZIgeicQje8lAagQHiLiarHRTzw0uCn+JQRWVnCkbkrwe6cWo9h7P38y3Iex3Vb8JT
	 hLUEAmCgNmBIoBU079/WTcMEEZPaUJB6t5L0zZXOfKi4ZRQNSEy4ouL16Dx9GXSujo
	 ioUKr3Lc1lByz7vIEUHV3vfiTbTXvvgiV431OmuMu2ekizw5O8cmZCs9Khh1SBiWhk
	 +oJ32mCqn/tnSLOz/5s3ytoxI1KXDqQFY99HlM3MLRwUCOGmnGr3Gi6irfVbvriCwX
	 3Nv4b+7uXBAjg==
Date: Mon, 31 Mar 2025 19:31:14 +0100
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 02/23] sfc: add cxl support
Message-ID: <20250331183114.GE185681@horms.kernel.org>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331144555.1947819-3-alejandro.lucero-palau@amd.com>

On Mon, Mar 31, 2025 at 03:45:34PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

...

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c

...

> @@ -1214,6 +1218,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers

nit: will

> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.

...
