Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879329;
	b=OF+cDhZwuqn62IvutcAkkcKxIlX58Eq7Gsu6010Gy1TN/lNjacVcbkN6gKS5L9TZmJ1P
	 iRnwyC6lNW3ltVpABiJxZMGhnnNebAMoMI+QPNcyiemXw35e40FDjk+V/6Mp41XjyrYo0
	 9jYHWIZkK+kAKI+0+YZIvcBk3zD0o4aVpMZmfm8CgF4GfDr5dTV6iOFqcQOM8+VS3e9ae
	 lN2ItUNIHIpmAu8/U41j1Rq1dav0PGv+1Awlo7q6fHhpFw3MjTs6sWyQdqGIeRMtp8TcP
	 eE34ho5A9aowwA5HaNr0m9/yzQ5nLl44/DGNBs+ATnjX5WUKVQhEwGMj/VI4Ec2y6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zz6WRoIrA4MtoYD+sM4sjtcaOrrRsCorOnSwGUekLOA=;
	b=36P//qv/+hOdAKqXYbIboSE4l3y3wzWXSTuYGOszEs4A7TKdrKg7rGHWXciRXL25VaV+
	 IP2O6FgcmCulXt8JIXmvGuGwZMLQEa/mawqTm6/NcmdEf9GXb9Od6AE4ARAeyknMCFGer
	 jtpjdcpZuiTdOANN+7oCYyVMPuIEPN74GHmg8HsRK4kCmqfMfP/0aFv3O2rvpSCTb1DHf
	 cYoh/OUF26R5XKn9lKwkj1euHpyqIDHiz0FdVeR4vo1I6AIvpzB9PBycr4VK4nQJo2Aau
	 06sPIZF5/y4rKD1Xmw6+Ub5XXMx+dOsuwm7y43k8PBelKhZvj9Sn3RJX9vktJ4F5LAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaVzT5k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE642606A31C;
	Tue, 17 Nov 2026 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaVzT5k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8951F000C4;
	Tue, 17 Nov 2026 01:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879329;
	bh=zz6WRoIrA4MtoYD+sM4sjtcaOrrRsCorOnSwGUekLOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DaVzT5k3Fq+zRV6SmVPs9JTPinoP3eCaKUB1XQNCIY6lYVaTR/Nd/npuK2bSwB9oe
	 kHT8SAHcNMuDj4gFWp6/Qqrl+vdqoTu8B0tQqj+5ypoUEWumz7BdZfgZFDJ9k9lsph
	 y9mQI0A/6GoYZ8Y9IPme45ighJ8m8pEgYycpkwP2UpLjRhplCTcL2wBlMx5bP+W+4Y
	 IgFuoWKmEQYl0euWuYCd7p/lnFT3LwEqYC0+02lWtm6rHtwhkgvNb1D7N1AIGpabpj
	 6iPt/uxSe6GkB/4AZCS7vLdjEB1It7w1eAXj3JG3+jsNDu4YGebmSAHwSdEmIJb6Mf
	 BTP8FJcXcrT+Q==
Date: Tue, 17 Nov 2026 01:35:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cxl/edac: Read cached DRAM event records under
 the xarray lock
Message-ID: <20261117013521.5b4d034a@jic23-hlaptop>
In-Reply-To: <20261108022022.3352-2-ai@linux.com>
References: <20261108022022.3352-1-ai@linux.com>
	<20261108022022.3352-2-ai@linux.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 11:20:23 +0900
Jongwon Lee <ai@linux.com> wrote:

> The event path caches DRAM event records in an xarray. It frees a record
> when xa_store() replaces it, when the record expires, and when the cache
> overflows. The event path runs with device_lock() and cxl_rwsem held for
> read.
> 
> The repair path looks up records with cxl_find_rec_dram() while holding
> only cxl_rwsem for read, so both paths can run at the same time.
> cxl_find_rec_dram() reads the record after xa_load() returns, and
> cxl_mem_perform_sparing() reads validity_flags from the returned record
> again later. Both reads can hit a record that the event path has just
> freed.
> 
> Move the lookup into __cxl_find_rec_dram(), which is called with the
> xarray lock held. cxl_find_rec_dram() now returns whether a record
> matched, and copies the matching record into a buffer passed in by the
> caller. The PPR path only needs to know whether there is a match, so it
> passes NULL. No caller keeps a pointer to the record after the lock is
> dropped. The event path frees a record only after xa_store() or
> xa_erase() has removed it from the xarray, and both of them take the
> same lock.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Jongwon Lee <ai@linux.com>
This seems fine to me, but a suggestion inline that might make the code cleaner.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/edac.c | 70 +++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..4624ab4644 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c

> @@ -1029,6 +1028,30 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/*
> + * cxl_store_rec_dram() replaces and frees records while the repair path only
> + * holds cxl_rwsem for read, so look the record up and read it under the
> + * xarray lock, and hand back a copy of the record.
> + */
> +static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +			      struct cxl_mem_repair_attrbs *attrbs,
> +			      struct cxl_event_dram *out)
> +{
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_dram *rec;
> +
> +	if (!array_rec)
> +		return false;
> +
> +	xa_lock(&array_rec->rec_dram);
> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
> +	if (rec && out)
> +		*out = *rec;
> +	xa_unlock(&array_rec->rec_dram);

As I just sent to next patch. It would be nice to have a guard()
for these. Maybe it is worth including as part of this. 

> +
> +	return rec;
> +}

