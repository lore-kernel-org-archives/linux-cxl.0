Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992561E3DCD;
	Thu, 10 Apr 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271615; cv=none; b=VMJB+HHjsQbtMHRW/7OH6DT8pqE73Nhem9qXGEGOViv9ygQr0n8UaThc+jnT2qwhd4Q/56xtATKCyE3r5vMtasDDFmnauUisZoDVF8TKnpPsNhUqMHwAheRMPlULhrceHkU9ng4WZDPZ8IZXxDMRyJVzOT+P5MSlX1Ze9zrLjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271615; c=relaxed/simple;
	bh=8xnLrcT6213lqqhInapJaZgknv/4Z4ygoKNwu+iRiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOt9ekSBz/GDKCQ6zgUsqtxNOczUx7XWdU+dRiNzLYi/ZdwkHpyszolyR1SmvJuNMQEQY9vxAgFfHwlJOReYkTSPoUEBiUtg0+uvTwgIrcsAk/rTFrMdpukTUsgBhh4gKO52MsuRgJ9IMkQAx/3Uk7Kjt+jHz2OfAPcBNacQVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ca-67f778f0a0f1
From: Rakie Kim <rakie.kim@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: kernel_team@skhynix.com,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	yunjeong.mun@sk.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu, 10 Apr 2025 16:53:08 +0900
Message-ID: <20250410075316.538-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe7Hiu/pBq9vsVnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ms5OXsVSsF2lYvqdLewNjBNkuxg5OSQETCReP+hlgrEfb1rC3sXIwcEmoCRxbG8M
	SFhEQENiU9sG5i5GLg5mgTZmiZvTljODJIQFwiX+/LjJCmKzCKhKHPz+lw3E5hUwlvj5r58V
	YqamRMOle0wgMzkF7CS6fliBhIUEeCRebdjPCFEuKHFy5hMWEJtZQF6ieetssF0SAr/ZJN5d
	eQd1m6TEwRU3WCYw8s9C0jMLSc8CRqZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIHhv6z2T/QO
	xk8Xgg8xCnAwKvHwemR8SxdiTSwrrsw9xCjBwawkwutp+D1diDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2NLfd23x66v7npkxUuuSJx2tXnppgl6Fqpb
	RAWT8j8cfJ198py2wqosV9OellPmSx11WwziuCOKKgVupXyO3Pz00IlPZ8pzXsUtnl5va+d7
	3eTRp74X3vdL75w0Cdue4PolZd/Frm/dzo3Pz8a6bdr2x3J34b2l01Nvzqjfau0uGjt9TTxv
	1yUlluKMREMt5qLiRADfQmYDewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS/dDxfd0gxMHTCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLOTl7FUrBdpWL6nS3sDYwT
	ZLsYOTkkBEwkHm9awt7FyMHBJqAkcWxvDEhYREBDYlPbBuYuRi4OZoE2Zomb05YzgySEBcIl
	/vy4yQpiswioShz8/pcNxOYVMJb4+a+fFWKmpkTDpXtMIDM5Bewkun5YgYSFBHgkXm3YzwhR
	LihxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJ
	ERjyy2r/TNzB+OWy+yFGAQ5GJR5ej4xv6UKsiWXFlbmHGCU4mJVEeD0Nv6cL8aYkVlalFuXH
	F5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MOYv01DhuSh1J1rq8qIJ6bvr
	7B7WXNnUsmjxGf+t0yZ8leD/JCZd1HRiscCd61/VBC9cm58lYKOnv3V7rZFJ8+PcsKdb0nMW
	8/ulrbq5fMcSuTTW65dcAot6zDcetikwXq885ejjCNlZGyc2Lp02PY6jzaVy66I5v1fMeb/w
	WefjVZMjptwubNFRYinOSDTUYi4qTgQABkQtl3UCAAA=
X-CFilter-Loop: Reflected

On Wed, 9 Apr 2025 13:52:28 +0200 David Hildenbrand <david@redhat.com> wrote:
> On 09.04.25 13:39, Honggyu Kim wrote:
> > Hi David,
> > 
> > On 4/9/2025 6:05 PM, David Hildenbrand wrote:
> >> On 08.04.25 09:32, Rakie Kim wrote:
> >>> The weighted interleave policy distributes page allocations across multiple
> >>> NUMA nodes based on their performance weight, thereby improving memory
> >>> bandwidth utilization. The weight values for each node are configured
> >>> through sysfs.
> >>>
> >>> Previously, sysfs entries for configuring weighted interleave were created
> >>> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> >>> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> >>> runtime, as some may remain memoryless or offline.
> >>> This led to sysfs entries being created for unusable nodes, causing
> >>> potential misconfiguration issues.
> >>>
> >>> To address this issue, this patch modifies the sysfs creation logic to:
> >>> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
> >>>      the creation of sysfs entries for nodes that cannot be used.
> >>> 2) Support memory hotplug by dynamically adding and removing sysfs entries
> >>>      based on whether a node transitions into or out of the N_MEMORY state.
> >>>
> >>> Additionally, the patch ensures that sysfs attributes are properly managed
> >>> when nodes go offline, preventing stale or redundant entries from persisting
> >>> in the system.
> >>>
> >>> By making these changes, the weighted interleave policy now manages its
> >>> sysfs entries more efficiently, ensuring that only relevant nodes are
> >>> considered for interleaving, and dynamically adapting to memory hotplug
> >>> events.
> >>>
> >>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> >>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> >>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> >>
> >>
> >> Why are the other SOF in there? Are there Co-developed-by missing?
> > 
> > I initially found the problem and fixed it with my internal implementation but
> > Rakie also had his idea so he started working on it.  His initial implementation
> > has almost been similar to mine.
> > 
> > I thought Signed-off-by is a way to express the patch series contains our
> > contribution, but if you think it's unusual, then I can add this.
> 
> Please see Documentation/process/submitting-patches.rst, and note that these
> are not "patch delivery" SOB.
> 
> "
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.
> "
> 
> and
> 
> "
> Co-developed-by: states that the patch was co-created by multiple developers;
> it is used to give attribution to co-authors (in addition to the author
> attributed by the From: tag) when several people work on a single patch.  Since
> Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
> followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
> chronological history of the patch insofar as possible, regardless of whether
> the author is attributed via From: or Co-developed-by:.  Notably, the last
> Signed-off-by: must always be that of the developer submitting the patch.
> "
> 
> The SOB order here is also not correct.
> 
> > 
> >     Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
> >     Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > 
> > For Yunjeong, the following can be added.
> > 
> >     Tested-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> That is probably the right thing to do if contribution was focused on testing.
> 
> > 
> > However, this patch series is already in Andrew's mm-new so I don't want to
> > bother him again unless we need to update this patches for other reasons.
> 
> mm-new is exactly for these kind of things. We can ask Andrew to fix it up.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

Hi David,

Thank you for reviewing this patch series and providing your Acked-by tag.
As you pointed out, I agree that the Signed-off-by tags in this patch
series are not clearly aligned with the actual contributions.

Coincidentally, Dan Williams has requested an additional fix for Patch 1
in this series. Therefore, I am planning to prepare a new version, v8.

In that version, I will reorganize the Signed-off-by tags as you suggested
to accurately reflect the authorship and contributions.

Thank you again for your guidance.

Rakie

