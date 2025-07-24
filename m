Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586223BF8F;
	Thu, 24 Jul 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753397109; cv=none; b=hlPM67ylsTrqbV2WgOmgYaU+6nzU4EY4XJ/DjU/sZrcxwHnybqz6CbxakRVFK3I4QBjQmb35U8pIyx4H5m0703kUj8O5WspebBcWXKxDURzE98WGMgXmY0opW9/zVO42CUETqv76+AbQpcB03vLfBEGcFJ49UcE8V7N3/2f0VUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753397109; c=relaxed/simple;
	bh=UPyEyfmQhsoOkySS+eZv7T3VhkFbdKNZiYgu5hIT510=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yh0lw/R3P5GmWnsbo+C9UJmsYESkmXzIytJ2qGsFF3vxPHMDca9XRPPMycrm0129/Y4I8CSsIexLJhcT/0o93yRqcbLf9RM4YtS/i7gztRm81Q5FqKnjU4zN5nwXMajot/mJBXIVi0LP+eXOfQdiSc25l+/v15J9ou/5QEuYwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftEICtu9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftEICtu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753397108; x=1784933108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UPyEyfmQhsoOkySS+eZv7T3VhkFbdKNZiYgu5hIT510=;
  b=ftEICtu9KnxRCma1dyVsxIUAOdsQN7RAtC1E31SXah83hmzA46BSK64M
   gDkCp1WJl+2bLAh6kzSgAJpv34gcrUo4t1nnzm++NKZHjynCdcDs42t3q
   Do008P/Wo2L9zyDXBVkYjNlGOOFiXhAwPNTVU+kHUC8Wwgytx0GQv/7YV
   7d4iJjTNB1WH7CGxY/Mt7SAe7yv+Dm4T4+gj+53+TR1fBzF/8zMP+8PId
   1kCUh/NeEANtr6v4gNul3e5dysqJuuJ+hGFPEEjS+xGkzoKkbCZSMTfTP
   hFUvgdgQJ+c5YbSqtWMoxEcEx/DCBEFsoMCx3NwVXZhqVKwkdoPLR7N6v
   A==;
X-CSE-ConnectionGUID: dmx/5vxSTWOZceHQX+RKXA==
X-CSE-MsgGUID: 7R42xs3ORUy2crFyhWGqOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73191757"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="73191757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:45:08 -0700
X-CSE-ConnectionGUID: /IYa0lWpTm+FadVm/WNq+A==
X-CSE-MsgGUID: E/PwLkcTQxu52/wVOUh6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160820277"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.202])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:45:06 -0700
From: alison.schofield@intel.com
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH] Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to clear_poison path
Date: Thu, 24 Jul 2025 15:43:06 -0700
Message-ID: <20250724224308.2101255-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

'cxl' is missing from the path to the clear_poison attribute. Add it.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index 12488c14be64..e95e21f131e9 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -20,7 +20,7 @@ Description:
 		visible for devices supporting the capability.
 
 
-What:		/sys/kernel/debug/memX/clear_poison
+What:		/sys/kernel/debug/cxl/memX/clear_poison
 Date:		April, 2023
 KernelVersion:	v6.4
 Contact:	linux-cxl@vger.kernel.org

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.37.3

