Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E85F50E
	for <linux-cxl@vger.kernel.org>; Sat, 14 Oct 2023 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vLDiQvaz"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196183
	for <linux-cxl@vger.kernel.org>; Sat, 14 Oct 2023 05:00:42 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231014120040epoutp04e84965f9058534b86e6f3c98b6d5d85a~N95HhGdh90485204852epoutp04W
	for <linux-cxl@vger.kernel.org>; Sat, 14 Oct 2023 12:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231014120040epoutp04e84965f9058534b86e6f3c98b6d5d85a~N95HhGdh90485204852epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697284840;
	bh=ZLvGnqyT4qEZxLP/3Mppcvu4djsCnKIk35z7yauwmfE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vLDiQvazOMvnPQDlkDtQGoRlVaQjRzA9rq5/frj+sKEtAWXcNXKMxDQPX33/hyM+T
	 n6GFY/plzGPZKtSmd3bTw21FyDHUZOckGJ0aSazCf+vzjSRZ+u8cx0UuL6gnEZy0t1
	 xlIJ2fKimgbVTE7ozmQnSByVnMUYibV45LXP//38=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231014120039epcas2p2c81ab4053d851ff3dc62df76dc5bb21f~N95G7B-fx0899108991epcas2p2s;
	Sat, 14 Oct 2023 12:00:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4S72533snwz4x9Px; Sat, 14 Oct
	2023 12:00:39 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.DB.09693.7E28A256; Sat, 14 Oct 2023 21:00:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231014120038epcas2p388517f5719bcd6517ff83580aebe9f53~N95FtEoTS0636006360epcas2p3E;
	Sat, 14 Oct 2023 12:00:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231014120038epsmtrp1e76fbbb8a89c2c5318c9a60bc61d3db3~N95FsQ-5B1865618656epsmtrp1c;
	Sat, 14 Oct 2023 12:00:38 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-6a-652a82e71855
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.BF.08788.6E28A256; Sat, 14 Oct 2023 21:00:38 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231014120038epsmtip1a05a304bbc57be91e5149ec28facc10b~N95Fczxvt1994819948epsmtip1T;
	Sat, 14 Oct 2023 12:00:38 +0000 (GMT)
From: Jeongtae Park <jtp.park@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>, Alison Schofield
	<alison.schofield@intel.com>, Ayush Mishra <ayush.m55@samsung.com>, Dan
	Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>, gourry.memverge@gmail.com,
	linux-cxl@vger.kernel.org, Kyungsan Kim <ks0204.kim@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Hojin Nam <hj96.nam@samsung.com>, Junhyeok Im
	<junhyeok.im@samsung.com>, Jehoon Park <jehoon.park@samsung.com>, Youngshin
	Park <yshin0.park@samsung.com>, Jeongtae Park <jeongtae.park@gmail.com>,
	Jeongtae Park <jtp.park@samsung.com>
