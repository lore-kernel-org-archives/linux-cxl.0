Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34C2071E9;
	Fri, 18 Oct 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280798; cv=none; b=QgE8o8gnSmBkoOMLcTBXc1eAEtT6o5UQk0ZzDHDdAAXjmeMQH3JbANGVODqB8iEwZPNDUXVAqhDQfT2aXsLjqWt3UReI/zrm/nkZS94yyuZaW+z27pGNWiOVlQfXQmjFTLJZF9+SgXd0fWUFXjE7W0cNTnf9axnUFYtpglekq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280798; c=relaxed/simple;
	bh=/JeMO2fu7enk080lSjfE13zH8ww++AGV97ihDY9Z1G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRp6K1QyMClaC6tHWqSBfcsFBo92GpOVCqvGieE7m4NS3/3c6Kr7DftnUYjbiWrbWuJ+I6vKdY7I+uKNdmzGaLk0f4DxiSFOeDuyxmbv6r74t0SttasB5mjMq7gtOMMexvFhw+CIfYmvhpYerVeayPynrVHQXK7nQoV8brCcom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/anIrzH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/anIrzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280797; x=1760816797;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/JeMO2fu7enk080lSjfE13zH8ww++AGV97ihDY9Z1G4=;
  b=W/anIrzHPInrWlpw09VZuUPT2tKuQXxA0dmGVyJ1Uxifu047rzEi9Zt7
   9E0bPhwbibbUucThY4M1dkOANzIs+YvVrgvPhcEfCRwG6u4oyDp0AmK2Q
   4m5KxM2hh05KrcI9Jd62AfMAQohRBPbzXJRrWdr+9bUTW178eoNfxdfMv
   Zw5/Rv58R5S8+pI/bYsOazKyqWFq72ezESGWKjyA4Udau2imnwVsdDOsH
   4rH2xVyb93V8Or1Twj3NENUABZxPG4FSsT1WmTTPtwSzLuQNS+pScpfFk
   cCSVGjNBebEtjmXLMiiBRj6TUYt/UDfdExYWPaFXKDFKavDVV0uq7sVc0
   Q==;
X-CSE-ConnectionGUID: Le4112cyQd2/m7q7ZyBqPA==
X-CSE-MsgGUID: uP5zL71lStiakzLMApF0Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28704469"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28704469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:36 -0700
X-CSE-ConnectionGUID: LB7sNHGETXGuCIc+Tuqhvw==
X-CSE-MsgGUID: 5zmL7R7LSMOxg5ipA4decg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79017591"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.109.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:35 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 18 Oct 2024 14:46:26 -0500
Subject: [PATCH 3/3] cxl/cdat: Use %pra for dpa range outputs
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-cxl-pra-v1-3-7f49ba58208b@intel.com>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
In-Reply-To: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729280784; l=1437;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=/JeMO2fu7enk080lSjfE13zH8ww++AGV97ihDY9Z1G4=;
 b=zLjjim30L5onOW4NpnzoIUsh/fvGuaNQH83i+1j4TebZKv0bkUxZzY1GMt8Ak4d7IOTebFMyp
 7DEuGgzmN++DzlOCC9VQHn6hsIgaAMoiBt2MYVvVhlbeo+7LGSNsqSp
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Now that there is a printf specifier for struct range use it to enhance
the debug output of CDAT data.

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

