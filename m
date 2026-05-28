Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4D1A680F
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947763; cv=none; b=Qyh2wwwW+uriW8ZPoegPOnbZ81tnJEivgS8pwLv01XWBm48Jg/AdYOXWYHoj1jwh210PjoIMrG3eSfnvOpvQtSOHfhgHJ+sifEK8Fv7AKYSD8ayoSC31dxJjmmND8XlFcVPQEJr1pObI6hLjFmZujopktgrFtT0boNqNxXHyoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947763; c=relaxed/simple;
	bh=ViRKEBspjkjXYV6M1/n4Y1WO4pddP6NWr83RlTnyy8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qau63ytAoZtq0SR4jq7Zd2sKWp/i8Tq54ufG+ebYB20S4RXHvKvrfgk/t9MvrREtOmk7IN8Z3BY7P8apjX2jGTkLL0P3IxmBhDGhNaVS/LvdQ29y37TvH+R37+QyvybQA+IlZ7ZDFkIRbrfplynJnxuMZVp+BWrwNRAuas6d+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV20QWEV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV20QWEV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c855599a77aso709320a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 22:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947761; x=1780552561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOnEl6g9CzHOp9himAORSol4KLevjnd3PpxGJzoKEiQ=;
        b=JV20QWEVG2BlnDUxYMH6Gqdr+joGz5f+YBq4GZxB02uQbw/kUVWSSUH8MKtTYCfz5g
         ML/exxPXdySd9BVhu7/dJ6Fz5h61bNrYRgH/f7noer4kOnC6yb0h8ZB9xLKlNDno4zSg
         I31XN15cRZvYPAKmPy5RQalF5YuCSZqGkxKSZKR1jbbaSeEaI4Z8pifKqHRgouYC6Om5
         LaDwceU43dPiIW732uHMp7hicoZrcBWTKdLENNmPluSqLUQphJJcFhVP9cYtJ7C6E3p7
         epiJpw7N1UYNZQcD7AX8pzZtimYxu4P8EpgwJfcuH9R4TCvZZ9cGHUvchZbBbE8GgBdm
         32OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947761; x=1780552561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOnEl6g9CzHOp9himAORSol4KLevjnd3PpxGJzoKEiQ=;
        b=h1VSwuWkocYHjJlruJF3T1aOEfTru0UmB9DehiBXYnkpM6o2YzyQWz48ym9kdfAhTV
         D0AmhkU1z8xE+H7C1QCT/roMoxjapeVQAuEQmu1+d4rVotrGTgDFitUF/llf6yu+BNgN
         80FN1CrODxgXSLHJ/UCFArS3XrJ0K9fHK9RQy4rUzQjgOYXxA/FgJKopjo6OankeeDWm
         Eyr6m7IoOXJ1oQb3VeUjnTCtsYh1PNj9MUPrj3K7F/liycqVibky2o/v3THjuFBLVkB9
         ppWDjr6lxe5Pxlj8yyIThDuqtYepsrDyNQEkICK2K+g5i9gDxUcSJ+S7+GYq/2K14/ws
         aprg==
X-Forwarded-Encrypted: i=1; AFNElJ9bo5O+F6ncCk4aXVi2v4fOOTK9BL0X7AiP+lJIVDDFa2Y6dhw5131nTzR9ytGPyf2hfky5McDJMIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmTgwhPd7w3dkFp7rRTxnFLIkmb40uMcxl619VNhOkcr3n+qv
	1FpdHZ6M5rBV9Z4QfOuFvQpbaM8WnOvMOz2Jja0DznmwDt5e3QaPHa2y
X-Gm-Gg: Acq92OH8tp7nwMq9B5Suk1SsLwu+vq2NqMc2vaXv4tiY6tAlGwiUSz+atE2c64jVv86
	9iGKOVvAccQrsoCmynOnAka/nAYtpvn5Z5lqNWAWQ1hMSvK4N9IhJeVsNJQOREKwto9bE2hPaxG
	VZ2dchNIGZz4l6IDPJ/bye5MraRofkTl8B7U6I1AiTb+Kqz6ZtBC+XgvgjrbqECsCyFvaHdMadU
	mB+tGE/wpVBSTdozkkIkdDPfNHNXOiWgX+OQqDOWKIe7ftEML6AbYBRgHM6V+xQxNzeSSp2c1J/
	6CresJ8ddply2Za4r/OPNItE+1KUjwcg0l0QNz5VaYE99PQikf7QT22EntZm8sd9G3iBSpsq5ie
	TzLGpreTvESHbvVgZia5FThsDcsqLPESJldKiY0WE8A06oCMVA84QbK+iW2qTFVvG5ppX97N319
	97olywyt5F3y9cTYJcgYooNRpETe3QxgicJiSOLfor7bH9OQ==
X-Received: by 2002:a05:6a21:7008:b0:398:b178:a53f with SMTP id adf61e73a8af0-3b328ec4d08mr26857031637.40.1779947761546;
        Wed, 27 May 2026 22:56:01 -0700 (PDT)
Received: from gmail.com ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:56:01 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 2/2] hw/cxl: validate PPR and sparing Set Feature writes
Date: Thu, 28 May 2026 13:55:25 +0800
Message-Id: <61025cb5676b04afcfd7c4cc16904c95564c7a48.1779946245.git.physicalmtea@gmail.com>
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

The Post Package Repair and memory sparing Set Feature branches still
copy mailbox payload data into fixed-size write-attribute objects
without checking that hdr->offset + bytes_to_copy stays within the
target buffer.

patrol scrub and ECS already reject oversized writes, but the later PPR
and sparing feature additions missed the same validation. A full
mailbox payload can therefore overrun the target write-attribute object,
for example in the rank sparing branch.

Use cxl_set_feature_copy() there as well and return
CXL_MBOX_INVALID_PAYLOAD_LENGTH for oversized requests.

Fixes: 5e5a86bab83 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4dd ("hw/cxl: Add emulation for memory sparing control feature")
Link: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2e4cc5824d..4c7a083e4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1829,8 +1829,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
-               sppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->soft_ppr_wr_attrs,
+                                   sizeof(ct3d->soft_ppr_wr_attrs),
+                                   hdr->offset, sppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1848,8 +1853,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
-               hppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->hard_ppr_wr_attrs,
+                                   sizeof(ct3d->hard_ppr_wr_attrs),
+                                   hdr->offset, hppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1867,8 +1877,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->cacheline_sparing_wr_attrs,
+                                   sizeof(ct3d->cacheline_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1885,8 +1900,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->row_sparing_wr_attrs,
+                                   sizeof(ct3d->row_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1903,8 +1923,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->bank_sparing_wr_attrs,
+                                   sizeof(ct3d->bank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1921,8 +1946,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->rank_sparing_wr_attrs,
+                                   sizeof(ct3d->rank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
-- 
2.34.1

