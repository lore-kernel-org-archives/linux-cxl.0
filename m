Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FADDA9;
	Thu, 24 Sep 2026 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212542; cv=none; b=aTNNkoOWbHMTATM8uXL0dxP+pAqaG9ZPDbsylm7J+QCxDAD2v2mEp0Q9KRcTXllWpFgBJkEVv8ARl9ZwSFnIHEjEuOriNNZjvf12eC5CKp9wf4QsPQeJO+Vfl9UYvKVyh2nICzfjvLFuQk86s04fytiHR0zKyiA9iweJ2rd8Eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212542; c=relaxed/simple;
	bh=7ZjZZlFb3ceS/wy6wTjHJxLsRGDZ/q2wCqeWH4pKkNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZi82zaSCBMUdKH9rdaCRRWwSaW7m3dzObVvmGpIVJT9zqbBwDUJpfF88JAzDfQu1owEngNKq83C+20buSy44OUD0DBKUQerkg42oQjoI5VAq9WyIoWXAXwawxaIQn2Q5zCo3XZ5n1n63J4tvDfXAIhLr8eWqadCETpue87xuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld1w/4Ho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld1w/4Ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319431F000FF;
	Thu, 24 Sep 2026 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212540;
	bh=B71boV2XThuzHvskggfMlD/ZAjyV0f1+JJNdeXL1qcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ld1w/4HoT3UxxCDIeRGTvm9iJf5LqVvAqDMpKzaultZ1MkZe3xCOO/GcDFUd5sD6v
	 Pevpc1+4iCUks4/TXcnHINfJJHx54FRbIJd+uQNjUrxQ4Vw4l60iyMukx9blCloJuO
	 bXdwb3fUXhLvtDOjLB6FiOFocfwN0jHlYLsfEtOAyuXmecnupot6EG1+NefyALwjnm
	 IV4Soe1VitXdZsxUCRF5SLYH/lr/nxvCTlprG6sHm4jA4K9p6lZ3klM2pWpNY3NEUJ
	 +gNWpe092bFPt9F/VMUNosmOVIxK2PQieLekJOu/8X2hs3nAtXjxe438K3UWx+bEiO
	 6h5yzrm/hfWnQ==
Date: Thu, 24 Sep 2026 02:15:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <alucerop@amd.com>
Cc: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
 <rafael@kernel.org>
Subject: Re: [PATCH v1 4/4] sfc: add multipf support
Message-ID: <20260924021535.3e55e8cb@jic23-hlaptop>
In-Reply-To: <20260921191239.4249-5-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
	<20260921191239.4249-5-alucerop@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 20:12:39 +0100
<alucerop@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use CXL core accelerator API for registering non-PF0 PFs to the memdev
> linked to the PF0, along with its complementary unregister.
> 
> Adapt the ioremap call per PF to be an offset based on the PF function
> index and a hardcoded per PF CXL.mem slot size.

I was wondering how you'd know what memory belonged to which one!
Simple solutions work best I suppose :)

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 75 ++++++++++++++++++++++++++----
>  1 file changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 348d7404cd7a..bed8d9c59185 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -13,6 +13,31 @@
>  #include "efx_cxl.h"
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
> +
> +static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
> +		   u64 devfn, struct range cxl_pio_range)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	u64 cxl_pio_pf_start;
> +
> +	cxl_pio_pf_start = cxl_pio_range.start + devfn *
> +			   EFX_CTPIO_BUFFER_PER_PF_SIZE;
Wrap as per operator precedence as easier to read.

			   cxl_pio_range.start +
			   devfn * EFX_CTPIO_BUFFER_PER_SIZE;

> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
> +				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +
> +	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;

'map' is carry quite a lot here that isn't really about mapping anything.
Maybe think a bit more on the naming?

> +
> +	return 0;
> +}
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
> @@ -21,8 +46,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	u8 devfn;
>  	int rc;
>  
> +	if (efx->type->is_vf)
> +		return 0;
> +
> +	/* are we PF0? */

First things we ask seems to be Are we not PF0? 

> +	devfn = PCI_FUNC(pci_dev->devfn);
> +	if (devfn != 0) {

I'd factor this lot out as a helper to slightly improve readability.
Perhaps factor out both paths and then have an if else.


> +		struct pci_dev *pf0_pci_dev;
> +		struct cxl_memdev *cxlmd;
> +
> +		pf0_pci_dev = pci_get_slot(pci_dev->bus,
> +					   PCI_DEVFN(PCI_SLOT(pci_dev->devfn),
> +						     0));
> +		/* This should not happen! */
> +		if (!pf0_pci_dev)
> +			return 0;
> +
> +		/* Is the PF0 device configured with and using CXL? */
> +		if (!pcie_is_cxl(pf0_pci_dev))
> +			return 0;
> +
> +		cxlmd = cxl_get_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev,
> +					   &cxl_pio_range);
> +
> +		if (IS_ERR(cxlmd))
> +			return -EPROBE_DEFER;
> +
> +		cxl = kzalloc_obj(*cxl, GFP_KERNEL);
> +		if (!cxl)
> +			return -ENOMEM;
> +
> +		cxl->cxlmd = cxlmd;
> +
> +		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
> +			kfree(cxl);
> +			return -ENOMEM;

ENOMEM for a map failure? Seems a little odd but if there is precedence
fair enough.

> +		}
> +		return 0;
> +	}
> +
>  	/* Is the device configured with and using CXL? */
>  	if (!pcie_is_cxl(pci_dev))
>  		return 0;
> @@ -80,16 +145,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> -	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> -				    range_len(&cxl_pio_range));
> -	if (!cxl->ctpio_cxl) {
> -		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> -			&cxl_pio_range);
> +	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range))
>  		return -ENOMEM;
> -	}
> -
> -	probe_data->cxl_pio_initialised = true;
> -	probe_data->cxl = cxl;
>  
>  	return 0;
>  }

