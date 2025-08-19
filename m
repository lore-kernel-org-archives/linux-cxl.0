Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310053115BD;
	Tue, 19 Aug 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592892; cv=none; b=dy5UyXbnEvBtxN10+ifBwk6ZCbDWt7dPAhZeODHS99UVPXOGCJi2g4GbjGm7m+j3OoDDENz4BJEagy5E95dO2Esseg8ugtEZWfr9x26XDO70m77mTgSAESqBNbP5LnjBamsCwU6gbWIQ15vhIc1vjwgiXlLD+qzN60yAQcmibV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592892; c=relaxed/simple;
	bh=hC3FF7CqXvYfG8tLDMZoTpgFfJ5oSyKKqMIelDWPp+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdAaNvPki/WNROIYmOSFLg2Wl5ZEhA2dl89zGRfjeMZM9ozyEHTqQi0Z2thuRsyDRwYegm8jIfOy8l4DSkZITgzN1EhxJ3vThNW9DZd5BTp8jrpGVCZEW//8VkZAN+P01/blf6sCYlo6JLNfZkG1lrNv0rbKPhIHtFhxfWRdRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVU7q3Mw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVU7q3Mw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so25430955e9.1;
        Tue, 19 Aug 2025 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755592889; x=1756197689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLUOi1Tq4O+Xr4PhuCC16k6tnogmko89GEp/A0Hn1CQ=;
        b=XVU7q3MwTNACpM7lAONPAbzhw5gznjFXHknyuIB7hKtwE9PePKB68XGYWu2X0qyTm4
         5CmQORvpwDZkojEPb6OejUIZuS6PLWsURGo1h2WE9qJQEjOE4PYYFSl8W3BAWyZWSra4
         NEN/a7Bm6wNNEl6acpp3YpxXYwKU6zSXUtlXzE552x/TL7nDvPBcDfOFdzM9/+rqKRhq
         n0YPHYE1gvuAFc88peRuyqd0/4cU5CxvtbAa67Iaqf8q1maS7+WgO9qz0CV+XS6uFRDS
         sGIxs+tbnprB8Vv/jQpsXU+jF7QEKNlEpUurbeKqlF+SgD0sULRj9yQNXXQiPbghn/SW
         pxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592889; x=1756197689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLUOi1Tq4O+Xr4PhuCC16k6tnogmko89GEp/A0Hn1CQ=;
        b=k+20FM/k3Wy4va2zcZoI9diLnkYdBbhnrQjWe7RX1vBwW4CcHfK+lxLhiqEWUVIiSz
         X7G2Xhe/AzW5E7ujhrJYxE1RofNu98MSyIXT8uXSc9rRC8eURDtnVSITkl7O+aJDPKkx
         t/cPBUvwtAenLvzJkMl6g8kcD98kIWGzHxXRoO2j7zuD+5tvf7mdQ5Jo+4Bc9LvtP4EW
         qPr+wWFgZS2YJdwMDKV/grI/6hXdSROH0gPSy8pCywUDRXRBBg8C6OLvWVTzshh9elfz
         RjxpWHtAKkFumm460STwVApungDa37myCIjAWgep0KFKVtCycatrWECTs9ZEn3+wryKV
         yB/A==
X-Forwarded-Encrypted: i=1; AJvYcCVVMjaaiVuzhksFdavm6K7efayBTSrNb+W+p/wVXbseOCFdWln/n6H/Kicwx894BnLIcOW0WiIGKxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1L8WOJhUvkW111dvio2LfyJT3LYoYE9tEi/Dd7dwACoJ7wnvb
	YVmlmh6bYcP7XsRCxFDn0odOl60RQRk8IvecXGiFKuNM5vpDJF3Fi4XgSuZkoFe6Lzg=
X-Gm-Gg: ASbGnctvBqYmfuWWzu45G/YkK87qYuQroHJlGQKRltBZ/kkoBXlJT5nuuiBj4O+LPYD
	DqrjlNrykwxXfWeJjnjOvycnoTSdwA32FHiXAhSjyHWrFVQBeakGNkWthxkEF5o9L9SzfH512hY
	NBwnNDmkr8PgfJSavgSpD4N5ckLh4T4V8xAHDf1rXHRJ3Okjj0SypCr90B4GjvvfYSE6g6UDsOm
	d/T+/77BbKQ/mxQKMMlTeHZrbgN1pPqhnQEljxB2hvwRrQVxkbwlrl1SA+TKkJsUVjtcyQVy7Ts
	HT1Qb089AN8bjDQ4ABtf5QEKQ5VkB5DSjDR07msvzFAONCLfsiewvc9ubu5fGicxqYAtjKKTz9R
	wthxVe7C+bYIbVvjHgVyQKA0myu99vY0=
X-Google-Smtp-Source: AGHT+IHpZR4chIo9Jhe+nlOC9eKX5wgesPXTSJhgCyQ/YeZ6CrLEnmtm986TctbTOdpsG7HXLXCAnA==
X-Received: by 2002:a05:600c:5249:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-45b43d464e9mr15595945e9.0.1755592888840;
        Tue, 19 Aug 2025 01:41:28 -0700 (PDT)
Received: from moktar-desktop.. ([102.31.181.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879859sm2746131f8f.3.2025.08.19.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:41:28 -0700 (PDT)
From: Moktar SELLAMI <smokthar925@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Gregory Price <gourry@gourry.net>,
	Moktar SELLAMI <smokthar925@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org
Subject: [PATCH] Documentation/driver-api: Fix typo error in cxl
Date: Tue, 19 Aug 2025 09:41:16 +0100
Message-Id: <20250819084116.13108-1-smokthar925@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed Typo in the driver-api/cxl/devices/devices.rst

functionalty -> functionality

Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
---
 Documentation/driver-api/cxl/devices/device-types.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index 923f5d89bc04..7f69dfa4509b 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
 Typically used for initialization, configuration, and I/O access for anything
 other than memory (CXL.mem) or cache (CXL.cache) operations.
 
-The Linux CXL driver exposes access to .io functionalty via the various sysfs
+The Linux CXL driver exposes access to .io functionality via the various sysfs
 interfaces and /dev/cxl/ devices (which exposes direct access to device
 mailboxes).
 
-- 
2.34.1

