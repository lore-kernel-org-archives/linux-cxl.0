Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772853;
	b=yjQQncoXJROKBCtERZDkTT2ypzi2k2otP9dQlVUqPEa5qMVW9QLPqJKYxD5oiBusp5ys
	 p2cFwnusvv8FwdpnRdqJ8mo6pd3s0vJvVgN6fh4YBVqBam4BbbADep60k8hzJSdOBRj8T
	 TsQ6CmQxQdivBtNElvg1SuzpcKRzoXc38uDVyg/Znm2hpOj7ly8f2H7iQ6NnRcX/Vo2eH
	 6rIOXpoXLdWVahD070MgoONCTpREKQPiqRvJPIqnYwmUbKkUR6PxvtIZ5WRiTSnQm7uJN
	 8UqpPSf0OVchNYVAhgBc8FqvYXRxThVeN+O9j1Fd3K7Ic+eo5bZIiyIEt5e+hcNrnmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772853;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=oPru1ixeqET8VA3w2O2W4/Wbh3CD3rwDs6Utxb/ih1k=;
	b=W2a+mhl5AktFVfKVXBzz/bJhXlOvgAqZxnVldr/Vti/rf2sImi7vjByy5i5ctOANjO7j
	 pp8lVm0nGxRqPvCY4TZXfZs2A62ylkljPX3zcl8ME/NCbLw04tkIuSoIg86K8VSuWZeZT
	 Xin7cOE1h7V5PAM+UbIbPSpkljiA9fx9NVNFdwo0vpTplswPQM7HPMVTwXj1niZ2NVexX
	 WHYV3s+Ci+STjFaTxNXMEBjU+7/11k8gvfgj1bdiHJiPUFf3pgKdN1zXnaExftPJ/p5id
	 Zrw77pLWNljmR0PgjKS/VQbk0Y1X3KzSh9ABcXXA020nLKJWx6BdQrNea/0ZxW6/aiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cKtbVfNf;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3577606A31B;
	Wed,  4 Nov 2026 06:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3577606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cKtbVfNf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oP
	ru1ixeqET8VA3w2O2W4/Wbh3CD3rwDs6Utxb/ih1k=; b=cKtbVfNfcrgz+EqJjM
	uJMjn5JBynLc51/wtpw8sPMbptGzOc2aGnJxUNT8e8z2dI89S0HiaYkncyvi3BSS
	zlbs4ZvP/zHsvjST6D6qLK8LPbJ84VseoSO+GmWhYFJavL+2zxjzpcQvKxeuS+y3
	oNbnPm78ZZR4mENSnTg3HV8Y0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3_1QBzepqJQjCDw--.33545S2;
	Wed, 04 Nov 2026 14:13:23 +0800 (CST)
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
Subject: [PATCH v7] cxl/core: Create EINJ debugfs files regardless of EINJ init order
Date: Wed,  4 Nov 2026 14:12:56 +0800
Message-Id: <20261104061256.1449275-1-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
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
X-CM-TRANSID:PigvCgD3_1QBzepqJQjCDw--.33545S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFykZrW8Jw45ArW7Kw45ZFb_yoW5CF4xpa
	1Du3sYyry8uFWakry3Aa4UZFyYqwn5Wry7Cr98u343CF4kCrn8AFnYyrWY93WDuF4kJa4S
	q3Zayr1jkF1Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTUDJUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC-wTJZ2rqzQQFNwAA3u

The einj_types file under the CXL debugfs directory is never created when
cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
einj_init() registers EINJ at device_initcall level, so the
einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
up yet and the debugfs_create_file() below it is never reached.

Change the file creation condition from EINJ being initialized to a compile
time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.

The same check also guards the inject files under every downstream port
directory.  Gate that directory creation on CONFIG_ACPI_APEI_EINJ_CXL as
well, and check einj_cxl_is_initialized() in cxl_einj_inject() to reject
writes until EINJ is up.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
---
Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
Link: https://lore.kernel.org/all/63e782a6-e33a-46ce-a455-5d207a60661f@amd.com/
Link: https://lore.kernel.org/all/1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com/

Changes in v7:
- Drop the RCH mention from the third paragraph, as suggested by Ben.

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

