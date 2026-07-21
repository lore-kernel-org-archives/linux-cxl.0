Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B93B8412
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678003; cv=none; b=lB6yDeZFvr0VKrmdZf7Z85Hq5k8iYJ03/dRA3SsTwSja3yYTIXTZPuRSEhts3uuF01eaCiqepinc6KCHs23aWbtkBKt3mCtYedDMgfT4fhcty4YGQQdRzjKtDbIEyeCZxXT9DFJ6lXTBMrs6pDOaf9zkqFU1VJF5tGU2EVhd+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678003; c=relaxed/simple;
	bh=YN4otMNzwDyqY3BFQYHjU9RTMEf72pLwphPkQqf8GUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odTfSmYsHFvUxpiE2Rp+zg+445Y5tC6aOR3UVOcJLUog1M4mrRcimpYeFyDgVMCOoquOr2qAye8sT1oAeJfCEm1HfL3Tg90LKl2iw9HWERGdHOr40472cjai0Gi0qtjzGKYLl7fbXGiOhlb8Bjhs4AzQRcLW+6DVvvxoho8VSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irce5u+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irce5u+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B71F000E9;
	Tue, 21 Jul 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678001;
	bh=/96IrG58rBRf8fvz7j4+yuBLXm/o2WSEdCEYoaZZaN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Irce5u+znO9nKJCses+UhoRMAdXlA6DYIlrw9pRDAFxF5AYnXGuHrhTxbZbI1y6SQ
	 f85MFsyvrRut20FLOjdXA0GGoWmND6S5Jn0lFZqJGWjiaNFRGwF3iQDdsQcH/H1g7L
	 nxH0GfWg78jV/QJvBa79z/pId6oxhGYyxfc7F6xQ+bWpsjeRHJ8n3wNrf+BU6fJ1T2
	 qQ8DVsvI0tTxjBfuqAPscnxINeNRNiEAvFOQO8sQwHgcWQA7BUH4UZZoMtKBT8wP23
	 KQ6CYop1lPLrf/6bnH3QuiFI7vrjqxNnEWsxN99k8OSHnHyAW0VBangkGvrGTIn8HU
	 /PZQrcdNaiVTQ==
Date: Wed, 22 Jul 2026 00:53:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
Message-ID: <20260722005315.332375f7@jic23-huawei>
In-Reply-To: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 10:37:03 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The error path releases its reference to a switch decoder before
> logging an error that includes the decoder name. If the released
> reference is the last one, the decoder can be freed before the error
> message accesses its name.
> 
> Drop  the reference after the error is reported.

Bonus space before "the"

> 
> Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Fix is good but needs more analysis than I'd like because two different
paths to the same struct device. 

What follows is very much a suggestion so if you disagree I'm also
fine with this fix going in on it's own.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> 
> No changes in v2.
> Reposted in series w the __free change in patch 2/2
> 
> 
> 
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..c86dd9d55e93 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			break;
>  		}
>  	}
> -	put_device(dev);
> -
>  	if (rc)
>  		dev_err(port->uport_dev,
>  			"failed to find %s:%s in target list of %s\n",
> @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			dev_name(port->parent_dport->dport_dev),
>  			dev_name(&cxlsd->cxld.dev));

It's not obvious from that error print which device is which.
Maybe the print should therefore being using dev?  It's the last
line that matters.

Might need a rename to make it clear it's the switch decoder dev to
make this all really clear.  swd_dev maybe?  Or just take the view
the code is local enough and keep name as dev but switch this to

			dev_name(dev));



>  
> +	put_device(dev);
> +
>  	return rc;
>  }
>  
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

