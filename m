Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B080A136E37;
	Mon, 24 Mar 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806115; cv=none; b=SxpZS5ennKrsgCwjm2xGo6I+ALuE5xvSnV91jAeclPssauu8k4yugqgJ0hmv0guYKSVSsPtkYJim4ea1kBJY8I8FOi4Vof+f17TWyJnSKn0oPqdnbAkATr2Xm6Kjsl2pSndCoXWt0kZmTgHgBA86TawhVxx45+mGnMZCYdC1lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806115; c=relaxed/simple;
	bh=wkcrYRaEYcsN4FhJWihvW9cIGCTYtG5ubFrbcw3oRWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2SJ8YkYEqXJ/fifXEehDcWPApu1RG7qhDLDr1RBNZ3K3+9k3K1J3hQ+fXcUfDeHPoqqI7MXo9obau6zwEFqTAuFeIVngE3njIK4gyhO6CqVXUXwK67rc2LAQPhBLZoKU7Kf/G2dWV2IWImBVVYMkG0QMbnf83Gd729wRg5EYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-cf-67e11c5ac948
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
Subject: Re: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for weighted interleave
Date: Mon, 24 Mar 2025 17:48:15 +0900
Message-ID: <20250324084822.976-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z91zCELAdts-l3Zp@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnkW6UzMN0gzU32CzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlfF4
	xiu2giM8FS0bmxgbGH9xdjFyckgImEisWraeuYuRA8xuOF8OYrIJKEkc2xsDYooIqEq0XXHv
	YuTiYBZ4xCRxun0pK0insEC8xJsr1xlBaliAapr2pICEeQWMJV6tO8YIMVxTouHSPSYQm1PA
	TOL56iawViEBHolXG/YzQtQLSpyc+YQFxGYWkJdo3jqbGaL3OZvEvK5yCFtS4uCKGywTGPln
	IWmZhaRlASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAQF9W+yd6B+OnC8GHGAU4GJV4eDe8
	vJ8uxJpYVlyZe4hRgoNZSYT3GOvDdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNL
	UrNTUwtSi2CyTBycUg2MEh/k+Zf8d7i7M+vUQuPGdb+a/36pjjz+V3mKN/Prl1kCHVohc/mz
	PLyTDK7u2bLrF7vgx5ipksapv0JX6009+cwt88On47ce7apaf+Xk2cNZ6TfMdve6zzbQYSru
	nPVV9/OF7s23r16/oCAydd981d9XhbbYt3+rCeDJkA/KkrpkZmGebW/cqcRSnJFoqMVcVJwI
	AJVHpOBwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNSzdS5mG6QcNsG4s569ewWUyfeoHR
	4uv6X8wWP+8eZ7f4/Ow1s8WqhdfYLI5vncducXjuSVaL87NOsVhc3jWHzeLemv+sFoeuPWe1
	WL0mw+L3thVsDnweO2fdZffobrvM7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubx
	7baHx+IXH5g8Pm+SC+CO4rJJSc3JLEst0rdL4Mp4POMVW8ERnoqWjU2MDYy/OLsYOTgkBEwk
	Gs6Xg5hsAkoSx/bGgJgiAqoSbVfcuxi5OJgFHjFJnG5fytrFyMkhLBAv8ebKdUaQGhagmqY9
	KSBhXgFjiVfrjjGC2BICmhINl+4xgdicAmYSz1c3gbUKCfBIvNqwnxGiXlDi5MwnLCA2s4C8
	RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzC8l9X+mbiD8ctl
	90OMAhyMSjy8G17eTxdiTSwrrsw9xCjBwawkwnuM9WG6EG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2P33lOcxb8trv9bXZwmXGR/2vTX0sWGZ758vmBS
	o29v5rngndNfU0FB7SxlthVT5ufeC2j3ZVdPb5WxOFEoVr7ooLyzdwHzTsY/rj8stZR/uV87
	vyDMWLajaPub1tPHGtymNPqoF0U827JdP8RWYY/fU+788M7jCx91u1nb/TlpzCLRJG0WqMRS
	nJFoqMVcVJwIAF5tHjlrAgAA
X-CFilter-Loop: Reflected

On Fri, 21 Mar 2025 10:09:12 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Thu, Mar 20, 2025 at 01:17:47PM +0900, Rakie Kim wrote:
> > Previously, the weighted interleave sysfs structure was statically
> > managed, preventing dynamic updates when nodes were added or removed.
> > 
> > This patch restructures the weighted interleave sysfs to support
> > dynamic insertion and deletion. The sysfs that was part of
> > the 'weighted_interleave_group' is now globally accessible,
> > allowing external access to that sysfs.
> > 
> > With this change, sysfs management for weighted interleave is
> > more flexible, supporting hotplug events and runtime updates
> > more effectively.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> 1 nit
> 
> > ---
> >  mm/mempolicy.c | 70 ++++++++++++++++++++++----------------------------
> >  1 file changed, 30 insertions(+), 40 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 5950d5d5b85e..6c8843114afd 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3388,6 +3388,13 @@ struct iw_node_attr {
> >  	int nid;
> >  };
> >  
> > +struct sysfs_wi_group {
> > +	struct kobject wi_kobj;
> > +	struct iw_node_attr *nattrs[];
> > +};
> > +
> > +static struct sysfs_wi_group *sgrp;
> > +
> 
> sgrp -> wi_group?  Or something similar, sgrp is not very descriptive
> for a global.
> 
> ~Gregory

Yes, I agree. `wi_group` is more descriptive than `sgrp`. I will rename the
structure to `wi_group` as suggested.

Rakie

