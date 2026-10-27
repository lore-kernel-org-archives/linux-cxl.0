Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100727;
	b=aVIoVP6u/x6aAjv+sWHyg1O17bX4Q5hLjQlmNRTQ0hD3OlwGXesV/GXw/tJmJIVUSzP0
	 51z32e6n4GxqjtfTacMI4Svf2DLakI2m8wuxzCt2sWAwiHGdPm3rEvJDB1HGcjfBdUdUH
	 LcD0YCkG8GkHD6NtrszH4Quf1gNduY+v07t5GjCBEy6anW6brl7NHmL3sCENlr0uQOvPX
	 kFIoqZ45aLOebvEd5I3Y2iq5EV4nyk6WX57elcONoHqc7VDeLAFzir2OLMJ080jdwhZtx
	 owR0SI6/sZjHktqi9soyK5yeoHvpnDvh+JocXlkerrO6bDNRN2OU96VLhmrH2O4leuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RdtQZXTbTiwwiCOERJQ/97tzbS8/zwPttXhgydj9WAE=;
	b=3nM3387U/rM8LNZAKtei/3iizg9GhcVqOA3hpFObGZKNfSkvPs9QbihvslH7eqhhonrm
	 67BgPQx1udh8RjsFzVAfWJfxlrVgiRFcOXUUZRTMAgVdEE6uYGToZIlr4Qrt2XnTba/MW
	 MP2m08/T6Q5i3sfNFbvHNNYd/mEzkZyqx37d+NkXgsyFjBdq99oVv7VOhT5dpB+BPLtUf
	 z1lwqAZOJObbFV6glXDG6McJwHlQCypIoGcK7opwax6sERWhhf9w1YurqKmQkycFQE3xs
	 6Uge+WVX5zM9RlZJBZKBAahwZNhArLgFX+GkEvieA3nvrOtzO5QD3qQIG+TZJUTmwuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52F606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 11:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB52F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c6ce60697so12243936d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793100720; x=1793705520; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdtQZXTbTiwwiCOERJQ/97tzbS8/zwPttXhgydj9WAE=;
        b=cgfTCbTQmgi08aq2EjQsJm84RLxzKfeSrSncAhWv2NxWX34D7zUPtFtjWMQCiG2lNz
         LKRkbYTvkqDwivjWQebhYClwp7BfdOjYotfdcAe6tniOWVw7k8fAg56bQNOsgF4gx94X
         d20jgGsA1d70pT/ktkr62L7A74iYyBwby2/bfs2tSvCH7mY2QTawa74oI6voEYGqV6OI
         8rSdwqhWgQiasbfVzvgo63SYfMT1NbHhQ1/PQ2nfhliNkl+kZRl82vbFKj+E1JeWrKIt
         IUeSRgq08JEj6mGtd8VckmSE/yaCQU0ZLGmJidqLDHnSJmfljMnUOv+RvWlnqtDMjqhj
         GSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100720; x=1793705520;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdtQZXTbTiwwiCOERJQ/97tzbS8/zwPttXhgydj9WAE=;
        b=I0UXZtLG3BZK2CMNgalvYqGQru6VcMDNTZf4W0e4IO3h0/wIjyiDqy4V28KDsP0/7j
         c7dqI35Y8q1RdJykJEcftSOExfZPkVfm9Z+6dVkiS1LH2tARpTg094aaZphqTU5aRBTN
         mZFprSW+1XSL2Mg56TpWGEwtJd6wlAb9AL5Orpt0hu9ye5FaTnbeOy0WC0+RsZ9J8pKs
         1qzr4Z57Q/w32zDaicJcYso6F23QuhDYOp9EbxfcjuMTNnV6frARXE6L470OonBt8gCR
         yJD71tHAKCUBCS4rsxhRTxF60lHpZfctM1Ko1isYwoSs+gbNpHQwqvpYPDIbdcCo5GCm
         kT/g==
X-Forwarded-Encrypted: i=1; AKwUvBx/KVU7pBWZjRTa39aSbb8VCShdToetiX4pOg3QqvI0fDy2QKgjGP720ICCEI3B1xc8kbiii0LK/fg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIWBCesZGVsFrjGeEST496qTc71re8sFqb/LgXI60iZytR1eyG
	6heWGKfesJuFEgF1kKisBsyVGTq/qzDtz39ktGRvVnFXKkbzFWkj9NvAOSzcwgN0xbs=
