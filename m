Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3D25634
	for <linux-cxl@vger.kernel.org>; Wed, 27 Mar 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524455; cv=none; b=QiRSmpqrSaGGWKqocFltuAohbL1qNlTaxKywVaWYoNNOuN/xI667hh2Dg6xh0Ayh4XwVC1ixVGapQqze7SMRS5fWxclAPOld+qGGqaOwA056Db8LtInlUn7d7rtZePqZ2/sg8ZFFCKeycH+nzKeG+d4NWMC1dhxL2JwaMbeiCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524455; c=relaxed/simple;
	bh=vFF0xl5uC5TkFV+VvhVksXaBFVN1XObnMprIpkcV0NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bh1qW4b1mfjOw6EnMo32fKd+E/VoMboXJb8r/pPzU1/643Gz/EHof9jvYNClQ426JZ0Zf93+o/BuyGBYloVtfbz4svRucW1hWoOgDRA10ztAqP6mo7HvbA0yYIYMJSiJsmtWw8Q2D6ABhluew3cAk2EADR6Nb6oeoieBSdlGstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HLwX/I+k; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HLwX/I+k"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43107ccd7b9so40709591cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 27 Mar 2024 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711524453; x=1712129253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvdqGcDUWp3D4k7+aVnVSTSeWYL78OJhC3HPSf53QMU=;
        b=HLwX/I+kLD16QsU8O+gINjU6liHuMF3mgccDjw8f37ZnFTmfFjgVukvvQTOfuP2OT0
         38lYyKbVawaKoR2dAmGBWhkOAd8ezxeFm/mSEz7WcAz8nhKrqd2WjpCoYafravHiZpHB
         IQtA7XMJl3FPV48u96jv0TKl+hXMTZgOjs6mNkYVOwXkm+dOR1MjgFFk+zA1jw42ztsa
         nkFurwZv6MJVKBtus+kYj1DoIHeikqaFWcedZf+EHgTCLIjKRKi4iDq5OpVpP/EiXDvO
         hF7SpH85HpgMVUHHJNKx92HVcTSv/O/NWm5xbKmP7iqyOwWHxy4jMfP1D2oUxv49JPn1
         7T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711524453; x=1712129253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvdqGcDUWp3D4k7+aVnVSTSeWYL78OJhC3HPSf53QMU=;
        b=nWyXQVI2WOGVayih4OaIXDHHIyU1b73xIndCMLzVBrFScieThY5OVnb1ueDAbDi+h+
         LeH11lc0TlnrP7nQis8+4ug9ZbH5LFGX5RaFsyJkeUNcNnYpE3ZfhB0TE2JI0FJlSz1L
         lcsOkz+B8waZVGbS0MEl/Oh0/AhAbiXEjuNHpIPGn+03DNWaPWL00yA30687ndu7exzj
         cfR9mnVCiSBXNCfsuLJvpLkxBMnQhyZwwdqWI/4P8zUWA7HCHBfb4zvgy98pexLdXMpq
         ijAbsieYxR6vdOomDqY+ZZZ427SXKQHDMKWA28/UmaRfGjQjZLiq69IVFaoRL06xEe2j
         7WeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV54e7p2xi1jFeOW7y51mtkvE8gwpVTyXHCHRpwd8FUR8iv5kaQF36mMy9i/oWf2Eq7P6cItBubcjBfmZoh8QZvwBtZko+xaWaa
X-Gm-Message-State: AOJu0YxUL3SVbUq2TqSBf483yWILS4UMjduIsVotFb9loWBF9LtFBwrH
	njUbNqFgcW8x2ispux9GdgtU+zpJ6ESvuPeDuo/4w/xpL0CvIhJ7g26NILUhsow=
X-Google-Smtp-Source: AGHT+IEI0M9d2AyKg0jvWeTlX5tpwHLQC2KlAkAsKe2cbEUuq+AjdA4mRWp3a2a6xzEVmFSqeoe/8g==
X-Received: by 2002:a05:622a:1450:b0:431:7c7f:411c with SMTP id v16-20020a05622a145000b004317c7f411cmr1553361qtx.49.1711524452825;
        Wed, 27 Mar 2024 00:27:32 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.102])
        by smtp.gmail.com with ESMTPSA id bq15-20020a05622a1c0f00b00431604af3c1sm2383555qtb.20.2024.03.27.00.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:27:32 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
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
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v6 1/2] memory tier: dax/kmem: introduce an abstract layer for finding, allocating, and putting memory types
Date: Wed, 27 Mar 2024 07:27:27 +0000
Message-Id: <20240327072729.3381685-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240327072729.3381685-1-horenchuang@bytedance.com>
References: <20240327072729.3381685-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since different memory devices require finding, allocating, and putting
memory types, these common steps are abstracted in this patch,
enhancing the scalability and conciseness of the code.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 drivers/dax/kmem.c           | 20 ++------------------
 include/linux/memory-tiers.h | 13 +++++++++++++
 mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 42ee360cf4e3..01399e5b53b2 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
 
 static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 {
-	bool found = false;
 	struct memory_dev_type *mtype;
 
 	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry(mtype, &kmem_memory_types, list) {
-		if (mtype->adistance == adist) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
-		mtype = alloc_memory_type(adist);
-		if (!IS_ERR(mtype))
-			list_add(&mtype->list, &kmem_memory_types);
-	}
+	mtype = mt_find_alloc_memory_type(adist, &kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 
 	return mtype;
@@ -77,13 +66,8 @@ static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 
 static void kmem_put_memory_types(void)
 {
-	struct memory_dev_type *mtype, *mtn;
-
 	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
+	mt_put_memory_types(&kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 }
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..a44c03c2ba3a 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+							struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	return NULL;
+}
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..974af10cfdd8 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, memory_types);
+	}
+
+	return mtype;
+}
+EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype, *mtn;
+
+	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
+		list_del(&mtype->list);
+		put_memory_type(mtype);
+	}
+}
+EXPORT_SYMBOL_GPL(mt_put_memory_types);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
-- 
Ho-Ren (Jack) Chuang

