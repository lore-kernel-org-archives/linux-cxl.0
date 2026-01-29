Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9335C1A9
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720692; cv=none; b=JgXDHquMLmk79Y7rJRsuoZUmX9U8z/lXlA86Ua14o9RzOHammCgx8Zax7akbSBdkf+2+VpyrKfkbF55HCLWWVoocnDYiAfB2jte+I6xYZZoVvW7+8NCAyDeiRCqSZuFtyVE5vqXyqdwB9oq8zHf/MyP0ZoneLIntWD76UCzG8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720692; c=relaxed/simple;
	bh=akrBn4JPwvLBEstJQ9HeJN9q5u1vwp5xfi2e9tVFX44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk58wa1Dy/6YS2b5EWDqjkCKhuQfSEgdSfndkUeXYWe4qUBOZu3YRcJk+hoT5tp8ZGVsW/dqWtkS12ZXypwvYLh0VZRVJoT1ikwO3wWZB4VelcwmZ6VeuD8HNmiGTdc1LRGm7KXAioEQXwYUihHGzEPScs+5tI9hVevvYXbjazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VKTj1/Ct; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VKTj1/Ct"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c531473fdcso170258385a.3
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720688; x=1770325488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7dwhjhUx8amshGTbVFKhqWt51EOp/YvCZDul2or7c8=;
        b=VKTj1/CtthKjNpOH14Qy/AaDCYqFfxyeMsekxnh5rv/USxlWS1YmyR4tjvh3AgVh79
         5bm9Ug8rSMbn1VpSDe66i939pqWE5T8Eeyjv4xye+AfRlq67BCP7onpfV7YzWrzr+S+H
         w8OAFmEgyr0QgA/4IWRELcaKjn9k3Ceui0Zk88sOL73DA6nKp8k9+EbIHvn+713narDF
         3J0dm+a/KXchagXdnES2uYVuNIKX9EstUMnaZk9DcgyjqaVHN+TBpumR1+YxGdbV5wuD
         YAm9calgriXtTNFrKQlghJR3Upds3CKQLjwNYW+kt3vITS2Jf/HSP5oldfUSgAUVSaCt
         hCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720688; x=1770325488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7dwhjhUx8amshGTbVFKhqWt51EOp/YvCZDul2or7c8=;
        b=KDrc327DHt+54SrkDg/S92ER5VgWbg4Kn3Vw2hh2M3F1Iuasr1J08IrT0LYEacb5Cn
         9NHqxynggobHn06MLfeFKMUMYGemuDXSjQSM+Ni6+90ygb/sfXukkLzyhDlbJ3NbEXfG
         gIPFL/iEXP3P+5CwZz+HXhcgncBdxjdaHsoNshE2UeZf9o/aRymIbMdYdzLHDzedSKGU
         rizoMu1cnl6AmAuNwJR1wXkDcHR3zQFq8U7a1GTH2EX0gPXl0WP/LENu3phCyOk8HVmV
         YDzWaOaHCVUkKDfqm68LOJoGVMeLNzgKdgb9VNLkPTcm3bcBheWu3wm3szHWk+YP5q6o
         fKJA==
X-Gm-Message-State: AOJu0YzIqftnsEEttGS4R1WnRZdGW2YmCDeKvwY4QNJPMbOuex+8hdYa
	qu4d3/iRt/dhQLw4l7ctiqySag+XRtlVz1dRUT9owX6u/ifgVAbCNmcrBRmJUpl3+fo=
X-Gm-Gg: AZuq6aKuiVrEHQZfdLUJnADvLmJc4rl73nBjzfiTwXAgIoEC91TA+ag35MhYDFMaEVa
	sE8sxndNJ5HWWcX7uKZ4CZUaD7rOEQgNEv6QvDTXu6WAbHfDnGLIHRNgvko8sGNF0hqTCGg3Ew/
	t/h1NRsTT8GBQIOrpybcMeaTO1BQAkQOgwJITBySoIh2fVFD2SFSNE8fBKQ1DKU+4iQWanAscvf
	TMXVPHPSD5Uq9eMvnhRxKhsoFFd6d9RpCH7s5jQWtKZnC2KXEO7KoXd1Il2UilpMwPtZR7mocwS
	82FfjPoPYnAIxdGiSjQEK87AJKcwIcju05eqnEU0VDIgXeJ+nwl4QPn2h054IdmIxRaXtzBIM3D
	dsUWXC1DiW+vqF5VDBYxTzmlJqYkJjQ2RHGJfQyHXAF4WYJZoVizlyLssZV6az3v/xl5Fl+WmnF
	qfUXWDmsAHBCSp/nLQOgKrEAJO7TaKB3c7kzgWnXvig9WCnAETKvwiUtfCVzXkk+AUm2iZ5ZCn+
	dkTwI/eLs2IIQ==
