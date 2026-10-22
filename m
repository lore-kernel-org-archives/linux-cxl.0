Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698979;
	b=li3gofzv5tKSLAUER4jU62se6n9Rbdc0gL0W3Kuec6zMiikuDABsmOF1VjUaA5dxePaE
	 1LvPJWF+E32WqLMjmozvDqMpoAGrD1XEw8MK8yNkV7yB4EmaCAm0tz6xGe/whg4ZNRzk8
	 qlLpcs2MkD2rqF+VVwvK12tOQrlWqxxPNUZGDX+Es5J06HjJabzr/F97zGSkuUJPCfadX
	 O+TxtRU+tnzMd+7bcOO6sNdduHU6l7c9ZddldxxMSyoTjoTm9WfWf+umyzFpig5D80NHT
	 4uWb++iaP5u4fckSxZsgUE40o3vedXysB+AXl0pPCTtqPktuUlCAwD0IjYi0wNHZ8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698979;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bW6SGBruZCR3lFoCKUPNNZpeN8t8YpoHhwwB5NNIjhs=;
	b=BUZCSoB+erW1HzIlueA27rXAjJkfVEkljSiYZWTtEF0qIIeglgMXWjnSS6AC+VQrXJHh
	 o9XVdtty42tcGmYyvc1xDx4/1/RYpCPSmmBLEVSa1JMw7tsW9lo2nJ2x6rN1sT3kXwPIi
	 JBkbyLMpCqKws02vW0m2asA8/KoC7OQhFsQsjh64vYHlhnPzKJkNxp2DVEmb6aKYugWJG
	 QeQoX1hGFqtpRg8B8J+UKO0sYZTvl3y+x9lt25zaQTE5wAeppZzkTRoscdwqsLIp7DfgZ
	 AjS6QH0tjEfqYYEKeYqVxk/ROzDVnLLlpBdkjG4m1n5bbOU9yLAk178FvI/c/o5q+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TZOU62HL;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72685606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 19:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72685606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TZOU62HL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792698978; x=1824234978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sdyfwvYhwGJHYoTfgHwcBcmcI6nG4IM8o6FRNG/rcMM=;
  b=TZOU62HLq9Jo0uMzXI/kXV2MEIhdvk6Jo6TotrHHg1ETv4ehMt3lkTA6
   +bkHT+Xoi9trD5NeMXFke2l4JOpVkpiw4WuTklH0DXtG+wwEmA42okivQ
   mlmMHhf0ZuOGSu6Gw1Z42l4L5IuU8KEwQLuo+OLtTyNKD3bEQsXtBCx9U
   UzcaSreKwDM6JjhtdUhI0S/duuKh0z/K3/25Drw/yBr/Zzk4Q+I1YURdr
   23Z6KADJz0anXbGyM/coYZo7oe+8CUswaMlntIJM34o8fTEv9hAgqSgdD
   FcxwXvgvaX0fqclvZmnlfSXOaLoKkDmAJCI8nd/jj3vnkXZZQ4jpyvQCu
   Q==;
X-CSE-ConnectionGUID: IO2KXkllS7uwjOMDrUhLFw==
X-CSE-MsgGUID: bGx5zkKcRDyxln1MLgDYaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1356726"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1356726"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:17 -0700
X-CSE-ConnectionGUID: RtEBkGuwQteLk9RTCQkSlw==
X-CSE-MsgGUID: TNYT9jjmSvS/Sk5HNZ3ZTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3839565"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 12:56:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 0/4] libdaxctl: Fix multi-range memory block handling
Date: Thu, 22 Oct 2026 12:56:09 -0700
Message-ID: <cover.1792695259.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Gregory: Hoping you can help w reviews here ]

Review and testing of Gregory's dax kmem atomic whole-device hotplug
series[1] exposed an existing libdaxctl bug when handling DAX devices with
multiple physical address ranges.

libdaxctl identifies a device's memory blocks using a single contiguous
address window, even when the device has separate ranges with gaps between
them. This can exclude blocks belonging to the device and include blocks
belonging to another device in the gaps. As a result, daxctl can report
incorrect memory block counts and potentially online or offline another
device's memory.

Patches 1-2 address mapping reliability issues discovered while fixing
the memory block ownership checks.

Patch 3 corrects the memory block ownership checks.

Patch 4 adds regression coverage using a two-range DAX device.

[1] https://lore.kernel.org/linux-cxl/20261016214248.443247-1-gourry@gourry.net/

Alison Schofield (4):
  libdaxctl: handle mapping initialization failures
  libdaxctl: tie mapping cache lifetime to the device
  libdaxctl: match memory blocks against each dax device mapping
  test/daxctl-create.sh: count memory blocks across dax mappings

 daxctl/lib/libdaxctl.c | 93 ++++++++++++++++++++++++++++++++++--------
 test/daxctl-create.sh  | 58 ++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 16 deletions(-)

-- 
2.37.3

