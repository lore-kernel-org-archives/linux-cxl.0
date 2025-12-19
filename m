Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACC339841
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163983; cv=none; b=mUR7WZ2IOr/VpQCfVdolasZHsApEBXp5kNaIt/7WNrEtnXDqmsfOIw9LIKngpklWJNHVcCSFC5XnTaJB8zyf0cBawGQsXCOyRWsFAtxciUjgKtazbfYKkBsW7YMJKKgoboZTxuy8HDWpZSz2OedxDvAQuYP8/W6xm922ZV/PMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163983; c=relaxed/simple;
	bh=0D/WrdGQQE7ltHL5+mGa/wEqsIL3YPu+z4L3U2Lyshg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm5xNIjfMcrmgg2RGafiM1tjs47Laplya18QQv4SvGoJ+BTfb0xS7/pt4vAR1vqIykhebi4eYWhezntJeWfhVjnU/rC9kQlG/RVq7c+mydFx/tXOeRDdlYWzvdK4okBQHZGQveD7mm5Y4x0tsD6I/LpxqJCglYuJsB3/e6KyO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ei6ASSpc; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ei6ASSpc"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4eda6c385c0so15008291cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766163981; x=1766768781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kou8afbLn05l+95wrl3ljXnrRcnV/4rBFXifcZSKEU=;
        b=Ei6ASSpcATcOSt4Hg9M1P5/7rlrbnn7cUE1w7jloYyMv/AjUQknuuIQJL8cfJ8Lsg1
         e/FtFrk55jLNHumNaKgy6cDm2bQSVCOZJCYBWUOOtQc/0Q5hp7CNbZG3/NuKFrXuJPFK
         x4P1fcm7F9fi+osc/VF9Cu6Aqu04dBFO4XYKcvpJJtair0Z9976Dz+iNyFcxi5H3oPwh
         mk5rBGVjBiQndB+1xFvYulMAuTrFjPUj0P5Xf/7fxkKBQDDGLql7j+jb+UKce7zpx/3F
         ycfKauErYVzpsZIYDlWZbwRgtH16A3KQfsjTuucnDQjvtZOeqyB/H/JMDECBmIV1tBkE
         Mwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163981; x=1766768781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kou8afbLn05l+95wrl3ljXnrRcnV/4rBFXifcZSKEU=;
        b=fJIi/j5LRrsVPM5yuDSWEhF+niQ/MALSzQbIQJ8sy9fIkzFLsoybOaB6i9I5hS2gfX
         xYXwkfN17bwJopXqc3Q+mNZcN21w3KuLRHyw4yfxbzRWUMpOiM0wDjTjiHclYbZxhAsR
         dUATh8iyanXbdCW+GfKUA+v5r2JKfOLeMhl0aRZ0IQALvhjgA9/ncH6pqoqoxDfH04ck
         zKO2NRSBxNwkSF5fwNY0pQUHPoMh8xp38QQEsGhBVMZbs0dvtbHlAmp7RF9VIeWkG+KW
         PAY3YR+FLdevmcpKrdEz03gbiOpfHNRaL841xLmw/epEib1DJu31AaiNZKiGZNsBVzQn
         tvUg==
X-Gm-Message-State: AOJu0Yx/DhREvDLaroR9O4c1LZ3b93E0I7KZ46MQ3AbfzObsPJVA4KpC
	ynXP799vJYwJqo0axwsiHq1yXSkdVOBPsF+Wt5chcHKhK7n995PO5q1vwDVRdJcdIgfyOX36hDh
	1Fk9bm5Q=
X-Gm-Gg: AY/fxX6weWDbwPxMZIkm26ZbiE7PYnAdERAH/v3EJiNDBeISD7DehB/cFCU70AkNkyy
	Oi/EY4Mx+K9+m6njyNXng+HY5N8wbHAopd+HrOLTqRRmmyIO6yKuh4Ers13iCghp17Ke20Q3JY6
	OKV35Gt0UCYaUX2rqc0cCufQl26cI745vkjxdbZyn8eE1+g8z+veA9Jj8fE2RTgVojGbeldCKvL
	KkrcjKfkG1+hNeap04teQDt/NyLWUnq9HRr4R4i5MiXiJEnSF3DGcEPhv4bJ/YV/m4pZOLvfUBF
	4tEdko8D7PZ4R7z9UXWjXyoiJkMHxtVcWxNOawADZKl8nD1xGbI5Y0AT5qKemjzNCP87xH38SZr
	Q3GRZ0oM25TiI2SUpD6smgAprHnVpq+5IaiMvWtC2ETgpq1TY/t0suuU5w5B363KiDKyVdm8Jwf
	LOPZyfC/A2S9jGd7TLx8z1hWVpYiZAnV8LKMl9q8cNF8EIXVQHFzknqKnMqfzoT0X/cZxDSCv2o
	HY=
X-Google-Smtp-Source: AGHT+IEw8aBZs2L4mMPmBDnnSLjfBX5Ies32NoaSuD3sFkoiOQdXSOB6QOg5l7pX5LIIu4V5HSwekQ==
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4f4abd2b668mr47440391cf.37.1766163980936;
        Fri, 19 Dec 2025 09:06:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm223197185a.4.2025.12.19.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:06:20 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	gourry@gourry.net,
	rakuram.e96@gmail.com,
	alucerop@amd.com
Subject: [PATCH v3 1/2] Documentation/driver-api/cxl: BIOS/EFI expectation update
Date: Fri, 19 Dec 2025 12:05:37 -0500
Message-ID: <20251219170538.1675743-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219170538.1675743-1-gourry@gourry.net>
References: <20251219170538.1675743-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a snippet about what Linux expects BIOS/EFI to do (and not
to do) to the BIOS/EFI section.

Suggested-by: Alejandro Lucero Palau <alucerop@amd.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/platform/bios-and-efi.rst  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index a9aa0ccd92af..9034c206cf8e 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -29,6 +29,26 @@ at :doc:`ACPI Tables <acpi>`.
    on physical memory region size and alignment, memory holes, HDM interleave,
    and what linux expects of HDM decoders trying to work with these features.
 
+
+Linux Expectations of BIOS/EFI Software
+=======================================
+Linux expects BIOS/EFI software to construct sufficient ACPI tables (such as
+CEDT, SRAT, HMAT, etc) and platform-specific configurations (such as HPA spaces
+and host-bridge interleave configurations) to allow the Linux driver to
+subsequently configure the devices in the CXL fabric at runtime.
+
+Programming of HDM decoders and switch ports is not required, and may be
+deferred to the CXL driver based on admin policy (e.g. udev rules).
+
+Some platforms may require pre-programming HDM decoders and locking them
+due to quirks (see: Zen5 address translation), but this is not the normal,
+"expected" configuration path.  This should be avoided if possible.
+
+Some platforms may wish to pre-configure these resources to bring memory
+up without requiring CXL driver support.  These platform vendors should
+test their configurations with the existing CXL driver and provide driver
+support for their auto-configurations if features like RAS are required.
+
 UEFI Settings
 =============
 If your platform supports it, the :code:`uefisettings` command can be used to
-- 
2.52.0

