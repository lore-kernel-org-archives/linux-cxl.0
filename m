Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F9BC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 18:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiLTS0u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiLTS0r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 13:26:47 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EAF1DA6B
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 10:26:45 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221220182644usoutp02bee11b0f52bd8dce37946649e518d415~yk7INwM-U0136101361usoutp02g;
        Tue, 20 Dec 2022 18:26:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221220182644usoutp02bee11b0f52bd8dce37946649e518d415~yk7INwM-U0136101361usoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671560804;
        bh=gIQhHoXNvs4MxKQlRTbfji2EgKuuKcwoXb+oiXJ/EpI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=sMR09R+g4eezgTMThZYESnsUqS6uv/g0yOQX//dXpND78eCcxSQTu3pQp11svQ2Wm
         fWYzasp8RDhI6vzbGAyZ+g3BISa4/hcuQKW30OknoGvAOmFYnUheewRkOi7eTDtAta
         Grc2eS3VTYtONlTRQ035bqfEIphxg/ydTH9mbDZ8=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221220182644uscas1p22ebc80f418a2a15cb142affe941fde9e~yk7H-4CDR2566325663uscas1p29;
        Tue, 20 Dec 2022 18:26:44 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 57.81.51548.46EF1A36; Tue,
        20 Dec 2022 13:26:44 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221220182644uscas1p17dabe2b8d3a4d1eeb6ab1a0fd89cc178~yk7HsK1D_3082730827uscas1p1K;
        Tue, 20 Dec 2022 18:26:44 +0000 (GMT)
X-AuditID: cbfec36f-813ff7000002c95c-11-63a1fe647ffa
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 61.68.07297.36EF1A36; Tue,
        20 Dec 2022 13:26:43 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 20 Dec 2022 10:26:43 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        20 Dec 2022 10:26:43 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH 2/2] cxl-list: Construct CXL topology graph images
Thread-Topic: [ndctl PATCH 2/2] cxl-list: Construct CXL topology graph
        images
