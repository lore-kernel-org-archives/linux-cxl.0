Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBC32BF5C
	for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185412; cv=none; b=nrGt58F+Q1tfDfFo+UGvpGZSy3h2FwrjWokV3vSvrYLmVggTAxa2rehEuEBc3/hLAYKGO6u/Y279eCyWS70hrzkI6nTb6ROPNpTQW251qYAgR5VRZ5EWHKwCkM037rHGvkTTtik+aYyReplKQkwGC9a+2/QJRPdTpcMvJgJKH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185412; c=relaxed/simple;
	bh=zg2VKuwFsN6029euqX1jn+gIisP3yKnPstGsmq0VUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY49948NkIyjia9E11vZGPPqeAORoSSppudgZsXq/XUz+6Ii9OVaFlBFHudbEk3YLx8CJPPJjDUvVRw0LcpL6HZvCd+DQhJPjXAUboVUB+20J2NuC5MORHO4a19O7xGV9LrxnAgaS7nr2Lm4Dv2fTr68o5hb8n3ZXLAK7f87OS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pI8TsTT7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pI8TsTT7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b2b289925so29132671cf.2
        for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774185410; x=1774790210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PihiyqdH9fgSKKz89FjkxG4uYpkRrGrjVrq6arvX1sY=;
        b=pI8TsTT7S6uJKlTUS/3DbbRnMSffLyOR2T3v1Nl5GR/VapsAUFF2o3qx0rBhuGEZG/
         3Yb1CHTqWmmgfXgZ/zD8Vdmbi8fyATMQeFtAc6wW7P0UtcqcoJhWIWjIYZrQxkJ+huwi
         kg11qDnzha+D5WsGpdXBrUA6ePS7sZwmGNWnR8FGL1lZ+ogZ5E9atgTXnupwZrnLAope
         5jhp13baMgwp4e+XFrkoofvZRHn++xBJ9x9hRVNui1pP3lVwJs+b4Eqsat/svmbNQWA4
         v2i5Pa7WcbDQZoBItBV5L5nCGY/FA1Czl5JvAcTQ1tJa2GZeMRFvfase8r83scfYiV7m
         zu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774185410; x=1774790210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PihiyqdH9fgSKKz89FjkxG4uYpkRrGrjVrq6arvX1sY=;
        b=CCrUonLoHq3j2I8LZgbYouDZ5Row3mltlm+KFXyyJnLERM9tcmHZxejII+yGB7V26y
         1GJDOTlUJcrbASE/aBBpJhTbeMUsn4wIGoqMNxLmbeTJ2g9er9aqM7olgZvlTyCyYeKI
         01oiwh44bAclyynRFOHEBRfoqq+LfhQpvUGWqi+p62/NOwXQwg9KVmyS/Ys+XO6TG+D/
         fXwihHGU1SD7Z6diqlYqpAT8U4oGh6+nrcfRwKv78R6vZGURXdvce/t78fewOu6keR5l
         8fJC69lPsyl7lU1Pg2PZKLR7+PCmTTMaUXMeGf85Qawbg9RfVE9aG/1QzYjOtmODWTrK
         2+zQ==
X-Gm-Message-State: AOJu0YwWCG0ygkrB8jg0zgipc8KXXxo5J6gqEZs4CmmVqtwYLnrrUrS6
	pHEcxBDVD3Dyz66ulpvnfZ0kQf+B68UNl8285afgguyK6N2eLJ9YcNlSVugl1vldoXxA0InkUWE
	7IaO6
X-Gm-Gg: ATEYQzyZ7ji0VppYwbeU2s2kPVk6hyTWU3lmecuulTTex8BjH8Ywf5rm14/sDCasqfE
	OlMVJB/iuOOSJYkZ/1LlmsG+YhJqCXrteOKmYAqZCXZniFuY69p0pvTTPkQro9SirmTpK5WYwAF
	0FHbd6uzALxosx4wFpQMnZ593I6+Fxl1+Q4JnsnHbTZsojFcTdBajooBjGw4nwdwCsFIc3i7MOO
	DSPJAOHq4OXhgR8Ce1qIMmiT9RNzGZJANIBlhLjU4W7dyKTqtzSbv8k9e8JwxjiZPMRi+Za5TEz
	bE7sfWBK+OH8xp+VufdghRny2/TQH6jIB1GnlTOmZfoJsVMCyOxAiY0Da/aUwLxPCFfHDDM0mcc
	FIkBDoLg40jU0Msl9J31VlNQvVSOLkYMwJDNW5fpXkwBCHHXIwhk1Tj8E+Ky5suYaySvZd4k4mU
	cSAlnUfeqiuV+7DSzk6ET8ZM+ztUslFtcR3yZzN4X6Q4raOVb4sY9u6RG773bf8ZQxckfrz3bqT
	nnaSuWbiyMKqEM=
X-Received: by 2002:a05:622a:5a0d:b0:509:44c3:5fed with SMTP id d75a77b69052e-50b375a3d3fmr136079121cf.55.1774185409857;
        Sun, 22 Mar 2026 06:16:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e35086sm59688651cf.18.2026.03.22.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:16:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v4 3/3] cxl/core: use cleanup.h for devm_cxl_add_dax_region
Date: Sun, 22 Mar 2026 09:16:38 -0400
Message-ID: <20260322131638.3636725-4-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322131638.3636725-1-gourry@gourry.net>
References: <20260322131638.3636725-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup the gotos in the function.  No functional change.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region_dax.c | 13 +++++--------
 drivers/cxl/cxl.h             |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index fe367759ac69..de04f78f6ad8 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -81,29 +81,26 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 
 int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
-	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 	int rc;
 
-	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) =
+		cxl_dax_region_alloc(cxlr);
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
 
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
-		goto err;
+		return rc;
 
 	rc = device_add(dev);
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					cxlr_dax);
-err:
-	put_device(dev);
-	return rc;
+					no_free_ptr(cxlr_dax));
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f08be12e0e53..249a2f5ffc7b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -712,6 +712,7 @@ DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.53.0

