Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B064298CA5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585241; cv=none; b=MY+iMsV6KLd1vpnuLz3PICBBXSJm3KigEnE2qItGgdeu1Ywzwj0Tu+jWqBfX/tAWuxwnfMSWeGjbq3lTpkY1iRYIRXCKy0Rm2b9t0Mcjq5pwVL2b9vMVibTqsF4OfIswXQpbUXMjJgZyjNIXOmL+qjR4HYILx1etSUmHtoOT6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585241; c=relaxed/simple;
	bh=HkRMufFei+tfu9b1tSOKx3CrgWNwTeFZwR2xKevh39o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDF1bOYQq06UpGTdxWdxSixc4onTntTQOFydwVb+j0WK4Wfv6hiKok+yNbDgf654MjYK7WLocRxJg9Z17tYhxMJT3MQN296g7oL2mA9gQX8uTO/CkJ7VHt3LuScv4Sjo7CQ2CzUsrVuOi4z7I0/9bhoCRotTzxyjCLyF0lrLbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4FC4CEE3;
	Thu,  3 Jul 2025 23:27:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v5 03/10] cxl: Add helper to reap dport
Date: Thu,  3 Jul 2025 16:27:03 -0700
Message-ID: <20250703232710.3141436-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703232710.3141436-1-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code in reap_dports() out to provide a helper function that
reaps a single dport. This will be used later in the cleanup path for
allocating a dport.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a49491c14d19..9691da831224 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1447,6 +1447,13 @@ static void delete_switch_port(struct cxl_port *port)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
+static void reap_dport(struct cxl_port *port, struct cxl_dport *dport)
+{
+	devm_release_action(&port->dev, cxl_dport_unlink, dport);
+	devm_release_action(&port->dev, cxl_dport_remove, dport);
+	devm_kfree(&port->dev, dport);
+}
+
 static void reap_dports(struct cxl_port *port)
 {
 	struct cxl_dport *dport;
@@ -1454,11 +1461,8 @@ static void reap_dports(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport) {
-		devm_release_action(&port->dev, cxl_dport_unlink, dport);
-		devm_release_action(&port->dev, cxl_dport_remove, dport);
-		devm_kfree(&port->dev, dport);
-	}
+	xa_for_each(&port->dports, index, dport)
+		reap_dport(port, dport);
 }
 
 struct detach_ctx {
-- 
2.50.0

