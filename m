Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206481;
	b=is1WGq1L3AtZnCFsRzdzMUiVPW4zJkE9KkeFojJNnibj5PsUHXqKKZ6tz9vtHNKmZurk
	 ORc7JdRrgLKV8bSkhy6pgCVjB+kvY/Yucrf7J+9/wzgv7zELFpYlmfs0gFzqhdWD5uCp4
	 F9HfttYyEWSvgOxDlBijBi4hs5CiaNb1MplqAgbUtsUd41BRBMUfyYF8y7rgJToXLo9gI
	 kuJDK8bOAlrtu+8OhveJQo1Mhr1UEfe2+EXtI44ToOdJP8OjaLGvooMOdibp2xXZau589
	 25+pOQ0ElFAF54mXiFoePUQP1SRyH2mDB4/pfAL7wpvuN/Sl24iISoqOG5E77iQDTcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
	b=jAd0h/vRPTPMluk7Nn6VfAXuJ20H8K3WrnFD2v4S6gZphCOMqURYXQCFXPfk4aKTBK6f
	 FgfFWrbrlGs7kobtb64voUhvKXVjQnKUDFJDMVM4nSYm9rAGjNMHS6NyTPfaLFq8TualD
	 9rXhcrIos1os+7ocRlEjRPNh/JWqQmpeiAu9IaGtJDW8GzpkayzsioCX8+s76W06exc/z
	 KoJaHIV7tmpHjWgPR/0R42reBlu5WxdlvrkAfJlNjQQpP5PxbD2ch/YHTFjgmquIh8V1w
	 3S47rPDjEYXdOTU2+3URozNKqUW4/Myo18bCeRYnHsEBMGfYnqnlEBmCWgabJK00ycA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36E606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D36E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c43fbcb4393so193636466b.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206480; cv=none;
        d=google.com; s=arc-20260327;
        b=mmyIM7FkLzGDkWT9f3GE3o+PznfqvKpzryAxKxqNwsAcnGMleNYrzG+RtSX5w+wKO6
         gjcaaShDwiVhK2bzsvVvjWmnIOF3QPINW5iY3qoH39MuH4GcnLE2zZ9fzFn5bDlL5jZx
         esMbwY3s68/2kUinuMvI2XG0mcAzhHLfPXZQ8YR6n4Cc71jo170oQh6thi7v1gSMGmTU
         EPoTmXiI6u1txX2hbo5G5PaBBc4Pq/QauhbvHyjDCb7b7gY6fSqFW+ivsNBe9aOi83wK
         V5UI3uJ7GYh2jw5jZzMBu4cNoR+VFI91jFO5Uil1SVzFREVQ7iTiw+/HxYCLS1GFbNKx
         tNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        fh=BgZ1B0b0LxehtEjZlcJTY5AgJjJFdLl0OoNLk6PNELU=;
        b=gthr3T4tMU485e3FNYpOlqBltewPWNlDoOBuJvHz6MxkVChblwTHyAR3bCdsKBegiD
         JAmX/jB8+Dr51gPP7y0vrFhVlovmjL/XmZhWHO4mG5dKrAcFIF1vAgHZpujE0jqDpgbt
         754FlDR4ptmSQ5hQFwCpszSk3RO3uR9mDRLAHuj7lTPReMLtSKaLsCnJ7sc+M8tnb9dB
         QCi9pZ/2a1RBGtYnH8aEZihWPaqmz/JoMFTI1wJW95YB/GvCBwYvITpaJORRCPWdCYv/
         oBT0BnTQW7X4Nzq+u9DUvDFk3wCKE5p+IalejGKaAq5oeZXN2AWvFnN4LJWk8TM+oScF
         /+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206480; x=1793811280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=oj4eYMqFg7gHe9H2JcxnVX1xekmxsJ19PcyDmk/OMgjn5UXSCYYnXu7Ac1axMQ7SR9
         q4zcTyMTKwoBmlpjcyBns4x2YrJV/wZCM14e5QvikeiV0C+wKNF7KUibECOIrMdPWZb8
         TeeSnShwQLOPfWWedxcIMlWY8bdOdzbeIcmNlPYAeJPXpTRHI3uLnL51w/g/MSBgrYqU
         hM8NCxRBVHWjK69lGvL9PkV9slxoAJvbLHj55IQQFN7GfFG4bIrQO3qJDWc5uDOrVsDp
         Urwxbb1Ol2RkuzF1a7HS3sIe18QCl/MS8DkzaZbxu24cwwm8EY03lDrdPNjvlUvh/BZE
         LYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206480; x=1793811280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=KHuYcVPi82nO2+r3wG3CnuiPmzopJpQJw44VaXU3jfITQ+rrxpXX99k/PRrIvblunX
         gMJ+7IkmEmHMVmEHhsvLpWwP/8jIrWrcrCKyXzg3GUHGpV2Ls2CE+rDp/QyQ0QxnVEza
         lNuq92hXLvR0xV2uepaI8zAcAuygcs1cYG62AwmezDXE1SmuN1IJfbSgJAvBiFoJzTiM
         S9gBD6CB59L6YowoAT7Jn2NITiKrOT86NdkJQUK+B/yc03/G+JBColLjCCrJ6OYutXnD
         6Fxn7KMkgZqEQvLrBauPK9HYPfFna9LQcgm1puqJ2j1Yglr4pyVfWQYewqo6yWViuD2C
         4N8Q==
