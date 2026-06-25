Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB63D9DD1
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386907; cv=none; b=TrCjDK1t4py5/HnnbMgRDv+StpJw9mXbZ0TOX1ZeHZFgJZFkwnxkeZ0fPwzxfEf3YiLFnsLA9UxBnKGkwD00FrceW1/Y6Tf77jPY9oJ+BMvStNvjjrucR5bYMXMF4fG9GagbxL03cXG3W9TnwmEwBGP3XQD5oaIDMksKPNVzXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386907; c=relaxed/simple;
	bh=b/Rqlb7CRq2lHk7bPAK4VQjGp6d+BXhYLUx1wMMJHzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAp4E8YU/gkLBqbzz3DgXBMq1dEImFSU/K6ayE4ponISdsxRCJS+YTogSH4mp4MEBHF9i2vCQBQ9tdbDIA4O0lYCPrdZvCEMInUDi99qkn+4wZ0KS/arqc41VOPXgHIQ7CpitFkyWmSM9TJ8K6hU08gXM3aWWOzuIv1Zh40GVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNQ+Xf3Q; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNQ+Xf3Q"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30c52f96f60so4046238eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386905; x=1782991705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jKp/0nhQptqz/M2+wfNC1AREQXAADTJq6niusW0KQg=;
        b=MNQ+Xf3Qj5HPerI8p2tggBCrYMbdBkVs8BcRSR6kx9qza4LlbmpTqn1O5PAlki+YMP
         DUf5SaXsYJ7xFZSH7PAO3yQr+z8kx5tTN72zSgW8vOZ1Jd847kHyCjcWHYlDuw+vGNas
         8l6+gxW+WCvZ+lCfa9MDNV3kgYiR7/G16XLkE6SzZ/8tx0kRZV4hgc1uKmeLEYPPw0lQ
         YAqHXwdskFLHW0ZCpXsIGza5YWbmUgH0+Nu6RS9a/zaAY/MyZNUa6OU4fNtlMB8oTBtw
         GLvguP+jboVlMImmXFVwm0FMC1l26Wi6rcrG6ndHko9oppye7B8B3g/+SsL2rDCCAOKB
         m7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386905; x=1782991705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jKp/0nhQptqz/M2+wfNC1AREQXAADTJq6niusW0KQg=;
        b=jbvEVhuphGFgzMaGo7NuW7EuatA4k1PNMr9tleK2k0CM/IEbiW+cjxAnCLP5v/kFsJ
         oImqGbLlZkJVLC9Fz6oMksIkxM6+ZIlb4vV5STYFmLcYmRXUs7CWP320wuW16BViaEYr
         REKkNKxFyzWeCwFgYGbSYz2AnHeW2Xec8VomtntbF5CoKalvVjoSldFwQgDl/LOIHEIu
         +ldd1DVAX/NPmRFAwDt3bcCJhX1/BBVmnAWGBWMGoHNicb41MV5ZE5IlO/4u+UyfpSHa
         5BMy/yAHJp99M8h6MC3+C8Z6p50G2N4OOmylWxv7WOIueDM5Apuozin8BBJT73VDvoIf
         SAYQ==
X-Gm-Message-State: AOJu0YxYSJQ7bHTW87Cu/DejF5N+6GN4cvrs/WClVLYAm0DVtRcYamOE
	PgjZuj4swUqIqu7sNOAzgp7PQrSdzBo0sTfSA3Gg5xnUJdcPBnmEQljTds4T0w==
X-Gm-Gg: AfdE7clBkJDndbfBH7fUmH2WQ1zzRy5lJgk35H/vqQB3aBMImMC0dKqoLdmeaHNjxc2
	aG8UAhbt01ARy0rqmejSDNdZGbCX0Bg1BQFl0sVKZ96HHzWktvz3KWbKMHigW1Xo+9p4DHlpMRH
	zWPZUitX2Wh0sH2BUJBUbiBot0eP+1K9TlXDfPBH7ZD/MJeddExi/SXTgY+OumrlSjG+l/icEUA
	W9mc2eNFbMCc/zhZfAkyRtfTVGJzJ41cAx3Xm0GP71kHeL+EI172CipfQ+DgStK3LrnECAFZ1Y1
	fqfOVBirrpx2Ogf6Mm6oL9TByW5jsg09UizMOUtcRctti3yDhFV/NZPabBhbnv81tbeUNA7FngE
	wrBxhsyj5rhroDVVpBkIO3HADs/AllpRXKTcNETmLTD4L84admqv94lEfwKFqVhf3qxhYEcUlPO
	Tu1DyQxlOZ9XJFoBDdQEx58wL7W1dtuz3ExZwMghwVFYo48tFXLTyXD5oXSbSVfQdcjcbZ
X-Received: by 2002:a05:7300:8184:b0:2ed:e16:6b4a with SMTP id 5a478bee46e88-30c84df4aadmr2221250eec.32.1782386904999;
        Thu, 25 Jun 2026 04:28:24 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:24 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v11 09/31] cxl/pci: Factor out interrupt policy check
Date: Thu, 25 Jun 2026 04:04:46 -0700
Message-ID: <20260625112638.550691-10-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Factor out event interrupt setting validation.

Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 35942b2ace53..8d12c684d670 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -639,6 +639,21 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
+					  struct cxl_event_interrupt_policy *policy)
+{
+	if (cxl_event_int_is_fw(policy->info_settings) ||
+	    cxl_event_int_is_fw(policy->warn_settings) ||
+	    cxl_event_int_is_fw(policy->failure_settings) ||
+	    cxl_event_int_is_fw(policy->fatal_settings)) {
+		dev_err(mds->cxlds.dev,
+			"FW still in control of Event Logs despite _OSC settings\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -661,14 +676,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
-		dev_err(mds->cxlds.dev,
-			"FW still in control of Event Logs despite _OSC settings\n");
+	if (!cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
-	}
 
 	rc = cxl_event_config_msgnums(mds, &policy);
 	if (rc)
-- 
2.43.0

