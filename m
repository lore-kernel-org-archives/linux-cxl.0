Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98618D65C
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752317; cv=none; b=g2r1eM6YqxeXMRO/3SuL+E9OLYgNaJRF4CSdFg5KniT5OYmvbiCZMtgM/MWl9yggGJWmI3ea7Hryg0/N+cTDW16Lf6d22VeEcMEKdddZ7Ptpe/H3xfC4/DjxoyZ7XQAZrCtcJ24fKOkMYCqQFgL6UqkleNC1uNhjs6TEAxRoedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752317; c=relaxed/simple;
	bh=1p6pmnqI7EqVba9pVVN8kdlQYzKrOCXpB5NqkCr/MMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2V+nX9iskT8G6Fddaqdrrp7EkTr9eAJOJNCq08nPUp158bw7KOiU7ZlHB6zfsr/Tozok8O96/bEaEX0EOvGAAwIJ2TLbZB0ENdZSkwNMOSNABDS2HndQk2eOP6VujVg8eFmAv1cltjCe5suiihecw/LeMsw+G4QrNu2gFB+ZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wi8Pv6Ke; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wi8Pv6Ke"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724752312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vwiC4I+wNAddjc4LjGQaDlHdkw/jV1rVA+GTUj5UF/c=;
	b=Wi8Pv6Ke2VGeL6TmDsMPzkzXQZAZ/EOXh8aPujr3uQ6ZpQEZS3t6uD8pI1jDgf47t2p+eA
	ThlhIF9DPKDMj/N2hjs1UK5/R5Bcn/v83rlVZEFDDKX9HOtYfVjUubXajrUiDf0SdckS4R
	uJSTyn6eevP6rCXNiWArJO15bzrkSzk=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] tools/testing/cxl: Use dev_is_platform()
Date: Tue, 27 Aug 2024 17:51:23 +0800
Message-ID: <20240827095123.168696-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Use dev_is_platform() instead of checking bus type directly.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/cxl/mock_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index 55813de26d46..8da94378ccec 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -18,7 +18,7 @@ struct acpi_device *to_cxl_host_bridge(struct device *host, struct device *dev)
 		goto out;
 	}
 
-	if (dev->bus == &platform_bus_type)
+	if (dev_is_platform(dev))
 		goto out;
 
 	adev = to_acpi_device(dev);
-- 
2.41.0

