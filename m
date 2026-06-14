Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913302848BA
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464201; cv=none; b=mide+Ac1QqpF+3AkJfJ8Awzz7HfPVTsTHrH5yWAA6DJzWPnnLlgkr/TuVFMtXLEE788pHRKAlMfsXnKHVeria+0+6ExNLnGlGsdKrLZdsFK+siPxmrlzoLAAhgYw5IUrXkY6spBHFfAj2rBRXNu/VIvuRpHfQPbzKJW27MVpGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464201; c=relaxed/simple;
	bh=MhzSpVeNsoo6KnR+ie4XyjwJ+Rdybs4XshPKfSZQHl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q0BF2nqc7HGHs1QVX5u15SoVMqOtt10EnQzGKWp40sRsHfBnAvYakj0wzzaVtrgDcG+Qc55I03+cqZ80B4RNVDQecUUzUpRAwmch9vrn4uSyQ6DNZbc244I1hyO6k7XHYgtX9GgSwg8p9ok+3fP8YCiJfCejawD99mDBoRtAnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGelc79e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGelc79e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781464198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYAcvS/4tP50eAPxRPeklkaj31Ip6dr75MhaJLz1/xQ=;
	b=aGelc79ek2pVlSXsVDpB0d+KyeJH+GSpRBWDE7pLJZvEs00FUX32oTmizs2BgtvAEWFAll
	ljZTts1lkkXB3TrFOPZB+ybiK1v0tcrMEz+s3nj+ODSxC7vc4MBUvNFi9Yf7vtdDsKsMZL
	ckc5iIVrlxVvcfCTyARfu+8MdeYlsak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-647ZqTfeOIGFjPoLsuYnXw-1; Sun, 14 Jun 2026 15:09:57 -0400
X-MC-Unique: 647ZqTfeOIGFjPoLsuYnXw-1
X-Mimecast-MFC-AGG-ID: 647ZqTfeOIGFjPoLsuYnXw_1781464196
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso19280495e9.1
        for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464196; x=1782068996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYAcvS/4tP50eAPxRPeklkaj31Ip6dr75MhaJLz1/xQ=;
        b=LFPsBpbE26kIHhaBOua09G5vHL+mUfWMysdLnXREMDgbS1CRgxwrekfNOi7e7qJ23y
         1ubZEUddxAECzGe7uacyDLN7S2jthQCQLUP9UJ8rbxf0SxkXFF2gWsC4JDLWBr2EAJQk
         7JZoSHeC5wuBrlFClDEJ/4ufsfY3FF+lNEZBa8JzCzXij5j5xzuT+1KXguSR/99cPXAS
         6nN8kDdL5wszDDozuqMpEZBS2Lt3V9bfCpBjAzJI+0bcs0/0MuUk/3xqvNAmMtNflgc0
         UBYqlbxM3TSUmkeWcvRk4fFNKmgLClqg1jquKqlezjlyPmpHaVwMeSLmJRTK6QSaaD1H
         A6dA==
X-Forwarded-Encrypted: i=1; AFNElJ/oNFU/RcW60P9ooXVaZgBrMy/297HFaRqL5igl1gisJ7V/YfJuZkJ0FI0He2c4C/c/ga3Nu6m5Kys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IRj8A6Dw+xkgx8RK2XgxYfuTsG2ELV1XbHEuHlOY/thmxSY4
	vgv1uBij4vX4KsGjiOxOfGS1019JXr/bg9aR+6PimqGifWRuS/cgLf29VyRBTs3JGioYDt35T1+
	3yDSYZnbAC49E0fzjZzDglIhW0vTuT/Q02bu/EULst9eEJyRQe9nnoLtiplj4+jvgzZprbQ==
X-Gm-Gg: Acq92OGyre/TEevNsinaZtdwVEqxj1paGebsznXb1PSoBG5kylDy0W5zz6JcmF1ZGOz
	zmsXxLYrPo4zhIH0B1vv0/Bd8aGPinsSLZzKR1YbTPAsSHGAZWFaBJEVcCVl8pZV8WxAItPZjkV
	IkOrP3C53hk514T7LiQO5K4qjtbZ1n6dGXun5IlIXVtMtIQQXH0jOqG6MHND9GSoMQJ09mjxloQ
	BlBAM+Y+cs9e5/fuB5EQeZFTWh5zpkaX/4i3JAL1Iyvj7UK+XwSkDAHycuTmO+QCW8gWSSflYRl
	jGDvOIwOqSNxP9n90flXw6tJPlzf1Ae+TtfGL06u/e7cef90Qkmg1oWgxWiMV9Uj2gBUS/J21PF
	YE9LHIRuKJ987L+CcpaCkp7XO6gHMC3+09+HBchY0QG8=
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-49220086792mr86942555e9.3.1781464196140;
        Sun, 14 Jun 2026 12:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-49220086792mr86942285e9.3.1781464195722;
        Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b7d2sm197662505e9.5.2026.06.14.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 101/106] hw/cxl/events: Fix handling of component ID in event
 records generation to not assume it is a string
Message-ID: <bae67e770aab251a9604ef8b81c67e6fe877baa3.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hu8KK6dX-f85Io2xjKRCm-yGy5L043G4VTM8OZAw8H4_1781464196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Shiju Jose <shiju.jose@huawei.com>

Fix handling of component ID in event records generation to not assume it
is a string. Component ID in CXL events is 16 bytes data, but event record
generation copy 15 bytes only from the qmp "component-id" field using
strncpy. Replace strncpy with memcpy and copy the entire component ID
data.

Fixes: ea9b6d647f2f("hw/cxl/events: Add injection of General Media Events")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-4-shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3cb1096e16..03a5d1751f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1895,8 +1895,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)gem.component_id, component_id,
-                sizeof(gem.component_id) - 1);
+        memcpy(gem.component_id, component_id, sizeof(gem.component_id));
         valid_flags |= CXL_GMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
@@ -2066,8 +2065,7 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)dram.component_id, component_id,
-                sizeof(dram.component_id) - 1);
+        memcpy(dram.component_id, component_id, sizeof(dram.component_id));
         valid_flags |= CXL_DRAM_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
@@ -2185,8 +2183,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
              corrected_persist_error_count);
 
     if (component_id) {
-        strncpy((char *)module.component_id, component_id,
-                sizeof(module.component_id) - 1);
+        memcpy(module.component_id, component_id, sizeof(module.component_id));
         valid_flags |= CXL_MMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
-- 
MST

