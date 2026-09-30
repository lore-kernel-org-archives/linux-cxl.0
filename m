Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1B2743EF66B;
	Wed, 30 Sep 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762210; cv=none; b=VilcYpQ1AfZzNRYBllYV/izNelLORmlp6B/YQ7s84lzSzc5XqCqC/wkN+M3gUXbT2xcW0lXO/Uf8ZSA55HB7DNPov8utTEzeTn+MRWmPrsx+kCezOOuYFBIvHxX0c+qC+bX7ZLBP4XWBmJ90Z02C/+VAyPsoNtbn1lJNmYO4nDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762210; c=relaxed/simple;
	bh=9j7+Yvtkz1Y4BDwYCj8xrPyEWUCrRnxQ6Rz6jVv+sdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWhjyNbkSkyIO8XxLlAEh8zoWwdSH5GQ3QjECoBHRvAJZdIu+2CHJmBKLXcIg1BslwqdXeEm9lsf2cSZuBpgjyrm2+1kSMa+ypDSkjxG8vBTkK2WaOzfMPbNslH3k1kbA90nk/XRWaCjgKw/z7Q5t85rOASKcs5dFTcG2J5Jxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=crjW7S3X; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="crjW7S3X"
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <linux-cxl@vger.kernel.org>
CC: <djbw@kernel.org>, <alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<shiju.jose@huawei.com>, <vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: [PATCH v2] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Wed, 30 Sep 2026 17:56:27 +0800
Message-ID: <20260930095627.32616-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928073553.85669-1-zhangyili01@baidu.com>
References: <20260928073553.85669-1-zhangyili01@baidu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc12.internal.baidu.com (172.31.51.12) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790762198;
	bh=nCYWhngtoI586LzvHoYsr085I2qHPdLYXm4hoTYbNFw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=crjW7S3Xn92ccMj1DEQSpmCnBMhkEK+ndiX6DlWaoN4uUiwAhDcozkvd5cgxUeh1Z
	 RjftUIbkvnSz6cPTCQM2u26yt3pQuLquKruyC3kuktDNBBtmRp/CbFW6tedhGqvzrh
	 GixRgAn4dYqi4StkrChwdRSf24WNjVhi7xnSOrlIfRdRq6ipsJoTydYVetfwxegYe0
	 VSvauMraW1eEqbrQBK5Hun0QAW9e5RcLiPpr5KWXq8dfUEpqtAjNOJyKhDEHDCy4Lj
	 KjK5Zle2Mpko8Y6z7jzul8D6DjcmMj/n8V7NkljgNtWVQftXzC7HfjJwigp7FvzZuh
	 at4I9ibNWMEAA==

cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
device-supplied ECS config word and uses it to index
ecs_supp_threshold[], which only has 6 elements. A device reporting
index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
value is then returned to userspace via the EDAC 'threshold' sysfs
attribute (small info leak and wrong reported threshold).

The threshold count field also has reserved encodings 0-2, which
currently read as 0 from the sparse lookup table. That behavior is
not intentional; it is just an artifact of the array's implicit
zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
supported values, so rather than documenting 0 as well, make the
read fail for all reserved encodings and only ever report the
documented values.

Convert the cxl_get_ecs_*() helpers to return an int and write the
attribute value through an output parameter (u32 * to match the
macro), so that errors propagate through the shared
CXL_ECS_GET_ATTR() macro to the sysfs read.

Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
v2: Per review feedback, fail the read with -EINVAL for all reserved
encodings instead of returning 0, converting the cxl_get_ecs_*()
getters to an int return with an output parameter so the error
reaches the sysfs read.
---
 drivers/cxl/core/edac.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..fd6612dde7f1 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -624,21 +624,31 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 			       0, NULL);
 }
 
-static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
+static int cxl_get_ecs_log_entry_type(u8 log_cap, u16 config, u32 *val)
 {
-	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
+	*val = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
+
+	return 0;
 }
 
-static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
+static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u32 *val)
 {
 	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
 
-	return ecs_supp_threshold[index];
+	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
+	    !ecs_supp_threshold[index])
+		return -EINVAL;
+
+	*val = ecs_supp_threshold[index];
+
+	return 0;
 }
 
-static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
+static int cxl_get_ecs_count_mode(u8 log_cap, u16 config, u32 *val)
 {
-	return FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
+	*val = FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
+
+	return 0;
 }
 
 #define CXL_ECS_GET_ATTR(attrb)						    \
@@ -655,9 +665,7 @@ static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
 		if (ret)						    \
 			return ret;					    \
 									    \
-		*val = cxl_get_ecs_##attrb(log_cap, config);		    \
-									    \
-		return 0;						    \
+		return cxl_get_ecs_##attrb(log_cap, config, val);	    \
 	}
 
 CXL_ECS_GET_ATTR(log_entry_type)
-- 
2.27.0

