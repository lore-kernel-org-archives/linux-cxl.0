Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BA3A8FEE
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207274; cv=none; b=s70sj4/1VXTsM/M9Z11hC4Uu9rw6nhL1m2Hf7KtHLizp64VEIcNKUlvpxE+DWW4067123oEWee24NGFUJDzY0LT7kqR6uYZzAk1kLRbI/Z96DeNhA5HkldeAHvDGgpewzmr1lULlipL0nL2PDZPPe5DFl9UVCya4MJajdr8uQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207274; c=relaxed/simple;
	bh=NCOvv9YB1ms8RsbXkjj2Ixz8lsgdyd+KtRw75MYuktQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOrJen7ZArO4ZOGcvd8NCZi3UWvJwmVISC3HDY0WTyAJPnTvsm5G5Yu4/YQEdqUUKH3sFSGfPkGrrxWJC9ciaBs1t0Bswt8L+Gq/y9E8WACSkWyxLjHRea5FT5a03qPAc4D8mLooeNgd1+dZBmwXo/wJM5jniQXwLHuRMs/Z+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5fQZ5MtFzJ46d9;
	Wed,  4 Feb 2026 20:13:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B81C340565;
	Wed,  4 Feb 2026 20:14:31 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 12:14:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v6 4/7] hw/cxl: Update CXL Fixed Memory Window ACPI description to include Back Invalidate support.
Date: Wed, 4 Feb 2026 12:12:12 +0000
Message-ID: <20260204121215.68897-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
References: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Defaults for these windows has always been to enable anything QEMU supports.
With the addition of back invalidate support it is necessary to specify that
host windows support this.

CXL emulation is currently only suitable for software stack verification.
The relaxation of the restrictions on this window to include BI have no
affect on the OS until BI capable devices are added and until now these
have not existed. As such no backwards compatibility impacts are expected
from this change.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.51.0

