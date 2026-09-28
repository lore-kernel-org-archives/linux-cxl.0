Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141C47C114
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589419; cv=none; b=EXdxpzQLO6WZAbEf5EWVURwMQxhlHCOieuFi1ihAVE1hFNiMdi+hNRLUdPjIJinGcl+oeJ/lZG2jPwapcR7y6+9UPoE8SfkwpUE1Xx0XOJAfhR2a6qqqhw2z1hhdhpBMV+PN/W+02c+4haxxuwRxjN4t086KlxlYKqVRHRy+sNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589419; c=relaxed/simple;
	bh=iL/67UircthEb/8jp6pmh14QqHLTa7e6U6Dg5DRJ0do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HIwjfBXLKIjO/CJwVjKdLonWtlufYvba3XBReRZlXFHLBcCLvTPQmuNZJqNwAMnUkjLm0s+dMBxMkzQTIz7ob5D5qPYwXf7hn/rL7wHi1IcwJDSCWJ4BqJN1fXSSGq2o5X0dWH9VUzcd2TvlL5kDABtG5SRKXa2tJ7tqEzbR2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqikDng6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqikDng6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790589416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SyaoOkFS4MJNj6jdg6gYWUmMLqLitNVLsMRzoDN+SEk=;
	b=hqikDng6WiEdbtlxNus/Jisxkx/T9JpR6nH+GUR8+uZLit1ANj0hmmpWPcS2P7FYqvBRkh
	t7sFd5N32yQQg+a6ZA7fL4dSnPe8L3qV91Kr113Wmzfe8VDyGZ7H46fg11+D52rHeJZ2hO
	CSxozNHlfF33AvrawBAHlX315JUkiTM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ERl78TZGO2mQy1IGVDWoVg-1; Mon,
 28 Sep 2026 05:56:53 -0400
X-MC-Unique: ERl78TZGO2mQy1IGVDWoVg-1
X-Mimecast-MFC-AGG-ID: ERl78TZGO2mQy1IGVDWoVg_1790589412
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70114182A102;
	Mon, 28 Sep 2026 09:56:51 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72AA51956087;
	Mon, 28 Sep 2026 09:56:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	qemu-arm@nongnu.org,
	Junjie Cao <junjie.cao@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/2] hw/pci-bridge: fix build with CONFIG_CXL disabled
Date: Mon, 28 Sep 2026 10:56:44 +0100
Message-ID: <20260928095646.3555447-1-berrange@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ZhJqcatixk2q7uFBVX10B-2W9b2u0x-Eb1UVn7qO0oQ_1790589412
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

See patch 2 for the details

Changed in v2:

 * Instead of using CONFIG_CXL in pci_expander_bridge.c
   split the file in two and conditionalize in meson.build

Daniel P. Berrangé (2):
  hw/arm: remove pci-bridge/pci_expander_bridge.h from virt.c
  hw/pci-bridge: split CXL PXB into separate file

 hw/arm/virt.c                                 |   1 -
 hw/cxl/cxl-host.c                             |   2 +-
 hw/pci-bridge/meson.build                     |   4 +-
 hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
 hw/pci-bridge/pci_expander_bridge_common.h    |  29 +++
 hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
 ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
 8 files changed, 242 insertions(+), 203 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
 create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
 delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
 rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)

-- 
2.55.0

