Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CB399365
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378924; cv=none; b=G3+xcf20qLLzzCPish+BWpXU9QS4QNl0poEkwoumMyJfz/sY4hcrwlvTy7o/XbiZRfumA8RZOrJzetVwr471mLtRLrkpVXs4RCvgUcJXHp8YILP0mH9WWmfRv+L29dtMdq68Uo2SUfcxZhy5M7qFYsLQwoLosxNmeJbzReqXeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378924; c=relaxed/simple;
	bh=K2Hj2XbaQYT6iNLE9zXZRM5ALp4XluEZmAssGObTg50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDc8mvYYea18sXuxTXWMx6RixGarmkQFHuWYHGtVQg7Z+QFXW5Et5YBNhhNBYPcvUWd9JQ/GeQBmHyoD8FuV1QjAaOTohogidc9ZOWbO7xDL4tf52w5aq6bXnajV5NRsPdbP7KgDx80jKdPIB2B8t08ks5uWxZNdkuHOtrdruRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d83RCn6c; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d83RCn6c"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cd43bd740so16055356d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Sep 2026 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378918; x=1788983718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1NZ9ZHcDjrngsqR4bYoxHCsiDBrtNaJ+UNE7jVFBRE=;
        b=d83RCn6c2PDL5qFN+rhrhrOtBL28xfd7bN+kpMiHlIFVRqotSS0GLfW/lU8H2VF9+V
         5eZlZqRnyH6iDr6gBSk9zanjlQm0CT0QMExuPl/WQJWg1k3cTtHHiPFYmqkvYi6rW8h9
         VMM47xDimO2Kjw2pAdVIji6LCLWSQbJ+W31lz8kbeg4WEtEFQpK4BtNJ7JEBJcCgj75j
         HC4z0MgQG9mw8XdddZ/kTmybjsB7d57JowBuCDNjF8VmW/uzwWKvNq/N6t5J/5mOCEe9
         iNBUh5Mt3deKGIsG43UXqoAXgLVvEni4TD2Q2iJJK6w7CFh9cVwCTIBWJGr+V+5QEK09
         j7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378918; x=1788983718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1NZ9ZHcDjrngsqR4bYoxHCsiDBrtNaJ+UNE7jVFBRE=;
        b=qXg4G/i8/IZDS/hjT4bsgbjgqcydYQXrEuL36m0sm8DCaS7ej6uXAZnl+gEX+A7QW2
         hqFR0xWyqbEKmAFtN2CgAyKImESBDd79mFp8zh/dkuR0PQUqddtUB7U+UEk/n1vXjkDo
         p0kqROolp0rhnO77wI98tHfQDi23/BOCiJ2yMDtp39PrduXujFka9K7w4q/1tfWYbzYL
         gTxhIBoaC8qEUeHU5Z53tvp8v46GIb7SA8NdPwv++w4GsOQNAFSFvpQh5vHKNwNlcMl0
         hj+BGe1culXgKSCBS8smwqrwLIg27IOpQoqjq1ubmbV/waVMHkWbqPm8zs5vi1OZaQo/
         iaVg==
X-Gm-Message-State: AFuF++kU+mBrAGh42k14DbCOeG7y7TThHUMyQN0zkDajQxEc2/NtORGo
	og+lJLLWtYy/DTQ69f0yi61fkqLvHhIWfHQIA1Obe8yB56r5cqh7iBDbPX/TyFDqHAg=
