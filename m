Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E7256C84;
	Sat,  7 Feb 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471348; cv=pass; b=FQnlyPlbcIQLYIIqk6UA575m1ebEwE7RU/NsI5NeOMgztMJDmqzFG9pY7g13DLy2qK0vWsy0E3C/ZzXV2jmdhcL4s8Ex/IBh3a6S49zPGEheN5rtDDovLbc1AiPO4Z//vJ1U80l7womHTYTWKgy3BCOsbkfv5s/V3DHGLaw02L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471348; c=relaxed/simple;
	bh=oRGDdJ4io6kARgehs1YmTM1pWiyiDSJDRWkNDXjlGOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0sX2haSO0HCkaKIAhepzejMvW35yFv31aKkf8bhW32IToYuPMo6rQaAu2o5iJBYwzar/zLikAJvL6rV/jwYXIKW2IhfLXpN86NoeGMj5/VLEqhYtgxFXqdvwYQHxe7INrDiSZ+oY6kYyXGKB81WrPEU7Iw4gC8RZH167cCsoUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Qk25gKLV; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Qk25gKLV"
ARC-Seal: i=1; a=rsa-sha256; t=1770471331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GGzRoJmxyrceXT3ViZhP4RyC6Ku3YuLGksAUE2BdJa6ZzMC9YqQQcYJea0/U9b6fz0T2JbjgQn3Mg0q+ITTNQxDJ0yYAEsCL1ZJOEFwReKzTOEqXp1rDDdU7iYlzvkr/f0iBWWNjcf0gSJAvRrCsYukoqpp6DW5Lr7/RiCOGe3c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770471331; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ycv8A4SaufoJcgg3Lf8vJqaVtwNtXOJQGSzINvUeC0A=; 
	b=Euw+xEHin5S9WCFxR765mZat7h9IY0YvOG01VOc7UoA2Fnu1NmFvTz8Iukg9vyc+3t6270yCkAKIBvKsf81zERJMx3AgNRUiXmG6KjBOOTMgHe3S5nZDsax1ThwzRT1uhB0S8Ko5mPSr5LqGVyqyFzGmy784yVsZeJmnADFanKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770471330;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ycv8A4SaufoJcgg3Lf8vJqaVtwNtXOJQGSzINvUeC0A=;
	b=Qk25gKLVtOWNbveNkP6RXvpfzregFjBC/XW0w8U3HkcDmE2UjT/op3MBM3oTxzYX
	XDc55mOa/mFs3Np1c4E4CIBpHaz1MHrYizjnIxID6gdfzBHKiEfQoP0mzIH9UiNsWNZ
	QluAooT+seai/OWtTKk9j+7KHaetoB9F3iubtXtg=
Received: by mx.zohomail.com with SMTPS id 1770471328274873.0278604737067;
	Sat, 7 Feb 2026 05:35:28 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] cxl/port: Hold port host lock while dport adding.
Date: Sat,  7 Feb 2026 21:35:11 +0800
Message-ID: <20260207133512.306128-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207133512.306128-1-ming.li@zohomail.com>
References: <20260207133512.306128-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122ce844a0697d9f5ea25590ab420000f12d21705be2ed355d8321db212e9c6f9047bc3a84a2d7aedc02f5454a19:zu08011227f37690ea5be74c8581c4551000004f70f74d8894ea9783d97462b87733f875cb9e81ec45155d26:rf08011232b9de95fa384e4456c76e9b3200001344a1ecbc3028621463c3426a362e9a850620959e6f0ea8b0dd0952bdc331b67d2d5426:ZohoMail
X-ZohoMailClient: External

CXL testing environment can trigger following trace
 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
 RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
 Call Trace:
  <TASK>
  cxl_event_trace_record+0xd1/0xa70 [cxl_core]
  __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
  cxl_mem_get_records_log+0x261/0x500 [cxl_core]
  cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
  cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
  platform_probe+0x9d/0x130
  really_probe+0x1c8/0x960
  __driver_probe_device+0x187/0x3e0
  driver_probe_device+0x45/0x120
  __device_attach_driver+0x15d/0x280

When CXL subsystem adds a cxl port to a hierarchy, there is a small
window where the new port becomes visible before it is bound to a
driver. This happens because device_add() adds a device to bus device
list before bus_probe_device() binds it to a driver.
So if two cxl memdevs are trying to add a dport to a same port via
devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
and attempt to add a dport, but fails because the port has not yet been
attached to cxl port driver. That causes the memdev->endpoint can not be
updated.

The sequence is like:

CPU 0					CPU 1
devm_cxl_enumerate_ports()
  # port not found, add it
  add_port_attach_ep()
    # hold the parent port lock
    # to add the new port
    devm_cxl_create_port()
      device_add()
	# Add dev to bus devs list
	bus_add_device()
					devm_cxl_enumerate_ports()
					  # found the port
					  find_cxl_port_by_uport()
					  # hold port lock to add a dport
					  device_lock(the port)
					  find_or_add_dport()
					    cxl_port_add_dport()
					      return -ENXIO because port->dev.driver is NULL
					  device_unlock(the port)
	bus_probe_device()
	  # hold the port lock
	  # for attaching
	  device_lock(the port)
	    attaching the new port
	  device_unlock(the port)

To fix this race, require that dport addition holds the host lock
of the target port(the host of CXL root and all cxl host bridge ports is
the platform firmware device, the host of all other ports is their
parent port). The CXL subsystem already requires holding the host lock
while attaching a new port. Therefore, successfully acquiring the host
lock guarantees that port attaching has completed.

Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c82e6f32572..6f0d9fe439db 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -612,6 +612,23 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
+static struct device *to_port_host(struct cxl_port *port)
+{
+	struct cxl_port *parent = parent_port_of(port);
+
+	/*
+	 * The host of CXL root port and the first level of ports is
+	 * the platform firmware device, the host of all other ports
+	 * is their parent port.
+	 */
+	if (!parent)
+		return port->uport_dev;
+	else if (is_cxl_root(parent))
+		return parent->uport_dev;
+	else
+		return &parent->dev;
+}
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
@@ -1790,7 +1807,16 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 {
 	struct cxl_dport *dport;
 
-	device_lock_assert(&port->dev);
+	/*
+	 * The port is already visible in CXL hierarchy, but it may still
+	 * be in the process of binding to the CXL port driver at this point.
+	 *
+	 * port creation and driver binding are protected by the port's host
+	 * lock, so acquire the host lock here to ensure the port has completed
+	 * driver binding before proceeding with dport addition.
+	 */
+	guard(device)(to_port_host(port));
+	guard(device)(&port->dev);
 	dport = cxl_find_dport_by_dev(port, dport_dev);
 	if (!dport) {
 		dport = probe_dport(port, dport_dev);
@@ -1857,13 +1883,11 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * RP port enumerated by cxl_acpi without dport will
 			 * have the dport added here.
 			 */
-			scoped_guard(device, &port->dev) {
-				dport = find_or_add_dport(port, dport_dev);
-				if (IS_ERR(dport)) {
-					if (PTR_ERR(dport) == -EAGAIN)
-						goto retry;
-					return PTR_ERR(dport);
-				}
+			dport = find_or_add_dport(port, dport_dev);
+			if (IS_ERR(dport)) {
+				if (PTR_ERR(dport) == -EAGAIN)
+					goto retry;
+				return PTR_ERR(dport);
 			}
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
-- 
2.43.0

