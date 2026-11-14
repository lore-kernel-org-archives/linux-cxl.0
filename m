Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640216;
	b=xd7xXy9KXiHe4ZRqSL0uXvLkwg8k+HBGoFcMErMGWEADsjO+NZ54gYHV1fLTBAtHREHE
	 QjrDxVbZi3bcKFLmx2QrJvo8WZstDeoPmvVYuHoU4090nMtVnYFvafp9oS5AoxQbx1ZZ5
	 Xempn8c/Fb6dABjRgfWlVII4xeTDts8S5NICI7g4ColodEWVJs/otylOJJT/GE/TrTQ76
	 W8yKtus1dSytDTlb/JdoW1BM28x4VqP14j6Uz9mlEjcKzJzbgxE8ZOOgvPglcnFndynqj
	 6qV0zSxn2QliHZyGvUjrtvBHfaODeT7NvQFsaZoXnbnX1xpORzAzmiNUsPFmnkoxjGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
	b=Vb08q7k2MQT38+OaKeQpTP+Xrf6amWg3XrzQ/R6vnDExBgXVWPEKLE3YBE6wPkm0eQbQ
	 yz5eKHnEJdjnRVNcsh0HHARxo3Ak7QKXPi4Wg0UoKiFcb6AR6fMo8Je7j8WYQjEYJdOZf
	 JRMERnbZ9U5V7jxcL9yx49/4cidx4tqe0BHCQBdVFPPp1zRb++G7R2m0yhKE6sx1w9otC
	 m8rbD9XPPCf897izz4OwkYsjz9legvbQ8DQR4dM7ZTAzBzaydBe7KN3CFwTOXvBiHMhuc
	 9JTgRQt0aNAaiU+cYCLe42ovllQ4kjsqFJYZK/ZWcVSdaVC7SoV9JPT+VWnMp8NymYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7460A2628
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA7460A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=d7KKfvBB
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea0c05c92so32025366d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640215; x=1795245015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=d7KKfvBBW5/5gvjm+2xpumHZ1G9opFmCK0hLy80god6602rP4hD7WpJOGpuokt5mAL
         oS0dK1kG353je+Plx7acyy3uDD+xG+fq13pPPunFf2FrrH3HCYFO6byP3Sxtv2jFPZRS
         xkvrHljmRCgifnLPU7TTzNYxo6K/0+6E/ugTWtazA660Z6j34/gCIt06b/pby46TMW4f
         tuIOIKSVgbsNBqf2nKWyrmyI0gqtvTjJCJgKoGlUlvqVhTxSTJN+XkpcJKcwx1Td3Q6t
         AEo832DgjwwYB1HZ/pxFbAs31Gd3WOnHnsRaeSVQ8XmVN/B1qBnlz7xTmeoX3z8P3pSY
         IBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640215; x=1795245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=gU+2i35VJjmNf52jsnuFa87TfTONVgSFX6wl/yMsqSanGI4Jtd3b9RiV070WykehEv
         GZPKma5WS/T8xiQNwKw+xNe8abIGFHTldnBApA3sqF/3sB0eiTaMfh0inH+xmTlXLDcE
         lbTyF5777+jROFxT4cC5FuZ8lkEmVa+LkjEUPmRhq6Beh6mQXSsuHBFTcZP04b6dkQNX
         ONfaGP3RkH56t5+79MW6qkngatW2Dwg1qHaIjl16fnIHl8W0GMTgQbCvmtvQ1yhfBtTS
         txP226UFc5lquZu600um04BRInaViGep+gz0M1CksRLoBUrORhRaNZoTmWCuPGfifNOE
         Q6yA==
X-Forwarded-Encrypted: i=1; AL+hErFpR0qxM/casoSj5oUXk4Uro0YgOtnoSyJnNJ4yLxucv+niwDWFOqLGcQHgPCJYq7SXwaHgTrhar90=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lDkqznl4IIwpVdRJIKtNlMj5Jd1sgwZBLbshtWSSct0XKa+to
	auiNrOZO4v0d7kMw69Zredm7dm0+5QzO4/1b0VfY1xGaENgrXkLEvpYH8kqdM78MJg0=
