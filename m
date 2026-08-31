Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371093CB57C
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163697; cv=none; b=uLKK8dGn2SUbvl3re4bVXfpw5bTCuKTWvZgsW67Pf/c0qn/fWAbOvPXLPVExLVyy3eeSGI355g+KqNCeRoPlhm/NQy9A+GfOYJxV8789PfvBhK8KSra29zt198yMdwTkrS/Rf/HgA4uwv70zX+q7/Yv0XlDBAuv5epvrCPkhidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163697; c=relaxed/simple;
	bh=U+TiwCVbbYEWUZQNmeou93WTC+YnHEeVvhuQzlTWlms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjPQ6Vrg/o65+2t8qD2e8GDlEa4JTNGQR7l/Y9uO5eAjydTGA2BTA5hNKFbXmMKvPeUXsJ/xlysI4NZvV2C1hbHnWVSLh1IrWRQ04V2U+L9jE3eFZ4a2H5iaNTaJ7E9winziTG2nLSg8g3RRF+ldmhlkpV2bi7xsPQ4RSmtdUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTpjlXFy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTpjlXFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788163695; x=1819699695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+TiwCVbbYEWUZQNmeou93WTC+YnHEeVvhuQzlTWlms=;
  b=ZTpjlXFy/4x4H9s942mdI5dm4PqwBmXBaHZOVzw8+pr0DiGvWhoy3ykp
   b8VlkCtRO0Ej0OJyaxTbKvOlFphbbNw+IE7YJ86qXg2v250t6zyFf/gm5
   UkQ2xXz7079lPpA3N5pPDyWABUfYAnCBGeq5GabMn4EN5RoXTc1f3mk8F
   z+Y15X+nupQd9SHbUYmFNlySxxPkRe3wX5tASiDTODwLjp6SZVuVT07ff
   NPL3ncx8q0TViB04KcCZnF4UQ938aKHpDIblsAuXUMecbd/kRQECetU/m
   LGhbsERdEkYDrSp5CQ3SHkKxhMHb6TNBngIYlxwJcIBZIksoPAArEQ0UI
   A==;
X-CSE-ConnectionGUID: qudTVXLOSC6JhGtEnUlrAQ==
X-CSE-MsgGUID: CG3qN3abTsKlsgZ5R9lcBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88588211"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88588211"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:08:13 -0700
X-CSE-ConnectionGUID: OM/f9X1eSR+ilDUacpFdfg==
X-CSE-MsgGUID: tOgbbR3XRYml6IhTeOZkog==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:08:10 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and convert to three-phase
Date: Mon, 31 Aug 2026 16:08:01 +0800
Message-ID: <20260831080802.410117-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Ping -- still applies clean on master, cxl-test passes.  1/7 and 3/7
have Philippe's R-b.

Adding Michael given your note on Haotian's CDAT fix that a staging
tree is a while off.

Many thanks,
Junjie
