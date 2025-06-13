Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B42D0267
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800662; cv=none; b=SJxt5FT/sa4AFJ+ut9oIC+nIfle/hU0eO+Z3/z3PwdsBM/uE9cVm/Nncd2bJ7R6xHfPmkGjuEtJjWKmwvxQfXUbOyi9UjrutNDUcAPyvtYp5wrqVmPdh/bheAOObNAtJqUxWzR6t7nfSmsf2gZlSVpcYpQt+ouZwsbKp9vObh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800662; c=relaxed/simple;
	bh=EnVnrBmOV7rIEgq7QH/fwD0t8DU3lxRyCJYZ7Y8djus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ2l4i/LQ/vy8YTTs6Mb4i7ZP3SaZ+hWQh8YHz44CEysLUXPCZfAVumgsqfV8RkgUQ84255XYhBxpIsvztpO97u8udOvSih2hpQ1OLGkZFkkFMOHGyFbc0H748bY4sGCAE2Lr3tT8JSl5/HnBopOmkGNCX/kM4sDNOg2rN1Vgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2h5ELs1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2h5ELs1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749800659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jGTjyGqgLpAkXFQhlYftBGt/d0bSUT/7S3I84fIEcgc=;
	b=J2h5ELs1rVil9IIK+ZXshuydWbZISTc/PSPQFQYCqX3p4hp403/KwC2S3O95gozjM6eqvT
	SrRjDEAUm/5ua6KyX/QjKBjaPaukQj8p/Jl64TEI3LcMZhR9Vo0zbMGJ33AzLWPGBopQQJ
	xAk93c/I9qZSSAGedcipg+AbQyFB3ck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-dGgYFOw-PS2R2AzTulvKCQ-1; Fri, 13 Jun 2025 03:44:16 -0400
X-MC-Unique: dGgYFOw-PS2R2AzTulvKCQ-1
X-Mimecast-MFC-AGG-ID: dGgYFOw-PS2R2AzTulvKCQ_1749800655
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso753221f8f.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 00:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800654; x=1750405454;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGTjyGqgLpAkXFQhlYftBGt/d0bSUT/7S3I84fIEcgc=;
        b=V6ccN0fNuV+ha6dyW7vPv6C3XM9Seoga3LwHPGr9QCgblKEPeMspef8ybkSu2k0D0C
         GpSAyeTAs3VD0CmhuhcfdzxHczCxxdtbgAVvLNHUzpSgQUerWnqKWXsOu31uu0Xs1H1O
         KGmO/+mD7M3L2AX0OsQAqSrnVj7Gt6FEcjjX2w23F+9IwVzerLj/LQGdfnEH7VepaR1i
         O7FPrj9hVBPsUmANPCv9hOAU0eVMqSasjqqdoCu2kddtqihhiTxfjthvqlJgfJY8YR2v
         9CaKFzDyEY+G5IYeslszlssiFjypA9MNd3Fx6v9BX1EqGtHgV/Mf8Kvju893OeWpNT8W
         YYaA==
X-Forwarded-Encrypted: i=1; AJvYcCXIBTIDx/cv8fEIArJuVAjCSOjBetohq/CVyedjOnishqR0f+8loTwd0K3zsYZZBKyZV9M/Jq+3IM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LFCyZRmphsRlSkUBgvgFSxR7XYhNLbvg648XfwktjHxqaWoJ
	PAqOCvvOBueg4gWS5qhd0uKyQhrKEykznAdCfAJI3N3RLJOStU8rrn3/y1j/1nBG/XHGaD7FWC3
	fZQtprcE1LqqZpnJ5HJ75C6E8RN8LDxAPOEBdZRdTsw8SCyqoDGKYQ+9jK8WL4w==
X-Gm-Gg: ASbGnctqaXzN66h4ciGGXJaQFFbJ/+8NpKxKIdEpI3J2r86PHC9pCbtBPhPBQbU0v0i
	Q5Eq2Mz/QDyo8ZmSPyPPlK5Lsev3aQA0QGgFee0eLe22+eAyhn2L/VYFt9r5EKIYI/QeYcSxOPx
	PECQly1Hj/ge8kHiXcDmnP8G613v+6zhjJO6XirgrSm80+iKGttAVYq9y2bp464Hfq8xANRWufx
	F1S5xdemXBkcAwVB61p8IGywbNLNfcyV4ugxGJRSgNaAfZOyiUROcmRaMU1dINrhGMA8CAA6Ofz
	Pvh14E8yu/0iCe4Y+RHsuzYYLjP0MGJ7mIN3SG8xGmHjFugOThF6MqwfQxDtMkSiSPqSwRZL9XU
	QeH7SPfUReXyJlUQ7DeiyY0OK+lVVW4u6fMIlYV+kmnBgwPjhlg==
X-Received: by 2002:a05:6000:2085:b0:3a4:d6ed:8df7 with SMTP id ffacd0b85a97d-3a568738d6amr1803374f8f.59.1749800654630;
        Fri, 13 Jun 2025 00:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl/T3bpZSTH6EemLwcTOlSFsSb99biE42PVbkwHnNV+UQgVHq5uEEmxu+Q9QQsb+MD/3RwxQ==
