Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC00C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLTS0q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiLTS0n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 13:26:43 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80391DDC4
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 10:26:42 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221220182641usoutp0242e4921de39315eeff48d704c1936829~yk7FoU4NG0260902609usoutp022;
        Tue, 20 Dec 2022 18:26:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221220182641usoutp0242e4921de39315eeff48d704c1936829~yk7FoU4NG0260902609usoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671560801;
        bh=oSHgjXIf0ZX3rS95Kbwm1NmPSQQihG1pgrpZ28manmA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GPBF9Tjh/xOPcORJG7ZD5EP4ooddEh0PCOo49e5k5FlWoERyXnOMLGd7k0hJVh7cn
         2GkE2+vTOR3q3InjaoFJOUtFCA+siQbfc6UrYLGTDzB+rsxgPhfflGTFeHzBy/bhGx
         lNmF4N62Eg66pEsqEo3xlRhv3VkV0He5gduIlJTw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221220182641uscas1p229e4a98e4ee88d34ca9d62345b40ec8b~yk7FeW4hu0570505705uscas1p2G;
        Tue, 20 Dec 2022 18:26:41 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 46.81.51548.16EF1A36; Tue,
        20 Dec 2022 13:26:41 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221220182641uscas1p24e70ddc9f912de0f3912028420854fb1~yk7FNZEQ11135511355uscas1p2B;
        Tue, 20 Dec 2022 18:26:41 +0000 (GMT)
X-AuditID: cbfec36f-a9bfe7000002c95c-0a-63a1fe6153e9
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F2.48.07107.16EF1A36; Tue,
        20 Dec 2022 13:26:41 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 20 Dec 2022 10:26:40 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        20 Dec 2022 10:26:40 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH 1/2] cxl-list: add `parent_dport` to cxl_port/memdev
 objects
Thread-Topic: [ndctl PATCH 1/2] cxl-list: add `parent_dport` to
        cxl_port/memdev objects