X-Received: by 2002:a05:620a:4801:b0:8c5:2d4c:4f0e with SMTP id af79cd13be357-8c9eb26aabbmr143736485a.25.1769720688060;
        Thu, 29 Jan 2026 13:04:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:47 -0800 (PST)
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
Subject: [PATCH 0/9] cxl: explicit DAX driver selection and hotplug
Date: Thu, 29 Jan 2026 16:04:33 -0500
Message-ID: <20260129210442.3951412-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, CXL regions that create DAX devices have no mechanism to
control select the hotplug online policy for kmem regions at region
creation time. Users must either rely on a build-time default or
manually configure each memory block after hotplug occurs.

Additionally, there is no explicit way to choose between device_dax
and dax_kmem modes at region creation time - regions default to kmem.

This series addresses both issues by:

1. Plumbing an online_type parameter through the memory hotplug path,
   from mm/memory_hotplug through the DAX layer, enabling drivers to
   specify the desired policy (offline, online, online_movable).

2. Adding infrastructure for explicit dax driver selection (kmem vs
   device) when creating CXL DAX regions.

3. Introducing new CXL region drivers that provide a two-stage binding
   process with user-configurable policy between region creation and
   memory hotplug.

The new drivers are:
- cxl_devdax_region: Creates dax_regions that bind to device_dax driver
- cxl_sysram_region: Creates sysram_region devices with hotplug policy
- cxl_dax_kmem_region: Probes sysram_regions to create kmem dax_regions

The sysram_region device exposes an 'online_type' sysfs attribute
allowing users to configure the memory online type before hotplug:

    echo region0 > cxl_sysram_region/bind
    echo online_movable > sysram_region0/online_type
    echo sysram_region0 > cxl_dax_kmem_region/bind

This enables explicit control over both the dax driver mode and the
memory hotplug policy for CXL memory regions.

In the future, with DCD regions, this will also provide a policy step
which dictates how extents will be surfaces and managed (e.g. if the
dc region is bound to the sysram driver, it will surface as system
memory, while the devdax driver will surface extents as new devdax).

Gregory Price (9):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  dax: plumb online_type from dax_kmem creators to hotplug
  drivers/cxl,dax: add dax driver mode selection for dax regions
  cxl/core/region: move pmem region driver logic into pmem_region
  cxl/core/region: move dax region device logic into dax_region.c
  cxl/core: add cxl_devdax_region driver for explicit userland region
    binding
  cxl/core: Add dax_kmem_region and sysram_region drivers
  Documentation/driver-api/cxl: add dax and sysram driver documentation

 Documentation/ABI/testing/sysfs-bus-cxl       |  21 ++
 .../driver-api/cxl/linux/cxl-driver.rst       |  43 +++
 .../driver-api/cxl/linux/dax-driver.rst       |  29 ++
 drivers/cxl/core/Makefile                     |   3 +
 drivers/cxl/core/core.h                       |  11 +
 drivers/cxl/core/dax_region.c                 | 179 ++++++++++
 drivers/cxl/core/pmem_region.c                | 191 +++++++++++
 drivers/cxl/core/port.c                       |   2 +
 drivers/cxl/core/region.c                     | 321 ++----------------
 drivers/cxl/core/sysram_region.c              | 180 ++++++++++
 drivers/cxl/cxl.h                             |  29 ++
 drivers/dax/bus.c                             |   3 +
 drivers/dax/bus.h                             |   7 +-
 drivers/dax/cxl.c                             |   7 +-
 drivers/dax/dax-private.h                     |   2 +
 drivers/dax/hmem/hmem.c                       |   2 +
 drivers/dax/kmem.c                            |  13 +-
 drivers/dax/pmem.c                            |   2 +
 include/linux/dax.h                           |   5 +
 include/linux/memory_hotplug.h                |   3 +
 mm/memory_hotplug.c                           |  95 ++++--
 21 files changed, 826 insertions(+), 322 deletions(-)
 create mode 100644 drivers/cxl/core/dax_region.c
 create mode 100644 drivers/cxl/core/pmem_region.c
 create mode 100644 drivers/cxl/core/sysram_region.c

-- 
2.52.0