Thread-Index: AQHZFKCcnPVOEAzDUEKvgsD++AANaA==
Date:   Tue, 20 Dec 2022 18:26:43 +0000
Message-ID: <20221220182510.2734032-3-fan.ni@samsung.com>
In-Reply-To: <20221220182510.2734032-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djX87op/xYmG1w9I2wxfeoFRovVN9cw
        WpyfdYrFovHnIkaLWxOOMTmweuycdZfdY/Gel0weU2fXe3zeJBfAEsVlk5Kak1mWWqRvl8CV
        8elCE1vBn72MFX1z3jE2MPbPZOxi5OSQEDCR2LKqka2LkYtDSGAlo8TembNYQBJCAq1MErd3
        KsIUre3oY4coWsso8WbDB1YI5xOjRN/jqYwQHcsYJW7PqQax2QQUJfZ1bWcDsUUErCUmNCwB
        W8EsMJNJ4uq36UwgCWEBD4n7X29CFflLvPy9FyjOAWTrSTTMZAYJswioStxoPwhWwitgKbH0
        yiVWEJtTwEri85bVYHsZBcQkvp9aAzaSWUBc4taT+UwQVwtKLJq9hxnCFpP4t+shG4StKHH/
        +0t2iHo9iRtTp7BB2NoSyxa+ZobYJShxcuYTFoh6SYmDK26wgNwvIbCDQ2Lr5z/sEAkXiR3t
        r6GWSUv8vbsMys6X6NlxAhq+FRIvZ6+AqreWWPhnPdShfBJ/fz1inMCoPAvJ3bOQ3DQLyU2z
        kNy0gJFlFaN4aXFxbnpqsVFearlecWJucWleul5yfu4mRmCqOf3vcP4Oxuu3PuodYmTiYDzE
        KMHBrCTCe+HIwmQh3pTEyqrUovz4otKc1OJDjNIcLErivN1b5ycLCaQnlqRmp6YWpBbBZJk4
        OKUamAyMOWS/xgUe2hpgIff7d13SKkZ7tefaEeEJhSafi+U9Fm4W/bSmkuXbtr7s/wZbVJZp
        efga1G9t/pIiXD352fsjByLa1kzedZ13Mc/h798lHuxLD4zXW7BC+nOUgbbRimulD96fitZ2
        Y1puJinQ2VEkN1/w8T4jdavJtfrVX1p0hKt3n7ymGcysK5p/+m3uAa5F0tq+9QwvF508MMPC
        eaG7s+3+bSEOHM38zMmHKnXZLlrphtWkPrKK2Lh9y97z3gpbOPWNzqs03TMUNKyzeJAv+fMq
        b0v+yg7/i2yT23XvXzolfnU5S8d1H7d4HbnOiar9OxwWyP5/qHLoyYrXbXw7p+2a6bnXfG+J
        1Jz9SizFGYmGWsxFxYkA41PXcKQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWS2cA0UTf538Jkg+aNlhbTp15gtFh9cw2j
        xflZp1gsGn8uYrS4NeEYkwOrx85Zd9k9Fu95yeQxdXa9x+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        ny40sRX82ctY0TfnHWMDY/9Mxi5GTg4JAROJtR197F2MXBxCAqsZJS48v8gI4XxilHi1/BxU
        ZhmjxI31W1lAWtgEFCX2dW1nA7FFBKwlJjQsYQMpYhaYySRx9dt0JpCEsICHxP2vN6GKfCWu
        rzsONJYDyNaTaJjJDBJmEVCVuNF+EKyEV8BSYumVS6wgthCQ3bb+IZjNKWAl8XnLarBTGQXE
        JL6fWgM2nllAXOLWk/lMEC8ISCzZc54ZwhaVePn4HyuErShx//tLdoh6PYkbU6ewQdjaEssW
        vmaG2CsocXLmExaIekmJgytusExgFJ+FZMUsJO2zkLTPQtK+gJFlFaN4aXFxbnpFsVFearle
        cWJucWleul5yfu4mRmBEnv53OHoH4+1bH/UOMTJxMB5ilOBgVhLhvXBkYbIQb0piZVVqUX58
        UWlOavEhRmkOFiVx3pdRE+OFBNITS1KzU1MLUotgskwcnFINTL69YTdj1iv5dUjdvtbMut1/
        W59uUtv5FX8WXZDYZHF7x5EZd0Nn565elWuvmqJccufJ+/tsBzxf7fOTVN9/b72kiBWrm6rK
        k0n7AuUWXAu/PiG5LWK66a+9qgybn3Ca1j66tHuSWe38Ozbhd9Y4/s/jKfJ4duTKr/6J7tue
        /aiJ3lqUFbtNf85jpWlPuSIsT1bKejetDVV3K/0luuqVp+S0nXsDXFL3f/3O+vzdni9PDlzk
        6wi63j3TZMtNblOZOWcLsz7N4TYKL9Y5a2Z5t6xv/m4ZWReTi+s21/xdUTT17Df5hbqdn9jf
        x86LOp3bt39Z4ZRblbuz9a4VPQo1fb7I9mF8qFhhYuQBScajm/iVWIozEg21mIuKEwFfSwzn
        NwMAAA==
X-CMS-MailID: 20221220182644uscas1p17dabe2b8d3a4d1eeb6ab1a0fd89cc178
CMS-TYPE: 301P
X-CMS-RootMailID: 20221220182644uscas1p17dabe2b8d3a4d1eeb6ab1a0fd89cc178
References: <20221220182510.2734032-1-fan.ni@samsung.com>
        <CGME20221220182644uscas1p17dabe2b8d3a4d1eeb6ab1a0fd89cc178@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The change is based on Matthew Ho' patch as list below.
The main changes include,
    1. remove the `root port` attribute for plotting the topology,
    instead leveraging the `parent_dport` attribute of the memdev and port
    objects to plot the topology.
    2. fix the error messages, using error() instead of printf.
    3. move all the graph related the functions to graph.c.
    4. change the command interface, remove the `--graph` option, and
    use output file type (indicated by the suffix of the file identified by
    the `-o` option) to determine plotting the graph or dump to json
    formatted plain file.
    5. fix some bugs in graph plotting related functions.

Matthew Ho's patch:
https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.co=
m/

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 Documentation/cxl/cxl-list.txt |  16 ++
 cxl/filter.c                   |  45 +++-
 cxl/filter.h                   |   5 +
 cxl/graph.c                    | 409 +++++++++++++++++++++++++++++++++
 cxl/graph.h                    |  20 ++
 cxl/json.c                     |   9 +-
 cxl/lib/libcxl.c               |   6 +-
 cxl/libcxl.h                   |   1 +
 cxl/list.c                     |  31 +++
 cxl/meson.build                |   2 +
 meson.build                    |   1 +
 util/json.c                    |   2 +-
 12 files changed, 538 insertions(+), 9 deletions(-)
 create mode 100644 cxl/graph.c
 create mode 100644 cxl/graph.h

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.tx=
t
index 14a2b4b..cb49206 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -362,6 +362,22 @@ OPTIONS
 	  Everything *-vv* provides, plus enable
 	  --health and --partition.
