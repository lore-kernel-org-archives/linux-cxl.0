Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077829;
	b=KjYbxMkqVC476utC0K4KbCp2UrwgVRks+l82VIZC9aC898sArWLIqKsUnLFWUo26GnZd
	 ZCtvdh02vlNV42K7hC1GHov7s4FHdfbr2prICC5kHb0Zt0z/keGlWRI5rGxE052he90K/
	 HaKvJysKwEVFwSHnAf2YBiHVMGt5QJS6+aTQv5UxRdGBPCGzf4a3lMw+TDk2KUAbNsP3D
	 mql81f36tgCWZWZjfs3DDltHOON7vL7faeMq+W1AdcHr6FSeHFgHTBWDTCHf0BCbdZyoK
	 oeL9E7SrOGj/L0Rp4gLg5lw/jULZqYrJ63EPDKCbJvPjEE1N7cv5ns+arcm9XMHVlQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
	b=kbR2Nd8UXLMXmh5lMIvHKGjFMbIEgToFp1PyjEQo7e5+QxMbAArK1j9RhV3J/UYva9nA
	 sQe2gRrunrZG7sN5shkdfQ/xU6yRLuRwy2VxkDhgm8QMePw3QZnCVtzNcLf0MAs/ipIa2
	 d3zn2uFEASIxsJbKGZv27XnilN0EP8vjFvmcPB6PbuBNTDCUp1f5lOWKlSXFNwMSi86e3
	 KZEG8ayBCQqvMDgS4IbjsQrdTmxBmDPeSGaiSyWY5Ib0/ZPJ8NYurTYmjNsFO4qH1/ARm
	 nDxT+j8eAcePjQSPGpAQw9L5jk0xy8myLirczFMICWPo3vasuTjAtKPSKvnniKcHrDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="krSh/1sO";
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC2606A31F
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5BC2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=krSh/1sO
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso4047428a12.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793077827; x=1793682627; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=krSh/1sOaB/EnuxksKvaR29m6EPzqsslcEUDvbWR6jV+oy9fnTCovkxM/rPw1u/v+T
         lxiOLLS87aQMgtIOGwE/Qaa1isZihhaTABaqa/fw900ImJMZPi5PHxp3qJJ3zja9eZN0
         N1PsgwchS8/1NrSdSxpXbjtCt0kPWGt7IGV7ngziZssa8t5rMKdSZi0+x2oTNqoF1xp9
         QfCXP/QbfPSLoXvihdVk58EqWwRUWt/KOB4jO4m0uCstPLPsjAhPIMZUiuouP9bofuae
         Bnw+Gpck4Uy2FyyO7f5GsvYewq849Un6g6AU18RJaXjeNlw7Jif4GLTrZY8PZABYLwKs
         JfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077827; x=1793682627;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=XJzjAPUmgB7RX5XsEK1bsvpf0lCNPV6GMS+qxJXhLFf0+xmx3uQZXF0nd72DC6GU3M
         Ybh3jFu4SwQNZtoH7zjkgIbLeNZBBM7JteA/y3DcjfnqSx81inaVtydIwGW5OO7dJMHq
         ypiETtJxCNecBRXY3foBw8hjFzOkooSeDe3cN87jEDnwZDkFUQZtwCSFSXMRmZ56AAqz
         lWQwsmDCdQW2WTAf8UGFfoZQLGmLQNz8Ns0F8uh7JNn4ISGe5xhn8gyTf2rn0KrNlVKD
         sjMrpGo1uhj16o6wjNRe4TsZ/+XnoTegs/ykA8kWQYWbXzQ7QJtru9hWwzktgEp4Fd2S
         3hRw==
X-Forwarded-Encrypted: i=1; AKwUvBxSnwoDvm6D90WyHfVR7BSdvIA4snI7tthjDCHGGeQugGZyQKLVpnTuNMzr1CppzEQ781td07p6JwI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSeL4FHSfbLk2OtNpb1/l0f5m+IPOXRIm9kmpuQXLLDIBcjS5r
	f9HSbJhy5EQmLCcqaOj+YVwl1x0ePrkw1wP2geMNgG4tqxtuiFa4DFVtG6Pujl/IVJQ=
X-Gm-Gg: AYBFou2ULtxfUdTW/LVDSvwQl54sGRVwIhmuwrsa8AIfFJFWX9NfsurI6wFPaMNVcnp
	pVS7IOMLPzej5UOxI8cNZhRpfb0EboRJC15xxF1YIV/WitLVnE3sg0vROT8SWjbYVZ9p5fao1Ma
	HeN+kkYBDz9Ldpa3CuAD18KJxfjTuIaExLGsMOmenNQ6xuDIsVE5ioWatmcnr9YvHAuPFuN1tAe
	CF1IUWxIEaQAuqV/QQYq0jdMwu6b/fYoQdsTGFluwzw09OXOxt2xTrQgHZ9q5ZpASWArokf6kSe
	fiPNAGsBcIQP+pNMjnqEq5jd9oMfAoriTv12IxhBA987IQyTGLC0HNWxTcmgvPG1HDkMGmRKCRk
	iHCgfWrLc/sNsWIL7EzY+0uRVdeZdIH1AcAUiAB4i6dszJtjOyRTgCcNJ/YKtHTZqvDOncx5ZW1
	IPgWPGM5IBP+o0DbzZ1Q3c6Zf+AgZGP80IxwG/0NlJJzjVicKgly1x1rtAe+3lpUIrh5js2PjeJ
	LZ+KK9PK1a9cnh6aPp2qKgMESBZPZr70/po1aCRjcI=
X-Received: by 2002:aa7:d642:0:b0:6af:80c4:8981 with SMTP id 4fb4d7f45d1cf-6b443001da4mr6849436a12.26.1793077826967;
        Mon, 26 Oct 2026 22:10:26 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445984d85sm4571938a12.29.2026.10.26.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:10:25 -0700 (PDT)
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
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
From: Gregory Price <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 22:10:24 -0700
Message-Id: <179307782442.2301705.17273288326330283268.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.
> 
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.
> 
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Two additional automated reviews independently confirmed a similar
pre-existing issue and generated the same patch (below).

Sashiko filed this as a pre-existing:
https://sashiko.dev/#/map/217050

But this seems directly related to your patch here, so it might be worth
squashing this in:

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 2122676c4220f..710e913c73bfa 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> 		prev = vma;
> 
> 	for_each_vma_range(vmi, vma, end) {
> +		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
> +
> 		cond_resched();
> 
> 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));

Could the pre-existing no-op check also require an exact mode match?
It currently does this later in userfaultfd_register_range():

        if (vma->vm_userfaultfd_ctx.ctx == ctx &&
            vma_test_all_mask(vma, vma_flags))
                goto skip;

Registering MISSING|WP, then requesting WP alone, takes this branch.
It leaves missing tracking enabled and bypasses the new wake. A writer
started after the replacement ioctl returns still queues a missing fault.
A writer already waiting before replacement also stays asleep.

Both cases time out on the base and on the full series. Replacing the
predicate with

        (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags

makes both pass with this series. On the base that change fixes only the
fresh-fault case; the already-pending case still needs this patch's wake.
Would a separate fix for the mode comparison make sense alongside this
patch? This is not introduced by the series.

-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] mm/userfaultfd: compare exact registration modes before skipping

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 669f71d485d02..0a28130cebc99 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2299,7 +2299,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		/*

-- 
Gregory Price <gourry@gourry.net>
