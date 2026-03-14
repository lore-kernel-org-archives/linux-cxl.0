Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0A1B85F8;
	Sat, 14 Mar 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472200; cv=pass; b=gnfV/3oxKQfqFoHWDSEqsxJjfRtos2asM9bKGh0Ec2V61sGI7qZPYPqVVHyUGZqJ1atG7z9Hbko6Sgks7zR0sOJvc8+PJ8UV48X+2wjy9gHVu6T/+tBe35VCqe37sXKBT4Z4H2YMK8oIqVpGgA5uyzK3j80vHsQtkdzXjyvFK90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472200; c=relaxed/simple;
	bh=DB9HqXhMpvRgERuMMJHgiOhLxgOij9oYtMtduU3akXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvUn+FuIrlw2PfWyWmj37amVcvzXom0tpH+g+1qESoEbryzkORBRwCrNVAQYnHcsazYwaLHSzStST4U4818y2ri7yyuOk+RAbH4Fi0W5kO3x0gb6YXRdzQAbMU3aGicEJWQmap5jUVy72xiZFXju7qAsx/qhac0iMJ34s+KCioM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bmTBiN0P; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bmTBiN0P"
ARC-Seal: i=1; a=rsa-sha256; t=1773472021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=axkE0fNzCrJf5Cvl9+BQSfZXzodz2MBbFsP3Ofc2AgOA5Gt1eM1uMNAfxsAwuTto8bVLu2PfD/MhSciX26Ymz76FqhJMjw8SZ1g8izT342Gr89Eg3LIkufqiDZUByNokY9Wg99+11f1JjYeLmycNuY3uCma2ye1TPlTYQxkhq38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773472021; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QmJl2oe8AGR2KIYRqSQqLtmGMi/TBXCWDyU7deHFt6I=; 
	b=mEeEFjvp5qPmN03MnSpCYM6D/OEdcYly0DfzThAjOP3j5U8fnnnXZIYXaHSo6I+uBweIdUuZ1XFseSCGKWh4arBpsoqn1/Hpy1KJTXuNLMUqNp2aj09cG0e+vByfQsbmWjKsyafZCZuue4XRlSMdBtBSt2Sfk4vTsJ58PL9t+BM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773472021;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=QmJl2oe8AGR2KIYRqSQqLtmGMi/TBXCWDyU7deHFt6I=;
	b=bmTBiN0P9dKDn9VQRSZO1ui7TOWlhEnx2mC9VIyUJLlYST+y63u17cYkduN/7KyO
	jHmeP/jRtVloP3UiMLJUD7f/o4rBqk+ASWSA3ubRx2yBRPod48tWBZE8sfveGBge0Rt
	tmAirvhxV42kbfHMjKGzc0RpDxFbzvS38ClaAiwU=
Received: by mx.zohomail.com with SMTPS id 177347201995764.17360339363813;
	Sat, 14 Mar 2026 00:06:59 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 14 Mar 2026 15:06:31 +0800
Subject: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
In-Reply-To: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773472001; l=1615;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=DB9HqXhMpvRgERuMMJHgiOhLxgOij9oYtMtduU3akXg=;
 b=afR/AegZjhlWuMx+r87tunQlkf8AHKkPZfsqnHdwUZCL17UgZGV8fJrXwy027WLWnmNl6k5+G
 /O2lAUCgK7VCaaqbs/XEf+JwlzL2DBtZCpav5cTg/axc7eYAg61WrrQ
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112289099a47d885d93aa2e3e17e00000d297e5df5e53ccbd21f13b794e8d82d090799ccd019f4a589328:zu080112278e36bcd1d7e2f75babbd455d0000b8daa23f752d1a73c075abf414d840d063a0daa5668d189b8a:rf0801122d3848e719f319e6efbe386ba900003b572e0a8020a8afcd1161f0a383752999c450f6e2cad084079f3bcb53cf83:ZohoMail
X-ZohoMailClient: External

CXL memdev poison injection/clearing debugfs interfaces are visible
before the CXL memdev endpoint initialization, If user accesses the
interfaces before cxlmd->endpoint updated, it is possible to access an
invalid endpoint in cxl_dpa_to_region().

Hold CXL memdev lock at the beginning of the interfaces, this blocks the
interfaces until CXL memdev probing completed.

The following patch will check the given endpoint validity in
cxl_dpa_to_region().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..ab88eaa31d1d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -48,6 +48,11 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
+	int rc;
+
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
 
 	return cxl_inject_poison(cxlmd, dpa);
 }
@@ -58,6 +63,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
+	int rc;
+
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
 
 	return cxl_clear_poison(cxlmd, dpa);
 }

-- 
2.43.0

