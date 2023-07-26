Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DFAC001DC
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 18:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGZSLC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGZSLB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 14:11:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1051FF5
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1690395044; x=1690999844; i=fan.ni@gmx.us;
 bh=4oG1eZ0c999l6zeP2mfz6dhnLMAIsj76o/S0EDXHkRU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=msWtZWox5+AdgbW9JJcLYsnK2+eAN0xeCDMD4RfZvrdPHfyofjv7/qjqdIqfdzKHOVorh8C
 syTihKQ4P4ujO+RwtiLl4APJJjeK+gOKpd8q06jO7Vv4iMWK9UhHOK3Y5aUHtRxQarUAO8Qdm
 BK4NNfRQoc1rgHP2wJt+yX589ATXmlGadsfrWmijikP9lAjNrVn9pQouNgrocx8LZjlZgf5Dn
 0HLj8SKQc0LDLGEW7FojGuRwiqFndUEMUeDh7PzfHimxIgy5GJ0TzchwRpUAsOVwwNo4n95bs
 yuVWVT7C5KyONOgtVhfWjdVVqKwTZb9jgK0bibwvt+QLUeTfyFDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([172.58.46.179]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MeCtZ-1pr2mK2K19-00bK6n; Wed, 26 Jul 2023 20:10:44 +0200
From:   fan.ni@gmx.us
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, sunfishho12@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH v2 RESEND 1/2] cxl/list: Add parent_dport attribute to memdev and root port listing
Date:   Wed, 26 Jul 2023 11:09:54 -0700
Message-Id: <20230726180955.88834-2-fan.ni@gmx.us>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726180955.88834-1-fan.ni@gmx.us>
References: <20230726180955.88834-1-fan.ni@gmx.us>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ZtfGhHuTTpJDYK78E6v2qRWc6jGAH45TJQGWfSuP4WOxLYR4SO
 09D1nml5KhM5nNsM+tiPici8sBRpL588hdfFDD8wdnN3GEXYUovAhoonAsE4VGntfC7Wfe+
 8rz5cWSsmDXJtL2xD3Z13lsl1qwacUZTEqdTfQUh1nWHSWLNhan24awG8RU54Z8kVOqVS55
 yAAENgulU756dVVqSGjuA==
UI-OutboundReport: notjunk:1;M01:P0:q8oatvyOVQ8=;RhNyXtDwOr8aw0jg5txkm6wVIBk
 sTP0Bo0A5VQm68K2VfeK2AKaPSG2gcra5uY8KsKcharj3cG33k9JzxD/zO9LeP9pQ7UeZXgyT
 +MiuUBROC94NfRiM4iB8xVr+fq60t9zv/6BL6US7TEHecF65tim32nTC+hbNq1M7wumOz2XVv
 UugeMwROSBQJJUudeUEltQPZ8OjxvyA5WZdij8F4SuJ5lLRVTARokLDlD4z7+uw9H34pgIHfa
 qkDxMqCkPp3yIiC+rtqDrj4kxAV3C5EhYiTYtk9sWPnWGTHRqi3Qia5kXMb4jaFdi93DPfoU7
 6U1I09kXzBsUg24oOA9srMraEPcd0FhnK0gl3awyMLV+LJYieF4TWzHOt5FaYnf8I/H3HCkp4
 84+ka5lBCG69kKarCR7bCjf+HpCHGt1PyfbCmJqKiGZHH7Pic39zz8W1pwRURn31oJtaXBsTB
 H2J0t3QrG+XBrE5/h8N0oj+dqkkVrU5JTbETQ54O4bZ3YuZY+06ix5G/dgpyWWwYHrj6QV8RH
 XwoZYubAhutpQN+Id4Y572FwKPkCaqj8IbYVpFElCfDGhT37HWR0Rajtah/qj08Gsz0FHDwv9
 jzumUhgyQVICoGBR+TJk6j4meMySoOe2/wbdNUFgzYkvN2CfJPzS13H2e86TukdiPFBeserGY
 ZPnhejPb0Z2YLPHRQw5S4e/yyd3ddBtuJ6DVq+xm9qtgk44ivMVBQ9yDrLsnt6xWk/QQIcfyd
 4+CmV/zTHQ1okmt/RLiRO/JYaUG0SKELY/fd6BaFMrGBzCmEGd3OkH77ZhzWXXEfUkkdBUlt9
 BQc7MiHeow8K7aEqhDQJ/TpzCdTBxZ6e42aTsEtr3+3Nj9/PKNqNIV1xhJfVnAhpu4jMOjFKk
 FpI7KM/WA1HTqvH7DWFIq+PEmNsH2dJeBl39IHkVklXNVANiA9rk8md4KgjIPgqsaE4K4Q0R1
 0uFm1Tk9yWmTgm1ra3WAVUn8O+w=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add `parent_dport` attribute to memdev and root port when listing by
leveraging cxl_port_get_parent_dport function. The attribute will be
used to describe the cxl topology when plotting cxl topology graph.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
=2D--
 cxl/json.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index 9a4b5c7..f7600dc 100644
=2D-- a/cxl/json.c
+++ b/cxl/json.c
@@ -540,6 +540,23 @@ struct json_object *util_cxl_memdev_to_json(struct cx=
l_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);

+	/* add parent_dport attribute to memdev */
+	if (cxl_memdev_get_endpoint(memdev)) {
+		struct cxl_endpoint *ep =3D cxl_memdev_get_endpoint(memdev);
+
+		if (ep) {
+			struct cxl_port *port =3D cxl_endpoint_get_port(ep);
+
+			if (cxl_port_get_parent_dport(port)) {
+				struct cxl_dport *dport =3D cxl_port_get_parent_dport(port);
+
+				jobj =3D json_object_new_string(cxl_dport_get_devname(dport));
+				if (jobj)
+					json_object_object_add(jdev, "parent_dport", jobj);
+			}
+		}
+	}
+
 	if (!cxl_memdev_is_enabled(memdev)) {
 		jobj =3D json_object_new_string("disabled");
 		if (jobj)
@@ -1009,9 +1026,9 @@ static struct json_object *__util_cxl_port_to_json(s=
truct cxl_port *port,
 		struct cxl_dport *dport =3D cxl_port_get_parent_dport(port);

 		jobj =3D json_object_new_string(cxl_dport_get_devname(dport));
-		if (jobj)
-			json_object_object_add(jport, "parent_dport", jobj);
-	}
+	} else
+		jobj =3D json_object_new_string("ACPI0017:00");
+	json_object_object_add(jport, "parent_dport", jobj);

 	jobj =3D json_object_new_int(cxl_port_get_depth(port));
 	if (jobj)
=2D-
2.39.2

