Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E8281530
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158301; cv=none; b=H1CpPbtCCHg6tnV9efL2HWUZwfRmnK2LCE5OXLGIoqlBcyDFFRsJr4jVpIECg6xwbRlMqd94W2QBzT4qUy0g00FWWwJ4wEtydcPhK+GKyzrsMOVhke7NUOEe83Zb2Fc2uoGM3ahi5gmyB4GBGs7mZ6/QF2pXddj01IjuI3jiCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158301; c=relaxed/simple;
	bh=9wlVfmVmE1FZIlAm8hbt7PCWwaL9R9CYrkrpj+LUYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ9+TLIA2gL96bIykQqQfz/FSsdbq7++1sFhiuqnxYbnwJPn5sfSZGCmsyCvrOh0PyyQ8emSiYMevvVQ+ogk4Bp22J1LH3iep8Qg/tJIixTTW0tLqYHOhs6BvrvB/hK63eYM7R9g4erBGIG0s3xghly/hQppz+XXKf6H9khgpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieiaQpZQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieiaQpZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788158299; x=1819694299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9wlVfmVmE1FZIlAm8hbt7PCWwaL9R9CYrkrpj+LUYAQ=;
  b=ieiaQpZQuQi3JxXnuFD1RrUAA83cw4XFnAiMp18EMdEMux5FZqAgW9ob
   wxTIw8juaBKvKCPdm8ZpKrIn7pVkJJNn3B3Dry/7bztyeCRYcg6WCx5t1
   r+oN5qmBTSc3/8w9bWlxGwlHztqC9rV04qwDLh0nFGX2qA3T2OxwSM6kS
   RcSzB8ehZxXPQngcH8bqsBZ0Wpkdaj/vylJ3oC6nhNtzMc5SPGKRWhai5
   pLicZ9TCc4QYlcC2HfuzuV9QubUdAgpg3jNL5m5F5xVFhXeZeqMHTuUy4
   Ytk/AR4XWGd3BJGUL5vC9tzgWsUhp9dbMqI4ucRSmimAhwl94AvG5Locr
   w==;
X-CSE-ConnectionGUID: Q9m9rjqrRA62Db8PJ5YdPg==
X-CSE-MsgGUID: 2I1R4TklRWuqVhMKl6PADA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88578128"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88578128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:38:19 -0700
X-CSE-ConnectionGUID: JUPwQEiNT/mU6WXlM/OV2w==
X-CSE-MsgGUID: Jx1uA8N4ThaLKIpiq0tCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="293521550"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:38:14 -0700
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
Subject: Re: [PATCH v4 5/6] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Mon, 31 Aug 2026 14:38:07 +0800
Message-ID: <20260831063808.409069-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-6-cp0613@linux.alibaba.com>
References: <20260828151317.815-6-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:04 +0800, Chen Pei wrote:
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie
