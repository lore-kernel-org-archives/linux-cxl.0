Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560E4AE8D3
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862943; cv=none; b=UMZsGTjxegUlfowKDQOPHbDlqSskl9mBW33Tkw8wRKW1tllEWB1CLz0hx+gs6dCfrd+4uMFJ7BitYSnCL1BUzDAE5K7RWJJX+ZNeVjW7+eqOox5n7zgBMjrYou0j/ElVNZnh20PPvhUpofIk0xWSZnuWv50VJXDgC3QAFpycFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862943; c=relaxed/simple;
	bh=KxlW7pE3yft8AwMyo7X6YBjNLPsw2oyjWvDnXubnlqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCGYVBeYIycWHByX5GeuaGMM7gKmWXmQLGLouBokyo0V+kh8Gv5yZvJ2RUS3KwxA1EOHX7Nrdmmkkxq9gv1muCu3Wi6U/DEe4rR9S56vI++eam2CdoGzDMOSnQqxvUzVzUDx4XHOQQ4j3IwzuWGDhGBbWC/weyGxP0RXFTfDfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ailiwfUd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ailiwfUd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso4788567a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862941; x=1789467741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRHewylYcBK5UEc/a/kasW/PpxdHQTVo3n2rnDIzZ3Q=;
        b=ailiwfUdIjRiVGKP1HG0OuqDnlloQmQd0V6KqC12RRW6KoqK0Qza9bpUh+4ORSqwRD
         tUS6kSG6RXvYMQ2q4tmHCm/zuXrt3JaAZzek7jU6pSTIO3fQHiC0eRJLYvrkNcfFv8SV
         0Pf6Gl/7zv9cAUIh3nnvsjAdsW8KJEPTh4jBttCKE/acwMA65tvcz5i6ih7OHAz1NMYO
         S1wzxTZu4jHaDo+9eQt1fM0R1Iq2MFETvSHqPpeIgi0fkWXOLXwUfPmZMUZ2c2kaW+fV
         +ruQeNOtIIzudIpzGtJrsF1KbwG5Hy9iXWIUb1Q208skD1PaKpOm03yWtURA3hdIhBsH
         Q80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862941; x=1789467741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRHewylYcBK5UEc/a/kasW/PpxdHQTVo3n2rnDIzZ3Q=;
        b=jWELuKaNG2FpScjyxH/7/CCFWUXOMTh17+amudqq0PeEYPUBCxoLXakR6vXyfaqaw8
         CtbGdPWd6gJJmjK+Z2ZRqiqk0kVCI1aqt2wnVsB4/Dupw2JdccHtcbjm3bJZnkYfcLEH
         PwIKvPCHEtXkuXUFlp5OdVnhHKbCiEFQzui3EIKmn47YJE2wDHoIYIZjz9OYT1Yw9TQS
         WqpDFd0K+aRewoypzEW3CChnwJ0gqSgDu033tr4bVhQIZG34izvWtj1dL9BMP1FIAnJQ
         TzS5vJVHXzwsdteYjpaBE8OV57nRtMUT2ncIaVli6GEq1uQggIAKbM3I9mJTL76MbHxg
         Tpdw==
X-Gm-Message-State: AFuF++kTVeK8+APE7cdSwnbdYvCPciAFfHbtrXYcAvgBVzkXinb1L9gw
	aKYjkqlPBwYoEgC5NayevQratSww5ONdPpIcR2mDT6cJvFKryvoMtowDMKAhXQ==
X-Gm-Gg: AYBFou2bKlB/pTwLtnuVRWcCkQfjB7LPzkfEs9JVCXK4DN+SCw+jdz+RZwp+NmjcpI9
	v1PP/k5qX+QNlzEzjyI8t46yTopuAwFMeTpqSk+TuChMPxnKCEerDvkO2+IdB1hX57qiqnc+FB6
	vI0+2BlB8bAHi+VLnWRFlsK5bTYSBITOZCbpN8BYcRBHTNGMP1lDlFENCo9zFLbOKnsAot8WEN7
	a5rOdgvADwU76ShNhUzaAUvnJzIDJRjr5E56/s+/EcYRhw+W1Wv3/tsBRJMW6dtG58vWh+j/BNK
	OfSsXCS4azieerhfNALJs2o6L0YfcDDo+wIQkeJSrBh6jqH0alMoLleRy9e2jiHNeg5PtLxubR7
	ZfUFFNDm1HNfretn2B5DuuaHa8amHX432SMYF9kYUXpGa/o3kjbMr1XaxIBJqAOl1yhwZcaHYtE
	m6o/pM7klwDvm5RZ+ag+Hj3cGcjmqsAYnWIDRidqa3CXJ2Oaeff1a8KeHEP8KMyk9lKnwq/D0xz
	QPgHdrbhUGuz/Utnxr7byZ5KhQfbSoaPxmVOIMKW+sDa6dXq7ArEfsKCrA/b+6CQKk5X1xMvt8r
X-Received: by 2002:a17:90b:582d:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-39b2627fe18mr43621096a91.25.1788862940842;
        Tue, 08 Sep 2026 03:22:20 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [RESEND PATCH v13 5/8] cxl/pci: Factor out interrupt policy check
Date: Tue,  8 Sep 2026 03:15:09 -0700
Message-ID: <20260908102124.2231730-7-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
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
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

---
Changes:
1. pci.c: rename cxl_event_validate_mem_policy() to
   cxl_event_fw_owns_mem_logs() and invert it. It never validated the
   policy, it reported whether firmware still owns the standard memory
   event logs despite _OSC granting the OS control, so the name now
   states that condition and true means firmware owns them. The dev_err
   moves to the caller. Commit message reworded to reflect changes.
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

