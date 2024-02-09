Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC372D05B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479672; cv=none; b=JFxD95VLKEEWqHrFoWMme5GEE6JVUId0cf9DJLGnxF65EDpn3SbWu++aJOqrf3lKhg0mXyuNxIKCkc5IXxtlU7bWZesTQtSACkDPadWqLvnui2Lb9B4BGdreQyflI9IoxJXe+eqSY6t59xPbzYSoSR+2NRTk8q/6hRuk/Vjkd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479672; c=relaxed/simple;
	bh=MnCVUOG7QYKmV55TxRoyxRi+hfSu7P6Gu8B4tvl7vLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F75sGJaT8FkAqDJhuqgyc/m0y+/mleLklk6Ys7AvGEX08BCPfkQhajAVwXirugr4SnwmQbNuIlzruxrXoivzc8MepoDUAhoI9uCzAjmeIilyq7Sqc0TPyYl7sbrYMWfb87ORxpyxRHpLOTdCYmXcsS9rIGwgDLBfj+5XaDr17LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V6HTYsii; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V6HTYsii"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479670; x=1739015670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MnCVUOG7QYKmV55TxRoyxRi+hfSu7P6Gu8B4tvl7vLQ=;
  b=V6HTYsiioleBT1pzL9q83IkALRROiI0SC6YPrDQSCN4h1lB8jfFZphen
   DqpLGPLEZdbyzID/b6cqY+H27gb9y8ODo4TIYIK3C2bpN35ZDBXqIcrDl
   H+B8YxgiDMMeCnOM7Q3/oFxdIWZBNf9jPQ6P99CKT1SOYKQxPEIGe3WRf
   Nz9M45qJmBVG+jp2toNOdWLZA8nrb0CgOLa48hhe1gTavhRYEaJw4Uqry
   IiYphkaQLr5CWI9kI4qR8371fUHKzeUiTlqmmFtBuFtMCP6VjY5BZRn1Q
   LPsbhC+b2UqAabcrWOgPsFd7vKR45xPRMHT2ix0xwtUkNzareu+W8pv31
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="149214304"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="149214304"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:22 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A6A2DF2D4E
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9903321A844
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3ABB61EA835
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C63EB1A006A;
	Fri,  9 Feb 2024 19:54:18 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
Date: Fri,  9 Feb 2024 19:54:13 +0800
Message-Id: <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--1.506000-10.000000
X-TMASE-MatchedRID: rMrifpT/n7G1UOlz1sLXchF4zyLyne+AVBDQSDMig9HHkH7uosEn7Hj6
	+0kG6ijw4vM1YF6AJba/IVneJQLBZQtuKBGekqUpnH7sbImOEBTlWfEpOEu2d1ro1J0HyADyuN2
	ViA1o+X1p8m481R42eL3i+dgqnYmih+XoUibFwoJARN3eHcDWfdeLTJRd5T2oJe7un0C4hwObDR
	BqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The length of Physical Address in General Media Event Record/DRAM Event
Record is 64-bit, so the field mask should be defined as such length.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 89445435303a..388a87d972c2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_FLAGS_MASK			0x3FULL
 #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
 
-#define CXL_DPA_VOLATILE			BIT(0)
-#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define CXL_DPA_VOLATILE			BIT_ULL(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
 #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
-- 
2.34.1

