Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130213;
	b=WgiIRE85BsbSdj38cTgWYxa4kczzYfhD56200WlqM6LZGG5ffAxqs9useTvwf21N5Wzc
	 EXcSptZeJLvzrFa14ObYjDOTr9OP1/byiNM0ZQ41BNHGE+Ruxv4JmaQceoqsKKNVVBzFI
	 lfR08VzunsogGUGHt3w9YmZFOg/6P8Y/1rEZY7hwo+DS5/O/3BwThyX/uo5pjLdpDWcnB
	 ekNnHKhoHH08ytRZ9p0ITd8cqLvRdTjOkKY32begBP2J2ABnz6iI8ru2pzdhT2u47Tj6x
	 aMcBQuBzYiUlsyBLy/AMHc4M4RUfGr7fxScEyBHBhgZsLW+Rxrf1chddRsqxt0VMcTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
	b=NZ3Ki2qwoz1XykHhaKdcwRSQMifuSCTSsh/+rJClxIYU6DDEyCRDIMHQUJHGFWxb8UGi
	 IWoPuL41j7BbWrzG9JfZ1hn9SxpDz5rskTJ07LgoVwHwy+KpFOelwj1ygY4t9Gs2/qGPK
	 8MfKJMpVhS9ulIyn5cEiZv1xql5EPRNM/zWr0gKiDvtTNPJFY8LgWDwZw59Q4iSpYwQ8i
	 Ovw+PEE15nbefYFcZf2Y9aIXjdx4Ja3Osygy2ugynNJb4NKJ0K1Fz5ERHSf0jFurcz6Gi
	 rXnmB3cjEzMy1G2pPUzcL6E2EoZHIBPZQimLCICppM1tSerSMtbGILlBG6cei7aE5ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016F606A320
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 19:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F016F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so485ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793130212; x=1793735012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=fKvu3sFl+ouMpBGe8QCxA/Po0tluUmY2cadQ5kspAESt99gU0otrCAvnCSeV7d6AMG
         nOJN76SW+5T4b89TdCObf7StqhqC5yuKT0Xa/e/MapWdVtpzLtKN2Qlut3EgtOYh/7BP
         MPFGdTIbjbI3NMLynzjswqcJUo6qUs4Fbp/l6sbS7XErYabWce0lM97r2Muq1h+B+NOY
         yACxHY1q+u2K8gXE1fj0nLilv5P5r0KMvBJx1xD0NR2cp9VharpDnFu2LcIgoIKT6gV2
         PJlApj1CY8zjAhY9JN3oV8+YwlHOQb/i9h/w7so1nt9/GQ6yRkZ8QtO/Y3IZocJ0d2Lu
         EPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130212; x=1793735012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=vWFgCZsyRiIWdhQDtdNNHkBrHYF0OcY1QK+wuZ9f+HO1tujKYpgRWGOWoJVlOFUJBP
         bVUtbdRw0h5zV66oJD0F1T6jOf++Nt3ePo/zGZ1/7PH5JBtmUKZYZ5ZjvOS2P4e9ij1X
         9uIEzu+5h/Zj4QP8e7ClVznLDG9aAl2Khb1aoDTae06E3F5DTmokvFArezZiUC7bBIys
         qttf4mocvwS7RoWjHK+/m39g7JKUSJ8wF8HYxmTVdBI+8WcNRMcgM+saKnK2Wy7qWUPm
         7pm5P0QYAzfo1IcjUv9rISB6PsX+96jiu2mzz8iVC3ZQ180G+8HE0QzeH6xpAtFiRdGN
         XVew==
X-Forwarded-Encrypted: i=1; AKwUvByia0MMY6p9/HRXVaTqZaMoOtsIohBNrYvbryGIAKnVSsnKA5KquVJ3tQSBFqo+zhz72kH3+omGCbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8kSfi5+lgAvFlwXPD6qauiey3BusK15BrFep1ATYxByiecmp7
	fx2jzO0rEDs1WWsGMdg8ORqbgjGRuxBMss/11Q8kqegQReXrJKzjj/S5+gvaDGEF5tnoB+goIbX
	GkT3N1IEH
X-Gm-Gg: AYBFou3c7iMo18LOsE48qpur1npyykAt+FDOEjdXr7tVwzUcIgFQO4HlcdI8gAiGkHd
	5vxzQ0peAvmHmIXPD159PDdUTOYRB8Werh2ThpHX+D/IsAcl/VE4ke7QEPaoeisMOQfmVWKPFBM
	inBzOkYW/BBUR5Z03ra6ubgK6w3TXOFu3QUR4Pjmf7lVDJbMg9V7oWXgauVrdfUr6OEnohhK2yN
	9VKzepXk5zObAZAqwFBg3kOCbnZ7OJjCQ57q4H3I7Xn+XdhTOEzxf+tszJkI71V3RymwVO61xzh
	wzRRHQZHjA5dcUdOKesJ4blY4ZHyAm151R9kfP2johKb/M7N5qG1Rf4rBAQmwnzWyLF/Wrcxx/x
	CyPQkMsgli/wXBYlUCiBNNJMSHewLxgt+unZLNlj1Y8uR//IUKLbSl+/Zg0sEltuGJx/LlrRa1/
	agzgUb7jkMMJH5sToa57d68tplR03ds8XY6+rj9LdVXSl5F9pg6rbTBcRQZ05kA7g2vV57/iaW5
	tTn+uQr5uogY60QuWsHHmCqGqCtjnxPYF4qo+7Rps+lo46UldYa9JoMA5XkdAsSZGn2bFLKkS5V
	EjcjTWTdjuwxKtznP+DcQh1lipnKTGnaG2sj5rkcmjrucmmA
X-Received: by 2002:a17:902:d550:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb01986bddmr124955ad.13.1793130211108;
        Tue, 27 Oct 2026 12:43:31 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f19b3sm251941a91.17.2026.10.27.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:43:30 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
Message-ID: <auD-r_lTZ71vbSKu@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:40AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.
>
>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/gup.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
