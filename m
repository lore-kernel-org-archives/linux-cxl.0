Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D61331A5C
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904746; cv=none; b=oN5X8BmKtXhPbad1nYNNHHhzJ2ibDfxq8sx7kf0ABpAzHPkjSv7GOpsN+Oll5ZXjwtMfEEN6pUyxutwhVmD3hjvWfP8lE4RPCxUn7tl6L+tsL4oKwJi9NGJ9vBCkqJ1OAPTotREpYKz69+D68w2C/jVBrg0b1SXopZf6TdF+xX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904746; c=relaxed/simple;
	bh=a5FayHYeLOjpSYndVEQNyEbTMfQR+C/FVM2n6KXYrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbSfOrlLNkLZW7xcC+0LxyuC+kQ5HnnQwPiwWnSlU64O0z66GRY5XhxwBM/c1e1vztTjKeK2w7i7gCSCL0bGR39HMgU8LijB9OSK+Oxvu4WlmhD793NKaBsgHkwBOM3RZAu/BUb7CTH9r3hsmMNyyz/gQ2J5mRXg3uVnTpebL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AAJhU+QG; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AAJhU+QG"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4ffa95fc5f1so34521361cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904739; x=1768509539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRDiJ+UlJzmE9gGlU0qCIeblmwRaclHqLNtsuAzr4HM=;
        b=AAJhU+QGRlNWe4lqt0GifqyTq3VXjRFKFEaeOF3zUUdmCGLDtQCJuVwfCae5+OLl9Q
         I8c21JA5zmeklBxwY1CTf8h9SPlgGcA7DIa/1Y8cUBk+YkExbsGDIwYq1FIqoE2LCAVV
         PTCdoIG+LfI6qYBqTdv75rwfU5I3MK356ni6uKREs/ATTAsohSfn4u2fDHtYZN3yG1hH
         dlirk7CFoMIDjOM5p/k/cyVdebpjRH2FOPptO/jZcCFwCGnn4096ONOS8sVQU6hTliW+
         2IVQgg8fRoB5tUccO86rOR2auxmqOu5AXjasjRAs4VUKxl9ZTI3iDxoY7VVPIjYc++6n
         jCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904739; x=1768509539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rRDiJ+UlJzmE9gGlU0qCIeblmwRaclHqLNtsuAzr4HM=;
        b=pZeusUk5VLTMPu3U4M+jOF1OZo4OT2T7PwG1jCEEoKMovN0qwrp0OQc7ETbJfMlO+x
         1Og6tJZa7GeT4MD4UYAZkmPyjktGeCSrS1jKP5DBGITKdjHO35Z/UqnrcDKcVM0uM1a3
         8UZglP6O5dyGlgtCa1Y8Hi5VIsnZVmQgD3hF83o2lcqL1JQN/Fmeku+IX9qL1il8zXqC
         1aSF3RGieVylZ7xKsJk6xc65pCgwih8WD0pN5hrSJT0pw3+qsmu9r6L+e8RZkgZ4yLq0
         n5RnP0hb3P1gsLCnOe5I2xUllul6cpqjddtpi/HTo8oo05pa20XvdwJfoVtFfD1SMvGf
         d1uA==
X-Forwarded-Encrypted: i=1; AJvYcCXOrLZry00JZyXt8dG070AWasOEBgJSFcWj9CqJokwRRvJg8pPGQECyVFbJQu4fBlk0guDYs7ZZRNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0WHzdJgF3tc3friiAIVRrfU+zAn4C51JvK+q8y1bcZt/jttG
	Q40a2DihJGl0DZPOOxH1pQNHr+IOQxmZVSk5RRDAW4WJQu3yXAwAbW/9K1RoZjh8QZQ=
X-Gm-Gg: AY/fxX4appV1c9a1Y7DKl5muGCkHJyUkatWcSmLPrJSKJhsfn0KwEqYqPzzYGNaz2iT
	v6Npi3NwwpyfqVtaijWUb0AzkaMbAc13P2DobyvWve9gEja8p8p74m9knjMOfpmL7FbXtvBIhFq
	URmWBPWYhheQX7EVkYA6VqXH0nqXFzgwxD/KnbOtdzm529cM+Bml9KHSGSkEXHx4glqT10IcPwY
	IXVM91K+vdtnT+Ug0+FhTMFSryU+OT+RBj4TA2NOHi/KSnf4bpB1WMMShzAsU/1eJlBNaLid5MZ
	KwAi7SJHr+devWjz/lZj5ZDfsa/UgovZVeh98lt/7oFwY+R2b7cot1xfOoiynCaMAn9Q9Rpthri
	3ROoCZYlf0DMwUG+TYhvfw2t/vy+UTS0MMhEucq9PHSN93oTKaAUTz7JQ8kQrb9r/3fqJGPTAHA
	CEKc6mjL6fuYJ4PS+hkiY0ySKjhv5ppD7EPuOkSOvYZIXMp2dmcFTvmFRHG7yCSEjwfkOTmHPgB
	is=
X-Google-Smtp-Source: AGHT+IFQyuUju0Z/aUbfqpVDbDingg5jj0Y3CKeme4WYcUfzCc6+dQALyvDYUzyj67d/yfod1gGU5A==
X-Received: by 2002:a05:622a:1101:b0:4ed:df09:a6a6 with SMTP id d75a77b69052e-4ffb48a8a54mr84063441cf.25.1767904738761;
        Thu, 08 Jan 2026 12:38:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:58 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 5/8] Documentation/admin-guide/cgroups: update docs for mems_allowed
Date: Thu,  8 Jan 2026 15:37:52 -0500
Message-ID: <20260108203755.1163107-6-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new information about mems_allowed and sysram_nodes, which says
mems_allowed may contain union(N_MEMORY, N_PRIVATE) nodes, while
sysram_nodes may only contain a subset of N_MEMORY nodes.

