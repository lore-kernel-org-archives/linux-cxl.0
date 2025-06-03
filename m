Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90071A2643
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988180; cv=none; b=gNSvvfNhVavPj1FsBh9LudN2STgv4mh9Rbe2ttM66OYKOQcOQwUVz25IF29mZS6w09Z13cgiuP5z17LghJfiY9hbs8Dbcg4/u1T/W80AO4H1OO8kDf/9KTt3L/MtxGBz+Ajwe7jxFKjEq0iHUWWVsuuCb0VCCv8DjjvgSVyXBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988180; c=relaxed/simple;
	bh=eajd9EavqBNsUT4SvCuI/74b+H2G9N7rEQZ/+V/rvPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdzBqgPA3JBUs6CGEKfqqZJ4JZV0kRs5GhCcg9FUGKDGNXtiX3fBP8nkuUxJwot2zTSw1bvbis43OLjHzFqgaWj+KtLA6d6mLdtBZAjVVPo7CB//D9Qw256qWWUAx0F/scf6O3TjufC6yp4qW7dp4Hka2pQ4Y3qOBLj8HZL5qgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/xtzrQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/xtzrQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748988176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eS7f7quUUty4CLA6etNXIneQrPITZcpqBLU3n/eJmMA=;
	b=H/xtzrQAvJ8VVBevXMRSnXgP0y//rXG6a58JCTDSGyI1TdaOD9nm+mSBK8mYZS6eBf9vqy
	/aGoD6d38hP1K9vpxfQNNA0r+aLXvvrjnJd57WDBk2o7DYq2L9lybv7BM2KYUAsrhQ9cw6
	sn6RBnXSXuTHNWyXDZN5ney/VDREIyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-2XvA3f2ROJi29zDs8Xe8WQ-1; Tue, 03 Jun 2025 18:02:55 -0400
X-MC-Unique: 2XvA3f2ROJi29zDs8Xe8WQ-1
X-Mimecast-MFC-AGG-ID: 2XvA3f2ROJi29zDs8Xe8WQ_1748988174
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so1868134f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 15:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988174; x=1749592974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eS7f7quUUty4CLA6etNXIneQrPITZcpqBLU3n/eJmMA=;
        b=GzxAIQMr6qM1X169E1TyrjIWPb104ufc5LI6xYTKsIuMzut/AM+dtNH1ymytnCAPzn
         bhYywJhiUHqpS4V+i1TwcIiBTXBM4WLzjhx1nbZTqajfaLyy4RIxvIafJ0G7XoleedCc
         DaCLxQReITL768O15OX56GvyB9+x6Rb8oAnGQ2y71kl57IQQxyg+ULalYdmitXXWT0O/
         UonA39xDhKpTjMSgwnb4YYHjxeYQM4hJLv17MgimQJwyDLgGc+tmKFCVIu8AIasZ2au3
         ezuQzMa2Yg+Ne+J7zhNHqFbvomZ7SmGZCPW3YY5Hmuy7A8MElD8XYl8Ev1z2qcNj34te
         n54A==
X-Forwarded-Encrypted: i=1; AJvYcCX5h05CCrIPA7uMbjBYN8vTgHoae3wXUBHD7ybr33fjy8tTZpcZvtwFp/V0LIp1h/Ew//zdpqmb2Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cKH4RHNoNjOaryntSl5DPO8T7VQGeg5iV71Qcz4kekq75Umi
	FY4Y1W9b76vntIdL6nSHlLBxk/SIFWzyxu1L/YPxthkyAi8/cLUu8goWfAU+Oy14odYKqNt2NUt
	Xb59bUvFRDn6bY+lZSegboKFsT3hAG/BQoSiBkOculgoLclyLWlvb+PU5/CY2aQ==
