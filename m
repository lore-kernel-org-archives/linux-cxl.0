Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC101459FC
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338499; cv=none; b=WreqEOzIOg/cTqilebm/VHK50gXgrVgKVXK44e6pbl9f33XZcvMHTCXhJ9BarRdF4Wt6Jzu8SSzyqBaPOuKOi65nPOnH3KEBueRDzaR7ba5WajK9vUHMm7y9waYMdi5U+5rs7hiiUNFtlYxcxEdF1RnHUiYM9QkYmrSRnyyrb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338499; c=relaxed/simple;
	bh=54UW/LOvNEtk5bhVJWRTaXQhqV9sMrplx2nvvXQMxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgG7uzUgqH2dIr+EmLB51D03IzGwrbnohYi154uoCwq3RhR1l3U0TObWeBleKkhODJzbbE60ZaR1NXfBab7YNGSQnVd4PqsQUcxj45ZhLnAL0H41QvZb5Zhx+7TjDJL8LaKloLVK7RcR7YQrVa2uUNDKwcVAepmh017Fn4frx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A7C116B1;
	Thu, 18 Jul 2024 21:34:59 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [RFC PATCH 06/13] cxl: Add Get Feature command support
Date: Thu, 18 Jul 2024 14:32:24 -0700
Message-ID: <20240718213446.1750135-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enumeration of Get Feature mailbox command for the kernel to recognize
the command being passed in from user space.

CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)

The feature requested is identified by specific UUID.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      | 1 +
 drivers/cxl/cxlmem.h         | 1 +
 include/uapi/linux/cxl_mem.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 70e3962ed570..b58b8cc517c9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4d3690aa2f3b..317cb92b0bfb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -483,6 +483,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index bd2535962f70..90dcb9723997 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -51,6 +51,7 @@
 	___C(CLEAR_LOG, "Clear Log"),					  \
 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
 	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
+	___C(GET_FEATURE, "Get Feature"),				  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.45.2

