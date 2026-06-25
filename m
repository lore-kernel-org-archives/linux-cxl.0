Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FE3D9DCE
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386898; cv=none; b=tSgRJEh1oeYROgzDvHInM5nq/osFTd88WZINsTaEIgBE9/uuA5ucpYyEld4WlWgwMHALV/7bKVN4GV5/rppst2wPBce6fK/Blptza0VnhS4l+5+VqalURL2G0/2xqetXlD/IjRSQXph0qnsulwqn05RwyyLIf9vF0HzLy0TNqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386898; c=relaxed/simple;
	bh=ATkHmMP7MsH0mq/QlG9WJufW7IKZ4PYK2ldlb4TL8tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXXeZLbcXKxkOPCG0hrEDnoEqYweyeNQGqEDx8qjnKn8YSLrZprTX/lTGA6Ynw/TpM38No4jvDV3CnQzGwWx5uj5Qffg7rMhXe9c4InQ4YjCLZ6N3CU239bzGELaaocpdoVQW1UFgZrejfSA5GEfw3K/C8G2VpCUIz0FC/HZNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnufF3W4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnufF3W4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c52cc5285so3247089eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386894; x=1782991694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9q+SAqx6fCfz13KEJXyzu0M/be87sqPxBXsY0JwlT8=;
        b=lnufF3W4Ts51GbTsad5+RyVM/cs/hRAaEPHgsmaOb4Qqp997cXTOQrpH7LEKfwRyjG
         Q570bYYXz/9WEuEgPh5Ck5LoH8hx5NHO+JTf+oO0S4CmPJ1ZD8kaQN3rA92Pz31TnfjP
         QPhtLEJhapZQ2L+qKDxuxe1w3iy1MXWdM+0qkUl6kLqTShW5U+hENIKmkvQG1uz5mJv8
         M6tx2gQ/K7CpKgv5k4EXYbA3ewM2GVNRWDyDAXuXOd1J303QjBQewcysNjOeKoA/rzJ4
         8WkgkDsT+kaT+iNtuKE4Qg8Sovu4SVy+qufDrrUaTqDZbxoakoX+fwUHshwBVhGxbJlo
         MROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386894; x=1782991694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9q+SAqx6fCfz13KEJXyzu0M/be87sqPxBXsY0JwlT8=;
        b=fPVZTpJL1K5LnF9AmhQM7XjBiUQzBqoBbrzHaqmR70bQZ6fI3WsqX40ClNGacP7+2h
         64I+bng1aschctbNtXV3w63xsQNrDjvtlkR50+g5rn/53pKKQRwjITsEudFZJJPef8pq
         8KFgD5BOOGqOxXJpV9ihPu4ETOiOsG20ft0bam6r9VI8PXdnJx2g0fr8NlldXzaK/Z+j
         DLtGPJePkV8slsxkDTsCFX14J61R967GAzx/mf/3a3/P9vFqp/M/pPFuRIt4U9hxVysA
         iR4Ke9zMTeJmZWCx605a01vS7wx/e+AnjHAGs+xMcccZFBWaiNJGQlmFpwljdaiG1mgf
         pzxw==
X-Gm-Message-State: AOJu0YxzsFROyX2zLA8HG38d3cCkCp/HwRt7bauJlUdx7lhbwYgz45Ro
	QAw8qbVZdPX5j0LKCqOH916jUNS81bG8sjJXMSYFOvgYeploHmeKahhvRbOJFQ==
X-Gm-Gg: AfdE7cmoZCBR/QYZF2orA5Hef4V1oJ+tCXPvCAgCvkGm2uPizLimD1HY7U+HRSU0j0u
	xlrvwn7Jy6mQmcwyWce3nu2MgKUDigRyf1zQzI4axE0INyVlH/ErC1iNZ1wqW/8nsSucamyfmu/
	N5z985oQXQ/c3+krzIzQAIfQMM32P5h+qUwz9DFBIQ7zeSzUX0XynBBK7o9quca5NaxlyBs1/uc
	yG/6Y04Tyq/bM3rIssl3o4ZvR0rz+KT/sAOS7KbIcLts4cMT3Y2j38mtgNc3DZTizcbj+VZT1B4
	evzFKipOGi5SzBQ/19CBk4zGYMGfmku4KiKcWYOXEsat1nr0WpgIQEpzoEvP4h9N7ErJl5A+MKi
	CGt77BnhcD1f2ScT6ggCKHZQBJjjhk7sE4uDfNwMe0fBiaFm8hA3ORbukULvlAAcnOeGBltfddl
	l9eR53B2w/Cr0xzLm4xScvZPzY5424AfMhQHu7tc+O8QJPokL/dFtMdUbAKYe5Zo9MEkh5
X-Received: by 2002:a05:7300:8ca4:b0:30c:2932:dd36 with SMTP id 5a478bee46e88-30c84e1933dmr2589974eec.15.1782386894178;
        Thu, 25 Jun 2026 04:28:14 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 06/31] cxl/port: Add 'dynamic_ram_1' to endpoint decoder mode
Date: Thu, 25 Jun 2026 04:04:43 -0700
Message-ID: <20260625112638.550691-7-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Endpoints can now support a single dynamic ram partition following the
persistent memory partition.

Expand the mode to allow a decoder to point to the first dynamic ram
partition.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
Changes:
1. Documentation: Bump kver to 7.3 and date to June 2026
2. Pick up Dave's reviewed-by tag
3. Rename dynamic_ram_a to dynamic_ram_1
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++++---------
 drivers/cxl/core/port.c                 |  4 ++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 435495de409c..499741cbb899 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -358,22 +358,22 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
-Date:		May, 2022
-KernelVersion:	v6.0
+Date:		May, 2022, June 2026
+KernelVersion:	v6.0, v7.3 (dynamic_ram_1)
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
+		memory), and 'dynamic_ram_1' (first Dynamic RAM) range. The
+		'mode' attribute emits one of 'ram', 'pmem', 'dynamic_ram_1' or
+		'none'. The 'none' indicates the decoder is not actively
+		decoding, or no DPA allocation policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with either 'ram', 'pmem', or 'dynamic_ram_1' to set the
+		boundaries for the next allocation.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..57d0fc72023f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -128,6 +128,7 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_1, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
@@ -222,6 +223,8 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 		mode = CXL_PARTMODE_PMEM;
 	else if (sysfs_streq(buf, "ram"))
 		mode = CXL_PARTMODE_RAM;
+	else if (sysfs_streq(buf, "dynamic_ram_1"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_1;
 	else
 		return -EINVAL;
 
@@ -327,6 +330,7 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
+	&dev_attr_cap_dynamic_ram_1.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
-- 
2.43.0

