Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817D2010EE
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364567; cv=none; b=s16gUb1uk5ay1dm1J45cB8d3RgXs/Rjccw6CacoQgnVnOVNuDvQT8GPCjvCdPeZEPeohoA7+xaInWB1A8YEb2oMUi06ZWX1Jh9/MWI5G9PaZoTYPSox7lp0Gn1D1wQFn5KDVN6lVZHrWc+k2VPUTHQbzVFVdEoSzsujFUsoDIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364567; c=relaxed/simple;
	bh=PYz5LGEPFVA5K7LEO2RLxyv5BGghR4alllEhsANbZNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ0LicpU1ludbUgdgLP9PeVEu+ZBUXIjvgoH9bEmbpDYfS/OwiOs41X6iTRg/x4xmI/P54LO99xD/otFr+fBDh1Hq9rwQZQFV5YWO1r74n8dGPVb77tQeJB9618uGNi2zvB/r/YKGuygO0GOlhBroX/qSF8yeFz867yzUFDtFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzyzXLgO; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzyzXLgO"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so1783516a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 21 Dec 2025 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364565; x=1766969365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a10/yyFUtLAmkdxBH2DQmudL6S0po5mlrbiaBGfSCN0=;
        b=KzyzXLgOkkFN/BrBIaREMCIni9v/MAwjGrTVgZNE9jOOWgooRbE0AmOooQT1PqE/Jt
         4b/c8Q6TMLOoGO/WzL0R4rcbg6vn/AksELyRhosB7qAkVosRVIBe/SAXV6KBuwaBtR+8
         IByHlFQVmaZ4JgxyTtMwrHZzb+sAcU1kklVpeuNuSyS3a7vgMNdda2ylL4fOi2L/aoT6
         dnN2BwR2UeF8I9kkw5FP6kQ6gUiuGJdxwrGcEPRboFniw8+rbyZOHu6BNeZw/5pZlo5z
         uLRpJbcYVXF94I7sWw4S4AMH1vVsfQEsT+zqZMwaG2MrbQ+Ce+/1kNsbvyLbfKqE+Hta
         0+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364565; x=1766969365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a10/yyFUtLAmkdxBH2DQmudL6S0po5mlrbiaBGfSCN0=;
        b=uEICkFwZP4y6hAu/h/+N8xr5DwpnTSDqe3RmRley41WNuyVaboKWsBqPQIGLUOdO6q
         zEApgNIq314s7d40404BupWW2BvHB1WsV/a8tJa7QOVQfSvyWR8QMgn8UbWsj7HbCxTQ
         LnCuA/gvZWZDjPR5/RdQm9ifxyRSV4AtRWOHoQFD3NN3pWeRQZuWUp+4guHBSEjT/O7z
         S3dA7o8dK620RG7tzczDn33lPVB3fdz+ArfOtSUtS1gcmCVNb7+997bPhfvOB5g9e6ZO
         xoS7/610gawitkz+/w+m67xav8q9lKir9CToUzQlnJGVutEMAmQpMuPEoU0wfEOdeUsg
         bxcg==
X-Gm-Message-State: AOJu0YzFXKqyXPwjHeJfu3rmLXEIVSa9dFdbviodP4yE9mQGFb+NBW7O
	zp3ZFaDp2QwMtU+qeIU/CaqjuZ5CENnkOYBBrCGxD4W1qcEediPVGDr/
X-Gm-Gg: AY/fxX7VldD+DdSK2dDWJcbrvsYSej/RgnNXamB8PYq8RO3VQfheE6NdqljlWUvdwO0
	G955Cn4/xU8mAZIb16ZSc/Vihg3Rcgcc0yLNKjN/w4ZZJjPuMDz4c818OjNLXa/9d28kXKPGm8T
	G9WXtyH5u9svNHW/2GYue/sbMtIU1BMykbi0GC0zNEN9NkY6EoLqamZNV03/y8c+jEJ5Xq3cNE5
	BsyKOVpPi47/tkCvRjK5qWY/w8XDGwd3zMXaO5tA+vRMS4GguljjRfNpYKUCRzgoTzsQRTyPu+F
	eVu6yso+dUBZ1T8B4r7swBzdrG1S4VoJD7lLMv+xVcwyBUqI7Ux3nYvgiH9myRcib0Hvj0p3rVe
	hANz8lM9qaH3VsvHjdllluc+3e3A/wDvcDMNkgqfrHkGX/kzVDXmfJQMj0W4ZTywoDdippnBw6T
	vDl3+F2LHRlxsnaCTUNUaShQO+Pg==
X-Google-Smtp-Source: AGHT+IEMm5PsORF6eBK+myRm0k9fs0suEo4RqzGxdu08t8Dj4rsOQM/w7YKy0ZJXO7xvr+1j5f+i6g==
X-Received: by 2002:a17:90b:1fc8:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-34e90de1f19mr9151046a91.14.1766364564695;
        Sun, 21 Dec 2025 16:49:24 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:df7d:b611:ffaf:6d45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm7461832a12.4.2025.12.21.16.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 16:49:24 -0800 (PST)
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
	surenb@google.com
Subject: [PATCH v2 2/3] mm: numa_emu: add document for NUMA emulation
Date: Mon, 22 Dec 2025 09:48:33 +0900
Message-ID: <20251222004834.10539-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222004834.10539-1-akinobu.mita@gmail.com>
References: <20251222004834.10539-1-akinobu.mita@gmail.com>
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
New in v2

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

