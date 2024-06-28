Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D946BA0
	for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554982; cv=none; b=oBkvpnlNDNesRwxWILCHX+I6Knb2Dwjx6u2nfWuimbN8bGaYqJOF50BC0EEvMR5RnBIpHOJ/agkYv3/t4MXY0KmKI63rPC3RbUFUQPvU2zAncE/fiYV+OvHqsC535VUNfgn2koDx6GwD7GVjzs04pmZ2SFwW62Z4XBwYzB3buP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554982; c=relaxed/simple;
	bh=/26V61FWgelBVsu8iplBNptP9TdL5u4EOQQo/JIVmjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/DMj9GuzX7qT55DlwrFCIQnZ7ybxeey54kGSJN/RLOIJunfJKLf/AK+SefQHDBEsLeJkOCg0cYB+ldZjBDE+UTbCwWDjGdQvQIloJIZKC/zdg8fvz0bovyEKTMqriF9v7fwiHFnsV7ygssdgP1fp0C0sBvfGtHbFiagjryTXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olAC4XjD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olAC4XjD"
X-Envelope-To: jonathan.cameron@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719554978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gy0NOjp3fgzujNjn03YIvDzl9Fqj+1fNboTj9KDJII=;
	b=olAC4XjDPP/fIYuqIYhACcF5/4Q/28Tl5xNDSEpQwyykCTBPOuIffDA6Vg7OoyDUv/ACQE
	t2gRmiHkZ3W6SiC5zFK41pzhkDaP67L2UU8+WDsLIugF6N50jPTwOkvMeketPUCelsYeYv
	+ej74ibV2rxmx1qy02CHp5rhyLw7Ap4=
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: horen.chuang@linux.dev
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	"SeongJae Park" <sj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] memory tier: consolidate the initialization of memory tiers
Date: Fri, 28 Jun 2024 06:09:22 +0000
Message-Id: <20240628060925.303309-1-horen.chuang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The current memory tier initialization process is distributed across
two different functions, memory_tier_init() and memory_tier_late_init().
This design is hard to maintain. Thus, this patch is proposed to reduce
the possible code paths by consolidating different
initialization patches into one.

The earlier discussion with Jonathan and Ying is listed here:
https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/

If we want to put these two initializations together, they must be
placed together in the later function. Because only at that time,
the HMAT information will be ready, adist between nodes can be
calculated, and memory tiering can be established based on the adist.
So we position the initialization at memory_tier_init() to the
memory_tier_late_init() call.

Moreover, it's natural to keep memory_tier initialization in drivers at
device_initcall() level.

- v2:
 Thanks to Huang, Ying's and Andrew's comments
 * Add cover letter
 * Add Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 * Add get/put_online_mems() protection in memory_tier_late_init()
 * If memtype is set, skip initializing its node
 * Remove redundant code/comments or rewrite code in a cleaner manner
- v1:
 * https://lore.kernel.org/all/20240621044833.3953055-1-horen.chuang@linux.dev/

This patchset is based on commits cf93be18fa1b and a72a30af550c:
[0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
[1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
[1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com

Ho-Ren (Jack) Chuang (1):
  memory tier: consolidate the initialization of memory tiers

 drivers/acpi/numa/hmat.c     |  5 +--
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            | 59 +++++++++++++++---------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

-- 
Ho-Ren (Jack) Chuang

