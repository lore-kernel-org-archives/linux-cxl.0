Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63014C85
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745359; cv=none; b=alRBAn3Gj6yXSvx1fpcbexCJYw9cqJMRiaDZub7iQ2Njz4bYCiME/cC/cXPz42OcvqSuqWctQ+B8elWsHM1gZktn0XLH/azqsaXmLYJNm+Jc1G3klGPuI1tCEjzoWxbO+CwEe0y920XQRbZTMvrSkOV6+lmkXr5YF5D/im3HeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745359; c=relaxed/simple;
	bh=Al0mJHRZrvoZ61WtSk0Ko36r2Zf9LmbijIUvRuOou7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8i8/Kcx86dwILQK/Vu2qO1kK9Amo9f/nGSHaFDz+KBWpsxum8s5Z7PI8yxLb9HoyuclTRsAPcduhGpAM6UMY3kc92+tHdix1ez+IeDunMdINIU9Aa0p9kqawBXamQsGEe7gRi1P6id41hDH04NSmK9X5uML1tz8FMl4JX4MaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvidyFWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvidyFWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749745356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y7GY49NLSZb0Lr0DFOFP5zgErbowRq+Rb1idml11R7M=;
	b=NvidyFWFLtVnboD5ur17P7WTcq1Jefs8IvMP3iXv4WC+kDM8ukAmlxFtfSJP7R2bdudSRT
	OvlfZTxIBAjHabUqOIfuHQRsSP3JIEHlppL5EKSuXL9hj4yWz4UHCMTXmi04FBUSTDiYZD
	gWWHXUpOwopnUyU+aLiynJmy+W8R7NE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Ac5113FOPw6UfgJFt2hnQQ-1; Thu, 12 Jun 2025 12:22:35 -0400
X-MC-Unique: Ac5113FOPw6UfgJFt2hnQQ-1
X-Mimecast-MFC-AGG-ID: Ac5113FOPw6UfgJFt2hnQQ_1749745354
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d5600a54so10407985e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 09:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745354; x=1750350154;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7GY49NLSZb0Lr0DFOFP5zgErbowRq+Rb1idml11R7M=;
        b=pFdW8PS5FRSrOfFweAOmnG6yQRV5SZDMQlXmiDMJypunYz8CGEZTWzFho0zGaduG6u
         JA8M6nG1HbIj1XAUKCiedkcG1/4+Rqui1eiMwICOOLO1FGwWNaHpzbZHPLrGGhjOrxOI
         YW+78hACfW7EbXsdyhV19NDfBink0i9JhYT6Ivc/eH+UKNFX3nGv2eMK+CqESjb7e7mw
         Yi9j0udmlwa1PmYwb5ax4+d5I7dkVlWHoLjlPUcNLDtfc+XX37BwNPHdiuYF8JNrilV6
         VU2oHrDy6SDRm3kWTEkXaM9Ziyqy6/lGggiGhQpz2QJlnwlbhdPHDoyC3asyoKZPjcvR
         olgg==
X-Forwarded-Encrypted: i=1; AJvYcCUnwiGXvcOlI2nblOnyE4hNU+2nJ84eX92nYcNstdRi+cPJUYnc/nR0KCGZe/naw88VbjZ0sZCAgCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHtMYFg0K9UpfXkEwmKFQMb28Aq87ubLC+5ASQpXu4ych2HD0
	IBfVBcWVf0QuhOfJGm4mcmpmH70upHl0pQlPz8wVRIY6gnIEyCXx3YoVzXx8e6DHW34dG7JZVGj
	+82JorIWnimCsH4fLXftLbmPMAhSGa96UNt71sNYAI4nsWQzTKNyjy9dswoCeUA==
X-Gm-Gg: ASbGncslCrxCR6Zvtc7MHjS/5l8YqDmyTEZN6O3J/KyJl2rDJi7bZdkzRwcPzOyW6ik
	84AB6ktSVleXIl2sqifkEd3C6agzwCxfjWGBaGCgGM9k3Kaj5nTTv2KWj8+Nym3yUVyQdAEWq0u
	GzR9tBnqMHNuuiiKoG56fm7aMKbNtan9L5DdR40T6GJ8WbBv8ica8SV87ue3EKeA4Pams94rKw4
	E7/VujF/EH9BeV1BOdLBK0u/pJ2JzY9ROCPimpbOpstDLQJSSkK3nYQAWkEQVFySC56fYlLou+k
	i5PJ4inhK/uhcmFvDWNgofoHfFKecLNi2CQH1VytqknFlH4yG0XWqJjGd5k0QEyYcBx/S5jUtG9
	IcbJ5gxU9q0Xd3+TU/qvzik/DcJB55j8Kb7J3uiwJ0XQQLtd2rQ==
X-Received: by 2002:a05:6000:26cf:b0:3a5:1241:c1a3 with SMTP id ffacd0b85a97d-3a558a4286fmr6492735f8f.50.1749745354254;
        Thu, 12 Jun 2025 09:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxNHM+y9+onXl/609vGofc8NG43R64Tkq6UMoshYWj17N2y2c0zpgcsoFkkjfCrhhEXuYihw==
X-Received: by 2002:a05:6000:26cf:b0:3a5:1241:c1a3 with SMTP id ffacd0b85a97d-3a558a4286fmr6492702f8f.50.1749745353886;
        Thu, 12 Jun 2025 09:22:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2324c6sm24697855e9.12.2025.06.12.09.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 09:22:33 -0700 (PDT)
Message-ID: <0340de74-1cc8-4760-9741-2d9c96bcfd17@redhat.com>
Date: Thu, 12 Jun 2025 18:22:32 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/huge_memory: vmf_insert_folio_*() and
 vmf_insert_pfn_pud() fixes
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
 <6ae86037-69bc-4329-9a0f-4ecc815f645d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6ae86037-69bc-4329-9a0f-4ecc815f645d@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JnlxZO5OCxcDTY2IUTHk0xx7XhEZTc4XO4rablXtWsg_1749745354
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 18:19, Lorenzo Stoakes wrote:
> FWIW I did a basic build/mm self tests run locally and all looking good!

Thanks! I have another series based on this series coming up ... but 
struggling to get !CONFIG_ARCH_HAS_PTE_SPECIAL tested "easily" :)

-- 
Cheers,

David / dhildenb

