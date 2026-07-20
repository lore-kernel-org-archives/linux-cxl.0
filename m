Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AC4D90C1
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576172; cv=none; b=QtxrXLHJ9VUc+JMgkg7tlQewH4ZuApcAL2KqzUwSWLp08wznDQFrZnC0bgdolXqVbRXh0m6DIMNLwfgG69gVp3mV9QjfmiLvoCQh1WLJYV7s0Oc5ehy7k9f/mdqPPAg2P/MJozpGfDUw6GrRheeyaLQD3QNhMyt7LlBaOSIQNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576172; c=relaxed/simple;
	bh=OgLS5lz8LcFlUwT/mS8KgOm9wsHn4lmIq/hL83K2TIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIE48w5ZpRU3asUsanofkvfHvK1dBS0i03yqoKYQXAggFxvy17eu0qlzh5qiTvSw/GouUTf01seOfcwa5raHXrNHVsUXlaSiFXIpJa/E/8hO/otd/IMPajipGrM6fXvJF4nwHbVptfIEtWCHjV2UDGuBihM3X8EsNXpUihe1Uzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PQuyZFhf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PQuyZFhf"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f186025973so119602126d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576168; x=1785180968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDe0EIY/cD+bqy5JmFZ8sdGZo0VCgkgte/Ch1WssJBA=;
        b=PQuyZFhfn2sJhMUSYjUspko+LNoX5A2aeIbQEKA/qzc6JTqLrewFNmX3BvfbSfc8sd
         JpWTsNEU+3xxH1Tw9qnkU96+o7WDZMTrygUCkGXkwjJeJgf9nK3vAD5KkU87SJjb1K6+
         0d63f7M4grdepyFmGBsZTkp6sA1Tk6L6E5rsxpfUqION7v6zCH/dEyTSsVPatzxCRjml
         he2VsfagBTRKOwqW+b9FEbq8C06ZqafbQX6fthxWzwZ0h51MgFx7vA67htF2TxP3HKJI
         aAj2AWfTeVAdi2Pja2SOgdTo0fuCcyUEhovjvwCfPzFEfqmohezenKpnzfBhGDgP/TGl
         99jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576168; x=1785180968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDe0EIY/cD+bqy5JmFZ8sdGZo0VCgkgte/Ch1WssJBA=;
        b=gJbtumCUyXlkqoGjLTRZqbdmMX71E7XiW3Xh9nw06pFNmWmpkNEpAB244nrZPhkNRy
         ALAFLxMq7FetK3InIIx1vWaXgc7HJEyxhE9pGm8339EDRPH5OE5lKiM2P2YEvRjA0EJk
         Ih+ClmnOVcClzZJobUJORlvnWLMxW30WIW9irk6DanMmb7I1dSJvmdGIPuQGqTX66Ptp
         Cgd9S0FdMzvyrOIpwqL8vY6ND5zXwgWiOQWc35uJhFWK2dDMl3vk9q31TlwZrgzGfSER
         xck7CvxExHeOYuR08VQK4lE5LjLhnw+FTNvz1u5hX6SOJkDAxEIpoM1174Vv1JJ3Iijf
         AC5A==
X-Forwarded-Encrypted: i=1; AHgh+RovcdWJcR+kkVvsPpQctpK6HEYyADrjQAgqY/cBBQYLE1c6+38JYYBbYDN3Vy/qDj0otC88kfsngI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjWTlJIeo1on3QDkD66g1QGskg5Afx1a3SQyAi6XyNuaEqoJj
	waLIjbQHnjC9ql3tUDuKG45No4McIvgO9Qc4ndnU3/5u3Iitnj9tHTsg1EPECRbRGZ8=
X-Gm-Gg: AfdE7clQ0uR4kJa4XudyaXk08hFVOiuntVCNSv1UjmDh/tEkY8u+6J+R/A1YCp0I7P/
	zOH3q3qIdttMwspNiLI0riAfaai17MV7nWbQP73+jEkrzfV5Uc2UDIEuu2ni9GAzxV7joS7kzve
	mn0SlrRel8xlWTixlOkQ2GvJZZ4B5OCxpVtkjsn0DqV+TT3cl9jqxVOGwXFN8q4fPooyRH0L8ir
	beUBzSlcV/S5ROPBDt061yeufdXSpLn6zrYaXI7NdvHWya4/z6czmG//8pPPv9sVemIXghSbq4K
	5ENe0ut5Ps41w++W3e2NA6vfuoOGLlAPmmvQyUxq4CpXQuxdbXY1FwcBxgzx80Dfmyy6nzGiaHu
	WZn/hPL4nVa3vWYXMY+rx/7QpznFqCBr4JheOjt2Yq4dtwsg/jMTk5anwcjRJI/YqXPXRrIePF+
	8rjUw4DRFCzbsh4KuFzRjbKkHBMYqajY2gm69UH5H1L3kX13bHY/keuLMo0vfbuVs=
