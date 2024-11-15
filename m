Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB851FB3CF
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706078; cv=none; b=X/JoLu9FD8jworhvb3UGxocDPTNyvG/Q8dGWyxwxkI1cfi8oFhJNKXA+LGlBcJlHCwN23QT3RqjEbAc7xR8bjXjxJtKgfEQC0sBRJfIJUZNlmQmMIF7Te4P127kObsvfDNvVcC43PvSSoT0Ld/OIzzIthSBnnp6xHVCTdU/bEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706078; c=relaxed/simple;
	bh=Oti3uXlgx4lCxIan2nV54r2yX1qIvLLH/AiPbJOSZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToFuvi239jaLPvAQe55FeYZaxOg8B41J3q62cUcGIynlrRdUs8U6NTQg8tJXmlaobAdgArtqYvgbNLMm+szjNamektWOeJ/OhkqVKzv2bmFMxyWIjrH9VoX9OlmrUUmFIvdDU+ejFXxBLIBdH0q3GKJobqrKCup+ijBwr+cyQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C650C4CECF;
	Fri, 15 Nov 2024 21:27:58 +0000 (UTC)
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
Subject: [RFC PATCH v2 07/20] cxl: Add Set Feature command support for user submission
Date: Fri, 15 Nov 2024 14:25:40 -0700
Message-ID: <20241115212745.869552-8-dave.jiang@intel.com>
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

Add enumeration of Set Feature mailbox command for the kernel to recognize
the command being passed in from user space.

CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)

The feature requested is identified by specific UUID.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      | 1 +
 include/uapi/linux/cxl_mem.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4b9abf9a5b2b..739444d34130 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -69,6 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
 };
 
 /*
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 90dcb9723997..469dd481795f 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -52,6 +52,7 @@
 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
 	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
 	___C(GET_FEATURE, "Get Feature"),				  \
+	___C(SET_FEATURE, "Set Feature"),				  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.47.0

