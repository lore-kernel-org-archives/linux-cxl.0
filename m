Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778F45DF48
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379797; cv=none; b=XWUT7A1MP448pwwegxaNYNIodppG+T8I6VC1/xtr0LnQakVpuG38knDRCzZb0goVS0uDzBsL/SOMYKKvBTjS23/+JcTsbMY0I2Iej9YkHhoYbQBTF+uQKdLQypP8cnMveNIMnNF3nFJnp3KY928IFeYGEpKuQwre8VDZH3L8o9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379797; c=relaxed/simple;
	bh=5uZX9fDqvdGTL/lxBCf8aIxOx6wgqNei7OvznJITzVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n56vJ78oYEyIy5FhyO1YCwBC5gs17DU+MACsXmVsAPpxmn5UQt84fKoJYJNOI4/140xx0iQE63wVISmSshPL2MsXQNampAuxUrnMRzvdeEbKpTslbYm/PrZtTvo82YgiqxqK2KDhl3vTAi3R6zRWWpdIZwSUrT/ktJqBkf8gaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9/TaNQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9/TaNQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE2D1F000FF;
	Fri, 25 Sep 2026 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379796;
	bh=PUGI89d6TT61t1HMFILnYTz+B7cirrUhtCX7SawrQ2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R9/TaNQvYV9owW/9dMzLfLqzh1CFPyWyWyvy4i6TKaJgzJCPbirigGlIh6Gi4Ytru
	 mn1Hqm3YGD8sbnt2bAizjYMDsX1mwAD/rGe9AL33OmNdZ/VPxI2FVUJp8T9vAtSz8G
	 XuYSlUBTjvAiW2a126NwO2b8CrWR1PiSO2t240tkFhhnhJRA9h625JQesBFLuja0+i
	 Rru7SH579QkghobxzBcZlEz/Df8l0rtbhrffBl/2dJ9QqKIbafl/0mpw7YYzP2ivvo
	 TTfIr9vAGn9+/h9UwqAwvn7xFMjsOHwKqxV+r83A/VqouAKWqU8F4aiGY4B9izY1hs
	 aKOvUtXz+3v2A==
Date: Sat, 26 Sep 2026 00:43:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/pci: Program the Port GPF timeouts before
 caching the DVSEC
Message-ID: <20260926004312.130e2b3e@jic23-hlaptop>
In-Reply-To: <20260922100026.3742401-3-kanie@linux.alibaba.com>
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
	<20260922100026.3742401-3-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 18:00:12 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> cxl_gpf_port_setup() caches the Port GPF DVSEC offset in the dport
> before programming the phase timeouts, and ignores the return value
> of both update_gpf_port_dvsec() calls: the function always reports
> success.
> 
> A failing config write is therefore not only silent, it is also
> permanent: the timeouts stay at the hardware defaults instead of the
> maximum flush window the kernel is asking for, and the cached offset
> keeps any later endpoint attach from retrying the update.
> 
> Propagate the errors and cache the offset only after both phases are
> programmed, so the next endpoint attach retries the setup.
> 
> Fixes: 6af941db6a60 ("cxl/pci: Update Port GPF timeout only when the first EP attaching")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Handling config write fails is a bit of an esoteric corner.
I don't mind it being improved but not for me that important unless
there is some reason we see these in the real world?

Definitely good to make it return errno rather than the pcibios_err_
though so overall I think this is good to have.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/pci.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e31aad7a525a..1f470ab0df3b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -840,7 +840,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  
>  	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> @@ -850,11 +850,17 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
>  
>  	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
> -	if (!rc)
> -		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> -			phase, GPF_TIMEOUT_BASE_MAX);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		pci_warn(pdev, "Port GPF phase %d timeout write failed: %d\n",
> +			 phase, rc);

> +		return rc;
> +	}
>  
> -	return rc;
> +	pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> +		phase, GPF_TIMEOUT_BASE_MAX);
> +
> +	return 0;
>  }
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport)
> @@ -864,16 +870,22 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  
>  	if (!dport->gpf_dvsec) {
>  		struct pci_dev *pdev;
> -		int dvsec;
> +		int dvsec, rc;
>  
>  		dvsec = cxl_gpf_get_dvsec(dport->dport_dev);
>  		if (!dvsec)
>  			return -EINVAL;
>  
> -		dport->gpf_dvsec = dvsec;
>  		pdev = to_pci_dev(dport->dport_dev);
> -		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
> -		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
> +		rc = update_gpf_port_dvsec(pdev, dvsec, 1);
> +		if (rc)
> +			return rc;
> +
> +		rc = update_gpf_port_dvsec(pdev, dvsec, 2);
> +		if (rc)
> +			return rc;
> +
> +		dport->gpf_dvsec = dvsec;
>  	}
>  
>  	return 0;

