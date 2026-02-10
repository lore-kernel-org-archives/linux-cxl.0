Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C0319877;
	Tue, 10 Feb 2026 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724227; cv=pass; b=PJJwAP0PpwQ1cF++48LLu1FYa0pjHI5Bqur48utN9F2KwC4rlarD2RpNgo9ZYcwNMhncV4cGBQOVfsw9TSRHDGnlWn5PjzIPSIRNEKD4EaJo8Fi/HHyO/dBkXb7fBm7ALTGXTGdtLjYOU9T2NIeEGjaxAKvC5F4BH7nT92MPRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724227; c=relaxed/simple;
	bh=jrtuRImjEUTr5xX17e1u7Nwuz+W7uVq8j9NCrIKV02w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCiSUVUnfytUi3Fj7Z9UrlQTCSPNukhomlAG28SXfILk9hGJPap8sl+qyWtzsLhBW45w1YrhoN/KbohLc5YeV1b05vB0jtq9OOdyOqokmOVKQKA5hXV7vJmAMWMn3CptRN7IXsI5kQQM33baQvFFsBrEpLd2WN5QZHDnqx07T1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=R1RVZAVF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="R1RVZAVF"
ARC-Seal: i=1; a=rsa-sha256; t=1770724085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oFzPhf3gpaZRzFAPW/0aAApI1fq1cG4f3ZML0yUBv77tNURMPIaw7R3+QwV5zoVUD5jXHeSOB2vrxP/uPh3BcUGExAGUwMzQCN23qgjhRrAVxO/U6llnVv5jDzLTUmaXsdNdxaxiIdL1UoF+tqJqg5UYP9YFWhn+uTqhWAQbaAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770724085; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/sM3rw4letdW5hweiSDCcJVIY9wprZ2MKwMQZXK0xPg=; 
	b=GrquEIlbc7SfrtPmvdliAuqmWCeKMP8J/BivhRzF2+Qv5e+6vp3E3EvnPkqA1d7GhrJe22iYA97XuGDFt1kgFknxKEVLNyD9hhfoSP+o/gNl84Q29nj4JXgBpZrJ32N4uy2r9AwGwpqkwYPXpDMtWqOAQij3K2zRbJ49T+0yXGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770724085;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=/sM3rw4letdW5hweiSDCcJVIY9wprZ2MKwMQZXK0xPg=;
	b=R1RVZAVFBYdOKHHvq6XZ+AY0WHUgl+dUxgprg7lySLf2K2+L8AcucNxjkla9warq
	X8BQDVLuGjfx1gkaCBh8ZMcjHfUp4Jw8KtP14C8nIgCbYlLRmdwkStaomke3k8hX5JJ
	aeiIXFGZKx6EePLMv8wYav/NN5+x71gVg2gu2l9k=
Received: by mx.zohomail.com with SMTPS id 1770724083145370.58933083292277;
	Tue, 10 Feb 2026 03:48:03 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Feb 2026 19:46:58 +0800
Subject: [PATCH v3 3/3] cxl/port: Use port_to_host() to get port host
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-fix-port-enumeration-failure-v3-3-06acce0b9ead@zohomail.com>
References: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
In-Reply-To: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770724039; l=2225;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=jrtuRImjEUTr5xX17e1u7Nwuz+W7uVq8j9NCrIKV02w=;
 b=joc4bfiyQ1xCj5x1OOHS1wg6LlaXsmMoISKaLpyIUGpmIf4w6JwCZP04Idquc14ue2bVbBUHv
 jRKg+T2Xu2EBzveuuOpGlT/FvCHJOl2k5mG3qwgrzaqxWFShE7NMt8c
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228900d802c4ff5a8a6ef7fc686000042be4d3e74393aad9660da4438e4c53059c96dbea0ad6375128c:zu080112274c057a5bc230c725847bdf6000007b9eba8f5134798bb115c2e7917e72fbc5ea0e64d8c837ca9d:rf0801122d36934606d5232717a23e6db40000fbf621542dae993a6982e57f02b5f684deebb7115b0cac7c0dd3a0b2b49f24:ZohoMail
X-ZohoMailClient: External

port_to_host() has been introduced, use it to replace all places where
using open coded to get the host of a port.

Remove endpoint_host() as its functionality can be replaced by
port_to_host().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9e4abdaf209b..a45bbc620b4d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -615,22 +615,8 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent = parent_port_of(port);
-	struct device *lock_dev;
 
-	/*
-	 * CXL root port's and the first level of ports are unregistered
-	 * under the platform firmware device lock, all other ports are
-	 * unregistered while holding their parent port lock.
-	 */
-	if (!parent)
-		lock_dev = port->uport_dev;
-	else if (is_cxl_root(parent))
-		lock_dev = parent->uport_dev;
-	else
-		lock_dev = &parent->dev;
-
-	device_lock_assert(lock_dev);
+	device_lock_assert(port_to_host(port));
 	port->dead = true;
 	device_unregister(&port->dev);
 }
@@ -1427,20 +1413,11 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
-static struct device *endpoint_host(struct cxl_port *endpoint)
-{
-	struct cxl_port *port = to_cxl_port(endpoint->dev.parent);
-
-	if (is_cxl_root(port))
-		return port->uport_dev;
-	return &port->dev;
-}
-
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
-	struct device *host = endpoint_host(endpoint);
+	struct device *host = port_to_host(endpoint);
 
 	scoped_guard(device, host) {
 		if (host->driver && !endpoint->dead) {
@@ -1456,7 +1433,7 @@ static void delete_endpoint(void *data)
 
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 {
-	struct device *host = endpoint_host(endpoint);
+	struct device *host = port_to_host(endpoint);
 	struct device *dev = &cxlmd->dev;
 
 	get_device(host);

-- 
2.43.0