X-Forwarded-Encrypted: i=1; AKwUvBysLCJl0UoK0hQOi28jmUSbMc+j7A/i2PIhXS6D/aHJ1VWZ6uhCfQ6+oBjwKwmDTpavoBWoo8sl+RM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0SYjFLdEdBBATQbFSieABHwXP/nF0HB3aUpGI0HTIjLWBI5iS
	22WvJp6E2zJvrNkHxTZ/5RKra8i/cM/iTRE7ChV2b/dHjxhUcYdZD4YQjI1/IKoAc6ji+Jfun7w
	zFoKUV0abgCWymFlrRkfFJrWDFsEieRE=
X-Gm-Gg: AYBFou1BZpCUwBC2W27p+1YlKe6x0UTbUrNXxm2KsoAQX1O4TQ/2JajI7DjJFblcOeT
	hejU0CfhEaEZv9HFpsCOve0lUIw5gZbZUSkqvB5xMggsPxWC8LVBvFTJi/s6tRUwBGhoJINNxzN
	J7zoIMLNmL10MiCYeTmQNDF0j2c/XbyOs0xmmVauBLOISst/Z8tW3CzTn7Jq65lMCT98RuMSP8w
	LZWpTIXdGcNE6Q2VpE8N4F9ZAkBe/KZawGL0g2bbC19ooLY8eQ+lV2HNWQnAN+v/N4+EBnOR/jK
	V5wMBVi2d6qgCc1VC/vKORh85J3RrHcCSPy7UuktJIbBMAOU81y8Z6/lYygZVl9Za1tg8J81ABq
	Xmeq7/pGSd5/58FMoEmpSRLNVHl+uiKnijJ13gooK9CwFPJcFhUiUxx/7IoVcfhgo37Vcdw==
X-Received: by 2002:a17:906:f586:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c49be00bf7amr248310266b.37.1793206479455; Wed, 28 Oct 2026
 09:54:39 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org> <auBbKP8UNI9talDL@gremlin> <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
In-Reply-To: <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 00:54:01 +0800
X-Gm-Features: AclHuK9Ir5cjQUbkmvsMXXN1XNQvMKyhNeup0qo5sC4qB6sDOiJzphX3Pz6BQcc
Message-ID: <CAMgjq7DzLFcznTqVaRneoN+qa9StPTvcBwHMdLM52ZbfZ-ffEQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 09:06, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote=
:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> MGLRU passes stack copies of page-table entries in walk_pud_range() an=
d
> >> walk_pmd_range() when walking to the next level. These copies can beco=
me
> >> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a P=
TE
> >> table concurrently.
> >>
> >> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> >> support page table walks"). Likely, earlier locking masked the latent
> >> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> >> retract_page_tables() without mmap or vma lock") allowed concurrent
> >> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg lock=
ing
> >> for MGLRU") dropped the walker's outer RCU protection.
> >>
> >> The fix is simple, so just fix the original commit so we don't have to
> >> speculate. To fix it, pass the actual PMD/PUD pointers. This restores =
the
> >> RCU-protected lookup and validation against the live PMD. Note that th=
e PUD
> >> handling is required as well to handle folded page tables correctly in=
 all
> >> cases.
> >>
> >> Fix generated by an LLM and sent by Josef Bacik in private.
> >>
> >> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ david: handle walk_pud_range() as well, clarify+simplify description=
,
> >>          adjust Fixes: ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >
> > God, terrible. And why does MGLRU feel it needs its own independent pag=
e
> > walking mechanism?...
>
> It's all a big mess. I think at LSF/MM there was some talk of using that =
also
> for traditional LRU, but I guess it might take a while ...

Right, there are reasons, MGLRU's page table walker uses a bloom
filter and have some zig-zag avoidance. It would be nice to fold that
into the generic walker eventually, but it=E2=80=99s not a high priority ri=
ght
now, but we=E2=80=99ll get there eventually. And using that for CLRU lacks
support for lazy promotion so I'm not very sure about that, but still
things are being unified bit by bit, so it will at least looks better
step by step. :)