X-Gm-Gg: ASbGncsg4iFaDFEiectDo+q1pri/YBM5cVNNfVBg3zYxrUE85fdv74TfOoFj6iCbITc
	QatHT4/EdxIV5bOUG06ai4nUzl4/d9BZz03lX8oyiXV4m4J5B5RLfJkc2POfQg2OH9k/e1J0o4P
	Wxo86f42uWFP2zjAO1Xmk21K3DXHB0iithSqAkvBr1KgaP7P2v/+Xd9Q0hSDwJc1Zl4K3YQrpMa
	EkTKJOmXW2lvcV/V6XSJ3WkQiLKaYiyf04gm6apGbmfRKq1oymwhjGXYZMk5Sc6BbGUZlkd+1Kn
	P6QLZAEX9T/xhSQJIXNEi9/3iigWdPSawISngb8e1qsOi41ln/ZpqgN/xUJzxl3JOi0TAaUbdz7
	h7O+YtUe2KkHgydEX0cavxOdMClNWRV+9UdpKJKFmupjLH7M79g==
X-Received: by 2002:a05:6000:144f:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3a51d8f6a52mr292320f8f.10.1748988174395;
        Tue, 03 Jun 2025 15:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHKGIadPoiOp938yNpY7WW37URrLF4uvDP2tSTNNwKFPpxKIBCxv1en5PPiTu2Tlm6YnhSjg==
X-Received: by 2002:a05:6000:144f:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3a51d8f6a52mr292280f8f.10.1748988173962;
        Tue, 03 Jun 2025 15:02:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed32sm174020795e9.1.2025.06.03.15.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 15:02:53 -0700 (PDT)
Message-ID: <d43be0c9-cad5-4712-813b-225e9969d84e@redhat.com>
Date: Wed, 4 Jun 2025 00:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/huge_memory: don't mark refcounted pages
 special in vmf_insert_folio_pud()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250603211634.2925015-1-david@redhat.com>
 <20250603211634.2925015-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603211634.2925015-3-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t5oL06hADUikvNbkTpMVfy1Pxu2gAqsqlkGbzJSOq_k_1748988174
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 23:16, David Hildenbrand wrote:
> Marking PUDs that map a "normal" refcounted folios as special is
> against our rules documented for vm_normal_page().
> 
> Fortunately, there are not that many pud_special() check that can be
> mislead and are right now rather harmless: e.g., none so far
> bases decisions whether to grab a folio reference on that decision.
> 
> Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
> implications as it seems.
> 
> Getting this right will get more important as we introduce
> folio_normal_page_pud() and start using it in more place where we
> currently special-case based on other VMA flags.
> 
> Fix it by just inlining the relevant code, making the whole
> pud_none() handling cleaner.
> 
> Add folio_mk_pud() to mimic what we do with folio_mk_pmd().
> 
> While at it, make sure that the pud that is non-none is actually present
> before comparing PFNs.
> 
> Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h | 15 +++++++++++++++
>   mm/huge_memory.c   | 33 +++++++++++++++++++++++----------
>   2 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667af..047c8261d4002 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1816,6 +1816,21 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
>   {
>   	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
>   }
> +
> +/**
> + * folio_mk_pud - Create a PUD for this folio
> + * @folio: The folio to create a PUD for
> + * @pgprot: The page protection bits to use
> + *
> + * Create a page table entry for the first page of this folio.
> + * This is suitable for passing to set_pud_at().
> + *
> + * Return: A page table entry suitable for mapping this folio.
> + */
> +static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
> +{
> +	return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
> +}
>   #endif
>   #endif /* CONFIG_MMU */

The following on top should make cross-compiles happy (git diff output because it's late
here, probably whitespace messed up):


diff --git a/include/linux/mm.h b/include/linux/mm.h
index 047c8261d4002..b7e2abd8ce0df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1817,6 +1817,7 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
         return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
  }
  
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
  /**
   * folio_mk_pud - Create a PUD for this folio
   * @folio: The folio to create a PUD for
@@ -1831,7 +1832,8 @@ static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
  {
         return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
  }
-#endif
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
  #endif /* CONFIG_MMU */
  
  static inline bool folio_has_pincount(const struct folio *folio

-- 
Cheers,

David / dhildenb

