Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C235CBCB
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720711; cv=none; b=UFuepePJE6CUhFrTIwuVGqu2b1QWxsHQ5oynajmrd+/iTRZhcDG9vjrvtN2Byiu0o9Jj74YjsxUApdRB3wzBlCGs0l1NyKqYMo+3JK41YLPHl1T2U7YYghq+nOfstqdDVuWCB4pFan+AHIRU/ZX2kkGtKfqKmJJjLmkZFK6YzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720711; c=relaxed/simple;
	bh=Ysme87URA8h80dz3v+yZIs8qliOaAmjArpOmGNPSVUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjPoUfdf9HWV5GhWEFpl4a+izrgui7aB2klv9A6TUSC2Jty1N8p6smCHWU+5/sDckc1QuRYsgz5cEejfnzl9Al3FJ2refJOKwKtMa7Y2LiTH1HUEzYUhUreTBTuRIK0mld4oU1yejAKWd4wa1NzQOj32nj0gwbiyM1DX2nwbpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QmxxnYP9; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QmxxnYP9"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c6d76b9145so156421385a.2
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720708; x=1770325508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2izjfMr9wFUktZXLnWxTLQ+Uf13Bf1lvXAJZzNDICcs=;
        b=QmxxnYP9qHqlX5teNx+fVssa6DDhCzWbcI8iRZ9qLS4T3A29ArWI7Yu3NRGNyq7euZ
         lqS8/NeIgmYLUmi3GxySKkroid0G1b8vXKX8PuW+mBk+QAsPcXm470wilU6yfHMowbMQ
         epubSFk+CkBbixUrXGBerZKw/U2NoQNczMzprZ3AAX5Vr4AAANFC+JxzGKEhZRtMnzyX
         3uMSJN4OYc/7dS8I08Oi6iLXveO1yZywqcVZWP8h2zJVsLGxWo5p3Y+HyIN0+nXXxCG2
         RIDF1t++cOFMIw+zzv37v6DELRkVluXfCMfnVsxP3zbA07W7t3eAL+1Sm5+JJXYZFojP
         yztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720708; x=1770325508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2izjfMr9wFUktZXLnWxTLQ+Uf13Bf1lvXAJZzNDICcs=;
        b=vlDk4iUandCENsf0JEW2hLz9o55Hb4B8izWSHWy+jOvYfqJ/0cqcjgCjcQiLSiOE28
         aWUYXMVw/7j7/KLVx6t5ZAHirxS3RjB1mJVawmSP9gu+HMAbFVQGQhOgUvFF9UBSqek7
         pXuzyNwAc2uoNeEiSqtQT+6/DOPUjQPQU3C+iF2ns3N+I/B7HTi2xh/fjcAtREHdSCSi
         f0m8t2FF1OP/XP4OeEPpLp/fIUlMJyvb8+PNCYGAZC3YX2ysypxO0PppRr3MoVhTAjRN
         XXdZz1LZSekT8tWuK3KFSmsqSmyKxeTZRB82/dGkbobeS7qcHDYgZD1RpQVkYTGgUgj1
         54wg==
X-Gm-Message-State: AOJu0YwuDYjuGrB6fgmQnlbkkIs3+AkZq96l2mI00vJc+rQhU1+ngCwa
	vm/v9C1cgkG/1/o/5RS5DtYecPxOQAN5Y12nK/PRwNg8FErQH1HCzFsubsiHjshkLgo=
X-Gm-Gg: AZuq6aJkvMF3HrerGBZbJdok+8gUAulcxzqwQOXEst5VIsR5CZq0D2ue8HnipODFTSi
	N0K5s7V63kzN92Da38W7+gksVCEQ61FlQb46j8juwh5UTsUUdcmVCMLOW/boQDo0GwTZnmbNC4H
	RG/EzVKFEOz92zptg4oIKUXx3x1ATwwXlq0rRyZy0bw+PCg1oSEBAnU+aPDlAnKTHT+09J3/eZx
	UlDHV00OI6Ni0KyRL1WfEqt6pZaaSjL0zsYwDoYWfYJUSKab1bjsS85PuHzDY1s05nSPlji+WXE
	Er7XsrUyHtemVd1nlQcQ+ENd3DEoe++5fvymQXgVkGvFiTji5eqoIng8TDVmoTin+3H8nZ+yboq
	PpFOPSZsU0rmIGeIlTQ2bIAfody2JlPnh5x07e/2EJcH4QXtFNq0hEfBS+agA0OQtQ42jnAsfZQ
	eEcg36w+EgjgM3nRu26iEl0cOg89c0yjz7i6mDmTjD/l9wfEIU7zqTGEr8bWrzMJdavn3dbsRej
	il0BCsaDckjhw==
