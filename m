Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AAEC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbjEKSJr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbjEKSJm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:09:42 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398172B
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:09:18 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511180853usoutp02c66a453db156e3822839d633a574e85c~eKSE0H2HT0177901779usoutp02O;
        Thu, 11 May 2023 18:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511180853usoutp02c66a453db156e3822839d633a574e85c~eKSE0H2HT0177901779usoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683828533;
        bh=iuLQl1nQB7qD4w1axqepo3ZBhxSbzcMtyqspZby93t4=;
        h=From:To:CC:Subject:Date:References:From;
        b=ekF5J8+Yw+Cx19T+awrR4zKSljeguVCXhjs7b3eM7X+zVT6E3L7VsOZvGZgPQtOd2
         UHfiJn8nCLmT5OEJSItKlsJVXH4IBfGuJj7citL0atNoFh4kitvUewWE+d5ba9916m
         XhAS1FCNOFjY2wqKBFbgA0wg8it+fp872U3NVDdk=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511180853uscas1p1e6e776909d9ea82ac7c96803f88ba9e3~eKSEoJ0Xy0347303473uscas1p19;
        Thu, 11 May 2023 18:08:53 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id ED.8C.42611.43F2D546; Thu,
        11 May 2023 14:08:52 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511180852uscas1p12736929a3b7da261a94fe661f151cc66~eKSER8DHh0346803468uscas1p1E;
        Thu, 11 May 2023 18:08:52 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-96-645d2f341f76
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 5F.78.64580.43F2D546; Thu,
        11 May 2023 14:08:52 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 11:08:51 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 11:08:51 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl RFC] cxl/region: Add support to create dc region for dynamic
 capacity device
Thread-Topic: [ndctl RFC] cxl/region: Add support to create dc region for
        dynamic capacity device
Thread-Index: AQHZhDOkW8NLFMp5JkGvotudMJAplg==
Date:   Thu, 11 May 2023 18:08:51 +0000
Message-ID: <20230511180757.2091508-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917t10X1nVKOyUkLQtMmz2EZqlUFKzoafS0h0tvam4zttnD
        hEyNcFRu6FJny0ydWbMoLV2K1hR7c8uUdGTWUsxSqIZaZpLzLvC/z+98v+ec74EfiQuMnDlk
        glJDq5QyuYjLJx60DDGLQ4IPxC5pGg+T5BleI8mtTguSMMbnhKRP34dJykoduMSua8FWc6VW
        YxdPWlLfj0mrvn3BpYbCM1LnvbnbOPv4YbG0POE4rQqOiObHZ324yDs2GHgyy6zjpaEKfy3y
        IIEKgYonxUiL+KSAqkBwOfMpzj7OYeA8W8377zLZznJYoRLBUHY64RIE1E8EpjcaVjAjMJja
        Jju41Dxo0NZwXexDrQJdWinXZcKplxh8cBRxXII3dRCemnLdphi42lHrZjGUWMcnPQS1AKxj
        fZiLPalQqC4ZmlyAqFkw8twyWccpIdh7ijA2qhdcL6zHWZ4F4w8/cVn2g5xf+W6eB90j/Ty2
        VwwdBjYDTgWCufgbzu7ygmcFPQTrnw2Pb3QQrgOAqiShW292L1gHZQUD7qG+kGd5O2EiJzgG
        bv7gs2U5FJVWu+esguKxO+7MM+DvqAPp0HzjlBOMUyIZp0QyTol0DRE3kTBZrVbE0eplSvqE
        WC1TqJOVceKYJMU9NPF9Xow3JdWid/YfYhvCSGRDQOIiH8/B0qhYgWes7FQKrUo6pEqW02ob
        8iUJkdBzafizGAEVJ9PQiTR9jFb9VzHSY04aJkx13LXbiDjN6ul5zBnBcFD8SWb73D1/VR4p
        OizykimhUlvQ079nZcSVRqm/qNC6e+sufWb6WAaGZ4s6XkV9z2glN5wK6BfyDQtG7PXto5ua
        Mp0RKf73w9sjtb3+n+qiNtxorRpprGCCPKS6ttyM23WzhwPnN4+Vd+pTBwKCOk2XvoST3fuP
        Nh6uzLMEK444RtvWFnY5czbCW/v78vsN5iX5ke+0a7IvWJtNy5lmx0JLjbJox5/srL2Md13v
        zK71w4rPFr/QW5vl0flpv8tDhx75rZjOfCy37/86DdJHE5k/j1P1p/s055xb8N7NIedbVjw6
        UeV7vDVs5wHHwPLPHBGhjpctXYSr1LJ/TnKwYK0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWS2cA0UddEPzbF4PMFJYvpUy8wWqy+uYbR
        4vysUywWzyc+Z7JYuuQRs8WtCceYHNg8ds66y+6xeM9LJo/Nr18we0ydXe/xeZNcAGsUl01K
        ak5mWWqRvl0CV0bnvV72grfaFZ3LJrA3MK5U6WLk5JAQMJGYe6iRFcQWEljNKLGmO6qLkQvI
        /sQosWXPQkaIxDJGictnBUBsNgFFiX1d29lAbBEBa4kJDUvYQBqYBc4wSdx7NB9skrBAnMSJ
        uVOgipIlXm97zAJh60ks3vkPrIZFQFVi55/nTCA2r4ClxJbFX9lBbEYBMYnvp9aAxZkFxCVu
        PZnPBHGpgMSSPeeZIWxRiZePIeZICMhLTP4xgw3CVpS4//0lO0SvnsSNqRA3MAtoSyxb+JoZ
        YpegxMmZT1gg6iUlDq64wTKBUWwWknWzkLTPQtI+C0n7AkaWVYzipcXFuekVxcZ5qeV6xYm5
        xaV56XrJ+bmbGIFxePrf4ZgdjPdufdQ7xMjEwXiIUYKDWUmE9+2S6BQh3pTEyqrUovz4otKc
        1OJDjNIcLErivB6xE+OFBNITS1KzU1MLUotgskwcnFINTFO09Jsk3X/+T/fJW/dQ4NeMEpv4
        3bGyq3mvyXHcS/grOOtHt6bEpPl7V4ReTOTMvbn9sOHBuhUrdb0Umrw0+dc91zGLrbC/LGKp
        U6HOsbnipuhyrWeTFszYoOx0Iiegk4H/Z/lbe/c0zuxnXC+Wl+7edM/rRZpX95sL23q+fN/G
        3GHs/TJkt2ZPWu+Di7Ulh13Nloemm/Jd0N6ct11m/bNfn39mtis4F8391PSdn8el6dzpNw33
        Uj115eV2tq/ZtDV854EL029yl8kdeCcWN33f0Zyzl+cFK0q03kj5Nlell3urz1TRNX4ra3QZ
        /jIb57+OEBHgmZRuwfuy9a6xxJmNojvTkqoF8u890j+zVYmlOCPRUIu5qDgRAMJ1HUgyAwAA
