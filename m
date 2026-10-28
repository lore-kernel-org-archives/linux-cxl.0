Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206438;
	b=LIKbFNXNk+hyiihcFOm65CiLJA3GSdyfQHqeoGhXNS54egC6C9NBwtbj/MDFvxP1JssW
	 2QCjAad9kiXh5XjtJZTlOTPIwuI46k+ca9Whz6ani2njqVG0wynzkZsJk+se4no0IdjX1
	 Py1uVoDzxek1JNBViiIyif7b7bbn8H1dwVW/cyDaXyD3NivlPDF1MSLnxIb3ywteZf+9A
	 Ky5pNCaTBnZ+JpegDSNZj84/mRivDnzcEqPqlJt9Z9WPOaqqv8UXeD0n+NTTawJOpgeGD
	 B3Fl5ZIRykqhlwqbTRb8dscIZ2sIg75MCZtwyXTkiZb/XHw0IGKt7Pw6UrJs0dBIQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
	b=wLyNg8NijPIYd+kU+o4o8CK1iwSHI8SCeguh7a75O5ACyLqFgEBpc8wVQlDHE59n3I7E
	 EU44nJ1+gNY4mK/RuKLJVHmCf8j5GMD5URgF7AUQbwo54pKzmzSUn61X5+TmrcNF784jB
	 qAuksu53Bu4EEhlnC0BnApJZfG4YQxYlECXr3v7sE+nJKVRSNiwQdWESDnFFYV0wJnUKQ
	 QgHXJibcX4JvI2WIx3YS2Hx9KEXFwupkd0xlMaL3JfwiAZ7TC/IEBwEM0ocJUbeSdUtGD
	 rhPAhvAfm5++1yR7OxsrLQjD5csYtukZfPzBr+1Gm1qLvXQRseHjhGFfA+Ez6AZzetw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XDq4mZkF;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64487606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 16:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64487606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XDq4mZkF
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so398654137.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206436; x=1793811236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=XDq4mZkFFwWiuClm+CVqUYc4wMUeEj61wwTEJ2ZEwdKAAZOVs4mAkia9/oOPQEGvZ7
         0CPllEZOpo+2Vx7NH/qeJyuqrXNeGxLOX9kPYs9EQ9wuoJxqmE3014fXKocl5hQCZSSq
         jYT4HKvnmSRh02d1ht2QsIKl81mDMWNV+vmtqq/q3kRlDKFLvoFwvUwOFm0i3nE1GCkQ
         0TjmSaJ0QDxHwSaQMTz0/I03VsYupX2JpKIJaxwXOjS22DLQQPY2UaMVlL2DtL/m4NnR
         nHVimsjgnDDTHtl7ghN+41KfpsxRYFoCjEcPBdzS03ioSJ55NDDAbq0L5U9RWlFtVa5Q
         rq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206436; x=1793811236;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=Bw/27BOpG7h1+GTu5w9zR6/600xeraHlL6dZxrRgOtJbV1R4+6Wlc4qjS79hWV0iFZ
         e2j3SIunQz2vL08y2c9pip3VnNVBigcYU2f5kyX2DEGOd6S3U8Me95vPe9AMkk7Tva5u
         6NvHunYZopovSIjgyORqeNMiWaLzs7ECGkaLzKR030hbyr8H7M6J+krCMjeRKuJiQyi2
         snZGlz4MgMZP8EkQ7mlPMZ8defCeZ7Dcqq1oqFn6DiQ211/JHS0qiXDcQzpFInN12UnW
         /wk45jsB64XqruGc3ujZh+gsGZntex3UyJUcAYA6Gb8zH1K6EFgi7GHTFHHdFfwbpI3o
         9XDg==
X-Forwarded-Encrypted: i=1; AKwUvByeR0p3H/XachvUsVE3YYLtqNW0snKOZmC1kAPSn/jQ+7EUgOZKGWLVxW6bCgkWa187sTnbBXVDJVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpfE812q3xo72a+YvLrksb5PVAlfra4LSdNDcsHAwXiLKKbRMN
	OPxny3Dpd/OnYtnDiCrMHQ4TeORN7dEsTO2WYZQL4rEdHcBjUBlnbKQZ44iYsJz0DZE=
