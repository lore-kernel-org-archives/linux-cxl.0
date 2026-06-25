Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F053E00BE
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389599; cv=none; b=fX9Mmg1hS5vh/n9HIeskg8y0BJxnhMqMDbXrMuqc7yzP7ar7XsTmR2KcT4yE+JL9b4h7lNpRuznRZy7QXz51i60AMPJvEO+tF++WDtGpDao2Y/ECdUPZTIjflWsDjFEkcALP4My0kH6bqP8xem42fNGbdXN5dkz0EjffwhB7K6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389599; c=relaxed/simple;
	bh=NGqG0z5kg5hD+sbahy7l1//i5IIwDROx1lw8ryP0hm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWrN8XBH9l9ZDcQSd7kArV/eUA6G+DQXPY/ivif/5jm7Z7qFNR22zorZ/YK3oy+HJf9mvw2yHhPtIe8TJ0paQxWwGH6F3Sx9o+Vxa5k30UjevPE3Li/T1Lzt/724fE0G2IUMaNWuXXQ0pP7ukyiV2+MKrGnQ4qHeHNM1FOS9qPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q52ol/JU; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q52ol/JU"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139a71baa35so5779035c88.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389597; x=1782994397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLN4RMNO6Z04sqs9IuRaj34hm6j4WxJm7vW3NC89bcE=;
        b=Q52ol/JUAI5QEIVTO4EYKC2F0dFwwKvG2QoYHW3sAN9etLJBl7om1Qt5c37K+JmWNl
         xMgT1BRk0G7jtC6YH+v0hmv5vXSvHHqlu3z7ziSyeLUSTxydPMtQ/Gglw5friTPMELl9
         AQJfHTKRJklCfKSW9FNawTzfdSVOb5b3iYoru2+bo5RSrIet3JEsGDeyQxdHbSkrWP2D
         JNRvFQpfb5iA5BwAeX9syr0QWi5GaCBxKP0cPHJNsJyqN9uHg0X2qfGB7Hb+b62Lahjw
         0a/7dtQdYEGIpPbwkZdBhmZuHabs/OhuAobp3Om1ZOjA6rd99Fr3BZpGRNa5UEutnbyv
         fNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389597; x=1782994397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLN4RMNO6Z04sqs9IuRaj34hm6j4WxJm7vW3NC89bcE=;
        b=dOTVNlGKBnOwRsMJGd9nN5XWF922nQinE7NmJMtk3VigjURIhCgZeXAWXMLPgsVGJb
         Ge2nZjQwN4E3HWIXSHJ8HMjrJUiQslp4U9M9T9vKpagvZwofnLfQJdx+TNJpLEYlo8qW
         aKKrUeaR3Ob5ky7Nxhm0Q15YFRt4GZjzMuOWZ9rahDgtPhJ6A2zllENkULFNfgFli8uX
         17q/SHEWYvJoSO9hmUdaOgrCKqw8EiQhviRouYeK4B9ZHxm5cuGQqHfRJce2ODeC5YTV
         lATzBJsFsmjMCtROCY9kVciy2mJOnqOypLxgfBeVbsb7V9gDXZ2FC9T3L+PDL6b/jTb+
         X9fQ==
X-Gm-Message-State: AOJu0Yyh38B6Z9QBg3vImR7eePAcCIPSmhdcTqurjvGz6oX0Pqi2UXU8
	wCYBnZ2IoLTNdq4eQNHCRaoSEHUUOHKKgQZUhdWAY5Ef/82F5oKbRrxkDoONWQ==
