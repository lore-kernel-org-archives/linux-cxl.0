Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97191FB3D4
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706075; cv=none; b=TGjqGXTi9ptxg6dUNYttt299ALeCT8+CQJLvaYqv88T1KsADjwHwMbsqqv3WVdkzFBFqL/oeczYcgzOoSrHt6qVZsggSMMwomYS1X3yNLeBZGJ9FMaTTpcSvv7h4uNS4QW+dB6S6xKIumr5w6psYdgnt+sIA4fl0DZjazXKzzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706075; c=relaxed/simple;
	bh=2bEFhd0YTqeO8rlInJt7aPO+FmyOXWrwPqtcu3YMliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9VcwaCswmF1eHfxl8nQMbBSKLJ9Wv57PrpnC8a5LJZPjSJMbWmOpH6MESJHu76lsPfziw/vWE/CvESRR2M07LNdpaOBh1mL2b/a8Rwm4sCJBnyHGRS8/LRYKDR58WZ/N4fi2MsIHLP3kl8yym47EkEdayUE5tyN19BhQytLHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DCCC4CECF;
	Fri, 15 Nov 2024 21:27:55 +0000 (UTC)
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
Subject: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for user submission
Date: Fri, 15 Nov 2024 14:25:38 -0700
Message-ID: <20241115212745.869552-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
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
 include/uapi/linux/cxl_mem.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f70bd7d28ff8..f49665d3b4d6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
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
2.47.0

