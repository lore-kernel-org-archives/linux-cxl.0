Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FA47ACE4
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156430; cv=none; b=KJDBgPNAj276x0MedcpV/zY6X9GfHLAc3zd3UpsA+Y3h2kT/2uN1kLXbi0vNNJYwdOlGAdRQGkvC1kZ9Knxp5VdMnjzCbMui3epe2AQXkPh0J7GEQ9z/jj7xTXYIAOCrUh9mszdKKMFB9yEi/lN8gp7WmaBsmoEEa3bXWIrw4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156430; c=relaxed/simple;
	bh=L6pjBYO8pyfc74NKRJM+Aw+PuIzrtslIC2/PolNoslI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SirC4IJDUDk7fR9mjI82qL6WzJrrnEAN+GDVyw+GRY0FrF1B3yGFANTjrO6TtYmMvizoaosTaP3vvpJGiq96IKsSacsqsKMQAMbHuNBGcWmYXZjkuts72iyGtZhMRzS58KFee29zPqZ/D1sKyAcb0fXrlSuNMUO01ONeGE3ln4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a4ifBbNk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a4ifBbNk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so2999659a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792156428; x=1792761228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bq/LpBxXTW0ASsexzlAoQoBY+9bpCrcejtfW5Dqw6Do=;
        b=a4ifBbNkAEawdS84V8nlEjf8ubgJBdwTaSPkF5gEhBuq/JeoDXIApGNsXddaW3Bgl1
         KQxy/h9wWBmIz7iwPcYtLPREeUXpj/l20ICdsSYMni0oUgcCJ1JL8xDKv65TuRzi3eVT
         UVKtbfbRkdKaIEZ2Vb+vaVoDk9806vENs95866h/qXQhrQr2eVBuPD5kvy0WN8z7VZ5q
         CakBCNGHY3n+5OHY1vGND0NeLKBJksAjh/F39zVg0XlF8u90X59ADemQXjXbCz7q0Lcd
         qBc8jDVSq0MYXMN7DpHKEVMox43kKGTj3AOvje0f+a3xIMX8BxDZG4Iuv1SkGl9RsmOZ
         TJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156428; x=1792761228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bq/LpBxXTW0ASsexzlAoQoBY+9bpCrcejtfW5Dqw6Do=;
        b=B30M/mjsckSpHQPWDpAuYDRcyWITR7G9hikg2jrg8OUd3iLosiUWB6uZKshKS/AkVS
         flf9+phv4VZsja5hSwB8Au5kWbJlUdkQ2HWrZ2T1xNxQDdwrdCH5kBNDSxvyfNKIZ5UP
         pajOX0gklzOHWAE8P5/Pvym6nC1VsioINNQUWuR66s2YRE/D9meMU5D7Axtl+HKReBZZ
         gEXhGw4l6q4aDvSm4Pq5xQq6tnQdojHn2PIJvbU1JGpo9hePfosVCELVolv0+y2BOr3t
         lV65LXNSy8i4/8NGv5CushxOwcLGKWWjxQZEJxT9/0n2yM4pMrvAMkXH1QarIOmtEqXf
         USdA==
X-Forwarded-Encrypted: i=1; AKwUvByFi7Zz95ChpqkHM5VZJkjMMWnLGAqtmlGM0F10fS3WCU7k7hUq/tFjpnfODlgsN9gdr14B9xcHyRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLKfcSAAa4spWu7fRLIYakq8LGD1I1LABvxBktIHDWQgOoOruQ
	o8FjF3sGVQ6yIqFQCh2Q8e9s9XybMH5yLo64CQpgukNJ1oGwOHAErPD9TyVQnlZkU6o=
X-Gm-Gg: AYBFou3MKivmzKPCi7b7gqb65WGc9h6Rr3FDQ965NITcysyDJIW9wt4GQZb3/iVrKQs
	GMcV9F7HgJsxERVJAbXFBheGUoQDLjfMBhbY2h/pJ0E8HLmWivqDOvrM/NPIAhfKjqNYCRJkGXG
	Hxe9Kq9KjIo5Ix0v3ZWLDUSbSoJtnlrMIspKLjnkFBB8UWD2QqreOk5EaWcEV4z/oESZWGoSA5q
	Nu1jNUYBMC8u3TaJikL6Lm8JK3qdEtAk0z62IAUoj4VJyGrA/wZzHxaecBRutOzmCOCgLVCpHVu
	vC6OtO8zgF+bDJAW/iqV7n4RUEEivj8VAW0dr+Yz7GxUq1mxR24LewHq4lJBw+syK8hk8/fU+KY
	EanjpZthBA6/Rzh7VGY39i8nEQI71ywDBvFgF4BN6peBALueXGIVoh4/31Zik7NjK2w2DDNq+Mz
	K703O4KR5DRhzGI3Pcn7CpukMjQ9UVovmlCAErbVodfkr5bCTTbZQKTpdpF/pCSsvBNhDA1PCRs
	33w5Sby4Q6m8xpCg2k=
X-Received: by 2002:a17:90b:134e:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3ac9259151cmr5507879a91.40.1792156427018;
        Fri, 16 Oct 2026 06:13:47 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm4240433a91.8.2026.10.16.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:13:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: warn on unaligned compound zone device ranges
Date: Fri, 16 Oct 2026 21:13:34 +0800
Message-ID: <20261016131334.3419393-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A compound page of order N must start at a PFN aligned to 2^N pages.
Therefore, a range used to initialize compound pages must start on a
compound-page boundary and contain an integral number of compound pages.

Two recent Device DAX bugs were caused by ranges that violated this
invariant, but neither was detected by memmap_init_zone_device().

Warn if the adjusted zone-device range violates this invariant so future
violations are reported when the compound pages are initialized.

Link: https://lore.kernel.org/r/20261016053944.2579541-1-songmuchun@bytedance.com
Link: https://lore.kernel.org/r/20261016054914.2601510-1-songmuchun@bytedance.com
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4c17a892924d..01ced0553ce9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1142,6 +1142,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	if (!nr_pages)
 		return;
 
+	VM_WARN_ON(!IS_ALIGNED(start_pfn | nr_pages, pfns_per_compound));
+
 	/*
 	 * Seed the reusable head-page template from the first real struct
 	 * page. The normal page-init and refcount helpers must operate on

base-commit: 63562804f25cb5b6f5e4f5e3a9f0d1c3c6868596
-- 
2.54.0

