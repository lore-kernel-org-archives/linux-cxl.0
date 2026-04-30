Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB443E487;
	Thu, 30 Apr 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566474; cv=none; b=EShHY9sDbtLPzoERDEjAYL81f+EyBQ3yB/3W6dtdXfRJY1SOxL8rE7UgLQpYgNKK/+t02Yn3z0O3QDPC6oGZ9Ak9H1sHSue0C7t8VbaR90YY9cmA64WG4e9vRBxzGjryCWePQFgyQSWQjl2PU23NUDp4PCKsBD47JfHOfPfRyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566474; c=relaxed/simple;
	bh=SV4fG3AmKvvNwe+nhrkm5kTMKiYO/+3iBY3yXw95w48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g352N7bIOAT1DpOl3in+C17Xesy74neajM4PfG2BlEqgGcWlUCq0aM8CKCnzfzgFYiawvoNYpBTc5zfNjenANN3AFBIv2kNtoMGpavDA5stQEaSag8C4EpZcH8pNCpHgcyGe7D92gNKl9jB4H24BifURdSvy4rPbhy0UmutrSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UgLXvOY1; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UgLXvOY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nY
	09t2S96S1se8yxEhtEIeujcNEhDHbYJUoGMogUaEU=; b=UgLXvOY1pGPBBtMrTC
	hXLlWH9MrJLHn8WJKu+cQGKLakbFsP9anaf0DUuPLHpTuutcfADQtCWLKtLXlftH
	yf/Xzu0X2Qhh/bam2ibdekvjUTH1sHLsJl6r+14J5T4Or/88EZTt4XMBKuaF9G83
	2eAEo5tsw8goOM3nYuUPwSRvs=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3k9_ogvNpGIRXCg--.51074S2;
	Fri, 01 May 2026 00:27:20 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] cxl/core: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:27:18 +0800
Message-Id: <20260430162718.43536-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3k9_ogvNpGIRXCg--.51074S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw47ZryrurWkGF18Grg_yoWkWrc_CF
	1xuF48Xr4qkFya9asruws7Ar9Y93Z5uws8uwsYga4avw1jqw15WFsI9r9xtrW7ZrWrAr10
	yFn3ZryS9ry0kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi_M3PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwky1WnzguluSQAA37

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/cxl/core/edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..a374e8ebac87 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -717,8 +717,7 @@ static int cxl_set_ecs_count_mode(struct device *dev, u8 *log_cap, u16 *config,
 		return -EINVAL;
 	}
 
-	*config &= ~CXL_ECS_COUNT_MODE_MASK;
-	*config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, val);
+	FIELD_MODIFY(CXL_ECS_COUNT_MODE_MASK, config, val);
 
 	return 0;
 }
@@ -729,8 +728,7 @@ static int cxl_set_ecs_reset_counter(struct device *dev, u8 *log_cap,
 	if (val != CXL_ECS_RESET_COUNTER)
 		return -EINVAL;
 
-	*config &= ~CXL_ECS_RESET_COUNTER_MASK;
-	*config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, val);
+	FIELD_MODIFY(CXL_ECS_RESET_COUNTER_MASK, config, val);
 
 	return 0;
 }

base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1

