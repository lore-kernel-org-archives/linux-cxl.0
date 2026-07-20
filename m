Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9B4CA284
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576163; cv=none; b=OkM1Jmu8UrO4qNRdGiZuVFV4Pj4ZgLCczi0sJaxdqQLCwvgFLDSWEllPUEWg6dcr5zGsjbkX1evCdS+MnJMqmZhYAnynf0tFtfu4+Ld7y/5ZmgruG1jUwWAzyiIeRHEfJcfH33dPg5xRZ0EeV1fXZJbN2SkyCZYEpZXGoMLUe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576163; c=relaxed/simple;
	bh=99pkAOPGtwB/BzPLgYWE1L+4EzvxcH4p7JFn3jZ80+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1PDUQSmyTFiI3e9DjFALYxSOm9V3NtrUoCruTznA4bkwLEcNOmFIFm6PaJloR/ySET0u3NT49JGRPWoard9uOjcDOn/kWxPfaRXHk7Iu0+MyFw62LCLEJBbzgjf5+a7YGadN4PUDgUG656wmLMrofsRc3Xf3rhXt+1mE0Q7Dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pBudzOTg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pBudzOTg"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e622cc874so782476685a.0
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576157; x=1785180957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyvPve12WhVPZzxgug/++OGUAj2qo04o06OFhCcQQmk=;
        b=pBudzOTg3CQS7bU6aa2/3qCLPH06+plLdsnBfPa4htG/DFZuTcu0A4+CWaWMPirDgG
         bn33DXYjMF44s/PkOZpbV+tUJgqPMzmcNA3pbkX1eXE96jV7KSwmYYTqFbzPQFL8Avl0
         28rLcXH2cafiKbRSFus/ifFddlVgbssJBFdCH7iDJKzejdZMjzZywJKLroAlVCaCtPWc
         36xHymoV+jWp5ncSipVMfKyPg2rfmAcqPZvLugfGi4y37TQYH2DCdF+FI8V5g2089JlF
         teoPcfWmvE4q4UNNd/WZgXDLBgjhHm/PVW/bpGFMgnwms1VTaYzaqvAIqvg3EVKUGkNj
         5O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576157; x=1785180957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyvPve12WhVPZzxgug/++OGUAj2qo04o06OFhCcQQmk=;
        b=f3uqdTWLc7m9ZhzIu5TX4A6gHbl85cy/mU4/Dn4eEUex1HgQjhIHN2Mg1uo6wOhSto
         BQTuAQO7XK1LyKHX35Ayd7YqAWBTIIw9tfryUCY25cBWjRHUp8qlfmeFc7zgRGc0QcnL
         G+Dq0Nr4G2C2f+A948gPy8o3T4OjhVFsZGlbsZAlf8dRd3JUTKwL9Jh5fjX/de5IoQ24
         g3bUyxqupEo3dqR0CtN/znnJ+3ufIymdGwDKrFY0XzXxZxOQVSOrvAq5Irq8e6SiLuhT
         kk0bHKgC3b6TfhchssNDDj3xK5KhjLt7y1LUM69CHv1LQPxlcoGkkYLxUtoPT2Bd4EVl
         WU5w==
X-Forwarded-Encrypted: i=1; AHgh+Rqmg41+Bhl7M2S6pgZKU2iIS8NscA0qMIyyHht7608NYeVWMGGY2MVm2CLTbxWJBApmqPNOrcVJYIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MFPVjJaSK3MLD8YyiRycYasIF3SFMOWI2o8UTLuORGPMBshO
	vW45nXpIhtObDF6KJnccvauqwBqy4nvUBnDtcdWZKoee2Qbh3YE+Z2/dzQrsj5xc9AI=
X-Gm-Gg: AfdE7cnyE0xGGq4iX8/jlkiryBhxgQ6Kh/w0s8lu9jtJQLCeAucuYa///ZQmv8AkiGr
	Ms5Pl6uuGWqpBG1mpLiyF6IfQSFcsP+CSIgQgaelABxMkNoQiymJj1Gvn5WE5km4m7HeSb++1yF
	Tt0dFRplYMYWT1U7vNgfbigQTJNiHiu6OPHuZo7MZCTqPr1RYAdfNlmCAdVUDdOw8hgwDtnsXBs
	O78B2puwCyC+bQy2fdDEd2wLJ+GTwNvOpRf1kYHfOUhApK2qpGLF4iRhmejG6lxDmXppsNoZtb4
	19WPU1FIGJZJoS1u9G764IUj5RppvQxCaGCGHLACL6nkIo/RE9oVTrPY4vgPf6gFx/xok3M4V6p
	PY7jak68WLnDO8oB8qqUwsPz29PnLbTJWL51bvuqkioYsS1VvA1hY5CSAZiWHf4cZITnyTZMG4W
	Av4ILpXfF7cXg1nx7IcFQwORTC/KBsBBGHgK3ka7WykPZ2xo4O/OjHJW0sLQYYrDo=
