Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BF280A52
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821348; cv=none; b=Uz0sJ7hxabYzZhSjaFaAeAjXHFjyhePcx06ZT2El/mRgWKiH2+UUtxgRUHUINIZrJUOVkSAaDdcvw/0fe8YidzYhVJ+hkob879+R5S9JHozYyrNozQHAejk9W274unt42BYbFwp8avTeTvLY9nG8sBbNGyL/DWPokAywPd+cQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821348; c=relaxed/simple;
	bh=LCx2YPw5gK3mu3hZUWVFDc8GquQ8g+0DLB06jHHMjTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zb4yqao2F/fDD8V/t5IgIj3AUHuJrTm2vHaWEYdlSfb1fuGC66TQP/G6GHVdZ13nNsWoASS0S6lvaxdCTSm9NptiyTlblSbIqzEP88D33siCSDZWi6hlWs5n2aU3U9RMhLGq+xuSsgmNF4G9kt+YLoBhd+FBLSExvnaeFukDOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvntT62xzzHnH8j;
	Mon, 19 Jan 2026 19:15:13 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F28040539;
	Mon, 19 Jan 2026 19:15:43 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 11:15:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
Date: Mon, 19 Jan 2026 11:15:37 +0000
Message-ID: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Chances since v3:
https://lore.kernel.org/qemu-devel/20260114142713.617806-1-Jonathan.Cameron@huawei.com/
Update references in the documentation for related commands as well as the
structures. (Markus)

Changes since v2:
https://lore.kernel.org/all/20260102151512.460766-1-Jonathan.Cameron@huawei.com/
Thanks to Markus Armbruster.
- Expand LD acronym.  Given the spec definition is acronyms soup, just
  expand to Logical Device and let people go enjoy the specification if
  they want to know what that actually means!
- Update spec references elsewhere in the qapi commands and data types
  so they all refer to r3.2 rather than just the new bits.

v2: Cover letter,

Hi Michael,

This is a rebase/resend of:
https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
which I think slipped through the cracks for 10.2.

Original cover letter:

This is the 1st CXL set that I think is ready for upstream.
They are lightly tweaked and rebased from the first part of:
https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
[PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features

I've split that series up as the two parts were only slightly connected.

The initial rework was a request from Markus from an earlier version.

Shiju Jose (5):

Shiju Jose (5):
  qapi: cxl: Refactor CXL event injection for common commands arguments
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record

 qapi/cxl.json               | 180 ++++++++++++++++++++++++++----------
 include/hw/cxl/cxl_device.h |   7 +-
 include/hw/cxl/cxl_events.h |  38 ++++++--
 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  |   3 +-
 hw/mem/cxl_type3.c          | 163 ++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  41 +++++++-
 7 files changed, 362 insertions(+), 73 deletions(-)

-- 
2.48.1

