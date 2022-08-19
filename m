Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E20DC25B0E
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Aug 2022 08:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbiHSIyd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347833AbiHSIyb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Aug 2022 04:54:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61076CD501
        for <linux-cxl@vger.kernel.org>; Fri, 19 Aug 2022 01:54:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d10so3604547plr.6
        for <linux-cxl@vger.kernel.org>; Fri, 19 Aug 2022 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tW8DuGA74WY0qH3p2brrechg70mcLe4sk1dVqGA83DQ=;
        b=QF70vfkluoHWHYsL/Fx25gpbjgQpXMMuxql8a0cgzTc5xnHs64D5EWa312B1T2mkVs
         DVN4TNjxPtlKJATs9YDsce6j4idkowNpioqAW4K9I5cN6Q0zI7mS1JVVMUm5gEOQCkfS
         V68nDo/bdCLRdIIdRmpOFmtBCcR+IPlVh3pd2lY4oHwBEpqsBvqd34X1Sz+0OKczXkuN
         KncptZ53f3FyvNne21yvbOsWNjROpj74RkQw1Q97l0UsHin9goxRswmoQQdSJdymJYD2
         k6/crICw6Ut3Ox8zULDW5p8Wg+z/Ng9OH2hHvY/gi9QlH90iP1rslysNaWZZGZJQvLso
         rgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tW8DuGA74WY0qH3p2brrechg70mcLe4sk1dVqGA83DQ=;
        b=ACTCJDN+u/XHrIsiiNJF410KWy6bilVShwokye3uIvGR3fkRK5BwXP05Xa36NP3M3x
         d6sLO0akGQQWxSbbCv0qYtsi/Cj3ey9FtTAvCCdeOtmnbpPCsKKQ0m+VYJVNcW3z2/qM
         rJkTESCjGCyCMGtQ0snqH6ikhxlG+my0j0KxJGbvNacoRaGceIBHwsgx3xcA3T69vEMN
         bDz7TF+qAoaOtBG/BgQtOw7tKxAxC5Lukgenrp3Hi8rwckZ6hMu3SiJBJfBLiVDWhW3G
         MNCfRED3fenPHmN0qaU82HOfrbMRfFfrgkkcQuylQjRXIUBFtfxrgUVmoAyUTvn4sbAd
         KWmg==
X-Gm-Message-State: ACgBeo0130/af+n25C3H+nEESn/cTQt5oc8y6UIuHzNvkyjaJ4NzwiYI
        ZJPF+gnww7lOCLLa6DvpFCZGp0nAxrM=
X-Google-Smtp-Source: AA6agR7Q5EKeADIzprclXEsQpFoEBQ1NTVZpD+plsjR0nxIbG0tY1uYgdiUe0r01BXDhSg34ysUaNg==
X-Received: by 2002:a17:90b:4b04:b0:1f5:2da0:b2f6 with SMTP id lx4-20020a17090b4b0400b001f52da0b2f6mr7124941pjb.195.1660899269544;
        Fri, 19 Aug 2022 01:54:29 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902db0f00b0016d33b8a231sm2659004plx.270.2022.08.19.01.54.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 01:54:29 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [ndctl PATCH 1/2] cxl: Add root port attribute to cxl list output
Date:   Fri, 19 Aug 2022 01:54:25 -0700
Message-Id: <b8aa06d6518260e7110defbd7a7eca659b09f26f.1660895649.git.sunfishho12@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <cover.1660895649.git.sunfishho12@gmail.com>
References: <cover.1660895649.git.sunfishho12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Matthew Ho <sunfishho12@gmail.com>

This adds a "root port" attribute to ports and type 3 memory devices
located under a host bridge indicating which root port each device
falls under. Previously, the cxl list command lists the various root
ports as dports underneath each host bridge, and displays devices as
being under a given host bridge, but did not indicate which specific
root port corresponded to which device. Adding this information
helps to map the CXL topology.

Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
---
 cxl/json.c         | 16 ++++++++++-
 cxl/lib/libcxl.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 ++-
 cxl/libcxl.h       |  2 ++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index 9cec58b482b6..ad82f37fc955 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -303,7 +303,7 @@ err_jobj:
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		unsigned long flags)
 {
-	const char *devname = cxl_memdev_get_devname(memdev);
+	const char *devname = cxl_memdev_get_devname(memdev), *rp;
 	struct json_object *jdev, *jobj;
 	unsigned long long serial;
 	int numa_node;
@@ -324,6 +324,13 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "ram_size", jobj);
 
