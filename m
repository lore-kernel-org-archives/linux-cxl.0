Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACE273800;
	Tue,  1 Jul 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370800; cv=none; b=XvX9ORFtct6Z4Gz5R79+Qnzp3buxFp4RS4hNKLOILtIObkTw4nVUb9pF/zlnfp2BBPWcC7d/jjx5CRDMoGBxiKfwusOF/mdXYf3dNNyhf+Zm/E4FeLsvWD3N4Zb35r8Qumcy65gQ+TkxSwvBx7iN5gYcCUBSMt7ksTNN1gvieH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370800; c=relaxed/simple;
	bh=eE+BK5pQFeUbxS+pqZWzB1zy4OWxCla1bWV9WxkErEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsO+rXOFeBPemiMnaq4Lv/+zvqROl+ZWmgEQkTziktQhc3h13ZdrS69xC7ZO9K6RxwPr9UvA+IjYZEkxwl4peczVDgUCjmJrILsh17woPh2Y7jXkRPo8Z5l31KHVwtyS4rpAWkHSBPLTaaw8WRgAFcPeoPJbe/Dgc/UPU3+hsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vAeXxLhG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vAeXxLhG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA202C4CEEB;
	Tue,  1 Jul 2025 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751370800;
	bh=eE+BK5pQFeUbxS+pqZWzB1zy4OWxCla1bWV9WxkErEk=;
	h=From:To:Cc:Subject:Date:From;
	b=vAeXxLhG8c1rAaiyrkTMYUSvl12q8Vnrba6Ri5+WoYJ245Jfe29MrCosFjJhzcpy6
	 vksertx7EC6/itMQaHaowpqxTk+Y1BJriSTQ/S7efv92nPH2g3JBo/G2inCWhlEIFV
	 DuXWMaAB/JFrrA+LltuXYwF2T1FdzknwZZ1thOzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: make cdx_bus_type constant
Date: Tue,  1 Jul 2025 13:53:13 +0200
Message-ID: <2025070112-whoops-grove-c355@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=eE+BK5pQFeUbxS+pqZWzB1zy4OWxCla1bWV9WxkErEk=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnJZzSOmzxbuGfBtPjfsj72F0VX9zmeXpD3U2htjxLr/ 0elM4ySOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAia6IYFkwWfLhLY+er6v8n p7w6n/Lz4eaI/1oM8wwNXovs/H722S7bJf1nm+X6PrikfgIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the cxl_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/port.c | 2 +-
 drivers/cxl/cxl.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..0696f7fcef56 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2293,7 +2293,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
 	NULL,
 };
 
-struct bus_type cxl_bus_type = {
+const struct bus_type cxl_bus_type = {
 	.name = "cxl",
 	.uevent = cxl_bus_uevent,
 	.match = cxl_bus_match,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..e7b66ca1d423 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -815,7 +815,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 
 bool is_cxl_region(struct device *dev);
 
-extern struct bus_type cxl_bus_type;
+extern const struct bus_type cxl_bus_type;
 
 struct cxl_driver {
 	const char *name;
-- 
2.50.0

