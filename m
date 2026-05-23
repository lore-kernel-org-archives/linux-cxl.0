Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FA38735E
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529435; cv=none; b=AesU+OgDv4NwtbTT5H6RMFw99EQTtAqqAOEp8cQdrZPqNLRnmZLZ7NLPaWyzrxDa06a9hj85FzUqYMuySnIGN4+RdejSkKc+Rq23EvAfHUO/MJBr19gl6oFs1vrIqMGSbQEf4IiEBvaennjOeMyeUATS2r9cDa1w3927cYzX4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529435; c=relaxed/simple;
	bh=cA6OvtiMYiH8fWm6hs/pB2NqRBhSnJLhmhXOqE10cNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2kmXxbKPSxN5jTVjDOO7aIush5FjljmrdUzXvJz92OXRhBEOJiwoy8KIbZx2vyhXlN+GmktZaZao3bM7OvMIAZ9Ac87MlzJHuBby9XfO+AngTfDWoMld9BplV3tsNUt847/wxLlHtmg2n53gsutNRJ7H9vNxv8x3OGc0IkoZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpi7iN2b; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpi7iN2b"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso12795990eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529433; x=1780134233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veSAHzzDLBJHWUT6ObwVQlgXBETLjKgsofHDN9ZwSyE=;
        b=qpi7iN2bE/i6DxBZNgs/At8dl3Zlt7X3cG6DGwIuObIOOkB/3ylh3b4H9/mYgjGlwZ
         PB84zWS1Ks3dR4epH0IyrWIPBgc15oDctMAisY1VEBOMJTM05+cvhOwGbKKUB2yeWV8E
         bKJt/TxZaNvaxzUn7qoWia6Nj+SC3OucyDs+QPw//R+4EGNRkm2zMIXZyZGq/en8Tfk8
         /ThPXghF2P6nMNiIc16oeQwhDFxOJxQGnE4mGvTxUKkqqs5KPmY/R46tFdm+EErU1ZSG
         CQjSM4Pgduwnn7uPwYOck/EhGWXuejDdJ4XzYpvUoktDlFBIUTKUFMFNda4QxcgR/y4M
         3ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529433; x=1780134233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veSAHzzDLBJHWUT6ObwVQlgXBETLjKgsofHDN9ZwSyE=;
        b=HLB4v6IFMSPvs6938vu0GXnG/sekoZFI59DZTvwWrO+MLn7McIQEeiuoq8Swl9Ljkt
         POl6YUB2cENZ8ILWCP2wxE2p8KlynbPPk3khfqqhJoM2zoiCgQn2qwcK8gLqApgWaWvD
         5lA9y6GK9N9TPy4SqvKF5Y4GwFYwaJWVXz6TAvAfn98ybtcdgT7OHS7aknRMrItCV+lg
         jWWsggzjHUud/5/6YanSmltd0SGzsJx5nK6fnI2bR0Gc7F0acDTIbeTNNlHoX8/rag5p
         PVBGfTAoN3ia0wyImQ6ZF8nfbNp7N9R6c6o/YG73Q7975uA+v/yA9ljIdctNw9Or/NG5
         zhQg==
X-Gm-Message-State: AOJu0YxoSJjONevwV6BY95Va8MyUWY+VTBygqxaPbMSrsKTv1jZZU/wW
	ljbNdG/r0IPT+kMBj0VCTxwDJQ4NUcp+IKsnutBtG74fsOGw0QNmzVA4usneCA==
X-Gm-Gg: Acq92OFaQ9L1on4LOXgmybySyPNXg0P9YhfZ323sGJAFCWyPg7EGkJnC3UH4FHR+EoZ
	hU11XKd9nVZl+H7xZUWmLek7nghywkCK8FjNTtDvvxMx2cX4WNz1I0qMAx7K6/HfZLaLhw85d5C
	39+00Lr64eT4KftLFwxlE0UikC1FKm9XWxJhU4OquTVMEoENBX6UdSPxbEjhwvcxSpt1FA5vbn6
	C76Kg5BQ1p0VPmzJQAtNd9ujcmoPuUZAwfiDd1AX3Ee/dwDr9+MauRs/rXRfjFn0/GoSR8qBmNL
	5Nd2exkrOnRdfDZTdnm0R8CeDSlDqBhO/hp0457CPoQfH1Gvput5nJLeVLHls2bBFCRSX/qMn6e
	8qPNKM12EuPyjOeaLhGNWy7yMvuOyhwZ06g8pxMD028iUnzoZjE8zglsSbBvT75erXRMnR+iRcP
	coGmdeHM3P1BhGAyWktyS9QxekkSuRowYIMEWqHeRcxyQv3rO4pCaKOGc49B0NTgNkT9MykBCtm
	3QngGIRikVHzq5+5g==
X-Received: by 2002:a05:7022:1e11:b0:130:6c8f:5a87 with SMTP id a92af1059eb24-1365f81e50amr3002026c88.13.1779529433221;
        Sat, 23 May 2026 02:43:53 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:52 -0700 (PDT)
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
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Ming <ming.li@zohomail.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v10 09/31] cxl/pci: Factor out interrupt policy check
Date: Sat, 23 May 2026 02:43:03 -0700
Message-ID: <a211cbf4417cfeac8ebb9152ff66d9acf9b2c085.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Factor out event interrupt setting validation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
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

