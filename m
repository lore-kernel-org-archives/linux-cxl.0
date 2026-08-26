Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677963F58C9
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751505; cv=none; b=qwttpYoEZJBtMJuVOmPoYr2BFYTUkrRZEMIc4NrK/g9MS4fd3eGQDaBugTIWqLRF37bT2TxZp9ueis2LgwyFIEJsRHsfNjgJiZgC3so6xfsx68MRGDljFFUSvQluNk19QfqVgdm+2yG640nSI1bok097nF/66CkuTcoY5eLxC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751505; c=relaxed/simple;
	bh=IsA8DjF0vXOGSyrTm6RVyG1i2dRPzlY7XZ4uNzXBxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XByG/F6dJNAcriq/rq7zG1XubCMpQzhLxTfpIw+fNr8XlgpEbsyenDeRQkcDxuvKroFttOUP5AUQCMG8jAppiheCHiKg9Y+IOZb1xnc1MVjAtEU2kZMQfpQIG1dV3tf8cGhwrvseANoYC4x58CojNcvRtEpMO8/oIdTLnLz7+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsJ3wVJH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsJ3wVJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751504; x=1819287504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IsA8DjF0vXOGSyrTm6RVyG1i2dRPzlY7XZ4uNzXBxUY=;
  b=LsJ3wVJHe3AOe8TLlfGjVDDR0S1sid+zEjoUTjRjUA0QgkcFpu5q/Q6r
   7qUQnfXKcS2F8db0B8f7jDjE1R/w43luMVTPhOpdLeCvXXUmPVmXuk2ng
   Iu27tEAczl/jUqZSvbuanZMVZ+oZe7XBezP1/xdkF/cuhRVwOfjrwMwvK
   88+0sD2WaAJECBOqlooqpb66BkNFSiOZnzmTtcwe+3mubUs3bPf+YGPcD
   IC83rpCKw7j45Qo2q4LqS5UX+dvHwn/w6ZE2cPE758nBVzPAzdyylrgb/
   ER8EX2fVOURi33UMzxI67yO6bd+yrAGo0mMeg8L/sR8gsi9oPfKdVeGdG
   g==;
X-CSE-ConnectionGUID: 8ShFU/goTO+xbECO77QGPg==
X-CSE-MsgGUID: KOXcPDgjRI+3OkbAASIVGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="111016850"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="111016850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:38:24 -0700
X-CSE-ConnectionGUID: yaiuLxGgT5qS8SBy6zuzdA==
X-CSE-MsgGUID: Ie2kZ+SyR4WsekNMi0TBAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="263821967"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:38:19 -0700
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
Subject: Re: [PATCH 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Wed, 26 Aug 2026 21:38:10 +0800
Message-ID: <20260826133812.355470-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-5-cp0613@linux.alibaba.com>
References: <20260821081954.1171-5-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 21 Aug 2026 16:19:54 +0800, Chen Pei wrote:
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++

checkpatch errors on this one: expected files added together with
tests. The flow at the top of bios-tables-test.c wants the new files
added empty and listed in bios-tables-test-allowed-diff.h first, then
the test, then the AML and the emptied allowed-diff in a final patch.
The riscv64 goldens went in that way originally (cc3ba2422554).
Alistair's Acked-by would need re-applying to whichever patch ends up
holding the test code.

Worth settling 3/4 first -- if the _CRS ends up coming from firmware
enumeration, the DSDT here changes anyway.

Many thanks,
Junjie
