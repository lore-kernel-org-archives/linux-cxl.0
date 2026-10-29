Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.202.115.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279438;
	b=Eay+dc03GujM4gIir5D8ppgyzjchXuh89V+Xdr76Zkgp7Pf3Qsy8X9Ywhzx+GbX+rvE0
	 ODsENEu/mvvqxFa6zcf4AfX83u1FbcyCIRP88r8DOiOqa1lc6pHAJ4rz/Yy5PtfR+AQji
	 G00r6pOiAPFeOGm0d6AirZMlioXU1A020a5zbtRVuLtLo4lq0WfbYeu0eoomFyY8jERst
	 h4XOwhoGzRMHBigYIJj/CRhFKqOdTk7ZlH30UoiFjB/lT0c234rG4yJVOTGmqA+r/yOzc
	 +mcJONn1Ngd21EkbVj3docEb88M9ko/0xSEpi6srU7S5W/0Aui2jKxFB+gn4c0QPHOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279438;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=Wm5M22Gb6vhRgb1kaAzigLTQLwmCID5pqNENHUh+A70=;
	b=ZZ7k4Uo8lX80e0T+KHU+GDQpip1D33AgtQYmEonUEdGi4BLGY1UTLGTUHUYzkPETJQ24
	 XhYhD1YO6pRb9+g17PPgpF6r5m8qQRd4QrSpyjo067C5mS9SCmZFhmwYrXrKG1D4OihSm
	 LbKt4fk6r1jcs2R95cMg7icDp2UQjerBbddlHjXn3oEGQIP15xOmB3yNSG5dev5pT0ofX
	 bkn0PXDyw0xKnYotJGKlos1uiKdfZgesc0FrE3Xo+nrLWRQ3kfAqB+SavLCR0FvcfL8pE
	 NzkNYmAL5jmGAlGeTU6wzKk72jxUJi15wm5lIWIAlomQJ4JH8pdyJOthSWxFMZffwoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=XmtxnpM0;
	arc=none smtp.remote-ip=111.202.115.100
Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 21C2B606A31A;
	Thu, 29 Oct 2026 13:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C2B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=XmtxnpM0
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <jic23@kernel.org>
CC: <alison.schofield@intel.com>, <benjamin.cheatham@amd.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shijujose2008@gmail.com>, <vishal.l.verma@intel.com>,
	<zhangyili01@baidu.com>
Subject: [PATCH v4] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Thu, 29 Oct 2026 21:10:13 +0800
Message-ID: <20261029131013.85983-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc12.internal.baidu.com (172.31.51.12) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793279426;
	bh=Wm5M22Gb6vhRgb1kaAzigLTQLwmCID5pqNENHUh+A70=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XmtxnpM0TQnNTXKkOUw7x4i28FnsoNqLxWdBaRZWrhZUB/RDnaf6rl0+V/C5Ymw5X
	 yJJUgi7ITBv+1KrMQdfC4vW4xADDVUtvhjyBBQPdUERVMyNWKp1DrydReDNA0C4s27
	 bUr6p+OBqZW9sS4JLGd76ckFxN9MLBN2M+ZM/EknVn8xcRdX3xU4yiaVzKQ7FKxRED
	 XQJGb4ZGhKNJutJPBfGquG6slPezq2Z7BaW5jaCK0JC0fbmkHoo4GFEnUsycOnEkCD
	 VBxwhszK6aaPnd8AJ/G0CaBV23Egjp3LU8/74QvMparCQqpd54nQq5cg9R2Xb/LNDV
	 kK8YXBTu+dVqw==

cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
device-supplied Error Check Scrub (ECS) config word and uses it to
index ecs_supp_threshold[], which only has 6 elements. A device
reporting index 6 or 7 causes an out-of-bounds read of adjacent
.rodata, whose value is then returned to userspace via the EDAC
'threshold' sysfs attribute (small info leak and wrong reported
threshold).

The threshold count field also has reserved encodings 0-2, which
currently read as 0 from the sparse lookup table. That behavior is
not intentional; it is just an artifact of the array's implicit
zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
supported values, and the write side (cxl_set_ecs_threshold())
rejects everything else, so a reserved encoding can only come from
the device reporting it. Rather than documenting 0 as well, make the
read fail for all reserved encodings and only ever report the
documented values.

None of these encodings can be written through the sysfs write path,
and no device is known to report them, so this is hardening against
a device returning values not covered by the spec rather than a fix
for known hardware.

Convert the cxl_get_ecs_*() helpers to return an int and write the
attribute value through an output parameter (u32 * to match the
macro), so that errors propagate through the shared
CXL_ECS_GET_ATTR() macro to the sysfs read.

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
v4: Spell out Error Check Scrub (ECS) on first use (Ben Cheatham)
and drop the Suggested-by tag (Alison Schofield). The diff is
unchanged, so the Reviewed-by is carried over from v3.

v3: Per review feedback, drop the Fixes tag and reword the
description to make clear this is hardening against a device
reporting values not covered by the spec rather than a fix
(Jonathan Cameron).

v2: Per review feedback, fail the read with -EINVAL for all reserved
encodings instead of returning 0, converting the cxl_get_ecs_*()
getters to an int return with an output parameter so the error
reaches the sysfs read (Alison Schofield).

v1: https://lore.kernel.org/all/20260928073553.85669-1-zhangyili01@baidu.com/
v2: https://lore.kernel.org/all/20260930095627.32616-1-zhangyili01@baidu.com/
v3: https://lore.kernel.org/all/20261021152053.85322-1-zhangyili01@baidu.com/

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