cpuset.mems.sysram is a new RO ABI which reports the list of
N_MEMORY nodes the cpuset is allowed to use, while
cpusets.mems and mems.effective may also contain N_PRIVATE.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../admin-guide/cgroup-v1/cpusets.rst         | 19 +++++++++++---
 Documentation/admin-guide/cgroup-v2.rst       | 26 +++++++++++++++++--
 Documentation/filesystems/proc.rst            |  2 +-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index c7909e5ac136..6d326056f7b4 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -158,21 +158,26 @@ new system calls are added for cpusets - all support for querying and
 modifying cpusets is via this cpuset file system.
 
 The /proc/<pid>/status file for each task has four added lines,
-displaying the task's cpus_allowed (on which CPUs it may be scheduled)
-and mems_allowed (on which Memory Nodes it may obtain memory),
-in the two formats seen in the following example::
+displaying the task's cpus_allowed (on which CPUs it may be scheduled),
+and mems_allowed (on which SystemRAM nodes it may obtain memory),
+in the formats seen in the following example::
 
   Cpus_allowed:   ffffffff,ffffffff,ffffffff,ffffffff
   Cpus_allowed_list:      0-127
   Mems_allowed:   ffffffff,ffffffff
   Mems_allowed_list:      0-63
 
+Note that Mems_allowed only shows SystemRAM nodes (N_MEMORY), not
+Private Nodes.  Private Nodes may be accessible via __GFP_THISNODE
+allocations if they appear in the task's cpuset.effective_mems.
+
 Each cpuset is represented by a directory in the cgroup file system
 containing (on top of the standard cgroup files) the following
 files describing that cpuset:
 
  - cpuset.cpus: list of CPUs in that cpuset
  - cpuset.mems: list of Memory Nodes in that cpuset
+ - cpuset.mems.sysram: read-only list of SystemRAM nodes (excludes Private Nodes)
  - cpuset.memory_migrate flag: if set, move pages to cpusets nodes
  - cpuset.cpu_exclusive flag: is cpu placement exclusive?
  - cpuset.mem_exclusive flag: is memory placement exclusive?
@@ -227,7 +232,9 @@ nodes with memory--using the cpuset_track_online_nodes() hook.
 
 The cpuset.effective_cpus and cpuset.effective_mems files are
 normally read-only copies of cpuset.cpus and cpuset.mems files
-respectively.  If the cpuset cgroup filesystem is mounted with the
+respectively.  The cpuset.effective_mems file may include both
+regular SystemRAM nodes (N_MEMORY) and Private Nodes (N_PRIVATE).
+If the cpuset cgroup filesystem is mounted with the
 special "cpuset_v2_mode" option, the behavior of these files will become
 similar to the corresponding files in cpuset v2.  In other words, hotplug
 events will not change cpuset.cpus and cpuset.mems.  Those events will
@@ -236,6 +243,10 @@ the actual cpus and memory nodes that are currently used by this cpuset.
 See Documentation/admin-guide/cgroup-v2.rst for more information about
 cpuset v2 behavior.
 
+The cpuset.mems.sysram file shows only the SystemRAM nodes (N_MEMORY)
+from cpuset.effective_mems, excluding any Private Nodes. This
+represents the nodes available for general memory allocation.
+
 
 1.4 What are exclusive cpusets ?
 --------------------------------
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..6af54efb84a2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2530,8 +2530,11 @@ Cpuset Interface Files
 	cpuset-enabled cgroups.
 
 	It lists the onlined memory nodes that are actually granted to
-	this cgroup by its parent. These memory nodes are allowed to
-	be used by tasks within the current cgroup.
+	this cgroup by its parent.  This includes both regular SystemRAM
+	nodes (N_MEMORY) and Private Nodes (N_PRIVATE) that provide
+	device-specific memory not intended for general consumption.
+	Tasks within this cgroup may access Private Nodes using explicit
+	__GFP_THISNODE allocations if the node is in this mask.
 
 	If "cpuset.mems" is empty, it shows all the memory nodes from the
 	parent cgroup that will be available to be used by this cgroup.
@@ -2541,6 +2544,25 @@ Cpuset Interface Files
 
 	Its value will be affected by memory nodes hotplug events.
 
+  cpuset.mems.sysram
+	A read-only multiple values file which exists on all
+	cpuset-enabled cgroups.
+
+	It lists the SystemRAM nodes (N_MEMORY) that are available for
+	general memory allocation by tasks within this cgroup.  This is
+	a subset of "cpuset.mems.effective" that excludes Private Nodes.
+
+	Normal page allocations are restricted to nodes in this mask.
+	The kernel page allocator, slab allocator, and compaction only
+	consider SystemRAM nodes when allocating memory for tasks.
+
+	Private Nodes are excluded from this mask because their memory
+	is managed by device drivers for specific purposes (e.g., CXL
+	compressed memory, accelerator memory) and should not be used
+	for general allocations.
+
+	Its value will be affected by memory nodes hotplug events.
+
   cpuset.cpus.exclusive
 	A read-write multiple values file which exists on non-root
 	cpuset-enabled cgroups.
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c92e95e28047..68f3d8ffc03b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -294,7 +294,7 @@ It's slow but very precise.
  Cpus_active_mm              mask of CPUs on which this process has an active
                              memory context
  Cpus_active_mm_list         Same as previous, but in "list format"
- Mems_allowed                mask of memory nodes allowed to this process
+ Mems_allowed                mask of SystemRAM nodes for general allocations
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
  nonvoluntary_ctxt_switches  number of non voluntary context switches
-- 
2.52.0

