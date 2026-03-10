Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F63BBA10;
	Tue, 10 Mar 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158348; cv=pass; b=NPmBbwdpgUDCqspXRFhBZZMeu+muGrbOYHiXEIAQPgNO+0v2d2HvJPIvUH8NLLLzsO034eEMzyKuMV3IDt3NH/A7dUr/cKlom384iE287Rhqcf6xc7LK49vNxw3SDg2CdxMcwzk3rqAMw5gYE4AsNtCzJEGhGSmftQPPEkfZVLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158348; c=relaxed/simple;
	bh=9cegwMqhBb1M2HDTgiRRFQZe1yhObxc9jZx5iEJ87RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCBtMkErRXQbFS1tBgfLVlddW7ALiVjlEV6LsXnIDGKzyCKRAq+wCv76oLIFDgLPTVkc7/pn/eJdWyr/JwsM7c3bzcv1n6Yn805hW6ZREMdX18vVzCpwHXaXKY0QvDokZIVPHHVF/BculZiw+GcsV1rfxV4y0GXHs6M/Qi4KBI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Ww7fTGWZ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Ww7fTGWZ"
ARC-Seal: i=1; a=rsa-sha256; t=1773158307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e0MLjwRJa6af31IKkqM1ahJeO3ijttll/ELcTUFL6YjcadB141rOu7kSom9x3EwOJTNXTFWk7RtC2lAFbRco3xy3GlLQPRMMGTjcrfp0wZpoHb84D5upGJG1dp3ZF6UvRYvFqCgVBLgH+lbQ0Ugaigf/cVv0wRyrVqumYkLNKOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158307; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v+Sp5eB4jHn/sA0kH/pywsovtoZ/8KBPXVDiCouPg1s=; 
	b=LA7vfqtzJ/aRN3ZOZVERtiU2PKcblOFwdMB/grY7TTwB+gyCT2VM6HcE3/PazYkeFEocCJCh5L5LeIjjmj5FD9D76rotIG3/WCTuTUok/YoQjdFJsRLIdjM3f7pm3n1xTVQTpY0MvYd8QRZVuHOS/k0eBKtJtVcEQqGQF/LdqCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158307;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=v+Sp5eB4jHn/sA0kH/pywsovtoZ/8KBPXVDiCouPg1s=;
	b=Ww7fTGWZDToAGaUNRAbUGO/CWVVGAWx8JcS9a6HIBNGzSsTwmK9B5yGMKHUh0IwJ
	ed+tGXf/1CXUpRzJhc8BxXh+peyKzjdyuj9ARlB2qnCD6+XzpingZS+dP0MCBxwvCJS
	31uxcGENCD44vUSDz11FEUlUCUewfochnTWEfyUE=
Received: by mx.zohomail.com with SMTPS id 1773158305583401.95210919423346;
	Tue, 10 Mar 2026 08:58:25 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:53 +0800
Subject: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=769;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=9cegwMqhBb1M2HDTgiRRFQZe1yhObxc9jZx5iEJ87RM=;
 b=ehBbYLnANmALJM/xQZFVS97B7jdRua4Bbqk3ycAUeM++PZTiJ8P3T3Xb+/m0BOj9uRKFbG866
 WhVU8eAISMHCx1EphgQzGJpkdCipb8z1ywjFh5da7EzDK+ziCNyV+Ya
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr0801122820a7170f3668632f2b094ead000053fb67fb145308710d3c84d7fd1dd6947224fdec47f60d19322b:zu08011227a6b6c6100c7aab107d4df107000092b27248d0c875ff9de6ab81fd4b25d251a64f261d430cf621:rf0801122d87d7d0d1a0dad495f20554cf000071052af948841edd458347db9b9ff1eadc414905b58ab7c305668c8253b510:ZohoMail
X-ZohoMailClient: External

Introduce conditional guard version of device_lock() for scenarios that
require conditional device lock holding.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
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

