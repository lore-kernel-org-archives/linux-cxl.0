Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F364611DE
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867397; cv=none; b=Mgsr7NtwCl2DXOsrhT794RefW1wEuyoeZog6c8v51rwRKjcpIdHOyXWPlPp4ohDPwqSDWERH85IvEBeyAZWH/Ao0gdy6WvNuhdMz5zfCEobsjCO7wcG+sKbFKH78ZO6rWDl42wEqky2oGyO6Do43kPTnTa084Q1DptmZLcOU52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867397; c=relaxed/simple;
	bh=0ItxBjCWeeYPymcdVA6acSuKxkPEbVxqgc4wC6gsjtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbNk6VC6CKKP/jNzkAm2UUxsdg3xxtD1Js2ssUKWKwUsoSQlN3xPQkbr3NCszyAnZQgZbE6Qo45bE6MnMTorkZD+SGVeKop8FEBsUzUMu7lpl6fyBvMCfpqJ1vpeqNaCv4v94cWiCgpGYIRraiFvzEdUl6Wgbh2XWX+aRiYhu40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoP9xHAO; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoP9xHAO"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2250121b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867391; x=1768472191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKs0XTtJuJVxxVwPA++DZZZ+CNpKQV3ASKLDqcig+Cw=;
        b=EoP9xHAO0rYxjFEWm49LDOql92ADIHPDydG6mA13lMIu7LRbsPv+fvRTOtoIYWCRt6
         Mzk6V4IIjGHSm2VAMg2L6GDjsQUNFdLKu5P30XPaszNY69e5pLoOQpCIznPaKpxsHGFi
         KkoBw7OADIaF2k4G5GqZW8pMYwlo+NLaMqhXrgMYcrQvcPWVlMHQVq5gBa/n0cuJ0HaP
         9PCN7XFjxQ7oYkT33osAy8tr0Z+sZGEzSZjowbsCNNpGk81f6HEYnJ79msy8QopGSXWJ
         ntWDa5z9f/dY/TDOQw0ldt2d7ejLjR89hOoYtNrn2zOlLVpz71t7dGQuwRvzOquE9M46
         XHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867391; x=1768472191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKs0XTtJuJVxxVwPA++DZZZ+CNpKQV3ASKLDqcig+Cw=;
        b=qvXR11BCQI7uPUZpsPN70JWA+n2oHdyhZtIip1+OjMy5TXYoxrmlX9nxh77ecdAASf
         Aq+gWAQSKMQikLCTGmx1gr+ZyX/xI1IFFV0oM1oAvs1Ci7kW0YIktKaWXCbO4pAr0iYB
         MfMP7PTiM/hlqQEQuYJ/VMGBxk1P+UBAz9E127L4ba1aQdj1s5rXgn/iDArdunhzcsgO
         p9W7L2EzD/u09L+9VUfYdfaxiPWyjywWG+mtC0AYAZ9hRXw+EYJ954eESuvaUBACWSUn
         PWzyoGShYEeRV//g0lvIOrMWFCYxNxMHjFJSspddZjN3nhh/VPoTDIASHUOYvRJ7iz12
         s44Q==
X-Gm-Message-State: AOJu0Ywyruztd6pt74v9UfE7fQ4E5bqF7DnE5Z1R64vnSkIUZNf3PxWy
	4cC47cmEPusVmcgAlL9RTGbAUkADIv5OlEKdhJQc8ydu+YNrNlQNvg8A
X-Gm-Gg: AY/fxX4eJj3JEP3CayKgCAF0RSv01i6NGujPcCWC8YVEkEC4roC/FH+7StMmZR0HraU
	xRCkocHL9Eg2zvR4IvKu8Po54DpDKZto1uxpC0azI8+uImFbe+SwIFd5Fm3of2bBpRJ8i8NjkDr
	2+qyUKJJ0pAUlWEnozw9aPRDUsXCyfppFe94trDy/rZ/ULhEu1Wt7ynVfK3QlVS5SAoDnWZxN6P
	cB6EnBj6Iac+0+dOF8ouP1pP6W7740GSXk/6eu93yvoxkexnnKGNmtVObqaS8d4RvV9cyPgY6Ma
	zy/Xw7EJgBI9FVKOVLYrYlYzPDNzbu3rtNtE3XKZWttwYtRxrzzAFAlCZ1Bf2wFWZl87lqmfPXj
	5qGuirHsu0x+aiVH3E+wbbSvtvhpLTP+THHS3luwGjPUUSiug33FlCX1MqDXWsPJRYELbzjbWrA
	zorNjrmFxpUhBPapxrZzCoW8Sq
X-Google-Smtp-Source: AGHT+IG5cjHWe4nCIW20Z8QJTPxi/x38oc0S4rLZqrg1Nkqq2kgc6NrGn9A7eOqoxL6kXyUHFyaZNg==
X-Received: by 2002:a05:6a21:3285:b0:35f:b96d:af0f with SMTP id adf61e73a8af0-3898f94ca6emr4948333637.26.1767867390988;
        Thu, 08 Jan 2026 02:16:30 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8352:dfa:3b18:eb4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c49299sm73785245ad.42.2026.01.08.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:16:30 -0800 (PST)
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
	bingjiao@google.com
Subject: [PATCH v3 2/3] mm: numa_emu: add document for NUMA emulation
Date: Thu,  8 Jan 2026 19:15:34 +0900
Message-ID: <20260108101535.50696-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108101535.50696-1-akinobu.mita@gmail.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
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
---
v2:
- added in v2

 Documentation/mm/index.rst          |  1 +
 Documentation/mm/numa_emulation.rst | 30 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
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
index 000000000000..dce9f607c031
--- /dev/null
+++ b/Documentation/mm/numa_emulation.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+NUMA emulation
+==============
+
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
+Here, the abstract distances of node0 and node1 are set to 576 and 706,
+respectively.
+
+Each memory tier covers an abstract distance chunk size of 128. Thus,
+nodes with abstract distances between 512 and 639 are classified into the
+same memory tier, and nodes with abstract distances between 640 and 767
+are classified into the next slower memory tier.
+
+The abstract distance of fake nodes not specified in the parameter will
+be the default DRAM abstract distance of 576.
-- 
2.43.0

