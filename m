Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EB3BC685;
	Tue, 10 Mar 2026 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158467; cv=pass; b=OWcCIKBQKSdbQYKvSsruT8Fxp431zPoHASUSPF0w0aiqspUGKIg2i53qAzm0Y8828qMNc2zKdlGUOz1lRkXMOoTjiMwILL1H2nPD2ZkIJrjxPe0GZLQWqjf9DFsglkvR9IK+ki58HrlhxgFprumfkiqRLCkpP+23qknU7vvpgno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158467; c=relaxed/simple;
	bh=l0EZGmsTcf36X0E0XndNYafXUD0iSTFs/Ybsl7j/4wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXwXjhYKvphrW++PHV8AYm53NkCzY0lOkp7sZw47y2wCnaaHJ72odJV/C5yc3gudhZ1l5tjixPJCn31omZaShUf8OCcrpUe62igm/T+cYJ6//evty3C/vTjKSs0tzFEf4WyuOpPpcIVvZE/kHdeQdfwLXi9Z/NlTHKckNZuNud0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aloDEkfq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aloDEkfq"
ARC-Seal: i=1; a=rsa-sha256; t=1773158329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FzM16uaNRsGEmv1j0sKR+oAZ35eM6X+xCaV5ghJt6NoXwzAJEdqNnQzRQKx0tYhdR3xKBPA6hd3SgvOOCS5nag1FQbU711rvajWtZHc1LHJLW9L6piyf3W9D2Ocm73SPAfep3OMRg80Ivvxdwr3Y0TrwL3dz5KoJjldQXHMI8/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Or+ZhAMTBzvjsWuvdXuHp+0M//ZrD+z05kSAxIka534=; 
	b=n75BaAJKbWdR0WgT4GGYoF8ZrTHIiZtTqhKLrpdt2LdxNhry9K9QrZjvx9Z95jkSJIx0OP3BdwMJlgewwpGt7KwIPQsNDzGaqMDfVrnmliv/Dn0bDYGMBvN1feycNr8brmOdRYpXEUb3DIlqReNfEeFE9dIvdWX5uy/iWQRELH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158329;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=Or+ZhAMTBzvjsWuvdXuHp+0M//ZrD+z05kSAxIka534=;
	b=aloDEkfqnQ6nql7y0ZQSmqdgK0YRJqPp//XKfVKo7imGRexqrrzwB1spNvdMy9MQ
	iGOYW84j5M+sFcJ6vltcIfd/jFWwwsODGubZHbKUJMg2Rfo/y2oCFF4g43yoBR5qN/i
	nYP9JzrKS25tHIAOwBQzPXIZcXg+tGrI+9w+24eM=
Received: by mx.zohomail.com with SMTPS id 1773158327256164.06898766243387;
	Tue, 10 Mar 2026 08:58:47 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:59 +0800
Subject: [PATCH 7/7] cxl/port: Reset cxlmd->endpoint to -ENXIO by default
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-7-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=2159;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=l0EZGmsTcf36X0E0XndNYafXUD0iSTFs/Ybsl7j/4wg=;
 b=SrHZ707az/xs/EYPUmfboK4WJhBsFW4feGbAP53xKzFaac55tdRs78uFwwB1wYsmxVR60tIuy
 fC8PSE+Mz/cD19Fcm3vAkCquwVBPHkKCBTVvmJxmYFhZlozATq1+tEn
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112282b6530e94dae5804efd3785600006e31b47c2b5aae09232b254a4bd9182b080334dd0fd824d33a8d:zu08011227cbbb50cae64841755ed0894b0000dad46b9af661aeafbcd8e5f654639e165bf1ba1f0bef593437:rf0801122d5ca919e7d48e4540bef9d3c900009b6666f33cd9046ca19669f18119022ca337c4ed2b79b7a1166c7bee699a2e:ZohoMail
X-ZohoMailClient: External

cxlmd->endpoint is set to -ENXIO by default, This intentional invalid
value ensures that any unintended access to the endpoint will be
detectable. But CXL driver didn't reset it to the default value when the
endpoint is released in delete_endpoint().

Besides, cxlmd->endpoint is updated to point to an valid endpoint in
cxl_port_add(), but if the device_add() in cxl_port_add() fails, the
endpoint will be released, but cxlmd->endpoint remains pointing to the
released endpoint, it may introduce a potential use-after-free issue.

Fixes: 3d8be8b398e3 ("cxl: Set cxlmd->endpoint before adding port device")
Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..ec3cb62b44b7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -834,11 +834,14 @@ static int cxl_port_add(struct cxl_port *port,
 			struct cxl_dport *parent_dport)
 {
 	struct device *dev __free(put_device) = &port->dev;
+	struct cxl_memdev *cxlmd = NULL;
 	int rc;
 
 	if (is_cxl_memdev(port->uport_dev)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+		struct cxl_dev_state *cxlds;
+
+		cxlmd = to_cxl_memdev(port->uport_dev);
+		cxlds = cxlmd->cxlds;
 
 		rc = dev_set_name(dev, "endpoint%d", port->id);
 		if (rc)
@@ -865,8 +868,11 @@ static int cxl_port_add(struct cxl_port *port,
 	}
 
 	rc = device_add(dev);
-	if (rc)
+	if (rc) {
+		if (cxlmd)
+			cxlmd->endpoint = ERR_PTR(-ENXIO);
 		return rc;
+	}
 
 	/* Inhibit the cleanup function invoked */
 	dev = NULL;
@@ -1425,7 +1431,7 @@ static void delete_endpoint(void *data)
 			devm_release_action(host, cxl_unlink_uport, endpoint);
 			devm_release_action(host, unregister_port, endpoint);
 		}
-		cxlmd->endpoint = NULL;
+		cxlmd->endpoint = ERR_PTR(-ENXIO);
 	}
 	put_device(&endpoint->dev);
 	put_device(host);

-- 
2.43.0

