Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1237646E
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158280; cv=none; b=MLDMRWR69LMcfUr0ou9h7NWERDNxLx29g6GrOclmNW9YP/Swbx9ddipwHV/Id7s/FWvZG4C1NNOyS+SlIeNaGlmGcxEzRWwEsRVMNbSWvly/jgjvsoCzT65EDDMGwckwIWjPtnKPLHFA0hUZdK+8BKTqDwQM+27Rb8Sakp4LGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158280; c=relaxed/simple;
	bh=vo/XQf+M5yJhZppndfhOXW182R1VefSU2/G8yHNnK5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6ISSIJQkNc4KxiwQNt6ss8vilEC314S3QMV5cxReC8Ni+zQSFiYgrZVKbur1cS+zig5knxxVz9O5wC3SEBz3d2B/iZHrOc5yQ5idWTNs71dGzX8sb6kbSAb1TpotJVcsOwUY4layX/MBySzCyjUTDiEzf8KNuNKVosDe3QiYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTHslXK2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTHslXK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788158279; x=1819694279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vo/XQf+M5yJhZppndfhOXW182R1VefSU2/G8yHNnK5M=;
  b=iTHslXK20Vr6xBLIMSzjiTEdlpG3O/k4hgqJQ0wWu1AlNyqvJiuNpV4O
   npukk8Owe9+ykcCA/TkQ1HYrg89EW26xRIYdG2MElmG8WuABQy7sVB2dr
   ppp3HTh+bAP400MWSHPQx5ki1RL/IJnHujvY1kq2iJyog6WyyqYbKFH1U
   yMKsLG9YmAQ8M0DhbIFLi1Z4EiHpSlU7NDk3GNgyhJ+Lk1GcHp+ICxg/i
   IJN/AGgaxDCveFa3LfggmiLwoebj79zEb4+OrDua/9DtmsA9Ut0liM1ko
   yM95GI3ScKC2yr1NEm85F6wF9AGR0pMcqApzhMjY+agiL9nhGFQOHn1OU
   Q==;
X-CSE-ConnectionGUID: ZNOKiM6xQuOILPzEK0s7yQ==
X-CSE-MsgGUID: m2GanLB3RyGz4kDOnSSK7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88578061"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88578061"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:37:58 -0700
X-CSE-ConnectionGUID: uGF+0WdUSdyku6Wx3xz3Dw==
X-CSE-MsgGUID: ahmy2BwDSkG7fQxW2HI2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="293521469"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:37:53 -0700
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
Subject: Re: [PATCH v4 4/6] tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
Date: Mon, 31 Aug 2026 14:37:46 +0800
Message-ID: <20260831063747.409053-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-5-cp0613@linux.alibaba.com>
References: <20260828151317.815-5-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:03 +0800, Chen Pei wrote:
> Add empty DSDT.cxl and CEDT.cxl golden files and list them in
> bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
> bios-tables test added in the following patch.  The populated golden
> master binaries are committed separately in a final patch, following
> the bios-tables-test update process.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie
