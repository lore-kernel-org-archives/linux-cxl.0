Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70E340A76
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529431; cv=none; b=FupJTzdzu9Uj1Wzo4+JE1BjapojHjy6GyGh5yQhwoKRjNRJ/L0jrDQR24PYTMwM/OLYeoGlhLpfsoZKY1EPVrRn2iP696ob5MyyFGnvVi3+z6zeH61vQMt6L245gakSq5zyckTV1c1VN08WeEtadskvrLbEvDtNhrF9267P0myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529431; c=relaxed/simple;
	bh=bhkVV5eWL9q2QBEtj+qST0UkfpKTX/AYf0RWbT4RAzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9VfovJKgoJrkeTyazsCENd0esVJNHxa0DbUpcvc8gX9Ly4LA0+mx8gQng4BCwbtTBHkp3XviC1a4YX1jm+OtuHY98/dvlrmX6PU/XY0kXXwQzkU77uoNFWKIql7evOJORlmBPQUJ4EkQAx+VgQSymzeZAjm4Lfsz0Ki/zwSKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ1R4Ufu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ1R4Ufu"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3044857f09aso2978996eec.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529427; x=1780134227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WfczXqcXBpP3sctFNC30HRypl1xDvSsdjoS+nUQlBk=;
        b=kJ1R4Ufun7G3m0N6kv1r1+4lbuilaG7Adolk5GIUjQ9p32bZPDPH0wGc9AOafi9wbO
         fWgjao/xSyAkqgVKx+S0hl9wx7GItmWzj3b2mgS7X/Fyp9C4eDvkhWclt4DrFqE0u3Ml
         4bx7K1+lIneusKMiGqIg2euxq2ZVsZS0bCo5uA2PuEATeshrWoXmn4wka2myDiYVsqoo
         stR3ma3SlX7FKi7vFgLFYddwf4wsVOFvCIIETmdN393PHlHktjTTIRwshjDFUd8KpIYO
         ogjC8itGvM9yP808jdFj7HRk+moqmiMAsfTllV7W/ckFihtSF8/Yla4Wm8z/Q4fTU8Uw
         kPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529427; x=1780134227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WfczXqcXBpP3sctFNC30HRypl1xDvSsdjoS+nUQlBk=;
        b=TAL7Bfb05kw27oxlxsmeIKtB0XI9NzKADf6n7SyS3wER2HWP3uBAXrkOGLX5R5u7eW
         LUAFAuPakK0Kd/zbwY0zKK7c4EW06NCAKfkkEPEBR6RRPmptWVTNicrnucwmj6DzQA/e
         Bt/fc5QMAHj8p/VFW1HWzRIYlLORkleSgpB558/QPsBWBmNsZTpgdtXkuw7TMzGnkCUT
         J63nNASXl7zcST2788IsebFlvkchC7KPPiKyTkzDQgqxEc7PtVWoqbi2HuC/QduJFs5C
         mXgdSg59M8aCsaQG8jPYnn03xZc2C/SjiCLXBav0mD6TE/48Xkqo0TnF/t+z0MBtt11B
         TIBA==
X-Gm-Message-State: AOJu0YzzGzywrvUETi4h1fd6EN6Ie/Vj8SgiCMv0wUXXshzKztRo7iK3
	775AVCqwTHt2VnyVFyNo+EhhIKPAQ8Wvbi7jtc7/TBGkEKV7XVBOW4lYIZCYgA==
X-Gm-Gg: Acq92OFdmazWzWBc8gZNX+/Yk7gLhksXpJTxJ6Kx1qH9obFZazcM9z1H+Lr/Ww/ZcE5
	/L8TDXM1zZjbnq1twom56fBIgXIB/Iyw9WMkUg64asd4cv2MIpY6PKZjBzMtFAsmXEHw7SnkLQm
	6x2PQAyyXOYVHgtf+fpcYefjJ4ZOeyIIoQGdUL/7NIObDgEuy5g2d8Mn8ACzY7+RkLnPuWkIJeB
	NiwGN04YfylRIp7TOp1aFobUqdGQC+uREMCh9KTYqsFVIMrBcDmkkrOI98cwj35UN8UFZnNaNRO
	JYFW+spf3QiC0WK5EosGKFsom27NVZFbWmIDLDTNuB79/stRnGDmyOYnh9kYHnfZKGra36KL10c
	h6fd+0T6BFP+i01G0p8duHW7yYZwu8M958vCXABOpxFJfA7uVGhj54UEqN202PE8jUyQwHrNc+v
	hCimtttg68qJ3sCSXawwhlQwxsKvgRb1CNNZSz2CjvWn/ctyscU7SGdWOOHoRuWb21hXIom8VSG
	YSxpWpo7ppEIuT1vF0VDpmKJjRA
X-Received: by 2002:a05:7022:6893:b0:12d:f0b1:75de with SMTP id a92af1059eb24-1365fb424admr2816473c88.22.1779529427374;
        Sat, 23 May 2026 02:43:47 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:47 -0700 (PDT)
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
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 06/31] cxl/port: Add 'dynamic_ram_a' to endpoint decoder mode
Date: Sat, 23 May 2026 02:43:00 -0700
Message-ID: <58e5e5007cd11e0b8e65016f126144f187badb39.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
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

