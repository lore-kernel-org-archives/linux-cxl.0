Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655AA926;
	Thu, 20 Mar 2025 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444308; cv=none; b=LZo0iZwKbNPj6hQVvgRrAvw1VGJsWiRzQN26eS/apn+kmdrzY2tCYPc/KA3P3g51Z3tOTaJ0Tp811K0Cdpz/klOpLgXQlFdeMcjR5MJwiUnbaTHEbpDxFRGkHA5Z35Nyss5L+Gq+09gw19SeICpRJbCl4VQUSDo+2ZEOfWCsYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444308; c=relaxed/simple;
	bh=FPbR/DP+L1yR3sywDhC/tWZmkgjAgkz5vfDZao5Rrr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2P+PH+utFc2EQKqoYXAWB9/Erb+mXHJDx0bobdXu5/vo/1edjNMvLjQ53azYqxZs7VQAGw+k0yOzuwx6KXyYDBWA4Lvl+iMoFE6ZTBvB5PUC9Dfh9QyEi8qjzhe067DtwEadvHeCyWD3oEuTDSSO3RU5clKM8hXBY2tLQnL48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-39-67db9705e331
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
Subject: [PATCH v3 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Thu, 20 Mar 2025 13:17:45 +0900
Message-ID: <20250320041749.881-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC9ZZnoS7r9NvpBg+mKFnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2PZ
	jCbmgk7hisNbJ7A1MN7j72Lk5JAQMJE4830TG4y9/tJnpi5GDg42ASWJY3tjQMIiAqIS847O
	Zuli5OJgFrjGJHHg800WkISwQITEz7+XwHpZBFQlDj/vBLN5BYwlPi+6xAwxU1Oi4dI9Joi4
	oMTJmU/AepkF5CWat85mBhkqIXCZTeJZZzM7RIOkxMEVN1gmMPLOQtIzC0nPAkamVYxCmXll
	uYmZOSZ6GZV5mRV6yfm5mxiBAbys9k/0DsZPF4IPMQpwMCrx8L64citdiDWxrLgy9xCjBAez
	kgivSMftdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2M
	7YsdUtpm+Vl8Md133VM+W9c9ZPMjH/brwcKHWDYsU3LIbjm57EqEW9NfqVczm0td0rkfr6iZ
	1/tQboJcxq/NPFPs5P5d3LDA921hgselZexLUhZYnHqfOHuJgA+fiWJVvditOL/Efdzz/9Zu
	uFZ3gz39lMrkjlMPM83mO6iXFBg53r+uIb5EiaU4I9FQi7moOBEAzlTsYlwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXCNUNNS5d1+u10g+WbhCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj2Ywm5oJO4YrDWyewNTDe4+9i5OSQEDCR
	WH/pM1MXIwcHm4CSxLG9MSBhEQFRiXlHZ7N0MXJxMAtcY5I48PkmC0hCWCBC4uffS2wgNouA
	qsTh551gNq+AscTnRZeYIWZqSjRcuscEEReUODnzCVgvs4C8RPPW2cwTGLlmIUnNQpJawMi0
	ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzBol9X+mbiD8ctl90OMAhyMSjy8L67cShdiTSwr
	rsw9xCjBwawkwivScTtdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoR
	TJaJg1OqgfEhh98qxtCjVhPWekTeCjgQP1Ftd8019U13OLnOZD/9UX9Kp7hohnNfg4DF0vNf
	XdatXnwh5frEtKf2KSVlWyNMKu3y1+qXzJ9uInjC49qqRyvM1vJM1n6kJvCiRHaKtNfHvJ4V
	hetF9G9q7t0R1dt8PcGtb0mc+bx3Gut/3QmNPj4/cuUj5wdKLMUZiYZazEXFiQDQhcXKVgIA
	AA==
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
  leading to unnecessary sysfs attributes and misconfiguration issues.

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

 mm/mempolicy.c | 191 +++++++++++++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 68 deletions(-)


base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
-- 
2.34.1

