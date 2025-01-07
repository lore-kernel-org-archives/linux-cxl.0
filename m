Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04021EBFE4
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249824; cv=none; b=E1yKXMJw+tlReySLhPDArxKXvxgIdfnAbAKVG6ViF0QkSPxfxz7NgAKyqgs3kSUKXhYzJyFUMEulZuhmbTAeRjFLKrEBYum3/NdwQKe2IDb0c6BMUWonrYuLDxi0m4kGKgSB633s1zmrLBbgDvEjjBMqXUSInFpO2gS3PFgkjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249824; c=relaxed/simple;
	bh=c0ykj2K/60PmyjKitp0xJUKrK4wYX/gepn1JSIYwzpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APH4oz8kXUQn4SYN9OHfbleOAeGYBarUX0bJdaaiXuZbXXZcq7mO+fwWOb1D4V/8hs+C73b9Z8nlKbTnx+36Ih6G9+/qVqmSLXrKBtyfmqVR7CGI5/evfqd+lYRnSYh1IDMwPumSohXaPbfWOgh6YyBb7JOmP546yuz22wAIX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da/Mfpqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da/Mfpqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPWLOfPPpQOf9nQB18V4X5aXAnWnhoDaHH+uIltQ4Xk=;
	b=Da/Mfpqc6lg2r2c1pr0Hzvq12NrX2RUwBfVM1spoARfgQgojnkY3xnUevZkUVFnB98pNgG
	qYvvp7dVYi/sO/7CMoZsm8XCfDAR+9N6j3P36BEw4NWsGOIg4MxQUX77FWQJMkUmpxkE22
	zTO3cbk5VvvDnXJMmQHK09UqX/CAmSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-tWyw5jS1N7iKfESpE4ON8A-1; Tue, 07 Jan 2025 06:36:57 -0500
X-MC-Unique: tWyw5jS1N7iKfESpE4ON8A-1
X-Mimecast-MFC-AGG-ID: tWyw5jS1N7iKfESpE4ON8A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso104715335e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 03:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736249816; x=1736854616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPWLOfPPpQOf9nQB18V4X5aXAnWnhoDaHH+uIltQ4Xk=;
        b=v0OCXhrGxdeR+yr9Yza4SCcOSOZg+mSYHg17GxiglF5xYobgbdFaxJitF2sWcmfcOl
         0XGRPHbsr/Jk//n4xnLNlkYFSBsvgzt9WS3p5dC0Kp1k0ulMRFdCdr4MGFKShya0h0xk
         T1rSkC4Mud/GPPgdHLSngH3TLKh1oUyEPa9Ec/GJZTngXPkYVvG+UFMGvVT5KYzV6gzZ
         h/v+n9a1kTglMWi911L1KJLSikepOxEiK85rXz+t8wZdoYkcduuSzhJWRI7sNsAjFK66
         GbNqyVWif9R7UaZ/VhDjKyRfz0Jn78xEkrI0whgPpdmBdGZJtPceT0h5YophiVb3Hh9P
         9Zbw==
X-Forwarded-Encrypted: i=1; AJvYcCU9wlhRj0zZH7xgiDJh+xSGxFnQOaWh0/BTgsUhNnbaEJuFa0kCtnb2n2BtQo7cVnq9lGHTrgBJxZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTV4l4mRm2dY8c1zDTOOHOtX7Gi1l02R2eSRpbjpTh+V/m6GD
	np45KT/E8fqugIQiSMvK9bEWigumncNQrr2zaKepL8MYspqIPqK17Wrdj4GZgI3GZoLG4fDodOL
	IxQm5ZWQ5KB3tWJJsfN1Ze4Y/gnO/tNsVjZoY1CTddbcj0olp/utg0u4y+A==
X-Gm-Gg: ASbGncuuTJYvZgovtrpS+26u4DgZ+lGs4Egw91u30Twj0ntqhJDyn9zIe5bknzSD6g+
	EhS0AS4400ZHrXCaGt16Vt65XPbtCfxXFixZeUVR0xHVHi8TcoBIQ6KMlAbPZO8fIlX5q45BWTu
	9ZZeJCREAbvTNPtTq9VfwEK06vFSeOPnT74GEccT3ImSi8X0y/BMlRKW+9iwRF+a4Ted8mUd/3G
	mJ+ydoK5IJ7NErUAUXlXCYf0d3ZfpuMMaW376/yUsWHm4Zfn/80h8i+whdsIstCfMngYwHf8UUM
	kYHv/eu/yny0GuwcE3Xs/LUSD4qzt/BHkwXsEpMfLpaX7W2XWpzRlgXp30yZfDBokgS3a+FcLuK
	KDb6pw1zS
X-Received: by 2002:a05:6000:704:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-38a2213d33emr54453857f8f.0.1736249816130;
        Tue, 07 Jan 2025 03:36:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaT18MaorKDc8f0dPQnq8Hx4Fd5WTGife38GGjyhvgZNdMgf0zcRP1rbdU6qLK3Zfzio44ww==
X-Received: by 2002:a05:6000:704:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-38a2213d33emr54453824f8f.0.1736249815752;
        Tue, 07 Jan 2025 03:36:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3? (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292f4sm51029779f8f.3.2025.01.07.03.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 03:36:55 -0800 (PST)
Message-ID: <758c0441-2cb9-41c4-bf70-c5810726779c@redhat.com>
Date: Tue, 7 Jan 2025 12:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/25] rmap: Add support for PUD sized mappings to rmap
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <8830827577fec4c6c2a0135e338723a5b532a2ee.1736221254.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8830827577fec4c6c2a0135e338723a5b532a2ee.1736221254.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lmA6XR1G8QgrYTiDAAl4eo6Tmq6Pn2FZ3hjLNlLtfTc_1736249816
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.01.25 04:42, Alistair Popple wrote:
> The rmap doesn't currently support adding a PUD mapping of a
> folio. This patch adds support for entire PUD mappings of folios,
> primarily to allow for more standard refcounting of device DAX
> folios. Currently DAX is the only user of this and it doesn't require
> support for partially mapped PUD-sized folios so we don't support for
> that for now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v5:
>   - Fixed accounting as suggested by David.
> 
> Changes for v4:
> 
>   - New for v4, split out rmap changes as suggested by David.
> ---
>   include/linux/rmap.h | 15 ++++++++++-
>   mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 683a040..7043914 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
>   enum rmap_level {
>   	RMAP_LEVEL_PTE = 0,
>   	RMAP_LEVEL_PMD,
> +	RMAP_LEVEL_PUD,
>   };
>   
>   static inline void __folio_rmap_sanity_checks(const struct folio *folio,
> @@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>   		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>   		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>   		break;
> +	case RMAP_LEVEL_PUD:
> +		/*
> +		 * Assume that we are creating * a single "entire" mapping of the
> +		 * folio.

Misplaced " *", can likely be fixed up when applying.

Apart from that LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

