Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879569;
	b=lVAGkynUPa30vTmsTlIlarQRzKGxj3SfYIFSaUgo1dVZAl5XWmX+U5kgOFCrvs/mgVYG
	 JEUHj+xLDNIZ04QXM9Gjq83ZRVQyxApbr0O6+8lpxib7qkt7u2JC6PucR7N1Sr+dWky7n
	 XJUIkCwzO9I76D1dTkhY9wVJHKhhBz4OZyruoCj3xBqmv6WLQgKlZ+ZpxBP+tXyzC3wK5
	 x/HqU64pUwYkftrz9QejCw8hqQ5NJmgLbmwesYVzOzm21d49a0uqZeFQ1uSz4AbIMyoF0
	 ZXgDJJq9g5xzA+kY9ruAzIE/TlmdqH81AqRbKAND/4zdlH716HtizriqyXTFYjPYRBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZwcKtO5V+ww87liNFj54k/wH7eamQ9JyikSUSnAv7KE=;
	b=GzjpBqp2gvQQv9IlujXKD+apIxcymvYzTiAS/be7HrhbSh7nIE+p5xAzX6o8wclidBkl
	 90oXRKtWlyV0/7BM3AC0L53jNrDsL6CjZe3A0SkLUZezge3kRdoMohmYjVgf58yHV0XFs
	 WURtqmJKJXdHTql93fhcAKLaxOcUvO+yw2YuMtGLTIVfhVCzGsSB6x913ZH1DRdZOBuDS
	 z1IFgbcPkOBGhIoe8e6M62Nxa2RNXXcqvnskzX4yLKhNIOedMrGtlGYT/Cf1hNqmNBiT1
	 ufeNCv6vmkGMA6rlOhdTJh4+nRB8osMpae7NNkbAFZEOdCnC2wKoTwhyMDLP/sWr7ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZKTzqKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD60606A31C;
	Tue, 17 Nov 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZKTzqKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97B71F000C4;
	Tue, 17 Nov 2026 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879569;
	bh=ZwcKtO5V+ww87liNFj54k/wH7eamQ9JyikSUSnAv7KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WZKTzqKS9mqL5M+fP5EgR7GQ8RGrGEBZxY+LRGJENZsqt8070HgoNMRFf6gWn17PJ
	 2QTctvB+Hwtr7EEsudvJou6encXDPTnqWDlajA9mIcjoVmvn3oDfuAteebuFYAGZAh
	 J6ZZKO5Rq0/Tzv4G4DoCzVckiXgU5g4/ZHmI2IMFyDxib/cjf2hCMFT9RgQasGyGdf
	 sgN4FTqAC9Qzg4HHs639bT4n3lQwZ43IS05BJp5tKVMMQN5uNkLD2ytUTv2n08//nS
	 kXonQqX3iI08pkoEp3KbpKGUJITkP5FLTrJzT97eNexeKbyn/SuSjgPYylfmQFh7wg
	 Qm4Tg0aDV3ZJQ==
Date: Tue, 17 Nov 2026 01:39:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cxl/edac: Mask DPA flags in the event record
 cache key
Message-ID: <20261117013922.41f4ee3d@jic23-hlaptop>
In-Reply-To: <20261108022022.3352-4-ai@linux.com>
References: <20261108022022.3352-1-ai@linux.com>
	<20261108022022.3352-4-ai@linux.com>
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

On Sun, 08 Nov 2026 11:20:25 +0900
Jongwon Lee <ai@linux.com> wrote:

> The low bits of the DPA field in General Media and DRAM event records
> are flags. Bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace
> events print the DPA with CXL_DPA_MASK applied, while
> cxl_store_rec_gen_media() and cxl_store_rec_dram() use the raw value as
> the xarray key.
> 
> User space takes the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record has any flag set, xa_load() does
> not find it and the repair fails with -EINVAL.
> 
> Use the masked DPA as the key. Records marked NOT_REPAIRABLE are still
> rejected, because the lookup skips them.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>

Huh. That's a gaping hole in our testing :( I guess test cases were non volatile
or we had a bug in the error injection as well and it never set that bit.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> ---
>  drivers/cxl/core/edac.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 42683b7c54..f627c73ff6 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,6 +918,16 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static inline unsigned long cxl_rec_dpa(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
>  static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
>  {
>  	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> @@ -1131,8 +1141,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> @@ -1161,8 +1170,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);

