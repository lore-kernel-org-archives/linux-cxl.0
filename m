Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658684C77CC
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576158; cv=none; b=URD2iM+MJQAKkYBtg0Tajn3hmT25qjDZlPOauaQ+K6nIJ5W4FDn31k8/5XkHkNE7cMPh9QwHoXaWwTAUEiRiYHMXwIzY0pEjLgc1IfaMtMqkK1qInwnWmdubzphuU0tEJvqKoNM4AUno4E7iQFafUn9t5LatpS+nyxSz+33+mUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576158; c=relaxed/simple;
	bh=d6pCHtBqoNKDq4P4c/ZFNHldTuhwFRB86ulVg/xnwxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmJBxrkpH8Nxu3rdCVc7rZr7ugWjNo1RAo0FTRXCJHotf5GRDR9IaQOwDLOo2SJ7jVMKYKsgbryVe5jXI0Zng4QhKXh+5A2r9/y9GRt+L08EaqDM1nbFcvGW4eXYcP2jlxDG/5839UGjqkBEvCKwwRjujynM1eYZbgKTAMTCtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jcgp0i8b; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jcgp0i8b"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92edb12cdf2so447599985a.3
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576153; x=1785180953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwwcrXiYs5LXY1nHNJcH4eGwqAhaBzqBMJWfc0nxcvk=;
        b=Jcgp0i8b1v13ud6qzJTbUzpBa2tu3Kq+68qdci6H8QYChJcKI5TbYlVm3LSzN/Tqo0
         kCiyG5+1BWPhrezzMQzpS1Se7pe9vUhTt0480nM1byigf9BRpTni+C363M6A+7ccr9Fq
         1joDNapj8wMJ4P+ji1ud9VeIfIbiPk0Y7KFJkMr1ZWvcnX4ejoajz3uj0iqpUF3Oq9r0
         hOWtdZrocf62Wy2SbjHE1pnUN4IufUQj047zEuUVwNWyaQPGJ+8u7eeej60qQrkJquZx
         051Zu0a+2BUXdRJbTzigD3ZypGe0AxiL72ijPAl60r44UoJbXmokXhNzlaw3Fp02n5XN
         HIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576153; x=1785180953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hwwcrXiYs5LXY1nHNJcH4eGwqAhaBzqBMJWfc0nxcvk=;
        b=rk2738EhgzDZ2F/WTTfz0lyqBGpU28S1Q6eBs7qZsgO4+9FxtEI2ItePN9bnuPI34x
         JVx/YqMN7DThR/DF1YySdH4AELHJ3IjQJ2wROje2YQzIxQBx80zLGqEAiwu6xp7mqp9B
         xzJYDas6nBTkkbKQRV4AEpOl997ToMyiSRl1MM3gKGNEkAJLL4XIVxGiiz838pllaq0l
         ksnC6TVa3/Ot6BwIlR1ZpXZkhcmUlhCz5zAXWzs3o2+u+m2NwoQ4fUqRkl1k0/ECIes4
         yHJoy33/V74yekqFCzN0aJm7Sp2ggNFXNtKb8v1q/Q32wSkbCebPhd0ihgzDHydQXAri
         yfYw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0bceshmCTH6/Sh9hhia6BlSQ7U3Gjx2LkXWM/ymKkHRyuRdUgJBxhvPEnF7HYhRr+UAmia32tag0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32QCEeuUm06AUdpblaj4PYUntwdT8uny3MsFsof86efiUAhka
	sCkzm4BFxjKGX46VBu8HeAgp2GQoZpnPq/9RqZ7ZVcyX1zFiypI/KPlYRX8pk93gzdo=
X-Gm-Gg: AfdE7ckV+97GeGTnUk1HR34bwwJFc5VCwGic3bXhat6bZhj46xF+ylbgvOB8xjAffUP
	/feanl+kxuQj35BqzUScQyFnuZLwxU+j50ieOM+qbTzMu+94RFKJ0dOCPVxS9KMN/15d9fn3Vys
	crWZKbhvtpdZIK7Ub1xDN41wfSxbxuUZZ9px5zPg2KuF/0hvOQeqITuR8S/stINKUKgOom/fLl+
	XdIsBA3JqWPkQIT3WgRv++M1w38mcLYS9+i0sINKO9EEY+DUY6U9WSQ2WDkRBWnkp75IoQwr9Q6
	dqWh657qmCfSb3/w6I6PGy8GmewyqCE7P/4cECtEs50x5fWTpM9QuouHA4pZRj9dOutrygPGKNx
	7LHtxcgZeSE5402Ci289rJT6EMhm/kIQcZ71tvASA2mwLzoTjibb5y4bz+WUDz+6Wxho3q1sN3Z
	QA5/VeCk0HtT/Ir1WclHKDTdXh36qfJN1iaRiJf7ORS+CkPO7GneiSAASiaRCrwBw=
X-Received: by 2002:a05:620a:370e:b0:930:9a84:d90b with SMTP id af79cd13be357-930b416db01mr1583254785a.50.1784576151483;
        Mon, 20 Jul 2026 12:35:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:51 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 28/36] mm: add NODE_PRIVATE_CAP_HOTUNPLUG for opted-in private nodes
Date: Mon, 20 Jul 2026 15:34:22 -0400
Message-ID: <20260720193431.3841992-29-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CAP_HOTUNPLUG, which allows memory_hotplug to migrate a private
node's folios for the purpose of hotunplugging memory.

Without this, hotunplug fails if any folio on the node is allocated.

Add node_allows_hotunplug() - which returns true for any normal node
and private nodes with CAP_HOTUNPLUG.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 26 ++++++++++++++++++++++++++
 mm/memory_hotplug.c          |  4 ++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 655fe9ec5cb61..7b617b1fa9c28 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -14,6 +14,7 @@ struct page;
  */
 #define NODE_PRIVATE_CAP_RECLAIM	(1UL << 0)	/* allow mm reclaim */
 #define NODE_PRIVATE_CAP_USER_NUMA	(1UL << 1)	/* allow mempolicy */
+#define NODE_PRIVATE_CAP_HOTUNPLUG	(1UL << 2)	/* allow hot-unplug */
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -97,6 +98,26 @@ static inline bool node_allows_user_numa(int nid)
 	return ret;
 }
 
+/**
+ * node_allows_hotunplug - may hot-unplug migrate this node's folios?
+ * @nid: the node to test
+ *
+ * True for normal nodes and private nodes opted into CAP_HOTUNPLUG.
+ */
+static inline bool node_allows_hotunplug(int nid)
+{
+	struct node_private *np;
+	bool ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	ret = np && (np->caps & NODE_PRIVATE_CAP_HOTUNPLUG);
+	rcu_read_unlock();
+	return ret;
+}
+
 #else /* !CONFIG_NUMA */
 
 static inline bool folio_is_private_node(struct folio *folio)
@@ -124,6 +145,11 @@ static inline bool node_allows_user_numa(int nid)
 	return true;
 }
 
+static inline bool node_allows_hotunplug(int nid)
+{
+	return true;
+}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1f42ed303366c..e9573f90e0dcd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1943,8 +1943,8 @@ static int do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			goto put_folio;
 		}
 
-		/* Private node folios cannot migrate, fail outright */
-		if (folio_is_private_node(folio)) {
+		/* Fail outright on private nodes w/o hotunplug support */
+		if (!node_allows_hotunplug(folio_nid(folio))) {
 			pr_info_ratelimited("memory offline refused: node %d pfn %lx\n",
 					    folio_nid(folio), pfn);
 			folio_put(folio);
-- 
2.53.0-Meta