X-CMS-MailID: 20230511180852uscas1p12736929a3b7da261a94fe661f151cc66
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511180852uscas1p12736929a3b7da261a94fe661f151cc66
References: <CGME20230511180852uscas1p12736929a3b7da261a94fe661f151cc66@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add a new region type "dc" and function to support creating dc region
for dynamic capacity device.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 cxl/lib/libcxl.c   | 13 +++++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/libcxl.h       |  5 +++++
 cxl/region.c       | 17 ++++++++++++++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 769cd8a..ecdc242 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1886,6 +1886,8 @@ static void *add_cxl_decoder(void *parent, int id, co=
nst char *cxldecoder_base)
 			decoder->mode =3D CXL_DECODER_MODE_RAM;
 		else if (strcmp(buf, "pmem") =3D=3D 0)
 			decoder->mode =3D CXL_DECODER_MODE_PMEM;
+		else if (strcmp(buf, "dc") =3D=3D 0)
+			decoder->mode =3D CXL_DECODER_MODE_DC;
 		else if (strcmp(buf, "mixed") =3D=3D 0)
 			decoder->mode =3D CXL_DECODER_MODE_MIXED;
 		else if (strcmp(buf, "none") =3D=3D 0)
@@ -2189,6 +2191,9 @@ CXL_EXPORT int cxl_decoder_set_mode(struct cxl_decode=
r *decoder,
 	case CXL_DECODER_MODE_RAM:
 		sprintf(buf, "ram");
 		break;
+	case CXL_DECODER_MODE_DC:
+		sprintf(buf, "dc");
+		break;
 	default:
 		err(ctx, "%s: unsupported mode: %d\n",
 		    cxl_decoder_get_devname(decoder), mode);
@@ -2314,6 +2319,8 @@ static struct cxl_region *cxl_decoder_create_region(s=
truct cxl_decoder *decoder,
 		sprintf(path, "%s/create_pmem_region", decoder->dev_path);
 	else if (mode =3D=3D CXL_DECODER_MODE_RAM)
 		sprintf(path, "%s/create_ram_region", decoder->dev_path);
+	else if (mode =3D=3D CXL_DECODER_MODE_DC)
+		sprintf(path, "%s/create_dc_region", decoder->dev_path);
=20
 	rc =3D sysfs_read_attr(ctx, path, buf);
 	if (rc < 0) {
@@ -2353,6 +2360,12 @@ static struct cxl_region *cxl_decoder_create_region(=
struct cxl_decoder *decoder,
 	return region;
 }
=20
+CXL_EXPORT struct cxl_region *
+cxl_decoder_create_dc_region(struct cxl_decoder *decoder)
+{
+	return cxl_decoder_create_region(decoder, CXL_DECODER_MODE_DC);
+}
+
 CXL_EXPORT struct cxl_region *
 cxl_decoder_create_pmem_region(struct cxl_decoder *decoder)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index c6545c7..1434da6 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -250,3 +250,8 @@ global:
 	cxl_region_get_daxctl_region;
 	cxl_port_get_parent_dport;
 } LIBCXL_4;
+
+LIBCXL_6 {
+global:
+	cxl_decoder_create_dc_region;
+} LIBCXL_5;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0218d73..1a54eee 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -151,6 +151,7 @@ cxl_decoder_get_max_available_extent(struct cxl_decoder=
 *decoder);
 enum cxl_decoder_mode {
 	CXL_DECODER_MODE_NONE,
 	CXL_DECODER_MODE_MIXED,
+	CXL_DECODER_MODE_DC,
 	CXL_DECODER_MODE_PMEM,
 	CXL_DECODER_MODE_RAM,
 };
@@ -160,6 +161,7 @@ static inline const char *cxl_decoder_mode_name(enum cx=
l_decoder_mode mode)
 	static const char *names[] =3D {
 		[CXL_DECODER_MODE_NONE] =3D "none",
 		[CXL_DECODER_MODE_MIXED] =3D "mixed",
+		[CXL_DECODER_MODE_DC] =3D "dc",
 		[CXL_DECODER_MODE_PMEM] =3D "pmem",
 		[CXL_DECODER_MODE_RAM] =3D "ram",
 	};
@@ -178,6 +180,8 @@ cxl_decoder_mode_from_ident(const char *ident)
 		return CXL_DECODER_MODE_RAM;
 	else if (strcmp(ident, "pmem") =3D=3D 0)
 		return CXL_DECODER_MODE_PMEM;
+	else if (strcmp(ident, "dc") =3D=3D 0)
+		return CXL_DECODER_MODE_DC;
 	return CXL_DECODER_MODE_NONE;
 }
=20
@@ -213,6 +217,7 @@ unsigned int
 cxl_decoder_get_interleave_granularity(struct cxl_decoder *decoder);
 unsigned int cxl_decoder_get_interleave_ways(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_get_region(struct cxl_decoder *decoder);
+struct cxl_region *cxl_decoder_create_dc_region(struct cxl_decoder *decode=
r);
 struct cxl_region *cxl_decoder_create_pmem_region(struct cxl_decoder *deco=
der);
 struct cxl_region *cxl_decoder_create_ram_region(struct cxl_decoder *decod=
er);
 struct cxl_decoder *cxl_decoder_get_by_name(struct cxl_ctx *ctx,
diff --git a/cxl/region.c b/cxl/region.c
index 07ce4a3..497562c 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -75,7 +75,7 @@ OPT_INTEGER('w', "ways", &param.ways, \
 OPT_INTEGER('g', "granularity", &param.granularity,  \
 	    "granularity of the interleave set"), \
 OPT_STRING('t', "type", &param.type, \
-	   "region type", "region type - 'pmem' or 'ram'"), \
+	   "region type", "region type - 'pmem' or 'ram' or 'dc'"), \
 OPT_STRING('U', "uuid", &param.uuid, \
 	   "region uuid", "uuid for the new region (default: autogenerate)"), \
 OPT_BOOLEAN('m', "memdevs", &param.memdevs, \
@@ -434,6 +434,14 @@ static int validate_decoder(struct cxl_decoder *decode=
r,
 			return -EINVAL;
 		}
 		break;
+	case CXL_DECODER_MODE_DC:
+		/* TODO: Do we need to have something like dc_capable?? */
+		if (!cxl_decoder_is_volatile_capable(decoder) &&
+				!cxl_decoder_is_pmem_capable(decoder)) {
+			log_err(&rl, "%s is not dc capable\n", devname);
+			return -EINVAL;
+		}
+		break;
 	default:
 		log_err(&rl, "unknown type: %s\n", param.type);
 		return -EINVAL;
@@ -640,6 +648,13 @@ static int create_region(struct cxl_ctx *ctx, int *cou=
nt,
 				param.root_decoder);
 			return -ENXIO;
 		}
+	} else if (p->mode =3D=3D CXL_DECODER_MODE_DC) {
+		region =3D cxl_decoder_create_dc_region(p->root_decoder);
+		if (!region) {
+			log_err(&rl, "failed to create region under %s\n",
+				param.root_decoder);
+			return -ENXIO;
+		}
 	} else {
 		log_err(&rl, "region type '%s' is not supported\n",
 			param.type);
--=20
2.25.1
