Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDD15B984
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468364; cv=none; b=u/6hybH0Bc9UZ9+GMkQxJtjX0WM05oUMEUkDopAk3jY+T7ftUmFWrZBY5NG3q9wKRr4mLNyWzW1BVCZS8K69MFFDdIVWqnRbOXrdDJ2ANHqT7VqCkgZciHEBnlkr9jmm3b/SP9stQ5caUcFp6XUB3CGK21dDdI6GAcOUq//yheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468364; c=relaxed/simple;
	bh=oFNjEDFz+AbNiKC+T2rhrSpRdo02v9bUsXqfLIUPcHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EL0qgO2uSCjIE/Zx/3oayB9Of27tY0ZCbIGqDMGO1Y7HF+HJN0jWJbN14eS+ishhwDrJiGSWN6e0yMyV/6WOt52txOBuYP0nCJ3R7CiusngeWhF1kzzWEmPMdk9iJJelXFpm//oVKWHAms0i2/rMQDPt85z94s4cbEZ1xlv7xGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg22l4pr4z6K6Tt;
	Fri,  1 Nov 2024 21:36:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 38AFB140A36;
	Fri,  1 Nov 2024 21:39:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:39:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 00/10] hw/cxl: Mailbox input parser hardening against invalid input.
Date: Fri, 1 Nov 2024 13:39:07 +0000
Message-ID: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

The CXL device mailbox has some variable sized input commands. The payload
length for each must be established using command especific structures.

If user space is either buggy or malicious, it may use size fields to
indicate fields beyond the end of the payload sent.  Some checks on this
were missing and Esifiel picked up on this.  I've tagged all these fixes
with Esifiel's Reported-by as either they were in the report or are similar
issues in other commands.

These can mostly be easily tested by using the raw mailbox commands option
in Linux and injecting broken commands from user space.

A typical command needs to first check that there is enough data to get to
the command specific sizing fields, then check the reported size is less
than or equal to the available payload.

Note that I think it very unlikely anyone is currently using CXL emulation
with a VM that they do not trust, but that may happen in future so good to
fix these paths now.

Jonathan Cameron (10):
  hw/cxl: Check size of input data to dynamic capacity mailbox commands
  hw/cxl: Check input includes at least the header in
    cmd_features_set_feature()
  hw/cxl: Check input length is large enough in
    cmd_events_clear_records()
  hw/cxl: Check enough data in cmd_firmware_update_transfer()
  hw/cxl: Check the length of data requested fits in get_log()
  hw/cxl: Avoid accesses beyond the end of cel_log.
  hw/cxl: Ensuring enough data to read parameters in
    cmd_tunnel_management_cmd()
  hw/cxl: Check that writes do not go beyond end of target attributes
  hw/cxl: Ensure there is enough data for the header in
    cmd_ccls_set_lsa()
  hw/cxl: Ensure there is enough data to read the input header in
    cmd_get_physical_port_state()

 hw/cxl/cxl-mailbox-utils.c | 73 ++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

-- 
2.43.0

