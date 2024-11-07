Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A972185AF;
	Thu,  7 Nov 2024 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013120; cv=none; b=Rb1i9bcEzuPzoIFcLkvv4SVPi0/JD9v3G0Noz5gEJuGfFrYhL9Hkzk5jeG7Ay4ZeNbqQCdjykO2vBnw8YeoFj+HCzVJDQvs02ltIe+H2zWoQ2jR8jd93m4622nw1vbeEc7YMU4n4/g610DBcB7M6AtEli/5RcKzXbd3ga9zfUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013120; c=relaxed/simple;
	bh=zrkJPQVXZsx8rimt+5mECl38V/+5uCzh28VzTSmy1KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzyjZX8euHloz88vTE/o2/2B2JvPg7OaLjEt2xCxNHknfiwifKGfg4vnSeFGCWMTaB0KE/hKAlwI0FG0T78yNo7IPN5wlWfSrDaWz8siBdZFg0bh6jY6vyc+ESG2Sre4A1LM8QJujVFMiXHf9lpJzlIJzZ/mPa9pppm9X0OgTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2Bh/0MX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2Bh/0MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013118; x=1762549118;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zrkJPQVXZsx8rimt+5mECl38V/+5uCzh28VzTSmy1KA=;
  b=E2Bh/0MXhaicYbb6vLgQo3s43roEWD2v/xfrCcJHuAni9dwHgPF0lB7b
   bkXi/1ECQ1VkpxGo/YUfnZ5UTn0oSADxHADnZqBuzxUETWZtcohbm9qtW
   Ip4bC+yqe/YbL59x8QBxJOvyeD0ZNHXte1azi2zLGfFXeqKTanYAroXWq
   dwMZQXd0vkuhfSxkNqNTudyf2rB4uAn8GhlvF4x89Qi6tBN/BMwPd9gfO
   fzfIa6sZnB9jWqjFjk2lllKg5VOeYZjAMeR/1XsprWRSzAdc7ZvXi1LDX
   XIrmbmflpVIdZg0MlObmpeoqPzhC78EYjlHhlLSNxR7+HhD+k3gRx4Cxh
   Q==;
X-CSE-ConnectionGUID: KefmN98ZTA6NB6VDuSS+UA==
X-CSE-MsgGUID: yA9xbidAR6i2tMPsjGfynA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300335"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:38 -0800
X-CSE-ConnectionGUID: ooMkMyDHQIGZpA3pHm+lTw==
X-CSE-MsgGUID: CFx1p6rRQ/m1T//7Yz+F/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093602"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:37 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Nov 2024 14:58:22 -0600
Subject: [PATCH v7 04/27] cxl/pci: Delay event buffer allocation
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-4-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Li Ming <ming4.li@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=1469;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=zrkJPQVXZsx8rimt+5mECl38V/+5uCzh28VzTSmy1KA=;
 b=gnuvNin8o92+zuWymm375kanSqfq7hQ4bjMtJFrImeR2pRa47mHQ5N92Ojo7Unwz1VAOuVhRP
 kNCsGMnLFYhBaE8VmgskGIR93Nueu4uhlcUntPicw+++1Ff8quthO2S
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The event buffer does not need to be allocated if something has failed in
setting up event irq's.

In prep for adjusting event configuration for DCD events move the buffer
allocation to the end of the event configuration.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Li Ming <ming4.li@intel.com>
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d266b19f7401a1cdc51ed6fb0ea0a..295779c433b2a2e377995b53a70ff2a3158b0a8e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -764,10 +764,6 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return 0;
 	}
 
-	rc = cxl_mem_alloc_event_buf(mds);
-	if (rc)
-		return rc;
-
 	rc = cxl_event_get_int_policy(mds, &policy);
 	if (rc)
 		return rc;
@@ -781,6 +777,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
+	rc = cxl_mem_alloc_event_buf(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_event_irqsetup(mds);
 	if (rc)
 		return rc;

-- 
2.47.0

