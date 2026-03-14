Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB2274B42;
	Sat, 14 Mar 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472177; cv=pass; b=VuxZJBTJ6mh/N2JqMzEL+Xk01EimTq+SJ1A8mqmLGJiwIsj/khBJ4dNErWA30lRuO0PEBlfD7e4VZto5IpB0eloQafW0zCV2g7WoLsy4PdzdkzsPbqBbO6aZ9ZbJZyV3keF/jdWp/3aY37L9l/xc+jzkZoDlgVeQH4v4C3FALWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472177; c=relaxed/simple;
	bh=jld8z8EaEZk/PIs/XnM+XbbTTLlhPZ/vTlBzy91LzBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSLHrKTIuRTUso8R3FPX5W9CHBtLZYasmK/VcxYnM43FAu+OjUInWcKlGfYmz8UHcwUXrzwh5VNz5PnVVMv86JWNa4BDpEXlc40SP2slcIoLmGGGVRtAhiostxsfDGR0k7odudE/hR3bIyGxW32ZKr0e9DT3ov2nZQXw6VGZJAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Knb+1cVs; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Knb+1cVs"
ARC-Seal: i=1; a=rsa-sha256; t=1773472017; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LZQtE9FuGhdLXj2onXBFs4/H0i5+//VyB8yKYXVOfqz8gXXit6RXKuKeLDX+6qElc4cXC4kvSl9cj6clVqWtLrklioL15qdR9MxazGzZJ21FLshyUNqtxSW1dU5QcSh0j/GUfnMbfjpeV7yyWc8id17u1gD2HM7WkjXcZ30Qfi0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773472017; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=he0hmlYadl7skuOe8IBrpjgtZApalDgIp3pwb0J17x4=; 
	b=GSCbjNfEvLepLDQQIt/ShKo75Uqu6vYDcbl4UxpngJOjNbgompI5xVmT8TkrK7FZaV9SznZbasvy4WHUas5O5M/qtsn3Lgc4GjEmwu/0rRETn452txWoaXLJ73QNWC2xzMvr12m7RbJei83Ln5okPc2nrWCfC18rsvW2QSy3sxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773472017;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=he0hmlYadl7skuOe8IBrpjgtZApalDgIp3pwb0J17x4=;
	b=Knb+1cVsyJRdZrwTkDM3eTNpH53SQhEJRiwK0Lbpmi51WgPIG8qXPVzmhxFDekym
	5XK+MBIjeyf+yVongy1ZgBQlkLVV1zZOKVAWdFX5QX7CM/SwFMI/eNpULI9y/HmAaYX
	pSrMHWcaCDSuAV3y7E6tWT76k+V3DKIZEcns3NqQ=
Received: by mx.zohomail.com with SMTPS id 1773472014637557.8600594017072;
	Sat, 14 Mar 2026 00:06:54 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 14 Mar 2026 15:06:30 +0800
Subject: [PATCH v2 1/4] driver core: Add conditional guard support for
 device_lock()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fix_access_endpoint_without_drv_check-v2-1-4c09edf2e1db@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773472001; l=882;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=jld8z8EaEZk/PIs/XnM+XbbTTLlhPZ/vTlBzy91LzBY=;
 b=vVy7NfYJLeQUWAB3/bMNKQZGhZP6WS+ae75EP6TH3St33twdxqqu2I1TKSfC3cY7idkoUqKYh
 gLJ+8DJr0VWCRzdZ1q6MQIok9lrwpxm2CofKFi1GtqhE+S8RZV/mqUV
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228d14fb1a2cc3d433601dca7ea00001a0613638ed52bb162cd0aeea0a9577678f5e63cf4a910d9f347:zu080112271ac650ea53c8c48b2f2e17ba0000f29f8472379426017f29730d6cb568e26b158f72af67528c9a:rf0801122d2013fd126a9024ca21b9143c0000a5e824e25431c819a524b27767917688fff2d259d1b8b89c043c87f38a457a:ZohoMail
X-ZohoMailClient: External

Introduce conditional guard version of device_lock() for scenarios that
require conditional device lock holding.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 include/linux/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..4fafee80524b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
 }
 
 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
 
 static inline void device_lock_assert(struct device *dev)
 {

-- 
2.43.0

