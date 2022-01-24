Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D064C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiAXAyk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:61693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235269AbiAXAyk (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985680; x=1674521680;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0NdwC93ssfg88OI+v7HvqVpIZAZ5L44ySP0ZKcYAP4=;
  b=HhqR0HLTfAB0b/Pcuhm6n5f4q0HRZLxoBIRWYJIF7vIWYUUX4o/YexZI
   K5lXhewRsBVdhmZkkdMwkRl2/wR55XE8B/JcpziBk8KiHSRP+LFynJE2d
   fc7c2+hCkwoGs64EsVFPwxfnQym5fEdwifgnBTqLPdUjZ9GQ4ccA84QAt
   sfejIpDJ7RExEQosLMZPiPimWoPWuRNtxcHmChzrlIohd02OmJxQJOtRV
   9613FRgLf6TzNgPZtnHwGRzUVhVgEGKHZeC84QzTIayVoTj/9XnxQdl1w
   ss/XtYa9BjkOQD4rbwhBYqtzGsVORLmlFOyV6O2O6tOiOFr82Nem2723U
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233294034"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233294034"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580175296"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:39 -0800
Subject: [ndctl PATCH 32/37] cxl/list: Use 'physical_node' for root port
 attachment detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:39 -0800
Message-ID: <164298567943.3021641.12696733268157328279.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Platform firmware objects like ACPI0016 link from /sys/bus/acpi to
/sys/bus/pci via a 'physical_node' attribute. Consider that link when
attempting to link memdevs to root ports.

Emit it in the the target listing as the 'alias' for the listed target
device.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |    6 ++++++
 cxl/json.c                       |    8 ++++++++
 cxl/lib/libcxl.c                 |   16 +++++++++++++++-
 cxl/lib/libcxl.sym               |    1 +
 cxl/lib/private.h                |    1 +
 cxl/libcxl.h                     |    1 +
 6 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index bd92fef962fa..a68a58b06c5d 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -389,6 +389,7 @@ unsigned long cxl_target_get_id(struct cxl_target *target);
 const char *cxl_target_get_devname(struct cxl_target *target);
 bool cxl_target_maps_memdev(struct cxl_target *target,
                            struct cxl_memdev *memdev);
+const char *cxl_target_get_physical_node(struct cxl_target *target);
 ----
 The position of a decoder along with the interleave granularity dictate
 which address in the decoder's resource range map to which port.
@@ -410,6 +411,11 @@ The cxl_target_maps_memdev() helper is the companion of
 cxl_decoder_get_target_by_memdev() to determine which downstream ports /
 targets are capable of mapping which memdevs.
 
+Some platform firmware implementations define an alias / companion
+device to represent the root of a PCI device hierarchy. The
+cxl_target_get_physical_node() helper returns the device name of that
+companion object in the PCI hierarchy.
+
 include::../../copyright.txt[]
 
 SEE ALSO
diff --git a/cxl/json.c b/cxl/json.c
index 3a3790955370..d81aed8f7729 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -342,6 +342,7 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 
 	cxl_target_foreach(decoder, target) {
 		struct json_object *jtarget = json_object_new_object();
+		const char *phys_node;
 
 		if (!jtarget)
 			continue;
@@ -351,6 +352,13 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 		if (jobj)
 			json_object_object_add(jtarget, "target", jobj);
 
+		phys_node = cxl_target_get_physical_node(target);
+		if (phys_node) {
+			jobj = json_object_new_string(phys_node);
+			if (jobj)
+				json_object_object_add(jtarget, "alias", jobj);
+		}
+
 		val = cxl_target_get_position(target);
 		jobj = json_object_new_int(val);
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 877f42c9145e..7bf79492ca88 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -72,6 +72,7 @@ static void free_target(struct cxl_target *target, struct list_head *head)
 	if (head)
 		list_del_from(head, &target->list);
 	free(target->dev_path);
+	free(target->phys_path);
 	free(target);
 }
 
@@ -970,7 +971,11 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			free(target);
 			break;
 		}
-		dbg(ctx, "%s: target%ld %s\n", devname, i, target->dev_path);
+		sprintf(port->dev_buf, "%s/dport%d/physical_node", port->dev_path, did);
+		target->phys_path = realpath(port->dev_buf, NULL);
+		dbg(ctx, "%s: target%ld %s phys_path: %s\n", devname, i,
+		    target->dev_path,
+		    target->phys_path ? target->phys_path : "none");
 		list_add(&decoder->targets, &target->list);
 	}
 
@@ -1138,9 +1143,18 @@ CXL_EXPORT bool cxl_target_maps_memdev(struct cxl_target *target,
 	dbg(ctx, "memdev: %s target: %s\n", memdev->host_path,
 	    target->dev_path);
 
+	if (target->phys_path)
+		return !!strstr(memdev->host_path, target->phys_path);
 	return !!strstr(memdev->host_path, target->dev_path);
 }
 
+CXL_EXPORT const char *cxl_target_get_physical_node(struct cxl_target *target)
+{
+	if (!target->phys_path)
+		return NULL;
+	return devpath_to_devname(target->phys_path);
+}
+
 CXL_EXPORT struct cxl_target *
 cxl_decoder_get_target_by_memdev(struct cxl_decoder *decoder,
 				 struct cxl_memdev *memdev)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index cb33180c2aa8..ce01298d8b43 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -141,4 +141,5 @@ global:
 	cxl_target_get_id;
 	cxl_target_get_devname;
 	cxl_target_maps_memdev;
+	cxl_target_get_physical_node;
 } LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 1743a244877a..7e7742d523f3 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -77,6 +77,7 @@ struct cxl_target {
 	struct list_node list;
 	struct cxl_decoder *decoder;
 	char *dev_path;
+	char *phys_path;
 	int id, position;
 };
 
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index abda0e51644c..0e484cc79f28 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -140,6 +140,7 @@ unsigned long cxl_target_get_id(struct cxl_target *target);
 const char *cxl_target_get_devname(struct cxl_target *target);
 bool cxl_target_maps_memdev(struct cxl_target *target,
 			    struct cxl_memdev *memdev);
+const char *cxl_target_get_physical_node(struct cxl_target *target);
 
 #define cxl_target_foreach(decoder, target)                                    \
 	for (target = cxl_target_get_first(decoder); target != NULL;           \

