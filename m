Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEA4AF9D8;
	Thu, 17 Sep 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642033; cv=none; b=q63k+ipATqx0H3Uy/X9rzYpXVE7fDZMwk6frL+lwqsm1xEmNYP81M2HkEXLAXAQZwSeMOSG6fNV/H0ZIS4M02O2hEd/2TWGHipwgcP05FZKkS3rZSbuM6zp3wWI3WMJhvEDdI388DhtK8us5VxNIIr4qWL2xT5KDlpvL6DpVzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642033; c=relaxed/simple;
	bh=DkWxEc7jBjWmpGCexxcFD6aq6LpdHBmUOZavT9HxjbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqLOZbhnhReyyTVolsX+DcZO7TbL8tKtj0jbLP68IZIzfxFf8sOlW+G3yFBUgkKcBnfPoKh17/Rf3fLLIahiXUF2awqZUrbRCIV1Hfo+kA52XNAUzeY+ydiHS6Gll8xDkLKwvJ2aXqUl0IAIe+uc5+53a9CUelyZ+/I8IJdrpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-01 (Coremail) with SMTP id qwCowACXMPQJxatq7YY6CA--.4150S2;
	Thu, 17 Sep 2026 18:46:44 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Anisa Su <anisa.su887@gmail.com>
Subject: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry count by the payload
Date: Thu, 17 Sep 2026 18:46:03 +0800
Message-Id: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXMPQJxatq7YY6CA--.4150S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4UAF13CF4kKw4xZFyDAwb_yoWxGFWxpF
	ZIgFy5trs7ZFyxCwnxZayYqry5Cws5ZryUAFyvg34Yk3sxGF12qFyUKayYqryYvryfGF1I
	kan0qFZ8Ca1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5dMa7UUUUU==
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwYNDGqrrRlQGQAAs8

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

Like 1/2, this is hardening against a device that does not honour the
protocol rather than a fix for a regression: an honest device never reports
more entries than it returned, so no existing hardware is affected.

Reproduced on the tree this series is based on with a QEMU Type-3 device
that reports 0xffff entries while writing one.  The 2048 byte buffer holds
102 entries, so a claim of 102 is still inside it and 103 is not:

	BUG: KASAN: slab-out-of-bounds in cxl_enumerate_cmds+0x1e1/0x870
	Read of size 4 at addr ffff8880036de810 by task kworker/u8:4/48
	 which belongs to the cache kmalloc-2k of size 2048
	The buggy address is located 16 bytes to the right of

The Read of size 4 is gsl->entry[i].size.  With the bound in place the
same device logs

	GSL: device claimed 65535 entries but the payload holds 1

and enumeration continues with the entries that are present.

This is the cross-check get_supported_features() already performs in
drivers/cxl/core/features.c, where a device supplied count is compared
against the retrieved length before the entries are used.

Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
v1 -> v2.

1/2 of the v1 series (the event record count and cxl_clear_event_record) is
dropped.  Anisa Su posted a fix for the same bug in the same function on
2026-08-31:

  [PATCH v2 2/4] cxl/events: Validate the record count reported by the device
  https://lore.kernel.org/linux-cxl/20260901002912.958-3-anisa.su@samsung.com/

It bounds the count with the same expression (struct_size() against
mbox_cmd.size_out) and carries the same Fixes: commit (6ebe28f9ec72), so this
is a duplicate, and hers is the better of the two: it fails the command rather
than clamping, which also bounds the per-log loop.  Clamping leaves nr_rec
non-zero, so `} while (nr_rec);` keeps issuing Get and Clear Event Records to a
device that never clears them -- a hang, which is worse than the read it fixes.
No reason to post both.

The patch kept here (formerly 2/2) is not in her series: it is the Get
Supported Logs entry count during command enumeration, a different function and
a different response.

Changes from v1 to this patch, from Jonathan Cameron's review:
- drop the Fixes: tag; this is hardening against a device that does not honour
  the protocol, not a fix for a regression, and the commit message says so now
  rather than leaving it to be inferred.
- use struct_offset(gsl, entry) and name it gsl_hdr_size so it is not read as a
  pointer to the header.
- fail the command when the response is shorter than the header instead of
  deriving a zero bound from the subtraction.  That also removes the ternary
  and the underflow it was guarding against, so the comment about wrapping went
  with it.  -EIO because that is what cxl_internal_send_cmd() returns for a
  payload size mismatch.
- add the missing blank line before return ret in cxl_get_gsl().

Anisa Su is on the Cc list, as she asked on the v1 thread.

 drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836..e7daa23de 100644
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
@@ -818,6 +819,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		return ERR_PTR(rc);
 	}
 
+	*len = mbox_cmd.size_out;	/* bytes actually received */
 
 	return ret;
 }
@@ -849,18 +851,47 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 	struct cxl_mbox_get_supported_logs *gsl;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
+	size_t gsl_len, gsl_hdr_size, max_entries;
 	int i, rc;
 
-	gsl = cxl_get_gsl(mds);
+	gsl = cxl_get_gsl(mds, &gsl_len);
 	if (IS_ERR(gsl))
 		return PTR_ERR(gsl);
 
+	/*
+	 * The device chooses the reported payload length and min_out only
+	 * requires the entry count field on its own (2 bytes), so a response
+	 * shorter than the header is reachable.  There is nothing to enumerate
+	 * in that case: fail rather than derive a bound from an underflowed
+	 * subtraction.
+	 */
+	gsl_hdr_size = struct_offset(gsl, entry);
+	if (gsl_len < gsl_hdr_size) {
+		dev_err(dev,
+		"GSL: response of %zu bytes is too short for the header\n",
+		gsl_len);
+		return -EIO;
+	}
+
+	max_entries = (gsl_len - gsl_hdr_size) / sizeof(gsl->entry[0]);
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

base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
-- 
2.34.1

