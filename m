Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E33CD8B0
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933037; cv=none; b=WC/TWlnk73DsMV2PFf36gX8Ix2FLV0q9nkRokcuNEseJuLKjCa6CI2Ez16isDnlHmdOskXtsO40Iq4VyOZqwLxUrxcaepaqG8PrpgNBsh3lL9i2vuNUWKU5jq5v0fW1E9Qly/Qxz8DqFLMzr1IKOi/3fxE8Hn37AU1Dpg4ZCHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933037; c=relaxed/simple;
	bh=0SjvrWXAa54P+Fh6S/QOObxuBijlaJ4nVW7gjQMLlDo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7lRFIAUIOmOCyU4ia3TAoU3l0cb3g1t4uKlQObPuwv2fwCzpQheN8ZRxBhuGBnK3NdtD2Uj0kReM5LO0Rn/BDzdELFcJlO/IY1bisAETCy05z3HQ53bfsf9bJK1AA3i9RlxG++o0w68aNWtYabJTaS47JLM9Gk4cx1nHHFHiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA5y7lGr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA5y7lGr"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so25063881fa.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783933034; x=1784537834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eswem+fgZ39sD2pjf/HcQMj2cdVo6XyD72F/asLblR8=;
        b=EA5y7lGrPrfI9Zl4WzGcqnJ1mFq103YY6XlqWnYuqQRbCNBOSaWSHqlgN7cpmuJMyN
         roZRXFsWyi9KIQBobULy74Bi0pCmTdM6xPw+9h5CFG8YxeFlSdn48ZAeLWKZ6GNJ/zuT
         EUo6JkRXBoER2aRLRFwCuf5jLq2/kvTljXnIQrZq+qbcAQ4WFu7shNLnTS1bVi8s6Hql
         uYwglrGE3NpduJ3Ym0F1fVgSSQH1x1tCBV19uFnAFI2UmEcLRCDyAFT4UoouDO2B0fOX
         PzDA4CTzx2iYkdKyA8+KNDyIkcLVI+nAiktN0/fSwenws3HPtNAYmCILhavuMdLeqTH7
         3b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933034; x=1784537834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eswem+fgZ39sD2pjf/HcQMj2cdVo6XyD72F/asLblR8=;
        b=Wu5I1cE0QLKTssuCAD8ojIJOwH1C7hgptBZ+d6NQMO2AcRpyKYixiD6PetjtXKwb+P
         8rgHHlpn91Qn67E+hw/s21o0S/gOZdJpCwDXHNnjWkyVnPl85xQOdEO2YvACNCh3z0Vs
         CRO+j36OJs+Bk2SJ3bI7A9r4NqWS7f68mmcvT9CmLG0aCtptEFChh3w2jFcKGUIiB5LJ
         Rlshvj6wKw3EYFKiYS7zuHRGC+TdD16Z7k/EbObJ2vdNqAUey0igdVk9LFyZZPH48D3d
         NV/NraBAlUjRLUygEpXbrIZvG5CgOnzpizUeEN9y9DPV1P7JGxNtHxGH5vDhm0YR1van
         q1Yw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+7EAXIkVGJ2tUSSn2AzItlXETcg64EgYSPRo5qaLqq/ROqp/gfiqvokNc7+GIW6Hu6arnLfuHHSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcrhhYizAWc8m4f2CHDqHI5tTfaKDwizRSiOA5GI39C5a8Wme
	DFNYYl8DIaY4tGU9u5mwqxrFuh7+iPLffdJiAcAc8V3lsWg29u0IthaJ
X-Gm-Gg: AfdE7clItrgGeLwsl1L5CcKTby42wPmMGPghBWlzLbZQ4orTHBRxxmhlMdEcpu2voxj
	s/NXA78URshvliyMev6XI0J+i8mY4hpa6oSwVmYEWkzdfWNv1VsB/AnzVifk3odxbrSvrntHpav
	Ca5Fzk11gLIIhZzBMfMSXxy8fs24M/x60WPyiy8tNEbGq8pXWtEwUaprxFYU/TP3RgxldKsPXr4
	yoUcwDxNQV22p0uNUt3JwQpqOag9cnKSdmV3rItHROb+qP50V50ZfOhzwtPVGK+rsN8ovPQUdsi
	zWv+EgTg2YrdEs4bIcCmlAAwcNEJuTeH2N6BTDe2wcJLwz3JsHT6LaLC8b/j5H2fbMPxYDKea2M
	ard5ZRGxNd/fAnGjuKFpidFUKS4vnPN3dmBIykp/OmxWxW+DieqYlQ2eyjjOKnzFCy5nr8LZOtH
	LZcPmp4Ys+KAKHpBNfPnGInmQq2wllxF/99XB7NRD0
X-Received: by 2002:a05:6512:32d6:b0:5ae:b136:acdc with SMTP id 2adb3069b0e04-5b0236a4a8amr2022533e87.35.1783933033504;
        Mon, 13 Jul 2026 01:57:13 -0700 (PDT)
Received: from pc636 (host-95-203-16-226.mobileonline.telia.com. [95.203.16.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a2e9sm2657309e87.1.2026.07.13.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:57:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 13 Jul 2026 10:57:09 +0200
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com, kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
Message-ID: <alSoZTopsSYAXM2z@pc636>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-internal-h-v1-0-956d5092782d@kernel.org>

On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) wrote:
> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.
> 
> ---
> Mike Rapoport (Microsoft) (3):
>       mm: split out mm_init and memblock declarations from internal.h
>       mm: split out sparse declarations from internal.h
>       mm: split out vmalloc declarations from internal.h
> 
>  MAINTAINERS                        |   3 +
>  kernel/liveupdate/kexec_handover.c |   3 +-
>  mm/cma.c                           |   1 +
>  mm/execmem.c                       |   1 +
>  mm/hugetlb.c                       |   1 +
>  mm/internal.h                      | 183 -------------------------------------
>  mm/kmsan/hooks.c                   |   1 +
>  mm/kmsan/shadow.c                  |   1 +
>  mm/memblock.c                      |   1 +
>  mm/memory_hotplug.c                |   1 +
>  mm/mm_init.c                       |   3 +
>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>  mm/page_alloc.c                    |   1 +
>  mm/percpu-vm.c                     |   1 +
>  mm/sparse-vmemmap.c                |   2 +
>  mm/sparse.c                        |   2 +
>  mm/sparse.h                        |  63 +++++++++++++
>  mm/vmalloc.c                       |   1 +
>  mm/vmalloc.h                       |  46 ++++++++++
>
Thank you for splitting vmalloc. Later on we/i can move other things from
main vmalloc.h into this local variant.

--
Uladzislau Rezki
