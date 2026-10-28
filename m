Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206505;
	b=LdNL4xMnGu9r9VqWh+SJGsNJb9iQ6aE+7+Ez9HqLr5U1Fbz9CtiYdvjLUMdcDCNssch2
	 D9xn+frKjHetJUVnFUw32TBAivCZf433RH4tYx9DHBpoHvvpOhl4DGx6qxQZItarWpE+S
	 HE2OiEmvOwNrLiaLpCryxdXOx+BNRFY2fAup8IvQJyRMZY2k/Hj948go2kBu3qPlaUuvT
	 Ltkpzarlp5I19M63m2WFWlnrtXeRPxtYHIHUkyQG1x9sKfHwO40/Ay8rnkHVNCSECH6Mw
	 QIlaUWhYUqiFmX1Sb2l3bC0ploN1OwQ9mYw4uoWLdNjo5e/wyLMN+N/OSIaevg/7fzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
	b=hBs1qyyjWuRJMEI2bp3oGOOkUzsEYyfO7t3q6Zoqjq7FYhQBb3oGW9MsSO9u4cHShoP/
	 ERp1s2D9CDuOuJ1rz2I0EEwNtQzqsd0r/nHsjwO2ZgZTTJmp+55i0YljGDJz6D7y1DrQ3
	 zPJ5lLkMAnR4WtgLT+RqyUdtb2EuV6MmG397/xQYAz95hS+SxU4+9Srq6udC0j1RC5ov9
	 8L2Iw6OrTdf0WNTN4wG4s4XwjdewVx8fLE2IMZVQByRbhZvCzhH5ByHW7MBj1f55qCMdL
	 VqDPr0m+Ucy4Ww+34uFnaC4AOE+JO8vc0k6BsllxGaMX9eDEzn68ntylirI0n5+q+kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254F606A339
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 16:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3254F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so483483e0c.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206504; x=1793811304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=YZTcsWCIUypnB5n4D/hsVZ4sYhEwp0OAWBZMIpgCIgC9VKYTguiLg2qUrAb1YtwQXm
         fBX2qjbMohrDsF8FpU3xT0wg+Z/De85xmZkcivTaFPK/xC2rSJQKjq22NWOhc1lGVidr
         hM8JGH+eSNGpRlvJh4EuWmmvnFfWam7TOV3FYkuqC4/2+sI4BlGechXv6xOQOVgypb6q
         zWTc1Wh0ex2ijemeCLiISE7AQnNSqdbH3U9hHcLHJdV8/WdwHyqp0xajG5zARiSHdoqr
         pOVMKySmKrvxR+H5Dzu0wqmwb1u32hxlg1K0CKnzvk4A8gUXWUD4WI0PaDrMBKpYlNaK
         M9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206504; x=1793811304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=rUHUn+RFauiy8AOizthDKXatNi4WMNNDgRIC5u/lf1/xcN/P/BeRzaLtOaMcBaIMvv
         zEmFR3b2raOkdaC2nNgVgmefCjlq9+K9T18TAtuqyHA2BhhyCB/V3Si/2bzanvhg1/W4
         ugsGIBUDusJJuy9yEeULV70oa0ci52f+Jng4NKe4UR2oyVPhkz8cECJj8tNjZSHrCuir
         CHDlWYU/6tDKFLkyjOuPMNuzs4Vcu03JWJ9UdbHmZP67roecnqM5Un5NsKmQhd0LxL/A
         8AQ+JOpcTfo65+baymSuU4kC58XO0DzS1bUJsYmHk2MlmccG8Qhj/hYBY0UJ9o3yLNbO
         k8Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzJ2rtbBhMiv46nNz6ayPC3Vw+yPxaQo/twbX9RgpqJqyyrL1FKPA5P+b3SbQ3pA67xJauFnDU0NHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK08RxJzXGsxVA3IzwbNhysAYGWxRpB1v/2gy3dfQCBO3SxMeLc
	KBfKedD9RRId8Y5sYF65ttupa68HebkGOfdZwj9yi5wclpbxM70hdnf+xA1dVtyE8ZA=
X-Gm-Gg: AYBFou2gCQO0RA0TUGwC3OAnoo76X6N6BT188L6aJrnaC3VW1GIAPESh51PJsDAQlfg
	uwMhwoDALYnTg6j4KPiryyupsrtqJHuZAkfyDjIZLyKmq+TzR0HSUM44rWRA09UzB1iU4ZzDxa7
	3e7sDVev4KnEOXOi0JdGEQkzkkREur2vaRwAnAVw0hHNHRczo6qPGDBrkSm2IZYt3OOsjsqHx8x
	AyCJlRzMN1R2zoazr4gi/CG4s578k2KfQ/PP5eD7gD8dar9/MlZgFpHnaQH67EO54xwCIPIHZ8+
	EEcIj0FHZ/IT8VV2WnWQO9Dn/CgsUlkCdqFgIdqnVAC+oE/jfQypb4a+yqSWQaNyS2/Opmgzzlc
	eSIJjWbxrIGRdZDsYA+lOg/XToUYQEMarKEhDhYlWHRHnJtizT7KArcHYB1tLLbkk9QR8hSsBap
	ZPW6PjT8ljPDgMRkwtKDXDjgVyovDYlyqyOnNyf8bZc12Mq0evBcS8GkPbyA3aRrpuGR+kJrbOK
	FFXNU4GdMKPa/Zk1F9ydqGtnehrPbJcqEdmvKijQd4uKYNR2R8Dub3rJKaPy/0ldgbue3VPYRQu
	LdwcyjcXvDoOGLnAGUtlIY7LKlkZOJfnhhpAul4XO4COBeF6j5kPfwMjPdnjIe67OR9HkB7avrH
	49weDnBtxd+KOAArWz8jqkITB4RtPlQ==
X-Received: by 2002:a05:6102:a54:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7d03a505a71mr1235376137.12.1793206503993;
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm6300543137.9.2026.10.28.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:55:01 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIoupm228FQTNGi@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d2da23157003..6f5fbce74f21e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -484,6 +484,8 @@ struct file *memfd_alloc_file(const char *name, unsigned int flags)
>  	}
>  
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	/* a regular file like any other: POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
> +	file->f_mode |= FMODE_ATOMIC_POS;
>  	file->f_flags |= O_LARGEFILE;
>  
>  	if (flags & MFD_NOEXEC_SEAL) {
> 
> -- 
> 2.43.0
> 
