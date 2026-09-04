Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87037A848
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518421; cv=none; b=qLkuWbke4g5bLK4i1N4tN3kJ8bOMLoyzWFg7pjiNaZ+JgG9bvxGP1LnI7kZOSEHdxdnR9AYMgTAfP0u+79y4+3/EoRsVaeOP3dRteVIl4nMKt1HBtf7eniR5L+wxxv+risKqEhn8b5gXFQBblPY4gFHrPefmBton4XcW9lApe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518421; c=relaxed/simple;
	bh=80EQ+j08nxlitM2qb+nj2AYVXhhWaOPF3lwiA9bPMhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vs4XQ6g4p7QHTHYpEkl12KZ76h7yboS3U3qj2sjvMWUdrEWvQTHksZV6kFtWOaY0XiavTQ95/cqZqnMlWMKuomJfV+NwwshDhQ8je3zqXhj8Cf319NImNKeXDSE/KNTQ10URm0IsEch8nifRiIJLoAmZ/3TFJhQDcKzvqcYYJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWJtqXGg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWJtqXGg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-395cf2535acso938890a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 04 Sep 2026 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518420; x=1789123220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VsgyU3plemw9VdUhVnU63XatTfyzeFs9qQpNpEGdpU=;
        b=iWJtqXGgYgtabsarZf5IxwGyMOrNVlUbrC+OVrQIzUMx0KJmanyrrZwZ7n1P24jIVM
         lDW5pimSpCkrf9odpdVtsZ/E+y/yWjmAKNmmQgZUnX3pJwaR1imeJsugDx6zVVhbWp8r
         vIsYFXaSSYoy5W5EcoO9oawDyGsjEgoRyJOeRvaaqXWQorVe8clQ6byBetSYDoY5HLvj
         swknlYzUY5srfAP6IQlV899LXCXEAzQknGusMCznCKGM6N5hRUr43VBQRC8cUle4O2JV
         WrZi0ZQeHDChcrlfHut8Nys6ZrPatgXQzTJTM2tqFUdPOmvsJlkjRZSSwBsAlTUBysie
         2X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518420; x=1789123220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VsgyU3plemw9VdUhVnU63XatTfyzeFs9qQpNpEGdpU=;
        b=EVUS4LD9RmWiwA2gQycqg7h1qQCb18v69vcrFeC6bD3xu+APnDjI47BGxDE4B2mBlg
         ASpAUefBkoDMOcn4FC7kNcR6OGcIXyjWG0ZdRte70kvVzRYM+1j94VFtJCFkWbmEXzAG
         EbNipJMNq1IBUTerEO8+OlV8mTprHmSOTczJRK4mXD93NeZHAfkJCzgmidioQeA38PyQ
         DpNisd88wbE1xzEqpLhb0Z2ZZMtck+v1tsdvzEThJWA/8v5IXsVo+3hJTsY5neU1Urbr
         jbSYm6QwI2LpJdflixmuH318xwKAi/N2A6uCKn3poHNfLyIGKtZE+F/MTucLPBBC9tR2
         umNA==
X-Forwarded-Encrypted: i=1; AKwUvBwFaeaC6VDaSHBjNI5sPcysb1Xy01s0x2DcnH43BWtlUaZse7Yd+149f3oqgHSy3Asupiua+YaVxrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kn5Lsq6UatA52VBB+yJ9fpsyYeDbwRQSlTwrnBjXaQVcIdptTs
	2I7KnLvQCN99qJJTAueAoHgpzt6uhKBlOl5hpZkpBr3h8UNXutEBX6L3
X-Gm-Gg: AYBFou1Su/O/r78ur3bjVe4KiXHlR3SGKEB/kxCN34g1A7vje3gtV+/mX/gAkCUGKEr
	oNJ1yvOjJ6xepKqBH+tv6gnBqpvwbTosq9zysfec5robln6r5D9DzKSKgYNRKm/vuEF6+trBHvM
	25u4fxMY6a80B79KNppJ1d9QOEjDtYXnytH9x1hIspaIFudwgVux2t5W5wqkhccJlV7UnTzM/5v
	JbPq7tI15C9qw/FMIVxEhV/qRqormySg22V/iSyJjQ7Dto9b3Fz+GKDPLHJx2yhEQGChVUh75F0
	aZwReZZ4GztEWXREnd80DhpJpAt6pzQGKzwiwzSEiQJMBMKLvJGYIo6fcHLkZF/iq5s/ejZ4Erj
	keA2H5BdRV7bVK7uQLQOQlbz1zauBWDB7nCCuQAY8QxOsdAhehrtEChFTzz5N2BwKj+g9cdrnL8
	rmawOxpmIgWdMAfYLdGI00yp6gh7MQVdXbl3l7ctOkUFVrM6mzzZIhNmEKFqKq9jLLkUF0WYkYK
	fpkg6LZ9C895PI=
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr13892803a91.10.1788518419735;
        Fri, 04 Sep 2026 03:40:19 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b6036fcsm6112649eec.20.2026.09.04.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:40:19 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH] tools/testing: fix typo "occuring" in comment
Date: Fri,  4 Sep 2026 16:10:12 +0530
Message-ID: <20260904104013.11549-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "occuring" to "occurring", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/cxl/test/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 7b756000a1a6..3d8a6d2b69d7 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -246,7 +246,7 @@ static void mes_add_event(struct mock_event_store *mes,
 }
 
 /*
- * Vary the number of events returned to simulate events occuring while the
+ * Vary the number of events returned to simulate events occurring while the
  * logs are being read.
  */
 static atomic_t event_counter = ATOMIC_INIT(0);
-- 
2.48.1

