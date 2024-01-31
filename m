Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A939AC3
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738377; cv=none; b=a8bF9LLCJuNCRVhu1k8dhgionciEqBYzxxZp4+P5P2Mqq1vln6KkcNbZeVb6YkIUB5sD2cGoO0SapnZNAvv86HRNc03FH0E5dywkSbrwNdozoeRukHbJYSM48MHI89TfisyfFvXg31sZ3IwcjcUBppxlcFoo9L0DMy2gdB7l1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738377; c=relaxed/simple;
	bh=PlIygDufGVDbOJQf1cZGTnC3xjljI5YHG3IezaqiwQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e55Yrdeb50x0eoq62iHqthn1CQap2AxAio8I3527YZmBtU6hCkmlzSEx62HjTKFq6i/94rNqy3JCsGE3gTz6ct7oH2wq1osKPFfMYS6kX0Ydg1b55IuOD7T17y2k/tVY3yftggG67dTvbK//mn0CPrQcEIxjmI/KEpCYBIyFRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsahX5Ou; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsahX5Ou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706738376; x=1738274376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PlIygDufGVDbOJQf1cZGTnC3xjljI5YHG3IezaqiwQA=;
  b=dsahX5OultqvF7xRzzoP0udqUF0KEKriPGVQ1qytQE5pxLlnevqSsm2u
   +w0S1W4MPOolZUKKZzHJoNQH51QEhotZdlf1wCqlekuiTCse7q7LRT/fm
   OaVHvbVTK5Gw2igYKs++MSMYbTukGm0GDPdetj32ckQe+OcPzXizszzQ8
   fZvIBByQMZHrbnboDhFEjMvlg0KheCzIWvbaBpuzmAaBmBNpj4ZYgeSGC
   7/k25l/lZuo2rwceiIXpKfNfcvW0VB09LpAVBxa3KLLpBF/jg/msj+7b3
   Qo8NtIxcyUCMSMMsKBjhpd/t1QRq4EUeFpJqywhFzbXmaDwtGVrf0TIzh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2675440"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="2675440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:59:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931989690"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="931989690"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.39.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:59:33 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: [PATCH v3 0/2] Allow out of order auto-region assembly
Date: Wed, 31 Jan 2024 13:59:29 -0800
Message-Id: <cover.1706736863.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add a precursor tidy-up patch to existing Patch 2.


Alison Schofield (2):
  cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
  cxl/region: Allow out of order assembly of autodiscovered regions

 drivers/cxl/core/region.c | 62 +++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.37.3

