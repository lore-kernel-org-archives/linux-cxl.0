Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7530BF6D
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970040; cv=none; b=EHTDTo9Tsu6Wbqn99exjJNjoxrobDNRfckpAwdhXbnSk8EYXiYUtowitG0Az8RYW6jHoHjA/rpiDTUvFojWEi4Qff+84FzqjsvImyYYDsCAxo4twIBcbgyn6+wQoZb/yZs3dDVGUzFj89Sp09XeK/XzrAfg89h9Z+SU5yVHEVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970040; c=relaxed/simple;
	bh=99E+NBFZxwEDpw3Bb7FfgkmiyFJdrQM9DmfQgHPDkXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJhy6tPbHCxbm8istRXIBW3AiHkVZH+UTVo1CgO4GGRNu4D1ncnWydqaid7ie7or6HiWghWfshYb9jaAMxt1r/f3KY5Dk4VYFSErw3XVybW86YXG75UM7fHRh0WXVSIFJDpAW1m6VENDLdS594vuMhnREZs+a7D4lRJmU74627s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnl3f6R5XzJ46ck;
	Fri,  9 Jan 2026 22:47:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 824C140584;
	Fri,  9 Jan 2026 22:47:17 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 14:47:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 4/7] hw/cxl: Update CXL Fixed Memory Window ACPI description to include Back Invalidate support.
Date: Fri, 9 Jan 2026 14:45:08 +0000
Message-ID: <20260109144511.557781-5-Jonathan.Cameron@huawei.com>
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

Defaults for these windows has always been to enable anything QEMU supports.
With the addition of back invalidate support it is necessary to specify that
host windows support this.

CXL emulation is currently only suitable for software stack verification.
The relaxation of the restrictions on this window to include BI have no
affect on the OS until BI capable devices are added and until now these
have not existed. As such no backwards compatibility impacts are expected
from this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: Equivalent of the default change in the window restrictions patch.
    That patch isn't ready for upstream just yet, so for now just
    change the value for everyone.
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75edb2c0a652..f92f7fa3d558 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x0f, 2);
+    build_append_int_noprefix(table_data, 0x2f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.48.1