X-Gm-Gg: AYBFou2qeTqzW2AQx25M+FIc9UZHW9C0Vd3ir1FaMfrfkz/TcDQEhqvhVaLHimROsb3
	vH8G89JooVlcC9+LAZIzSw8tGWRSvkFTt3B7d5fLo9S0W3VmYK6BimINQcmXXypXfwfx9Jb1RTx
	CBW3IrV+r6b2BfG6Uv8J6HiTX/T3bYm3ucRuhmWkl7yM4BmYsLUuSH7Vfaz3oD3DgMYW3J0rt62
	8w7ndK8V9MJYgf0LFTOROf695vZJ2NeHehnlzRdmXhHmz7O8ZHDWp/+4DlyQjVsNtKXRx8UuXyj
	w8jfls/h1r5vJItPuCbHCV78Ug9fGPm91Jgv90Yk5o2aodoL7txQTYgx4COvKWQQGgHkluY3cwe
	Sz+dJ1bKLeZyS1x6xgETTGwUuneMMHXJHJN7KwhqYkFvf+AFgRXnsCnz3m4ZtkC56bDNMAjJbU1
	K4lEmyCKK0JgIp8S/tB86j5PgZDQP9oTeJ781RGwtzp+HfWr2udxpEN1KeNEMdOAgAEwlGR8iXz
	RV2SauMbN/fYmvgHCn0+a78GwMiqtAp1RZWocudEuoNOA9ziGK1qEVcuXGdGffFolrTtpPjdTQz
	+EGSv+GTxOzxXGg0e8cOmdXMw9IKP6stvvf6BkHlrWb61ZCzt/x+R77ZlO1DWgDpdlio4jrJ4BB
	wKTkPywAkxj7vIW+temO4qmkHeza6CQ==
X-Received: by 2002:a05:6102:3e8d:b0:7cb:bb33:8412 with SMTP id ada2fe7eead31-7d03a5063b4mr1453208137.10.1793206435862;
        Wed, 28 Oct 2026 09:53:55 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259db2d3sm6495987241.6.2026.10.28.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:53:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:53:47 -0400
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
Message-ID: <auIoDgHmzpGH6cOl@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> shmem_file() only checks a file's backing mapping. That mapping can belong
> to another file, as with a Coda file backed by a tmpfs container after
> mmap(). It does not establish that file_inode(file) is a shmem inode.
> 
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
> 
> Add file_inode_is_shmem() to check the inode's file operations in both
> paths. This identifies regular shmem inodes, including those used by
> memfds and ordinary tmpfs files, independently of wrapper file operations.
> 
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/shmem_fs.h | 6 ++++++
>  mm/memfd.c               | 8 +++++---
>  mm/memfd_luo.c           | 2 +-
>  mm/shmem.c               | 5 +++++
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a7c7a96a7cbf9..2ceca7993e4f5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> +bool file_inode_is_shmem(const struct inode *inode);
>  bool shmem_mapping(const struct address_space *mapping);
>  #else
> +static inline bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return false;
> +}
> +
>  static inline bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return false;
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 0f6fff004f5e4..7d2da23157003 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -211,12 +211,14 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  
>  static unsigned int *memfd_file_seals_ptr(struct file *file)
>  {
> -	if (shmem_file(file))
> -		return &SHMEM_I(file_inode(file))->seals;
> +	struct inode *inode = file_inode(file);
> +
> +	if (file_inode_is_shmem(inode))
> +		return &SHMEM_I(inode)->seals;
>  
>  #ifdef CONFIG_HUGETLBFS
>  	if (is_file_hugepages(file))
> -		return &HUGETLBFS_I(file_inode(file))->seals;
> +		return &HUGETLBFS_I(inode)->seals;
>  #endif
>  
>  	return NULL;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f9..c0811407ce397 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -582,7 +582,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
>  {
>  	struct inode *inode = file_inode(file);
>  
> -	return shmem_file(file) && !inode->i_nlink;
> +	return file_inode_is_shmem(inode) && !inode->i_nlink;
>  }

Yeah, file_ is not needed, otherwise:
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  
>  static unsigned long memfd_luo_get_id(struct file *file)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fadf23f9e21ed..0d41aac125df9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
>  static const struct vm_operations_struct shmem_anon_vm_ops;
>  static struct file_system_type shmem_fs_type;
>  
> +bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return inode->i_fop == &shmem_file_operations;
> +}
> +
>  bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return mapping->a_ops == &shmem_aops;
> 
> -- 
> 2.43.0
> 
