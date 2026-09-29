Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255FA3DEAC8;
	Tue, 29 Sep 2026 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662104; cv=none; b=P9sfA14bzQX4O2Bsd7z2Z9eHHKwzgZMCprmiV6Jj/V8nJcrpH7Il+4yY/XbxC3otxcy/GOFxwIDCkzOI1DyNuDKHsdg6HirWWtPG/cPFJ4ijj0w/JAWYf8h+Ukf2mOpjDedM0VuzYrq0jprZDWd9Q12Vcj4azaF4GKxZk+ztWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662104; c=relaxed/simple;
	bh=k2bYglX9n5ZhP9Olp6WrZrXFMEcPUzsPwZS1+kslqcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AriWZIEjC7P/8hBgPpNXVEHIbrGtxHk7i05W/Le4axvrp3lNTr9yhNjN2rtI7EcOuJmoCHDbcj/BB4PnhwizALI46QXkNC8qAfSYkX0kIQ/OEnm5KOTGMeIQbLUuaapAnBZGRjQQNOzG3Tlw/XldCt+X+6rxKOQl1nZ4qR+RRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-05 (Coremail) with SMTP id zQCowABn1T+2VbtqJzOmCQ--.4354S2;
	Tue, 29 Sep 2026 14:08:13 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mbox: bound the device-supplied command return code
Date: Tue, 29 Sep 2026 14:07:47 +0800
Message-Id: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn1T+2VbtqJzOmCQ--.4354S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47Gw4UAr47try7Cw4rKrg_yoWrWF1kpF
	WDCa4jkrZxta47ArsrCayYk3y5ZF4ft34UA34qga9rA34ayr4jqrWkJ34YgwnI9rW8Ww17
	Aw4Yga1ruF4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUypnQDUUUU
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwMFDGq7TSQcvgABsW

cxl_pci_mbox_send() takes the command return code straight out of the
mailbox status register:

	mbox_cmd->return_code =
		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);

The field is 16 bits wide and nothing validates it.  It is read the same
way from the background command status register when a background
operation completes (CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK, also 16 bits).
Both consumers then index a table with it:

	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;

and that table, built from CMD_CMD_RC_TABLE, has 31 entries (SUCCESS(0)
through EXTLIST(0x1e)).  A device that reports 0x1f or above therefore
reads past the end of a global array.

cxl_mbox_cmd_rc2errno() is called for every non-success, non-background
return code, which makes this reachable during probe with no host action:
answering Get Supported Logs (0x0400) with return code 0x1f is enough.

Reproduced with a QEMU Type-3 device that reports a chosen return code,
against this tree:

	BUG: KASAN: global-out-of-bounds in cxl_internal_send_cmd+0x11d/0x190
	Read of size 4 at addr ffffffffa5212c10 by task kworker/u8:2/37
	Call Trace:
	 cxl_internal_send_cmd+0x11d/0x190
	 cxl_enumerate_cmds+0x12c/0x980
	 cxl_pci_probe+0x84a/0x11e0

Return codes that are in the table take the ordinary error path and
report nothing, which is what makes the out-of-range case attributable
rather than just "the device reported an error".

Validate once, in a helper that both accessors use, rather than at the
two register read sites: the same bound then covers the foreground and
the background path, and any future consumer of the field.  An undefined
code is still a failure, and -ENXIO is what every non-success entry in
the table already maps to, so callers cannot tell the difference in a way
that matters.

Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
 drivers/cxl/cxlmem.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1a..7f89dc4fc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/array_size.h>
 #include <linux/node.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
@@ -205,14 +206,39 @@ static const
 struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
 #undef C
 
+/*
+ * The return code comes straight out of a device register: the low 16 bits of
+ * CXL_DEV_MAILBOX_STS.ERRNO for a foreground command, and the same width of
+ * CXL_DEV_BG_CMD_STS.RET_CODE for a background one.  Nothing validates it, so
+ * a device that reports an undefined code would index past the end of the
+ * table above with both of the accessors below.
+ */
+static inline const struct cxl_mbox_cmd_rc *
+cxl_mbox_cmd_rc_entry(struct cxl_mbox_cmd *mbox_cmd)
+{
+	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
+		return NULL;
+
+	return &cxl_mbox_cmd_rctable[mbox_cmd->return_code];
+}
+
 static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
 {
-	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
+	const struct cxl_mbox_cmd_rc *rc = cxl_mbox_cmd_rc_entry(mbox_cmd);
+
+	return rc ? rc->desc : "undefined command return code";
 }
 
 static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
 {
-	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
+	const struct cxl_mbox_cmd_rc *rc = cxl_mbox_cmd_rc_entry(mbox_cmd);
+
+	/*
+	 * Unknown codes are still failures, and -ENXIO is what every
+	 * non-success entry in the table maps to, so the caller cannot tell
+	 * an undefined code from a defined error in a way that matters.
+	 */
+	return rc ? rc->err : -ENXIO;
 }
 
 /*
base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
-- 
2.34.1

