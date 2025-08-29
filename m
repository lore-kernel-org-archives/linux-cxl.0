Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DE341ADC
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490997; cv=none; b=RV+5Y1KDJRNOtaVOjeLP6/29xMbeTSxlgoYuXny2Tf8wYQA6KN03NpzWB+0kgM3uz6ARqZPm44sQWc81BxuHb9U3dAuxD4OZrZ5sEwBM7ngnHcxUla73qx8DDvUl4pwgU2G98L0txFHS2ty51M7Izjugq0cOioSCtM6evgvryPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490997; c=relaxed/simple;
	bh=9LsvV3HdGeh8nVxaXVmpOSdDiAQ6aWB+/Cc2kod8lrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8baqWa3w4R+ouuzMRA+Xfb7E+Q8F5tiOnxuk7Y8hLFUJmi23LHJHaUYfq7gqvUtYQHmLM3OvBL+UZhJmuMvemSgUuMCDcpIAECjH7ttgi8OsnlRjYI5NBUoAJZXB5pmkTRrkBcoilCTJHcKSecXA9h/rL0x4IqP9okP6uJ9w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E642C4CEF0;
	Fri, 29 Aug 2025 18:09:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v9 02/10] cxl: Add helper to reap dport
Date: Fri, 29 Aug 2025 11:09:20 -0700
Message-ID: <20250829180928.842707-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code in reap_dports() out to provide a helper function that
reaps a single dport. This will be used later in the cleanup path for
allocating a dport. Renaming to del_port() and del_dports() to mirror
devm_cxl_add_dport().

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 855623cebd7d..88f19abf3327 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1432,7 +1432,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
  * through ->remove(). This "bottom-up" removal selectively removes individual
  * child ports manually. This depends on devm_cxl_add_port() to not change is
  * devm action registration order, and for dports to have already been
- * destroyed by reap_dports().
+ * destroyed by del_dports().
  */
 static void delete_switch_port(struct cxl_port *port)
 {
@@ -1441,18 +1441,24 @@ static void delete_switch_port(struct cxl_port *port)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
-static void reap_dports(struct cxl_port *port)
+static void del_dport(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+
+	devm_release_action(&port->dev, cxl_dport_unlink, dport);
+	devm_release_action(&port->dev, cxl_dport_remove, dport);
+	devm_kfree(&port->dev, dport);
+}
+
+static void del_dports(struct cxl_port *port)
 {
 	struct cxl_dport *dport;
 	unsigned long index;
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport) {
-		devm_release_action(&port->dev, cxl_dport_unlink, dport);
-		devm_release_action(&port->dev, cxl_dport_remove, dport);
-		devm_kfree(&port->dev, dport);
-	}
+	xa_for_each(&port->dports, index, dport)
+		del_dport(dport);
 }
 
 struct detach_ctx {
@@ -1510,7 +1516,7 @@ static void cxl_detach_ep(void *data)
 			 */
 			died = true;
 			port->dead = true;
-			reap_dports(port);
+			del_dports(port);
 		}
 		device_unlock(&port->dev);
 
-- 
2.50.1

