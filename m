Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C88272E59;
	Tue,  1 Jul 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371665; cv=none; b=SJ6xUGiTAKHKNvAXx/Q8ZSQsp9zn2uvpcBfxYvbiG9Gfz2CH+C+OMhTm2XHmvukbmoducUDfEEsbUuhPUrhnAkSA25aSOtbIGOmuUrd9CJyiLQ01p63ZlR/4DAuDaHMqSztBAnqnk8V9jR5skaZhj2GBASVeXSNNmYBouKJoAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371665; c=relaxed/simple;
	bh=iBF/y+yecO68ndK0fEdFmCdiNOBjTqzz5e8PY4hyxm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WH/u5UBWvdiskjb6LTZ8eF9+aqqKe74/C9Me34Vn2tA+mGI6YsNRkyMXlP75urNFMzgtUSgFPtHhAmkV7yqZGtMkC8BxA2Y/4XfIyFf4AMiW74Qxrb2sw3o0vuA/8N55KjKavMceoa3UPO81xxvA1R3GsIQCqgBkcRZDESvLzIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urpqvLz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urpqvLz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1403AC4CEEB;
	Tue,  1 Jul 2025 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751371664;
	bh=iBF/y+yecO68ndK0fEdFmCdiNOBjTqzz5e8PY4hyxm4=;
	h=From:To:Cc:Subject:Date:From;
	b=urpqvLz1U3coMyX1Zwun18Oyq/dYL8+1/TFb6t74YZTR7JibJ4MdRMaJkyK/NXlWL
	 fJa8tJpvFykFx322u74xk1vOtPrHna7ll652yL0g9Eds5rnmlARDgxTzAzYKU6TTAx
	 309ZC57jfoZTb/TJfKTqujHbYXID9zTGxQp5AUE0=
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
Subject: [PATCH v2] cxl: make cxl_bus_type constant
Date: Tue,  1 Jul 2025 14:07:39 +0200
Message-ID: <2025070138-vigorous-negative-eae7@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=iBF/y+yecO68ndK0fEdFmCdiNOBjTqzz5e8PY4hyxm4=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnJ57ukhJjXsonO3hVecLqmTmajx4Owu0s4Piz0feg4y S/Ae4JhRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkw0eG+c6vnM1uny+PzeKa v0vz6h2ZUxvCLzIs2Opw5+aj5XFHWlZEim6feuWffvdEAwA=
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
v2: fix up the subject line to be correct

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