X-Gm-Gg: AYBFou06uB8eyl4Nt5xpICKlLaXGwoPriPYfeCID5GbMwHog0lRgtCvgTHfZ9l/fYK3
	LdoT/TfKW86j5TUPefqNbCe5DA/l1JN2sx1WSyurqSrfgpPR91O7WY4Q3Q4p7SpKNzBUVPq9J3y
	bPNqU6NrfrLszzl/MiKj4a+A4U29Lmy4i7o3JlW7u8uDnGdAPeSD4i+NSF/WSlSc+uxF0uIIPw/
	cRMdMngfHzjonrZnWPERFM7tWFKvt10O6ZWi6tff6qDvtaG6BvvqpRGA1uEUlTV+v60aNVwDOU4
	DU5z+lSWiZbEQfW6LSu/lzJ/rj9BR39+gKMrXOWvkPIO/czHS3qPlQPM7WSgicN6siVBSDqcoWH
	wnqZiPSrVfUBjXeZXGLfsYwcJdmmTDcz5Vavmy23cWHwB0/r6Ef4ClivnvEciGnAZRtL/8+6Sof
	gWP+Zi9q4LMFwK0MCaSmLU+J9BQEc3EcqBqG3vbWSwDeK3x6aEulaAeobbCWWsm3yIUZICq7+l6
	emWHvmVCTlBJuXUY/ngA0FRFWW5UQiGDVjs2Agt4VUl4iOrg0P48SIRcAYj7YymkNbh76x7M52w
	21IPu4/KzUCKR9tKv/7iNpZ8IlCJ8FhHcJciZe31JBdGva77
X-Received: by 2002:a05:620a:4556:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-940ef9380d4mr1524401485a.61.1793100720515;
        Tue, 27 Oct 2026 04:32:00 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm99588996d6.3.2026.10.27.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:32:00 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/6] mm: fix pfn walker races with memory offline
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com, 
 nao.horiguchi@gmail.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev, 
 iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com
In-Reply-To: <01d7d54d-0047-4eb6-a1d2-5b3f113f26cf@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <01d7d54d-0047-4eb6-a1d2-5b3f113f26cf@kernel.org>
Date: Tue, 27 Oct 2026 07:31:59 -0400
Message-Id: <179310071902.664110.12994053710961856591.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 09:57 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 05:21, Gregory Price (Meta) wrote:
> > Several pfn walkers check that a struct page is online, then use it
> > after memory offline has poisoned it (CONFIG_DEBUG_VM) or removal has
> > freed the vmemmap.  Five of the races crash the kernel; the sixth leaves
> > an offline spinning with the device hotplug lock held.
> 
> I have roughly the exact same list of AI garbage fixes here from a certain company.
> 
> And I consider this all extremely low priority.
> 
> So this is something to discuss throughout the next months and do it properly.
> 

I actually have a reason for these fixes other than "bot said bad".

We leverage ballooning and hotplugging as VM memory overcommit tools
and are finding that some of these race conditions crash them with
large MTBF.

While most of these are insanely narrow, they are not as unlikely to
happen as you think. A vCPU can take a vmexit in these windows much
more easily than a host can take an NMI or other interrupt.

Thankfully none of these (or the other series) appear to be obvious
security issues, but they are stability issues.

I have a reproducer for every single one of these (and the other
series) - but a handful are unreachable due to a 2-statement read
being emitted as a single read by the compiler (which can be undone
by a targeted compiler flag). Those were included for completeness.

--

On properly - I have a follow up series that fixes the zonelist walks
structurally, but it uses SRCU-fast on the fast path. The catch is that
PowerPC (and i think others?) don't SRCU-fast without atomics, so they
take a performance hit.  (It also doesn't help us for backports)

I've been weighing that solution over never freeing and/or prepopulating
zones - but this also results in performance impacts (leaving dead zones
in the list forces the allocator to walk them for no value).

-- 
~Gregory

