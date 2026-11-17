Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877404;
	b=c8nRnZw0FSgWwruuBxuOUd6i7p6LS6KQAsViBmb4Xh3ZEDI7xEO0J7AMmnOJk3a7+HEp
	 ZKrPE48bVlvUtwJwxo5W7lbziw/DBiaTyWJ1+f3T1ACeJwzdtye/sE3ijt+ILEkeyMEj4
	 RyBuaUqa1IGFnOFOLwUSAUTKGLxWPYy8YqsEL9OvrauJg5fnC44zZsmfuEyrerPujDb0V
	 VzNaaoRlzJOegGrtDAwpdKBtdL4dpr+ElSI7IsPLCWfVoIaE/eX2f+P2DswzDtuO0vByc
	 Nnm9c6Lkx7XFv3vfM+4DaligY+Kwi+2R2+4Xr8lcOcDorvvD+3Kb3WzWy73OrX0zbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Q8xRj1Homj/VTvTcbwqPDSEFGebgrQcuNK0zuIg1sPk=;
	b=fAfiIBZN2mv5gNAWvWbEUo5KhkdX1/q2Kc3npiokoYBaf0BEo3/cN32l2xK36B9N3E6q
	 wu2SIoynDRVuw1E/ImjJ/1EunOnOLjf1Rr/7IvB+NnAmk2/klH6OQH84yqLepFG2nG38V
	 IfPbEPDQhIJ6EgjfMdqL+9xPDIKSbiGkuyUWowI2GJPiIgd2IPgzabg1KJAxZptRqxWRR
	 sS+4dsXGV97MADJpczG9FGJQjrSiR1/7uu4BW292v0QEJIgCXhF9DWk1aA5BjgANqkUD4
	 Fur3QC/mD5HaPkHPTLiVY30MQo48YvRYLkYQEcp3S8ZGhUd6sZszarqFHZyjoRhUYwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJgeIx0L;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266C606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 01:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5266C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJgeIx0L
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5327596eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 17:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794877402; x=1795482202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8xRj1Homj/VTvTcbwqPDSEFGebgrQcuNK0zuIg1sPk=;
        b=zJgeIx0LaMdjhlYxD44HyALbgxnMk5ITiG4INp5yFDEwqxAKQ+Z8mvUgt5EsSdyRs0
         lI1uKVfXkO708gLETJaKoa1H3CiDaud+DPFQfGbjsyItoU2lgI+KHOZVVY0K+KofEH3P
         ApZwfeR/Ztxp66cQrrBeLG8UVTAH0r+k/K6Ik315R2cLgvmFqGGT8T6BPfl/pD1wsC3o
         lYOynhbKvUpSzHjObYwLSnc4z9D6qVHU3T8aC2OWs/cpOOw9OFgjYqq4ScVLsVayQryl
         XX6XVJlMQSCN39AZW95ptzrCuH12WNOv0iGe2scA8v40QbNv7pTWecagE+tq2JRMqwqL
         t4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794877402; x=1795482202;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8xRj1Homj/VTvTcbwqPDSEFGebgrQcuNK0zuIg1sPk=;
        b=jdwDUs9794CZudGRo/7DNsurjnMtZoG7L0YO5CjUZAWqihey0AvGmAdrfxRCixW8uv
         6G7n9vfyo8haVN37J/o1rqavHJNT7TkB5bjFIAlp2cSd23sAd9qXwLMeKEPBO17V26cb
         joa54Yu81UqZ0BWt5CY6DPn0vQeSNWBaANzjyGUY/6PwahA0UrH3NSk9GrtXlJHsX3ec
         9ewxi6LrH4VqddmGs5x6SzMCIhI60IARZh3sxSuduAmxw4yxXkXHQ1hzkpNEw2ZIR08J
         dW5a/Ftq9UGVcyXkFJl6PXUtgSGxsa8U5RyjZ8w77lQnGmNyJKtQ3/8XEmvdEejFv7Hj
         qb8g==
X-Forwarded-Encrypted: i=1; AL+hErGoblbb5wBKModMOJA63BtT8z03krOuvuhaqskziGsoymbWboiEqeRFd8Un4lymlNrjx/su2Xpr7uA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eOIme6bX9dj6ig9KXdGN4Z+MSbqgn0shMQCAVJjFwdHEonrS/
	HTbK2zZ/WuLu8/J9bIzEnYj/8j6lRr550LamWvZxI0mj4GvyZRrG3TSn
