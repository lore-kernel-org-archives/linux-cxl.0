Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310763B6354
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379879; cv=none; b=aFc/nXALIVayM5OTCsnPOj6/qWmwC95DxKmekIkye6ndn7Ln7rT5zPsRbC72BjbDPKxkezUSvNFPEeAzvuQ48T0h09q2VXw2dEoETBPPgDkcvcKUBmvaJ1u4EcSe9+kLQqzFaig76ioyCN8w5faYaztEkUl1FYePlXzn0VBkN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379879; c=relaxed/simple;
	bh=7LoFXl1Ck/H3nadU5sQSCnsNowtOpKjInGpxEZ/upGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrU5HebnoxlKjjQyTDxmDmqMkUbDrJDVppjRs8EVcG0tb/r2WEGYYtypPQLojyMks81unFHF1uuJp8JpQRCGz1Lw+NBnB5H+fqU9V6zW1JTGcvhQxrJEEFXx86qdmO6sCi+zG2H/72atqPxJWt8usDTcppZiolPyiKlAqpRxMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWxkitrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWxkitrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D2B1F000FF;
	Fri, 25 Sep 2026 23:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379878;
	bh=4nqsfaY+6tQwnIu75iPdcCJo/y1shOfBAt6r8OVNwCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YWxkitrms/WiNZ84Tey+8xfqlEkOI2IeZarwfk6gd23Hv+/dWlGotaUOfkQjt9Ypt
	 oSdUR+L8m6AvsZ0Z/TO0S3jGXRyZTc8FBJzJaeWvlK3wWDujI2zWt7rATmvEtmK+j7
	 9LMvK4wQasSO48twfAdIRF+Cc0iliRzZvvqNUlxOaIQp0n2nCgs6d+cUCVi+x1tc4t
	 oqP7iRj3OQ3iQ7zICebRPYdci8pvbU2xM5dgMoy0DcqG87qOrPJzfcqWBYdVo6cLYX
	 H3MVVA7a1vV8zZdGjCHn2MRx5unS6UxI2hW9boCaFhQ3h7vq5IPzTFrlY4GrGAYaoR
	 xAAlZMXMUl2AQ==
Date: Sat, 26 Sep 2026 00:44:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/pci: Update only the Port GPF timeout fields
Message-ID: <20260926004430.42e9cec3@jic23-hlaptop>
In-Reply-To: <20260922100026.3742401-4-kanie@linux.alibaba.com>
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
	<20260922100026.3742401-4-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 18:00:13 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> update_gpf_port_dvsec() rebuilds the phase control register from just
> the timeout base and scale, so the rest of the register is cleared by
> the write. The other bits are reserved today and nothing is lost, but
> the full-register rewrite would clobber any field the spec defines
> there later.
> 
> Read-modify-write the register and change only the two timeout
> fields.
> 
> Fixes: a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/cxl/core/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1f470ab0df3b..72e54facafe8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -846,8 +846,9 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
>  		return 0;
>  
> -	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
> -	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> +	ctrl &= ~(base | scale);
> +	ctrl |= FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX) |
> +		FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);

I think a little nicer if you use a pair of FIELD_MODIFY() and let
the compiler figure out that it can combine things.

>  
>  	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
>  	if (rc) {

