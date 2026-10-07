Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3E3939D7
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404330; cv=none; b=uGHtXL2m5wDJWxQgePsHbwhYlg4NyEXjFSlj2SOawLQYIJQYvD/o0+GSI2ehQmnCRHZ3CjhfoXzaQo/8FUUkTOSOEz4CRnLgGT4pK5UWM66+DIsA/a/50PcokeMG4nWQL3HuYMYM9bUZyVklGd7CwUXCvUrHKe3EwcCJyEErXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404330; c=relaxed/simple;
	bh=aq0AMSyhxQLdXuPHgvAFBRB0ypmluL2Ow3NcbByDnYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldt9sZdb834g+cUrxFJ3ER9hIl9IeSghJXPUtnkzX7ijFVRRt66tJfnLD0SOehaB8s4sG0mrF9XELeSV6omgmDO0Sqo+rJ4xrBEaTDNC0xqoEOn1JOdb/KFcQGHmIri/V+577svyjjHU5xY2/v4SxkxB024EOQz8H+oEF/qqPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPOJ4isa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPOJ4isa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc758830601so2971835a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404323; x=1792009123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4ajd1qKUyYuUsNFBJ1eWwssuwOD2W4HQfyS01t4xII=;
        b=fPOJ4isacEdwIMVw/FUu+UYcftTvtgrxjxNeq/MT+GIkL7dtgVikOimUhXxq3eAKa0
         dGVkOPWqJcNcBNKLME6GO4+lXFNtelywA8/B7jusZ2cIYwOJcI69uf5KlfAdgwTsQuS9
         +G61CzRgnjWoBt87CQ2FQPgkSYt2wo4fmvtofZXeWMkXVnPsmR4fVOoOubJxt4bNS7pa
         Uq6t4dZMEUkrP1nMW4ANgFYKjLyih8LJ4Cmw0XZBD2tcC6ZYsbneDz7jJluhvWgmhaXK
         +5iuEH6btJx3vZlK9Kbzki0tjxvb6xjLb9qSnNKiY0QcjLHleB4AHPoFPgcybleilXUL
         gt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404323; x=1792009123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4ajd1qKUyYuUsNFBJ1eWwssuwOD2W4HQfyS01t4xII=;
        b=Zw2I45qZPgv8tbAzEth5TKT2+WwtSL36ZTjcc7C8XhACz6ss2VyK4gRfUoEGR4HGpv
         +Glm/bWy/zEi/zvm/p5wjPIwD+nn6rz349CmVPi27Ii7Oh7gMs596y9jAYa8/6CLhyrN
         9ceY7A4RPVr7uK8eNEj9g64pSxMP2Pm1Bk61OzW3N8P6CQuSVCA77WgVbJe/gXCeG+M3
         7/+U1Mqr6ZkNLqNikfzNMmNObuHQkqqMaDPw1dxeI3MqjZOTBzBWMSV9dLG1M9qTi3G+
         3q/qEbP2OiTb1fT9PKoJgHORNtz6+3Qru+X5l1WVSL65CGU+rPjul2WuasbFH47b0ah+
         0tIg==
X-Gm-Message-State: AFq9FYJRGM5eyIwD/ijrTUwWISY6HUSvsGyKorqIasTGFy9+HGr9MDaf
	Nawj4djd/VfFL0FnpCRob6PphYWk8n0soowKgERgnEbCmz+FcFgzZxp4fan7tw==
X-Gm-Gg: AYBFou0qLAFiyoCC6xdWog3pD1vfHzqWYt/zRxaTHk8skylfYWbfmT5o2cxjYg/XWNu
	P/zFhUP0qPC1fpn+iihXIrlgKgMZVgJfihn4NJNIh9aQgXHA+EX7hC4hgJJei96AuO60tnmWhTk
	PgDbvJ5hdkWngpisMxL3erNVHg1S1HjVakFDRVKShlNt9ZCZ5xBtx7bTF4g3j9b44FonCfMPIsi
	YyfPhnzf0/8cHvHagGI2OCKUiVTzPyLfVB7LGdJ0yF7RFYFk5+7RXdrZIjuLKUtpyEVZNYRnyuR
	FTrU5Q8N8XCxDzmW7q7OsZ13Ihuizd+ufnr1R7+i8FCFB3rgTJIjb4FfOW8eFTXecSVocOkiY4K
	xGyDhQgzbXhbHdXkEv0ucOvyDkdBiPUAvTLJW47hhyiNfnsSYge2b4gVvzPDEx/08Zj8nPCth4D
	LX+CONiNvjBFzJDvvCHa2PoLQtFB4y1Dk6o0eDsbCzxbjorPGGzdkD+m01QzgUyeHpR09SPkJJu
	MCPshoSnVKroS7UlH1+2YZDh4ou26bIe656DRfwof3ErlUNw+v40W3Hx78pZAbWiNkzamFhFOza
	biyH+X9PVFwLLg==
X-Received: by 2002:a17:90b:1344:b0:3a8:7bbc:3f3e with SMTP id 98e67ed59e1d1-3a8a1b0071cmr3203301a91.41.1791404323214;
        Wed, 07 Oct 2026 13:18:43 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm967623a91.4.2026.10.07.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:18:42 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v15 5/8] cxl/pci: Factor out interrupt policy check
Date: Wed,  7 Oct 2026 13:16:38 -0700
Message-ID: <20261007201828.952-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007201828.952-1-anisa.su@samsung.com>
References: <20261007201828.952-1-anisa.su@samsung.com>
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

Factor out check for firmware ownership of memory event logs.

Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4867657f5526..7b754af2168d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -640,6 +640,14 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy)
+{
+	return cxl_event_int_is_fw(policy->info_settings) ||
+	       cxl_event_int_is_fw(policy->warn_settings) ||
+	       cxl_event_int_is_fw(policy->failure_settings) ||
+	       cxl_event_int_is_fw(policy->fatal_settings);
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -662,10 +670,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
+	if (cxl_event_fw_owns_mem_logs(&policy)) {
 		dev_err(mds->cxlds.dev,
 			"FW still in control of Event Logs despite _OSC settings\n");
 		return -EBUSY;
-- 
2.43.0

