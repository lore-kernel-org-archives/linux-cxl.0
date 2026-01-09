Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF63064B5
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970009; cv=none; b=I0qnJSBVBFtPU3nNnUFz2ygN2T4mtvzWctXKGOptEtp1ijmZHqnM15L8K5f0kfH7U3fc+Wy9qKSgERY+h2B8VNx+foEpoktDD5Z6r4D+1WWk6mNwkeq1xi2rdBfGnBK4BnslxtJ37xuWvhzKgz6z6MU742hjpxKeN4Ue4HmODgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970009; c=relaxed/simple;
	bh=ROri2kYQtSaMUmhV8V8MHLFRofVv55tWtbYnCFqh8F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIKIFlpoLU8BRZ2ZCs4Rt9jmOLpbhE6VmFU0WuUezycEr2+yXxAZ5hz0oOjgWfD1OedmQGZecWqjLBqqunSorNwq+ZH56ILOGjy8uoW0OmmFOuNrIz/8R2aLupoiv/GeEcFdhEkbYybVQzGcfQOSOQbeu9pIP7UPPSShTWuZtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnl3350s2zJ467H;
	Fri,  9 Jan 2026 22:46:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5126540539;
	Fri,  9 Jan 2026 22:46:46 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 14:46:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 3/7] tests/bios-tables-test: Excluded CEDT.cxl for BI restriction relaxation.
Date: Fri, 9 Jan 2026 14:45:07 +0000
Message-ID: <20260109144511.557781-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

The next patch will relax restrictions on the fixed memory window
to allow use with back invalidate capable devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: New patch as test data update was previously missing.
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..b4646b5b3147 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
2.48.1

