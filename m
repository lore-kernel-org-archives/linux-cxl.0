Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198350;
	b=wtA0YPRicZr/gjNE2SaLMzw9iu00EnC2tBqzoJS75B2+eGYUAbIWs/pwSPFhZWeMNS0C
	 vo9j7VMnDn5eIcSc2J08DrhMOIz52wvQVGKawQ1IQa+Jt4bx6WxZiEBnMl9dxg5dOvBX1
	 QGakkB+LQrcp70gNQ/gCYt4wUkdjRq7E8h5bgJLw1owdLhHvP+Gw2Mi1qkGUWIr8Pa94R
	 kciLfFxvTUirEqFcuvA0i350qT53aQKhTJLIRaJ8NiQzvmVlSgx/YaDwOOPkvGdj0bGGK
	 SiVFprJ9uvUb8VoSucu1E+wV5TeHh+poek2W5lrnSKXN7jr7a/2RlN2fSQ2WElkXiTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198350;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vr4MfyXdMQAA4F0lswl/DvoutdnbX+8VcxGdEwgajQI=;
	b=KKMHCGE1IXhcuNYDrhpuiKoEAqkC2slpz+gpjOoThd527Pwlprc1Ijpftat5dBgnh7gx
	 sxI0YMq9f2LZBEweVNY/omPiWxWrvhmJerNyVtGm71+1kQzyjRGCA+tPcYAXGAfakAx3b
	 kOWgW/q689FdoQQlqE7OzjB5Vh//9yBypTHuXJ9MgTioTcsqoITuheTWE8SFg2XgJZ8Py
	 IHyhGZrh0vZy49b3oJcINGro3/2agoOKVBxFf1Zn2KPfMOeVaB2T52b0tqIC7KP0mafzp
	 ZnJoyrrO/Wqq1bMoJJYiTmWFbTk2ZW63lfhpCxsxDoyjppZ+3sjwC1iCLo7W0WzQY7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BB606B213
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 18:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5DF1F00AD3;
	Fri, 20 Nov 2026 18:12:29 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH] cxl/region: Keep a decoder staged when its auto attach fails
Date: Fri, 20 Nov 2026 11:12:28 -0700
Message-ID: <20261120181228.1466310-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
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

An auto region lists each arriving endpoint decoder as a target in the
AUTO_STAGED state. Once all targets are there, cxl_region_attach_position()
attaches each one port by port. Attaching at the endpoint port sets
cxld->region and moves the decoder to AUTO. If a later port fails, the
unwind clears cxld->region again, but the decoder stays in AUTO and stays
listed as a target.

When that endpoint goes away, __cxl_decoder_detach() finds no region and
calls cxl_cancel_auto_attach(), which only removes AUTO_STAGED decoders.
The freed decoder is left in the region's target list, and the next
teardown of the region reads it:

  BUG: KASAN: slab-use-after-free in __cxl_decoder_detach+0xa6/0x3b0 [cxl_core]
   cxl_decoder_detach+0x6c/0xf0 [cxl_core]
   unregister_region+0xcb/0x470 [cxl_core]
   kill_regions+0x9f/0x100 [cxl_core]

Put the decoder back in AUTO_STAGED when the unwind leaves it with no
region.

Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..f1083976592f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1830,6 +1830,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
+
+	/*
+	 * Attaching at the endpoint port moved a staged decoder to AUTO, and
+	 * the unwind above cleared its region again. It is still listed as a
+	 * target, so keep it staged for cxl_cancel_auto_attach() to find.
+	 */
+	if (cxled->state == CXL_DECODER_STATE_AUTO && !cxled->cxld.region)
+		cxled->state = CXL_DECODER_STATE_AUTO_STAGED;
 	return rc;
 }
 

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.54.0

