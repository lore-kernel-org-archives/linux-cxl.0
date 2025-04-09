Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8123A562
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189532; cv=none; b=BimzW/Oxuoj3fIqB06AMvFykCNagQzvvbMrYagxklD7WykDPo9cqDLCNapQAr0mTO+h6pxB5+xJBnG8RxR2ftYKKRftdZWVU7FNdHSpKKnO+XsweC29tBGkuSI2lKzPME5Y9uYAvKKcoiZJgTZKFeDrXOdkt9lHBf482H0yH8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189532; c=relaxed/simple;
	bh=x4gIHGrqcCZRR3ztS0Z6SbbPAGM4PDgey1zkLq5vlbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THyudDlTQ902mSMs76GSn4jIJd1VtSFqLnaGuushsyxw9IuG280vOmcaxBioUGYiUNICKOsqpLzhYpfTPVtD4lSrvbFfcq+Ks/KLeAizV3GGXqjMzzYgPG7tTTGUCdVBmGLwABogWTXwaXOwLlt1gCrL0pIeApGudUoaso6D2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGz4vE0T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGz4vE0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744189529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1iDO9MMl4N3RRYmrexFHKDKAzEZh06JJGIlAqH65H+Y=;
	b=aGz4vE0T44ObkZlbbwWSQ5dBN3yq38n9Oyw5M4N2DvKiuU1qTHJ2r5ZuQSRoxeQPI/Owbt
	J0ThNkVFiwoDb9OcTad+WSyvZqIjtex1XXQVcnfvr2tIZcJXmeKiJpQjQS3wli7rRcCSVO
	SUQuoTlVEb7hEuYa6UhDXumeBZs7aGI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-XONuTXmsNXiBYTkbWPrc7A-1; Wed, 09 Apr 2025 05:05:27 -0400
X-MC-Unique: XONuTXmsNXiBYTkbWPrc7A-1
X-Mimecast-MFC-AGG-ID: XONuTXmsNXiBYTkbWPrc7A_1744189527
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso31686715e9.1
        for <linux-cxl@vger.kernel.org>; Wed, 09 Apr 2025 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744189527; x=1744794327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1iDO9MMl4N3RRYmrexFHKDKAzEZh06JJGIlAqH65H+Y=;
        b=m2H3CC5Dx24l1biiNJa2hToyFqTybJJR6QYqtmTAUR61JDaBdekTZXHt3+z4ndadrZ
         u7W1dYFpnjlMnVwiHH8yLobYr3oHLbs88AzCi5lNMRsCMLOFUW0/ajaSB7vyG4kBvAvQ
         pD64ElC4zzwRzXmC3Gb7du4cYZ9TWfyuFTVnNvFJV5SPGvtjIKXdGpHOEPLctIz/6gwf
         /4OBPRchoHnZwt6Yq3bL6eAi4ITgoSO+mur+Rj5Dq0zOiV3iAeCjVDrUHhEMVsKNBxz/
         4MiZ58x9Be3VLexWgdrydx1B3FRu+FC8uVw32qvPfx/Pgwgeo66kpKctu7RTvX3v9BdO
         s0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkh9f1/Uh4Wkuwtv9hlS5V+E0y1W9S220beh3AKIglb2R/6rA/MzQPzmY+mtm1u/BO2TTBd9d3Aso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGk8hFEGod3uIX0Qg/NpUyvZPnKaW00RBNMgYu2P+sFPwZ+Sg
	HCsa9c5ue83/6Bq7HSl7miOxvAYezzF6OZAjS3GlOxRmENzXzGIAzh+zqVBN7AciZ9x81W/iwE0
	j2XlmC+to0YnlTd4JyMs1qZnxkgWWxkAmcQhIINHvg+ew7KyPCNzKFb4kKw==
X-Gm-Gg: ASbGncvrZmP+B/VNd/QQ4kBsEGz7G0LQvHhdSvG2rtTBp40eUeQlawM4fRWsKVKiKI/
	4cDqUtyKJQRdYNMiaz+wyEG+iV8bqrB6dl1ue5fRgnbQ19hRSF2uQSUAsRF6dQ7L5PwOl4FgRZ0
	A2fYx7FvS81GMNgRKx8nr/xb7BADJZKdTFah9scfd1G+sxWc94+9jkNlPZvGzaNNCjLK5Kb0BEZ
	q7j9YkTs7AYprkaj/38gmUp+kBaVa6vKMuwb2VFRf1ASlq3iPE2oZse9bqq9eqcZjUw3cAvQpYg
	OLACFoW0y6U3vxhTwdv92OkglOF9PZVnhx8o9oGR4COhx53A5RydjLjqirX+XLPL6WWixAf6T+X
	GaUNabzUg3TE71yiQBNJ1a2FTHUF7K8Hg+w==
X-Received: by 2002:a05:600c:4f4f:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43f1ff2f7b8mr11402865e9.21.1744189526785;
        Wed, 09 Apr 2025 02:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsx7wCRCByNDp3vRMCobQmLS/Z8q3mGWkAI2jHMGbEvurBgQxJ1sSDoc6/fcJT9fDzVWRiOg==
X-Received: by 2002:a05:600c:4f4f:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43f1ff2f7b8mr11402605e9.21.1744189526296;
        Wed, 09 Apr 2025 02:05:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207c914csm13080075e9.39.2025.04.09.02.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 02:05:25 -0700 (PDT)
Message-ID: <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
Date: Wed, 9 Apr 2025 11:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org
Cc: gourry@gourry.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
 dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
 Jonathan.Cameron@huawei.com, osalvador@suse.de, kernel_team@skhynix.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250408073243.488-4-rakie.kim@sk.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K7KyW3Z1ZPtcB8WDYzG_nr6TnGelyUFaslupyanyljA_1744189527
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.25 09:32, Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>     the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>     based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>


Why are the other SOF in there? Are there Co-developed-by missing?


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

