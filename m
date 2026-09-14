Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0ED486628;
	Mon, 14 Sep 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390959; cv=none; b=TCWyruNhf13ZEJu+Arcg4f9tbgTdj5+d2SEsJLk+Q4TUi+CmIdV5BZEIPpoyrU+sR8c8dTBYzCHYfzRyIgxpFNNpA5MkYuViNb4es+DiXi7SaM9gMgPhGkwiqNA51UlRzgNIM5BIRFefqr/PJE5eLIpsohzaJFFKPlzlGF8PTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390959; c=relaxed/simple;
	bh=EJ/V5i0ODO4mP5JrB50YaKIx7JfIWvk4bsVJrO0Wtrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJbDOZycCIuxEDGqVbwl24w0BCeNe39viXVm057Oz4cSQQtoGq/iw9iSgiS3sKNoEL74P4wBOPMvkQjx24R0ibeigRPL1m7qvOmfai1aqSMjwuJ+DFByVgT1MRYXCmM0DCVXFCKHkQwHpUMBMiJ2Ghfj712EjrS9NB6YvOUhFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-01 (Coremail) with SMTP id qwCowACHWOwe76dqyj74Bw--.19200S2;
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
Subject: [PATCH 0/2] cxl/mbox: bound device supplied counts by the received payload
Date: Mon, 14 Sep 2026 20:56:59 +0800
Message-Id: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHWOwe76dqyj74Bw--.19200S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xXr1UKrW3Kr1rtF1rtFb_yoW8CrW5pF
	Wag3s8KrWkJa43CrZxAF4Yq3y5Ar4kAa90grnxtw1Y93Z8Jr13XryrKr4Fqw45urZ3XFy0
	q3W2gr93G3WDZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUysN3UUUUU
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/

The CXL mailbox layer uses counts the device writes inside a response to
index flexible arrays in that same response, without ever comparing them
against the number of bytes the device actually delivered.  Two of those
walks can leave the buffer:

  Patch 1  Get Event Records.  record_count bounds the walk over
           records[], in cxl_mem_get_records_log() and again in
           cxl_clear_event_record().

  Patch 2  Get Supported Logs.  entries bounds the walk over entry[],
           during command enumeration, on every probe.

The number to compare against is already in hand:
__cxl_pci_mbox_send_cmd() stores how many bytes it copied into the driver
buffer in mbox_cmd.size_out.  Both paths derive their bound from it, so
this adds no new trust in the device, it just uses what the driver already
knows.

It matters because the count is read from the same response whose length
the device also reports: a device that reports success and a full length
while writing less leaves the kernel reading the rest of its mailbox
buffer as the count.  Firmware that takes an error path can do that
without any malice, and patch 2 runs at probe time, so no host action is
involved.

The cross-check is not new to this driver.  get_supported_features() in
drivers/cxl/core/features.c already compares the device supplied count
against the retrieved length before touching the entries.

Both were found by fuzzing a QEMU Type-3 device that lies in those two
responses, with a KASAN guest kernel; the reports are in the patches.

Gaobin Huang (2):
  cxl/mbox: clamp the event record count to the received payload
  cxl/mbox: bound the Get Supported Logs entry count by the payload

 drivers/cxl/core/mbox.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)


base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
-- 
2.34.1

