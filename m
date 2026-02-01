Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E32DFF1D;
	Sun,  1 Feb 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938282; cv=pass; b=e+f4QNec1R52nHw7OJ72T+OIHiFkPgJepnjQliqOdUqq97f0TiSUJXCTyuOklMbib9uEa5fyYbSVzQNTf6/cmRDbXAUQZlkzzMvtaVzajoTf9c5FXT46cTtSFF5ZQtzmfZpDjAyBtQeV1WeZgVhbjDVoZatF5lRLyJzhA2EmtHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938282; c=relaxed/simple;
	bh=nBOj+eZ31XIz3fTU5R51cCceiBldGbHgQS/NmDS9ZPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTgy+Ii2X2N0WszwykUS6P4BgEZmSYoQM5cVh9Kr2ZvNzidMBJXPWgAgXnbuCF7nyqrnIM5xsmjRnd7NDf6ktgs6sxVWt9v+nyCYg43BGGiRBJG41DVUEsCOO93uSpm2K6ccY2/bXHNxRBchd+rG3w03zmAxu6DQ4sD3dHwRVFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=HUA9/SGN; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="HUA9/SGN"
ARC-Seal: i=1; a=rsa-sha256; t=1769938269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T2kMW1azUzO2DFetEktwVqJxrnz7YRgFC/xFDy2auhVo96hxlWKMh33VfqBGJ6YImHdV+FvBjx5aR2jnB6TaBx3fq6Bc98zEhM7vTYssTBIf/g048mDx7zbXsOw1zrRSgUkdQm1p2uw9DLDzzJxRWDQc7MfMYxwt1i8VaL+J7Mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769938269; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=um7Rwl3nc2rUGCVeCqO6PMOLQM0nAbnAPJ2AKqKDL7Q=; 
	b=Sff/7SsB3gFIWrCVgtQdHNkpt7zUVZx15TdIR+5EaWeXxxX1D25rorjIeAZSt475wBH82Uu9cuAWd71qplTATvZu9s7mHCZarq4rjiozoUOOY7p2YYWsr3TmaIAXKAsXlNLQJwMxXpM3AE3aaoB03VtsuHm6G7gDjyIf0p01jSo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769938269;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=um7Rwl3nc2rUGCVeCqO6PMOLQM0nAbnAPJ2AKqKDL7Q=;
	b=HUA9/SGND/4r+BAJuCfrqA3K9JGfYps4tAFB+JVlulLdqSAyd28xiU+LMEyznzB2
	WkP1sTNQrJaquGPISWeOUZ8c2e5BEYUqR+nyCZ/qLpfU2fGpq9Zt9AYvGvic5X4n573
	FGnHkRmdr4OEcm+F5xkojDuqF+OFF6QqrBtA4018=
Received: by mx.zohomail.com with SMTPS id 1769938268428264.52491364859065;
	Sun, 1 Feb 2026 01:31:08 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport adding
Date: Sun,  1 Feb 2026 17:30:02 +0800
Message-ID: <20260201093002.1281858-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201093002.1281858-1-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122c5220c7f99190c00eb1a9215200002f2cf8a702a7d37c8715e358734040ba9ff9dec2ef7f7733f4b57b3b5dfa:zu08011227a62bdce4bd80fbbd4dae56b2000014f64478291be40dd36af877ace544630a1534a74992238e88:rf08011232c4003c64a836c36016f1a338000055538e8bfeeec9f42e89d9298eebd99129d854a94ffe5194ece7b7b028fb6285472217d5:ZohoMail

When CXL subsystem adds a cxl port to a hierarchy, there is a small
window where the new port becomes visible before it is bound to a
driver. This happens because device_add() adds a device to bus device
list before bus_probe_device() binds it to a driver.
So if two cxl memdevs are trying to add a dport to a same port via
devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
and attempt to add a dport, but fails because the port has not yet been
attached to cxl port driver.
the sequence is like:

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

To fix this race, require that dport addition holds the parent port lock
of the target port. The CXL subsystem already requires holding the
parent port lock while attaching a new port. Therefore, successfully
acquiring the parent port lock ganrantees that port attaching has
completed.

Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 54f72452fb06..fef2fe913e1f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1817,8 +1817,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			/*
 			 * RP port enumerated by cxl_acpi without dport will
 			 * have the dport added here.
+			 *
+			 * Hold the parent port lock here to in case that the
+			 * port can be observed but has not been attached yet.
 			 */
-			scoped_guard(device, &port->dev) {
+			scoped_guard(device, &parent_port_of(port)->dev) {
+				guard(device)(&port->dev);
 				dport = find_or_add_dport(port, dport_dev);
 				if (IS_ERR(dport)) {
 					if (PTR_ERR(dport) == -EAGAIN)
-- 
2.43.0

