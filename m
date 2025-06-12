Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE532BE7C7
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751186; cv=none; b=MyY/LH+ncXLhbiyK/uTm9NqFGSarg/AOIXRyEIE5kBlkU2c63kJ+2K1RQPqLx+KAO+SPN5cYJVDDrzchQGRNAS4SK2G8Ur6XKebuuL2vx/Mcksl+hnrbidVMdGfDdGyNXsYKUAWCJOk/4Ck4vzxRnrcnIds/jrjBZU1mobTFjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751186; c=relaxed/simple;
	bh=/KcpP3sd6NE+ea6NDiYmJmS5AFVotPbnqQ+fVjozi/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/a/MdVv+iT4YCuhZItdfrLleLumGwUvKjK10euN9YJjL10yMTppQRJyHP5HNrJLK8RgeV1yYQ3WqBnwzMN/XUJvQmtyZ25KwemeJcaj2HXvSxy1UcO6t9HE3oNd8I2nOJcie+hWTS1a5PKjHVn6SLKlWT48gevAOUUtkH17eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h2k6C843; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h2k6C843"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad3400ea3so13091276d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749751182; x=1750355982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXTM+CkzUjCCaEkCj05xO9AKr6j3JG1MebSjEIdnf+8=;
        b=h2k6C843agjUUgv1Q/R2zJPTAsW6UcO/gZjV90884j3oQ2uUnDBCygC+t+9BqY9VU1
         x5Bd1PFBMpjKL9/zoLqAElwmSqRcRSCTpq8wiYicbqYaKd3UAI/zI23PKtcUEzjAH3g/
         4Tebv6cx07Up2YbEm6A97MEQvuvn7GLnLttOm8HTjVSXVh06VsimxJYSGlzgH3kTHvTO
         mzGgkbGPjUcbDZddOYdjy0KUUENqZaPg+FiJ+ija6NJ9MMejzRIDO5f+Eq0K3rF6+/7g
         xLvF6iZWkuWax2TYklmVU49HMSVzcqzIr3c48DbZGEM//zYxk6n0C/UDASe2mP55yWhE
         BRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749751182; x=1750355982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXTM+CkzUjCCaEkCj05xO9AKr6j3JG1MebSjEIdnf+8=;
        b=GqW48/EFnyBobJYpEpqFxeeNlHA2xJeLs8t1KB6k+SXxV/gWQTsEc6NX3iAHZWcXXm
         kmhy/VB6Jf0gSTTFQYqSTgKMEnKjzCnm8xXSuum7enxdgNpu1GC8TVHNqhUoGmqBJ8Zs
         0dgNNanlDPANKp+AcQffJ8yJIiZoJywpDkv/JSi+vbfhR0OwLpIKIBeo1xafSu131kNs
         c+iw8eygbMytFEnpajlFL3yWmU+Z57v+jBVSZVyVb0LzMOxvBb1/Mvq0bpXCy9HsghmU
         edjE1pujnmznRIUSq6I1vZS+v3LM2KOryUzJzighT4TDzREFtEhNXtKqvT3i+x2deX/Y
         c87Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWdV5j1djkBUUzS6jWfjt6uKJb7FZhDnWvtMivov0mKNzvc0bk3vb6b8QytRSfYrD4Ce5whowR4yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8IJarahJPMAN+gBbTW5wgcIXSAUXUDtyR9cT8FdLB4qhKGacs
	x2eybO4GUFmU/0KzKyesOuBfMO9Hk78OyDC2brN7h3L8hMDdGZHYkUkm5PvgYDIumVw=
X-Gm-Gg: ASbGnctdJOkwLIW9kkztn7y7Fs+fQDKdu0fJWZ0wWDKQ9RVM9IhnuJdsDpUCzIvCr/k
	ZghAPegcJYY1p+ge0MdiAlcHGyuk1/JeEzEVDN+MisoBCtTw15xojF/btSsYW1SmgRd/IWg+L62
	79zs0CxhqCtrsHbFgQN834FOc/3crrRIyvZIIKoZBSd6dPJtto5n3JMJe3hfYlN1zZmx9dr8iIT
	0Zqpk0UrumN8OvJh58ukUA8XqPAkynKpTJg624hBJk5uFh38RqK+uBOfegeQfeHh+KTsn4AhHuT
	MyfzpkYUt78+cwSBxjUtbnPcn6pT946OPgoRyHw4SOnh4rdo1j+QaFU5UbmrnJfHKz5a9DgG/dM
	pkfA+aakhemuIWWvLVzJqeGBvxJXmkZBCLLkC+Q==
X-Google-Smtp-Source: AGHT+IEsvSci92g9GrvFGh5NfCjtusJYIMdN3N/cEr2P+xXcnfBxDJAll2rQe2ppsiqe5qWlDpXtYA==
X-Received: by 2002:a05:6214:224e:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-6fb2c334737mr142643026d6.19.1749751181973;
        Thu, 12 Jun 2025 10:59:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b2f9c4sm12808026d6.26.2025.06.12.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:59:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uPmDE-00000004kef-3k63;
	Thu, 12 Jun 2025 14:59:40 -0300
Date: Thu, 12 Jun 2025 14:59:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/huge_memory: don't ignore queried cachemode in
 vmf_insert_pfn_pud()
Message-ID: <20250612175940.GA1130869@ziepe.ca>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611120654.545963-2-david@redhat.com>

On Wed, Jun 11, 2025 at 02:06:52PM +0200, David Hildenbrand wrote:
> We setup the cache mode but ... don't forward the updated pgprot to
> insert_pfn_pud().
> 
> Only a problem on x86-64 PAT when mapping PFNs using PUDs that
> require a special cachemode.
> 
> Fix it by using the proper pgprot where the cachemode was setup.
> 
> Identified by code inspection.
> 
> Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
