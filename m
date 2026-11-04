Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832119;
	b=e0HIr0am/fIKROlzk68Tt8hTkwpXHHo4eE3ptarwY5A4JD2DmczAKkPqyxf4hUDinEdk
	 QW66LYXHKKze/R0PB2gC53wp8tVwqrq5DQRt+DH00dJMltvd0oNtgitFllfw6JYL8/yHd
	 LLDZYgVKOEcn8lvvbktnI3QY4tfV0dkYmtR6PUzAqvqcbD+UvklAiyeRAq/puX/aQ17pD
	 b1I7ZE/aDENn3DavSjteuSLxowUJXJPnvRkTeDRAMJxUIiMtUFbXSjR/338iwAansPlOn
	 mhq2HzczOfqSUfMkaAMyPHNrdCWc7TOn/5rU5GWeDgDio3fZ82BWZzwBtTQRMlErs/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7JJZFX7GjlSxlyM1xt2ZPMCBId8gHLPODjL1RlXKQBc=;
	b=Fe9ucqVk4wV8x+8+cAV4dSdP4YsCg/zMn55TF7Vp7GzjxP9YgO5jIyNpkTItcwIfMAl3
	 lGCTUZPrk/JIdsNZtLeyoHC13mym/dCBvsJszn5Bt5inClVKaMLaVBua4T3t4ZXpBj7t0
	 JLiaLcd8x4E7Fy6fdpfhvkNVETx28gT6xui48933X6asT0tjwyaNrSHggUdNsG/eM24wk
	 GWCwLgbAMgVUUNVeQJ9ScVmolUyBWyK1XA98tUPo4x8NQfmn17D68ifM+kqU1tsi5W/SK
	 YGQUHbCO1hjBPmBcfLzc906+prInzU1gHV8oeWUxQqpQuYJdbIlTZ0WeMgeLTOQ9YHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFbWW6xx;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADD606A326
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 22:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54ADD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFbWW6xx
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so9826185e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 14:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832118; x=1794436918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JJZFX7GjlSxlyM1xt2ZPMCBId8gHLPODjL1RlXKQBc=;
        b=fFbWW6xxpsEYD3oBRYSPO2sNLgd6voHxFWw6v27R9u4eGWHvAoWP028d3VlkW5ygPd
         o6GkD3FEd33GcyZ07604PYcoZhlGTKyi7yTV+yZaP3etjwvjRsXrfxPOwNLEcC/CLi4l
         Y2wbsIk0WLLhjn2NNPIcvBBwlZV7sB3fV4JuG8oEUfVV/SoLzgEv8ZRbuyQqjkhFABkL
         2uDqksTjbc4/Pz7HYCQudk4MYdBrxqB/+jOlKncdPyKaxwEY06P/2uRiX5WUJhlAUsPC
         l3xvkUW1p7Q6CBtjRtHmYNEEYsoLoaNbbRp3/Csi0TcnfFU+Ub69W6XxG6U/kumHoFLd
         RvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832118; x=1794436918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JJZFX7GjlSxlyM1xt2ZPMCBId8gHLPODjL1RlXKQBc=;
        b=09d+feEptfW0LEJcnnOomH1oHs5cIrF2hQRWQOIy2ZvcxIWiMRfiQ/AXLfxVHnX8dd
         u2rDooEBLrzDyjHGbv1LS2MAedpdIfF2xKlQZhuCEPBg/fuMKHu/W2CwzVQkTpboPsQ2
         NXhy2Ckh/OkABprN67DNs68gHzvwdZNge5HU2tG8QoA+ZME/zGs/xurjfSYCCg/EgA5g
         eK5CzvQn/9RFn/8R7xiXtIX/I05nx3l2lHQHJOGA+jYp7mTzxCaGN5vsmNtt8HaSkzWo
         ftJhQODuzSAC32Fj19QBnyHDDkHwk88Gyc5HcOrDpiDeG+hcyoBs3qsXrFOgxI4JSRRx
         IpRQ==
X-Forwarded-Encrypted: i=1; AKwUvBynRWYcoyYaWUMv6w692dNaPHlL7mSRsBI1G0v2t/X8v/vaIclfYK1+/Kpb9/P8y4eqkuAse/JMoIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VO7Pq4uoZV/NGO1HqR5IVO6pFsvScHdlZ96/ofQZ3M8sZ1/pz
	68TUiRDNrbHB4nqN9+Qe2JPR6kXShnYkjLIJreifo2jbdfK0013/Gzct
X-Gm-Gg: AYBFou2ST0sj5vEmTgyyAG3OQyyvFHsCEIrUbhtTo/W9SUQ3qlnkhhs+0eqWZzIQIjt
	Ja9epQVF+BPOWgm60JCM+vlXbtP/yFHjyV7IaUY0CyYr+tbwcagrCEeB/mTpAwMPT9PpSVBKJwA
	nDj7Ak9AioMKrcQk6107wXkyl7CrA339EjWkrMDWyOvwFpYHDbHrXx/i048vg0P+GeqI/KQlhBw
	SXylrjl8TJZtqzdoxlXE+FoY0vbJy44/0wXWv8PfGgfE6uSUkg/iYGV1Mw+SxeeEp7Nowvq9gRs
	RC6K87jMLajA3Nz0ZBOq1A+yhth5VrRW2vCXQVLqTbFsZqBtnqZHRdo4ykU79fLQWPenc/B4HNy
	Is9nCOrYA/v089ri/H1lkvQ5YxvzTScVzkKBnGqZ9mpmHU+nNjdP59hwEI9ojE6q7+YMnR00plQ
	8pFHZWZWUWwKhgUEQ+iIZbe91/mgokqb6O3RaTRoOiFlmGnV1gUtckjAMuO+IWHx+vLH7PgFhYE
	vVKE5nPTjrBdxtWdHSPHonW9teY63VMYuR6vwuYNwH7Ck3pfJf93LYpGP3Mq/3ptjSn7WSsWFKU
	gIwlpF6qmy7oDHWVNlrzKiA=
X-Received: by 2002:a05:600c:4e50:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4ac16bc461emr393154585e9.7.1793832117676;
        Wed, 04 Nov 2026 14:41:57 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed551dbasm6018773f8f.37.2026.11.04.14.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:41:57 -0800 (PST)
Message-ID: <d4b5e996-e718-452c-afa9-e9d9e08712c2@gmail.com>
Date: Wed, 4 Nov 2026 23:41:55 +0100
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: split out memory-failure declarations from internal.h
To: Breno Leitao <leitao@debian.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, kernel-team@meta.com
References: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 5:45 PM, Breno Leitao wrote:
> mm/internal.h carries the memory failure declarations, but only seven
> of the 81 .c files that include it use them.
> 
> Move memory failure declarations to a new mm/memory-failure.h and
> include that from those seven files that need them.
> 
> Move the block as is, including take_page_off_buddy(),
> put_page_back_buddy() and page_mapped_in_vma(): they live in
> page_alloc.c and page_vma_mapped.c, but are built only for
> CONFIG_MEMORY_FAILURE and called only from memory-failure.c.
> 
> Keep the declarations private to mm/.
> 
> No functional change.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Link: https://lore.kernel.org/all/aumt-4kfGGtoXuh-@kernel.org/
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
