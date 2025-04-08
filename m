Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278321767D;
	Tue,  8 Apr 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097639; cv=none; b=X3kn3LOw1eD8tARVV3b6RVYMswYtUw1oFQwdzZNNdKpBQpE9H1SU9JBrLAE+swZdKN2qEsh9gOk+8fAQtrBSnHFD09kXweNLIEHpLSTkcmxERNcMWTLJJZIY35s/Q/TF4z8Ef43IK1NpA91QQ65zD4GB17VWpNAXRZL/yl5KUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097639; c=relaxed/simple;
	bh=gzZTqg8Iy4Z9Xg/wjZQwPqD67nnEhaC2eeaJMbw96v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8uQ+rLt/m4af2t7qAUNWFY1cXgwu7pGr6ONpmOwbkg6xn+miVIWZ84/Mhv+Bb7q6BQ+IgIp5m3xMqvZa9uMb+E1Hh5LBshk77YFeXWqSS7Bunchs4B17lpVldCjDFL+ijnYn0ib19tiuJY7lIH4Vf/VKDWMhMKX0YKf18TeNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f0-67f4d15cb46e
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v7 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Tue,  8 Apr 2025 16:32:39 +0900
Message-ID: <20250408073243.488-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC9ZZnkW7MxS/pBt/nmlvMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mk7/nMVasFaoYtmahSwNjEv4uxg5OSQETCT+bF7DCmPfOLWbpYuRg4NNQEni2N4Y
	kLCIgKzE1L/ngcJcHMwCj5kkHj1/wQiSEBaIkFh+YQdYL4uAqkTHrPvsIDavgLHEq2t3GCFm
	ako0XLrHBBEXlDg58wkLiM0sIC/RvHU2M8hQCYH7bBJPZ35kg2iQlDi44gbLBEbeWUh6ZiHp
	WcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMKCX1f6J3sH46ULwIUYBDkYlHl6Po5/ThVgT
	y4orcw8xSnAwK4nwvp34JV2INyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC
	1CKYLBMHp1QDo5JgS+CxrDeaJU1zUt5MOmtz+e2u+2EFG6REktST7r3XYDBU+Gy34WjtS9GO
	msm8DW+Y+uvdzfgtOmdNSr/4Ji7SXCey7M7Eb3N7RUofMESpsHhYyU666FX98LxAoFUOm1tX
	a/XmpPgZ32QFato4n7WsqYu9GjY32rnSbmeiK9/GhbtLWRYqsRRnJBpqMRcVJwIAdMaYwmQC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXCNUNNSzfm4pd0g43PNS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDJO/5zFWrBWqGLZmoUsDYxL
	+LsYOTkkBEwkbpzazdLFyMHBJqAkcWxvDEhYREBWYurf80BhLg5mgcdMEo+ev2AESQgLREgs
	v7CDFcRmEVCV6Jh1nx3E5hUwlnh17Q4jxExNiYZL95gg4oISJ2c+YQGxmQXkJZq3zmaewMg1
	C0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBvKz2z8QdjF8uux9iFOBgVOLh
	9Tj6OV2INbGsuDL3EKMEB7OSCO/biV/ShXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmk
	J5akZqemFqQWwWSZODilGhjPL5y/5dKRbRLJ35pMkjQPb9Rd4Z1/cuZ/Fwcm06cPSwr8ZRd8
	eCLMsuzFZrXcOV1THqwuOsKjObnzySa2E2yrsneu7s1evIrfTnpdzFXr/IrrjzUnvQ38+dN3
	64qFNh4NXY37NkTI3O/sncsa6r7zjQbnvEOTWp/cS9oks2JmUItwe/iSnapLlFiKMxINtZiL
	ihMB9C1t6V4CAAA=
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
- Memory Leaks: Improper `kobject` teardown caused memory leaks
  when initialization failed or when nodes were removed.
- Lack of Dynamic Updates: Sysfs attributes were created only during
  initialization, preventing nodes added at runtime from being recognized.
- Handling of Unusable Nodes: Sysfs entries were generated for all
  possible nodes (`N_POSSIBLE`), including memoryless or unavailable nodes,
  leading to sysfs entries for unusable nodes and potential
  misconfigurations.

### Patch Overview
1. [PATCH 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
   - Ensures proper cleanup of `kobject` allocations.
   - Adds `kobject_del()` before `kobject_put()` to clean up sysfs state correctly.
   - Prevents memory/resource leaks and improves teardown behavior.

2. [PATCH 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
   - Refactors static sysfs layout into a new `sysfs_wi_group` structure.
   - Makes per-node sysfs attributes accessible to external modules.
   - Lays groundwork for future hotplug support by enabling runtime modification.

3. [PATCH 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
   - Dynamically adds/removes sysfs entries when nodes are online/offline.
   - Limits sysfs creation to nodes with memory, avoiding unusable node entries.
   - Hooks into memory hotplug notifier for runtime updates.

These patches have been tested under CXL-based memory configurations,
including hotplug scenarios, to ensure proper behavior and stability.

 mm/mempolicy.c | 193 +++++++++++++++++++++++++++++++------------------
 1 file changed, 124 insertions(+), 69 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.34.1