=20
+-o::
+--output-file::
+	Create an image of the CXL topology or a json formatted representation of
+	the CXL. One can specify an output with -o or --output-file, when a
+	jpg/png/jpeg suffix is provided a graph containing a graph of the CXL
+	topology will be generated, and if the suffix is none/txt/json, the cxl
+	topology will be dumped in a json format to the provided file. Note this
+	option will automatically turn on the verbose option (verbose=3D3) and di=
sable
+	the -E option.
+
+--input::
+	This option takes a json-formatted file with valid cxl topology and gener=
ate
+	a graph showing the CXL topology accordingly. The graph will be stored in=
 a
+	file (.jpg, .png or .jpeg) identified by the `-o` or `--output-file` opti=
on
+	or in topology.png if no such output option is given.
+
 --debug::
 	If the cxl tool was built with debug enabled, turn on debug
 	messages.
diff --git a/cxl/filter.c b/cxl/filter.c
index 56c6599..554bec6 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -8,9 +8,11 @@
 #include <util/json.h>
 #include <cxl/libcxl.h>
 #include <json-c/json.h>
+#include <util/util.h>
=20
 #include "filter.h"
 #include "json.h"
+#include "graph.h"
=20
 static const char *which_sep(const char *filter)
 {
@@ -1180,16 +1182,22 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl=
_filter_params *p)
 			}
 		}
 walk_children:
-		dbg(p, "walk decoders\n");
-		walk_decoders(port, p, pick_array(jchilddecoders, jbusdecoders),
-			      pick_array(jchildregions, jregions), flags);
-
+		/*
+		 * Need to walk ports before walking decoder so dport will be properly
+		 * initialized which is needed to get the correct parent_dport of a port=
.
+		 * This is needed if we plot the cxl graph after some region is created.
+		 */
 		dbg(p, "walk ports\n");
 		walk_child_ports(port, p, pick_array(jchildports, jports),
 				 pick_array(jchilddecoders, jportdecoders),
 				 pick_array(jchildeps, jeps),
 				 pick_array(jchilddecoders, jepdecoders),
 				 pick_array(jchilddevs, jdevs), flags);
+
+		dbg(p, "walk decoders\n");
+		walk_decoders(port, p, pick_array(jchilddecoders, jbusdecoders),
+			      pick_array(jchildregions, jregions), flags);
+
 		cond_add_put_array_suffix(jbus, "ports", devname, jchildports);
 		cond_add_put_array_suffix(jbus, "endpoints", devname,
 					  jchildeps);
@@ -1232,6 +1240,35 @@ walk_children:
 		     top_level_objs > 1);
 	splice_array(p, jregions, jplatform, "regions", top_level_objs > 1);
=20
+	if (p->dump_to_file) {
+		switch (output_file_type(p->output_file)) {
+		case FILE_GRAPH:
+			create_image(p->output_file, jplatform);
+			break;
+		case FILE_PLAIN:
+			FILE *fp =3D NULL;
+
+			fp =3D fopen(p->output_file, "w+");
+			if (fp =3D=3D NULL)
+				error("dump to output file %s failed", p->output_file);
+			else {
+				/***
+				 * we need increase the reference count as util_display_json_array
+				 * are called more than once in which the reference count will be
+				 * decreased by one each time it is called.
+				 ***/
+				json_object_get(jplatform);
+				util_display_json_array(fp, jplatform, flags);
+				fclose(fp);
+			}
+			break;
+		case FILE_UNSUPPORTED:
+			error("dump to output file %s skipped due to  unsupported file type"
+					, p->output_file);
+			break;
+		}
+	}
+
 	util_display_json_array(stdout, jplatform, flags);
=20
 	return 0;
diff --git a/cxl/filter.h b/cxl/filter.h
index 256df49..f2d3e4b 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -5,6 +5,8 @@
=20
 #include <stdbool.h>
 #include <util/log.h>
