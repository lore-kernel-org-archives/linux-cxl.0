Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330311DC9BB
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971980; cv=none; b=XmvLe3zmaFwEWO7xGxsqsxd1Y++Ck6nmOP4y7ToJDxksUq7uHcGGhsYPb6HYtYYub8lOy/bkwAfxhWvew7gKhJ6xpl9EcWku02JMJyPmQ45mxrT19qr8O03oVySIE6W6m3bOFFqp8vWa8SqDenfyf2pHiRMOsR7aiPJz/AuNj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971980; c=relaxed/simple;
	bh=TbudILUJN0FP5VLxGVnsYnNFJJO9PoQVJHqli21jG0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmzOqJIJZTx7Q7GioFK5f7D9/m5XbxoLxceQ3Lat4mFY91VxaBftLIoYQ5y6Y44c7tbda4rYzaYhw/Nqe/cs6T6pQz3whVEvAY+ag1qyf1yz9rWTZn6tudiy8yTETMXK+A9DaxtENGp9JP2OM2ND1mym2kUQBGa20e8g6OL9Eoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lQjvfLoz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lQjvfLoz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4775ccf3e56so4897191cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971977; x=1746576777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/jf5P1SJ1TTjW37Z8pO9A3yJArrRLf6vL3nuDSaJuU=;
        b=lQjvfLozNq83YMcBm92iURmGiSsutiPsGwqCMVfVyYGmkRtQ7Zi+iKfrdQRP/7n0a3
         S3PVpdHCSEe2nKjX3l4KUZ7Jwq5I1ICveaidDjq1RRLrTgNHhfDQFL2Zavis30JED+3D
         cOP1RdN86FqtBxAa+nYm6Di/sN+7Doc+GSJGa3PkDrusoSj7oGrzyQtak6zxxlL0pvPg
         /PGCU6BKaAzVwx9RLtwXXiDG1kvXkm6cAvNLZBr/qHeIx0viotKfSWKopcLh3EQzP8KK
         xAWzpCITUIZ+qFp+7BIqkHycCtKIqWqzbUVaprGEnxWXVI20id9L2V1rmktyOFF1PvSJ
         2YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971977; x=1746576777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/jf5P1SJ1TTjW37Z8pO9A3yJArrRLf6vL3nuDSaJuU=;
        b=JQocoIKJBuObwWeroYlyX0QOXJDV0L8//SAzKmCnQfqLlmGiO/QUyI+tKELpzqNw+e
         OnwCzYuJHYnwgGOXkyEUVG1Y1VrprXkdTmN4C17C7LYzEQSh2rmdZIeeXh5+TbWKy8jK
         p3GRbr7W2FP12s62ip+4UxUVYUZ0AF/Ys+2WMdrAkhqbjBsu/cz6NnX71xHAC1g066h6
         jID9Zi9HskorJlDcmtwcAvBlMDRXTAX2lyS1jx62EvIjmQDrqotx0/3FypB7Xk2/1xek
         fl2MygDhUPadao53Te3qCDouYlhU3KPysTcjVUDMkNpQIQ7J8mJd6LcVgGEgIL1R3TgN
         MMXg==
X-Gm-Message-State: AOJu0YzITB8CkOYsXLiXzF3jfmxsmYde6/+FvugXeZDjDy8E4QpzgK79
	Xi1rgUFs7YHWKFZkntbNtsPt30kLjglSsdPcpQmqvUe1UnxVhOcWCU3aX8K/CyVv1U94jVClVFE
	A
X-Gm-Gg: ASbGncudM/gwTK0pW/Nx+jlepZeG81Pspr0DYyaOCuWQEmWXW0pG9O/e21swb53sBxd
	/lirgwCThZPIGK4qO0tGvpCroCDzkmuR1s3XqbGPPlYhOL7tuH56kQyBq78u2nh981ZQGgtLbap
	/o3mD0yBpDZOPHIacG+xLp3FOYeY6DJmiql/PZjEIwXZL5DFeaMsZ0MRj1H7deUZ4CqWMS7f2pb
	9151L8Yqut+7+t0/NSkmT0l4YNFY0DnR2RLlAdCYVgP3Z70EkktLiiFFAysxXxb4JWivZIlGE19
	rY65Xwx1O17yt3+/pX6rrrlT6/fyJR4ALfl0pkLneW36jGWRw4LU15t3sgArGYUCkND4y0Ta9kw
	M1FQ4jkKD0ebyjyqW2gg2WmMeMwEM
X-Google-Smtp-Source: AGHT+IEF1VJpcgqXRaIJTt5/r0suWK89wo3LFIdy+JCCJintOUr+gPIbueI1DmAc/mN/DB3Iu06J9w==
X-Received: by 2002:a05:622a:a0d:b0:471:80ef:35e7 with SMTP id d75a77b69052e-489cb7bfd7dmr13735131cf.4.1745971976847;
        Tue, 29 Apr 2025 17:12:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:56 -0700 (PDT)
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
Subject: [RFC PATCH 12/17] cxl: docs/allocation/dax
Date: Tue, 29 Apr 2025 20:12:19 -0400
Message-ID: <20250430001224.1028656-13-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
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
 .../driver-api/cxl/allocation/dax.rst         | 59 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  5 ++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst

diff --git a/Documentation/driver-api/cxl/allocation/dax.rst b/Documentation/driver-api/cxl/allocation/dax.rst
new file mode 100644
index 000000000000..8e0c9f6a6843
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/dax.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+DAX Devices
+###########
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
index d5186fc609a9..d19148be3087 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -42,5 +42,10 @@ that have impacts on each other.  The docs here break up configurations steps.
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

