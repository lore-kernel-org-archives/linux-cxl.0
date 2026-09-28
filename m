Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABB47D445
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589421; cv=none; b=DoCsfrUSWsFeUwA0/acgg+iYog0S2wr/ApTA1FZeaplBFHyIRgusKqU3WJYmNz0+f5zN39CApjo5mhWT7V8mRHo+Gutw1RrvSPIA99FyYNur35yhcTUl78708qMmeSVJuq7CYOGx1yXAHKYU/iyoYWOB5PNgVaf/FzP+W1toqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589421; c=relaxed/simple;
	bh=wMRZi85OyAcXwHR1uDCHWH/0Cj2JhYTCl5I8U7FnIjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM5hHpDn8A7ZnI05GhGVe5v41Lf5wT7ruiAR+e0oSyRcBFH/HxWzimwb3kdRZWQBnazoRNWOjAU6e1lgmzjB34qsMdv2Wn6xB2e9DF0xXMxe8TadYvjd1dBxtlfWKhpOWxDaYLquac7yps1hNzibhJa1kmNLASc2cz7vFnjMs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JN0Kffts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN0Kffts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790589419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tVuCFNF/H30yzbtZqEPG9Njc0+ZOaYVy5PjtguTs70=;
	b=JN0KfftsP5rZRm1uCXsnC9QscaHSyRDAtW2ontLR1AkpuNri0wij+sCUYTjcOnJMaX6t+u
	Bsfkia06L5/uIScYwTCorS8MdeUYOUSgCE0dUGy93LQq/KG8ENThnt1UEOGhwbvnviNQxs
	UlS7IqwCNLdepWc03g9D9gVBei6J/d0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-pqnv6E6YONKDnLyjTcF4Xg-1; Mon,
 28 Sep 2026 05:56:56 -0400
X-MC-Unique: pqnv6E6YONKDnLyjTcF4Xg-1
X-Mimecast-MFC-AGG-ID: pqnv6E6YONKDnLyjTcF4Xg_1790589414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8836419352EF;
	Mon, 28 Sep 2026 09:56:54 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECE681956089;
	Mon, 28 Sep 2026 09:56:51 +0000 (UTC)
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
Subject: [PATCH v2 1/2] hw/arm: remove pci-bridge/pci_expander_bridge.h from virt.c
Date: Mon, 28 Sep 2026 10:56:45 +0100
Message-ID: <20260928095646.3555447-2-berrange@redhat.com>
In-Reply-To: <20260928095646.3555447-1-berrange@redhat.com>
References: <20260928095646.3555447-1-berrange@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: G-81zgQQ-CzyxbXBJrNR_jkPoRwsvRfV_q3nzviPips_1790589414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This include is redundant as the function is declares is not
referenced.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..a570832fc0e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -58,7 +58,6 @@
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/core/platform-bus.h"
-- 
2.55.0