Subject: hw/cxl: avoid build error with lower(<=9) gcc versions
Date: Sat, 14 Oct 2023 21:03:22 +0900
Message-Id: <20231014120322.4145387-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmqe7zJq1Ug+6/EhbTDyta3H18gc3i
	9mQei+lTLzBarL65htGiafVdVosXf54zWXx484/F4sDrBnaLM2dfslqsWniNzeLI2qtMFouP
	zmC2OLqHw+L8rFMsFhvvv2OzuPLzEaODoMfOWXfZPVqOvGX1WLznJZNH35ZVjB5TZ9d7fN4k
	F8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S5
	kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSo
	MCE74/+tc6wFmzkrJl36wtTAOJ+9i5GTQ0LARKLzzj+mLkYuDiGBHYwSzx63QTmfGCW2/b7M
	COF8Y5R4+KibDaZl2uUjrCC2kMBeRonda80giv4wSpy/N4MRJMEmoCUxfWYDWJGIgJHEq54D
	YJOYBZ6zSNxcvxBskrCAvcS3V4+YQWwWAVWJp887wI7iFbCW+LpsMzPENnmJ/QfPMkPEBSVO
	znzCAmIzA8Wbt85mBhkqITCVQ+LJlz1MEA0uEnN/bGGEsIUlXh3fAvWplMTL/jZ2iIZmRonX
	z6+wQDgtjBLrbu+AqjKWeHfzOdDdHEArNCXW79IHMSUElCWO3IJazCfRcfgvO0SYV6KjTQii
	UUli3tJ5UDdLSFyauwXK9pBYdHkXMyS0YiWmvTzMNIFRfhaSd2YheWcWwt4FjMyrGMVSC4pz
	01OLjQoM4dGanJ+7iRGcfLVcdzBOfvtB7xAjEwfjIUYJDmYlEd7ZcRqpQrwpiZVVqUX58UWl
	OanFhxhNgQE8kVlKNDkfmP7zSuINTSwNTMzMDM2NTA3MlcR577XOTRESSE8sSc1OTS1ILYLp
	Y+LglGpgku3N+OS6hllAiKX+j51qfHVwagvn3F5/jVNxezVPPdV8I5JwV3zm+g8zH29r3Rfu
	UrfDx+2iv4t59/6V01dt2Xfut/+smm7v11nsTZzSs58n8rpsyKxxmrYveNq9N4EPv9gH3rnm
	8f+BgvXNbbLv7LyMXeN2HNrLvDnLJGL3Ha+47IofDL+fTZGKupB8IWyj2vEMPnZBTYlHbXti
	F9nqJMx31ORt6dgzUza8RqZYVymB3f3LUzMBFovm++mzP/F4LNq4/cHKh7q25r/vq3knHHfK
	kZ4VdOLYHospBx6sOXO7e8O9qKCWzMib7+RY+M5Ffjh2NJHpm3dpDuurnkkr8j5tnxJ6e0eL
	bty5Sc/FlViKMxINtZiLihMBrlCmjEcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO6zJq1Ug6YNMhbTDyta3H18gc3i
	9mQei+lTLzBarL65htGiafVdVosXf54zWXx484/F4sDrBnaLM2dfslqsWniNzeLI2qtMFouP
	zmC2OLqHw+L8rFMsFhvvv2OzuPLzEaODoMfOWXfZPVqOvGX1WLznJZNH35ZVjB5TZ9d7fN4k
	F8AWxWWTkpqTWZZapG+XwJXx/9Y51oLNnBWTLn1hamCcz97FyMkhIWAiMe3yEdYuRi4OIYHd
	jBL7tv2HSkhILN/wggnCFpa43wJT9ItRouNJKxtIgk1AS2L6zAZWEFtEwEjiVc8BRpAiZoGv
	LBK99z+DdQsL2Et8e/WIGcRmEVCVePq8A2wDr4C1xNdlm5khNshL7D94lhkiLihxcuYTFhCb
	GSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOBy2t
	HYx7Vn3QO8TIxMF4iFGCg1lJhHd2nEaqEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATS
	E0tSs1NTC1KLYLJMHJxSDUz9O259SU7VLL6jvPdcT5dM60/Dgolit59GnG9t3Kw1IdBgBRMX
	u3j6XYVbLws2zk/9b/ro8jTxg9asmiUlJlzFy5Z1Tcyp6nvn8Wr+yrN8js5Zq470bzZxqNm+
	aoIU77efiYKqIftz9y6Rl3QOLlsjuX7mLsvbV/QF76yx5OYyehLQktHCHD9T4AuLNkthcoRN
	qFO3m2OtUcMVx65Pzt8/lT/SvuAaeuB77mYtY45LZ4RWn1CR8Y4/f5oxU2Il58b5lvYPrNKa
	uQIls5Wn6Gz7b7knMfHLi2jJn1pyU/55bqqQ+y/46lKw3tnTXG88PpeyVVbKdU/usGbXu3fe
	49oOL5nVJ9bzLZK63cCUp8RSnJFoqMVcVJwIAHBK0ln2AgAA
X-CMS-MailID: 20231014120038epcas2p388517f5719bcd6517ff83580aebe9f53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231014120038epcas2p388517f5719bcd6517ff83580aebe9f53
References: <CGME20231014120038epcas2p388517f5719bcd6517ff83580aebe9f53@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are testing on the below branch[1] and getting the following build
error when using gcc-9 or gcc-7 (gcc-11 is ok).

I was reported in private to Jonathan Cameron, and he will get rid of
it soon.

This is just for your information and for keeping on list.

Thanks
/jtpark

[1]: https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13/

Reported-by: Kyungsan Kim <ks0204.kim@samsung.com>
Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 hw/cxl/cxl-component-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index c022a90774..fd15d9a61e 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -325,9 +325,11 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_ROOT_PORT:
     case CXL2_UPSTREAM_PORT:
     case CXL2_DOWNSTREAM_PORT:
-        init_cap_reg(RAS, 2, 2);
-        ras_init_common(reg_state, write_msk);
-        break;
+        {
+            init_cap_reg(RAS, 2, 2);
+            ras_init_common(reg_state, write_msk);
+            break;
+        }
     default:
         break;
     }
-- 
2.34.1