X-Gm-Gg: AfdE7cnnVOn4wKcBop7NrYxbJaSXR0fDA5nMRQl+r0qmInydnPHsZLGtugGqelB1g8D
	jtZmftKSN71xuOIjaRBhZk1CLNxRBTAoQ1Ahs5evjoBx6kY5kYIGkTzk3Wdo+P+XHmgwi9qIiKc
	cUB37RJryeL66EDwfBlNgZTLZaW8EsQlIpUZlXRwpocUr99mS3p2+/LpBvkLVX3Y8ZlFumIjQ5c
	zRmxGsKG2sveV4+2NI8s+L1a4vyEIXLZ+Ry3cINE8XhLBQAWcqreRpn62dfmcdhHrjXAqfy8SkY
	wSedkpHTRnXN624eICMTxGDiEHGO7bLc/r+xR0Q3Qec9WndP3HADId187NQjWrUSpUD/uQcX/60
	jl+EKpc1PW4A7uJHECFnOkS8mn254l9nAcLSMT4D+z/aBM/NMN6Qdh4xALBufoGX1WjwuvOrJ31
	tWmJWFXtWYfLnVD6DjXS1oCbshKy2CLx7JJvIOV1hsXy2vJFcxwCSXbhylMFquT4xRaCUD
X-Received: by 2002:a05:7022:6299:b0:138:407c:1d20 with SMTP id a92af1059eb24-139dbadf918mr2191847c88.35.1782389596491;
        Thu, 25 Jun 2026 05:13:16 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm7422206c88.8.2026.06.25.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:13:16 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [NDCTL PATCH v7 3/5] cxl/region: Add extent output to region query
Date: Thu, 25 Jun 2026 05:09:37 -0700
Message-ID: <20260625121242.603807-4-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625121242.603807-1-anisa.su@samsung.com>
References: <20260625121242.603807-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

DCD regions have 0 or more extents.  The ability to list those and their
properties is useful to end users.

Add an option for extent output to region queries.  An example of this
is:

	$ ./build/cxl/cxl list -r 8 -Nu
	{
	  "region":"region8",
	  ...
	  "type":"dc",
	  ...
	  "extents":[
	    {
	      "offset":"0x10000000",
	      "length":"64.00 MiB (67.11 MB)",
	      "uuid":"00000000-0000-0000-0000-000000000000"
	    },
	    {
	      "offset":"0x8000000",
	      "length":"64.00 MiB (67.11 MB)",
	      "uuid":"00000000-0000-0000-0000-000000000000"
	    }
	  ]
	}

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
1. guard util_cxl_extents_append_json() on cxl_extent_get_first(region) != NULL
so emmpty extents array doesn't show up for non-DC regions
---
 Documentation/cxl/cxl-list.txt | 29 ++++++++++++++++++++
 cxl/filter.h                   |  3 ++
 cxl/json.c                     | 50 ++++++++++++++++++++++++++++++++++
 cxl/json.h                     |  3 ++
 cxl/list.c                     |  3 ++
 util/json.h                    |  1 +
 6 files changed, 89 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 193860b..7512687 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -426,6 +426,35 @@ OPTIONS
 }
 ----
 
+-N::
+--extents::
+	Append Dynamic Capacity extent information.
+----
+13:34:28 > ./build/cxl/cxl list -r 8 -Nu
+{
+  "region":"region8",
+  "resource":"0xf030000000",
+  "size":"512.00 MiB (536.87 MB)",
+  "type":"dc",
+  "interleave_ways":1,
+  "interleave_granularity":256,
+  "decode_state":"commit",
+  "extents":[
+    {
+      "offset":"0x10000000",
+      "length":"64.00 MiB (67.11 MB)",
+      "uuid":"00000000-0000-0000-0000-000000000000"
+    },
+    {
+      "offset":"0x8000000",
+      "length":"64.00 MiB (67.11 MB)",
+      "uuid":"00000000-0000-0000-0000-000000000000"
+    }
+  ]
+}
+----
+
+
 -r::
 --region::
 	Specify CXL region device name(s), or device id(s), to filter the listing.
diff --git a/cxl/filter.h b/cxl/filter.h
index 70463c4..30e7fe2 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -31,6 +31,7 @@ struct cxl_filter_params {
 	bool alert_config;
 	bool dax;
 	bool media_errors;
+	bool extents;
 	int verbose;
 	struct log_ctx ctx;
 };
@@ -93,6 +94,8 @@ static inline unsigned long cxl_filter_to_flags(struct cxl_filter_params *param)
 		flags |= UTIL_JSON_DAX | UTIL_JSON_DAX_DEVS;
 	if (param->media_errors)
 		flags |= UTIL_JSON_MEDIA_ERRORS;
