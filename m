Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50D78F5B;
	Fri, 21 Mar 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531843; cv=none; b=D8w9U89ywLN0A2TrkRVELaKVtvWC64u7zj76v0Y5AyQnhWGfz4hlpt1plxLdSB5j2L3tXpdqvaILOYhtCA5QT+Sm0A40z5oGW9EJO1mA3vyGvj0Ol2zx9MRjHbhkpgdtFM8JzeHnTEnktBMZlm8FUwhM9RoV5KaLpmHLek6hOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531843; c=relaxed/simple;
	bh=7Q8BslervTr6dSGNEOeNQ9GeYiDLBdnSZjhgnoZmtYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biwglQ5k+fvCCOQ8dE6h9TFGsiOgvsG4p3D72jLnINQ4vqCMlA/w/h05sGjsFYd/FFyXhZYwOLfBq+4JW2ghfgMOx49IyZjnIcCcw6RlOxSrR3yQDUMFrFc5JKGt5VVR1CwRltHkCeoMQ51Va3Rv2N+aAgd3DDXa0zXbl0UXHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d6-67dcecf2c08f
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Fri, 21 Mar 2025 13:36:55 +0900
Message-ID: <20250321043701.928-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9xJdP29XEz6CljB@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnoe6nN3fSDf7fs7CYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8a+
	e/NYC6bxVXyb1MbcwDiDu4uRk0NCwERi7alX7DD2zY0nmboYOTjYBJQkju2NATFFBFQl2q64
	dzFycTALPGKSON2+lBUkLiwQLtE6QxSkkwWoZNrnTWwgNq+AscTCT3+ZISZqSjRcuscEYnMK
	mEmcubYXrEZIgEfi1Yb9jBD1ghInZz5hAbGZBeQlmrfOZgbZJSHwmk1i9YZHjBCDJCUOrrjB
	MoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuozMus0EvOz93ECAz2ZbV/oncwfroQfIhRgINR
	iYfX4s/tdCHWxLLiytxDjBIczEoivCIdQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE
	0hNLUrNTUwtSi2CyTBycUg2M8mmTeMpqKgtfHHwgsMhZ3/A2e7Mf94nJXotKk1cu+hmgmn77
	mHpYokfInpvip7VPLnpyuOXjYXa/23snHOATniWTFJ3df1KP/bJNXJwkR2JrzAeWz29+3lzr
	yh0neSrOYP6BnWuceDnlffs3GM67+IL9vcuzmqkpT37/XHmM7c2xc2f8y78FK7EUZyQaajEX
	FScCACO+hSFyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNNS/fTmzvpBlev61jMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAlfGvnvzWAum8VV8m9TG3MA4g7uLkZNDQsBE
	4ubGk0xdjBwcbAJKEsf2xoCYIgKqEm1X3LsYuTiYBR4xSZxuX8oKEhcWCJdonSEK0skCVDLt
	8yY2EJtXwFhi4ae/zBATNSUaLt1jArE5BcwkzlzbC1YjJMAj8WrDfkaIekGJkzOfsIDYzALy
	Es1bZzNPYOSZhSQ1C0lqASPTKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAAX1b7Z+IOxi+X
	3Q8xCnAwKvHwWvy5nS7EmlhWXJl7iFGCg1lJhFekAyjEm5JYWZValB9fVJqTWnyIUZqDRUmc
	1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAmH8pU/Hemc1Tkw8/nvTspHSystI9/5fLmTYVFlyq
	srgYvXFptvEU9hRri0fRkvstVzZ/TUj6fHlPyNWrlaeL4+Y/OSP91Cd1Qc8eh71iaz8d2BQ4
	793Rg7NXBjYIT17sbM5/vvPCwcqwgjVV80zubeefmLOA8ePSlm8Ldto0LGKTXa7ady/ExkWJ
	pTgj0VCLuag4EQB+26AAbAIAAA==
X-CFilter-Loop: Reflected

On Thu, 20 Mar 2025 12:59:32 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Thu, Mar 20, 2025 at 02:40:01PM +0900, Rakie Kim wrote:
> > On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> > 
> > Hi Gregory
> > 
> > I initially planned to separate this patch from the hotplug-related patch
> > series as an independent update. However, after reviewing the code following
> > Jonathan's suggestion to consolidate `kobject` and `node_attrs` into a single
> > struct, I realized that most of the intended functionality for Patch 2 was
> > already incorporated.
> > 
> > As a result, Patch 1 now only contains the `kobject_put` fix, while the
> > struct consolidation work has been included in Patch 2. Given the current
> > design, it seems more natural to keep Patch 1 and Patch 2 together as part
> > of the same patch series rather than separating them.
> > 
> > Rakie
> > 
> 
> The point of submitting separately was to backport this to LTS via
> -stable.  We probably still want this since it ostensibly solves a
> memory leak - even if the design is to support this work.
> 
> ~Gregory
> 

Patch 1 and Patch 2 are closely related, and I believe that both patches
need to be combined to fully support the functionality.

Initially, I thought that Patch 1 was the fix for the original issue and
considered it the candidate for a backport.
However, upon further reflection, I believe that all changes in Patch 1
through Patch 3 are necessary to fully address the underlying problem.

Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
into a single patch, then renumber the current Patch 3 as Patch 2,
and treat the entire set as a proper -stable backport candidate.

I'd appreciate your thoughts on this suggestion.

Rakie