X-Received: by 2002:a05:620a:28c7:b0:92e:c118:18b7 with SMTP id af79cd13be357-930b43c37e0mr1448114585a.86.1784576168124;
        Mon, 20 Jul 2026 12:36:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:36:07 -0700 (PDT)
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
Subject: [PATCH v5 34/36] mm/mempolicy: add mpol_set_shared_policy_range()
Date: Mon, 20 Jul 2026 15:34:28 -0400
Message-ID: <20260720193431.3841992-35-gourry@gourry.net>
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

mpol_set_shared_policy() installs a policy over a VMA's page-offset
range, which is the only programmatic way to populate an inode's
shared policy after init.

Two limitations make it unusable for binding an entire backing inode
from in-kernel code:

  - It requires a VMA, so it cannot cover unmapped offsets.
    (e.g. unmapped file folios faulted by pagecache)

  - mpol_shared_policy_init(), the only no-VMA installer, reconstructs
    the policy from mpol->w.user_nodemask.  That field is only populated
    for static/relative or mount-string policies.

    a policy built programmatically (e.g. by mpol_bind_node()) leaves it
    empty and stores w.cpuset_mems_allowed instead, so _init mangles it.

Add mpol_set_shared_policy_range(), which installs an already-built,
fully contextualised policy verbatim over an arbitrary [start, end)
page range with no VMA.

Reimplement mpol_set_shared_policy() as a thin wrapper that derives
the range from the VMA, so both share a single underlying path.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/mempolicy.h |  2 ++
 mm/mempolicy.c            | 35 +++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 715951a5b03c1..1348e9f5f2cf9 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -125,6 +125,8 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
 int mpol_set_shared_policy(struct shared_policy *sp,
 			   struct vm_area_struct *vma, struct mempolicy *mpol);
+int mpol_set_shared_policy_range(struct shared_policy *sp, pgoff_t start,
+				 pgoff_t end, struct mempolicy *mpol);
 void mpol_free_shared_policy(struct shared_policy *sp);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    pgoff_t idx);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4daba81fff7c7..23c4c25097450 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3424,24 +3424,47 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 }
 EXPORT_SYMBOL_FOR_MODULES(mpol_shared_policy_init, "kvm");
 
-int mpol_set_shared_policy(struct shared_policy *sp,
-			struct vm_area_struct *vma, struct mempolicy *pol)
+/**
+ * mpol_set_shared_policy_range - install @pol over [@start, @end) of @sp
+ * @sp:    the shared policy tree
+ * @start: first page offset (inclusive)
+ * @end:   last page offset (exclusive)
+ * @pol:   a fully-built, validated policy, or NULL to clear the range
+ *
+ * Installs @pol over the given range, replacing any overlapping policy.
+ * @sp takes its own reference, the caller retains its reference on @pol.
+ *
+ * The policy is not reconstructed, so the policy is preserved exactly.
+ *
+ * Unlike mpol_set_shared_policy(), no VMA is required, so a range that
+ * is never mapped into a VMA can be covered, including the whole file.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int mpol_set_shared_policy_range(struct shared_policy *sp, pgoff_t start,
+				 pgoff_t end, struct mempolicy *pol)
 {
-	const pgoff_t pgoff = vma_start_pgoff(vma);
-	const pgoff_t pgoff_end = vma_end_pgoff(vma);
 	struct sp_node *new = NULL;
 	int err;
 
 	if (pol) {
-		new = sp_alloc(pgoff, pgoff_end, pol);
+		new = sp_alloc(start, end, pol);
 		if (!new)
 			return -ENOMEM;
 	}
-	err = shared_policy_replace(sp, pgoff, pgoff_end, new);
+	err = shared_policy_replace(sp, start, end, new);
 	if (err && new)
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_set_shared_policy_range, "kvm");
+
+int mpol_set_shared_policy(struct shared_policy *sp,
+			struct vm_area_struct *vma, struct mempolicy *pol)
+{
+	return mpol_set_shared_policy_range(sp, vma->vm_pgoff,
+					   vma->vm_pgoff + vma_pages(vma), pol);
+}
 EXPORT_SYMBOL_FOR_MODULES(mpol_set_shared_policy, "kvm");
 
 /* Free a backing policy store on inode delete. */
-- 
2.53.0-Meta

