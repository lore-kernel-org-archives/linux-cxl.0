Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.3.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596080;
	b=ZLSXDexRfix1b+jBOwUOrxwxe37wCZtb3bTc9zsEqEHP+qdRI5OInqlT5hHmawV2uXY4
	 XBWMO7sn2KnvcDxFZdCCAYFInoGRstYtjQFo4urZsEaf1Puau6SLxrk4u9+GVf4c66QH1
	 4pcuogbVZzU2e9dsceuKZFuOZ5+mVQw3bCWE2N0BcGgo3J9r/DXK6f62LnrrkJP4x7rRe
	 3/XD5HkanFRC45SqP8AzHV4ihfokR6jDUco8AoIWOMz/l1tYmcd0VfSoAvuDxrqxya5bE
	 6iwmeBD00z7HzlekUElvsxmkzcWdUiR6FClaQvKr/Ybl1w8fSEr8/3Z0zG4iZyuqbzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596080;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=nW2t74IIRSfYGanbWK3MJKNPdtM7IW6iGdLlsj93zRo=;
	b=YZONnP3dMo8wXm/ZmyJEZQYtzjzlPbagcT6/+4f6VvaNEb33BIjS5hNxiaSiaE/ZzUaT
	 ZR/CBfyjP8MK2r/2qq+sGNTY3le2+7f9HVelgjrG2EwmJKl+RYMz9spocaTcFg+FCcvv5
	 BC64XtUoYeOC54C1jTi7Sy6/BR8l4gRcFTeGqcZ+7TGjzIPd/O2PbC6wUgouSeRKndQMn
	 iVZ5WP/TfMJG/55557MAQrdmuxeJsvmrt0S0BC/IM4i2hlrvQXgxaai9bxv0dnSWuDJdo
	 9zG+claifjSqaxZMgLxbBFkkd1cuMZJ6HRb4m6sIxFzV6M8vlonkJy97MrvV8ex0Tsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Dx7g40Kk;
	arc=none smtp.remote-ip=220.181.3.85
Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 26EC1606A319;
	Wed, 21 Oct 2026 15:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26EC1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Dx7g40Kk
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <jic23@kernel.org>
CC: <alison.schofield@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<djbw@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shijujose2008@gmail.com>,
	<vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: [PATCH v3] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Wed, 21 Oct 2026 23:20:53 +0800
Message-ID: <20261021152053.85322-1-zhangyili01@baidu.com>
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
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792596066;
	bh=nW2t74IIRSfYGanbWK3MJKNPdtM7IW6iGdLlsj93zRo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Dx7g40KkeF18npDmFLVqNphM7zUoZAzDcCF7j6vG5Kn5n3VpwnEIdj04YQLNno4HA
	 QE2nKGWBaS4Xc29NmDDVDHP+Nen1GMiHidbYedZGikIwg3EBXKPYAosSJet0eJzVj2
	 L/JuOrbtVAs2jZ314PBcYyQlT0X7myc7+P+0rbrG457YIKlzg3I93NYcEauVpfTHHS
	 u4h5NiPnrU/m6hqn9m9Yms+Y5bbL8ekq7WnEofw2r/0JtsOoUUGN4R8lpusyVZH7o3
	 FAo8AxKiNwEpOqNYITDnLZYTxjL8t/WVQ8NIFCjfYISGw4cDks+kRsrhm9QqlzrSyP
	 h8oEWrbaKgh9w==

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

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
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

