Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442063B442F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523132; cv=none; b=QvDZLnKqJ82zJXdB2L2WRGPDaF9dB5CAEDLmzo3ti9gQaOzs6Lx+fsutyFdeAu+qCYEVGUfUgxbHLQ8bdGJSjoO5aL6e266j2qlA/S/jN3ZNZOykANpI3F9z7QCyVZe/O6KfvJi/ezETI3O/6QvLWhYWS+aEK6zPBQaMtwEZ7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523132; c=relaxed/simple;
	bh=UgDH+0UmT8EKHV6zkYpXIbmDMRA34B9xhV7lb9tZoz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXMasWRluqqo6baTXkwweA/t/dzmnNhycPSarfsMDT4vZCWLcDec1Q29+M7Xwd0EJzeBbHc1BJtsj38OomzBEesRpgBRQd0QAAAzFBPKJ4gQtaslvPFjv3gt0L8oLAyI2lLnPzExOFBfs9ksRQdnwyteyiB7iNzv3OnBxc8lAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vv32Jzgc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vv32Jzgc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786523125; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=seJlBFvA4wpaI8eN+kXlat1QS47eLT6pUSfes6j1l7c=;
	b=vv32Jzgc89o7xJWLhVDKf2zGP6+cwAocqTtzPR9XYJSTY6Kc62Okhfdgz94nzC+HuZYYPECqDoNZcXFzh8+PwGHbs7QvkhjWKrNHjuHcopmNtI7BnBwbSNGjkWVQu2MpTTEDIn1xZukUVUhsll9mnONxsJnRq30Z1KLx4EEW15Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8r2roc_1786523124;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8r2roc_1786523124 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:25:24 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/hdm: Reset the commit cursor before enumerating decoders
Date: Wed, 12 Aug 2026 16:25:24 +0800
Message-ID: <20260812082524.359758-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port->commit_end is the cursor that orders decoder commits. It is set to
-1 when the port is allocated and then built up by
devm_cxl_enumerate_decoders(): for each decoder found committed in
hardware, init_hdm_decoder() checks that it follows the last one and
assigns port->commit_end = cxld->id.

Nothing lowers the cursor again when an enumeration attempt fails
midway. The decoders themselves are registered with
cxl_decoder_autoremove() against the port device, so they are released
when their devres scope goes away, and their ids return to
port->decoder_ida from cxl_decoder_release(). The other cursor,
port->hdm_end, is unwound by cxl_dpa_release(). port->commit_end has no
such counterpart - commit_reap() only runs when a decoder is reset - and
the port object outlives the attempt because it belongs to the agent
that called devm_cxl_add_port(), not to the port driver.

For a switch port the retry is automatic and cannot succeed. Decoders
are set up from cxl_port_add_dport() while port->nr_dports is still 0,
inside a devres group that is released when
devm_cxl_switch_port_decoders_setup() fails. That release destroys the
decoders and returns their ids, but leaves the cursor advanced and
leaves nr_dports at 0, so the next memdev that enumerates the same
switch - devm_cxl_enumerate_ports() to find_or_add_dport() to
add_dport() - runs the setup again with a stale committed count.
init_hdm_decoder() now finds decoder0 out of order and returns -ENXIO.
From then on every dport addition fails for a reason unrelated to the
original failure, even once whatever caused that failure is gone, and no
memdev below the port can attach. An endpoint port takes the same damage
across a rebind, where devm_cxl_endpoint_decoders_setup() runs again.

The failure paths that strand the cursor are all driven by device state:
an interleave ways or granularity encoding the driver rejects, a
committed configuration whose size does not divide evenly by the ways,
or a failed DPA reservation on the DVSEC emulation path.

Reset the cursor at the start of devm_cxl_enumerate_decoders() rather
than unwinding it on each error path. Enumeration reconstructs the
commit state from hardware and has no reason to inherit a value from a
previous attempt, so one assignment covers the existing failure paths
and any added later. This matches cxl_switch_port_probe(), which
already resets port->nr_dports so that a second attempt starts from a
known state. The write takes cxl_rwsem.region because that is the lock
cxl_num_decoders_committed() asserts for reading the cursor.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Found by the Sashiko review bot while looking at "cxl/hdm: Fix out of
bounds read of the decoder target list" [1]. This is independent of that
patch - the two touch different functions in hdm.c and apply in either
order - so it is sent on its own.

[1] https://lore.kernel.org/linux-cxl/20260812061017.56916-1-kanie@linux.alibaba.com/

 drivers/cxl/core/hdm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..c69ec539e6d8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1163,6 +1163,10 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	cxl_settle_decoders(cxlhdm);
 
+	/* The commit cursor is rebuilt from hardware below */
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		port->commit_end = -1;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

