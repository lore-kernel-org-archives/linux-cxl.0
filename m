Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74C3BF68F;
	Fri, 16 Oct 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189274; cv=none; b=l8liQ3MwuU8KRtZAhf2baoCS823Jbz4y48lDV8aNcVpqO1PsjnYhIkOmg2Fm4R8CR+W1mV1LDevvACrR/S5R4qNNIoNec3z/nUWXLhUqHxgaRo8ID8ic/i2oCek9L36I4rDMncWjThhBPttgBPVB70KSpB/3tQxjqEc95+G0Di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189274; c=relaxed/simple;
	bh=+z0PHAHEj59swJPq5Nlxstw7bKvLCyU91OGO7P0W8As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpGzWQ/ckksIHjA0J2NAc6cYzyr2FmTC2IODPAzpK2k9qZzXIdrTEQixw3G+aEtKPsT2zk2g5AMLqOc3x5czQkV3hhCLnxdNeURNLAkHLwGpVzNE5ENlwe0bC1/OTJITeLAibT15IOkytakBV9lyIKQaoPVPMdlooKBPLwN8oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLutAh9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLutAh9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B971F000C6;
	Fri, 16 Oct 2026 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189272;
	bh=JbtA90jSYbvjWaAUht/ufzHaPdDcdPFD56WPRraPHlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YLutAh9hSCOh6gtplRHRSIQlgjQ3k26KGbWzUG4uFVnvCToVBjgeiOCUZGpysnN5C
	 +w4WXEJTJ1BNR9Vr2u6wXhbiy6Oq9ama6WongS/4PHUrwyPRWFFH/FCirjbC1heIgK
	 /o7VsuTXuC5gSDJzRdKLq9PNqqWoa2LItHW0crT8mOIP4Y6WK/Nf34xKU73xB6UaJ+
	 SywUNWx1sOSxrE8zMfgbCuWlZ8bwzx8IVBp4ytcApMSBmLjMmY5uB4PaFMmtqv589h
	 J4ANggi93+r9PZAPBIIpK9dvAEjnoYbgNB1+3CPxyXsAbnX8+ksOHVZZLMVehAjeJ/
	 RVS/DaVoujrOQ==
Date: Fri, 16 Oct 2026 23:21:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Breno Leitao <leitao@debian.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Kiryl Shutsemau
 <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 2/5] cxl/region: Factor decoder poison-list
 retrieval
Message-ID: <20261016232103.6497bbb2@jic23-hlaptop>
In-Reply-To: <20261010162017.62506-3-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
	<20261010162017.62506-3-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 21:50:10 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> poison_by_decoder() performs two different operations: it queries an
> unmapped DPA gap preceding an endpoint decoder, then queries the DPA
> resource assigned to that decoder and its region.
> 
> Factor the second operation into cxl_get_poison_by_decoder(). Give the
> helper an optional snapshot so a later region-probe caller can retain
> records from exactly one mapped decoder. Keep the existing endpoint
> walk, skipped-DPA queries, partition-tail queries, -EFAULT handling, and
> trace behavior unchanged.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
>  drivers/cxl/core/region.c | 41 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75b8092e6dc2..c72524923b38 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2940,6 +2940,40 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +enum cxl_poison_query_policy {
> +	CXL_POISON_QUERY_DIAGNOSTIC,
> +	CXL_POISON_QUERY_PREONLINE,

For now, perhaps focus on flags defining what you want done, not when the
query is happening.

> +};
> +
> +static int cxl_get_poison_by_decoder(struct cxl_endpoint_decoder *cxled,
> +				     struct cxl_poison_snapshot *snapshot,
> +				     enum cxl_poison_query_policy policy)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	enum cxl_partition_mode mode;
> +	u64 offset, length;
> +	int rc;
> +
> +	if (!cxled->dpa_res)
> +		return 0;
> +
> +	mode = cxlds->part[cxled->part].mode;
> +	offset = cxled->dpa_res->start;
> +	length = resource_size(cxled->dpa_res);
> +	if (snapshot)
> +		rc = cxl_mem_get_poison_snapshot(cxlmd, offset, length,
> +						 cxled->cxld.region, snapshot);
> +	else
> +		rc = cxl_mem_get_poison(cxlmd, offset, length,
> +					cxled->cxld.region);
> +
> +	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM &&
> +	    policy == CXL_POISON_QUERY_DIAGNOSTIC)

This is becoming odd enough I'd add some comments saying why
we are eating the error return.

> +		rc = 0;
> +	return rc;
> +}
> +
>  static int poison_by_decoder(struct device *dev, void *arg)
>  {
>  	struct cxl_poison_context *ctx = arg;
> @@ -2971,11 +3005,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  			return rc;
>  	}
>  
> -	offset = cxled->dpa_res->start;
> -	length = cxled->dpa_res->end - offset + 1;
> -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> -		rc = 0;
> +	rc = cxl_get_poison_by_decoder(cxled, NULL,
> +				       CXL_POISON_QUERY_DIAGNOSTIC);
>  	if (rc)
>  		return rc;
>  

