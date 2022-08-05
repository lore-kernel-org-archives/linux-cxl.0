Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8335C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiHEUiL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiHEUiK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432531F
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731889; x=1691267889;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=580o0fZSfeMUexRJckcK5xaYxR6kecesWhqv4qC6SRw=;
  b=IPnXggjtrx5mDgl1gnX0vqo8WgUKepfJT45TQ/gqHSdpn6o7k3LyPcwV
   zUB/rqxhSf/w97qPY4/8iFUaWVe8xsezvK+uOWd+mbWmh+p8JCwz07Aoz
   NcR0pfV2og2Tb8Qvm5zY1TkgTyEoKf4sOuDyPeTdzrQW3NVnWVgR6SPRx
   szNl5NoqUb4u+fj5OWU6ZuMpv8hBE0VPc5Efhm55Mz8+g56UFY8se82zD
   w6XT57n8fLA5QVSX2iVHXcck2OYtf0Zn3TJoDrjVE+T7ep9CwaEJpueDJ
   if+tVIm4xmDgtmyOAfVGVnrmtgg+r/YKtPFdFHApDGVhN9PMlOLathDzw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290293693"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290293693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="693117973"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:09 -0700
Subject: [ndctl PATCH 3/6] cxl/list: Add region to decoder listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:38:08 -0700
Message-ID: <165973188860.1528532.17427805440366364536.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While decoders can be matched with regions by physical address, or filtered
by region, it is also useful to get a plain listing of the association.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |    7 +++++++
 cxl/json.c                       |    8 ++++++++
 cxl/lib/libcxl.c                 |   34 ++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |    1 +
 cxl/libcxl.h                     |    1 +
 5 files changed, 51 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 7a38ce4a54e2..72641699633b 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -398,6 +398,7 @@ int cxl_decoder_set_dpa_size(struct cxl_decoder *decoder, unsigned long long siz
 const char *cxl_decoder_get_devname(struct cxl_decoder *decoder);
 int cxl_decoder_get_id(struct cxl_decoder *decoder);
 int cxl_decoder_get_nr_targets(struct cxl_decoder *decoder);
+struct cxl_region *cxl_decoder_get_region(struct cxl_decoder *decoder);
 
 enum cxl_decoder_target_type {
        CXL_DECODER_TTYPE_UNKNOWN,
@@ -446,6 +447,12 @@ Platform firmware may setup the CXL decode hierarchy before the OS
 boots, and may additionally require that the OS not change the decode
 settings. This property is indicated by the cxl_decoder_is_locked() API.
 
+When a decoder is associated with a region cxl_decoder_get_region()
+returns that region object. Note that it is only applicable to switch
+and endpoint decoders as root decoders have a 1:N relationship with
+regions.  Use cxl_region_foreach() for the similar functionality for
+root decoders.
+
 ==== TARGETS
 A root or switch level decoder takes an SPA (system-physical-address) as
 input and routes it to a downstream port. Which downstream port depends
diff --git a/cxl/json.c b/cxl/json.c
index 36b76d34b4e5..82e3c552cdb1 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -442,6 +442,7 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 	const char *devname = cxl_decoder_get_devname(decoder);
 	struct cxl_port *port = cxl_decoder_get_port(decoder);
 	struct json_object *jdecoder, *jobj;
+	struct cxl_region *region;
 	u64 val, size;
 
 	jdecoder = json_object_new_object();
@@ -486,6 +487,13 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 		}
 	}
 
+	region = cxl_decoder_get_region(decoder);
+	if (region) {
+		jobj = json_object_new_string(cxl_region_get_devname(region));
+		if (jobj)
+			json_object_object_add(jdecoder, "region", jobj);
+	}
+
 	if (size == 0) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 5001c5685d74..aec3671b1625 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2019,6 +2019,40 @@ cxl_decoder_get_interleave_ways(struct cxl_decoder *decoder)
 	return decoder->interleave_ways;
 }
 
+CXL_EXPORT struct cxl_region *
+cxl_decoder_get_region(struct cxl_decoder *decoder)
+{
+	struct cxl_port *port = cxl_decoder_get_port(decoder);
+	struct cxl_ctx *ctx = cxl_decoder_get_ctx(decoder);
+	char *path = decoder->dev_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	struct cxl_region *region;
+	struct cxl_decoder *iter;
+	int rc;
+
+	if (cxl_port_is_root(port))
+		return NULL;
+
+	sprintf(path, "%s/region", decoder->dev_path);
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc < 0) {
+		err(ctx, "failed to read region name: %s\n", strerror(-rc));
+		return NULL;
+	}
+
+	if (strcmp(buf, "") == 0)
+		return NULL;
+
+	while (!cxl_port_is_root(port))
+		port = cxl_port_get_parent(port);
+
+	cxl_decoder_foreach(port, iter)
+		cxl_region_foreach(iter, region)
+			if (strcmp(cxl_region_get_devname(region), buf) == 0)
+				return region;
+	return NULL;
+}
+
 CXL_EXPORT struct cxl_region *
 cxl_decoder_create_pmem_region(struct cxl_decoder *decoder)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 6bf3e91bdecc..573fcdf532d6 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -213,4 +213,5 @@ global:
 	cxl_ep_decoder_get_memdev;
 	cxl_decoder_get_interleave_granularity;
 	cxl_decoder_get_interleave_ways;
+	cxl_decoder_get_region;
 } LIBCXL_2;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0b84977c2a2c..4b5490986a2a 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -185,6 +185,7 @@ bool cxl_decoder_is_locked(struct cxl_decoder *decoder);
 unsigned int
 cxl_decoder_get_interleave_granularity(struct cxl_decoder *decoder);
 unsigned int cxl_decoder_get_interleave_ways(struct cxl_decoder *decoder);
+struct cxl_region *cxl_decoder_get_region(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_create_pmem_region(struct cxl_decoder *decoder);
 struct cxl_decoder *cxl_decoder_get_by_name(struct cxl_ctx *ctx,
 					    const char *ident);

