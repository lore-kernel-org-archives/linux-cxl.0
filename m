Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD410F2;
	Fri,  9 May 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757852; cv=none; b=SRiNFcE17WNVVnGf1QZ5CZyuYVY5usxwoFCebytOd4HGgNtcPPiVYiwORRaCvVujmko6Z3DdAsLE7nb4tVM6V6Jd9p9MEpv555O6QM6BTL5V/9Z9mERHgNijekhgJEE5lwhZkdwXr+yauQGiTGuJbq07+BIFDRq1Ki/gJ3sTujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757852; c=relaxed/simple;
	bh=zKd2SAmnATdR5EJa6eAx0Puk/ovNe0wg7AUh9t606c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOE4RgLBFP/m9Oa0lxbYSwCWF2T3/bhak8jujN7Vn1AF8Cw+4qFjNVo4t+iMELNtzq/nO5DmMpPKOh464iwowMukb8wQyjKfJkBe4BC3K5DcdTrIv0G53vXVKNY3iYz4G830Oe6N0hbyxmNvVhBzRRmYXR47D0J+gTuxZ3xo6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-30-681d68cd3122
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: joshua.hahnjy@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Fri,  9 May 2025 11:30:26 +0900
Message-ID: <20250509023032.235-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <aBzJ42b8zIThYo1X@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnoe7ZDNkMg1l/lCzmrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mmbv+M5UME2+4tux2cwNjF2SXYycHBIC
	JhJzO3axw9j7X35g7GLk4GATUJI4tjcGxBQRUJVou+LexcjFwSywnkniwMWtYOXCAgkSp+Zd
	YgaxWYBqVjQcBovzChhLHO3cxAIxUlOi4dI9JhCbU8BMYuWEFWBxIQEeiVcb9jNC1AtKnJz5
	BCzOLCAv0bx1NjPIMgmBE2wS0561MEMMkpQ4uOIGywRG/llIemYh6VnAyLSKUSgzryw3MTPH
	RC+jMi+zQi85P3cTIzCMl9X+id7B+OlC8CFGAQ5GJR5eDxHZDCHWxLLiytxDjBIczEoivM87
	ZTKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MBpwsPTa
	chQv2vhT5DpDlbWJ4YmX7efLa14wcM/96HOj29Yz5sClb6e2Sm5qfzndfqOR3lqNq4VOJT+/
	uEe+ZrfavLL/kGfW08Jzt1dOa1GPi3xnsT/1hdUPGfNCxomH2cvvnxNwe/h432HB8wUVTxmf
	3+zjtl3a80d+t/wlXR7F08Jnu7qiZiuxFGckGmoxFxUnAgB5phVhXwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS/dshmyGQf9rEYs569ewWUyfeoHR
	4ufd4+wWn5+9ZrY4vnUeu8XhuSdZLc7POsVicXnXHDaLe2v+s1ocuvac1WL1mgyL39tWsDnw
	eOycdZfdo7vtMrvH4j0vmTw2fZrE7nFixm8Wj50PLT2+3fbwWPziA5PH501yAZxRXDYpqTmZ
	ZalF+nYJXBmzd3xnKpgmX/Ht2GzmBsYuyS5GTg4JAROJ/S8/MHYxcnCwCShJHNsbA2KKCKhK
	tF1x72Lk4mAWWM8kceDiVnaQcmGBBIlT8y4xg9gsQDUrGg6DxXkFjCWOdm5igRipKdFw6R4T
	iM0pYCaxcsIKsLiQAI/Eqw37GSHqBSVOznwCFmcWkJdo3jqbeQIjzywkqVlIUgsYmVYximTm
	leUmZuaY6hVnZ1TmZVboJefnbmIEhu6y2j8TdzB+uex+iFGAg1GJh9dDRDZDiDWxrLgy9xCj
	BAezkgjv806ZDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5O
	qQZGr1sPHz2esef4Gy2nK7tWSK768kj0XV7907UeXpzn8vQa1wtsK9P+utoj6ktq1rKFtwqa
	9AM/seVLXrz3L1O9XJ7jjIil17VY8WbT7JgXLVt95EXu32Fx6LFZznN2l+GqHpnGJZq/LTvl
	NNoSTJp2zNkzeda3VZMnJ6zVvefzg+PPLK/Xr9VslFiKMxINtZiLihMBznRWoVkCAAA=
X-CFilter-Loop: Reflected

On Thu, 8 May 2025 11:12:35 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Thu, May 08, 2025 at 03:30:36PM +0900, Rakie Kim wrote:
> > On Wed, 7 May 2025 12:38:18 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > The proposed design is completely optional and isolated: it retains the
> > existing flat weight model as-is and activates the source-aware behavior only
> > when 'multi' mode is enabled. The complexity is scoped entirely to users who
> > opt into this mode.
> > 
> 
> I get what you're going for, just expressing my experience around this
> issue specifically.

Thank you very much for your response. Your prior experience and insights
have been extremely helpful in refining how I think about this problem.

> 
> The lack of enthusiasm for solving the cross-socket case, and thus
> reduction from a 2D array to a 1D array, was because reasoning about
> interleave w/ cross-socket interconnects is not really feasible with
> the NUMA abstraction.  Cross-socket interconnects are "Invisible" but
> have real performance implications.  Unless we have a way to:
> 
> 1) Represent the topology, AND
> 2) A way to get performance about that topology
> 
> It's not useful. So NUMA is an incomplete (if not wrong) tool for this.

Your comment gave me an opportunity to reconsider the purpose of the
feature I originally proposed. In fact, I had two different scenarios
in mind when outlining this direction.

Scenario 1: Adapt weighting based on the task's execution node
A task prefers only the DRAM and locally attached CXL memory of the
socket on which it is running, in order to avoid cross-socket access and
optimize bandwidth.
- A task running on CPU0 (node0) would prefer DRAM0 (w=3) and CXL0 (w=1)
- A task running on CPU1 (node1) would prefer DRAM1 (w=3) and CXL1 (w=1)

Scenario 2: Reflect relative memory access performance
The system adjusts weights based on expected bandwidth differences for
remote accesses. This relies on having access to interconnect performance
data, which NUMA currently does not expose.

As you rightly pointed out, Scenario 2 depends on being able to measure
or model the cost of cross-socket access, which is not available in the
current abstraction. I now realize that this case is less actionable and
needs further research before being pursued.

However, Scenario 1 does not depend on such information. Rather, it is
a locality-preserving optimization where we isolate memory access to
each socket's DRAM and CXL nodes. I believe this use case is implementable
today and worth considering independently from interconnect performance
awareness.

> 
> Additionally - reacting to task migration is not a real issue.  If
> you're deploying an allocation strategy, you probably don't want your
> task migrating away from the place where you just spent a bunch of time
> allocating based on some existing strategy.  So the solution is: don't
> migrate, and if you do - don't use cross-socket interleave.

That's a fair point. I also agree that handling migration is not critical
at this stage, and I'm not actively focusing on that aspect in this
proposal.

> 
> Maybe if we solve the first half of this we can take a look at the task
> migration piece again, but I wouldn't try to solve for migration.
> 
> At the same time we were discussing this, we were also discussing how to
> do external task-mempolicy modifications - which seemed significantly
> more useful, but ultimately more complex and without sufficient
> interested parties / users.

I'd like to learn more about that thread. If you happen to have a pointer
to that discussion, it would be really helpful.

> 
> ~Gregory
> 

Thanks again for sharing your insights. I will follow up with a refined
proposal based on the localized socket-based routing model (Scenario 1)
and will give further consideration to the parts dependent on topology
performance measurement for now.

Rakie