X-Gm-Gg: AYBFou0toEZpzhXyyO/Wy+dJj7fXvWRB2oPW03FnVuJuLBTu3V3d7uysnVnDle7h46l
	T1I4gAyDKmO+tJc1DWfnIAqT0E4B8EFQhynS3NJSHVYDcEwT8GQ02h1CkSLYEHAusBYuO2JUvWW
	D5ltHzvbnjWJ2gJ87+5yk43Cj5cSSen4B2EOEpEHNrV+Hitg1+bIY7pJNe+FLDKIo96//Dl2QGN
	Eat+NzScvASIbxV/xCc6rKkwqxArtvujWgDBi6cJRU48okgkr59M6meSgJayAKFgoPrYa6tOdHh
	QCgoK/u22BgNDL+xQHIz+goOANq/lXBZnnw/i1PhpsigBeXMVbSZvC3mhqiyaLrnR2Dsucgtao1
	/GjZxSSlD7bmRUvxNgqaUOs1pvtxYrpAZlprX7piFYXCHq/n3wLiy9g+Znedb4pSC4pOfL8gYvG
	S8vFj5qwrTPgucsgAbBQfRq1WuPJyU466eurtJ9io0bpvEKk0djhZ7BQSS7D7t03Ad3kZvmusBu
	22/G6p6LOvlJM6ZBeKEmxSzlbrDMIq238EOmV0DTf4fmK9oang4RuZz7JAM14jZb7cqcw2YNFNw
	g2RXbEz5E0Rh+QioQC/vfUwx6fwBkHhyIDIac+sh7Ur0VK1Aus7eDbibSsqmDppTEG4m81KgYbG
	6nAHMziH0DQ3x1hY=
X-Received: by 2002:a05:6214:8581:20b0:91e:a16b:7f59 with SMTP id 6a1803df08f44-91f241f7044mr56496996d6.32.1794640215081;
        Fri, 13 Nov 2026 23:10:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:14 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount policies on common memory
Date: Sat, 14 Nov 2026 02:09:42 -0500
Message-ID: <20261114070959.3490008-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
sysfs entries (weighted interleave weights). 

Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
and mbind() masks to N_MEMORY_COMMON nodes.

Later when an N_MEMORY node is omitted frmo the N_MEMORY_COMMON set,
they will be stripped from mempolicy nodemasks as they're not eligible
(similar to memoryless nodes today).

All memory is common at this point, no behavior change at this point.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b10c098e9c2a3..662ab420fe03c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -213,10 +213,10 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 	int nid;
 
 	/*
-	 * N_MEMORY can change while wi_state_lock is held. Remember the
-	 * nodes contributing to sum_bw so all passes use the same set.
+	 * N_MEMORY_COMMON can change while wi_state_lock is held. Remember
+	 * the nodes contributing to sum_bw so all passes use the same set.
 	 */
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		node_set(nid, nodes);
 		sum_bw += bw[nid];
 	}
@@ -439,9 +439,9 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return 0;
 
-	/* Check N_MEMORY */
+	/* Check N_MEMORY_COMMON */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_mems_allowed, node_states[N_MEMORY_COMMON]);
 
 	VM_BUG_ON(!nodes);
 
@@ -3400,11 +3400,11 @@ void __init numa_policy_init(void)
 
 	/*
 	 * Set interleaving policy for system init. Interleaving is only
-	 * enabled across suitably sized nodes (default is >= 16MB), or
-	 * fall back to the largest node if they're all smaller.
+	 * enabled across suitably sized common memory nodes (default is
+	 * >= 16MB), or fall back to the largest node if they're all smaller.
 	 */
 	nodes_clear(interleave_nodes);
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		unsigned long total_pages = node_present_pages(nid);
 
 		/* Preserve the largest node */
@@ -3476,7 +3476,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*nodelist++ = '\0';
 		if (nodelist_parse(nodelist, nodes))
 			goto out;
-		if (!nodes_subset(nodes, node_states[N_MEMORY]))
+		if (!nodes_subset(nodes, node_states[N_MEMORY_COMMON]))
 			goto out;
 	} else
 		nodes_clear(nodes);
@@ -3508,7 +3508,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 * Default to online nodes with memory if no nodelist
 		 */
 		if (!nodelist)
-			nodes = node_states[N_MEMORY];
+			nodes = node_states[N_MEMORY_COMMON];
 		break;
 	case MPOL_LOCAL:
 		/*
@@ -3903,6 +3903,9 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case NODE_ADDED_FIRST_MEMORY:
+		/* Weighted interleave spans only common memory. */
+		if (!node_state(nid, N_MEMORY_COMMON))
+			break;
 		err = sysfs_wi_node_add(nid);
 		if (err)
 			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
@@ -3934,10 +3937,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 	if (err)
 		goto err_put_kobj;
 
-	for_each_online_node(nid) {
-		if (!node_state(nid, N_MEMORY))
-			continue;
-
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs for node%d during init: %d\n",
-- 
2.53.1-Meta

