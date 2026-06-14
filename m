Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB782472A6
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453755; cv=none; b=SGRQ4ANHHABgQNdQBhO1+DUD0gmIG6tW3XNVra8eosQzU/p0ULV7qHo1yAfAJ2abWL1cWAh8ZNhcXyEANYJCz5fK4m6uNtstvCt1pHzYR699GZ0M4TvK4tBTcSlPdGqnny2tnucGXWtdCbPLUQ/qI7EIJFJ7K9RPCCYvJn3tVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453755; c=relaxed/simple;
	bh=0KjrcF1RfnmDOL7RpI0DWveoukUXC94l358vI81uumY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQY+2AE0rmrKiEMQ39A61QISbsz4n2HRp2J2mvQW0NNJv85bn3g4EDZUY8Vq0xDpLP6uTG2sgyRrcQkzWaBARrQtaQY/J/10JPAwwzggewwMXBuVv8uGKKhwle8JIcEY+2L+DVTBM+9ppeK0/Wr6FPUhVIWNFzw5Dy0vQPg9ENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYL0wfYW; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYL0wfYW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781453750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kEYJ7xP+tYTB+MoyRGzw7SP2fpUDIwAj7Q+PSGirzZk=;
	b=KYL0wfYWsGO/SQnhs8bYe00FmsSUGIDbLf2jBy8JeUE9Xqb/txgsOTJvSkHi9pkejt5U91
	YVpvoPFE2Gyy2mtZBX2O/XLOP2qqc2HHQjtId3ItB890B5UboJKaoRe/kKwVdvfuvRR9Wx
	BQtXlEbFz3MRBAnzlnDYsQFQatwYArQ=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	gourry@gourry.net,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] cxl: docs/linux/dax-driver - fix typos
Date: Mon, 15 Jun 2026 00:14:58 +0800
Message-ID: <20260614161458.88942-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix two obvious typos in the "kmem conversion" section.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 Documentation/driver-api/cxl/linux/dax-driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/cxl/linux/dax-driver.rst b/Documentation/driver-api/cxl/linux/dax-driver.rst
index 10d953a2167b..72c85a0f8606 100644
--- a/Documentation/driver-api/cxl/linux/dax-driver.rst
+++ b/Documentation/driver-api/cxl/linux/dax-driver.rst
@@ -35,9 +35,9 @@ will be exposed to the kernel page allocator in the user-selected memory
 zone.
 
 The :code:`memmap_on_memory` setting (both global and DAX device local)
-dictates where the kernell will allocate the :code:`struct folio` descriptors
+dictates where the kernel will allocate the :code:`struct folio` descriptors
 for this memory will come from.  If :code:`memmap_on_memory` is set, memory
 hotplug will set aside a portion of the memory block capacity to allocate
 folios. If unset, the memory is allocated via a normal :code:`GFP_KERNEL`
-allocation - and as a result will most likely land on the local NUM node of the
+allocation - and as a result will most likely land on the local NUMA node of the
 CPU executing the hotplug operation.
-- 
2.53.0

