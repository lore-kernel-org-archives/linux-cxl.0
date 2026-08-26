Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6734D38B
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773378; cv=none; b=htjdA8wNkn5Ftp8WoPbSLrXPOE70+TSloNHVK18MIHLoTtRpaoj4UHXyvk6nLVMIzEZr4WL1MpXcos2U5mIhBtn8pb6eKoDUSRQMuTonXYsh+w+aPmkl4HKSYjirakKxRyou/+iDCKQ6iehQ8J+7mvZ01gWt3hf0HEgQVbx/T1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773378; c=relaxed/simple;
	bh=3ARsbG/8ACgUcXakontHsggfzrB5pdrrmMuLP8GjJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JuTamkXTj1X3EYRhb83JvGaXKFVdtSHIhVCqW3tCvndCiQfFHh4CYgcL/tbe4hXqsuwRbFHQYSf99TTTHIvsZJTe4Q7DWST9P3hbVxl3HWcxUlo78VM4awNb0Z2+twuFtr0cTaKG14F25V5wsteG/HVLPKgvmtlWlx61teuG1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBVagZwK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBVagZwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpkdvipcmAcBa2auSG3J8F5gVm+aKl/kzxuPFWdZfzg=;
	b=fBVagZwKA+M+lESQNwkhcA1obZbb0EU+9UplkbEvRvbjWdqhPP7bREuey2vYybLb07jCL2
	Xz6i3VSM3zEJPLSQnoqtb09DGhD/joGynGCusXcityOEQwbKfetm3jPf3n6DfS31reT3km
	ktoazkH1nR/Kvp8Bqqp6dw6g+buViWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-9lU4g2X8NkqLcH-6lngtuw-1; Wed,
 26 Aug 2026 15:42:38 -0400
X-MC-Unique: 9lU4g2X8NkqLcH-6lngtuw-1
X-Mimecast-MFC-AGG-ID: 9lU4g2X8NkqLcH-6lngtuw_1787773352
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9382919540D7;
	Wed, 26 Aug 2026 19:42:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B9A81800577;
	Wed, 26 Aug 2026 19:42:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 25/43] qapi: convert trivial intro sections for pci.json
Date: Wed, 26 Aug 2026 15:38:22 -0400
Message-ID: <20260826193840.2152000-26-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: auGOCcxbW4lh38HxQ26z6Wb6pwXwwNZJNS3nBKhBM5k_1787773352
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
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

