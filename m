Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605402;
	b=liRgV/WRvqsbFb8nFDpXg4abHaV/NLgHpJ/n7CsViGVBHbLSX79gVAPJYW9+qULflmqE
	 Oo61+Rb0Me7Vw8NVq3/B7TMJHw1kRzbhBJktWFz3wFoggYaCUD96/w3UL9Sns0KLLWC7k
	 V3zlnoShBRNr+61bwgWeT+HtZxR3PzVHcwHNPAlxN7nhtE0/rcnqsv5bk2FbBu+3dGL+C
	 tq/6PGMhrqMq/+oTRZ+h7/LvzyZrwUwwA7zVnwVn19c7vdgvd8jYkia88aJhRRN4W6Aef
	 Dtl4Hka4/UoyD+nVXWcZ3lgBJyQ4kuGL4raIYsxeizC2X20lgINdNdEOQjjm7QOiICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
	b=aXeJ9JwwjULiRb8f6sN4ecfPJzY8Ff6dgCHDHhwlnqRq2wZwJSZ+4moyYb+iuXjoxbqH
	 6cpRDyywjMGXgPETfqQzzxTggIzDPW5GdRyP6aKepJ2CtMeH9Nse9UPbfCaj0lIXM/D4t
	 h0WB6ZpIV0o/BrmRZ3fXoCSyihr993DYubS/+3hhJag8Ni2AUP5USXIxJ0tS7KMDeJBWr
	 vvS0sbi+9eCW4PpxbXvqNvKv5u9pgYaPFSL19fUc1fAoKR21o+UgtGrC2ZEiIbwTMu9qe
	 shxFZTRxLntkMU3FQvKHbjfFidMauridn4oRrPOxvgc4Oknma8BgMz6duoC3vfQJ/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=XQ8MzsJf;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8D606A319
	for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 17:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD8D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=XQ8MzsJf
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so1407911c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605401; x=1793210201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
        b=XQ8MzsJfm7hVLaVVmJxcZ6cCv2OpnZhEPS/ixp+1iyeH7bdd67uqG1H1T22iN81Vpj
         IqdFpLXy+hex8KLmaifYYxCctnfDmCSeb6G/AZ2ct0NJ7cUn6kLJdQhpKeFcQ0KzF1QO
         MaQCpyPrutkdj7djQwJeI99nmLRhJMs07Kkrf+Y/qy+Vl6TpSthXMSA1odxP9ZiiAWfJ
         jkVxSyB/XBfrqpb4OYXbXcDz52Ok2oaXNuR2p6KUICorES9mE3pSIOIZVbHrA+dpsHBI
         /8OuhiCIh+NdJvgh0zzCsMwPSjQK1TE+TJk+8qxNr4sz5wUBSb29H8lSMda6j9GbB8EB
         l/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605401; x=1793210201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
        b=lSZ7aHFdx5mbzTJuGtMaiwYKIB8C0IuNvlzqNm0ufjsMvqiJPPg2SjU1uN76hBhpP8
         rIbz3P7NT58DZ9T6UthCiXc1SH50eagIixipsrv0hZsu7E8H2Ncpg3gN+u08OmsxQhlm
         XWLlCeJr11++kJbuSEYGYP7YmM4/u3Dqao7FOq+zeUSVyVp9b+Br6I/Q5z7AyDh9EMqH
         KSuGoedrXcN5LY7u4d5AIVb6r/GFGPiqZTrJydBKcaW+8OaEVZPAuEKSyix6GQuAYCRd
         gur5ajCFASBFQBLGATBeGPGn7x+q71M5urg8Q3XRAOqdIv0ys7flO6OEBIimS7JsS9oj
         ohZA==
X-Forwarded-Encrypted: i=1; AKwUvBycRATtC+K5eOFPs/GWKqoidTzsT6iRCu8H7BXTmTv/ukQyncD1JewBaaymtPt3zlX2EuYdbyv4acE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8vKN7Ghsr8DHX5Syz1tBa9HqpjWyUjR8zMAWGT5MgVy3dqVIo
	sYc2WOGo2tOoMTbJ13k14smLQ5b5z08b8oqLjonfrz8CzDHCuLFR4TCIXMj7fqBWlTk=
X-Gm-Gg: AYBFou3cmRr/tIh2WIwEWpHHlqBtl3YgwRBKG34xg6qhw1Me4Fa1OYHFTA+c3mxp7qj
	gOCimtHoeEmwy66tSKwCwLZJwa70FcDIuLaFlTtSPvTw6mOkSE4h2WPHF861tMgBeDqqq3FogMB
	Wk+03frODxlVhuMluonBglaX5n4bpCy2zGun82Ybrxucszja6knRMkHGZB9yQBPpYy/vAYjwzx4
	9BmZ+1sJAll4fA5P+xOv54Cjym6SMbwlYNqm3Jgm3PFZjNwOxSjWGI9OWbUji3YNH+Jz5pu1MxY
	1ClutxSHyHK/CZu87xfDR8R7TAlVqeAXgIeH2ju6Igw9OwDtoo5Dxpw+sYs3EFP+diV4PRHcjdN
	glDnFgy0xCXjsH0+pw/5RUJe6P4TAPWLkmFIQ+rmvclywMBBPqrHSmNrfiuIMcUT6A5FB1fiYZz
	DnDfWzPs89E7DFTIOokKOq87THW8tVe7IutMUMRkoHjJqvi7A+GxkC2jVr88XKFWnZvBQoXW/hV
	2+EltwCcDxtzC8Cko4KUwigZh/awrxJuk3expHmOo1XrQfPLzBHikyyEloskKX9MBP6+45qCSxc
	gHO1aufx1R0fFJhR/gwlSXWD2N6sq62Ovqf0byBK1PXKNruXfy0g
X-Received: by 2002:a05:7022:928:b0:151:6e80:baa9 with SMTP id a92af1059eb24-190a4ffadbbmr4178212c88.12.1792605401167;
        Wed, 21 Oct 2026 10:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm7736763c88.14.2026.10.21.10.56.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:56:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: alison.schofield@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	icheng@nvidia.com,
	iweiny@kernel.org,
	jic23@kernel.org,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com
Subject: [PATCH 6.6.y] cxl/mbox: Clamp mailbox output allocation to the payload size
Date: Wed, 21 Oct 2026 13:56:37 -0400
Message-ID: <20261021175637.1655-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Cheng <icheng@nvidia.com>

[ Upstream commit 8a13db9f899d149c3aab24abcb668121cfda5a4f ]

CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
kvzalloc(out.size). A large out.size drives a huge allocation, above
INT_MAX it WARNs and taints, and with panic_on_warn=1 it panics.

The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
to min(out.size, payload_size, device len), so the output buffer is
never written beyond payload_size. Clamp the allocation to payload_size
too, matching the RAW path.

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Link: https://patch.msgid.link/20260624144147.53997-1-icheng@nvidia.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
[ Backport to 6.6.y: Use the target mbox and mds objects for the upstream
  output-size clamp. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-93186 to 6.6.y.

The code changes match upstream with the target mailbox object names. See
the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/cxl/core/mbox.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 059e95e086205a497eb5f6c863a4bfc29c1c16c9..278a11657d8b7516533749bc8c1ce3eb933848cf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -359,11 +359,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 		}
 	}
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox->size_out = mds->payload_size;
-	else
-		mbox->size_out = out_size;
+	mbox->size_out = min_t(size_t, out_size, mds->payload_size);
 
 	if (mbox->size_out) {
 		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
