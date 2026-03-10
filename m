Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2E327BFA;
	Tue, 10 Mar 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158369; cv=pass; b=Zlxkp6ehbEpXE19Ejhhm6C4Pf1a+ZU3wm3IbUvMdR7EQ7nujCu4tJD3Go+y01uE2naU1vIoFnqX0OAwYYVZfsAO9bevEKhOWuxT4mLKDBJhlG4yUN6kDosU6a5XOgHKPaQT/u4Qeq1+LllhwJLaNmARinl1hN4SFaAt8N45yTQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158369; c=relaxed/simple;
	bh=rU6WDhcN7WJon276w2eU/IaTYHGcXdC05P+xbVtAC/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5Odwj7OUlIXlbqRbz+pgUhJBum3Cq3HQbcTRxyOnSi79sy00BLazIRHYd1EPMg0nOj2eoYwRYxfafHbZaz58FJ0222vquMbVurbtm4XFXUTG2x2Yd+kSxR1nS5FW8RihsbMDFPjSYQuJSUwLcBd+O/81PB+UCTHP7mmxFbu/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=L8QvEyT+; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="L8QvEyT+"
ARC-Seal: i=1; a=rsa-sha256; t=1773158311; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOmG3ytd+ZpwArJnoDFZhWt9MC+uzxjrYBKRMM3LruKV7vaR1tL/58rCqWu/VZU2HHa1Y7XguJ4CmIDpoYg4fc+izXjIMDFSD04Q8o6bJt8Vqrytw0HYqQ6vNzku4QZ/TSqyAQ7T9HQjhsBzhQjCinl4fE1nJWYDqzZWndt5+XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158311; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h0gOEyLsKUXgoqobM1nzCwbTc9H0I1PIC4gr+hBO1Ns=; 
	b=GCKOmFRoIZBv8bze+Vlg6+bc6iIaUxxJ0LdvQPu4xM2WIDuVoDThSRyRj6E14BuxnK0MqOgyuVXDWAgWONJPdw7iUqcs4D0oJD0zjAfRLU5sfpXcHG9k0EPRdXszkFMtFtUw5evHVKwnDCA6A5/TYCxGHisUj5dV8CR9NHciChg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158311;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=h0gOEyLsKUXgoqobM1nzCwbTc9H0I1PIC4gr+hBO1Ns=;
	b=L8QvEyT+IPi8UJoLGuk+N3QoVLq/kGIH1gPsL3wREKj8LlNr7TDL+qSa7iQdTFwN
	oS7cg7GZTtGXi4RkAFNt07l23vUEO+GMFpdGeC9R6ZjYzt1PxvhV5GVIxlGH2dVUFWi
	SE541wyL7wfOnzp17sc/lL9uHQoztrMZ6ytjEZYY=
Received: by mx.zohomail.com with SMTPS id 1773158309175978.1934732389334;
	Tue, 10 Mar 2026 08:58:29 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:54 +0800
Subject: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=2059;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=rU6WDhcN7WJon276w2eU/IaTYHGcXdC05P+xbVtAC/c=;
 b=a3RUt3LqR6xtRa6WtV2TMQkICKxM/DUgoYI5x8NdYQB7CilD/ERhHP2L5s4egdO6ixKCN5A57
 qzF+RDaA/LqD4leCqOBLOhwKy2RePIA8VnpQ8we20myaooIBU7Cbun3
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228f64cba3fca3349f30d5932eb000088510a6aeaf537156245488e2f3b102973c055191187e5f69433:zu0801122702eabe4b031738113eb0a7d30000e1aef14c5a5b7960673073a2698b35ea3f4509d6fb00eab84c:rf0801122dfdd9d40775a504c1041ef9590000ccebbfc4141a2eb0eca0b8210e7cda4d616cf8254de697da5b03bbe13bc200:ZohoMail
X-ZohoMailClient: External

CXL memdev poison injection/clearing debugfs interfaces are visible
before the CXL memdev endpoint initialization, If user accesses the
interfaces before cxlmd->endpoint updated, it is possible to access an
invalid endpoint in cxl_dpa_to_region().

Hold CXL memdev lock at the beginning of the interfaces, this blocks the
interfaces until CXL memdev probing completed.

The following patch will check the given endpoint validity in
cxl_dpa_to_region().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/memdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 273c22118d3d..8ebaf9e96035 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
+	device_lock_assert(&cxlmd->dev);
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	lockdep_assert_held(&cxl_rwsem.region);
 
@@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	int rc;
 
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
+	device_lock_assert(&cxlmd->dev);
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	lockdep_assert_held(&cxl_rwsem.region);
 
@@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	int rc;
 
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;

-- 
2.43.0

