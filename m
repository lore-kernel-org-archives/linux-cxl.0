Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879024;
	b=QmM9SpV9sF+G02CAzsPba55Vu6MuUr7V0NaFl3CelhKsJyl9ikNSymlzacOykL8Xk8mX
	 BcQyY8SB6w9Q7vd04aKu4fO0s8WmcEvShtyQDEwGKphAmi6DJCDU1HkYLEFMYfqh0iTUi
	 xElLz7sTNr0N/23J22pdmcUKsFP1qbWOQeg6qFh07juG+L7z2XqdgLs2C3oW+jkyGyrj4
	 aLwIl0ttdNRMm4ZJWXjWytMEUK12Vpm/Uhi9yADu6dwTay6wvAQFzbrYxwn7Bre4hK0Tg
	 qxU9t/mm7RVjQ6MNhUSBekbQKCI5L8whwxd8CVs1PZp3p4w7XBwTScRBUfd+17+3Dug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879024;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WfYij0hVeVgEYI/cvStrgYo7p6IrJGKSJkR5sb941Rw=;
	b=wiS1fFYlVzUHEOw1aRy1FcRdTy2BJYS1Qx6QAsrgcf78ZSF8jxx5j8Ecilxkb9QXdspd
	 h0FQInUeodHpYNSNY2VDoCxzktd6nLx88865S1PvY0Niae0Xj4hxmZkOZGetALdAKjEf+
	 XJPULf8FDLmRH+b/k3MdrPXoy6sMSGSQFKq8PC6x0GekUQCEAnL0IE0yLexx5UzS70QOY
	 f2jtr9HAzpJfhHi1zohmser+CsFsoCZGYgOhKNTS2QXxw9KaLbWkKiXqARlRGiXAfYA3G
	 /b2JCUk/Tf6qzq6w4Odru0l14C8jnHSGBcsJv0kICZ8B7EX9Tx23WqZXSIwPQ9gILFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqT1dZvP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD214606A31C;
	Tue, 17 Nov 2026 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqT1dZvP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A581F000C4;
	Tue, 17 Nov 2026 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879024;
	bh=WfYij0hVeVgEYI/cvStrgYo7p6IrJGKSJkR5sb941Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YqT1dZvPUTgc3AOTAYLVuQthDbKePul9AjuuIAlxg57WDmz89cKTLAciYWVWobPEl
	 8FVkr0fvFnDBiiTJddpJEDRLfJ/Css/kNocqBK0pmxYtCjYGGaG6M2Wq/CpOzYZHcn
	 IEW8mJsr1+q/agQro/dclwtgGftoIBxeQ73OuF5TLlB3+lLsohsjIUsTxkYhJx0ptU
	 f9/qENwCwik1mZWD/7zrVuarHDkYtzWos+Cf65pn3WFiIOoG4rRZZgcbuemFcjhJ2B
	 2xPneme4zGQAhvL4lhrRaQ0GNAfjI6rbNCunbt0PxZK3Ef7KgHQPaP8LQWs1hWLWI3
	 qUhJyAGL8s+Ng==
Date: Tue, 17 Nov 2026 01:30:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH v5 2/3] cxl/edac: Skip event records marked
 NOT_REPAIRABLE
Message-ID: <20261117013017.3e16c98a@jic23-hlaptop>
In-Reply-To: <20261108022022.3352-3-ai@linux.com>
References: <20261108022022.3352-1-ai@linux.com>
	<20261108022022.3352-3-ai@linux.com>
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

On Sun, 08 Nov 2026 11:20:24 +0900
Jongwon Lee <ai@linux.com> wrote:

> Bit 1 of the DPA field in General Media and DRAM event records is the
> NOT_REPAIRABLE flag. The device sets it when the memory at that DPA
> cannot be repaired.
> 
> cxl_find_rec_gen_media() and cxl_find_rec_dram() do not check this flag.
> A repair request that matches such a record passes the lookup and is
> sent to the device. Since the records are keyed by the raw DPA, this
> happens today when user space writes the DPA with bit 1 set.
> 
> Skip these records in both lookups, so the repair request fails with
> -EINVAL. The trace events already show dpa_flags='NOT_REPAIRABLE' for
> them, so user space can tell before it asks for a repair.
> 
> cxl_find_rec_gen_media() now reads the record, so take the xarray lock
> there too, as cxl_find_rec_dram() does. Also make it return bool, since
> its only caller just checks the result.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")

It's silly but broken?  I'd argue no. This feels like a useability improvement
to me rather than something we want to call a fix which suggests backports
make sense.

> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 4624ab4644..42683b7c54 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,27 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
> +static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
> +static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +				   struct cxl_mem_repair_attrbs *attrbs)

A find routine that doesn't return the thing requested seems misnamed.

cxl_check_for_rec_gen_media() or something like that is probably clearer.

>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_gen_media *rec;
> +	bool found;
>  
> -	if (!array_rec)
> -		return NULL;
> +	if (!array_rec || attrbs->repair_type != CXL_PPR)
> +		return false;

I'd split those two conditions as they are completely unrelated.


>  
> +	xa_lock(&array_rec->rec_gen_media);

Hmm. Was assuming there would be guard() available but nope.
Was proposed but nothing happened with it.
https://lore.kernel.org/all/20240228135352.14444-1-mschmidt@redhat.com/#r

Maybe worth resurrecting that. +CC Michal.


>  	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> -		return NULL;
> -
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>  
> -	return NULL;
> +	return found;
>  }


