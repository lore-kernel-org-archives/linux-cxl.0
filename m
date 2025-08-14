Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64A2741A0
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210151; cv=none; b=BMmEZXOGwTxWAVNgDYQz61sXn27IuaynmSZ7UQNqV7/zJY4mLX4NuzaeX+E0PiakZe6psUQOkd+6a8SijZVEjzdW2/OKgzdvR25cf+/Jpw3gBh2n4M3RgZpIxUzMvAX0jNnIl6IMJX7rYdH7MFB7enMZuBOzzHT6iUDWEA2hBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210151; c=relaxed/simple;
	bh=ZomzymkFqW1alGQN/8n6sQVtMYIg3flYaeieFmE3I6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQLBlwor6QBDnWsHVT1jiy87cIkt/0pBmj6rKewE2N5jIEPEV0mibLReGwwS95c0MvKNNMQpCRG1GCBhXOr5/vaC3xiTljvhFtn9EdPmG2Y6G/43gmeuOF7nbUb2w1Q+sU+T00oLmI5h2+IoKaxLYpN+bWyaiNHPg42AoQRNdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19632C4CEED;
	Thu, 14 Aug 2025 22:22:29 +0000 (UTC)
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
Subject: [PATCH v8 02/11] cxl: Add helper to reap dport
Date: Thu, 14 Aug 2025 15:21:42 -0700
Message-ID: <20250814222151.3520500-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 855623cebd7d..fd316e9bd59d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1441,6 +1441,15 @@ static void delete_switch_port(struct cxl_port *port)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
+static void reap_dport(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+
+	devm_release_action(&port->dev, cxl_dport_unlink, dport);
+	devm_release_action(&port->dev, cxl_dport_remove, dport);
+	devm_kfree(&port->dev, dport);
+}
+
 static void reap_dports(struct cxl_port *port)
 {
 	struct cxl_dport *dport;
@@ -1448,11 +1457,8 @@ static void reap_dports(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport) {
-		devm_release_action(&port->dev, cxl_dport_unlink, dport);
-		devm_release_action(&port->dev, cxl_dport_remove, dport);
-		devm_kfree(&port->dev, dport);
-	}
+	xa_for_each(&port->dports, index, dport)
+		reap_dport(dport);
 }
 
 struct detach_ctx {
-- 
2.50.1

