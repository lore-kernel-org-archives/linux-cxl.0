Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892631B80D;
	Tue, 10 Feb 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724214; cv=pass; b=Cs4mB0dCzopc6aYl7ZAXGK/oK3UaDvKK6ojMpQTVwTSZEcerZNl8EdPiSxVsrtJyiN0G1qpuIsho+UFId7uIVxUcm86iAin81YbWCh5yAZBOsZZqfClpunwcYJ8wzQ8Lolj+BNGJG7TpxB/P3rjq0t8DW5iP7g5Xy9xadGSPdLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724214; c=relaxed/simple;
	bh=SSnVkzVSropAXZSCmu0ixw4Cij1D6YdUc8DhKgOzrWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2tXUnnGquAUo2PeOiLjeasVpzgKGnM/C27aYxdLP1vcoq5L2DoNAvdWulCFGLa9qDpLxLvM/0GfmxZE6wn2nqUeUxNyKN52FXfqG1tihJ9FG4gQRsNi4hFWK9FdSnVaWFR2ZluC7lbUSuL/JCihtRhvJAP0yxu2vfMdejZpl8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=f3TW043Z; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="f3TW043Z"
ARC-Seal: i=1; a=rsa-sha256; t=1770724071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ao45GBYqlvQ++4SFh+/aR+ajJE5PJ3uzNyn12PidtpXlAWPiOincZRzftanXIaWJihXAFBsvFSKit7Syufwy1CNvZWTaET0taDPniI4vvjhbxqWlPaUfr5bnMUHTP2MpxgHtaqwop4kzEBnfSm15TGQnn3Lg8l2qC60WHwE799k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770724071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CLCMJSIdCBJK8kkdm0K0l2O1r5OcTqNcYjBsQ8aUQyY=; 
	b=TWA282YoNOvP4UPg7UIbSjc2lCv6Jr27/tEyYQptax2ucyd8rV+6MrQSQ4VTdqfcI9jJHOCGEsyOs+FVp0xOXUvA35HTAF2A505rgW5+27YDsyF2BRFFX7z/lKaWWPBDjkcJcsBLSySQ1O0uNBoW+Bv2Gls5Z4OTPxrk1kidLZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770724071;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=CLCMJSIdCBJK8kkdm0K0l2O1r5OcTqNcYjBsQ8aUQyY=;
	b=f3TW043ZRiXz+/idt/C+RbmBeFSsSMvQ1TPHykLDdwGoWPY/q/vOAKSnb/2XIAoh
	jMlMuJxSgitqvgPgJKRHLuqerdM49sMao9JzAH1RgGz/MtQR8gGULvs1w/Knq6uKsMT
	JEwmQLWLHjepYkobTvSXneyImRy8e8o7/0/0Jfn4=
Received: by mx.zohomail.com with SMTPS id 1770724068091582.9441928379345;
	Tue, 10 Feb 2026 03:47:48 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Feb 2026 19:46:57 +0800
Subject: [PATCH v3 2/3] cxl/port: Hold port host lock during dport adding.
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-fix-port-enumeration-failure-v3-2-06acce0b9ead@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770724039; l=4221;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=SSnVkzVSropAXZSCmu0ixw4Cij1D6YdUc8DhKgOzrWE=;
 b=5gdW+wyrvDcTHOv1whBnPF9We0lwSeFQFmSQyabhYOuOjEwhZIus2sZW5cKHyVNYdEo/AWkaQ
 hhogbSpXC+KBbeg7A16N/wmtHhAFRsVl9BO9SsjnjsFObP2SX6ZTfkz
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112283198f6dc84b958d6760c31e70000320fac2be414855e92b573365e0421f17c47085f34b2dd600a5e:zu08011227d4a0fdec6c8685d83bfd536400005571b87f17fa6cb201c3f2a99820580552cf76cf3745a2093b:rf0801122da78a5ee33d180eb8558006020000424f52721d32ca6a2e86c68a9224437c82a93856a063dcfee17439a34f3cf1:ZohoMail
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c82e6f32572..9e4abdaf209b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1790,7 +1790,16 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
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
+	guard(device)(port_to_host(port));
+	guard(device)(&port->dev);
 	dport = cxl_find_dport_by_dev(port, dport_dev);
 	if (!dport) {
 		dport = probe_dport(port, dport_dev);
@@ -1857,13 +1866,11 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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

