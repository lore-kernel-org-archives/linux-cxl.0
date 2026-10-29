Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288653;
	b=u+gmqky1tE43T0B+CrBpqxEnPyqyW8razFIMn5u9uUuvGsVdeFeoVvivXikTM+wwiTFY
	 mLCP0kBrAblTrQR0FfZMA7UOav9Rc9mI1Ag0rbEcwnHR+QdVijdQ7lpT1U76J80paX8S0
	 NflD4u09zi0hnskGsKM6pQHoloQHaoVQz3UE7TnNtqTlwDnvuM0DK+n7Dh0nDzdoHPbCa
	 65ELOgN835/gJE9tEhjI/6QFJzC07BeM0dUEHDTPYit5XEq8PYmr/xrKm41RuwdxoLcIC
	 l622fCveosySNInhOWYPETHg2ry+TT/b9/ZF6ZQs90toYvsGfGsXhCOIG7tLyEvyIwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288653;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9LohosSmNI0EaSphEpGjYH9L23OvaCdilKiGHMtzl+I=;
	b=ccwF/wd09ZzS6oiOgEL+jyBWnsRHOqwgzYAmYVJK9wl1qYXuerkjMcN5yXlVtArOGQV2
	 Mu55CjGIXWPBFcKbEGljhuF3YzdJgrO6ltiUfJNbPmljHTg/FNJZvsX2oI+Fu0S6ZY/3X
	 MfEWJ7NeeRjX8Z5RxxVkQhzQeYUIr1ddBAy07paVXxj7m6VRfjGGiWw3x8+9TfMPZGmmY
	 eNZZajAis3Ujc2RPcjf4ODQIldJx91WfKJWR5yIrYXhcKU3nDr5KRPJsgKSULSvt55VOY
	 /s+2Yc2R/dNlGT/6xc0mIQcFjJKDW2Fw+8hrQpj/7nI0R0qIMxvS3CJtc9IeflQ4GLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyagxtlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6528606A330;
	Thu, 29 Oct 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyagxtlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7931F031E1;
	Thu, 29 Oct 2026 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288652;
	bh=9LohosSmNI0EaSphEpGjYH9L23OvaCdilKiGHMtzl+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyagxtlFRZCZ8laotq+zQX/nXLERa551dmYVok4IhbDxultx8Qv/zBxN54h8zWNFB
	 SU+tc74cj79XLWTEjRkwdxchX9I6BXRs21mLGib4aipJWDxDX/KvxW4iqXOSr7B0dx
	 eme5eSIcyy8lJJh/A0BknoG9D8uZig8XSMWsJd3rvw5Pdll/YBqlR/FyK0LWdIjic1
	 k0HXGV7jTLdAqFs6AdorrgNLNgGIvlSTjYkuzYdUXJsEGDCqm72UBjgUPtTCzdsqeP
	 CNAnKspdsy9k+rM2AVusw0R8k8/cc2GV8FBVCf9QtijcAoNWNqrIhMx9kys+i4sdhb
	 Qn/epeF6H3VQA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id B8741198003A;
	Thu, 29 Oct 2026 11:43:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 11:44:06 -0400
X-ME-Sender: <xms:vGnjaqXV_oXgY5WUohdr93Ik2ciaVdD-rppLtqYNFzseLbm9KSKfCA>
    <xme:vGnjavN8pBx64E9WcCMA8kFGqSS4xWegMAxVR_OBlfT1SxSA4n0In5x5lbogKKlBc
    2rRH2jGjWSLyr4Tyc9R7jhxaFX3yje0xka2R1JpP2wFHC9Wg3f8KVMj>
X-ME-Received: <xmr:vGnjaiVCXjTDRQFWtHXM2tH5Wgg-Aq7EBL6jORvsqxqYi7qv7dCvrGbSRIA>
X-ME-Proxy-Cause: dmFkZTGgJ834dc6Y2aLU8zitTP7wE/5Ai0JJcu2EEkyHN74nVjQguXnqD1o/giwxhWpS9o
    5GchtjMcZM/GimMO/oRY8cX+X5o2O14DaG/wHSoGgsePhNezpMMUR9hxfh+6ePbBrSONp8
    zUTDPK4YxRFB7PeD9qpcs33Dq2TJ1rCyaCFWQqXYaeQ5IfvhaG1aEgdU9FIBIbjxQyUEVO
    HUhgjEnLM/mcjpKXN3he8HzQsNkc6t66xTfzuNR3aFM/rpGhCVU4vnygjpenFdd7gimv9e
    MgBaDigPiYtn0obZd1xKf8xjo+9ygSAq03nBlObq0yoPRGrpSR1NmJKyzbHTEpvNJryhG2
    oPIKnzFB/jvoPqtSeTVcwgzvAxg1c5L48mEINcwempzZtumcmvHXasq/aFb81DhF1mCBpJ
    k0Wd876DP/lwDJqM2yLb9ejFBfSTZaL5p93eohaQGYpjoUKfReSmxvjtGjgIvo2rmBt7la
    FqiSPNMgdpRknAzIxxtHBZwUytDrApT3RG3uLkS298mLHFtCnBMbrOKOZH+PAxoBTWX2Pn
    9gF3ShCPlU6mXRgQPAvMj+FEowG2WQXnjXKfnerLhTADFznq+/TOvIONV4A3pqqDzDZrzC
    SzVIwowSHvm6FClF8On+525Eh2Tr7cnWddMWSEr16lkF2XGXutWYCuVCIvHg