Thread-Index: AQHZFKCaOmcvc8eDq0mTxCsoX7geTw==
Date:   Tue, 20 Dec 2022 18:26:40 +0000
Message-ID: <20221220182510.2734032-2-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djX87qJ/xYmG7TNU7aYPvUCo8Xqm2sY
        Lc7POsVi0fhzEaPFrQnHmBxYPXbOusvusXjPSyaPqbPrPT5vkgtgieKySUnNySxLLdK3S+DK
        WHqji63gqWbF5V/32BsYe5S7GDk5JARMJL4t7GbvYuTiEBJYySjx6u9dKKeVSeLQ78dsXYwc
        YFWnnmdBxNcyStxb/Amq6BOjxLRnU5ggnGWMEo93fWYCmcsmoCixr2s7G4gtImAtMaFhCRtI
        EbPATCaJq9+mgxUJC4RItL74ww5RFClx+vdxVghbT2Lan/fMIDaLgKrEzevbwWxeAUuJV3un
        gfVyClhJfN6ymhHEZhQQk/h+ag1YnFlAXOLWk/lMEM8JSiyavYcZwhaT+LfrIRuErShx//tL
        doh6PYkbU6ewQdjaEssWvobaJShxcuYTFoh6SYmDK26wgDwgIbCWQ+LRvytQg1wkevt/Qi2Q
        lpi+5jJUQ75Ez44TjBB2hcTL2SvYIWxriYV/1kMdyifx99cjxgmMyrOQ3D0LyU2zkNw0C8lN
        CxhZVjGKlxYX56anFhvlpZbrFSfmFpfmpesl5+duYgSmmtP/DufvYLx+66PeIUYmDsZDjBIc
        zEoivBeOLEwW4k1JrKxKLcqPLyrNSS0+xCjNwaIkztu9dX6ykEB6YklqdmpqQWoRTJaJg1Oq
        galF5/XJiP35PkJ2q6eelCqfUWiqa3PuZn4gx6vreiVX/nR4fH0sLiWz4bPudYn9px/c10p+
        wLL59ZoVaw06mfvem94R6slsOHzg89frfAm72uYedj9uL69s/ijamiFrhfCcnYJyj+4fmlMu
        sHTLhqSJVnGMK/j2/WIUeimz/bDcWattArX35S/ENd16d1jm2OR3J5mcFjbIX7LfnOqzVWFq
        6tcSYe7NX00+t56InKivY55fUzapweLrLNGe8jabH+vliqwW325ceafddoa86uMNKwzL5x6J
        mRa37MzrVfkRX3P7jLQ2LXH5KBP+xZdtUd21d+l3Ocs2urRGlGi8XH3vSFPjlPP+f84Ji69P
        Uj2mxFKckWioxVxUnAgAO43/WKQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWS2cA0UTfx38Jkg2XNIhbTp15gtFh9cw2j
        xflZp1gsGn8uYrS4NeEYkwOrx85Zd9k9Fu95yeQxdXa9x+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        S290sRU81ay4/OseewNjj3IXIweHhICJxKnnWV2MnBxCAqsZJVZe1YKwPzFKLDwo1cXIBWQv
        Y5R42PKVFSTBJqAosa9rOxuILSJgLTGhYQkbSBGzwEwmiavfpjOBJIQFQiRaX/xhhyiKlOjv
        vwtl60lM+/OeGcRmEVCVuHl9O5jNK2Ap8WrvNCaIzZYSbesfgi3jFLCS+LxlNSOIzSggJvH9
        1BqwGmYBcYlbT+aD2RICAhJL9pxnhrBFJV4+/scKYStK3P/+kh2iXk/ixtQpbBC2tsSyha+h
        9gpKnJz5hAWiXlLi4IobLBMYxWchWTELSfssJO2zkLQvYGRZxSheWlycm15RbJyXWq5XnJhb
        XJqXrpecn7uJERiJp/8djtnBeO/WR71DjEwcjIcYJTiYlUR4LxxZmCzEm5JYWZValB9fVJqT
        WnyIUZqDRUmc1yN2YryQQHpiSWp2ampBahFMlomDU6qBycC6a6LOOcO65C7/gOkTJl455iYe
        lrykO0fj7961H9f8lZ1Rt2A5f7wW7/v7vbc1/m6etH+vssefuW3lvfXfK66z3HovG9sjKyiy
        MOueXEC/3OMLWQ4LjexXCvKoLOyV/yhT6nHwuuC0pku+9uKsijt/Tn03N7BwSZVJ6JfqmqaN
        SWrH/3b0yRTX+3YwZdz9a+nz3v33mZW939yt1/fFhRf87ppzgcO3oiP60YYgtddnnJ8wMmv/
        X/v9SCfDLcFD666YCBsH6JVnVfQVP9EtnfbP+VCY3c2zvb8DJ5548ve9tnCc4EmW14ILMl5c
        8/tlz8DTu3L2vbPa6iwZkXOCPK46FAdFhajr1ORvmaegxFKckWioxVxUnAgAXfF2bjMDAAA=
X-CMS-MailID: 20221220182641uscas1p24e70ddc9f912de0f3912028420854fb1
CMS-TYPE: 301P
X-CMS-RootMailID: 20221220182641uscas1p24e70ddc9f912de0f3912028420854fb1
References: <20221220182510.2734032-1-fan.ni@samsung.com>
        <CGME20221220182641uscas1p24e70ddc9f912de0f3912028420854fb1@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The parent_dport attribute reprents the downstream port that the current
