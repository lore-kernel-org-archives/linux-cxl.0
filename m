Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B3629
	for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487098; cv=none; b=GzEbMH3HBUu8T9PsgFWEfNuw+Wqz1layaeYiKx7QltLQBzOkygOtQtBypoPOq0hXvyIFv9sEIycyh5fVezD2ctLHyilrPaFbUvVkbIi0ppm2SmTHXa0cfpnE0JIECnSAfluW8HQIAtdz6g1KnOak44wRPXNM+uEa+nY9s4PlaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487098; c=relaxed/simple;
	bh=b/jFrdmnO0rpereLMILOqdyWlRK2prgGOcLhdtLkY2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDWUBdURJR9aHWzXzVMiDrowQm0mqXhCaF0H/TndtrY13ZB1bA5mFx8KigpFws2FlYka9wFxNN0GFPEa7jDcKf3xQf3QGS43WcK78nndzBlUpU2sGXSNw44l7hUSZYVxRKSoWhPHXpRBBHdJ+AC1BJrWW+jEqAjED3cgNQbYMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XzMIYjWl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F3X43dYS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XzMIYjWl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F3X43dYS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XzMIYjWl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F3X43dYS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XzMIYjWl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F3X43dYS"
Received: from suse-arm.lan (unknown [10.149.192.130])
	by smtp-out2.suse.de (Postfix) with ESMTP id A9EC11FE7C;
	Mon, 21 Oct 2024 05:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729487094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uasAuAriFvxcGrgTEhq3mB/oZjluKCLBsLF2xamV3dI=;
	b=XzMIYjWl+3lMXDW/rIa92hF3Z3sHYwhIClhgT5U8gOjlnRSrV8docXbliISPvsWCxGjFf4
	ZeM06ZtkY3fuHHklU6haofPgukrIoeSYDfWVLo9kIttup7WdRHBsUy4p/+3hF2bBwVkeZP
	GO5Yew+8wvowbCR08QaPt6+ElqxvLEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729487094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uasAuAriFvxcGrgTEhq3mB/oZjluKCLBsLF2xamV3dI=;
	b=F3X43dYSwzbHLg70Onaz1V5smCnqD8aG0SsCqXRXPFUkLzNEogxIqfZAft8luQtYygydwu
	ci+EmnGCOtulJkDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729487094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uasAuAriFvxcGrgTEhq3mB/oZjluKCLBsLF2xamV3dI=;
	b=XzMIYjWl+3lMXDW/rIa92hF3Z3sHYwhIClhgT5U8gOjlnRSrV8docXbliISPvsWCxGjFf4
	ZeM06ZtkY3fuHHklU6haofPgukrIoeSYDfWVLo9kIttup7WdRHBsUy4p/+3hF2bBwVkeZP
	GO5Yew+8wvowbCR08QaPt6+ElqxvLEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729487094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uasAuAriFvxcGrgTEhq3mB/oZjluKCLBsLF2xamV3dI=;
	b=F3X43dYSwzbHLg70Onaz1V5smCnqD8aG0SsCqXRXPFUkLzNEogxIqfZAft8luQtYygydwu
	ci+EmnGCOtulJkDA==
From: Coly Li <colyli@suse.de>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Coly Li <colyli@suse.de>,
	Kelvin Shieh <kshieh@lenovo.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH] cxl: downgrade a warning message to debug level in cxl_probe_component_regs()
Date: Mon, 21 Oct 2024 13:04:43 +0800
Message-ID: <20241021050443.318712-1-colyli@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.03
X-Spamd-Result: default: False [-0.03 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.57)[0.855];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

In cxl_probe_component_regs() the error message "Couldn't locate the
CXL.cache and CXL.mem capability array header." is not a critical error
message indeed. Downgrade the message from error level to debug level
by using dev_dbg() to print the message, and the end users won't worry
about the message anymore.

Reported-by: Kelvin Shieh <kshieh@lenovo.com>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..026690137bc3 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -52,7 +52,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 	cap_array = readl(base + CXL_CM_CAP_HDR_OFFSET);
 
 	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
-		dev_err(dev,
+		dev_dbg(dev,
 			"Couldn't locate the CXL.cache and CXL.mem capability array header.\n");
 		return;
 	}
-- 
2.46.0

