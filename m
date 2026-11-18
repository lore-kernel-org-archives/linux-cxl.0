Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003672;
	b=2amzOdeLQAFVPVOmEJcg52tqGgyeRXkSCIgaMo3OXVdj52TgZmqOeQ0Xu5QpzAJel9bK
	 FD/tl8AuKbsmjgeWzeKy/O6EzPQel6NY0/N1Fj5NxJ+8MkEgoDyMzbBxSO84gFHbNVyS3
	 Lcv1ilNECFReMQGyILxZAP4hfRQFF0s6i6kzH6Z2/+W+hK5s8QBBK+a9UspStevlnZrnP
	 b4GOHly38U/ROGRR1FZ+IaKhdiy/nflgSuiIsqCGqeu0mKH0Zn1ZsSOrvZjaZnpb62nSd
	 7gtVEHjhOBczCx4OpksgpHLJrgtylEKpwGVVvitNLyBzh0z2Ov6nXUfNxrRVSIQb6+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003672;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=shXLopQjUR6W/RVgrmsuiRMgnkO4F0thntG93+V0tbA=;
	b=j3gmOlGGu5L7/eh/y/fYrbRSIUHMERdBowP5ocyACErDlu3IXXbrWW98tqDC6avFdaUJ
	 dtQ5jWtW79yw5p3qlNO4tH1HTIh0u0fRyTpVs6NCh8bxopMEl/5C8gebzd/wgYI+/G9Un
	 TiOd4vHaB62T7frlovHwdpgRdendEnCAN+m9QKWVn6FgeW5NhP4SGewv7AXPwkgVYyJAQ
	 haSaNio2fXtW654RiMNjaCrBE+qq7E9gpkJ7nm8hM78VuXfhWzgDJiJY6aq9APz4aLwy6
	 MqfBnCUnmLA46WF4YY4nT9xwLmp+n+NRhGjXpVkF9i8qDlK6k9/WV5/OkISFhBh3QqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=TRRr0Jzf;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 403B7606A339;
	Wed, 18 Nov 2026 12:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403B7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=TRRr0Jzf
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <jic23@kernel.org>
CC: <alison.schofield@intel.com>, <benjamin.cheatham@amd.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shijujose2008@gmail.com>, <vishal.l.verma@intel.com>,
	<zhangyili01@baidu.com>
Subject: [PATCH v5] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Wed, 18 Nov 2026 20:07:36 +0800
Message-ID: <20261118120736.7181-1-zhangyili01@baidu.com>
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
X-ClientProxiedBy: bjkjy-exc10.internal.baidu.com (172.31.50.20) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1795003667;
	bh=shXLopQjUR6W/RVgrmsuiRMgnkO4F0thntG93+V0tbA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=TRRr0JzfQwinb3V9+0dCjViajwQSd5yJGBe2f3AJWgFsqrfSzc+TZyVBX8ycXRejT
	 +uGYGR4zGdg7vkaORDDusnNSuiW9QhWGcwfnB3CMkeBC47pqbhobUIfkYS5+dIR8nt
	 5caJsHZuCIRYH0Clo2s9nTeMh3ZQTV7L21/lw52DmQxgimgBQMfNaA3Tr9rcA2xOtD
	 bq5ZJB309mSz0RjGGzyiOAOWXG+oVdvBWqRiPytVfj8+qOWJN7+vsk45MpzEDMIcy2
	 2WfrsxHCQPybVlSjvR2reeeR2BxjUCRAvid6XuE+MPi4/+3sdY2rm3daxXvWn5ryDA
	 dEYduJtIjeYAQ==

cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
device-supplied Error Check Scrub (ECS) config word and uses it to
index ecs_supp_threshold[], which only has 6 elements. A device
reporting index 6 or 7 causes a read beyond the end of the array,
and the driver reports the resulting value to userspace through
the EDAC 'threshold' sysfs attribute.

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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
v5: Drop "adjacent .rodata" and "small info leak" from the commit
message, since what sits beyond the array depends on compiler and
linker layout (Alison Schofield), and add her Reviewed-by. The
diff is unchanged, so Ben's Reviewed-by carries over from v4.

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
v4: https://lore.kernel.org/all/20261029131013.85983-1-zhangyili01@baidu.com/

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

