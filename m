Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378B1F80A1
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018976; cv=none; b=G7sCqrFIBUtTTCRRN8UmX9Sh/11+8PnLDHdkkIpey7shWXGdZ3coksVpCG2ZwIYoChoLtO6y6en0QHTCLWFmQcygFPyExaJC0r9++rsNYNsE/x7TnpX0Z+v1VAupN7LmbqYgeNPCtIFTQDa80tfQZRP7Gpk/Jc38JCvznfp//SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018976; c=relaxed/simple;
	bh=QaypORjW3EMHTAblyCa6/SD2Ip2+R1gvNvsS0NpaF0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvteuhFXGVm2Kge23M8Wl5+UjQKrRlmGBE1EPPtaotWyrzQ3OYzU2k1ylGUaHPTA10s7ALaBcs4fuuMmX2XRUSpmYQZNwokuk7J6XcGWnwcfaiuocaUH3Y4oX9McHZwQfifXSXV4kfJtcXZM9kj8oYedr9284TyYdWgOvNa28OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez4eHBC+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez4eHBC+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e5a62031aso2015590b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729018974; x=1729623774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRhqJ20pk83iDSj5hmw7CzhffO/7S9pA+eX7u2uLFo4=;
        b=Ez4eHBC+c0w4L2ImptCMi0pIH16XOgeGKbKfOWF6zOk4l8E24o3wY63juWvZXxxnII
         cKO71nJlo8G6IIyTL1IuhNwTz06rpqtygU5hx2geaLh/x1cjjFOZpzBU2RG2ZuxKM/Bl
         FyYQgl+JAFbKE3haGemoUu7DYmAotZYqkAfISnpMM95pHzfo/WAHKGGBAfXWWUQco8P4
         3GR6kgnZA02vyKZJiGcigqGmXxTX6zCOa37lHhaCdD7ZxwJFnU24AVoIMWcGL7Q2rey4
         Z/uTXylXB8EY3LtoFKKN6bmn+OsIS46RyhsILCHIrxbVJvWyKa5+ZqY87OT68ZMbpXdT
         fZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018974; x=1729623774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRhqJ20pk83iDSj5hmw7CzhffO/7S9pA+eX7u2uLFo4=;
        b=Eq1eVNl3vKU5eZHIv+4ttSIlzu9bofeMmVVNX2kaRlTDpO0qRxj6k2nYcsHSt+mBpb
         NVDoybGn0zNggx0AZ4JtOw4bT2i/7dlBsbgTctE8IAUebXxSEBlt4onb+U0gh4pg0U8e
         1+4mCJmvMDBvPUh96NAuzrvBqU3+unR/3NKmw836hWAcagZz1jWEzGEDrnDOYwlp8vDq
         Az5O54x3CAqEUpL4WKRKpiYB4kp+cp3hKJWxl0gSqzw+rLifNXc60mZvKrJkPLdxIDeg
         mF93A9BmLnwk9FfihI+JatYdB1iKdVaTlWD1Za6jcMrB78VB0eHFI4CzUbPFrX/JGvi9
         MINg==
X-Forwarded-Encrypted: i=1; AJvYcCWcRe1v09VDTkYlIFHhtltNf2CakoYrpMy/59KYrtWyKONcrKLKqKl7KTG2/eO7AUGXS+ekhp2NQOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXMyMHQ93cbED84ZskTn5ONFzqIQmpB5cT8gCCJj2jmS/bxHU
	R0HKcFP5lFdRL2mvG4uqVTy2QcpIMGnmpT5+i60wusPCLI1nZO4y
X-Google-Smtp-Source: AGHT+IGc5YPaHVYzT8+gN6wEAfeb43XjrNCWb44uNxhvH+Z50BWjZbe0gjt5jCjBlP8uQMLOcGpfLw==
X-Received: by 2002:a05:6a00:2e97:b0:71e:cc7:c507 with SMTP id d2e1a72fcca58-71e4c1cf183mr22748548b3a.23.1729018974328;
        Tue, 15 Oct 2024 12:02:54 -0700 (PDT)
Received: from fan.. ([2601:646:8f03:9fee:b98e:93ee:91b1:1c18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d3fe9sm1707165a12.51.2024.10.15.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:02:54 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH] hw/cxl/cxl-mailbox-util: Fix output buffer index update when retrieving DC extents
Date: Tue, 15 Oct 2024 11:51:26 -0700
Message-ID: <20241015190224.251293-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

In the function of retrieving DC extents (cmd_dcd_get_dyn_cap_ext_list),
the output buffer index was not correctly updated while iterating the
extent list on the device, leaving the extents returned incorrect except for
the first one.

Fixes: 1c9221f19e ("hw/mem/cxl_type3: Add DC extent list representative ...")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c82ad50ac8..58f8930272 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2233,6 +2233,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
             stw_le_p(&out_rec->shared_seq, ent->shared_seq);
 
             record_done++;
+            out_rec++;
             if (record_done == record_count) {
                 break;
             }
-- 
2.43.0

