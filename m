Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC242C859
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213840; cv=none; b=IkioS6ofhaQjztcR3J72SyVGYPPCcu1H9Z65oTD9/deRbqzc3emims+KjZ1dr4yZVEpJbqDjeO1sY6TDnnCgMFTwdXQiO6jCDv3UIEEVntLM2402W1aPINNRusAE+C7kCqzXDXItP21meBKKLmY2TCsA63ZGI21xhr4470Yj3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213840; c=relaxed/simple;
	bh=DlwFjROwVpvtL3AixKA+5jVRuBuItMbFqNJvW+kkm0E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHFzVOidznPjwbeuuh6EXXYQBFrQoSWtkLXYTPtBmLUMpDIcSQow7JXCfUQz8dOf7JdLsVXIGKWjtF65kf/7GGG1rAwQq0fnTxvB9dXY0+Usu4Gf9NfdWD+yhx8fh1TbJQGPx/6ommQLX+Eu+vSgdi1VIn6uJE4x52VfBO5d1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IU7t2L4R; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IU7t2L4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729213838; x=1760749838;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlwFjROwVpvtL3AixKA+5jVRuBuItMbFqNJvW+kkm0E=;
  b=IU7t2L4Ryfns3z0DhGnjTYzx1NWoJ8Z5jDyg35aEKtovMz9DHpLEr1m4
   lLCg8DopQ+pQZsj5H60c7+B4OoRVLFWzmhP2qaFoiUb13j+0CEciyLGpQ
   9I7xXBPNzNzPHfhW/mm16wJWAl0uZR9Vi8axbrgLR0259/6n7AK06c2gu
   WbmIIKiT0sUxXMBiD8Tv2dYIVqOAoGmmEazxHynX0ecuSzb2ES+2GeESq
   3GnF8y4g1nTWdJ2QM0CeTylkkrmPESzfp34MPSFtBQObr/IBUkjfVZ2PP
   3MrjtTxpbabi0q2xAkeKOh2zD6KNAHLBHf51qI+PgZF3ODZfTFKTQiF96
   A==;
X-CSE-ConnectionGUID: fVdeUim5TpWWUxOr0/wsSg==
X-CSE-MsgGUID: BkR+s7F3Q3uMJ/pXXamVhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28168500"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28168500"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:35 -0700
X-CSE-ConnectionGUID: MNPoNwRhQsuSx2eTCCO70g==
X-CSE-MsgGUID: 5dXVxnOvQwKEyuqjk1tvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="109535317"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.118])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:36 -0700
Subject: [PATCH v2 3/3] cxl/port: Clarify add_port_attach_ep()
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com, dave.jiang@intel.com
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Li Ming <ming4.li@intel.com>,
 linux-cxl@vger.kernel.org
Date: Thu, 17 Oct 2024 18:10:33 -0700
Message-ID: <172921383206.2133624.16072155083340676420.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The subtlety in add_port_attach_ep() is too high as even static analysis
checkers had trouble following the error exit logic [1]. Jonathan points
out that at a minimum the 2 acquisitions of @port should use 2 variables
[2]. This patch goes a step further and refactors the code to:

- drop the redundant uport_dev argument
- move all device_lock dependent code to a new find_add_dport() helper
- clarify why the @port reference needs to held
- clarify that @port is not devm released on failure
- create a new __free(put_cxl_dport) helper for this case of passing
  around an implied @port refernce

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: http://lore.kernel.org/20241017181244.00003e1f@Huawei.com [2]
Cc: Li Ming <ming4.li@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |  112 ++++++++++++++++++++++++++++-------------------
 drivers/cxl/cxl.h       |    1 
 2 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8e6596e147b3..599b1a4caa70 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1539,14 +1539,63 @@ static resource_size_t find_component_registers(struct device *dev)
 	return map.resource;
 }
 
