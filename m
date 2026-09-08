Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D61A6822
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835799; cv=none; b=fnWi+8tiw7BKW5jfBnnSaHGEQTFR86Adirr3Gmx7LOG5mjDl1N1Wvh9ocjQFbP13Mmh29fwGL/3AIxXDIK8DBo1bzK+ZzV70djT3wvfLlwIowzVKf3fq4WU798O1cSk3fNO0622g2QEs6nVeUWmXtuSx3191C96OLmUVcnrdddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835799; c=relaxed/simple;
	bh=fbZQTo0ShgS5y2Esy/5sEa5ttyGSVI9woDdGApk69Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuR5WmcggdQvU0KjMMv+yOEQeFLWyTpCMsJ7xPxWnOyoW1XrG6/G9u0sxiBB53EI/cN2R3sfple6Ws9AHYBCl7B2i90NS+WjdIH2KjUufa6d4djP4yZMiS9ACnJPMKo1IfHtyHvoa+eEvbCUjyRHl0BVNip2sbSEq+AKNPVV0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAbJ2b7I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAbJ2b7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788835798; x=1820371798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbZQTo0ShgS5y2Esy/5sEa5ttyGSVI9woDdGApk69Ss=;
  b=VAbJ2b7IJ8k5+girm3C7hThgxxLVrU8H8Y+5NbrZUXSHwd62TDM3tDMV
   b7N0DlcTtowN2Ky/CrRA12RKZxc514kxqlq/WwbUa4uBTw0VAwQeZD1Sx
   rsh2JP0FDwK0fRYIPpVh+6xGzKcDNZe/OLfqtm8jpzDTWyhj60eRU5cKY
   qsjFYHxWxx3vr9veTh8YiwBEYCIsvDy5YyKM1eifCvJWuQurb7/77EI41
   aubI7v5qYzEZAtUp0JSTNYDAcpTN+Jwj2MzRgsqYeNXeJwmMAC5njQUEo
   D5S9jhYiUMPUbecVcAd4SZc6aDXNrdyUEwn0MqqaCjoBufC7Z2LJL5Ogp
   Q==;
X-CSE-ConnectionGUID: yIUvLPeaSBSR6lYu99b2mQ==
X-CSE-MsgGUID: 9czxO3VAQqyxvPM+qvw2Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99888176"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99888176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 19:49:57 -0700
X-CSE-ConnectionGUID: GupaeoblS0uZGdgK3k3mYA==
X-CSE-MsgGUID: GWe+0nneQwCSPGKHVGinGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274999680"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 19:49:53 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	sunilvl@oss.qualcomm.com,
	jic23@kernel.org,
	pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Tue,  8 Sep 2026 10:49:41 +0800
Message-ID: <20260908024941.492366-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093735.2753-1-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Mon,  7 Sep 2026 17:37:27 +0800, Chen Pei wrote:
>   - Collected review tags: Junjie Cao's Reviewed-by/Tested-by on
>     patches 1, 2 and 6.  Michael S. Tsirkin acked the ACPI parts on
>     the v5 cover letter thread.

My tags on 1-6 stand for v6, retested on master 35500e5c41 and on
riscv-to-apply.next b23a62773a. Thanks for the quick turnarounds and
the careful respins throughout.

Alistair, Palmer: no open points from me, and the series touches
nothing under hw/cxl, so there is no dependency on the CXL tree.

Many thanks,
Junjie