+	rp = cxl_memdev_get_root_port(memdev);
+	if (rp) {
+		jobj = json_object_new_string(rp);
+		if (jobj)
+			json_object_object_add(jdev, "root port", jobj);
+	}
+
 	if (flags & UTIL_JSON_HEALTH) {
 		jobj = util_cxl_memdev_health_to_json(memdev, flags);
 		if (jobj)
@@ -727,6 +734,7 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 						   unsigned long flags)
 {
 	const char *devname = cxl_port_get_devname(port);
+	const char *rp = cxl_port_get_root_port(port);
 	struct json_object *jport, *jobj;
 
 	jport = json_object_new_object();
@@ -741,6 +749,12 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 	if (jobj)
 		json_object_object_add(jport, "host", jobj);
 
+	if (rp != NULL) {
+		jobj = json_object_new_string(rp);
+		if (jobj)
+			json_object_object_add(jport, "root port", jobj);
+	}
+
 	if (!cxl_port_is_enabled(port)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index a40b0e6aee83..c5b8ff339eb8 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1260,6 +1260,39 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
 
+CXL_EXPORT const char *cxl_memdev_get_root_port(struct cxl_memdev *memdev)
+{
+	char *rp_name = strdup(memdev->host_path), *save;
+	const char *rp;
+	bool host_bridge_found = false;
+
+	if (!memdev->host_path)
+		return NULL;
+
+	rp_name = strdup(memdev->host_path);
+
+	if (!rp_name) {
+		printf("Error: strdup failed in cxl_memdev_get_Root_port\n");
+		return NULL;
+	}
+
+	rp = strtok_r(rp_name, "/", &save);
+
+	while (rp) {
+		/* return the first substring after the host bridge */
+
+		if (host_bridge_found)
+			return (char *)rp;
+
+		if (!strncmp(rp, "pci", strlen("pci")))
+			host_bridge_found = true;
+
+		rp = strtok_r(NULL, "/", &save);
+	}
+	return NULL;
+}
+
+
 CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
 {
 	return memdev->firmware_version;
@@ -2405,6 +2438,39 @@ CXL_EXPORT const char *cxl_port_get_host(struct cxl_port *port)
 	return devpath_to_devname(port->uport);
 }
 
+CXL_EXPORT const char *cxl_port_get_root_port(struct cxl_port *port)
+{
+	char *rp_name, *save;
+	const char *rp;
+	bool host_bridge_found = false;
+
+	if (!port->uport)
+		return NULL;
+
+	rp_name = strdup(port->uport);
+
+	if (!rp_name) {
+		printf("Error: strdup failed in %s\n", __func__);
+		return NULL;
+	}
+
+	rp = strtok_r(rp_name, "/", &save);
+
+	while (rp) {
+		/* return the first substring after the host bridge */
+
+		if (host_bridge_found)
+			return (char *)rp;
+
+		if (!strncmp(rp, "pci", strlen("pci")))
+			host_bridge_found = true;
+
+		rp = strtok_r(NULL, "/", &save);
+	}
+	return NULL;
+}
+
+
 CXL_EXPORT bool cxl_port_hosts_memdev(struct cxl_port *port,
 				      struct cxl_memdev *memdev)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 549f88dae6ff..4f61686a3aff 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -19,6 +19,7 @@ global:
 	cxl_memdev_get_ctx;
 	cxl_memdev_get_pmem_size;
 	cxl_memdev_get_ram_size;
+	cxl_memdev_get_root_port;
 	cxl_memdev_get_firmware_verison;
 	cxl_cmd_get_devname;
 	cxl_cmd_new_raw;
@@ -101,7 +102,7 @@ global:
 	cxl_port_to_endpoint;
 	cxl_port_get_bus;
 	cxl_port_get_host;
-	cxl_port_get_bus;
+	cxl_port_get_root_port;
 	cxl_port_hosts_memdev;
 	cxl_port_get_nr_dports;
 	cxl_port_disable_invalidate;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 61c7fc4e39b8..9ffa640bc832 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -47,6 +47,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_root_port(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
@@ -95,6 +96,7 @@ bool cxl_port_is_endpoint(struct cxl_port *port);
 struct cxl_endpoint *cxl_port_to_endpoint(struct cxl_port *port);
 struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
 const char *cxl_port_get_host(struct cxl_port *port);
+const char *cxl_port_get_root_port(struct cxl_port *port);
 bool cxl_port_hosts_memdev(struct cxl_port *port, struct cxl_memdev *memdev);
 int cxl_port_get_nr_dports(struct cxl_port *port);
 int cxl_port_disable_invalidate(struct cxl_port *port);
-- 
2.34.1

