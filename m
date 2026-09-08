Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304583DDAE0
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862951; cv=none; b=EZURJ2R9ytRRgdQJh+NJVeN2YCK85Chf9lpu8r2emyKeNdMshg3iIhPBaIn/Q1F7eqeKlYzskw9QJTLObiTFu6aunC/Lrc+VU7TzJB2PKJ0Up08+Xp4idovhmQ5xX53Yo0WcocFk5yfMQYBwmiv60iV5jKS9OmEMl/WxTTYS1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862951; c=relaxed/simple;
	bh=WcAS236eE92Xpc8lwdqt13gvVOWuT6IHqQ+OZcIQWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD8AoEeLQJz2cnMZWlD81XCOV2QS2DFumpNV3E8b98YU7Nsdg9UOajFhY1yHruxqiU3rZsnIM8gX8ypUGjfx0fiAnmCxOfWj7X/vW6gHn6fsnVPhZ96PgHLl1CerLtoLgpvtg6stVP8wx0J8A8X0dc+qiqZvkVLAhNnVLaT/ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hngBRjmP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hngBRjmP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3540940a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862949; x=1789467749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oICIOfyWUzjcGGZ54RP08iRPf6nsMfmqyTZYAfDbx+o=;
        b=hngBRjmP7FqsSruK8EWNbq5HVWw1jeg1Hm8zDQ2VDoPxUY+xJSpEf0BUOE8GEItMIl
         ISfDUprQfbJCh8zGVaWGNT66W+R9+lmXUUYdkM9xC244ZBNxWR5rGkqA/9JRfzeDJWoo
         bHBsvmL7OAPLwL4udxyN0KY8AkTGMj2ofYWKkYkBZS8GTyVJOvKGE5pHSjOpdwmrI+Wb
         zaAeb/guYWZ93ZnMIFgMoQs4/+huarXUGtT5qzbVMtA066+Z9S6d1Q33Tdhg1gl63crj
         qd5ZBXzqbO09ZoExf1/P2uvjuUn9yHqeIOaOpaITFECUaoCM7aIKKWJGrcUVhkviJl39
         MmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862949; x=1789467749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oICIOfyWUzjcGGZ54RP08iRPf6nsMfmqyTZYAfDbx+o=;
        b=HiQjzV4JaPpkt2nHza0gKGi1udCKHo3pYU8W0yKq8z1/x+ZZl0xsNMSCbY+3nCzwSY
         z0SpSROLpwNPOVetl188u4UcvADQ2GqhtjqftUGkQ2fQZ1uW991OB50cpr6UxULWIeL1
         CN1D4AvOm2ubZ4awhfOX0YhN9ll1/Wnbi/DoRTH4D1YYUZoBRQdX5NEoo7cQMoSY/EMG
         J0xgglCqsb8qjEV5aDun12E3W6WZ+MH3MyEZELPQ8+ynfZeAz6D2iYD926uUJOD/DalZ
         xZHX7mh4oYfm/yH/Sj7Ho/7PJMSvdmA6icCiZ8/WCKW9e0mugX7Si/+Qw5IcZNfcIdRg
         jlEg==
X-Gm-Message-State: AFuF++lKS1bNDEGlw8tLi6n7mwANyDFm6meeQvwf0cEUZiDBzvKHS162
	l/i90I5BTCMHYTsq5Q5DFCNY/UWy6a4PqQ4miiRBAqXzFMiy70cs+iyapJykqw==
X-Gm-Gg: AYBFou2klIvYcSXji720hO6nIkxB2dXIBFLs9C+5Esx78jQ5QQ0KQtUCKQ9fN6cI8tj
	4/fNR/7K5nziK61bI2fTE60m4IJsEGCTFiZPoJECHryr/Kt90SdCBAgcwaG7T4xlA45qNljTsBX
	qd6MNCD7Ts4HiK5wQx2ubBZKf9W/sxRooXDQ5yoF7a8ayb0CXNbGOJBo9Y2itwaiqniZWaeNlzD
	fUUuVBkJCZaI4q2eWgUEGQ72ON6JEkTZVAJXrOkLEw/MuYhSDQM+HFTOBauVUOXTUxwpbYp4X4S
	FkzJSZpCiVKx1/F3yAVFuwosajEmYFlt510NYZnUTMn+VYPHAoDvU2K+YTZwaaXyqKSXRY+Zyba
	dLIWkM2XFjgzLdzc8ZXnPYEreqjHGLyNTK1vYnDmU2IUCsvIITavxd8BpbF/9y7pTLOx3DcsXnd
	UPp0lHJtdOkKqdc0iScNAB4iO8AMPq3kxyTBa4vb9c33Ot1vyH+R3XRu3xNLTwv3cqhcsM6jqg+
	65BzT1JI5pNigxBAnQ05snThfnGTGU4Zib4xxj5Lksh2HI5W6MvRvZLuFTzYz6XtYtzgb6jLWrO
X-Received: by 2002:a17:90b:3a81:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39b2612eaa4mr39545215a91.10.1788862948470;
        Tue, 08 Sep 2026 03:22:28 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:27 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Anisa Su <anisa.su@samsung.com>
Subject: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition layout and ordering rules
Date: Tue,  8 Sep 2026 03:15:12 -0700
Message-ID: <20260908102124.2231730-10-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DC Partitions complicate DPA ordering. Add a DPA Partitions section to
cxl-driver.rst describing spec-mandated and Linux requirements for the
layout.

Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
New patch in v13.
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..f0742d6c86c3 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -181,6 +181,44 @@ A Memory Device is a discrete base object that is not a port.  While the
 physical device it belongs to may also host an `endpoint`, the relationship
 between an `endpoint` and a `memdev` is not captured in sysfs.
 
+DPA Partitions
+~~~~~~~~~~~~~~
+A memory device presents its capacity as one flat `Device Physical Address`
+(DPA) space divided into `partitions`, which Linux lays out in a fixed
+order::
+
+  DPA 0                                                     end
+  +---------------+---------------+---------------------------+
+  |      ram      |     pmem      |       dynamic_ram_1       |
+  +---------------+---------------+---------------------------+
+  part[0]         part[1]         part[2]
+
+Part of that order is required by the CXL specification and part of it is a
+Linux choice.
+
+The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
+Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
+at DPA 0 and pmem starts at the DPA immediately following it.
+
+Dynamic Capacity partitions only need to be 256MB aligned according to
+CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
+(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
+(static) capacity and its first DC partition, or between one DC partition
+and the next.
+
+Linux follows the static precedent anyway for the partition it maps: the
+first DC partition must begin at the DPA immediately following static
+capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
+a device with no static capacity at all.
+
+Currently, only one dynamic partition is supported. A device may report up
+to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
+`dynamic_ram_1`.
+
+Support for additional dynamic partitions may be added if devices appear
+that need it, which is what the `dynamic_ram_1` name leaves room for.  Until
+then a device offering more than one is still usable, just not in full.
+
 Port Relationships
 ~~~~~~~~~~~~~~~~~~
 In our example described above, there are four host bridges attached to the
-- 
2.43.0

