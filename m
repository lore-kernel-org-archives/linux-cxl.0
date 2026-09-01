Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCB346A07
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222590; cv=none; b=XjHZgduX2bX3sA1rhblyZC0ajgopxTIgsmbJw4qesEzcKEk/+onugv8LTR4FpYS1BAkF4t482n822FCSBOVQGxdHFFyQstKqiOIga0HPtX3meApS+O85TGqGOjnbsqRPGhQEKn2ooFz2TUQW94WOyYDKPwSc78KYIv2QWLlhF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222590; c=relaxed/simple;
	bh=A+mxQOf+BvSx4wGarIQzA6Sq+EhnVpHfIBhMsKimd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0xranoPTuD+VendDa8/GE3Cp7XqD9dI6gh7Z9YHC2ipcU2VeXl03iIg5aiPcbV+S5cxfWEYB3pm08hceL8xmnLNDFiZ9Gfy9Tnsq70TTL2CufSqNsSJsLCWknKLXCFjtmCvYk/O0pnw60ExlCOvC4T2v6GsNm/Csobz7DBkPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwErkXK8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwErkXK8"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-865bdc6ed72so26339427b3.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222586; x=1788827386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pup05/JP8Wr9ADhiiVIjKn3tG7KZ68Z0VZEv26PjtVM=;
        b=RwErkXK8MZFwDq9XJXF3etoOOvQBA8KiwHKUx3x+n6bzu+5Hg1ZSF97PNN/wBZzSMy
         75b1WBuncC877iSbbpQh6UWQNkymj0NSClP5l0YfwfRRU6Q3GeMI4YN8SHJd0q/XF+3K
         c1Zgicx+FhkrC0HVeK5KlAMwdMWcG62AhKyOab5u79nOmrWK/k4Mc15XRvMyywvs7IDJ
         uKFYVKdA0B7xFW4a1JsS1MIH89MUFih3JL9LwnAq8myLruffjLxZCs3BpQRuBn1B8dAC
         k7B5q5Hf3Fc3SkAUsp8+GsAWlyciTBxKJCsEEivZuiYJQ5l/fqq9ZoP7zJBvaN9SUDXA
         i2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222586; x=1788827386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pup05/JP8Wr9ADhiiVIjKn3tG7KZ68Z0VZEv26PjtVM=;
        b=gS96Sv90DlmD0sjn9q9Dhl0jLLH4Np++G5WYhlzQy3d/Tju5CwUzcBGW6bNggOpibX
         XW+rnPsVaTSMXErveUSlpfht9pifMnAyLMxXV5T8KvBpV0SVMiaVLf0dUkkuTizncLnQ
         oGhISXHFjD5KQlubIJTdaRjZkSoWcDujW19gn8vGEZrfc8v1EV9vWrCWGa83XrTGQhX2
         afPHXNBJctMN0WAVqgZ19OhjnfMRKlWP0Z8/b893p2dzYaIFIw2IaZLowGUl3eqlalI/
         L9wRJIg0XS7UpeX6vreqmVC5wxUDZG+QxxP8NC5HRpi6iXyPkS033VsHvWxBWNMxRZ9V
         8J5Q==
X-Gm-Message-State: AFuF++kiCd+n8qx2kq4I8DYgi5DD83PWCToOba5cRZIGdQ9GhbMdF5k1
	6OAo9vwfMn4HJZZ8wndGkIonu2ptDiUZGQz+g7EmJqTFQ4Vrn8SZEWEbKeJZ6g==
X-Gm-Gg: AYBFou1+XH0KmuI34+0ZSTbqCrCujyjQpcaGW3yRCZCAM+UI8hjn+UHru2HNANEqvYq
	kz+x6BX7cg52DIGJ+T7gE+kVPKNoOL/oKRyCaHkjUEBKN8vMXFRbLkT7vg1DQMUXKioqlV0rg7G
	x7Gd+k2Du8OC5a7SYW4GjSm3aAqwUh0LAcdkNMnx1PvuPOI95XH179JACpimqB9wC8qQoNN9mW8
	oosgx+DuylktUeyb2TpzbCFNQTQXFc6pfjiy10ROCJzNS/yqcAxW6JkOJH1zZ3sMOAhmQ3aopGo
	ZttYdEdgSHga81Ec3htKxjCYz81YLvHPeVENohYf4WHKZ2B1U4QUW4jjt4ZRdjqDEN9lx1C6M1n
	arrR29+kB1AaoIe4DgwBeIvF8bcVq6UuMVfVLa4IAzwRNHHgdwPg0w9fYPbVFWwG84eHkc5PSMH
	kQv1qrOL+WhfeSKj4lpjYLduFBJDD62LMfuzCk34gnbffweCgTogU1KZ/IiJo9DAt3HIf5es5MY
	aZiBs/nAedLzWSA9PjO/BZHnlq1vTcpffdEUrk=
X-Received: by 2002:a05:690c:e142:20b0:81d:a225:ecc0 with SMTP id 00721157ae682-86873b610ebmr18069507b3.27.1788222586063;
        Mon, 31 Aug 2026 17:29:46 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm63349177b3.34.2026.08.31.17.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:29:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	jic23@kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were processed
Date: Mon, 31 Aug 2026 17:26:57 -0700
Message-ID: <20260901002912.958-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901002912.958-1-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_event_thread() returns IRQ_HANDLED whether or not it found
anything to do. Claiming every interrupt as handled means a device
flooding its MSI vector is never detected.

Return IRQ_NONE unless the Event Status register names a log to drain.

Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 239df18c9c87..94ff2b7d1f09 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -528,6 +528,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	u32 mask = CXLDEV_EVENT_STATUS_ALL;
 	int attempts = CXL_EVENT_DRAIN_ATTEMPTS;
+	bool handled = false;
 
 	while (mask) {
 		u32 status, drained, stuck;
@@ -542,6 +543,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		status &= mask;
 		if (!status)
 			break;
+		handled = true;
 
 		rc = cxl_mem_get_event_records(mds, status, &drained);
 		if (rc) {
@@ -579,7 +581,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		cond_resched();
 	}
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
-- 
2.43.0