device (cxl_port/cxl_memdev) is attached to. It will help to track the
topology when plotting the cxl graph

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 cxl/json.c         |  8 ++++++++
 cxl/lib/libcxl.c   | 39 +++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  6 ++++++
 cxl/lib/private.h  |  1 +
 cxl/libcxl.h       |  2 ++
 5 files changed, 56 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index 63c1751..ac1b0b5 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -348,6 +348,10 @@ struct json_object *util_cxl_memdev_to_json(struct cxl=
_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);
=20
+	jobj =3D json_object_new_string(cxl_memdev_get_parent_dport(memdev));
+	if (jobj)
+		json_object_object_add(jdev, "parent_dport", jobj);
+
 	if (!cxl_memdev_is_enabled(memdev)) {
 		jobj =3D json_object_new_string("disabled");
 		if (jobj)
@@ -769,6 +773,10 @@ static struct json_object *__util_cxl_port_to_json(str=
uct cxl_port *port,
 	if (jobj)
 		json_object_object_add(jport, "host", jobj);
=20
+	jobj =3D json_object_new_string(cxl_port_get_parent_dport(port));
+	if (jobj)
+		json_object_object_add(jport, "parent_dport", jobj);
+
 	jobj =3D json_object_new_int(cxl_port_get_depth(port));
 	if (jobj)
 		json_object_object_add(jport, "depth", jobj);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d44..27ffee0 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1267,6 +1267,16 @@ CXL_EXPORT const char *cxl_memdev_get_firmware_veris=
on(struct cxl_memdev *memdev
 	return memdev->firmware_version;
 }
=20
+CXL_EXPORT const char *cxl_memdev_get_parent_dport(struct cxl_memdev *memd=
ev)
+{
+	struct cxl_port *port =3D cxl_endpoint_get_port(memdev->endpoint);
+
+	if (port)
+		return cxl_port_get_parent_dport(port);
+
+	return NULL;
+}
+
 static void bus_invalidate(struct cxl_bus *bus)
 {
 	struct cxl_ctx *ctx =3D cxl_bus_get_ctx(bus);
@@ -1447,6 +1457,24 @@ CXL_EXPORT int cxl_memdev_nvdimm_bridge_active(struc=
t cxl_memdev *memdev)
 	return is_enabled(path);
 }
=20
+static struct cxl_dport *cxl_port_find_parent_dport(struct cxl_port *port,
+			struct cxl_port *parent_port)
+{
+	struct cxl_dport *dport;
+
+	if (parent_port && parent_port->nr_dports) {
+		cxl_dport_foreach(parent_port, dport) {
+			/* HB ACPI0016 can have only one dport and being itself */
+			if (!strcmp(port->uport, dport->dev_path))
+				return NULL;
+			if (strstr(port->uport, dport->dev_path))
+				return dport;
+		}
+	}
+
+	return NULL;
+}
+
 static int cxl_port_init(struct cxl_port *port, struct cxl_port *parent_po=
rt,
 			 enum cxl_port_type type, struct cxl_ctx *ctx, int id,
 			 const char *cxlport_base)
@@ -1486,6 +1514,8 @@ static int cxl_port_init(struct cxl_port *port, struc=
t cxl_port *parent_port,
 	if (!port->uport)
 		goto err;
=20
+	port->parent_dport =3D cxl_port_find_parent_dport(port, parent_port);
+
 	sprintf(path, "%s/modalias", cxlport_base);
 	if (sysfs_read_attr(ctx, path, buf) =3D=3D 0)
 		port->module =3D util_modalias_to_module(ctx, buf);
@@ -2404,6 +2434,15 @@ CXL_EXPORT struct cxl_port *cxl_port_get_parent(stru=
ct cxl_port *port)
 	return port->parent;
 }
=20
+CXL_EXPORT const char *cxl_port_get_parent_dport(struct cxl_port *port)
+{
+	if (port->parent_dport)
+		return devpath_to_devname(port->parent_dport->dev_path);
+	else if (port->parent)
+		return devpath_to_devname(port->parent->uport);
+	return NULL;
+}
+
 CXL_EXPORT bool cxl_port_is_root(struct cxl_port *port)
 {
 	return port->type =3D=3D CXL_PORT_ROOT;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..33f3bba 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -217,3 +217,9 @@ global:
 	cxl_decoder_get_max_available_extent;
 	cxl_decoder_get_region;
 } LIBCXL_2;
+
+LIBCXL_4 {
+global:
+	cxl_memdev_get_parent_dport;
+	cxl_port_get_parent_dport;
+}LIBCXL_3;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 437eade..ee7d769 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -71,6 +71,7 @@ struct cxl_port {
 	struct cxl_bus *bus;
 	enum cxl_port_type type;
 	struct cxl_port *parent;
+	struct cxl_dport *parent_dport;
 	struct kmod_module *module;
 	struct list_node list;
 	struct list_head child_ports;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..588ad00 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -34,6 +34,7 @@ void cxl_set_private_data(struct cxl_ctx *ctx, void *data=
);
 void *cxl_get_private_data(struct cxl_ctx *ctx);
=20
 struct cxl_memdev;
+const char *cxl_memdev_get_parent_dport(struct cxl_memdev *memdev);
 struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
 struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
 int cxl_memdev_get_id(struct cxl_memdev *memdev);
@@ -81,6 +82,7 @@ int cxl_bus_disable_invalidate(struct cxl_bus *bus);
 	     bus =3D cxl_bus_get_next(bus))
=20
 struct cxl_port;
+const char *cxl_port_get_parent_dport(struct cxl_port *port);
 struct cxl_port *cxl_port_get_first(struct cxl_port *parent);
 struct cxl_port *cxl_port_get_next(struct cxl_port *port);
 const char *cxl_port_get_devname(struct cxl_port *port);
--=20
2.25.1
