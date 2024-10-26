Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645A1805E;
	Sat, 26 Oct 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903630; cv=none; b=HzM8SWtN+wueJAFFR/wgQO0yKfsdEPO0ZCmkGLZ6w/3ljxkLN4OtalfMX1Z1JDfrM932Ci78CkCIQ5VaTHyMLLTeWDOBGvHDwBQspsxu/KAilqEBfdnzk0z0uw1zgcliSXeA/yYIfmimZrXNlJ3gB97VUxO5wPSuLEBGqlT1Orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903630; c=relaxed/simple;
	bh=yxBEWdpHaV6bcSUejItXoVU+ob4Ni/SGYV+LJ2p6dCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFJFo/H1dKVToEVmHT2ZtC52HhGDzjsQtlq5h9QuXBYxULP/0oaE5M5uhmkFNTYAu0FcX02aYLYLdhXVYL7CiEsp3qcPue4swhyerZxxERf8O18wIBN5tw8kZka5FABB/L4GT/VVCoR4J/q+cw21oncsQqxyfbZR7sJgd/jFdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zcfq3NoE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zcfq3NoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729903629; x=1761439629;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yxBEWdpHaV6bcSUejItXoVU+ob4Ni/SGYV+LJ2p6dCE=;
  b=Zcfq3NoE0J+zLJnqlrm8OV7Xm+eDiNfNZeEZD01vaT54dMGV4beqjPIE
   ll6dnE7y6NLTF/SLhIo87nMdaj9+vSPvc0g6egz9s1sghK1o5Y/Ux9+fE
   2p53mgjuJHtkEH55KIV4w5AP3x8Fb9pFNztjzxW8AXglN+lcLhZClVt3S
   jDv5gIlRLRjrj94pdKSMsX9JEC/BHP1s2DwhkiZjdiYeaPbyP+KXiN1Gn
   AVyi3vDlSqMeEYl4m25zGeLINzhVHrj3ZYJv9watY4za9k2/8NP5UekDm
   Z4cDTgZpneGE2kcwIQEyIvpNsRkxef86iKibokGcToRx/C2hqiL+87Mw8
   g==;
X-CSE-ConnectionGUID: lxKWPCLQSUeTx43MeKs2bg==
X-CSE-MsgGUID: o8zGigyJTICqQzlfvw+gfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40974473"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40974473"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:08 -0700
X-CSE-ConnectionGUID: 5uLdAEvPT6au9dmIRrD+jA==
X-CSE-MsgGUID: AR5ymz5LROiBOT7S3qAlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85851658"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.111.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:06 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2024 19:46:56 -0500
Subject: [PATCH v2 4/4] cxl/cdat: Use %pra for dpa range outputs
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-cxl-pra-v2-4-123a825daba2@intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
In-Reply-To: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729903614; l=1497;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=yxBEWdpHaV6bcSUejItXoVU+ob4Ni/SGYV+LJ2p6dCE=;
 b=AdvYAt7HP7Phb77jMxIC63bIRrVcMNTgBmLTw6viyhQkS5JB8emh4NT8CovuO2TcKoEgYN7Ie
 4bEEH+YcjRODfngW74iQXLPZKDNpwKlCZgQp3BhNZlDYzt6z1bDlUoB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Now that there is a printf specifier for struct range use it to enhance
the debug output of CDAT data.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/cdat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index ef1621d40f05..438869df241a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
-		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
-		dent->dpa_range.start, dpa_perf->qos_class,
+		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
+		&dent->dpa_range, dpa_perf->qos_class,
 		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
 		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
 		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
@@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 			 range_contains(&pmem_range, &dent->dpa_range))
 			update_perf_entry(dev, dent, &mds->pmem_perf);
 		else
-			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
-				dent->dpa_range.start);
+			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
+				&dent->dpa_range);
 	}
 }
 

-- 
2.47.0