X-Gm-Gg: AYBFou1A8HxO+rliSrrtJfYWV4NDOC79TjvfouoIFXsX7X+1zMb9zq04gz/Ue+AXuTw
	MPGu3vcaFU7R3WKZRcz7i2xbUuNwdsso8Hc/G6B8GRbb4hWgEcDtoC+hR4hXrhBWQ3Ya729uyzD
	3Zy+oJzfqJdpRryQGWdMzuhVX5CU7YQU8QUQsdMCTrXwOSMTNyIxDsdFpGzAgrgv7PRP4QgGCtJ
	LUSWmkU3kDEKl3MxIPlW9P0aR5ghzXD0CCPfrL121pERqWa7se8Jq2R/aI/xzFuJljU09xf6t6k
	r6voBAJ2NXNru20V3M/SvU2gkil7/L/L1oCnQKEXLsqoEw1b0cCHe8xQfO4zBWVM9Vj7NkFuXpM
	Du+zbaMlBRic9ikM6vV4Cuz/dXgKwuT9Lq2Ob0oSKvy2DrsAzRXFgpqZjTsMfZCifex8LLWVofa
	B5t3pTjtKzUvkctrAZvPodTX/c9T7Du9+Ilqn7EDC+iUwJ2HwCe0t5d9j0rxp2nBo2w5O26tS14
	X0gSNWO9fig04T9ue6H3Ies6ZI/JLbD3ziGCbVoSaRWyrfhDRYjfuUbt7dFWzT/kwSd+rs3QZu/
	2zEQFRS1tNjlaoe1bzlgNYdfrqAhPedn7A==
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id 5a478bee46e88-37967dd4c20mr11790852eec.25.1794877402316;
        Mon, 16 Nov 2026 17:03:22 -0800 (PST)
Received: from localhost ([115.99.200.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm37778195eec.10.2026.11.16.17.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 17:03:21 -0800 (PST)
Date: Tue, 17 Nov 2026 06:33:19 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 2/5] cxl/region: Factor decoder poison-list retrieval
Message-ID: <avun1x_x1UK2yWjL@acer-nitro-anv15-41>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-3-shaikhkamal2012@gmail.com>
 <20261016232103.6497bbb2@jic23-hlaptop>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016232103.6497bbb2@jic23-hlaptop>

On Fri, Oct 16, 2026 at 11:21:03PM +0100, Jonathan Cameron wrote:
> On Sat, 10 Oct 2026 21:50:10 +0530
> Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:
> 
> > poison_by_decoder() performs two different operations: it queries an
> > unmapped DPA gap preceding an endpoint decoder, then queries the DPA
> > resource assigned to that decoder and its region.
> > 
> > Factor the second operation into cxl_get_poison_by_decoder(). Give the
> > helper an optional snapshot so a later region-probe caller can retain
> > records from exactly one mapped decoder. Keep the existing endpoint
> > walk, skipped-DPA queries, partition-tail queries, -EFAULT handling, and
> > trace behavior unchanged.
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> >  drivers/cxl/core/region.c | 41 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 75b8092e6dc2..c72524923b38 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2940,6 +2940,40 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> >  	return rc;
> >  }
> >

Hi Jonathan,

> > +enum cxl_poison_query_policy {
> > +	CXL_POISON_QUERY_DIAGNOSTIC,
> > +	CXL_POISON_QUERY_PREONLINE,
> 
> For now, perhaps focus on flags defining what you want done, not when the
> query is happening.
>

Make sense. I will drop the enum. The snapshot argument already tells
the helper what to do: NULL for trace path, a snapshot for region probe.
The helpler will return the error unchanged and each caller will handle
-EFAULT itself, as poison_by_decoder() does today.

> > +};
> > +
> > +static int cxl_get_poison_by_decoder(struct cxl_endpoint_decoder *cxled,
> > +				     struct cxl_poison_snapshot *snapshot,
> > +				     enum cxl_poison_query_policy policy)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	enum cxl_partition_mode mode;
> > +	u64 offset, length;
> > +	int rc;
> > +
> > +	if (!cxled->dpa_res)
> > +		return 0;
> > +
> > +	mode = cxlds->part[cxled->part].mode;
> > +	offset = cxled->dpa_res->start;
> > +	length = resource_size(cxled->dpa_res);
> > +	if (snapshot)
> > +		rc = cxl_mem_get_poison_snapshot(cxlmd, offset, length,
> > +						 cxled->cxld.region, snapshot);
> > +	else
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length,
> > +					cxled->cxld.region);
> > +
> > +	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM &&
> > +	    policy == CXL_POISON_QUERY_DIAGNOSTIC)
> 
> This is becoming odd enough I'd add some comments saying why
> we are eating the error return.
> 

Will add one. A device that keeps no poison list for volatile ranges
returns Invalid Physical address for them (CXL r3.2 8.2.9.8.4.1) which
comes back as -EFAULT. The trace path treats that as "no records"
instead of failing the whole walk.

> > +		rc = 0;
> > +	return rc;
> > +}
> > +
> >  static int poison_by_decoder(struct device *dev, void *arg)
> >  {
> >  	struct cxl_poison_context *ctx = arg;
> > @@ -2971,11 +3005,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
> >  			return rc;
> >  	}
> >  
> > -	offset = cxled->dpa_res->start;
> > -	length = cxled->dpa_res->end - offset + 1;
> > -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> > -	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > -		rc = 0;
> > +	rc = cxl_get_poison_by_decoder(cxled, NULL,
> > +				       CXL_POISON_QUERY_DIAGNOSTIC);
> >  	if (rc)
> >  		return rc;
> >  
> 