X-ME-Proxy: <xmx:vGnjamxjzn27rK0ySjsGRniUaql1tj51-3CqBDy-1H61hM2iCxkUaw>
    <xmx:vGnjaoXmMQI9KQwEfOjnXMm-rXDeB-wh8O3GucM8N1bOjv5Gsw38Gw>
    <xmx:vGnjatGq1k8tRzclx_X2jSCVi6_3zr7GTYrg3feqS3CvIxacixI4ig>
    <xmx:vGnjat54KicWAGKdQmUX9xn_FZnJU6qwkhTMCIjnw6EryTcAJne9EA>
    <xmx:vGnjagBJm-xLj-uOPmq8qxgdDdgBPjFXl8HGy9pVFnLZwZ7Eo94LuXNe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:43:54 -0400 (EDT)
Date: Thu, 29 Oct 2026 15:43:53 +0000
From: Kiryl Shutsemau <kas@kernel.org>
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
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auNprZJRad8r_xaY@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
 <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
 <auMvYdTd_e9O9kDj@thinkstation>
 <7fab2115-6c44-43b1-b03b-8ce4a37ffe32@kernel.org>
 <auNaOMYUUpnzCofx@thinkstation>
 <957fc9ce-1789-41d7-a4cb-66acdf7fcecb@kernel.org>
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
In-Reply-To: <957fc9ce-1789-41d7-a4cb-66acdf7fcecb@kernel.org>

On Thu, Oct 29, 2026 at 04:21:54PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 15:38, Kiryl Shutsemau wrote:
> > On Thu, Oct 29, 2026 at 03:18:23PM +0100, David Hildenbrand (Arm) wrote:
> >> On 10/29/26 12:37, Kiryl Shutsemau wrote:
> >>>
> >>> Yes, I missed that the loop only goes back to start when a lookup
> >>> comes back empty below end. When the last batch reaches end, it exits
> >>> without another look. It doesn't need the split either: any punch hole
> >>> whose last page is in the page cache gets there.
> >>>
> >>> That exit looks unintended to me. b9a8a4195c7d ("truncate,shmem: Handle
> >>> truncates that split large folios") turned the "if (start >= end) goto
> >>> out" early exit into the loop condition. Before it, the loop went back
> >>> to start until a lookup from start found nothing; Hugh kept that on
> >>> purpose for hole punch in 792ceaefe621 ("mm/fs: fix pessimization in
> >>> hole-punching pagecache").
> >>>
> >>> Restoring it is enough, and makes the "restart to make sure all gone"
> >>> comment true again:
> >>>
> >>> +       if (start >= end)
> >>> +               return;
> >>> +
> >>>         index = start;
> >>> -       while (index < end) {
> >>> +       for (;;) {
> >>>
> >>> Then a replaced folio is found on the next round, and truncate needs no
> >>> special case for it.
> >>>
> >>
> >> But that's then another lookup even if not really required?
> >>
> >> Why do you thing that is that better?
> >>
> >> I agree that the code is simpler, but at least it's consistent with the other
> >> handling.
> > 
> > The extra lookup only happens when the second loop had work to do.
> > Normally the first pass removes everything, the first lookup from start
> > comes back empty, and both versions stop there. When the second loop did
> > run to end, it costs one more lookup over a range that is now empty.
> > 
> > What I like about it is one way to look again instead of two: the loop
> > already goes back to start when the last batch ends below end, and the
> > patch adds a second way for when it ends at end. truncate is not like
> > shmem here: shmem_undo_range() stops after one sweep on hole punch on
> > purpose, so it needs the rewind; truncate was meant to sweep until
> > nothing is left.
> > 
> > Your version fixes the bug too, so I'll leave the choice to you.
> > 
> 
> Can we just do:

LGTM!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
