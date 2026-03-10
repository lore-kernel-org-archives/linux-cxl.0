Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A73A63F4
	for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110498; cv=none; b=SaU0AwvJ8fcSfMORi5HgDz7Tam+Pdphao8UiOsT/eBkJMHdHgJ7QcunSqI3bcZ2fCf6u75kzxQZT6MeoAQcXHG1XLHWeWGu5162026YgvO7wkzBA9FNMIm+o4g/KdBx/REdmjzhpBXY7tYSECUuBw47OKY7iowgIA6WWXGclTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110498; c=relaxed/simple;
	bh=PTz0ktU0g1jw0+Ux04KfN+p+7V23IhKHyvbDuUyEEug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxD/wL3ARt9Ik5CadGhj6waG6/sbdSFmwF/T5w9gahltbh4dXzbQHKFiKcWNwlx2JGpLFXZ/HC19GKFQCuLOrYo/Ofvqf5Bj7Xro1sMVm6A2lGtKjD+nCMZy9zmNy0AshqDX6jJUlcmSMMjLl1s3j+HEch8WuTgb9C4j8GoESb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KaffO90t; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KaffO90t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773110493; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=JXM8NFuOj/au553yR9Pai/eMJh+iIz0O7glpCZSKU+0=;
	b=KaffO90tu2YjokTe8uu28Nk4THuTECNFuBLVw4460wRJHdDEik31AhJ+oAnpfp9qIQJCW2Fg6k8b3vnx7T5+XJWZA/PeovlQY3oEGb0l0E0O6Ih055zXLS+zxqInVR3QTzwmmFR+55w2FV5NdPDp+UNe27KOg5jHG1il22Pr6e0=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X-eASDu_1773110492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 10:41:32 +0800
From: cp0613@linux.alibaba.com
To: ishal.l.verma@intel.com,
	alison.schofield@intel.com,
	nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [ndctl PATCH 1/2] ndctl: Fix missing key_type parameter in ndctl_dimm_remove_key stub
Date: Tue, 10 Mar 2026 10:41:01 +0800
Message-ID: <20260310024102.25682-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310024102.25682-1-cp0613@linux.alibaba.com>
References: <20260310024102.25682-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

When fwctl is disabled, the following compilation error occurs:

  ../ndctl/dimm.c: In function ‘action_remove_passphrase’:
  ../ndctl/dimm.c:1030:16: error: too many arguments to function ‘ndctl_dimm_remove_key’
   1030 |         return ndctl_dimm_remove_key(dimm, param.master_pass ? ND_MASTER_KEY :
        |                ^~~~~~~~~~~~~~~~~~~~~
  In file included from ../ndctl/dimm.c:25:
  ../ndctl/keys.h:51:19: note: declared here
     51 | static inline int ndctl_dimm_remove_key(struct ndctl_dimm *dimm)
        |                   ^~~~~~~~~~~~~~~~~~~~~

This patch fixes the issue by adding the missing key_type parameter to
the stub declaration of ndctl_dimm_remove_key in keys.h, ensuring the
function signature matches its usage.

Fixes: a79375a9b0cd ("ndctl: Add  master-passphrase removal support")

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 ndctl/keys.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ndctl/keys.h b/ndctl/keys.h
index ce71ff2..b60c209 100644
--- a/ndctl/keys.h
+++ b/ndctl/keys.h
@@ -48,7 +48,8 @@ static inline int ndctl_dimm_update_key(struct ndctl_dimm *dimm,
 	return -EOPNOTSUPP;
 }
 
-static inline int ndctl_dimm_remove_key(struct ndctl_dimm *dimm)
+static inline int ndctl_dimm_remove_key(struct ndctl_dimm *dimm,
+		enum ndctl_key_type key_type)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0