X-Received: by 2002:a05:6000:2085:b0:3a4:d6ed:8df7 with SMTP id ffacd0b85a97d-3a568738d6amr1803335f8f.59.1749800654148;
        Fri, 13 Jun 2025 00:44:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4? (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b09148sm1547927f8f.58.2025.06.13.00.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 00:44:13 -0700 (PDT)
Message-ID: <51520205-07f5-45c2-b3e3-cf58a95d9fe6@redhat.com>
Date: Fri, 13 Jun 2025 09:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/huge_memory: don't mark refcounted folios
 special in vmf_insert_folio_pmd()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-3-david@redhat.com>
 <434c6cfd-ba83-4d3c-8bde-736fcb8e9d91@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <434c6cfd-ba83-4d3c-8bde-736fcb8e9d91@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: koDORSjW8qHn-SpPkFOwsxf2sp6077ht65iMjmQtJKU_1749800655
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 18:10, Lorenzo Stoakes wrote:
> On Wed, Jun 11, 2025 at 02:06:53PM +0200, David Hildenbrand wrote:
>> Marking PMDs that map a "normal" refcounted folios as special is
>> against our rules documented for vm_normal_page().
>>
>> Fortunately, there are not that many pmd_special() check that can be
>> mislead, and most vm_normal_page_pmd()/vm_normal_folio_pmd() users that
>> would get this wrong right now are rather harmless: e.g., none so far
>> bases decisions whether to grab a folio reference on that decision.
>>
>> Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
>> implications as it seems.
>>
>> Getting this right will get more important as we use
>> folio_normal_page_pmd() in more places.
>>
>> Fix it by teaching insert_pfn_pmd() to properly handle folios and
>> pfns -- moving refcount/mapcount/etc handling in there, renaming it to
>> insert_pmd(), and distinguishing between both cases using a new simple
>> "struct folio_or_pfn" structure.
>>
>> Use folio_mk_pmd() to create a pmd for a folio cleanly.
>>
>> Fixes: 6c88f72691f8 ("mm/huge_memory: add vmf_insert_folio_pmd()")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Looks good to me, checked that the logic remains the same. Some micro
> nits/thoughts below. So:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

> 
>> ---
>>   mm/huge_memory.c | 58 ++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 39 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 49b98082c5401..7e3e9028873e5 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1372,9 +1372,17 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>   	return __do_huge_pmd_anonymous_page(vmf);
>>   }
>>
>> -static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>> -		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
>> -		pgtable_t pgtable)
>> +struct folio_or_pfn {
>> +	union {
>> +		struct folio *folio;
>> +		pfn_t pfn;
>> +	};
>> +	bool is_folio;
>> +};
> 
> Interesting... I guess a memdesc world will make this easy... maybe? :)
> 
> But this is a neat way of passing this.
> 
> Another mega nit is mayyybe we could have a macro for making these like:
> 
> 
> #define DECLARE_FOP_PFN(name_, pfn_)		\
> 	struct folio_or_pfn name_ {		\
> 		.pfn = pfn_,			\
> 		.is_folio = false,		\
> 	}
> 
> #define DECLARE_FOP_FOLIO(name_, folio_)	\
> 	struct folio_or_pfn name_ {		\
> 		.folio = folio_,		\
> 		.is_folio = true,		\
> 	}
> 
> But yeah maybe overkill for this small usage in this file.

Yeah. I suspect at some point we will convert this into a folio+idx 
("page") or "pfn" approach, at which point we could also use this for 
ordinary insert_pfn().

(hopefully, then we can also do pfn_t -> unsigned long)

So let's defer adding that for now.

> 
>> +
>> +static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>> +		pmd_t *pmd, struct folio_or_pfn fop, pgprot_t prot,
>> +		bool write, pgtable_t pgtable)
>>   {
>>   	struct mm_struct *mm = vma->vm_mm;
>>   	pmd_t entry;
>> @@ -1382,8 +1390,11 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   	lockdep_assert_held(pmd_lockptr(mm, pmd));
>>
>>   	if (!pmd_none(*pmd)) {
>> +		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>> +					  pfn_t_to_pfn(fop.pfn);
>> +
>>   		if (write) {
>> -			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
>> +			if (pmd_pfn(*pmd) != pfn) {
>>   				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
>>   				return -EEXIST;
>>   			}
>> @@ -1396,11 +1407,19 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   		return -EEXIST;
>>   	}
>>
>> -	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>> -	if (pfn_t_devmap(pfn))
>> -		entry = pmd_mkdevmap(entry);
>> -	else
>> -		entry = pmd_mkspecial(entry);
>> +	if (fop.is_folio) {
>> +		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
>> +
>> +		folio_get(fop.folio);
>> +		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
>> +		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
>> +	} else {
>> +		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
> 
> Mega micro annoying nit - in above branch you have a newline after entry =, here
> you don't. Maybe should add here also?

Well, it's combining all the "entry" setup in one block. But I don't 
particularly care, so I'll just do it :)

-- 
Cheers,

David / dhildenb

