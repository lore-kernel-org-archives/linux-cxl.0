Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313053;
	b=XQnjE38FjPqBlicLsGU++b4S6FJ4e3AP4LnfpfLERCpttVe1oBj9hI3W9zAd1j06hAok
	 +IVYLnG3OTz8f5/irQ0QNr4LW5nftnMXZe5hhPyupo3jNAvbqsnIwzuU9bj4o3HwZ2Nww
	 kGVSgHLyNF65yKWD7BEht3u5tQvJaM0deLWtdglimlKrjKTgOpuvxtpd8p8WqYTVFvJvo
	 U55rKz0QdQlsf5vIj4uxjRmyvzCYvMsr6cbLfpZZFzY8ZiYm8rvZ1tmQr5wfbdFVukTSX
	 eX7zNsX6yQbwzgu1B0vqWKjWfkv5OBURkCLLhgru4KjCpKskCJx8SyLDBr1TX3woWww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
	b=Bd/OEnUP216C0eCPgraqSfFRf64aK5n55VVtNvxqrkVsUvg8G/0WZG3azkQW3sU//wwl
	 MdoB5SMNroBFATfN8+zuSfjVpaSxhpS44eoMFCNeqHETg16ndYuLF0OZklt30rPBt4sLv
	 rwLUTZpijJOJcCXeP8YJ8xsq8/oDWEgbhEI4DZ4eyGijfrFWQKfBIl3Zb1scrdNyphqBa
	 w8L07SPK2HaXjBZyL2j5qwIAwy/mQTjgDArT2+lGusfwzbhcUY9pn4sh3+V4l0GdWCwoA
	 0/jegXw9gRGBwxKYJuPRDNApDlM2RgP/Wi6r3mONWAxXqre+Wf1fC/ij0uvMAxMVPrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B47606A31F
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 22:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B47606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c63449320so1295966d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313051; x=1793917851; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=VSHotii2iA/Qci+re5k9+hkvQxKjnotN/2zPP0cTQVX8b2J8BjE60+OcYufQKoVKvx
         a+j3LCBHF1DpLlIDKR7gb6PpKNODYEXP5niM7fAnH7XdFH7GFuaFd3xcGQIGPOzeeZ36
         dX2hldmlIJ3DR5XmGdNwQLj7XhdPI1h4ZuM7QOuzWnRVpoDso9hh2meI0Lui5uI/IuOk
         506s3mKiMnXlDNPtgHXynDbZfoZM5erpE048exc19KkqyliRV6xYwunu5BjsxA79iI4j
         XwHJNuL76Wix5UlGfgAKC8Pr4DZ0OiWTffDcTDfMEgS1ueH/XIz4VWe0mCZo0xJKxe0s
         aGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313051; x=1793917851;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=VSE97rZFWCz7Qiwz9YhmPpnFcmodvdEtMBNwz94E30lbIJ7C0lmC3x4kusRdiN20rw
         bmdHU5xVwn7e/mIR0peszcvQ2Y1JBTOfnd6zhALmj5WTNbk5cWP8jpLska4HTEqupbVD
         4HoVqd5QxU3B8SgfsS7MH8YHL8gQTRzM3kmPgES7/QHILf8M8TdqW87B+UvSsVi+ZdJb
         W2Gu4RSKFxXBdGPAse3SdNKnEt6fYr6YEi539qUvwloy+ARwOhuWhnwFdWBzGpI3apzJ
         MBxIxUSiwYntEjXOdaN39/+JL/IMDSHAfQuviXs2eNxUunwdBjDPKjpQkOfatiB71jiZ
         zYwA==
X-Forwarded-Encrypted: i=1; AKwUvBwAR1NU+zDYBVcWTG9UAz9mlybDrbJImKN88sd0Yyt3j6m0Hb5z2WbaYLT+MX8QJ3HTq4lOvD2Zowk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuDsb3DnQ/D6oeeFeXg8Od12aMyJgXGzgNVhGNTS4KJzDuTlLT
	DT2F/Scmwei9Y58h9pVn8e1JYGBMyWqm9dQou4uNEh6p0d3htNPgMDLmlMB2qiuZyG8=
X-Gm-Gg: AYBFou0qwd2EaonpomvsXRkoONZHm8+XuzgMEBpeV1jXLCWo6y+D9L9I6VrigDSUNNV
	vEwCBcN8XQaoDMse4iCZWSk/VCPopvh9EbW7sg6C9tKbJCT9xmMSxR2VPbOIOTU7De1Q6oLEgsp
	RpY+THkTtN9KA3bijk8PRabz/9dVuXeT7qbui/wt5I4yTIsjJCcAOEPpR/Z88mi2aJLkcw6k6Xd
	e1wykPJRPcp8fJZme2G8xUUVUVgOL3qfoy+jlm3mUqIOmRXHf8R3A3Tne4ogB7Ev9TjrAI4buWn
	VhVye2BRt06VV8wlT8F18AyUk6iY0Xqbh7OZcBcHjc3A+MZjNoCR6/ERB1bW3NnW0VKvcMwTyYH
	zqWvsyKGop4OTGbBI1oKhSpe4mtcKGXCZ8RGskdVdYL+BHdn1tLcBMvTDWPoKR6TIJsH+mSjsUl
	h5QKA1m0b1u+Gc6oRxojfHwOrYVip0BE9l7La7M0maPeV/41qcUvH6AXfM3BlhxbUUF/fVAv8vp
	gLmwF2Vqq1kk97LnRKw2HQz7baDpwHOrbASQSUxyGGnDK8YrGoesMvbUzna82qvZg3k6y3G0Nwq
	/xdV9N1VC7dqkkpKXF1rT4yGT6CvCgpHp+ndcJQ6RInw4gRjqQo9j0oGSr+0IIlcVl+uklWtaH0
	V
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr5824286d6.15.1793313051262;
        Thu, 29 Oct 2026 15:30:51 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca68e5f47sm398016d6.42.2026.10.29.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:30:50 -0700 (PDT)
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
Subject: Re: [PATCH v2 14/47] mm/huge_memory: fix zapping migration entries
 for device-private THPs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:30:48 -0400
Message-Id: <179331304801.2127828.6570375349219520262.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A PMD migration entry can refer to a device-private folio.
> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
> 
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
> 
> Check the PMD entry type using pmd_is_device_private_entry().
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

One note below, but it's not a holdup.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> +	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);

pmd_is_device_private_entry() already returns false for a present
pmdval - so !is_present is redundant.  If there was a reason to open
code this, then keep it, but otherwise you could drop it.

-- 
~Gregory

