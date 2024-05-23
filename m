Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162512628D
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486542; cv=none; b=diqt3zPoi/ELoOlLR2xGI+B7NWutWRmPHZ2mnetvrxQyFli5RfAAMPfSvcsIscKUK/NXr5E6NedztfXwFKWWbRC7iM0niU7/T/XPHiouRtVnV67rCW1CWjCBnb7QQmhOKN+2wLbPU/A9ouG9tacEo7DQCzbcQmlW8UKEzhC6dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486542; c=relaxed/simple;
	bh=0ytFv8VyeIAXYEof08ZsZWUwwIexgyDp+99fQoIl7ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXpdx3V/W/Hx+3Zo4n2kqlTe3cIPXwU9jZ5IffGoj56I/M2HHSguJefiliBoYIJSJGgF3tgZvpPeLMUXdjNq3l8fiEuO4S/ArNFClEvbm4kXNnKp5ZQ5o2isJnNkW9U6loxPkVq3OHRsoV09XBKGhMJXbk0MaWVcIHn4P/5VV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKd9AnsN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKd9AnsN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f333e7a669so14325415ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486540; x=1717091340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py+IWCEA+58Br6wfdzxyAKl2e4AQZdRZm/N5DBOTD9w=;
        b=MKd9AnsNWiY+ZWcWAIrR2s7tD4QLL6/+WBWX5U+HKSAGV0dzd+GhdELJ32HwBg1nIr
         P+QypzfnsOOPg4fNcaW+wXMgU06WQnQFm9KIY586/jpQWyFgOXXA6VwFvsA40NK3s54F
         Wdt2IJqv0hITH6idE8M/NZc+iYcW3j4JNVleDR1UypYM6eiFHLuSuy2LAH4W5R30k9Q+
         OlmSIZZg5sWP9gu1oQUahpqPeBmUBxl8Y4NWcGwG/HW8JI2MpAUUv/qyX/ujFAOnVzii
         qCSBLdq0rmOMUyy8jaRTklSuDzNSxqpZoleo7AHfhTNmE3+k/Nk6wFqc98NN4WhWwPXL
         IMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486540; x=1717091340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py+IWCEA+58Br6wfdzxyAKl2e4AQZdRZm/N5DBOTD9w=;
        b=v3K6/rw/ZnRx6vDVC7OJMky6QpKpkbYNVgvFmQuFkgdhLgrx9Azskx9oXPgH2D/U+S
         +a9rS/AIIaXeoOaZwzRcTxDgz7a8KuIuWb8ThtYAC6astAp68cCj+bQ9Id+vh6AeWcih
         Mor2MMrgJJc1RBNTNkbPZ7BxVpmQKJKHS8+bVdxr6fdgw+TWG9obe5qMoWjlz3wW0V/D
         SZtkiOCMadvOEVRUG27YMZZvANwkN/BElCPM2Fd0LLFQLI1yuLo8/UdJehsnFCKZuy0M
         5XQwEKHAbEexAM4T55tEWhuJDXj0U2VjAiGj73Tme8NYWseNw29WCRUL7z3WS+w63ACl
         8yVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpDC3xAx2VtiZ+ccPvadFqKm52DFNsJLFM6OP1wcy1+JBLTGv4XoFXJtVwH4sZA1jKOX3ccJz7GED4E9BYGYk8V+9HlaZGkqli
X-Gm-Message-State: AOJu0YzUwNLLPPaOgy8eIgfk4fXPd3zLGXLstzTIdW40pFjyWhYR4+Qf
	5E0f4tDoC1eVqYXMBmh+W6/ADjRdiWc1b3yiCqIbtEIdc37HS/tK
X-Google-Smtp-Source: AGHT+IGUU65s+ThjrpW2GkGrCtHEGF5MHJn9d7jgIeQXnhn8qdEYnubOYSC43+E2eDUvC9354XVJ6A==
X-Received: by 2002:a17:902:f9cb:b0:1f3:4bb7:5e16 with SMTP id d9443c01a7336-1f44873387bmr600065ad.32.1716486540365;
        Thu, 23 May 2024 10:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:49:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Svetly Todorov <svetly.todorov@memverge.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 14/14] hw/mem/cxl_type3: Allow to release extent superset in QMP interface
Date: Thu, 23 May 2024 10:44:54 -0700
Message-ID: <20240523174651.1089554-15-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 60cbaa9bb6..284db94182 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1946,7 +1946,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0