+	if (param->extents)
+		flags |= UTIL_JSON_EXTENTS;
 	return flags;
 }
 
diff --git a/cxl/json.c b/cxl/json.c
index e832982..7b856f9 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -1022,6 +1022,53 @@ void util_cxl_mappings_append_json(struct json_object *jregion,
 	json_object_object_add(jregion, "mappings", jmappings);
 }
 
+void util_cxl_extents_append_json(struct json_object *jregion,
+				  struct cxl_region *region,
+				  unsigned long flags)
+{
+	struct json_object *jextents;
+	struct cxl_region_extent *extent;
+
+	if (!cxl_extent_get_first(region))
+		return;
+
+	jextents = json_object_new_array();
+	if (!jextents)
+		return;
+
+	cxl_extent_foreach(region, extent) {
+		struct json_object *jextent, *jobj;
+		unsigned long long val;
+		char uuid_str[40];
+		uuid_t uuid;
+
+		jextent = json_object_new_object();
+		if (!jextent)
+			continue;
+
+		val = cxl_extent_get_offset(extent);
+		jobj = util_json_object_hex(val, flags);
+		if (jobj)
+			json_object_object_add(jextent, "offset", jobj);
+
+		val = cxl_extent_get_length(extent);
+		jobj = util_json_object_size(val, flags);
+		if (jobj)
+			json_object_object_add(jextent, "length", jobj);
+
+		cxl_extent_get_uuid(extent, uuid);
+		uuid_unparse(uuid, uuid_str);
+		jobj = json_object_new_string(uuid_str);
+		if (jobj)
+			json_object_object_add(jextent, "uuid", jobj);
+
+		json_object_array_add(jextents, jextent);
+		json_object_set_userdata(jextent, extent, NULL);
+	}
+
+	json_object_object_add(jregion, "extents", jextents);
+}
+
 struct json_object *util_cxl_region_to_json(struct cxl_region *region,
 					     unsigned long flags)
 {
@@ -1126,6 +1173,9 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
 		}
 	}
 
+	if (flags & UTIL_JSON_EXTENTS)
+		util_cxl_extents_append_json(jregion, region, flags);
+
 	if (cxl_region_qos_class_mismatch(region)) {
 		jobj = json_object_new_boolean(true);
 		if (jobj)
diff --git a/cxl/json.h b/cxl/json.h
index eb7572b..f9c07ab 100644
--- a/cxl/json.h
+++ b/cxl/json.h
@@ -20,6 +20,9 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
 void util_cxl_mappings_append_json(struct json_object *jregion,
 				  struct cxl_region *region,
 				  unsigned long flags);
+void util_cxl_extents_append_json(struct json_object *jregion,
+				  struct cxl_region *region,
+				  unsigned long flags);
 void util_cxl_targets_append_json(struct json_object *jdecoder,
 				  struct cxl_decoder *decoder,
 				  const char *ident, const char *serial,
diff --git a/cxl/list.c b/cxl/list.c
index 0b25d78..47d1351 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -59,6 +59,8 @@ static const struct option options[] = {
 		    "include alert configuration information"),
 	OPT_BOOLEAN('L', "media-errors", &param.media_errors,
 		    "include media-error information "),
+	OPT_BOOLEAN('N', "extents", &param.extents,
+		    "include extent information (Dynamic Capacity regions only)"),
 	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
@@ -135,6 +137,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		param.decoders = true;
 		param.targets = true;
 		param.regions = true;
+		param.extents = true;
 		/*fallthrough*/
 	case 0:
 		break;
diff --git a/util/json.h b/util/json.h
index 560f845..79ae324 100644
--- a/util/json.h
+++ b/util/json.h
@@ -21,6 +21,7 @@ enum util_json_flags {
 	UTIL_JSON_TARGETS	= (1 << 11),
 	UTIL_JSON_PARTITION	= (1 << 12),
 	UTIL_JSON_ALERT_CONFIG	= (1 << 13),
+	UTIL_JSON_EXTENTS	= (1 << 14),
 };
 
 void util_display_json_array(FILE *f_out, struct json_object *jarray,
-- 
2.43.0

