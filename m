Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF62C0276
	for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811065; cv=none; b=TJEaoi3MOK+A7MhrkXEQKGgNe1JtC/Gqtg+sA0dIZsLTNGxIw4rg4ptXxNxG+z0slBN/LY4ERNE3Fqucfcs8eu4XPmx7/tU9ROmTzzA0YhZM9GHb0Ngf04JcTkqukdpLjzzrW6FEHk5E8R0TYqeoj8DmCE+fjz5eT0iTcNVHlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811065; c=relaxed/simple;
	bh=Bf2lkJTzia6rp6eqbB2BpOAYcLR/LaQxryC/u1QpIJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4D9QjRAYBvOeH+A/OR1GZbxeZsmriwo/xClkTT4U+DQEBZI9yd/U/TyjrLGzppK4DScBuNcQxPHzQMQS5cVV6/JbhO6uPPhg0SdjYUF8JjPfcrTKCKfGrWE+4qZf/I5u+rGA92JCsEGwCRumUrOqd5eqRpdlIABBq3x5irgatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdypjq0J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdypjq0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755811062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sBq1GXuyu1bfPR2a5gIBWELZcbU22YtlmG431fTdv50=;
	b=Zdypjq0J0uJ7v4RYx5Z6OKDGm/IybPBbVP0pCL6ZnlencyOT8lc9SJfNnS9OoZBUjfRhRs
	/6EFyyDh8QZvILUD4wq7VQucvRyOgXFSERgYfu+phPSelIkAwmSilDIAeL+QcudDUSZXd7
	ubCeAXSFqOqXa0QKucQRSaZ4Tjv5+Wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Inp5QckZOTapy4y8Sa-EOw-1; Thu, 21 Aug 2025 17:17:41 -0400
X-MC-Unique: Inp5QckZOTapy4y8Sa-EOw-1
X-Mimecast-MFC-AGG-ID: Inp5QckZOTapy4y8Sa-EOw_1755811060
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14530355e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 14:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811060; x=1756415860;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBq1GXuyu1bfPR2a5gIBWELZcbU22YtlmG431fTdv50=;
        b=pu3eY9dKgkPeqTtuwSEcaMTCB43rU4fJCiOIrJ0oy8jCYQOiWrlPCvFfmWFzIY07Et
         QNQbbj3dwclEENMa6zin7C7F/5dlO3EvmVupC86RCyvALpoVGmpf4HVqQjHNeu1r9P1q
         dxKLP5YR4kL829zvYYdikmgiMd8c5O8Ktp+0QyLJexQGSWO9P1pB3nQBy+cj/Nj5nNkd
         r6KIzSqs+WHhzrKmUeTU8of0gJflElOlErdzAH9r+yb8UsLKnn/s8FdeauQZoph2+2Dp
         aIL20pQItv4bULt2lW49uxVhvyniBrgZHICQQSEetL0G40bA5Vt4vZZiRDRvfG2tE9lX
         J86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP683TWQxZUfBOCuz7RuOEcn7Meya73V4Rtw6BqeCwElKudRsIwq1MaGJch/+VIbFexTiyK7B8UoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNDBI+eMzXx67mzMqlIlYiKl6n+kZAU8d+ABhqBPDS4etbfbl
	YUtdSeACGl3pbPqUgoV8XUIMm07Gqyyy7AlTuby5OQAsUIhz4gJhMZRsBFeuHH+rg8zQtdx6M2w
	VtbkQO+N0Gc5wq+2xk47FMPdQwUU4WtB2D+zq1D3YIQhLIY1NECBGR6Ws3WgkgA==
X-Gm-Gg: ASbGncv71xbG5JU4gyFCSRg47qXWvMeNCOa5jZVYxbZXwVXd071RE+9N/DoshuY78j9
	SEoWuPsATWwi89wkVPgGkAQVtSNZb+ich4SwgsLiM4a4nUK/5d3hyaF5g2pK24Bjlo/LhVh9meK
	bDVW28RehSqwmz80v9OxLmQTJUjt/dSZwuzYuI3uAM8osvUMMS+f1zBUD22+K0Ah5KspRF/5mfg
	av8uhF5qHueE6nwxRe8O+bobwDL8E3u8YNkEHpz7rUultlHXboE/Vcy3yZj8fW8MCtTR3G14kYK
	8pBflmVzjTLlNA5QodLpUNLN9AcyEy/AoDn6omjZSqdC8T4O3LxpfzvgwHJ1r95nHSsGDRfImVe
	MKX/ef545/8cViJAMA9R5SuVUtEx+zVSA2/hTpPGDvpiBgsLIRXljbP7FYYM1dQ==
X-Received: by 2002:a05:600d:103:b0:459:eeee:2759 with SMTP id 5b1f17b1804b1-45b4d7ff5a3mr20457365e9.14.1755811060058;
        Thu, 21 Aug 2025 14:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvgqefoRLnA/bfxgpVXZVQTDNLNgVxTUS43Go75UVVxQRjwxcQQmsmIjWRnwgQKHT6pUYi0A==
X-Received: by 2002:a05:600d:103:b0:459:eeee:2759 with SMTP id 5b1f17b1804b1-45b4d7ff5a3mr20457265e9.14.1755811059623;
        Thu, 21 Aug 2025 14:17:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:ba00:803:6ec5:9918:6fd? (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50d5dd4asm11221735e9.0.2025.08.21.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 14:17:39 -0700 (PDT)
Message-ID: <14a0e842-8616-4bd3-8e11-7d8521c81cb0@redhat.com>
Date: Thu, 21 Aug 2025 23:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/memory_hotplug: Update comment for hotplug
 memory callback priorities
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250820194704.4130565-1-dave.jiang@intel.com>
 <20250820194704.4130565-2-dave.jiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820194704.4130565-2-dave.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rh_8bpmWCJ2pQPbCS4dcw7lk2qoTxmzMqtJIIVNcYMI_1755811060
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 21:47, Dave Jiang wrote:
> Add clarification to comment for memory hotplug callback ordering as the
> current comment does not provide clear language on which callback happens
> first.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Clearer comment suggestion from DavidH.
> ---
>   include/linux/memory.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 40eb70ccb09d..de5c0d8e8925 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -115,8 +115,8 @@ struct notifier_block;
>   struct mem_section;
>   
>   /*
> - * Priorities for the hotplug memory callback routines (stored in decreasing
> - * order in the callback chain)
> + * Priorities for the hotplug memory callback routines. Invoked from
> + * high to low. Higher priorities corresponds to higher numbers.

Minor nit: s/corresponds/correspond/

-- 
Cheers

David / dhildenb