+/*
+ * Check if @parent_port has a child cxl_port that hosts @dport_dev.
+ * and if not create a new port attached via the @parent_dport
+ * downstream of @parent_port
+ *
+ * Caller is responsible for dropping the port reference after using
+ * @dport
+ */
+static struct cxl_dport *find_add_dport(struct cxl_port *parent_port,
+					struct device *dport_dev,
+					struct cxl_dport *parent_dport)
+{
+	struct device *uport_dev = dport_dev->parent;
+	resource_size_t component_reg_phys;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	/*
+	 * lock serves 2 purposes:
+	 * - Resolve races to find/create a new port
+	 * - Prevent found / created ports from being freed before a
+	 *   reference can be taken
+	 */
+	guard(device)(&parent_port->dev);
+	if (!parent_port->dev.driver) {
+		dev_warn(&parent_port->dev,
+			 "disabled, failed to enumerate CXL.mem\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	port = find_cxl_port_at(parent_port, dport_dev, &dport);
+	if (port)
+		return dport;
+
+	/*
+	 * Note that this port is only unregistered when @parent_port
+	 * is unbound / removed, not if this routine returns an error.
+	 * It is a shared object across multiple downstream endpoints.
+	 */
+	component_reg_phys = find_component_registers(uport_dev);
+	port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+				 component_reg_phys, parent_dport);
+	if (IS_ERR(port))
+		return ERR_CAST(port);
+
+	dport = cxl_find_dport_by_dev(port, dport_dev);
+	if (!dport)
+		return ERR_PTR(-ENXIO);
+	get_device(&port->dev);
+	return dport;
+}
+
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
-			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
-	struct cxl_port *port, *parent_port = NULL;
-	struct cxl_dport *dport, *parent_dport;
-	resource_size_t component_reg_phys;
+	struct cxl_dport *parent_dport;
 	int rc;
 
 	if (!dparent) {
@@ -1560,50 +1609,23 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent, &parent_dport);
-	if (!parent_port) {
-		/* iterate to create this parent_port */
-		return -EAGAIN;
-	}
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		find_cxl_port(dparent, &parent_dport);
 
-	device_lock(&parent_port->dev);
-	if (!parent_port->dev.driver) {
-		dev_warn(&cxlmd->dev,
-			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
-			 dev_name(&parent_port->dev), dev_name(uport_dev));
-		port = ERR_PTR(-ENXIO);
-		goto out;
-	}
+	/* iterate to create this parent_port? */
+	if (!parent_port)
+		return -EAGAIN;
 
-	port = find_cxl_port_at(parent_port, dport_dev, &dport);
-	if (!port) {
-		component_reg_phys = find_component_registers(uport_dev);
-		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-					 component_reg_phys, parent_dport);
-		/* retry find to pick up the new dport information */
-		if (!IS_ERR(port))
-			port = find_cxl_port_at(parent_port, dport_dev, &dport);
-	}
-out:
-	device_unlock(&parent_port->dev);
+	struct cxl_dport *dport __free(put_cxl_dport) =
+		find_add_dport(parent_port, dport_dev, parent_dport);
+	if (IS_ERR(dport))
+		return PTR_ERR(dport);
 
-	if (IS_ERR(port))
-		rc = PTR_ERR(port);
-	else {
-		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
-			dev_name(&port->dev), dev_name(port->uport_dev));
-		rc = cxl_add_ep(dport, &cxlmd->dev);
-		if (rc == -EBUSY) {
-			/*
-			 * "can't" happen, but this error code means
-			 * something to the caller, so translate it.
-			 */
-			rc = -ENXIO;
-		}
-		put_device(&port->dev);
-	}
+	rc = cxl_add_ep(dport, &cxlmd->dev);
 
-	put_device(&parent_port->dev);
+	/* translate EBUSY as fatal */
+	if (rc == -EBUSY)
+		rc = -ENXIO;
 	return rc;
 }
 
@@ -1678,7 +1700,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			return 0;
 		}
 
-		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+		rc = add_port_attach_ep(cxlmd, dport_dev);
 		/* port missing, try to add parent */
 		if (rc == -EAGAIN)
 			continue;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..31dadc128b4e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -746,6 +746,7 @@ void put_cxl_root(struct cxl_root *cxl_root);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->port->dev))
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);