X-Received: by 2002:a05:620a:2855:b0:92e:c118:18e1 with SMTP id af79cd13be357-930b437e3afmr1539338685a.88.1784576157342;
        Mon, 20 Jul 2026 12:35:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:57 -0700 (PDT)
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
Subject: [PATCH v5 30/36] mm: add NODE_PRIVATE_CAP_NUMA_BALANCING for private-node NUMA balancing
Date: Mon, 20 Jul 2026 15:34:24 -0400
Message-ID: <20260720193431.3841992-31-gourry@gourry.net>
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

By default NUMA balancing does not scan or prot_none private-node
folios, so the kernel never migrates them via access sampling.

Add NODE_PRIVATE_CAP_NUMA_BALANCING to opt a private node in.

Add folio_allows_numa_balance() to gate change_prot_numa() scans on
node eligibility. Opted-in private node participate like normal.

Unlike demotion, NUMA balancing is not reclaim-driven, so this
capability stands alone and does not require CAP_RECLAIM.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 29 +++++++++++++++++++++++++++++
 mm/internal.h                | 13 +++++++++++++
 mm/mempolicy.c               |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 87b03444b2c97..5c3e070ed0deb 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -16,6 +16,7 @@ struct page;
 #define NODE_PRIVATE_CAP_USER_NUMA	(1UL << 1)	/* allow mempolicy */
 #define NODE_PRIVATE_CAP_HOTUNPLUG	(1UL << 2)	/* allow hot-unplug */
 #define NODE_PRIVATE_CAP_DEMOTION	(1UL << 3)	/* allow tiering demotion */
+#define NODE_PRIVATE_CAP_NUMA_BALANCING	(1UL << 4)	/* allow NUMA balancing */
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -143,6 +144,29 @@ static inline bool node_allows_demotion(int nid)
 	return ret;
 }
 
+/**
+ * node_allows_numa_balancing - may NUMA balancing scan/migrate this node?
+ * @nid: the node to test
+ *
+ * Access-based promotion/migration.  Unlike demotion this is not reclaim-driven,
+ * so CAP_NUMA_BALANCING stands alone (no CAP_RECLAIM dependency).
+ *
+ * return: true for normal nodes and private nodes opted into CAP_NUMA_BALANCING.
+ */
+static inline bool node_allows_numa_balancing(int nid)
+{
+	struct node_private *np;
+	bool ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	ret = np && (np->caps & NODE_PRIVATE_CAP_NUMA_BALANCING);
+	rcu_read_unlock();
+	return ret;
+}
+
 #else /* !CONFIG_NUMA */
 
 static inline bool folio_is_private_node(struct folio *folio)
@@ -180,6 +204,11 @@ static inline bool node_allows_demotion(int nid)
 	return true;
 }
 
+static inline bool node_allows_numa_balancing(int nid)
+{
+	return true;
+}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/mm/internal.h b/mm/internal.h
index 62e68acae08a3..01ab8b32b0bd8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -123,6 +123,19 @@ static inline bool folio_allows_madvise(struct folio *folio)
 	       node_allows_reclaim(folio_nid(folio));
 }
 
+/*
+ * folio_allows_numa_balance() - may NUMA balancing scan/migrate this folio?
+ *
+ * NUMA balancing is access-aware tiering migration, so it follows the tiering
+ * opt-in: false for ZONE_DEVICE and for N_MEMORY_PRIVATE nodes without
+ * CAP_NUMA_BALANCING, true for all other folios.
+ */
+static inline bool folio_allows_numa_balance(struct folio *folio)
+{
+	return !folio_is_zone_device(folio) &&
+	       node_allows_numa_balancing(folio_nid(folio));
+}
+
 /*
  * folio_allows_longterm_pin() - may this folio be long-term GUP-pinned?
  *
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fe42a510590a2..4daba81fff7c7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -874,7 +874,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nid;
 
-	if (!folio || folio_is_private_managed(folio) || folio_test_ksm(folio))
+	if (!folio || !folio_allows_numa_balance(folio) || folio_test_ksm(folio))
 		return false;
 
 	/* Also skip shared copy-on-write folios */
-- 
2.53.0-Meta

