Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979126F2A0
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871641; cv=none; b=lpDODSn5GN/o9Dh4z1rhV/GP6hRFD0sR3O8pII7sjrEAY3mGus+rEIg+mljnsHO9PvEoOUmG+a0tEvmrm+QdLZ1RN9tgzlYu8uXNDKweFRlRfBMMLLFzg7NQc23mxfcyir9zWR6TEUl+0dawExYegCM7eyMYsAQFeoSdrO5UNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871641; c=relaxed/simple;
	bh=cA6OvtiMYiH8fWm6hs/pB2NqRBhSnJLhmhXOqE10cNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSYxqhfDcjyk0AzhoKK9kufUjUCma3yOr5CsH0tctWJBkd3nPM6Y6yZAi8Z70Bp41341g7wyKAP3arNeOSEy4kD/iHnfG9yqLdZgB0EBgRQIJPElDcy3SID9YoXui7GZsLpdLG0G6PfznMf1e8InmPHj2/ukIhO+1CjuNuHsbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp12S2mL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp12S2mL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7a43424f861so22786847b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871639; x=1776476439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veSAHzzDLBJHWUT6ObwVQlgXBETLjKgsofHDN9ZwSyE=;
        b=Dp12S2mLmE5EpEVz6tZEU6ehfpAYSVFWP9hiaYcNqeZDpPCWUmGxKLsn90uqJXL5ly
         7itEZ4uJQZmDUm5FGuh0E1ZaUzphVDd3coryueBhyMoUrHjTfgcaGuni4bbpU/9gKWtO
         cohuduH5KVkXFGPzG5vainWJ48b3LIBTFL2FuT/UtudYPAxHsepVkP894X2j9r70XeQJ
         BCjXN6Uez8sjyqP0KxmcB72XWUiTxA9U8zlwbfr9jOhpBSj1FQScMiv/wMHFW15ivKJL
         Q50/zNApaE8/gIT03dWVEYaZaW/Zmeu38K/1z4POlqDGiRNUdQrwhO8wEN/XBmhsFNFL
         tMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871639; x=1776476439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veSAHzzDLBJHWUT6ObwVQlgXBETLjKgsofHDN9ZwSyE=;
        b=lkht1z5BgVibTXgpkWftbW2YF3CqsSpOUUOdM/MCzfgz+4621uVPV5NbDFkvLBdb9k
         UToBs2j2O+WmSudCyFLBXkyWs54pQV5PTAemMOVASftgkKMLV7gluowDxnAV2UhfQrZY
         dayeHflx+iwrz/I5SD0st0RYgddJ7jBamlWrJWP7JBND4QX78tWC/emBJWu7TNgI+05D
         Cpm8vo72W1OTC5VwdtUbNmQMBsTNkgyS042vprFU8gAf8a2y7AwBO7vufgUa54r/yCKL
         qJm908gTmKdbylToaMyyqoOmr6r58cYnA5qwRXSkzF3zZaqAN6Z+5JBdewZBOQ1VQrsE
         W01Q==
X-Gm-Message-State: AOJu0YyX4Rbz1BfbuBY/C6gGthJqvoRB49u3VHTPSOEkfacAYDc2ICJq
	LVOqCQpPGyG5/Hq+giIxLcNT5ZLxtDjcU/jFBob2WHWnrgC1wy9rj/J/xOEDcw==
X-Gm-Gg: AeBDiet6+SbIK4k+zlJ+do4ub9TCGMINS5NCNORZoh5L49G9veZ162T1pmucSiz3lkY
	e6rzD97ACfchC5qbAvtoQEP4DGHu7CE9uKXZfqo0n6brFJ57AJmvf7f7EyQPylryKZN7vYpmqZ3
	+lZBS3jHIKbnH+DT88a8O6kLt/qYfu+WTCKvCOt2gxD6lfRpczZRI+a2GI6PEfmXjWWkg8lOQ6p
	ncvpcs6721Bvlk9yairWVnUUiIPjSs2oKQudD6krqTalUTgST0UqsOZNW0VPxhX0mem/ogE8BPl
	CNF/SUh8jKmpAH5UaQRCq6wDCmPDJ0TKvtscqpgnfvgcUERMDhSUUKW9Obhd8FPYTycpiaWZkW1
	00OQUm/FgKdoitchcEWRJMGgbo2KF+PBOXSfqkiG1pM04rKd17/yTEU8WJaLK8vA0afaw0xo2Tp
	fyHIbYnqJ4pCdaAS1jrf1HXm+wgA6Ckbua7/YGdxmWrg==
X-Received: by 2002:a05:690c:7681:b0:79b:f4e1:a5b8 with SMTP id 00721157ae682-7af6f2290cemr43491787b3.8.1775871638917;
        Fri, 10 Apr 2026 18:40:38 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:38 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 09/20] cxl/pci: Factor out interrupt policy check
Date: Fri, 10 Apr 2026 18:23:04 -0700
Message-ID: <20260411013958.47422-10-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
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

