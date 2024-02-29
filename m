Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A77827A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231353; cv=none; b=nBhI2cM/oTRudlPj7fXbZLoTWOj8WTz3ts957xDZAPuQ4jK5g0TAQaSC03zrWnWRR5UzfsgpKLWsy7eWSTnajP9mShHAmLZdtEObh4W20CgWUTEky+d8wyU8HxQGWfN5IGMdiih69FD/qJkOCe1ERq6WDZ91+/ivf4uwikdHm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231353; c=relaxed/simple;
	bh=gE96ppWK4dmsP/3ugIUOQfKsBCAueRbuyUdCXDH1o8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnttsrsqlaZeT7UiD5TId5bw0Xo/V/snORLLUMz0AxA+TRZA5JZCdDFhyr9miJC7L7HA5GINkKhL6XdT8N+QbfmG3CUXcc6CacjziBQc2lUpqQuCyDY25+SSm9E1A10gxDqBYRIa9x8zHgdwuD8KK81VJmAs6t9cd3OaAsWj7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F51C433F1;
	Thu, 29 Feb 2024 18:29:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH] cxl: Fix the incorrect assignment of SSLBIS entry pointer initial location
Date: Thu, 29 Feb 2024 11:29:11 -0700
Message-ID: <20240229182911.750135-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'entry' pointer in cdat_sslbis_handler() is set to header +
sizeof(common header). However, the math missed the addition of the SSLBIS
main header. It should be header + sizeof(common header) + sizeof(*sslbis).

Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 08fd0baea7a0..b7c678d4b1aa 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -414,7 +414,9 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	entries = remain / sizeof(*entry);
-	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+	entry = (struct acpi_cdat_sslbe *)((unsigned long)header +
+					   sizeof(header->cdat) +
+					   sizeof(*sslbis));
 
 	for (i = 0; i < entries; i++) {
 		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
-- 
2.43.0

