Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09942262FE7
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066926; cv=none; b=e/tvAGX8DsUTCcvx4VcqsXOYzk46EbDbsSlEeKU8Js5S1ZmRBQwO6K+c7XiExtf9wap84EZZ/BvoOHGjN52QuudbwhD/17P8k3ZYMoOvUEnKx8gYSeD94z8ACeqsvAE8QUp6H4YpnsqNp368g9/hP8JSlAgrVhp4q0xcJpRNncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066926; c=relaxed/simple;
	bh=6kFRAXLyb71mD2Zs2gNFWfCB+AfEcQArhWsCvZFm48U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkowfOfijejeeWFBHCwIA2AtxUS9tDo+3f+KZhn4ybYniA1DllQbqV5bOp+ycCjOSiij2K41OI0FMx2G4QzNCJ7FUMtXyVYVrGdQSSeilyd7lzmZteltGycwWqIbEQhjov47jcAQFbx5fDlxU1+SJC8yXmIRT2VZMPDma4HnPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JnQElByY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JnQElByY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476af5479feso55103391cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066922; x=1747671722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpBvWJMvNrl2dBGkl5driDL3hYTI6jOnBaaDfES2w1M=;
        b=JnQElByYJxg6o/n5loj0kZT19DtAktksz+qN61RdF2oaWDqIHKV8aFcNcCvsxW0FHC
         pYSnQZsUnbxVcWxgAV8kGggKL6eUEishsR5dWy/Rs045fVb90jouUNaOlI/5FjLY5BZy
         ctnLUGndKKZbn2S0nN15JlLOq9CbGQft3XmZOyYIHQ5aqB8js673f8l304Ro+UwxGQ17
         MpTvbphYM1tsFD0QcKsdGxS2c9jhdkEmuDJqAGnyXBFyWjT2xmr7/CZS71MQTZ3UEw9j
         syopRlDwDO57k9vskFG/k/vdjD1qy34YGj5YaWo3iW0ncj8MPa2sbDLIJTnbEHy1odQn
         NlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066922; x=1747671722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpBvWJMvNrl2dBGkl5driDL3hYTI6jOnBaaDfES2w1M=;
        b=bYPMrzweW9VLAPGExlkGyCFlWQCeOmRHbF1MnZdEcg36OceK781GFGYiOVJ6E2iBFk
         gLbw2LbkyNJ0FMRQvfNcY7LlCoTLgERm6MtVEsgXwvbiAUWzRH3soorJKAjR3rU5f0kG
         PW6Sz2YvN34oILzLBm1iu85TEwMn+ZqqWmU48efUuOqotko+TBToAwLlt8qdS5WjWAlG
         J2pS9+vcw5N+ufJ7QRBjLJuOX8d6cgB0MsRIPzEU77otbBWXXu2gv66Tqk+4vbYEN2S5
         BTvyNMWqnNzDVgulUgho4kP0hXyb0tuYxLJHrCgZZMTKw3hVhNBoKnuSMIIyv+rEiQmW
         FUdg==
X-Gm-Message-State: AOJu0YyWXUqTprbkymdU6T8SdGCNGbA2drZVS//iSDmlrdlDtTh9Ki6+
	e2wawGqMFiJXwT0UgvMrgqF6Z7q9NHGFxrTW5Yr4DP87VKkQT19QPYNPNMB0E3DjSmaluIpGRWl
	1
X-Gm-Gg: ASbGncuSptM+/Gq/wAkm/IKR38f7wrOtuVLUTIo8niXiMAYmjz7cydzx1JSaOTuyG4g
	fW89YiCE4ukIZRlLmpN0ShejI0ZI3kgpNiylr6tM11v/AsQcFM49XTkdlpGxVWOmHZqs65XwCix
	bFxr/0HBRU97vzWqlGzXaiCquzcPUkPvSV3NaTThwypgGNcviACSmQLzHpq7xLG4srR0/szIGfZ
	a35BTsN9FvPpE7ONFl5AWLS3F+k4/Psbrxfu7tl+FpkLH02/zbkSMqnOBfJxPVusHcntORXj/Wo
	n4c8vX8dmZX0CAFdzQweK3vS02+4+vAQd9wUPmsNJYXk6v8gXTM4SECKwgsGwUsTptis912zuD5
	F4y9hiZPxVg4hFJ+m8kilny9+xz0rrkwduZKx
X-Google-Smtp-Source: AGHT+IEgOwqbTVyM2cCqwhYH6oeFz+yp7dgByEYQB2haUlrU8NGA2h0ID7S4kwTF7yVmhY0k+Ia7IQ==
X-Received: by 2002:a05:622a:5408:b0:477:c04:b512 with SMTP id d75a77b69052e-4945273c1dbmr225206941cf.16.1747066922158;
        Mon, 12 May 2025 09:22:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:22:01 -0700 (PDT)
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
	corbet@lwn.net
Subject: [PATCH v3 13/17] cxl: docs/allocation/dax
Date: Mon, 12 May 2025 12:21:30 -0400
Message-ID: <20250512162134.3596150-14-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small example of accessing CXL memory capacity via DAX device

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/allocation/dax.rst         | 60 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  5 ++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst

diff --git a/Documentation/driver-api/cxl/allocation/dax.rst b/Documentation/driver-api/cxl/allocation/dax.rst
new file mode 100644
index 000000000000..c6f7a5da832f
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/dax.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+DAX Devices
+===========
+CXL capacity exposed as a DAX device can be accessed directly via mmap.
+Users may wish to use this interface mechanism to write their own userland
+CXL allocator, or to managed shared or persistent memory regions across multiple
+hosts.
+
+If the capacity is shared across hosts or persistent, appropriate flushing
+mechanisms must be employed unless the region supports Snoop Back-Invalidate.
+
+Note that mappings must be aligned (size and base) to the dax device's base
+alignment, which is typically 2MB - but maybe be configured larger.
+
+::
+
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <stdint.h>
+  #include <sys/mman.h>
+  #include <fcntl.h>
+  #include <unistd.h>
+
+  #define DEVICE_PATH "/dev/dax0.0" // Replace DAX device path
+  #define DEVICE_SIZE (4ULL * 1024 * 1024 * 1024) // 4GB
+
+  int main() {
+      int fd;
+      void* mapped_addr;
+
+      /* Open the DAX device */
+      fd = open(DEVICE_PATH, O_RDWR);
+      if (fd < 0) {
+          perror("open");
+          return -1;
+      }
+
+      /* Map the device into memory */
+      mapped_addr = mmap(NULL, DEVICE_SIZE, PROT_READ | PROT_WRITE,
+                         MAP_SHARED, fd, 0);
+      if (mapped_addr == MAP_FAILED) {
+          perror("mmap");
+          close(fd);
+          return -1;
+      }
+
+      printf("Mapped address: %p\n", mapped_addr);
+
+      /* You can now access the device through the mapped address */
+      uint64_t* ptr = (uint64_t*)mapped_addr;
+      *ptr = 0x1234567890abcdef; // Write a value to the device
+      printf("Value at address %p: 0x%016llx\n", ptr, *ptr);
+
+      /* Clean up */
+      munmap(mapped_addr, DEVICE_SIZE);
+      close(fd);
+      return 0;
+  }
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 35c5b0c6f95e..6e7497f4811a 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -40,5 +40,10 @@ that have impacts on each other.  The docs here break up configurations steps.
    linux/memory-hotplug
    linux/access-coordinates
 
+.. toctree::
+   :maxdepth: 2
+   :caption: Memory Allocation
+
+   allocation/dax
 
 .. only::  subproject and html
-- 
2.49.0