+#include <json-c/json.h>
+#include <graphviz/gvc.h>
=20
 struct cxl_filter_params {
 	const char *memdev_filter;
@@ -14,6 +16,7 @@ struct cxl_filter_params {
 	const char *endpoint_filter;
 	const char *decoder_filter;
 	const char *region_filter;
+	const char *output_file;
 	bool single;
 	bool endpoints;
 	bool decoders;
@@ -26,6 +29,8 @@ struct cxl_filter_params {
 	bool human;
 	bool health;
 	bool partition;
+	bool dump_to_file;
+	const char *input_file;
 	int verbose;
 	struct log_ctx ctx;
 };
diff --git a/cxl/graph.c b/cxl/graph.c
new file mode 100644
index 0000000..e4584bd
--- /dev/null
+++ b/cxl/graph.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 Fan Ni <fan.ni@samsung.com>
+// Copyright (C) 2022 Matthew Ho <sunfishho12@gmail.com>
+#include <graphviz/gvc.h>
+#include <util/util.h>
+#include <util/log.h>
+
+#include "graph.h"
+
+static Agnode_t *create_node(Agraph_t *graph, char *label, bool created)
+{
+	return agnode(graph, label, created);
+}
+
+static char *find_device_type(struct json_object *device)
+{
+	char *value;
+
+	json_object_object_foreach(device, property, value_json) {
+		value =3D (char *)json_object_get_string(value_json);
+		if (!strcmp(property, "bus") &&
+		    !strcmp(value, "root0"))
+			return "ACPI0017 Device";
+		if (!strcmp(property, "host") &&
+		    !strncmp(value, "ACPI0016", strlen("ACPI0016")))
+			return "Host Bridge";
+		if (!strcmp(property, "endpoint"))
+			return "Endpoint";
+		if (!strcmp(property, "host"))
+			return "Switch Port";
+		if (!strcmp(property, "memdev"))
+			return "Type 3 Memory Device";
+		if (!strcmp(property, "dport"))
+			return "dport";
+		if (!strcmp(property, "decoder"))
+			return "decoder";
+		if (!strcmp(property, "provider") &&
+		    !strcmp(value, "cxl_test"))
+			return "cxl_acpi.0";
+	}
+
+	return "unknown device";
+}
+
+static bool check_device_type(struct json_object *device, char *type)
+{
+	return !strcmp(find_device_type(device), type);
+}
+
+/* for labeling purposes */
+static const char *find_device_ID(struct json_object *device)
+{
+	char *dev_type =3D find_device_type(device);
+	json_object *ID =3D json_object_new_string("unknown");
+
+	if (!strcmp(dev_type, "ACPI0017 Device")) {
+		json_object_put(ID);
+		json_object_object_get_ex(device, "bus", &ID);
+	}
+
+	if (!strcmp(dev_type, "Host Bridge") || !strcmp(dev_type, "Switch Port"))=
 {
+		json_object_put(ID);
+		json_object_object_get_ex(device, "host", &ID);
+	}
+
+	if (!strcmp(dev_type, "Endpoint")) {
+		json_object_put(ID);
+		json_object_object_get_ex(device, "endpoint", &ID);
+	}
+
+	if (!strcmp(dev_type, "Type 3 Memory Device")) {
+		json_object_put(ID);
+		json_object_object_get_ex(device, "memdev", &ID);
+	}
+
+	if (!strcmp(dev_type, "dport")) {
+		json_object_put(ID);
+		json_object_object_get_ex(device, "dport", &ID);
+	}
+
+	return json_object_get_string(ID);
+}
+
+static bool is_device(struct json_object *device)
+{
+	char *dev_type =3D find_device_type(device);
+
+	return (strcmp(dev_type, "dport") && strcmp(dev_type, "decoder"));
+}
+
+static char *remove_double_quote_from_json_str(const char *json_str)
+{
+	char *p =3D strdup(json_str);
+	size_t i, j =3D 0;
+
+	for (i =3D 0; i < strlen(json_str); i++) {
+		if (json_str[i] !=3D '\"')
+			p[j++] =3D json_str[i];
+	}
+	p[j] =3D '\0';
+	return p;
+}
+
+static char *find_parent_dport(struct json_object *device)
+{
+	json_object *rp;
+	const char *dport_str;
+
+	rp =3D json_object_new_string("");
+	json_object_put(rp);
+	if (!json_object_object_get_ex(device, "parent_dport", &rp))
+		return NULL;
+
+	dport_str =3D json_object_to_json_string_ext(rp, JSON_C_TO_STRING_NOSLASH=
ESCAPE);
+	return remove_double_quote_from_json_str(dport_str);
+}
+
+static char *find_parent_dport_label(struct json_object *device)
+{
+	char *rp_node_name;
+	char *id =3D find_parent_dport(device);
+
+	if (!id)
+		return NULL;
+	asprintf(&rp_node_name, "dPort\nID: %s", id);
+	free(id);
+	if (!rp_node_name)
+		error("asprintf failed in %s\n", __func__);
+	return rp_node_name;
+}
+
+static char *find_root_port_label(struct json_object *device)
+{
+	char *rp_node_name;
+	char *id =3D find_parent_dport(device);
+
+	if (!id)
+		return NULL;
+	asprintf(&rp_node_name, "Root Port\nID: %s", id);
+	free(id);
+	if (!rp_node_name)
+		error("asprintf failed in %s\n", __func__);
+	return rp_node_name;
+}
+
+static char *label_device(struct json_object *device)
+{
+	char *label;
+	const char *ID =3D find_device_ID(device);
+	const char *devname =3D find_device_type(device);
+
+	asprintf(&label, "%s\nID: %s", devname, ID);
+	if (!label)
+		error("label allocation failed in %s\n", __func__);
+	return label;
+}
+
+static void create_root_ports(struct json_object *host_bridge, Agraph_t *g=
raph,
+		       Agnode_t *hb)
+{
+	json_object *rps, *rp, *id_json;
+	char *id, *dport_label;
+	Agnode_t *dport;
+	size_t nr_dports, idx;
+
+	assert(check_device_type(host_bridge, "Host Bridge"));
+	if (!json_object_object_get_ex(host_bridge, "dports", &rps))
+		return;
+
+	nr_dports =3D json_object_array_length(rps);
+	for (idx =3D 0; idx < nr_dports; idx++) {
+		rp =3D json_object_array_get_idx(rps, idx);
+		json_object_object_get_ex(rp, "dport", &id_json);
+		id =3D (char *)json_object_get_string(id_json);
+		asprintf(&dport_label, "Root Port\nID: %s", id);
+		if (!dport_label)
+			error("label allocation failed when creating root port nodes\n");
+		dport =3D create_node(graph, dport_label, 1);
+		agedge(graph, hb, dport, 0, 1);
+		free(dport_label);
+	}
+}
+
+static void create_downstream_ports(struct json_object *sw_port,
+		Agraph_t *graph, Agnode_t *sw)
+{
+	json_object *dps, *dp, *id_json;
+	char *id, *dport_label;
+	Agnode_t *dport;
+	size_t nr_dports, idx;
+
+	assert(check_device_type(sw_port, "Switch Port"));
+	if (!json_object_object_get_ex(sw_port, "dports", &dps))
+		return;
+
+	nr_dports =3D json_object_array_length(dps);
+	for (idx =3D 0; idx < nr_dports; idx++) {
+		dp =3D json_object_array_get_idx(dps, idx);
+		json_object_object_get_ex(dp, "dport", &id_json);
+		id =3D (char *)json_object_get_string(id_json);
+		asprintf(&dport_label, "dPort\nID: %s", id);
+		if (!dport_label)
+			error("label allocation failed when creating downstream port nodes\n");
+		dport =3D create_node(graph, dport_label, 1);
+		agedge(graph, sw, dport, 0, 1);
+		free(dport_label);
+	}
+}
+
+/* for determining number of devices listed in a json array */
+static size_t count_top_devices(struct json_object *top_array)
+{
+	size_t dev_counter =3D 0;
+	size_t top_array_len =3D json_object_array_length(top_array);
+
+	for (size_t idx =3D 0; idx < top_array_len; idx++)
+		if (is_device(json_object_array_get_idx(top_array, idx)))
+			dev_counter++;
+	return dev_counter;
+}
+
+static Agnode_t **draw_subtree(struct json_object *current_array,
+			       Agraph_t *graph)
+{
+	size_t json_array_len, nr_top_devices, obj_idx;
+	size_t idx, nr_sub_devs, nr_devs_connected;
+	char *label, *parent_dport_label;
+	Agnode_t **top_devices, **sub_devs, *parent_node;
+	bool is_hb, is_sw;
+	json_object *device, *subdev_arr, *subdev;
+	json_object_iter subdev_iter;
+
+	json_array_len =3D json_object_array_length(current_array);
+	nr_top_devices =3D count_top_devices(current_array);
+
+	if (!nr_top_devices)
+		return NULL;
+
+	top_devices =3D malloc(nr_top_devices * sizeof(device));
+	if (!top_devices)
+		error("unable to allocate memory for top_devices\n");
+
+	for (obj_idx =3D 0; obj_idx < json_array_len; obj_idx++) {
+		device =3D json_object_array_get_idx(current_array, obj_idx);
+		if (!is_device(device))
+			continue;
+
+		label =3D label_device(device);
+		top_devices[obj_idx] =3D create_node(graph, label, 1);
+
+		agsafeset(top_devices[obj_idx], "shape", "box", "");
+
+		is_hb =3D check_device_type(device, "Host Bridge");
+		is_sw =3D check_device_type(device, "Switch Port");
+
+		/* Create root port nodes if device is a host bridge */
+		if (is_hb)
+			create_root_ports(device, graph, top_devices[obj_idx]);
+		else if (is_sw)
+			create_downstream_ports(device, graph, top_devices[obj_idx]);
+
+		free(label);
+
+		/* Iterate through all keys and values of an object (device) */
+		json_object_object_foreachC(device, subdev_iter) {
+			subdev_arr =3D subdev_iter.val;
+			if (!json_object_is_type(subdev_arr, json_type_array))
+				continue;
+			nr_sub_devs =3D count_top_devices(subdev_arr);
+			sub_devs =3D draw_subtree(subdev_arr, graph);
+			if (!sub_devs)
+				continue;
+			if (!is_hb && !is_sw) {
+				for (idx =3D 0; idx < nr_sub_devs; idx++)
+					agedge(graph, top_devices[obj_idx], sub_devs[idx], 0, 1);
+				free(sub_devs);
+				continue;
+			}
+
+			nr_devs_connected =3D 0;
+			for (idx =3D 0;
+			     idx < json_object_array_length(subdev_arr);
+			     idx++) {
+				subdev =3D json_object_array_get_idx(subdev_arr, idx);
+				if (!is_device(subdev))
+					continue;
+
+				if (is_hb)
+					parent_dport_label =3D find_root_port_label(subdev);
+				else
+					parent_dport_label =3D find_parent_dport_label(subdev);
+				if (!parent_dport_label) {
+					error("please use cxl input with parent_dport attributes\n");
+					return NULL;
+				}
+				/* with flag =3D 0, it will search to locate an existing node */
+				parent_node =3D create_node(graph, parent_dport_label, 0);
+				agedge(graph, parent_node, sub_devs[nr_devs_connected], 0, 1);
+				free(parent_dport_label);
+				nr_devs_connected++;
+			}
+			free(sub_devs);
+		}
+	}
+
+	return top_devices;
+}
+
+struct json_object *parse_json_text(const char *path)
+{
+	FILE *fp;
+	char *json_as_string;
+	size_t file_len;
+	json_object *json;
+
+	fp =3D fopen(path, "r");
+	if (!fp)
+		error("could not read file\n");
+	fseek(fp, 0, SEEK_END);
+	file_len =3D ftell(fp);
+	fseek(fp, 0, SEEK_SET);
+	json_as_string =3D malloc(file_len + 1);
+	if (!json_as_string ||
+	    fread(json_as_string, 1, file_len, fp) !=3D file_len) {
+		free(json_as_string);
+		error("could not read file %s\n", path);
+	}
+	json_as_string[file_len] =3D '\0';
+	json =3D json_tokener_parse(json_as_string);
+	return json;
+}
+
+int output_file_type(const char *file_name)
+{
+	/* skip ./, ../ in the path */
+	char *of_extension =3D strrchr(file_name, '/');
+
+	if (!of_extension)
+		of_extension =3D (char *)file_name;
+	else
+		of_extension +=3D 1;
+
+	of_extension =3D strrchr(of_extension, '.');
+	if (!of_extension)
+		return FILE_PLAIN;
+	of_extension +=3D 1;
+	if (!strcmp(of_extension, "json") ||
+			!strcmp(of_extension, "log") || !strcmp(of_extension, "txt"))
+		return FILE_PLAIN;
+	else if ((strcmp(of_extension, "png") && strcmp(of_extension, "jpeg") &&
+				strcmp(of_extension, "jpg"))) {
+		error("Unsupported output file type: %s", file_name);
+		return FILE_UNSUPPORTED;
+	} else
+		return FILE_GRAPH;
+}
+
+void create_image(const char *filename, json_object *platform)
+{
+	char *output_file =3D (char *)filename;
+	GVC_t *gvc;
+	Agraph_t *graph;
+	char *of_extension =3D strrchr(output_file, '.') + 1;
+	Agnode_t **top_devices;
+	FILE *FP;
+
+	gvc =3D gvContext();
+	if (!gvc) {
+		error("Creating gvContext failed when trying to create cxl image");
+		return;
+	}
+	graph =3D agopen("graph", Agdirected, 0);
+	if (!graph) {
+		error("Trying to agopen failed when trying to create cxl image");
+		goto free_ctx;
+	}
+
+	if (!of_extension || (strcmp(of_extension, "png") &&
+			      strcmp(of_extension, "jpeg") &&
+			      strcmp(of_extension, "jpg"))) {
+		error("Unacceptable output file type, please use .png, .jpeg, or .jpg\n"=
);
+		goto close_graph;
+	}
+
+	top_devices =3D draw_subtree(platform, graph);
+	if (top_devices)
+		free(top_devices);
+
+	if (gvLayout(gvc, graph, "dot")) {
+		error("Calling gvLayout failed when trying to create cxl image");
+		goto close_graph;
+	}
+
+	FP =3D fopen(output_file, "w");
+	if (!FP) {
+		error("Creating %s for storing the graph failed", output_file);
+		goto create_exit;
+	} else {
+		gvRender(gvc, graph, strrchr(output_file, '.') + 1, FP);
+		fclose(FP);
+	}
+
+create_exit:
+	gvFreeLayout(gvc, graph);
+close_graph:
+	agclose(graph);
+free_ctx:
+	gvFreeContext(gvc);
+}
diff --git a/cxl/graph.h b/cxl/graph.h
new file mode 100644
index 0000000..1777ce9
--- /dev/null
+++ b/cxl/graph.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Fan Ni <fan.ni@samsung.com> */
+/* Copyright (C) 2022 Matthew Ho <sunfishho12@gmail.com> */
+#ifndef _CXL_TOPOLOGY_GRAPH_H_
+#define _CXL_TOPOLOGY_GRAPH_H_
+
+#include <stdbool.h>
+#include <json-c/json.h>
+
+enum output_file_type {
+		FILE_PLAIN,
+		FILE_GRAPH,
+		FILE_UNSUPPORTED,
+};
+
+struct json_object;
+void create_image(const char *filename, json_object *platform);
+int output_file_type(const char *file_name);
+struct json_object *parse_json_text(const char *path);
+#endif
diff --git a/cxl/json.c b/cxl/json.c
index ac1b0b5..c8a2f89 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -306,6 +306,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_=
memdev *memdev,
 	const char *devname =3D cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
 	unsigned long long serial;
+	const char *parent_dport =3D cxl_memdev_get_parent_dport(memdev);
 	int numa_node;
=20
 	jdev =3D json_object_new_object();
@@ -348,9 +349,11 @@ struct json_object *util_cxl_memdev_to_json(struct cxl=
_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);
=20
-	jobj =3D json_object_new_string(cxl_memdev_get_parent_dport(memdev));
-	if (jobj)
-		json_object_object_add(jdev, "parent_dport", jobj);
+	if (parent_dport) {
+		jobj =3D json_object_new_string(cxl_memdev_get_parent_dport(memdev));
+		if (jobj)
+			json_object_object_add(jdev, "parent_dport", jobj);
+	}
=20
 	if (!cxl_memdev_is_enabled(memdev)) {
 		jobj =3D json_object_new_string("disabled");
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 27ffee0..78cd509 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1269,8 +1269,12 @@ CXL_EXPORT const char *cxl_memdev_get_firmware_veris=
on(struct cxl_memdev *memdev
=20
 CXL_EXPORT const char *cxl_memdev_get_parent_dport(struct cxl_memdev *memd=
ev)
 {
-	struct cxl_port *port =3D cxl_endpoint_get_port(memdev->endpoint);
+	struct cxl_port *port;
+
+	if (!memdev->endpoint)
+		return NULL;
=20
+	port =3D cxl_endpoint_get_port(memdev->endpoint);
 	if (port)
 		return cxl_port_get_parent_dport(port);
=20
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 588ad00..7ad0928 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -61,6 +61,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void=
 *buf, size_t length,
 		size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t le=
ngth,
 		size_t offset);
+const char *cxl_memdev_get_host_path(struct cxl_memdev *memdev);
=20
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev =3D cxl_memdev_get_first(ctx); \
diff --git a/cxl/list.c b/cxl/list.c
index 8c48fbb..005ff59 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -11,6 +11,7 @@
 #include <util/parse-options.h>
=20
 #include "filter.h"
+#include "graph.h"
=20
 static struct cxl_filter_params param;
 static bool debug;
@@ -52,6 +53,11 @@ static const struct option options[] =3D {
 		    "include memory device health information"),
 	OPT_BOOLEAN('I', "partition", &param.partition,
 		    "include memory device partition information"),
+	OPT_STRING(0, "input", &param.input_file,
+		   "input file path for creating topology image",
+		   "path to file containing a json array describing the topology"),
+	OPT_STRING('o', "output-file", &param.output_file, "output file path",
+		   "path to file to generate graph or dump cxl topology to"),
 	OPT_INCR('v', "verbose", &param.verbose,
 		 "increase output detail"),
 #ifdef ENABLE_DEBUG
@@ -73,6 +79,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx =
*ctx)
 		NULL
 	};
 	int i;
+	json_object *platform;
=20
 	argc =3D parse_options(argc, argv, options, u, 0);
 	for (i =3D 0; i < argc; i++)
@@ -86,6 +93,24 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx=
 *ctx)
 		usage_with_options(u, options);
 	}
