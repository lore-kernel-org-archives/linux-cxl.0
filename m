Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F94C66
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777345; cv=none; b=kGkC7InzuHGLjSbmoaw8cgvTnLRj0v7lL48Zm+tiz9FfpqzSsLOKKGAIZn8Aq7cTh8zKvMpfpusqn5Satlml/U1Uh5r0YrQE+SmHtBWX98p9Pi6xXCqUHIfOrDELGd5yZleFsrFShkvojv34DJ3gyjmJQ2Lk2t38xJf4s0OcMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777345; c=relaxed/simple;
	bh=wu6QcMpTIWxavY/2/4LyZBluATg7cbaktwykv1ioA00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOPhubl/MGmxgss+NB2utzXYM+HowfmmrTko7wB/YnK3YuRJgcE9xQO8BQiY3oJ40+Sfy01dpAnRN8m5wnjcdXXubM7hWCGB1LBSmMiOgLRpCc1o8tN/NX0wJbE6uQ0NCnRihX2xstwWxfkBYsfV6P3Gh8CeHqouVpiFefv6OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XlVeKzf0; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XlVeKzf0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713777343; x=1745313343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wu6QcMpTIWxavY/2/4LyZBluATg7cbaktwykv1ioA00=;
  b=XlVeKzf0CBI5ohI6PfSQQSoruYmkq0HxaFSepIYE/3OmXHZsG1DuNn5S
   K8+/9eNJG8H4g5dv57mv2UpyqD5PdlK8XdMxyIDQV64cBK9vkA6vYSRoP
   95cNKIod7abbBD8L36t8S97eAWjvQm/BTrIezPauBjob1IcaP9EkL5MlS
   YQ2DPxoZa4P6v8mgKFVqbP7LV/+/wTFNmbv3YwurSsZY5kryIRKMlHOU9
   xdOKuKqNZHRa7PPK8m2NyV2gWPekQeqnP07EMWzVYFT3QGXRm9kq66tZZ
   zME7U6LmagoSQnqG2xj9LO2sqV+FeCPToeJK2d+5bSArlXdUeto4UNsyX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="156593919"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; 
   d="scan'208";a="156593919"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:14:31 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 891BDD5004
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C26F81590F
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3DDA8200932C6
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A36501A000B;
	Mon, 22 Apr 2024 17:14:27 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v4 1/2] cxl/core: add passthrough flag to struct cxl_switch_decoder
Date: Mon, 22 Apr 2024 05:13:49 -0400
Message-Id: <20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10--6.745100-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXSCAvsmJ/zu/6oXHZz/dXlxj7hvEKSa/BRBL//DKiVczqKJ
	8yeXnfHAjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRzr16YOzjZ11MVCcj56k8hrgbJOZ434Bsunq
	BIQj+1JlMgLbAPLc3nKD8el0BdzuoNyl1nd9CIt0URSScn+QSXt0H8LFZNFG7/nnwJ52QYi+pyg
	CGKFPC+PL0dqdhIhOvYXExMvg8UtWKzA3c+VUMOnvnCQ6wKniu2RcfcR4aT8g=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per CXL specification (8.2.4.20 CXL HDM Decoder Capability Structure in
r3.1), the host-bridges with single port and switches with single dport are
not affiliated with any instance of the HDM capability structure.

Driver will add a passthrough decoder for each of them during init, so the
constraints imposed by the HDM capability structure do not apply to the
passthrough decoders.

By utilizing this flag, we can swiftly ascertain whether a switch decoder
qualifies as a passthrough decoder, thereby avoiding the need to conduct a
string of capability constraint checks.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c | 1 +
 drivers/cxl/cxl.h      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..27fb4f9d489e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -57,6 +57,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	if (IS_ERR(cxlsd))
 		return PTR_ERR(cxlsd);
 
+	cxlsd->passthrough = true;
 	device_lock_assert(&port->dev);
 
 	xa_for_each(&port->dports, index, dport)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..6f562baa164f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -415,6 +415,7 @@ struct cxl_endpoint_decoder {
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
  * @nr_targets: number of elements in @target
+ * @passthrough: indicate whether the decoder is passthrough
  * @target: active ordered target list in current decoder configuration
  *
  * The 'switch' decoder type represents the decoder instances of cxl_port's that
@@ -426,6 +427,7 @@ struct cxl_endpoint_decoder {
 struct cxl_switch_decoder {
 	struct cxl_decoder cxld;
 	int nr_targets;
+	bool passthrough;
 	struct cxl_dport *target[];
 };
 
-- 
2.37.3

