Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684249;
	b=l7kfgVpbCQZSnJzwiZqHgtNEmqBCWdRAtRSD5XpcUV5OUQgqIv1pfD66Qvi98eA7xWuW
	 d5COJSe2poilxRYGrGfEh0pkn7ljHcrSXsINYq8n16MoFzwu89NiLuQZs+I7nKcVsjk9j
	 3VQAgwiOUHIu+Rp6gfg1FhH6VHdes+KYjpZswlVup/QeEkOJCUk0Qy+B99RYVc+Nig2Vy
	 03FbpNNlG9Zo9BS1fspME0TBrXbu0W0ho1sCm+8MEd1jbVXfOKkCA6kcqXrP72BVsgiM0
	 1dUlBWTYSMgsXPOArw65/DUf9MzHCCgb+5Br0el33ZdQY+A1XnoKQRu7GooMRW/sEaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684249;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=1SUHukhOZD2PvxvVE654q0jDC0/+kYhMEDgWdq91p3s=;
	b=heiP7pU56KqXnx1iwXrr9fbMHycHbo30wXREOqIdRfYxGjvXTZJgzQBttAC+7RtdqKr2
	 LT9tzgyHYXc2S5wCKu+viyfXEuYY3N4iswksEnh3G5g+UYBzPFMjkOF4PnRpYO06flmwY
	 aAIbVVsuy/y9mPqFFUNhqgcjquMZ8M+tXu7Zy7jqJBUQFzQ8m3NWsjg0GdQwYaqPggSyF
	 IclDPoFSm01daAT+9fpc16X7WIJ8x9QxeFBLS65Iw5aXpjLohxVWf8vg3pdjqdf8r32cy
	 0POi5xGpAb9LsrQzjPyqXiSkC2rsn3QneKVp48TO+idMTbKIRv9jzpmL7gDG9DrrpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z+jH3h5+;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B4606A324;
	Tue,  3 Nov 2026 05:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z+jH3h5+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1S
	UHukhOZD2PvxvVE654q0jDC0/+kYhMEDgWdq91p3s=; b=Z+jH3h5+Mqutwxst4m
	qYje7Uo1OEQ+LrKJjtfbVj173XF4EzTZGSkhcmr5DKs4vpI85aTyXzHGnn9eNQFs
	Jseca0Orfh2lkWEtRuH/ZOYmFpWN71IrtJWnyXCHakmCGtCjrGgY3sIDOLPhtGQB
	kr6fCwq3RQCoehqTJdOokbcOk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXSZPSculq7ZSvDg--.17660S2;
	Tue, 03 Nov 2026 13:36:34 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] cxl/core: Create EINJ debugfs files regardless of EINJ init order
Date: Tue,  3 Nov 2026 13:36:18 +0800
Message-Id: <20261103053618.884065-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102032436.230945-1-yangyongxin@kylinos.cn>
References: <20261102032436.230945-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:QCgvCgCXSZPSculq7ZSvDg--.17660S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFykZrW8Jw45ArW7uFy5XFb_yoW5ZFyrpa
	1DC3sYy3y8Cay3Cry3Aa4UZFySqwn5Wa47Ar98u343AF4kCrn8GFn5ArWY9ayDWFs8Ja4F
	q3WYyr1DCr1Ykr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTUDJUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC4wPph2rpcuPufwAA3N

The einj_types file under the CXL debugfs directory is never created when
cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
einj_init() registers EINJ at device_initcall level, so the
einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
up yet and the debugfs_create_file() below it is never reached.

Change the file creation condition from EINJ being initialized to a compile
time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.

The same check also guards the inject files under every downstream port
directory, not just the RCH ones.  Gate that directory creation on
CONFIG_ACPI_APEI_EINJ_CXL as well, and check einj_cxl_is_initialized() in
cxl_einj_inject() to reject writes until EINJ is up.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/

Changes in v6:
- Apply the same compile time check to cxl_debugfs_create_dport_dir() and
  move the runtime check into cxl_einj_inject(), so the inject files under
  the downstream ports are created as well.  This is not RCH specific, all
  downstream ports are affected.
- Reword the commit log as suggested and drop the parts that the code makes
  obvious.
- Drop Cc: stable and both Suggested-by tags, move the lore links below the
  git marker.

 drivers/acpi/apei/einj-cxl.c | 3 +++
 drivers/cxl/core/port.c      | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index e70a416ec925..22a7eb4dc75e 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,6 +30,9 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..a949228de936 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -806,6 +806,9 @@ static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
 
+	if (!einj_cxl_is_initialized())
+		return -ENODEV;
+
 	if (dport->rch)
 		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
 
@@ -819,7 +822,7 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 	struct cxl_port *parent = parent_port_of(dport->port);
 	struct dentry *dir;
 
-	if (!einj_cxl_is_initialized())
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
 		return;
 
 	/*
@@ -2515,7 +2518,7 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
+	if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
 		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
 				    &einj_cxl_available_error_type_fops);
 
-- 
2.25.1

