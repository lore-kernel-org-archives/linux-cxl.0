Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303371A680F
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947760; cv=none; b=tiw/oiYOgffpQjKkT91FaefuH51VgRo53mU/trXNV7pOol/BiOtyWi812EFt+pGB3OS5v77G6jFbm3Z9g+zkZFqYqXDneOFREKAyFuNq/jiE2loHv22FaxwvgCJRKxVX7kUVvFiA4sLjaL5Kmc5HYXT3O2tFlgRQpT06VUTMZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947760; c=relaxed/simple;
	bh=Tfg8TRrUlw4UV777h2Cn1rO5BYdV9Y2tlVqakO/yCbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUiEWwLVUK1ej1u8x2YBplkRBkiRcEOElNpdMt4zT+NGLdulck5Yo+dZWMxxQaVtsvMGjCYMRmjTMP0HTjxDVvBIpN1c24zInTjzqH6HH4mVicx6H6ihv4BL0hwph6RI/6tae8RsbX7aZi+b+mtBZw749c8qeacvz35jBBFkuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/6Kzltt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/6Kzltt"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso6289281b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947758; x=1780552558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2PUBTnl7NO+GZMfRvUslTvPkHKEc8GZDQXDvKmhtZI=;
        b=a/6KzlttqmSLvcQg454KNGFVCrloRub4pukw45NbNTUqi5Ft/b8l/vJrkkJ22UlxHd
         Zh04YiIPZqrChnOddA/Ej9lvMsLoALhO6lzxf6qXEgxeFxnAiN+99Z3hu1D0RU2Aj+N1
         UlQy9AwrZ4Ns/P5ore3IQsmORfUcBkJ5EKNICqgw0MUeQpTgPZqD/+EZj38FgIhR6otU
         Ugj9m/QHlMZuVYJWZ9q7X50KB88cHyu1D+Ap03vwjBfhaTjckoSzGGykG71Ua0ovwWIO
         /IIHAYZG7IZdFowRtnFekCKI1LA5OTxb0SWL7klM6QSUW9PHUuNyOxbsa0/dVgVFPOVp
         KVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947758; x=1780552558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2PUBTnl7NO+GZMfRvUslTvPkHKEc8GZDQXDvKmhtZI=;
        b=MZuwpyvahLteyqq++nKE3/hNHY4nhFC3cjFruGgVZseRUJ7cYSsWBIJ8GWDK9mrViX
         GWE3Tfmp0ucMgq2hew0gbtYn234V6BTvxP6JUXS+seLDLHNEoNe+vbwD1yufyAGZsYZ2
         VuXsc93VvUoRdMnpqiG768jUwuY4S9zmhloMV/uqE5EN79JICE4pZNEJZutnEIteHXdL
         OO8RDHhnTgdEhHzyWGjCi6SNi9+FYo4CUFnCIQs3JXmf8hD4eYfj92yfwico8dC6MSlA
         1qbtJv5APGTcnozonpO0Zrw+CxXnfPrvEDtFVyhgj4qsoTP4lWH5zEvAG8ORwkE2bopH
         SG1A==
X-Forwarded-Encrypted: i=1; AFNElJ9YGtjn3KjCSSDE4XknT4N5rNIilhNjEU3+gwYv0DV8EOZX2dCrTmXhnuo7Iw2ycGlg4KWlGVWuWEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOu6Ev801+VaEZtHAbs2ue52JrPGH0siOIeNanB6o9iN+yoKt
	w5iZj6or/+VUzpmIHo9bqxUwd+EOaeOQj1Lz6/xAdkoo0iyH+7BiZ4X3
X-Gm-Gg: Acq92OGhT0DTO6jvVqHyj+XYymNj1M0TJCf6sjBG99IaS/F+Ok5tvxYl5ST+d16hqmO
	96xe8n/5BZ9R/txFpzmIgaLNmAPEJAf0UUlDUSTqr1PNwDqn0NRHNxodlDaP5UoES4qVvp7gf3g
	EzZRORHHrmk4PYG7a1DEU0NSFmTJJwGLf2oVEHNN51/ESnq5HZxXhREgE2FxeGZ1VdgimAXNKyO
	X1xg/BV1xh9Byxz/eQmXaeATptwU4YSigYHKyt6WKH94IAY26YzcJGqB8paFBqwr/T6eXaE+vwz
	VYOxsO6Vbo24Vdvn23LtefNXZoSyWdZ3ObC3juM4svM0fjWng16yNOqcuHNedkzwi4V88JIR0a3
	LBN4+g6dHjv0NwleyVmyEcOuJo1TISmgnRhIby8/MUCz8W0YjPJg8pNAxBKAMyf2LuCKP/26E71
	dE/nE0J7DzGR2VvPiKOesksnec5b/Yux5ns6E=
X-Received: by 2002:a05:6a00:9283:b0:827:33cb:c7a3 with SMTP id d2e1a72fcca58-841fda94381mr209905b3a.10.1779947758395;
        Wed, 27 May 2026 22:55:58 -0700 (PDT)
Received: from gmail.com ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:58 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/2] hw/cxl: factor Set Feature write bounds helper
Date: Thu, 28 May 2026 13:55:24 +0800
Message-Id: <a8f1eedc2173fd98e244048a2eccf00e1af460c1.1779946245.git.physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779946245.git.physicalmtea@gmail.com>
References: <20260429152750.2409174-1-physicalmtea@gmail.com> <cover.1779946245.git.physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c1c4d6b38b13 added the same offset + length validation twice in
cmd_features_set_feature(), once for patrol scrub and once for ECS.

Factor that logic into a small helper so later patches can reuse the
same check for the other Set Feature write-attribute branches.

No functional change intended.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 40 ++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..2e4cc5824d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1702,6 +1702,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_set_feature_copy(void *write_attrs,
+                                       size_t write_attrs_size,
+                                       uint16_t offset,
+                                       const void *payload,
+                                       uint16_t bytes_to_copy)
+{
+    if ((uint32_t)offset + bytes_to_copy > write_attrs_size) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    memcpy((uint8_t *)write_attrs + offset, payload, bytes_to_copy);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
 static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            uint8_t *payload_in,
@@ -1713,6 +1728,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
+    CXLRetCode ret;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
     uint16_t count;
@@ -1760,13 +1776,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->patrol_scrub_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        ret = cxl_set_feature_copy(&ct3d->patrol_scrub_wr_attrs,
+                                   sizeof(ct3d->patrol_scrub_wr_attrs),
+                                   hdr->offset, ps_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
         }
-        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
-               ps_write_attrs,
-               bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1787,13 +1803,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->ecs_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        ret = cxl_set_feature_copy(&ct3d->ecs_wr_attrs,
+                                   sizeof(ct3d->ecs_wr_attrs),
+                                   hdr->offset, ecs_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
         }
-        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
-               ecs_write_attrs,
-               bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
-- 
2.34.1

