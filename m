Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B31EB5E9;
	Tue,  4 Mar 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062940; cv=none; b=e9r+yBgQd0Kp2yz1BG3+X9GTLjjG6Dk9HUBQ/1Mwp+Xh7ZeDIcC3Z/kOeY364uLLbMjNHpfY3ws1NWkLRXEEH1T2LGoLRlhOLO8fqmSjiRWgMYDhYeuezMJJ/4p0FVNTTE9F9Xbdbe5ahYivPxOZ9Xo6RlloYDk/PJUVza7GtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062940; c=relaxed/simple;
	bh=gYBY0hZtBx51WKtIGPm5uQcaBCRVh+AkWb1F+ZYyODA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mE9+swKztZ3SjbvARDyYX3+lXhXlfx2cZ0z+LfibtoyO+zoICBN9VMsmsIZdIv8uiI5qORw622dpIfuOX39hfOfBMvnkX3Cs3UjPARgHg7wgF9j0DeErwTdYpvTC1PYy+qn3wSljxJ4iCKJ9wqzSGGLwZL2GHbJCDxaAcC4u/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XEh47JHX; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XEh47JHX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741062939; x=1772598939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gYBY0hZtBx51WKtIGPm5uQcaBCRVh+AkWb1F+ZYyODA=;
  b=XEh47JHXWRJ1nDSsHZXJNlbcjeMF6ctRWz8OctU9rmmwFn+HEY/qbaX8
   0QWWWfnlKWs0SxPJugL8mQm2nWJ+S/vectAY9twSjE2fGk2XYf3zOwC3X
   DMQVWR8nSrFU6ZpnqdFfxmVFd2//8kT2T289bDxXoWo8oLicNGYfsVbaI
   zT5Bx9FyfxX+yHIrcauXzxoK2RQGyNa62e/vjptNZ+vR0HloG3yitfaPv
   9P8E3zH+6zLnjIoD/gjshLcNgjlA/1nxHuIXby3nsw0Z2s4QYnAsXZ5rJ
   fm8EiJYWQzBHHUm4qoiZsplTVrsBdgkhiSPgC3K7WJq4nnLTmftfrK1Mi
   Q==;
X-CSE-ConnectionGUID: fYK0OVvVT/morF69C1S9ig==
X-CSE-MsgGUID: 04GlfqwwTguLRzxRtnbyNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="191879144"
X-IronPort-AV: E=Sophos;i="6.13,331,1732546800"; 
   d="scan'208";a="191879144"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:34:26 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 77A9DD480D;
	Tue,  4 Mar 2025 13:34:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 38407D4BC8;
	Tue,  4 Mar 2025 13:34:24 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 79C301A0078;
	Tue,  4 Mar 2025 12:34:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	ilpo.jarvinen@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] resource: Fix resource leak in get_free_mem_region()
Date: Tue,  4 Mar 2025 12:34:15 +0800
Message-Id: <20250304043415.610286-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leak is detected by the kernel memory leak detector (`kmemleak`)
following a `cxl create-region` failure:

 cxl_acpi ACPI0017:00: decoder0.0: created region2
 cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
 kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

    __kmalloc_cache_noprof+0x28c/0x350
    get_free_mem_region+0x45/0x380
    alloc_free_mem_region+0x1d/0x30
    size_store+0x180/0x290 [cxl_core]
    kernfs_fop_write_iter+0x13f/0x1e0
    vfs_write+0x37c/0x540
    ksys_write+0x68/0xe0
    do_syscall_64+0x6e/0x190
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kernel/resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 12004452d999..aa0b1da143eb 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -2000,6 +2000,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
 		devres_free(dr);
 	} else if (dev)
 		devm_release_action(dev, remove_free_mem_region, res);
+	else
+		free_resource(res);
 
 	return ERR_PTR(-ERANGE);
 }
-- 
2.47.0

