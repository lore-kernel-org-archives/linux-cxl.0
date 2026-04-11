Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C415255F52
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871637; cv=none; b=ezOAfxndSFN9G7qVtbyHMXtlBF+88w/NP0ytAiN6fffiFQMjub1XBdaaW05vj7BourIKssnJ53PZ4NmmRO9bCYpcLMuyzStEw3DEM6PmLZcTH75+14SsuQ1ydjdzvXZNLYPqnFBzNf/jviPQ24/XkScYQjO3grGyV7X4TBqIYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871637; c=relaxed/simple;
	bh=bhkVV5eWL9q2QBEtj+qST0UkfpKTX/AYf0RWbT4RAzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPJ9UBMt6NSsm5GPRJW8oEhh1pV6MYhhozfO/oWf5sh5zvFVN9oIMRcFDD1kMSJ4e2mCpinZmgrf0Il9C9L85/vjKtvxPaTBWD1BJAGsVh5mWk344FUv3vPL5NHI1G1S2uxXi5YVwP5sJdmpKrnLIy3aJyVqT/gt8d5xPyoO3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVnNF7Ug; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVnNF7Ug"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a535e7c00so32701047b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871635; x=1776476435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WfczXqcXBpP3sctFNC30HRypl1xDvSsdjoS+nUQlBk=;
        b=dVnNF7UgiC+gy7WVAYY2FL1+2hjMb/FJ0+zC8VqMnp1IPrL516dpXeQnevh5yFWUb5
         F3bzG+otBUBt9OBXFIfT/x5ebcjnXREyA5IflUX7KLgQ8LL7B33OJQBMVH699as8Dv6Z
         Zqxe5z6wUWk4IiDLvQ8RqnYzJR3CpQYiHq+UmhsKdw1QZ3NwEUMx66zxnPbp/OOiUAwY
         DoKfkIOVvQwn/grZTKYnQAhh/hs0FKAxEfvHmyuf/95aMqqkliLEAsceYjLXXt6fw2J4
         azdLbusrL6bxuFBPzGOD+Vvlq84QCFMRoCnFPiK9grXXAhuLDEisRMP2lnEdp97NdsWe
         dlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871635; x=1776476435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WfczXqcXBpP3sctFNC30HRypl1xDvSsdjoS+nUQlBk=;
        b=U2R0mETuGXQWuOQoqObLdP/RpLRV7M/CyevoUgOQXPYearRkr4dnINwuyOT1mN/afZ
         qBEMbsSWocnC1fgePNcD69J0UgU3KgV8zZ/9oRLAOJ70s9TVRAKVvGe0Q2clvgW69C4r
         FTMHWltSG+BNJkQ6CxbK+PxBkuRj0dWObL4ApOQyqGh9+QLY60IY0m5gJaj0Ff1gsEX3
         t0Bn8sTDGLp+9K/qPmnEVG/dvIylwk5AnOXK4OnRD/RnrYItUiXw0gEXATU8Upy6HF/A
         Z0Tg715ETcJMMtK4ER2ob21eo3Huo8NRk9gRrCdNML1CgMFnoSjnz/Z4/ooJWAJjyHWq
         Vs9w==
X-Gm-Message-State: AOJu0Yx1aVFAklL0Ix2gFda6u9yyP57EzZnT1l1hWneM2j37rpZ/SZZv
	kZ8sBEfZI+9a97jbuuqz2XlcMMe4zRepSHjq08uLTgiSV66XzsvfIAB+4dQTOA==
X-Gm-Gg: AeBDieskfRdm8nElvCa8Izbs+Hux1G9RevMxcpu752ZjNg5LgRg3vRLphYSpenRsUww
	qip5JiXUA2Mr8/a+Ou1sPkTj+ApxFvx4NE8zF+MfEegG/ekxw6iM5a8hf0j99YpMveYfck07mHq
	nUNdCgQHxK6zmUDV1PWfiE5TfHxTsDoz88/QiZvj3S8F60zRVfX7Fk44URVILPe01wPkAVRNXsF
	0wTIKNmtVY55MUCIgrGmMQW8xTAveEsm53CaqwyO8jKamDf/hZa38Yp+NOn6Dh4MGeiOSLx5OTp
	Ww9toJEjlCmveA6HgTrzQ50slSHXkwVCuq7TVq6crggyvpt6blrfRa/tOBDyGAvwEqN9koc9ajW
	uXrggbChqxiTdoPrUABPmpXbAMKzVmPBpQyEK63CVAnGWkzdTBkvuaBxs0ZRgvldtx3i0Nhb7c+
	luJ+IWbVRSoQ4nsK125LWSILSlMrZmer4Y5wVrD48Xng==
X-Received: by 2002:a05:690c:397:b0:7aa:451d:bf9f with SMTP id 00721157ae682-7af6ee4915dmr53216827b3.5.1775871635038;
        Fri, 10 Apr 2026 18:40:35 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:34 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 06/20] cxl/port: Add 'dynamic_ram_a' to endpoint decoder mode
Date: Fri, 10 Apr 2026 18:23:01 -0700
Message-ID: <20260411013958.47422-7-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Endpoints can now support a single dynamic ram partition following the
persistent memory partition.

Expand the mode to allow a decoder to point to the first dynamic ram
partition.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++++---------
 drivers/cxl/core/port.c                 |  4 ++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3d95c325f6e0..c604c7ca6432 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -358,22 +358,22 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
-Date:		May, 2022
-KernelVersion:	v6.0
+Date:		May, 2022, May 2025
+KernelVersion:	v6.0, v6.16 (dynamic_ram_a)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device
 		local address range. Device-local address ranges are further
-		split into a 'ram' (volatile memory) range and 'pmem'
-		(persistent memory) range. The 'mode' attribute emits one of
-		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
-		not actively decoding, or no DPA allocation policy has been
-		set.
+		split into a 'ram' (volatile memory) range, 'pmem' (persistent
+		memory), and 'dynamic_ram_a' (first Dynamic RAM) range. The
+		'mode' attribute emits one of 'ram', 'pmem', 'dynamic_ram_a' or
+		'none'. The 'none' indicates the decoder is not actively
+		decoding, or no DPA allocation policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with either 'ram', 'pmem', or 'dynamic_ram_a' to set the
+		boundaries for the next allocation.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..a7f71f36531f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -128,6 +128,7 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_a, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
@@ -222,6 +223,8 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 		mode = CXL_PARTMODE_PMEM;
 	else if (sysfs_streq(buf, "ram"))
 		mode = CXL_PARTMODE_RAM;
+	else if (sysfs_streq(buf, "dynamic_ram_a"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_A;
 	else
 		return -EINVAL;
 
@@ -327,6 +330,7 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
+	&dev_attr_cap_dynamic_ram_a.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
-- 
2.43.0

