Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F917230BD9
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532544; cv=none; b=Wy4yalaRmYw+HxWHHPiHDPNbwAuUObeJ/AUaFXXzmgKBayP+OEx1oFK8BMSPlLOE8/71r+InpaqT9QHr9gKUJa/dgSEUoQQpuU1Yuep7GLCHL82yTdknye4twtIimsw2Ml7e7cDF6k4chrCmu1ZjpodY67l9GArqDtbwgEQE3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532544; c=relaxed/simple;
	bh=j/9mVNqgd3H3lCKYoEFsSh7Erats92mnr/9go8Rb2AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaEdYKl6Pt3zquMJAkyET58YYP29jl37nM7kJS80QgHPtKDgjvX/9t9blNSNNNBwxV29Wt4sdyYqSdgRNwe/JnEfJiB3TdVJUU1S0BXRf4StUafIubKRIDM/jUv3nCSNL5CcC0nu0BBlurM+yE4CRWmNO9qUQQqhFnewS9oJUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B8AC4CEED;
	Mon, 14 Jul 2025 22:35:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v7 03/10] cxl: Add helper to reap dport
Date: Mon, 14 Jul 2025 15:35:20 -0700
Message-ID: <20250714223527.461147-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714223527.461147-1-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
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
Reviewed-by: Li Ming <ming.li@zohomail.com>
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

