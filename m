Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4E3B71C5
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448182; cv=none; b=hEZiJW6ps7obnooef08Kr9sEFZTSWVskSdH20KIXWm5uKrM6GiDumOiNcjczDePTXmkFaPgMmLfgWhbZKCOPrJ13OqoutwhLlvB1gPIIq8m8EsKZGWOznBewjuUE9hqzTW6c3UxdbIVwu10K5QHRRACihA/T3/G6SuyEeTwClmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448182; c=relaxed/simple;
	bh=v2Y8QLeNGjHusKG5mSS1CluNmiDbrk7shaktZCW6aGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6Oirh+4oW8fwRLhJ3ovT+lIW23ooO8rMt/J/KzQq+hHDOGp9jlkBDsz/Z2fqO4gTcSn0Ja8+C4NiXeHrjgkuUrB/LZx6m5ufb6nsRACqQFSg1DED3RUsONwdeSQ5n95T9Mptb0Dv+ta/OOe2FboOP2YHAqO7rrroK4v10JIxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PqahTpyX; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PqahTpyX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448176; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9xdgk82SxmU4qyXPq+TvFrjNWCRaS2JNXAib21SnGh8=;
	b=PqahTpyXWL/1S/QJrWSDdoORlWE4HMpYWUHqDvWs1Ha5XN/vAaEOSvQb8md7U9PMVDbvzW7YQqF/kfgGeHpzrrScmVNkxRPnEAqWCftYeSJaWuBwHrUFCL5Yt35nAoX2rYzdN7zcRi7QtGTzEWhadK6l7QT4UdwihtpLX2HHU84=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oKIz0_1786448175;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oKIz0_1786448175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:15 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 1/8] cxl/features: Validate the fwctl RPC input length
Date: Tue, 11 Aug 2026 19:36:01 +0800
Message-ID: <20260811113608.2815625-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxlctl_fw_rpc() ignores @in_len, the length of the buffer that the fwctl
core copied in from userspace, and blindly dereferences the input as a
'struct fwctl_rpc_cxl'.

Userspace fully controls that length via fwctl_rpc.in_len, which the core
only bounds from above (MAX_RPC_LEN) before doing
kvzalloc(cmd->in_len)/copy_from_user(). An in_len of 0 yields a
ZERO_SIZE_PTR allocation, so the read of rpc_in->opcode at the top of
cxlctl_fw_rpc() faults, and any in_len smaller than the header reads past
the allocation.

The @op_size field of the header is equally unchecked. It is a u32 that
describes how much payload trails the header, and it is used as such:
cxlctl_set_feature() passes 'op_size - sizeof(feat_in->hdr)' to
cxl_set_feature() as the length of feat_in->feat_data, and
cxlctl_validate_set_features() reads the UUID out of the payload once
op_size claims to be large enough. Since op_size is never compared against
the size of the buffer that was actually copied in, a caller passing a
small in_len together with a large op_size makes the driver read up to
~4GB past the end of the input allocation.

Require the input to be at least header sized, and require the declared
payload to fit in what was copied in. This matches the documented
userspace calling convention (Documentation/userspace-api/fwctl/
fwctl-cxl.rst), which sizes the input buffer as
'sizeof(struct fwctl_rpc_cxl) + sizeof(*payload)' while setting op_size to
just the payload size.

Fixes: 4d1c09cef2c2 ("cxl: Add support for fwctl RPC command to enable CXL feature commands")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/features.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..0ab1a8547b7e 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -649,7 +649,16 @@ static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	struct cxl_memdev *cxlmd = fwctl_to_memdev(fwctl_dev);
 	struct cxl_features_state *cxlfs = to_cxlfs(cxlmd->cxlds);
 	const struct fwctl_rpc_cxl *rpc_in = in;
-	u16 opcode = rpc_in->opcode;
+	u16 opcode;
+
+	if (in_len < sizeof(rpc_in->hdr))
+		return ERR_PTR(-EINVAL);
+
+	/* @op_size describes the input payload that trails the header */
+	if (rpc_in->op_size > in_len - sizeof(rpc_in->hdr))
+		return ERR_PTR(-EINVAL);
+
+	opcode = rpc_in->opcode;
 
 	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
 		return ERR_PTR(-EINVAL);
-- 
2.43.7

