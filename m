Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26738B12A
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471084; cv=none; b=LonMJk62tO2y+iJP/nh2qpE1Z483q7PW8Il/L6EI1Y0idZ9Popb+trfqBlg3BuzNs+Amgam0RbeeATgCpZmhXeGp/T2xq2c2RIYKuTi3Ifuc9AxRtDoVdjviSnji/rXn1HzEvauCE2+wU5jV9VfKUgpqSRHn8wVHQ7m8QZLE6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471084; c=relaxed/simple;
	bh=nqkyJiQOacfE5+qZ6fXMSwyikqoQS1NHv1IVJWkLZ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip250BnEDN1tUgslqapyLG475jPsdbGeZ+M4d9C3Pe4ueLxzFOtCifwp1avWTcBAWm0z8+8+nTnrtYyW/ANo5SF/g65M0s457NK5ZYp8bhvV6Pzk/cbabiR1E1/d3gTULHto3itNRfmZKvOVCfHcFpCBzDKPX7I8oMOLZVA8/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxSiYidz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxSiYidz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f6092eso8782098f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471078; x=1778075878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i55Tulez84uC6S30BzMAZAX+g+KufDCaRfey8FY/Ij4=;
        b=hxSiYidzcvM9QihibEHOi2yzJMkWL31Ggjus85vFe81yWopcF7ZWuJhfsAo7oOxKea
         NrGEyGiEtQ+FICXzlAxjeI3FytZnJ5VVUaOr3GQDmDwXsA4+nuGP10HQJMdYGeNJDFXD
         uT6C5aCcyA2RtARbtx2PDOYtFSntOMP1ceg+Ue4zpkk5R33tMDpyfFV/XEjii7Sc6GNV
         tgZefbaScRtJmX0nVJMtwjBRbrMYayHbV7sOL20hfxHkj8Y3jN98YqN2QicEMPzieE4a
         5b+v2NAC2be0gH9L+zvQ7DlOa55GGN4NyLyZEh76bvSQ4gb8ncOm9D7iRu34ZhZuJNvv
         ZInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471078; x=1778075878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i55Tulez84uC6S30BzMAZAX+g+KufDCaRfey8FY/Ij4=;
        b=LGfiUhz2RChfbJl4cdzQFJ4oXxlOTd+1yVZ0izgoz29am7QcfSDslQsOGiyZzbNN2x
         O5tA2QJZJH72ie0i6Y+K7zY2DQClhDjAA6lhg0I4l9wMzjxn7RUajkdri9WdB2nTg0u8
         xIkwrCKYFMqlnQSyT5ZVQfzoeMKOhbGmEML4GSw0hIOWTcIiQTmqlkkbLHmd98clPlGE
         PIuQXNTjULK8rP34yRYU+fE3UXpVYENnRoF3WcNvZwNltls2P5bqBeAseaon/bHQrIy/
         pAss6h4f8YZkK+1TdaCFtaP4Fk5Aa+i0m3ktQQvG/TrA6/fSdUrGf+kbd9Q/aHpVFTvd
         Ep/w==
X-Gm-Message-State: AOJu0Yz/+ZNTd+i8Ku+aqAFyTjesxfSqw0DtCfonX8fEWEHURHp+tMTy
	8l/Sz2G9QLTF/QZWQW6ekUvv3Q4G0SNIva9x9sOULmZSsr1/gJ0hZayQKgyjH1Is
X-Gm-Gg: AeBDies3B9uWd6C0PwGHBhaSSC3pDlANH7eC5Y0m9YVWF1GtrbG2TbOgeoY9Xsd4wWp
	raVaTUC64SxrFO0UNOohE5GrH6kXvjsUm1wolIdZv8BtwsvMgcmGEn5oTtQ+zmc1Kvj4swHL9M8
	7Kc2LdR89yBIfbyyrfPurOqV9YHr4FuFRRwviNKsOM+IAw/LzQaP30imfFmmTLy3OeTQtS5NplZ
	H1xQ49ZKBsKPMDQ3KMDzpqb4z3qRIgRhq7ZgaxBC+p90ayovg0YucocGc6B4fCZOCA3xyo6uojK
	7A5IOOasQ3V/HLGY/X0ETRfer5w0bH8i3Sh1bCePGfK0ZlDSpI+F9NMiRAMsqFJ5Er+D1omGR3O
	xGfWMsHJlxFWolW/QCF5q9C4OL79pGPZ6QMkDGCxHcBPGvzduRzK5OuqPOR8DIAwdv2FG29SsYH
	vKAQsIsCWpr/4kB38an3cxIq5k4gCzaN0dgckzyFog20qR3xLhvJC75+s+730ONWwFG1POU8vG
X-Received: by 2002:a05:6000:2304:b0:43d:75ec:26f7 with SMTP id ffacd0b85a97d-4464aced724mr14325698f8f.29.1777471077272;
        Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:57:56 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be busless on QEMU startup
Date: Wed, 29 Apr 2026 14:48:36 +0100
Message-ID: <20260429135717.3048713-3-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the capability for hiding devices, introduced for virtio-net
device in:

commit f3a8505656935cde32e28c1c6317f725084da1e0
Author: Jens Freimann <jfreimann@redhat.com>
Date:   Tue Oct 29 12:48:55 2019 +0100
qdev/qbus: add hidden device support

Currently only endpoint devices can be hidden with a primary device
and failover (known static configuration). However, looking at future
composable systems, we see a need for hidden devices which have no associated
bus upon boot. Move the check for hidden devices to before the bus
search, and if it is hidden ignore the case where the device was
described on the CLI without the "bus=" field.

This is motivated by a specific use-case: implementing the VCS
command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
this scenario a switch controlled by a Fabric Manager is able to change the
virtual hierarchy of devices seen by a guest within a fixed physical system
topology. The connecting bus is not known until runtime when
a bind command is issued by the Fabric Manager.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 system/qdev-monitor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index f2aa400a77..b51dfe0645 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     DeviceState *dev;
     BusState *bus = NULL;
     QDict *properties;
+    bool hide_device;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
+    /* Is the device hidden from the guest?
+     * If yes, no need to find a default bus if none given...
+     * Bus could be provided at runtime (i.e. in a switch)*/
+    hide_device = qdev_should_hide_device(opts, from_json, errp);
+
     /* find bus */
     path = qdict_get_try_str(opts, "bus");
     if (path != NULL) {
@@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                        driver, object_get_typename(OBJECT(bus)));
             return NULL;
         }
-    } else if (dc->bus_type != NULL) {
+    } else if (dc->bus_type != NULL && !hide_device) {
         bus = qdev_find_default_bus(dc, errp);
         if (!bus) {
             return NULL;
         }
     }
 
-    if (qdev_should_hide_device(opts, from_json, errp)) {
+    if (hide_device) {
         if (bus && !qbus_is_hotpluggable(bus)) {
             error_setg(errp, "Bus '%s' does not support hotplugging",
                        bus->name);
-- 
2.47.3

