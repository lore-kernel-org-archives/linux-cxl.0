Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DD4F55DB
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379421; cv=none; b=mbsFAuwQ3ACZV//yebNc7bFTpNx8RK5Gk+SjeJ5pRUx0Ku9j4MzgtMAyf+6fN2GyFlbN8f3gGaVu9jYwS0UTrPL2aHXJYiLrRqNPk1sP1Ds2O6KzaQi7PA1u4G/NbyUMmXKciGSaZmQiz7KXu+qBzHaFaKE6ds8ntwbhjjvxHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379421; c=relaxed/simple;
	bh=jGR/+umJ8FoV6CkyNwn3NWGTfYU2nT4ZyDT1PLGSg7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIx5umwBbm8BHixvL2tLpK+yRe74WkdkKmSz9Q6fymQd8A4Re6usWySZUxcwxAUQav9sHjHYohhNatZpjmD98989KCU0a8qIdJlJt2zs4oICREQJoOMB5WzcGmaIEZb4JHZxEHoutY0t7gQ8EZVluHIFflaZs88nShCYDsa0EG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbAo/BL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbAo/BL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E241F000FF;
	Fri, 25 Sep 2026 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379419;
	bh=XqMzeqbu6EUsUyf3O0nbnYhyIdSoUYWkSooy8oW8Q7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SbAo/BL/igc0R4PbBFo2c1PjnL8g0yGxzjmyAPdw7i2RTuvkwUrZCg904pgmmhwZY
	 f7HjF6A48o/B2A3cRT8i8798NjokpyFsO/6iEZ5Tj9pZxCteXITGsKjSmPfoB3q9kG
	 0RutP0HZ001XDttFgYUolN3Wg7s2uuH4WvXwhqW8hKRcxhgl/ChhFrfIJugEXgaQVt
	 eWwHDIRf4KfU0XGTk6ygS/ewbm/TqIko/HAKl6J8VuVfPEPMbSG/6NOnzgKRmZQdw2
	 eGKJR5G4yDgJasz17GmwnVOTVFSQyKLR5DK3HAjoTe4ZkrOgnvcVVGTv2ioCWdgy5Q
	 dtIXmNuMrAnEA==
Date: Sat, 26 Sep 2026 00:36:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/pci: Use the Device GPF DVSEC for restricted
 endpoints
Message-ID: <20260926003653.591284c9@jic23-hlaptop>
In-Reply-To: <20260922100026.3742401-2-kanie@linux.alibaba.com>
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
	<20260922100026.3742401-2-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 18:00:11 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
> from the PCIe type of the given device, and only a plain endpoint
> counts as a device. A restricted CXL device is an endpoint too, but
> it falls into the port case and is probed for the Port GPF DVSEC
> instead of the Device GPF DVSEC.
> 
> On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
> lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
> shutdown count stays invalid, and the warning complains about a
> missing Port GPF DVSEC on a device.
> 
> Treat restricted endpoints as devices.
> 
> Fixes: 36aace15d9bd ("cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Not an area I ever really messed around with, but the description and
fix look valid to me. So a somewhat tentative.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..e31aad7a525a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -804,7 +804,8 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>  		return 0;
>  
>  	pdev = to_pci_dev(dev);
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT ||
> +	    is_cxl_restricted(pdev))
>  		is_port = false;
>  
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,