=20
+	if (param.output_file)
+		param.dump_to_file =3D true;
+
+	if (param.input_file) {
+		if (access(param.input_file, R_OK)) {
+			error("input file %s cannot be accessed\n", param.input_file);
+			return 0;
+		}
+		platform =3D parse_json_text(param.input_file);
+		if (!param.output_file) {
+			warning("no output file name given, using topology.png");
+			create_image("topology.png", platform);
+		} else
+			create_image(param.output_file, platform);
+
+		return 0;
+	}
+
 	if (num_list_flags() =3D=3D 0) {
 		if (param.memdev_filter || param.serial_filter)
 			param.memdevs =3D true;
@@ -108,6 +133,12 @@ int cmd_list(int argc, const char **argv, struct cxl_c=
tx *ctx)
 		param.memdevs =3D true;
 	}
=20
+	if (param.dump_to_file) {
+		param.verbose =3D 3;
+		param.endpoints =3D false;
+		param.memdevs =3D true;
+	}
+
 	switch(param.verbose){
 	default:
 	case 3:
diff --git a/cxl/meson.build b/cxl/meson.build
index f2474aa..5decb11 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -7,6 +7,7 @@ cxl_src =3D [
   'memdev.c',
   'json.c',
   'filter.c',
+  'graph.c',
 ]
=20
 cxl_tool =3D executable('cxl',
@@ -19,6 +20,7 @@ cxl_tool =3D executable('cxl',
     kmod,
     json,
     versiondep,
+    graphviz,
   ],
   install : true,
   install_dir : rootbindir,
diff --git a/meson.build b/meson.build
index 20a646d..9fb1161 100644
--- a/meson.build
+++ b/meson.build
@@ -142,6 +142,7 @@ kmod =3D dependency('libkmod')
 libudev =3D dependency('libudev')
 uuid =3D dependency('uuid')
 json =3D dependency('json-c')
+graphviz =3D dependency('libgvc')
 if get_option('docs').enabled()
   if get_option('asciidoctor').enabled()
     asciidoc =3D find_program('asciidoctor', required : true)
diff --git a/util/json.c b/util/json.c
index 1d5c6bc..da709a1 100644
--- a/util/json.c
+++ b/util/json.c
@@ -106,7 +106,7 @@ void util_display_json_array(FILE *f_out, struct json_o=
bject *jarray,
 		unsigned long flags)
 {
 	int len =3D json_object_array_length(jarray);
-	int jflag =3D JSON_C_TO_STRING_PRETTY;
+	int jflag =3D JSON_C_TO_STRING_PRETTY | JSON_C_TO_STRING_NOSLASHESCAPE;
=20
 	if (len > 1 || !(flags & UTIL_JSON_HUMAN)) {
 		if (len =3D=3D 0)
--=20
2.25.1
