Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACB29A1;
	Wed,  2 Apr 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558607; cv=none; b=Zx05lJAK9CPDksLdmEMFFn8jVXxdz5XGnbE1sajw1V0iENi7p7GkKLqgtPBgPcQkmeBX+r4GmqSUZ0e1ir8uudF2tbgjavZDYGPa/FhabjMOuf7byb+qzRWADJJppYi2B76KirPFQwyb9wtfm9UH7zNhVx/2FPI5nA2WzGjmMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558607; c=relaxed/simple;
	bh=h8eMNrKVbSlSbUPhA0LACZPHV730lSrXa0PUIipN8d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0V9rvLpDtB8kKR2tSwHNn5VfggYDRwmCr5/5NBw+9OYlraLxCY694t9iLNGYE0zenAI+mcYXd50kBXp+LHXaLAHiMfk7X2SF3SPNf8G2uPwz3sYxgNP/QEuM7It3ITilm7cXW86zsqMKJihOwfP00ksY7g50WHFYM45YgU7DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c2-67ec97c66fd7
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
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
	rakie.kim@sk.com
Subject: [PATCH v5 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Wed,  2 Apr 2025 10:49:01 +0900
Message-ID: <20250402014906.1086-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnke6x6W/SDY4+sLGYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8b6
	W7+YC6YIV7xv3cfawPiEv4uRk0NCwETiz9+1zDB2y4spQDYHB5uAksSxvTEgYREBUYl5R2ez
	dDFycTALXGOSOPD5JgtIQlggQuLGwsfsIDaLgKrEu8u/wObwAs05ePkvI8RMTYmGS/eYIOKC
	EidnPgHrZRaQl2jeOhtq72U2iQV/oyFsSYmDK26wTGDknYWkZRaSlgWMTKsYhTLzynITM3NM
	9DIq8zIr9JLzczcxAsN3We2f6B2Mny4EH2IU4GBU4uFt4H2TLsSaWFZcmXuIUYKDWUmEN+Lr
	y3Qh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjOwtSy/O
	6vve3eG+7trsttkpIe/nF137Llt/42aD7qnWZxz6B7x3rls24+Erlnse8rsLfxfv7+/ZHP05
	U5j3QHfhpUNvJa9sSuCLVylkMVgsdepy3qKLVXeexy4MNvy3taxj0adDCkKL81P+v7sY/WrX
	hhDl584z1ufdahG49PW+t3afAV92wSIlluKMREMt5qLiRAAzo/kqWwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXCNUNNS/fY9DfpBidmGVvMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAlfG+lu/mAumCFe8b93H2sD4hL+LkZNDQsBE
	ouXFFOYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpCEsECExI2Fj9lBbBYB
	VYl3l38xg9i8QHMOXv7LCDFTU6Lh0j0miLigxMmZT8B6mQXkJZq3zmaewMg1C0lqFpLUAkam
	VYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBu6z2z8QdjF8uux9iFOBgVOLhFeh5ky7EmlhW
	XJl7iFGCg1lJhDfi68t0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalF
	MFkmDk6pBsa1Ss94WeZrZGjv+Z7UO1+yZcKN5Rs23v8qVWf/ZefPkvASzuxpi11LLixa+EWu
	bX++0qLNzJOUnrvXVe6a3mHXsU3JuqywVOmIY0fG1P9SLzju8l7hXxrmovR+zY4HhieKmFfH
	z4m2C789baPpogUTZ4f+ydgX8fzHyxmO+xy2yh3yPcm5QadRiaU4I9FQi7moOBEAVTEIx1YC
	AAA=
X-CFilter-Loop: Reflected

The following patch series enhances the weighted interleave policy in the
memory management subsystem by improving sysfs handling, fixing memory leaks,
and introducing dynamic sysfs updates for memory hotplug support.

### Background
The weighted interleave policy distributes memory allocations across multiple
NUMA nodes based on their performance weight, thereby optimizing memory
bandwidth utilization. The weight values are configured through sysfs.

Previously, sysfs entries for weighted interleave were managed statically
at initialization. This led to several issues:
- Memory Leaks: Improper `kobject` deallocation caused memory leaks
  when initialization failed or when nodes were removed.
- Lack of Dynamic Updates: Sysfs attributes were created only during
  initialization, preventing nodes added at runtime from being recognized.
- Handling of Unusable Nodes: Sysfs entries were generated for all
  possible nodes (`N_POSSIBLE`), including memoryless or unavailable nodes,
  leading to sysfs entries for unusable nodes and potential
  misconfigurations.

### Patch Overview
1. [PATCH 1/3] Fix memory leaks in weighted interleave sysfs
   - Ensures proper cleanup of `kobject` allocations.
   - Replaces unnecessary `kfree()` calls with `kobject_put()`, preventing
     memory leaks and improving system stability.

2. [PATCH 2/3] Enable dynamic updates for weighted interleave sysfs
   - Restructures sysfs handling to allow runtime updates.
   - The sysfs attributes are now globally accessible, enabling external
     modules to manage interleave settings dynamically.

3. [PATCH 3/3] Support memory hotplug in weighted interleave
   - Modifies sysfs creation logic to restrict entries to nodes that are
     online and have memory, excluding unusable nodes.
   - Introduces a memory hotplug mechanism to dynamically add and remove
     sysfs attributes when nodes transition into or out of the `N_MEMORY` set.
   - Ensures that sysfs attributes are properly removed when nodes go offline,
     preventing stale or redundant entries from persisting.

These patches have been tested under CXL-based memory configurations,
including hotplug scenarios, to ensure proper behavior and stability.

 mm/mempolicy.c | 192 +++++++++++++++++++++++++++++++------------------
 1 file changed, 124 insertions(+), 68 deletions(-)


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.34.1

