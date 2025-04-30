Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758022882D0
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036691; cv=none; b=ZWaKuv1iGR10PJ+JSC+mwJhljKiLv5zvQKldvUPjnTvWbvurZ3UA0uQBxIHL0Bgj13CIHLgRhUTLIv10PDodoC+/oH+PkavnzLsRzHnhuP7aOGxRtwtnvyqx++svnuEZJUF9nX/zvhQw8a85L9QEsSZzyHUm5+6pIjxRrm2ig3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036691; c=relaxed/simple;
	bh=iirzwEeYoxznZHJe7vcY27yiljb3AwlzwC5WRq52rLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D85e0f9TolVXLsuygR92HPh9MOCn1BVZ1mweJefTQhey19JGNHlGsrE+Igjcehf6V7Qomo9ndf5caw6M9Se8+UNbQ+mdJ39BI4J2FNEwTXbB7miGOMwwPS0aoD/kuRl4EF0a/gHuyKG4tl7A5tVOXkUYKjdn2DMb+K9YtF/BMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hrnPfHha; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hrnPfHha"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4775ce8a4b0so3085401cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036688; x=1746641488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A39YiB1Z+l6GCsVmrhqArPxiVLmwBB2VQEqP9tXT4Ig=;
        b=hrnPfHhaQAzbrxbEaJMbYQ9nSMkwK3qabvTrVWPR51RX9eV6xdN4LMIrJNXRu3aLd+
         R/lU/gXZceDxMVeebN9N0tpY6DyD92BBpzVIuAP61GPU+efI/QzI8VkZpZCv/AP3Lh5b
         OM3n4RituY+VnxqBZDUgD3jEamKW54F8pMzMd6PIhVonpvEhqb7AZJisAsnaLVJowC0Q
         l3OmCs0rkOV1GZo13/lJCLsdNbJ9RRJlLNlsc0PhUq98X9gx/AdFV2xYiolpTdW/l3bf
         V2itiyeNxsAwbWhgNPTSJ15yN7myDiwjkpgYLzCXsyOpQ1oq9cUuzogUaAi4y9HUfOUb
         9DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036688; x=1746641488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A39YiB1Z+l6GCsVmrhqArPxiVLmwBB2VQEqP9tXT4Ig=;
        b=RWpPzV18G/3syAV0TaIhWjoWh9PT8hO/U9zU8j0oycOjXLfI48Dbnl9anvrsCqIJuB
         vRMvleOf93LOjK71yWDeuVjKzzWKBUT6D+3LukH3EZm/F+G06g4/ioPmwMTOCoVVcdrb
         IJBctpjDQJzjRQERXRlv4PxB+bWL7S9dMbf7maIti8tKSPfoyhRbfiOOb28EVc3IOMT6
         Td9xSzNm0ZvfoEj4KhiruBsHoC+XxFWnTHPYWhlqHPHFoKLu2/TTrBmk8n7vOarQZysZ
         KbwbGjzq3AX+Mi9oH2nqXcsIrsgfVOVdFLfGW6nJwTxiUc0q3v21hfxnN5rRPcLo5HH6
         wJaQ==
X-Gm-Message-State: AOJu0Yzuon17PQ9kv7kJIsbgepbdpNHL6MoLEj9QanfDrm8eXL3duWXd
	IJU52zBX4h2r3gXUAzDBSRSQiGJ8dhp9cE3ym5rx9mqc4zuYc5hdC+SalILTg6U9vqQiV87C112
	z
X-Gm-Gg: ASbGncuVlps0Uc0cLqqOE3RO8nkrNlbqJS1orKZd9qT/RLiJWCFGGO77DUzdB3F3pkR
	g7vJterGWNqSNbkK7HMkP8iCUWG0jjLqA4B6FU4WcibzdC3obvqO4/Qu4ddWfT/wV0rJmUTR6Ax
	4E7rd1RfY0UuMlogIlmvg1m98Il/IgRsfBJOfuLnY/n/ZZ0aRCN+krYhTHoKjkqG7EYRU6mClD/
	fQ16SJ5zODP16ce2glNErJ4tS5fa4Qq3B0yjrOueAbT1Oi/Z1t52zQr/x7jsvkjlZFttfu/W74e
	rFmRl4CCoNhd56ukD8xLPaXQbZFrClv+wRXAOw5vMcRDCLeI1b/KY42bpNAHaeJK30q0rWN1uMg
	XdFEr2RKj4/jy/VdFybrmAvQuaBdb
X-Google-Smtp-Source: AGHT+IEjj5fRlO+G4AeYsj9CnMTHgu74PV6/AnY9a7Hyw1zOc1l/ean48c9t9b0uKuyRkKfZm4P+pg==
X-Received: by 2002:a05:622a:4a17:b0:477:644a:72ec with SMTP id d75a77b69052e-48ae7a20044mr4433871cf.13.1746036688396;
        Wed, 30 Apr 2025 11:11:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:28 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH v2 16/18] cxl: docs/allocation/tiering
Date: Wed, 30 Apr 2025 14:10:46 -0400
Message-ID: <20250430181048.1197475-17-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Carve out a space for folks to explain existing tiering mechanisms
and how CXL capacity interacts with it.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/allocation/tiering.rst     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/tiering.rst

diff --git a/Documentation/driver-api/cxl/allocation/tiering.rst b/Documentation/driver-api/cxl/allocation/tiering.rst
new file mode 100644
index 000000000000..623bb23088be
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/tiering.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Memory Tiering
+==============
+
+todo
+
+Memory Tiers
+============
+
+todo
+
+
+Transparent Page Placement
+==========================
+
+todo
+
+Data Access MONitor
+===================
+
+to be updated
+
+References
+----------
+
+- `Self-tuned Memory Tiering RFC prototype and its evaluation <https://lore.kernel.org/all/20250320053937.57734-1-sj@kernel.org/>`_
+- `SK Hynix HMSDK Capacity Expansion <https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion>`_
+- `kernel documentation <https://origin.kernel.org/doc/html/latest/mm/damon/>`_
+- `project website <https://damonitor.github.io/>`_
-- 
2.49.0

