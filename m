Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487050;
	b=ljxKfBU5tjWhUUdYEkOpbXeIjZSZo8G2B3ZUbAdFdSNcor84KPSGTKpnfbJNuJ5sq5E+
	 65I0mRwd3tcNxT+ywMJIY2utcmCysWNgBOH5dV9tP8VfLw/13kpgUQlF7ZEP+cB8+Xbo5
	 o+mvGi8vA+SNY2pq9sz7Cm8d3iVQ23LTNGfXppJn4OhuvWXR3YGsWc8m9hl3bA/i2j5jj
	 LNXazg6wZzrsww62bgUlrrSGCSwxzhus2Fwpt21b0xJDAdw+yZk+uKvJy65o9yqCxYDLK
	 r8mczqKyZidUre+B7wXS5YdnsGuG3y8E23bJX5Q+BJdRuppq5g9T1oOXuZ095+2vHLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487050;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient;
	bh=7fPwpHZdaKLM+cMIv4LZwyyUgYl642IcMfN3iFx5WTo=;
	b=PKEXsrmw3B4l3D+ytWP0JXXIpjC8hxQYzMgnxExmwX/4wEBhwVOELuXtmUV87WgJBSOx
	 kohH8pthaYJRR16Oge662t+2VgcWhjqhDQNcoEy+uRwG0LprfyDnotswti+t1N0LI2CM1
	 T2m2j0z4tIlYtw9xCs2K96z/DGpLKWNZCbF72rmMxd0I1G/6E2fFFhmdS5LeyVLkjBoM7
	 3MlVXMi088bYx4gZ8tdHgpPCNY3zLJe3jFEdHXCuZlLHBj9wTDIi/s6JeXaYKTlsYTLy0
	 xjjvb9dN3GSxeHWHb1U3Gxu4lrh310+vltwfruWR4Q8sD7eBdb81o06bwyDfx7TMHAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Ygns+KRG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C467606A31B;
	Tue, 20 Oct 2026 09:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C467606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Ygns+KRG
ARC-Seal: i=1; a=rsa-sha256; t=1792487043; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vd+iqqYgcnztG2eiQgRJHxPpTzZqpsiiyYb6EYyrKOZwR8D2Wvrx/ouWOwnV57tg2ybLROmQeIUtQnMwVxScuaW5qYF9wqqiwSGRQxaPpOdbg5B5F9pAD9On84tcvFg8ZEoArq4gSKMokBghMwGMGchDiOVlnUBPaj3P3oGgyhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792487043; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7fPwpHZdaKLM+cMIv4LZwyyUgYl642IcMfN3iFx5WTo=; 
	b=OwYflvt+/uvzJV/lB6Vd7WNq7epnqU/wDo4Da+i/FVtq7Hlr1GwxGZeebFWxkVWbBllzrihjr/Wj1EZrIoDbJ06vb0IziXZi8ZSb1AsSbxciS1ISbh8Yym9Rjf7VQ/+WzpALYR8sJCZLlQBrqrw6mK8hxXyfwQMMg0rANzsSc94=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792487042;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=7fPwpHZdaKLM+cMIv4LZwyyUgYl642IcMfN3iFx5WTo=;
	b=Ygns+KRGad2+ixoJMBgdu2H/GwBo3bBEgCb0NW6mHNKWd5VK5PplEXDkhTMbERzf
	CUrqlQCNyE7GCMpoFXpAITBh7nJC8K2Xfv1mM/rOZfHnftrv6DNHG9PG0ZAB3PS1AtS
	zRcr9vEYwfNClpd3GwSbm1ElBO7hp0kRABGcLPW4=
Received: by smtp.zohomail.com with SMTPS id 1792487040338487.1605834647628;
	Tue, 20 Oct 2026 02:04:00 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cxl/mbox: Return success for CXL_MBOX_CMD_RC_BACKGROUND
Date: Tue, 20 Oct 2026 17:03:52 +0800
Message-ID: <20261020090352.939795-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
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
Feedback-ID: zu08011227fdfea7f0d3ae05f633b0e33600003d7850d29c2723e9caaa549eaddca363334bda772185edfd3d:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

In CXL subsystem, each mbox command hw return code is mapped to a
corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
mapped to -ENXIO.

However, a BACKGROUND hw return code indicates that the command has been
accepted by the device and continues execution asynchronously. It does
not indicate a command failure.

Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
callers do not treat a successfully started background operation as an
error.

Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..cc71d7a84cdc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -160,7 +160,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  */
 #define CMD_CMD_RC_TABLE							\
 	C(SUCCESS, 0, NULL),							\
-	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
+	C(BACKGROUND, 0, "background cmd started successfully"),		\
 	C(INPUT, -ENXIO, "cmd input was invalid"),				\
 	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
 	C(INTERNAL, -ENXIO, "internal device error"),				\
-- 
2.43.0