X-Gm-Gg: AYBFou0sBb3ynqCsOU50dosws9s9GTmQBnVielQu3zuDsyBfpe5H0rjykJgQBV5S+Je
	S3QXIiTmSTmiGRh6T5x8HGGXFHumqo0VgL3hW0Xw+AhBogJ1pTgT1UD+MsRbr6oEFi3g6yHZ1ew
	Gk9YGtnxV6BYhA4BpkfLaL0L31Ckyn9Vyn44StZXsTpJNt7nWrbKTxC5PYrelHOYuagsT1Pha9h
	1V8pVvIvVpy+FauCccy+94YXRlr2vPu4WP5IsvKlNIjeoVvI1IFJrgIOFY5IOjrCCoUt7CS7WgY
	f1zmLgC6BF6jXTsljGArVEQoKsT6IzqN81TAjJhjpAQJT1yBiAgGSAYNiKLQs1uauet1BR/P5LZ
	2pbLssaBMvlRfrXeio7NofSuYzpA43avKCDvpiNq7ybEEi11EeW8KPyrIpCfUaVxmW71Q2Ewf/i
	+IT7U8sEdPtrUcxf9Dm9OU6HWzcW+ubp7Uz61NtdjCQqOHdqlbcTj2lL3wSyjLRhA0rQ3Stsj3S
	Reer9JoHQZAd1CrEjpGIPE/iLy+bwbQUOAQu/4rusFOmc7ilq+QNbOh8yV6
X-Received: by 2002:a05:620a:148b:b0:939:6de8:43e2 with SMTP id af79cd13be357-9396de845d1mr170355585a.47.1788378917712;
        Wed, 02 Sep 2026 12:55:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f187083sm295334485a.15.2026.09.02.12.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:55:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH] mm/memory_hotplug: factor out node_is_memoryless()
Date: Wed,  2 Sep 2026 15:55:07 -0400
Message-ID: <20260902195507.88655-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A memoryless node neither spans present pages (populated or ZONE_DEVICE)
nor has an offline-but-added memory block still linked to it in sysfs.

try_offline_node() presently open-codes this memoryless check.

Pull that into a node_is_memoryless() helper and pull the existing
check_no_memblock_for_node_cb() helper ahead of the add/online path
so it's clearer what is happening here.

No functional change.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 60 +++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 226ab9cb078ad..d0e94057682af 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1491,6 +1491,36 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 	return ret;
 }
 
+static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
+{
+	int nid = *(int *)arg;
+
+	/*
+	 * If a memory block belongs to multiple nodes, the stored nid is not
+	 * reliable. However, such blocks are always online (e.g., cannot get
+	 * offlined) and, therefore, are still spanned by the node.
+	 */
+	return mem->nid == nid ? -EEXIST : 0;
+}
+
+/* Caller must hold the memory hotplug lock for this check. */
+static bool node_is_memoryless(int nid)
+{
+	/*
+	 * A node still spanning pages (especially ZONE_DEVICE) is not
+	 * memoryless.  A node spans memory after move_pfn_range_to_zone(),
+	 * e.g. once a memory block has been onlined.
+	 */
+	if (node_spanned_pages(nid))
+		return false;
+	/*
+	 * Offline memory blocks may not be spanned by the node yet, but they
+	 * link to it in sysfs and can be onlined later, so the node is not
+	 * memoryless while any remain.
+	 */
+	return !for_each_memory_block(&nid, check_no_memblock_for_node_cb);
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -2214,18 +2244,6 @@ static int check_cpu_on_node(int nid)
 	return 0;
 }
 
-static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
-{
-	int nid = *(int *)arg;
-
-	/*
-	 * If a memory block belongs to multiple nodes, the stored nid is not
-	 * reliable. However, such blocks are always online (e.g., cannot get
-	 * offlined) and, therefore, are still spanned by the node.
-	 */
-	return mem->nid == nid ? -EEXIST : 0;
-}
-
 /**
  * try_offline_node
  * @nid: the node ID
@@ -2237,23 +2255,7 @@ static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
  */
 void try_offline_node(int nid)
 {
-	int rc;
-
-	/*
-	 * If the node still spans pages (especially ZONE_DEVICE), don't
-	 * offline it. A node spans memory after move_pfn_range_to_zone(),
-	 * e.g., after the memory block was onlined.
-	 */
-	if (node_spanned_pages(nid))
-		return;
-
-	/*
-	 * Especially offline memory blocks might not be spanned by the
-	 * node. They will get spanned by the node once they get onlined.
-	 * However, they link to the node in sysfs and can get onlined later.
-	 */
-	rc = for_each_memory_block(&nid, check_no_memblock_for_node_cb);
-	if (rc)
+	if (!node_is_memoryless(nid))
 		return;
 
 	if (check_cpu_on_node(nid))
-- 
2.53.0-Meta