X-Received: by 2002:a05:620a:2845:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c9eb258c5dmr134323385a.5.1769720708025;
        Thu, 29 Jan 2026 13:05:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:07 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 9/9] Documentation/driver-api/cxl: add dax and sysram driver documentation
Date: Thu, 29 Jan 2026 16:04:42 -0500
Message-ID: <20260129210442.3951412-10-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain the binding process for sysram and daxdev regions which are
explicit about which dax driver to use during region creation.

Jonathan Corbet <corbet@lwn.net> 
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 43 +++++++++++++++++++
 .../driver-api/cxl/linux/dax-driver.rst       | 29 +++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..1f857345e896 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -445,6 +445,49 @@ for more details. ::
     dax0.0      devtype  modalias   uevent
     dax_region  driver   subsystem
 
+DAX regions are created when a CXL RAM region is bound to one of the
+following drivers:
+
+* :code:`cxl_devdax_region` - Creates a dax_region for device_dax mode.
+  The resulting DAX device provides direct userspace access via
+  :code:`/dev/daxN.Y`.
+
+* :code:`cxl_dax_kmem_region` - Creates a dax_region for kmem mode via a
+  sysram_region intermediate device.  See `Sysram Region`_ below.
+
+Sysram Region
+~~~~~~~~~~~~~
+A `Sysram Region` is an intermediate device between a CXL `Memory Region`
+and a `DAX Region` for kmem mode.  It is created when a CXL RAM region is
+bound to the :code:`cxl_sysram_region` driver.
+
+The sysram_region device provides an interposition point where users can
+configure memory hotplug policy before the underlying dax_region is created
+and memory is hotplugged to the system.
+
+The device hierarchy for kmem mode is::
+
+  regionX -> sysram_regionX -> dax_regionX -> daxX.Y
+
+The sysram_region exposes an :code:`online_type` attribute that controls
+how memory will be onlined when the dax_kmem driver binds:
+
+* :code:`invalid` - Not configured (default). Blocks driver binding.
+* :code:`offline` - Memory will not be onlined automatically.
+* :code:`online` - Memory will be onlined in ZONE_NORMAL.
+* :code:`online_movable` - Memory will be onlined in ZONE_MOVABLE.
+
+Example two-stage binding process::
+
+  # Bind region to sysram_region driver
+  echo region0 > /sys/bus/cxl/drivers/cxl_sysram_region/bind
+
+  # Configure memory online type
+  echo online_movable > /sys/bus/cxl/devices/sysram_region0/online_type
+
+  # Bind sysram_region to dax_kmem_region driver
+  echo sysram_region0 > /sys/bus/cxl/drivers/cxl_dax_kmem_region/bind
+
 Mailbox Interfaces
 ------------------
 A mailbox command interface for each device is exposed in ::
diff --git a/Documentation/driver-api/cxl/linux/dax-driver.rst b/Documentation/driver-api/cxl/linux/dax-driver.rst
index 10d953a2167b..2b8e21736292 100644
--- a/Documentation/driver-api/cxl/linux/dax-driver.rst
+++ b/Documentation/driver-api/cxl/linux/dax-driver.rst
@@ -17,6 +17,35 @@ The DAX subsystem exposes this ability through the `cxl_dax_region` driver.
 A `dax_region` provides the translation between a CXL `memory_region` and
 a `DAX Device`.
 
+CXL DAX Region Drivers
+======================
+CXL provides multiple drivers for creating DAX regions, each suited for
+different use cases:
+
+cxl_devdax_region
+-----------------
+The :code:`cxl_devdax_region` driver creates a dax_region configured for
+device_dax mode.  When a CXL RAM region is bound to this driver, the
+resulting DAX device provides direct userspace access via :code:`/dev/daxN.Y`.
+
+Device hierarchy::
+
+  regionX -> dax_regionX -> daxX.Y
+
+This is the simplest path for applications that want to manage CXL memory
+directly from userspace.
+
+cxl_dax_kmem_region
+-------------------
+For kmem mode, CXL provides a two-stage binding process that allows users
+to configure memory hotplug policy before memory is added to the system.
+
+The :code:`cxl_dax_kmem_region` driver then binds a sysram_region
+device and creates a dax_region configured for kmem mode.
+
+The :code:`online_type` policy will be passed from sysram_region to
+the dax kmem driver for use when hotplugging the memory.
+
 DAX Device
 ==========
 A `DAX Device` is a file-like interface exposed in :code:`/dev/daxN.Y`. A
-- 
2.52.0

