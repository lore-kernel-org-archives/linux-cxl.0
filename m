Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3F37BE8D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292138; cv=none; b=eSQL+d+l5kFRm9/4a5GaI0nwSvJfP0ldjEqZKz4jur7O67wjPZ4bTlsWKrXyQRx3ZeMr13lzuqgtDeLBcj8IVl/zsQFbyX4Ppvr3w8MEmZIgsNDNSNtuBE2IMRJhLmuEiYOc0BkbVkL/WyQUsjiSD/XVGQqCq7FnY9TqEfvsuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292138; c=relaxed/simple;
	bh=UwxEPyduWf6Cf4EObr2HFsSLyyogC0TXzqPXXd0TF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ4AsBDpqAbD4Zn34P//N9H9ssemvvE+ll3dd618K8jjuHrFx1avi4R4MJm7p0us4SxVLPE1sTXEX0YNvYSZSaQyCrilYoPXT31If0c2ywzd+zvR5GExQCRStR9npkHMKu+5ww3r1io3XBwIV28JCObRDUtSNfd1x6qwneOHxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbz34y+i; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbz34y+i"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso5166779a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 00:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768292136; x=1768896936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoxKrGhyaE4VBNdB4C6I31y/frdPcxDPShYvaQtOSlE=;
        b=dbz34y+iwWauQZYp9WUx9WDsk9ubXo4VmRCjdyOxIRNJZ8BSX9F71+XtOkBLWqOMbq
         jJKSjpzSWI6BGQ7bKas8na/gZcTdVycbrZDRqJtNVzIvOCmpzo8po2MhtdjzgkFeGGft
         V793OwozaCxd8dJr+Y4xsuijGZnfKYvARNPcNUkWXfXaKYESzJtZJU4dPNKlvPNXYscT
         q90EfTXIVpQ62CUZtH6VuL6FWrHPX2JPJ15ucOIEqKqsCplbLYPH57/gB/XqTjYSMGVo
         yImB8DJ1ePXQkFuivLyrGAiqnS1JYSM4y0rzHhluZSCz9b9FCumgV37Edl7Spiy5KyxH
         QD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768292136; x=1768896936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoxKrGhyaE4VBNdB4C6I31y/frdPcxDPShYvaQtOSlE=;
        b=snYdNMCyf61aWPqvenhdXj0myEVpEdZ66osPiXU65/Xrcyb/IrUsu7xQLItpfB67Az
         xBXikCIDp37cJvCVnt9R/LtkRoDioLlpmdwqJv9QlS/CDjyDFUIgQ9J8ZsuOiUQreTGW
         +L9m0d6TXkOqm++iyZhh9ypiGk8r44aM9lCEMhQIkkAxLzBoK7ObWUMh1CrwlWORotpI
         dNYvbuuGLoA58V2Q3s9TMi1r+oq3wYlaNVh7bZmedDWKMzMKtRC+iHe4mqfu7jfu3v4n
         FGL09e9nrX1ZiNfvIQPjRGV70UBGy00dd7VpIy194Igl6Zo/6D5DTO2rxsa/jWriX4uK
         P65A==
X-Gm-Message-State: AOJu0Yy6kZB06x0VczXuzr7lervJlkkNqXNytDylnjx3ZCdympEPP+zH
	QA7bFWmQUM/M1yQzwMvjffgBzxHDjzth9549hBtc20j1w08/6FjZfhZA
X-Gm-Gg: AY/fxX42+vQdxwzj48/dtCTSRRUes5fTyRwIkqZOPtnoMZYN41MR4hDsnfj0CybQCHF
	aoA+H9ukjulRrh8wL7wYbZac2OeIQg5TXz1jUUoWCUduJuHE7C5NlnXmaugKJx1GR0Q2pjN8ZG2
	dokVWNpL49IVKE1p3xwwBTjIOng8m4Zhj5Ox2Q/uZYvr1ZsCQzuHkOAJ8YLb4iEuN+UHNZaBghc
	7FMZKSkO1uDqwZOeNMURl1pTvpuoPtK3J3GY1mmEwocgHueH0+bAgQTOE+FZnHSePBhlYEo+eyh
	l5ibweWfSjTOL53w67Qgv0zxtGMVw/yHK1Ny49y65i8ZGDSws9C+hP6fdJnQpIbfaoWvcDSW9LN
	3XyJsIg7F5VzmttbjqbgbUjBNMGq5w3YPfCKqJmLqSnc0nUfBIuSkRd0VnbnU1Ml0YDnyYPGAYP
	Eqq2kHXvjkxFNIxunK2ThR685YBA==
X-Google-Smtp-Source: AGHT+IFI8tZbu3gKqGSLHJvoaf0AjOxH+SKwPXLRujBsbcbN09R1JhQxlQ2NzJCr7k+pKN2Pqi467w==
X-Received: by 2002:a17:90b:3c06:b0:34a:b1ea:664e with SMTP id 98e67ed59e1d1-34f68c4d4famr19778021a91.15.1768292135720;
        Tue, 13 Jan 2026 00:15:35 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:180a:3788:c683:2f64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350ff05492dsm657199a91.3.2026.01.13.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:15:35 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bingjiao@google.com,
	jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: [PATCH v4 2/3] mm: numa_emu: add document for NUMA emulation
Date: Tue, 13 Jan 2026 17:14:52 +0900
Message-ID: <20260113081453.8293-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113081453.8293-1-akinobu.mita@gmail.com>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a document with a brief explanation of numa emulation and how to use
the newly added "numa_emulation.adistance=" kernel cmdline parameter.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
v4:
- typo in abstruct distance value
- add information about supported architectures in numa_emulation.rst

v2:
- added in v2

 Documentation/mm/index.rst          |  1 +
 Documentation/mm/numa_emulation.rst | 31 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/mm/numa_emulation.rst

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 7aa2a8886908..7d628edd6a17 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -24,6 +24,7 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    page_cache
    shmfs
    oom
+   numa_emulation
 
 Unsorted Documentation
 ======================
diff --git a/Documentation/mm/numa_emulation.rst b/Documentation/mm/numa_emulation.rst
new file mode 100644
index 000000000000..81f15ea68022
--- /dev/null
+++ b/Documentation/mm/numa_emulation.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+NUMA emulation
+==============
+
+NUMA emulation is currently supported on x86, arm64, and risc-v architectures.
+If CONFIG_NUMA_EMU is enabled, you can create fake NUMA nodes with
+``numa=fake=`` kernel cmdline option.
+See Documentation/admin-guide/kernel-parameters.txt and
+Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst for more information.
+
+
+Multiple Memory Tiers Creation
+==============================
+
+The "numa_emulation.adistance=" kernel cmdline option allows you to set
+the abstract distance for each NUMA node.
+
+For example, you can create two fake nodes, each in a different memory
+tier by booting with "numa=fake=2 numa_emulation.adistance=576,704".
+Here, the abstract distances of node0 and node1 are set to 576 and 704,
+respectively.
+
+Each memory tier covers an abstract distance chunk size of 128.  Thus,
+nodes with abstract distances between 512 and 639 are classified into the
+same memory tier, and nodes with abstract distances between 640 and 767
+are classified into the next slower memory tier.
+
+The abstract distance of fake nodes not specified in the parameter will be
+the default DRAM abstract distance of 576.
-- 
2.43.0

