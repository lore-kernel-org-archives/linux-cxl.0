Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E0156EE
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gJh0qOPa"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3AE97
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231010082323epoutp03d0610b9dfd93ed3f88bd37ad53468d48~MsWQYWj131875318753epoutp03T
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 08:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231010082323epoutp03d0610b9dfd93ed3f88bd37ad53468d48~MsWQYWj131875318753epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696926203;
	bh=vx+Vv/vD1L1rAVoTywgW+xt0ph0BQwD5a25Sizeuquw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJh0qOPaocS6v8vcTBZf+R8uVZHqqXMtCAoT/CVPGxThQeYfsQSoEhionHpxw7IXW
	 3TlGp2URSYhKpDiTWUTsjyCZdXUKe5ceqkLldT+kOAp84koe2NR/B9hV0aVlLhrKnu
	 Kbpf8iloNPAufWZ5asTWREqe2qAqPcq6I5BAH6tc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231010082322epcas2p42362da8b770a1472c994d6165e88f615~MsWPyxm7f1476914769epcas2p4j;
	Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4S4TS96Mt8z4x9Q6; Tue, 10 Oct
	2023 08:23:21 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.6E.19471.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231010082321epcas2p369390101e543193908ad3578dcbac6a8~MsWOyMtzZ2472824728epcas2p3T;
	Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231010082321epsmtrp15cdb16b485c5ee6a38f44e3c0dc96880~MsWOxZrQz1187111871epsmtrp1e;
	Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a4d-3d2bfa8000004c0f-75-652509f9a478
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.F1.18916.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231010082321epsmtip262ba105964d28ee0a826c4c53204d881~MsWOidL1g0745807458epsmtip2L;
	Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
From: Jeongtae Park <jtp.park@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ben
	Widawsky <bwidawsk@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
	Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kyungsan Kim <ks0204.kim@samsung.com>, Wonjae
	Lee <wj28.lee@samsung.com>, Hojin Nam <hj96.nam@samsung.com>, Junhyeok Im
	<junhyeok.im@samsung.com>, Jehoon Park <jehoon.park@samsung.com>, Jeongtae
	Park <jeongtae.park@gmail.com>, Jeongtae Park <jtp.park@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/6] cxl/mem: Fix a checkpatch error
Date: Tue, 10 Oct 2023 17:26:05 +0900
Message-Id: <20231010082608.859137-4-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmue5PTtVUg1lHjSzuPr7AZtE8eTGj
	xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
	i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
	2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
	rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
	ODG3uDQvXS8vtcTK0MDAyBSoMCE749a1KywFbWwVr49eYWxgnMzaxcjJISFgIvF7VSNjFyMX
	h5DAHkaJ1Y/eMEM4nxglbp9/zwjnzD7/jxGmZUvXdFaIxE5Gib+nZrBAOH8YJS6+XwZWxSag
	JTF9ZgNYlYjAQyaJna/6mEAcZoEpzBKds7aCrRcWMJeYPWM6mM0ioCqx6eVZZhCbV8BKovfU
	BqgT5SX2H4SIcwpYSzyc/5YNokZQ4uTMJywgNjNQTfPW2WCXSwgc4ZD4/6aXGaLZReLil6dQ
	hwtLvDq+hR3ClpJ42d/GDtHQzCjx+vkVFginhVFi3e0dUFXGEu9uPgc6gwNohabE+l36IKaE
	gLLEkVtQi/kkOg7/ZYcI80p0tAlBNCpJzFs6D+oECYlLc7dA2R4SvyZ/gQZXH6PE/p7/bBMY
	FWYh+WcWkn9mISxewMi8ilEqtaA4Nz012ajAUDcvtRwe08n5uZsYwUlcy3cH4+v1f/UOMTJx
	MB5ilOBgVhLhfZSpkirEm5JYWZValB9fVJqTWnyI0RQY4hOZpUST84F5JK8k3tDE0sDEzMzQ
	3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBibrpbdeTKmYEP3kP+eRT0smvveaF36Q
	r/PPXm42LuXpJa82rpz+OKjuyHkN3kczux92n72ZuGUJo/XHaU+Tgz6UR9W+uSl/YdNK48KG
	AIa/dirPBep4J8yTeR13vce2SGOV0smEb3+l9cuTeHMONjXt8zFyS1jhcHX25Nhb52ZffNIi
	qJrREZvxd+KF6hnT5xzx5JX5rLh8lmRVU17F6/fR5dc3RvtzdNXEHzJVDZuhzy140nrK1eIO
	d8PrF3esCTwdx+6wIkD+aB1LicGEgpSgld6P/h5JPdPD1aXhW19WvMs8a66mdoWS8cWdKuH9
	6XtUr9lOviZitznQVD5SJOLEUZa3PavbGoqmLHfeuluJpTgj0VCLuag4EQCPkldDawQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXvcnp2qqwZflghZ3H19gs2ievJjR
	YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
	xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
	7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mq4de0KS0EbW8Xro1cYGxgns3Yx
	cnJICJhIbOmaDmRzcQgJbGeUOPTzNlRCQmL5hhdMELawxP2WI1BFvxglZvQ+ZwNJsAloSUyf
	2QCWEBF4ziRx8s0pRhCHWWAOs8ThzpfsIFXCAuYSs2dMBxvLIqAqsenlWWYQm1fASqL31Aao
	dfIS+w9CxDkFrCUezn8LtkEIqGbbwXY2iHpBiZMzn7CA2MxA9c1bZzNPYBSYhSQ1C0lqASPT
	KkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzg2NIK2sG4bP1fvUOMTByMhxglOJiVRHgfZaqk
	CvGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTAtPr6pv0f/
	1q1Y27t9/7v+q814liA+hyNsV9yGp1bXne7zeM75Hiqo15qx4HjMUvOzL7zlVhy7YcdanSDN
	UWfpaG9ttE73YMNsf7GiSWbrNS+plE5KPyxyZ4+lvNPD1v/Pp2st32Wss73P87FGm2aKdoWJ
	d8jWqyccHMNMjghP35xUpXKh3KI0Udqi3HOvganK1ovs6bfjvnQtkd/L8bP2+gaPo7suH+qP
	fTunfM9C4ckem8ytP725xVZcWn8pxXixQtLUxWlWbf2np7vu2XT2paiAbuHpuU19SxcW387l
	UVltY/x6y7JHn13Uz7+65By62H7asf0zWI8Ha85JTjvgP9X7hyOPwo+AwoKpzk+UWIozEg21
	mIuKEwGraWZrHAMAAA==
X-CMS-MailID: 20231010082321epcas2p369390101e543193908ad3578dcbac6a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p369390101e543193908ad3578dcbac6a8
References: <20231010082608.859137-1-jtp.park@samsung.com>
	<CGME20231010082321epcas2p369390101e543193908ad3578dcbac6a8@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ERROR: spaces required around that '=' (ctx:WxV)

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..1ac3eb2be84f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -183,7 +183,7 @@ struct cxl_mbox_cmd_rc {
 };
 
 static const
-struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
+struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = { CMD_CMD_RC_TABLE };
 #undef C
 
 static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
-- 
2.34.1

