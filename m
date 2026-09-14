Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDC486623;
	Mon, 14 Sep 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390959; cv=none; b=S77cU/OQlMkzsVZUx3yzeqOhUIOfuccD6ML5rb3HWhefAy6ym2+QIk9tKJ8NTmTbXHve4a03I6lAScfOXkMH1/eiGzfyxB00UK9rstNXrgYdvzUEbfOHv5QQVcHzju5g9oxVKn8tPwTWMxs3ZlHtLFpgpATTFUUEASUSIwBFacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390959; c=relaxed/simple;
	bh=7GbaiCEjRwQUmr3ACyN5hD3nr1lFtbeBjz7zYOw52pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlUKDRNYuq90rK64/nFjwDnOVP7R6K3upB1LiLaSn972+Sj+fX6qwJrjiw64mmREuCWPjemhFsts3fhPQCSmhcYvCc92J9uPpkNqzjnmTMo6tuC1pT0anFx9nO2Ziil6TnDNA3lPgHSiObtrCUzwlvecHB+zHMINEuSsy+RuI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-01 (Coremail) with SMTP id qwCowACHWOwe76dqyj74Bw--.19200S4;
	Mon, 14 Sep 2026 20:57:08 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cxl/mbox: bound the Get Supported Logs entry count by the payload
Date: Mon, 14 Sep 2026 20:57:01 +0800
Message-Id: <20260914125701.1160136-3-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHWOwe76dqyj74Bw--.19200S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4rWF15uw1xAryrtF48Crg_yoWrAr1kpF
	WY9a4UJrn3ZFy7CwnrZay5WrZ8uw4kZryUAFyvg34YkwnxCr12qFyDGayYq34FvryfGF12
	k3Z0qF98Ca1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0E
	x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
	0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUkRBTDUUUU
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/

cxl_enumerate_cmds() iterates gsl->entries entries of gsl->entry[] using
the count the device put in the Get Supported Logs response.  The response
is only checked with .min_out = 2, so a device may report more entries
than it delivered and the driver reads past the end of the buffer.  This
is probe time, so it happens on every boot of a machine with such a
device, without any host action.

cxl_get_gsl() can already tell the caller how much arrived, because
__cxl_pci_mbox_send_cmd() records the copied byte count in
mbox_cmd.size_out.  Derive the number of entries that fit from it and stop
the loop there.
Guard the subtraction too: min_out is smaller than the response header, so
a two byte response would otherwise wrap the size_t arithmetic and leave
the bound with nothing to do.

Seen with a QEMU Type-3 device that reports 0xffff entries while writing
one, in a 2048 byte buffer:

	BUG: KASAN: slab-out-of-bounds in cxl_enumerate_cmds+0x1e3/0x980
	Read of size 4 at addr ffff888003707810 by task kworker/u8:2/38
	cxl_enumerate_cmds+0x1e3/0x980
	cxl_pci_probe+0x84a/0x11e0
	 which belongs to the cache kmalloc-2k of size 2048
	The buggy address is located 16 bytes to the right of the
	 allocated region

The Read of size 4 is gsl->entry[i].size.  The buffer can hold 102
entries, so claiming 102 is still inside it and 103 is not, which is what
the sweep shows.  With the bound in place the same device logs

	GSL: device claimed 65535 entries but the payload holds 1

and enumeration continues with the entries that are present.

This is the cross-check get_supported_features() already performs in
drivers/cxl/core/features.c, where a device supplied count is compared
against the retrieved length before the entries are used.

Fixes: 472b1ce6e9d6 ("cxl/mem: Enable commands via CEL")
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
 drivers/cxl/core/mbox.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a8f51bf0f..c94439554 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -794,7 +794,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
 }
 
-static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
+static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds,
+						       size_t *len)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_supported_logs *ret;
@@ -818,7 +819,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		return ERR_PTR(rc);
 	}
 
-
+	*len = mbox_cmd.size_out;	/* bytes actually received */
 	return ret;
 }
 
@@ -849,18 +850,39 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 	struct cxl_mbox_get_supported_logs *gsl;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
+	size_t gsl_len, gsl_hdr, max_entries;
 	int i, rc;
 
-	gsl = cxl_get_gsl(mds);
+	gsl = cxl_get_gsl(mds, &gsl_len);
 	if (IS_ERR(gsl))
 		return PTR_ERR(gsl);
 
+	/*
+	 * The device chooses the reported payload length and may return a
+	 * response as short as the entry count field on its own (min_out is
+	 * 2), so derive the entry count without underflowing.
+	 */
+	gsl_hdr = offsetof(struct cxl_mbox_get_supported_logs, entry);
+	max_entries = gsl_len > gsl_hdr ?
+		      (gsl_len - gsl_hdr) / sizeof(gsl->entry[0]) : 0;
+
 	rc = -ENOENT;
 	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
-		u32 size = le32_to_cpu(gsl->entry[i].size);
-		uuid_t uuid = gsl->entry[i].uuid;
+		u32 size;
+		uuid_t uuid;
 		u8 *log;
 
+		if (i >= max_entries) {
+			dev_warn_ratelimited(dev,
+					     "GSL: device claimed %u entries but the payload holds %zu\n",
+					     le16_to_cpu(gsl->entries),
+					     max_entries);
+			break;
+		}
+
+		size = le32_to_cpu(gsl->entry[i].size);
+		uuid = gsl->entry[i].uuid;
+
 		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
 
 		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
-- 
2.34.1

