Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B15C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 23:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiKGXjJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKGXjI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 18:39:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEA1706F
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 15:39:07 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKodN009972
        for <linux-cxl@vger.kernel.org>; Mon, 7 Nov 2022 15:39:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=WFPAHpIAQXSUJRDQK5czfxoeXeV9wszKrlcJnyiKnSk=;
 b=KGnNesLzlMtZabR7eWVa5ZxMWURZJrBQdZmDH/4gobTRrjnIEz/Zvdg5T7TXpgjFkDwo
 h9KDBYXlZBsH5LW3xS/timIo1Cq+mIa+5ouGD7bUz4eZhnQ9H1hn97Ogp4JcDFnOFKiX
 TM+TNiShCseFMAnA0eLXS1sKqazyr48oIdTg032ycj0g4rhq2fFoPabKtlQfsJxTgAT/
 AkrJ1TCof+h68OYGSjPpcj6Wuj+h/oTtxSGsx3Al+5x+ClZZ/Sw01RsdszJ8O2dQnjF1
 P+L/tXfBqRGRDO9BMRIhckqCbeLEAw4gwfHf7hipxxUHdZDcwoN2xHaBvAUdlKC7XLS0 MA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knq54uh26-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 07 Nov 2022 15:39:06 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:39:06 -0800
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id A75B4300EACF; Mon,  7 Nov 2022 15:38:53 -0800 (PST)
From:   Jonathan Zhang <jonzhang@meta.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>, <alison.schofield@intel.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH V4 0/2] add support for CCI Get Alert Configuration
Date:   Mon, 7 Nov 2022 15:38:40 -0800
Message-ID: <20221107233842.3553784-1-jonzhang@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xjU7qL9dW-r4S84B1VKn5ojkeeZ7j2hV
X-Proofpoint-GUID: xjU7qL9dW-r4S84B1VKn5ojkeeZ7j2hV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec 3.0 section 8.2.9.8.3.2 defines CCI command
Get Alert Configuration.

This patchset adds support for it.
 =20
v4:
- Fix the typo of LIEF instead of LIFE (Alison).

v3:
- Update man page and JSON output to use "alert-config" (Alison).

v2:
- Change the command parameter from "alert" to "alert-config" (Vishal).
- Update the format based on clang-formt (Vishal).
- Updated the names to be consistent with the existing code (Vishal). Suc=
h as:
-- pers_mem --> pmem
-- temp --> temperature
-- drop "get_" from some function names.

Jonathan Zhang (2):
  libcxl: add accessors for Get Alert Configuration CCI output
  cxl: display alert configuration fields in list command

 Documentation/cxl/cxl-list.txt   |  33 ++++++
 Documentation/cxl/lib/libcxl.txt |   1 +
 cxl/filter.c                     |   2 +
 cxl/filter.h                     |   1 +
 cxl/json.c                       | 185 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c                 | 163 +++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  23 ++++
 cxl/lib/private.h                |  38 +++++++
 cxl/libcxl.h                     |  35 ++++++
 cxl/list.c                       |   6 +-
 util/json.h                      |   1 +
 11 files changed, 486 insertions(+), 2 deletions(-)

--=20
2.30.2

