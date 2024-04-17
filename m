Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4217F7
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340263; cv=none; b=qYbNlxiEHfyS8Yen6DyWktxv04k5wg9D/09hpwZbGVXIi3dM/B8z3W1EjSD51wXi9zy4RswaZjrJgLaURN+5ZrbfDOyxe+3SwO5assfpbsyzH8h7GoqLkL/ngMC0eivLl2O8e/VVRNKrSu3VIMO6Czs3gG9Q/EW7gdevt1I6Up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340263; c=relaxed/simple;
	bh=lb9Pxp3Eza7fspbIatLUTROAMiPIxPeq3aIDRxd+Zfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LsoZqs10gHhNvT1VE8pi9zmvggOU1L+AQtt1XlNaI6lPIo7YJZVClmm9oELXkkLg/bFu+8poPmasScOj336oWTCFzMqlIB3jV8beiiM+9Zzolr3FEp1HCX8uK+1CGDVgt6Acjsis1pVkhCTvGRoLqnev4fRGOdYnYlpmp0bG8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o74WZn3M; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o74WZn3M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713340261; x=1744876261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lb9Pxp3Eza7fspbIatLUTROAMiPIxPeq3aIDRxd+Zfc=;
  b=o74WZn3Mro28L3fIHG1WDPKRtLf8hHoKI7UwTzVRhthrDoj47V7/e1Jt
   ORJ3dmzKLCdgKSozj3zJPQsCowxRUqebq/TYHlCEkPwx8I5KZIyreCo0f
   J3nWEq/leeFvy24+CR2YhWLttR3hUWyUuARaSb/w39yZXddmVz4Xe8OfP
   z1ZbZB16L6LE13Y3Bo4Osf9jOdX9OojzBpogFN+roXzqd37Gib6xHxrOd
   uDXAIIkzlj9rJp+NiPL9YppH3y7CZ/FypBLr++NWljspjcIe8iY7gwUWk
   g9la9lQZJVyEuWrzNh9IMfT9lwWgIdoCSnmN7bj6QMnKCBAl8o52cQTfa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="155828447"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; 
   d="scan'208";a="155828447"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:50:58 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 71F6EE4EB9
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A1AE31B869
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2DD1B200026DA
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 577481A000A;
	Wed, 17 Apr 2024 15:50:53 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	alison.schofield@intel.com
Subject: [PATCH v3 0/2] cxl: add poison creation event handler
Date: Wed, 17 Apr 2024 15:50:51 +0800
Message-Id: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.005
X-TMASE-Result: 10--7.175000-10.000000
X-TMASE-MatchedRID: 4r2MyAYFTndlJTodqNqEzpV3j1zTOBYz/OuUJVcMZhvG5dXdQTj2OHG0
	XoqFERcpi70orB5wM5OhvbGMLMgkamULhS/RYteOEVuC0eNRYvL9XDMezlt/vCiJduasmgZhRpc
	31ddH+ShCIvvqgRmgughBeNJICtc+j2hRzH1UwuAURSScn+QSXmVV1G+Ck2l7+gtHj7OwNO35N/
	S1zEq4untHa4+L7o4W99dC03zAok3mnTE/jwuyozlvRXkWmame
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Changes: RFCv2 -> v3:
1. patch1: removed changes for flags
2. changed the main idea of this patchset: not for injection event
     handling, but for creation;
3. removed GET_POISON_LIST command while receiving POISON event;
4. dropped poison report in debugfs;
5. added DER event handler to handle POISON event, in case POISON event is
     sent by DER;
After the above changes, this patchset becomes smaller.  Main code changes
are in patch2, which seems could't be divided smaller.


Currently driver only traces cxl events, poison creation (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison pages in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison creation event handler in OS-First method:
  - Qemu:
    - CXL device reports POISON creation event to OS by MSI by sending
      GMER/DER after injecting a poison record;
  - CXL driver:                                   <--- this patchset
    a. parse the POISON event from GMER/DER;
    b. translate poisoned DPA to HPA (PFN);
    c. enqueue poisoned PFN to memory_failure's work queue;

Shiyang Ruan (2):
  cxl/core: correct length of DPA field masks
  cxl/core: add poison creation event handler

 drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/trace.h  |   2 +-
 drivers/cxl/cxlmem.h      |   8 +--
 include/linux/cxl-event.h |  18 +++++-
 4 files changed, 126 insertions(+), 21 deletions(-)

-- 
2.34.1

