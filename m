Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2E25E469;
	Sat,  7 Mar 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772862794; cv=pass; b=HG2+iftV89z7RpBHGlY6pxyikA+dVy6CMV3XtXrxQTmQLe9h0zbCeZrp0fDueLWffERDqiHNUJ7Fi5WiM3ot1zYOf/ENYp5VK2o5H/RAp9Ef973Kyd6hZkJHy6B6A1ScJCXPosEwrEViRYzW4/ANjcXyT8vdxgcizs5XVR/nw/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772862794; c=relaxed/simple;
	bh=7ftgz8tuTyEsgjf9vwv0u3BeAalwQ2a52Xsvna9BgSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L1LqVIyS046YioyX73WxXlkoEqldamoqcYkUWLhDwbIPjI9gPwALdYk2/UYUzq4huODLcazYw3Ieps4Dy2g0Ph4g28dP1JW0xJj++SsBaoCMqbbN84GXMCW606I5SFg+nBVfMFLPHH2fVxSvIjr9o8Maw9UP65mPBic1B1SuUFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=St0vSj4n; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="St0vSj4n"
ARC-Seal: i=1; a=rsa-sha256; t=1772862778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LldDHbDlrJZpcu7RxiMd0P04HqJV/HUJ9c/uOCMqKdZOJS3KBmYXXwuhmpBK3OMWHwNPZWHh2g88mSgrpgZFzLYBYjq3lDHZTrFn/Hbs12lGSWBaFyI5+BFhaGdbD2hSmvHMEyZyC5o3fafSfLhNppr4IGwEatPx0cdxNITEPBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772862778; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fj0l2wHqxhSAPSrepoyJIsFPkg8FJUfQTnE30k9mqeg=; 
	b=Ohxs6mgvS4aOVBQ0Z9/YrqsJw3OJDX9q1+LnqunsS4L/pq+0oFtPvgViVIm0m0qdDqzTg3JFlkn6wdmGfiTwTHU8Mpk8QNqwMhEXj+UTcHKi8g+5An5o8fnvL/dwkvPVMs0R05y9riHedclDWIYgVZSErxQ/uGJY7v43o0+92tw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772862778;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=fj0l2wHqxhSAPSrepoyJIsFPkg8FJUfQTnE30k9mqeg=;
	b=St0vSj4ncZmOWvfPrN7Gt8ZLrYbqCoYLr/oeCOKkEvzQGQ8JX3qF3eOPPhMuYPw+
	YS7awLRGvo5KLsX+Npb0ebQwB9GIgpFOn/lZxn7kL//kxj/vR3+VN68AdBm9ZE11EZ8
	u9itjJb0YhxO7t+JUOVreJCiAMOIHK9POGD7Z3og=
Received: by mx.zohomail.com with SMTPS id 1772862776075910.6970531217306;
	Fri, 6 Mar 2026 21:52:56 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 07 Mar 2026 13:52:52 +0800
Subject: [PATCH] cxl/port: Do not return -EAGAIN from find_or_add_dport()
 for newly added dport
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-find_or_add_dport_not_return_eagain-v1-1-7c298461a9a4@zohomail.com>
X-B4-Tracking: v=1; b=H4sIADO9q2kC/x3NwQrCMAyA4VcZOVvoOrTiq4iEuGQzl3SkVYSxd
 7d4/C7/v0MVV6lwG3Zw+WjVYh3jaYD5RbZKUO6GFNMlTjGHRY2xOBIz8la8oZWGLu3thkIrqQV
 6jjmnfE7TfIVe2lwW/f4v98dx/ACCW6L3dQAAAA==
X-Change-ID: 20260307-find_or_add_dport_not_return_eagain-ab17727523c8
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772862773; l=2496;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=7ftgz8tuTyEsgjf9vwv0u3BeAalwQ2a52Xsvna9BgSo=;
 b=J76G7xqm9ZS2m0Sx1cr32NBYC/BjUm/wOLeRpFf6AinPqZIwKlJgfN8vBaQD10GN6jWkkrKlp
 D4Z603/UCOEB1+0ZHP/3+gj0KtMMars5VrBNJ1jxO2jY77Rc+pBHNPX
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228cbaf1c00d952ce50af6f31e000005053d5b63a9c841f77fbdf8867e8171e3f2d46514d27e7285dc1:zu08011227960147661fbe1a13706fe5f700001a513edce902fe1baf2108abb286b03ecabad43d72a2682124:rf0801122df335e5d9a82ead73d0b2143e000052d2a542a1a4fbe11bceb1815cd5e79a61a78281fea1cd8fccbd76ed946217:ZohoMail
X-ZohoMailClient: External

find_or_add_dport() is used to get an ancestor dport of a new CXL memdev
on an existing ancestor port. It is called only when all ancestor ports
of the given CXL memdev have been enumerated. Because port enumeration
iterator walks CXL hierarchy of a given CXL memdev from CXL memdev to
CXL root, if it found an unenumerated ancestor port but the parent port
of the port is existed, iterator will call add_port_attach_ep() to add
the absent port then trigger CXL hierarchy re-walk until all ancestor
ports of the given CXL memdev enumerated. After that, iterator just has
chance to call find_or_add_dport().

So if an ancestor port is existed but the corresponding dport for the
CXL memdev has not been added, iterator will use find_or_add_dport() to
add the dport then return -EAGAIN on success. The -EAGAIN will trigger a
CXL hierarchy re-walk.

However, this re-walk is unnecessary. After adding the ancestor dport,
subsequent calls to find_or_add_dport() will return the newly added
dport on the same ancestor port during re-walk. Therefore,
find_or_add_dport() can return the newly added dport directly instead of
an -EAGAIN, avoiding the unnecessary CXL hierarchy re-walk.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..3074d912d6e5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1782,14 +1782,8 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 	guard(device)(port_to_host(port));
 	guard(device)(&port->dev);
 	dport = cxl_find_dport_by_dev(port, dport_dev);
-	if (!dport) {
+	if (!dport)
 		dport = probe_dport(port, dport_dev);
-		if (IS_ERR(dport))
-			return dport;
-
-		/* New dport added, restart iteration */
-		return ERR_PTR(-EAGAIN);
-	}
 
 	return dport;
 }
@@ -1848,11 +1842,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * have the dport added here.
 			 */
 			dport = find_or_add_dport(port, dport_dev);
-			if (IS_ERR(dport)) {
-				if (PTR_ERR(dport) == -EAGAIN)
-					goto retry;
+			if (IS_ERR(dport))
 				return PTR_ERR(dport);
-			}
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 

---
base-commit: 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4
change-id: 20260307-find_or_add_dport_not_return_eagain-ab17727523c8

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

