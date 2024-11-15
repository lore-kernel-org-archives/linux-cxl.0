Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C391FB3F8
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706086; cv=none; b=oGL22o2s6h124D8v8FlIMI3Y0LQe+fHoC7BI2H8eKcrPI7JWgBp8n1q/fFTkfBHsNDjWBFhuuHJQPoKq/4d/cYCItmN8ko3K6+9Tg7tPz7B/R/vBtDEzijjSao6ydPbOxROH4AdQzS8gTRLKMRCIfBemuJkL3OzZIGajbAF2c0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706086; c=relaxed/simple;
	bh=I+D+Hn2hmqk4QgdVsTxVBuZBTO9ampZTBon06QPd39U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNT5V784+cZ4BCZooCyJxcS4WzoxOhxdoKBvctLdBtaLesgcz5JqfMU1lJaf+0KMaoxdg6hgnhoP3V84xv32JW1owIkDG2rCxScvPCez2P0FgVT1xQTx0aTo3z1oF+e2sd1wuYXcOQvWj+f8WLDKm80UngMztbTTauHX3CNOZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451B1C4CECF;
	Fri, 15 Nov 2024 21:28:05 +0000 (UTC)
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
Subject: [RFC PATCH v2 12/20] cxl: Save Command Effects Log (CEL) effects for enabled commands
Date: Fri, 15 Nov 2024 14:25:45 -0700
Message-ID: <20241115212745.869552-13-dave.jiang@intel.com>
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

Store the command effects via what device provided via the CEL in the
'struct cxl_command_info' structure. Steal the upper 16 bits to store
the effects value in order to keep user API compatibility.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      | 2 ++
 include/uapi/fwctl/fwctl.h   | 4 ++--
 include/uapi/linux/cxl_mem.h | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f464eb42f08a..fba6bdd30a82 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -795,6 +795,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		cmd->info.effects = le16_to_cpu(cel_entry[i].effect);
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 7334907e27c1..04da549cd4ae 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -74,8 +74,8 @@ struct fwctl_info {
  * struct fwctl_command_info - Hardware command information returned from a query.
  * @id: Driver ID number for the command
  * @opcode: Hardware command opcode
- * @set_effects: Effects to the OS and hardware when command is executed.
- *               Provided by the device.
+ * @effects: Effects to the OS and hardware when command is executed.
+ *           Provided by the device.
  * @size_in: Expected input size, or ~0U if variable length.
  * @size_out: Expected output size, or ~0U if variable length.
  *
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 469dd481795f..9dd37849c450 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -118,6 +118,7 @@ static const __u8 cxl_deprecated_commands[]
  *         the label-storage-area can not be written while the kernel is
  *         actively managing that space.
  *
+ * @effects: Command effects reported by the device.
  * @size_in: Expected input size, or ~0 if variable length.
  * @size_out: Expected output size, or ~0 if variable length.
  *
@@ -136,11 +137,11 @@ static const __u8 cxl_deprecated_commands[]
 struct cxl_command_info {
 	__u32 id;
 
-	__u32 flags;
+	__u16 flags;
 #define CXL_MEM_COMMAND_FLAG_MASK		GENMASK(1, 0)
 #define CXL_MEM_COMMAND_FLAG_ENABLED		BIT(0)
 #define CXL_MEM_COMMAND_FLAG_EXCLUSIVE		BIT(1)
-
+	__u16 effects;
 	__u32 size_in;
 	__u32 size_out;
 };
-- 
2.47.0

