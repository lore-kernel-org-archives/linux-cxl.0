Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283240;
	b=qc4igQAmPgA4PpVROW/f4Hp54rB3LMSkWAN6vOIsuQ9WAIcrtXaNeTbaxRxNg5LLaJ49
	 VHqLgMym2YzXDokyTJtpeMhXfZecDzTchFt9oiJX505LNYLHZ2pKIr7DaZwZDj1In8+g7
	 Y+FLQZW09iDOpsWifqcQ6vK55tESJ/jSaqP8adX08SUYZhqJbjolx8L/xtOHQ4v0hQhaD
	 rYQqwhKvcOXHEZpbSH0R74qDJEcN294Ikv4R30sYhZIvKu4VosIQSedNO382ZUKTrqrs/
	 +a1JnNWJ6ksYOK6IaSZ89npzkOLq8Aem9d71GyTYydex5Zc41msty9ljV2Y0A5q6fdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
	b=awParBxZbCG80wIu34qKvZDnZmJkNz9hJJ0m1YJiurB4rBkl86M7z9aFNsqNgRrGHebt
	 vNVu01RVj97+Fp/OPZ16EFxB6lwuFiHaXvp7M3DL7XrcMPbtYxl7Pk80OGFHbVs3GAyeR
	 tXTFxYnO4WDuo3dVhVU3ufs4bcGGLyXvb7yBu55gi1bBHYsyx+MGBEQ2sKg3DDtXkjTSX
	 XgOUNDyj0vnGO6bvyeWk/hQHwZOI4wVvLyjpzC+Vsoj4I82ykHkBsRWlNWgznwPrX2ExP
	 ak4uX/z1qVVPJMvquWYW9eDn87ztlDJa2h3S0qME8Ua9DqDWC3nVWYA737yiC2HO0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="e5/0LFuu";
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F2606A31E
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e5/0LFuu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4395d31228so340107666b.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793283233; x=1793888033; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=e5/0LFuukNHW7lzYuFosRJh+HCYXR9pyFNiQxvyIIBVipBFBgPFdS4+6o0e/VLtSHP
         D2NV+uWECYwfjgApOljWOGHKCse0y1GozqH0FgOpVe2BGPs5fNsPIa/znV1SPRUcfRzC
         S2HvVwG+whXsWeX2XViUnh1wbiyPOAgZYzqXUt26yduzQ4O2OmGCssgjZkXAmf+1GtpK
         qCiL3bvCUG1uU/sMo60Z4jhr+nRw7l3FkT58U3zkvqVemdPsgtw1581thB5KWAkrpUg5
         ZQXV5QFXWQJRc25kncj0f/n/AZy335nPp8YBto+psFG1ofitw09eWSoKIi34kVGWTlCu
         Ewrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283233; x=1793888033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=bPdY4SiF3OQ8ToitkwbcJZmXx+XUCShHLe3gUfT+8vhMWaefMYe3bf564qlhEaCT38
         Yo6hkieVK57DFys/aBYY9a0+suepEEDuENEVewc5KW906maNM4u0sBdA53txsXVuCPjB
         LucS4ll9jfaemsTJRzZELLCxlbxTmhKG2oUTpWLdpiEc/iOzH9cwFhsnb53724Q0lAgP
         f8fP+Yg+Q/n5qashwQhRkxQ7SoNJOqZq3sboa4Wg8RlOM0GsBqeoag/4UNxhDy0o50MH
         Kp4q0Yj66BoTdRkX9EnsBhV9MqvkRGHTPdY74XvtTcgcs1HSfuxjMzD4Q66J6qZTsUX3
         fbQw==
X-Forwarded-Encrypted: i=1; AKwUvBy3mtOrcY3twecYtZHjuPCI8hefJG0LazjvCFk+xwFa4OzCK1kNRJyw9TswR5Tc33XTkIuIZzSn5nM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq3d8HroCScyYpxGYn5wXWDSWw0AwlvVlI5fn07tGiGlwHeSz4
	m4sSEQ4fIxAxVvWeI8p5M9BVRN83XUXpBtlGLgjQx85I4vnroMmMtoyKw1o5VJnLglI=
X-Gm-Gg: AYBFou0gQISVsepr3zz58vKs+UbiSrZFhk9ZmQ0GrK1/rA8YwKdi1fIH2xj3MHBrafr
	M1I9AfRS7I+1lXIz7ueMq11KFBnl2NxeMsVjQxyc7h65zRN9ewJ10VmzNPAr4jfYnxjMChvNNhs
	bS6BZvIU0B2f/rQsXQW3gLlw7WRdJ6ahPlQf5s8N7cwnRLC9b4n6LAXcKzA8Ft7XzoBRKfABie+
	lIRkurDhEhk3mkZgWBknHjfJkGh4KWDNeswKHkTnRZY5DYMbsQ2yGe9+aKZY00hI3L6xS75Xi2w
	5wRsI++zDTQbNr2/5lfDhKkXpPyuTK8h+xJw3IX+faFYwYXupK0gullRdotVvwmnWA+BuNWDKnx
	gTs5rEBnMk4PHPdMQAWpmVGv6tAvgUH62TTshV+I4zwXxu2n/BUh8CCS/Q5+j4PS7GqEZ5nEnjI
	6ukyFF5mCUCBYUusY+5RhAbu94FHKyQaK9CQeKZ1HtKWmMIaGiNbVi6Bkj3cEn2k5zn9uu5LKjz
	tJvc26mFNrX3bAfxZ0eWCkHJCyJepBhoPgs/J7Vrao0C9HggluIcdSSHgqLThaPrDjfHcVanD7x
	JY8UET7CM86op3Xv9Xw=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id a640c23a62f3a-c49be03a73amr545832866b.41.1793283232717;
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm521507866b.60.2026.10.29.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
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
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
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
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
 <179323853182.453251.8510731747954180380.b4-reply@b4>
 <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
Date: Thu, 29 Oct 2026 07:13:51 -0700
Message-Id: <179328323124.453251.12177231963891458248.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 12:01 +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 02:48, Gregory Price wrote:
> > On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> > 
> > I get that you want to avoid taking both locks while zapping, but
> > wouldn't it be simpler?  I suppose we don't know what kind of
> > regressions might pop up with that though, bah.
> 
> Exactly, that's the spirit of the original code. We would just block a 1GiB
> range of va space for the entire operation.
> 
> If you think there is a more elegant way of doing it (while minimizing holding
> the pmd lock), please shoot :)
> 

Elegant and this code do not appear to be compatible.

Another look, i think this is the preferred route.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
