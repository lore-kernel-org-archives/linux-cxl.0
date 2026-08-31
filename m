Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD93C988E
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207847; cv=none; b=JfXKgA6kFDKZcg6jG1MRynVAKDxrcoXhwM8b8cTHCEffWPSCm9Cy0kW6QeNgnIeJtV2m+XaPVJpcgaCXwA9C0Mg3VEzDHy5PS3Lon0+aVewu8Ax8ct+rPuFvn8AsBXUUJ/8FbYfNnEYoxkPOwhkfS6ttY8jT9AHl2NeCZXDdYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207847; c=relaxed/simple;
	bh=jvgQS4PVFb8aK57JgCpGhGHkia2GHDSegcR2wtnPSUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLtzO5zqrQB/1Uz8lsrZcCQQJCO5C+LdG7iiQck11HrKexgOvbWdNN0sMW9YuGzfEr4FNxPDBYcoCbp5FB+y+Yk1paA1wfML5RJ3gaU/mJfT2dwT9O5JsjZR7ydUCr3jTjL6Nkdd9H5dqIy3ffXsB9RSxHW1oolb9qaas/pV0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBPjW1wg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBPjW1wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4l91jyPAAO7hilD1RJ8+HNLPzBoV65DoCBpgH8pqK0g=;
	b=VBPjW1wgzSyvCbMQ+anvOCjqtrUl/akarkd2xXoxHa9hm5moG+pkq3mWOxhwaIxVGi+Xsz
	HNslI43XezUa3ADuPtvAAkN0SIGN1YxLf7kmrkTjMMDU1/ns2gxvAz1MBI0c9II5iqDB/X
	BYts6oPtFlmeyWXfdu+2J3UEdXT0TtU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41--Cv9VqWIOBa22A9uM2LAFg-1; Mon,
 31 Aug 2026 16:23:55 -0400
X-MC-Unique: -Cv9VqWIOBa22A9uM2LAFg-1
X-Mimecast-MFC-AGG-ID: -Cv9VqWIOBa22A9uM2LAFg_1788207832
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76CFC1921ECF;
	Mon, 31 Aug 2026 20:23:52 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 460EC18005AC;
	Mon, 31 Aug 2026 20:23:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 25/43] qapi: convert trivial intro sections for pci.json
Date: Mon, 31 Aug 2026 16:19:27 -0400
Message-ID: <20260831201945.287730-26-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 2EyGcHMr304zepBiHPOOzzx2vVdwttPigCGzBY_s8rk_1788207832
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qapi/pci.json | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 694c741e420..a6a79f91afc 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -13,8 +13,7 @@
 
 ##
 # @PciMemoryRange:
-#
-# A PCI device memory region
+#     A PCI device memory region
 #
 # @base: the starting address (guest physical)
 #
@@ -26,8 +25,7 @@
 
 ##
 # @PciMemoryRegion:
-#
-# Information about a PCI device I/O region.
+#     Information about a PCI device I/O region.
 #
 # @bar: the index of the Base Address Register for this region
 #
@@ -51,8 +49,7 @@
 
 ##
 # @PciBusInfo:
-#
-# Information about a bus of a PCI Bridge device
+#     Information about a bus of a PCI Bridge device
 #
 # @number: primary bus interface number.  This should be the number of
 #     the bus the device resides on.
@@ -80,8 +77,7 @@
 
 ##
 # @PciBridgeInfo:
-#
-# Information about a PCI Bridge device
+#     Information about a PCI Bridge device
 #
 # @bus: information about the bus the device resides on
 #
@@ -94,8 +90,7 @@
 
 ##
 # @PciDeviceClass:
-#
-# Information about the Class of a PCI device
+#     Information about the Class of a PCI device
 #
 # @desc: a string description of the device's class (not stable, and
 #     should only be treated as informational)
@@ -109,8 +104,7 @@
 
 ##
 # @PciDeviceId:
-#
-# Information about the Id of a PCI device
+#     Information about the Id of a PCI device
 #
 # @device: the PCI device id
 #
@@ -128,8 +122,7 @@
 
 ##
 # @PciDeviceInfo:
-#
-# Information about a PCI device
+#     Information about a PCI device
 #
 # @bus: the bus number of the device
 #
@@ -161,8 +154,7 @@
 
 ##
 # @PciInfo:
-#
-# Information about a PCI bus
+#     Information about a PCI bus
 #
 # @bus: the bus index
 #
@@ -174,8 +166,7 @@
 
 ##
 # @query-pci:
-#
-# Return information about the PCI bus topology of the guest.
+#     Return information about the PCI bus topology of the guest.
 #
 # Returns: a list of info for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
-- 
2.55.0

